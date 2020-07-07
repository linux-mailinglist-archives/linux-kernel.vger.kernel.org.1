Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DC5216DF4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 15:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgGGNmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 09:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgGGNmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 09:42:11 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 097A120658;
        Tue,  7 Jul 2020 13:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594129324;
        bh=2m6GEwDQBcjVY0VOcddjTxilVjLHtLerth0czHg7BTw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VOmm52wZr7jvynXbjixWvqxcQjScp1YKxr/i+yUdxIAXWBS6VJt/crcRPW9UddPYv
         nCjGU6n/sbilor4VobIPDgb8sB7uZ3gFtbIehbir5mbVPD1lM6BcEtnJ9YTHt2yJwO
         tJ95ENTTJ8FLojPoSsN9zvoAarJsXbcXYjDWiH7M=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E34A6352310C; Tue,  7 Jul 2020 06:42:03 -0700 (PDT)
Date:   Tue, 7 Jul 2020 06:42:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [LKP] Re: [refperf] 8e4ec3d02b: error:#[##]
Message-ID: <20200707134203.GU9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200705080005.GV3874@shao2-debian>
 <20200706225011.GO9247@paulmck-ThinkPad-P72>
 <849a4d92-5f56-44ff-7300-ed780a2aa9a4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <849a4d92-5f56-44ff-7300-ed780a2aa9a4@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 05:23:48PM +0800, Rong Chen wrote:
> 
> 
> On 7/7/20 6:50 AM, Paul E. McKenney wrote:
> > On Sun, Jul 05, 2020 at 04:00:05PM +0800, kernel test robot wrote:
> > > Greeting,
> > > 
> > > FYI, we noticed the following commit (built with gcc-9):
> > > 
> > > commit: 8e4ec3d02b549a731c94b4bcddff212bb92cdbaf ("refperf: Rename RCU_REF_PERF_TEST to RCU_REF_SCALE_TEST")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > 
> > > in testcase: trinity
> > > with following parameters:
> > > 
> > > 	runtime: 300s
> > > 
> > > test-description: Trinity is a linux system call fuzz tester.
> > > test-url: http://codemonkey.org.uk/projects/trinity/
> > You lost me on this one.  All that this commit does is to change the
> > name of a Kconfig option. I don't see how it changes execution.
> > 
> > What am I missing here?
> 
> Hi Paul,
> 
> It's the bot problem, CONFIG_RCU_REF_SCALE_TEST is set to 'y' in kconfig
> file,
> but CONFIG_RCU_REF_SCALE_TEST doesn't exist in parent commit c7dcf8106f75,
> bot used 'make olddefconfig' to update the kconfig to build the parent
> commit
> which causes CONFIG_RCU_REF_PERF_TEST not set too.
> 
> We will check more carefully to avoid false positive.

Got it, thank you, and no worries!

							Thanx, Paul

> Best Regards,
> Rong Chen
> 
> > 
> > 							Thanx, Paul
> > 
> > > on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > 
> > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > 
> > > 
> > > +---------------------------------------------------------+------------+------------+
> > > |                                                         | c7dcf8106f | 8e4ec3d02b |
> > > +---------------------------------------------------------+------------+------------+
> > > | boot_successes                                          | 14         | 0          |
> > > | boot_failures                                           | 23         | 38         |
> > > | invoked_oom-killer:gfp_mask=0x                          | 5          | 4          |
> > > | Mem-Info                                                | 5          | 4          |
> > > | Out_of_memory_and_no_killable_processes                 | 4          | 4          |
> > > | Kernel_panic-not_syncing:System_is_deadlocked_on_memory | 4          | 4          |
> > > | WARNING:at_kernel/trace/trace.c:#trace_find_next_entry  | 18         |            |
> > > | EIP:trace_find_next_entry                               | 18         |            |
> > > | error:#[##]                                             | 0          | 34         |
> > > | EIP:main_func                                           | 0          | 34         |
> > > | Kernel_panic-not_syncing:Fatal_exception                | 0          | 34         |
> > > +---------------------------------------------------------+------------+------------+
> > > 
> > > 
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > 
> > > [   14.325320]
> > > [   14.337793] [main] Added 18 filenames from /dev
> > > [   14.337808]
> > > [   15.232694] rcu-ref-perf: Experiment #0 (Format: <THREAD-NUM>:<Total loop time in ns>)
> > > [   15.232694]
> > > [   15.238007] divide_error: 0000 [#1] PTI
> > > [   15.239505] CPU: 0 PID: 86 Comm: main_func Tainted: G S                5.8.0-rc3-00028-g8e4ec3d02b549 #1
> > > [   15.242735] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > > [   15.249804] EIP: main_func+0x2af/0x393
> > > [   15.251276] Code: af f0 e8 86 f8 ff ff bf e8 03 00 00 69 ca e8 03 00 00 f7 e7 89 55 8c 89 45 88 8b 45 8c 31 ff 8d 14 01 39 d6 77 08 89 d0 31 d2 <f7> f6 89 c7 8b 4d 94 8b 45 88 f7 f6 89 7c d9 04 89 04 d9 43 e9 09
> > > [   15.256851] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
> > > [   15.258817] ESI: 00000000 EDI: 00000000 EBP: dc6cdf80 ESP: dc6cdf08
> > > [   15.260738] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010246
> > > [   15.262810] CR0: 80050033 CR2: 08bb0000 CR3: 33bbe000 CR4: 000406f0
> > > [   15.264757] Call Trace:
> > > [   15.265997]  ? __kthread_parkme+0x3a/0x71
> > > [   15.267516]  ? _raw_spin_unlock_irqrestore+0x34/0x40
> > > [   15.269216]  ? tracer_hardirqs_on+0x11/0x25
> > > [   15.270767]  ? trace_hardirqs_on+0x34/0x41
> > > [   15.272295]  kthread+0xee/0xf3
> > > [   15.273636]  ? srcu_ref_perf_read_section+0x69/0x69
> > > [   15.275325]  ? kthread_create_worker_on_cpu+0x1c/0x1c
> > > [   15.277009]  ret_from_fork+0x19/0x30
> > > [   15.278462] Modules linked in: psmouse parport_pc ide_pci_generic qemu_fw_cfg ide_core processor
> > > [   15.281552] ---[ end trace 891088ef0ed36b53 ]---
> > > [   15.283184] EIP: main_func+0x2af/0x393
> > > [   15.284632] Code: af f0 e8 86 f8 ff ff bf e8 03 00 00 69 ca e8 03 00 00 f7 e7 89 55 8c 89 45 88 8b 45 8c 31 ff 8d 14 01 39 d6 77 08 89 d0 31 d2 <f7> f6 89 c7 8b 4d 94 8b 45 88 f7 f6 89 7c d9 04 89 04 d9 43 e9 09
> > > [   15.290313] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
> > > [   15.292272] ESI: 00000000 EDI: 00000000 EBP: dc6cdf80 ESP: dc6cdf08
> > > [   15.294261] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010246
> > > [   15.296304] CR0: 80050033 CR2: 08bb0000 CR3: 33bbe000 CR4: 000406f0
> > > [   15.298264] Kernel panic - not syncing: Fatal exception
> > > [   15.300001] Kernel Offset: disabled
> > > 
> > > Elapsed time: 60
> > > 
> > > qemu-img create -f qcow2 disk-vm-snb-i386-61-0 256G
> > > 
> > > 
> > > To reproduce:
> > > 
> > >          # build kernel
> > > 	cd linux
> > > 	cp config-5.8.0-rc3-00028-g8e4ec3d02b549 .config
> > > 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> > > 
> > >          git clone https://github.com/intel/lkp-tests.git
> > >          cd lkp-tests
> > >          bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> > > 
> > > 
> > > 
> > > Thanks,
> > > lkp
> > > 
> > > #
> > > # Automatically generated file; DO NOT EDIT.
> > > # Linux/i386 5.8.0-rc3 Kernel Configuration
> > > #
> > > CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-14) 9.3.0"
> > > CONFIG_CC_IS_GCC=y
> > > CONFIG_GCC_VERSION=90300
> > > CONFIG_LD_VERSION=234000000
> > > CONFIG_CLANG_VERSION=0
> > > CONFIG_CC_HAS_ASM_GOTO=y
> > > CONFIG_CC_HAS_ASM_INLINE=y
> > > CONFIG_CONSTRUCTORS=y
> > > CONFIG_IRQ_WORK=y
> > > CONFIG_BUILDTIME_TABLE_SORT=y
> > > CONFIG_THREAD_INFO_IN_TASK=y
> > > 
> > > #
> > > # General setup
> > > #
> > > CONFIG_BROKEN_ON_SMP=y
> > > CONFIG_INIT_ENV_ARG_LIMIT=32
> > > # CONFIG_COMPILE_TEST is not set
> > > CONFIG_LOCALVERSION=""
> > > CONFIG_LOCALVERSION_AUTO=y
> > > CONFIG_BUILD_SALT=""
> > > CONFIG_HAVE_KERNEL_GZIP=y
> > > CONFIG_HAVE_KERNEL_BZIP2=y
> > > CONFIG_HAVE_KERNEL_LZMA=y
> > > CONFIG_HAVE_KERNEL_XZ=y
> > > CONFIG_HAVE_KERNEL_LZO=y
> > > CONFIG_HAVE_KERNEL_LZ4=y
> > > # CONFIG_KERNEL_GZIP is not set
> > > # CONFIG_KERNEL_BZIP2 is not set
> > > # CONFIG_KERNEL_LZMA is not set
> > > # CONFIG_KERNEL_XZ is not set
> > > # CONFIG_KERNEL_LZO is not set
> > > CONFIG_KERNEL_LZ4=y
> > > CONFIG_DEFAULT_INIT=""
> > > CONFIG_DEFAULT_HOSTNAME="(none)"
> > > # CONFIG_SWAP is not set
> > > CONFIG_SYSVIPC=y
> > > CONFIG_SYSVIPC_SYSCTL=y
> > > # CONFIG_POSIX_MQUEUE is not set
> > > CONFIG_WATCH_QUEUE=y
> > > # CONFIG_CROSS_MEMORY_ATTACH is not set
> > > CONFIG_USELIB=y
> > > # CONFIG_AUDIT is not set
> > > CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> > > 
> > > #
> > > # IRQ subsystem
> > > #
> > > CONFIG_GENERIC_IRQ_PROBE=y
> > > CONFIG_GENERIC_IRQ_SHOW=y
> > > CONFIG_HARDIRQS_SW_RESEND=y
> > > CONFIG_GENERIC_IRQ_CHIP=y
> > > CONFIG_IRQ_DOMAIN=y
> > > CONFIG_IRQ_DOMAIN_HIERARCHY=y
> > > CONFIG_GENERIC_MSI_IRQ=y
> > > CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
> > > CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> > > CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> > > CONFIG_IRQ_FORCED_THREADING=y
> > > CONFIG_SPARSE_IRQ=y
> > > # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> > > # end of IRQ subsystem
> > > 
> > > CONFIG_CLOCKSOURCE_WATCHDOG=y
> > > CONFIG_ARCH_CLOCKSOURCE_INIT=y
> > > CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> > > CONFIG_GENERIC_TIME_VSYSCALL=y
> > > CONFIG_GENERIC_CLOCKEVENTS=y
> > > CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> > > CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> > > CONFIG_GENERIC_CMOS_UPDATE=y
> > > 
> > > #
> > > # Timers subsystem
> > > #
> > > CONFIG_TICK_ONESHOT=y
> > > CONFIG_NO_HZ_COMMON=y
> > > # CONFIG_HZ_PERIODIC is not set
> > > CONFIG_NO_HZ_IDLE=y
> > > CONFIG_NO_HZ=y
> > > CONFIG_HIGH_RES_TIMERS=y
> > > # end of Timers subsystem
> > > 
> > > # CONFIG_PREEMPT_NONE is not set
> > > CONFIG_PREEMPT_VOLUNTARY=y
> > > # CONFIG_PREEMPT is not set
> > > CONFIG_PREEMPT_COUNT=y
> > > 
> > > #
> > > # CPU/Task time and stats accounting
> > > #
> > > CONFIG_TICK_CPU_ACCOUNTING=y
> > > CONFIG_IRQ_TIME_ACCOUNTING=y
> > > # CONFIG_BSD_PROCESS_ACCT is not set
> > > # CONFIG_TASKSTATS is not set
> > > # CONFIG_PSI is not set
> > > # end of CPU/Task time and stats accounting
> > > 
> > > #
> > > # RCU Subsystem
> > > #
> > > CONFIG_TINY_RCU=y
> > > CONFIG_RCU_EXPERT=y
> > > CONFIG_SRCU=y
> > > CONFIG_TINY_SRCU=y
> > > CONFIG_TASKS_RCU_GENERIC=y
> > > CONFIG_TASKS_RCU=y
> > > CONFIG_TASKS_RUDE_RCU=y
> > > CONFIG_TASKS_TRACE_RCU=y
> > > # CONFIG_TASKS_TRACE_RCU_READ_MB is not set
> > > # end of RCU Subsystem
> > > 
> > > CONFIG_IKCONFIG=y
> > > CONFIG_IKCONFIG_PROC=y
> > > CONFIG_IKHEADERS=y
> > > CONFIG_LOG_BUF_SHIFT=20
> > > CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> > > CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> > > 
> > > #
> > > # Scheduler features
> > > #
> > > # end of Scheduler features
> > > 
> > > CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> > > CONFIG_CGROUPS=y
> > > CONFIG_PAGE_COUNTER=y
> > > CONFIG_MEMCG=y
> > > CONFIG_MEMCG_KMEM=y
> > > # CONFIG_BLK_CGROUP is not set
> > > CONFIG_CGROUP_SCHED=y
> > > # CONFIG_FAIR_GROUP_SCHED is not set
> > > CONFIG_RT_GROUP_SCHED=y
> > > CONFIG_CGROUP_PIDS=y
> > > CONFIG_CGROUP_RDMA=y
> > > # CONFIG_CGROUP_FREEZER is not set
> > > # CONFIG_CGROUP_HUGETLB is not set
> > > CONFIG_CGROUP_DEVICE=y
> > > # CONFIG_CGROUP_CPUACCT is not set
> > > CONFIG_CGROUP_PERF=y
> > > CONFIG_CGROUP_DEBUG=y
> > > CONFIG_NAMESPACES=y
> > > CONFIG_UTS_NS=y
> > > CONFIG_TIME_NS=y
> > > CONFIG_IPC_NS=y
> > > # CONFIG_USER_NS is not set
> > > CONFIG_PID_NS=y
> > > CONFIG_NET_NS=y
> > > CONFIG_CHECKPOINT_RESTORE=y
> > > # CONFIG_SCHED_AUTOGROUP is not set
> > > # CONFIG_SYSFS_DEPRECATED is not set
> > > CONFIG_RELAY=y
> > > CONFIG_BLK_DEV_INITRD=y
> > > CONFIG_INITRAMFS_SOURCE=""
> > > CONFIG_RD_GZIP=y
> > > CONFIG_RD_BZIP2=y
> > > CONFIG_RD_LZMA=y
> > > CONFIG_RD_XZ=y
> > > CONFIG_RD_LZO=y
> > > # CONFIG_RD_LZ4 is not set
> > > CONFIG_BOOT_CONFIG=y
> > > # CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
> > > CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> > > CONFIG_SYSCTL=y
> > > CONFIG_HAVE_UID16=y
> > > CONFIG_SYSCTL_EXCEPTION_TRACE=y
> > > CONFIG_HAVE_PCSPKR_PLATFORM=y
> > > CONFIG_BPF=y
> > > # CONFIG_EXPERT is not set
> > > CONFIG_UID16=y
> > > CONFIG_MULTIUSER=y
> > > CONFIG_SGETMASK_SYSCALL=y
> > > CONFIG_SYSFS_SYSCALL=y
> > > CONFIG_FHANDLE=y
> > > CONFIG_POSIX_TIMERS=y
> > > CONFIG_PRINTK=y
> > > CONFIG_PRINTK_NMI=y
> > > CONFIG_BUG=y
> > > CONFIG_ELF_CORE=y
> > > CONFIG_PCSPKR_PLATFORM=y
> > > CONFIG_BASE_FULL=y
> > > CONFIG_FUTEX=y
> > > CONFIG_FUTEX_PI=y
> > > CONFIG_EPOLL=y
> > > CONFIG_SIGNALFD=y
> > > CONFIG_TIMERFD=y
> > > CONFIG_EVENTFD=y
> > > CONFIG_SHMEM=y
> > > CONFIG_AIO=y
> > > CONFIG_IO_URING=y
> > > CONFIG_ADVISE_SYSCALLS=y
> > > CONFIG_MEMBARRIER=y
> > > CONFIG_KALLSYMS=y
> > > CONFIG_KALLSYMS_ALL=y
> > > CONFIG_KALLSYMS_BASE_RELATIVE=y
> > > # CONFIG_BPF_SYSCALL is not set
> > > CONFIG_USERFAULTFD=y
> > > CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> > > CONFIG_RSEQ=y
> > > # CONFIG_EMBEDDED is not set
> > > CONFIG_HAVE_PERF_EVENTS=y
> > > 
> > > #
> > > # Kernel Performance Events And Counters
> > > #
> > > CONFIG_PERF_EVENTS=y
> > > # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> > > # end of Kernel Performance Events And Counters
> > > 
> > > CONFIG_VM_EVENT_COUNTERS=y
> > > CONFIG_COMPAT_BRK=y
> > > CONFIG_SLAB=y
> > > # CONFIG_SLUB is not set
> > > CONFIG_SLAB_MERGE_DEFAULT=y
> > > CONFIG_SLAB_FREELIST_RANDOM=y
> > > # CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
> > > CONFIG_SYSTEM_DATA_VERIFICATION=y
> > > CONFIG_PROFILING=y
> > > CONFIG_TRACEPOINTS=y
> > > # end of General setup
> > > 
> > > CONFIG_X86_32=y
> > > CONFIG_FORCE_DYNAMIC_FTRACE=y
> > > CONFIG_X86=y
> > > CONFIG_INSTRUCTION_DECODER=y
> > > CONFIG_OUTPUT_FORMAT="elf32-i386"
> > > CONFIG_LOCKDEP_SUPPORT=y
> > > CONFIG_STACKTRACE_SUPPORT=y
> > > CONFIG_MMU=y
> > > CONFIG_ARCH_MMAP_RND_BITS_MIN=8
> > > CONFIG_ARCH_MMAP_RND_BITS_MAX=16
> > > CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> > > CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> > > CONFIG_GENERIC_ISA_DMA=y
> > > CONFIG_GENERIC_BUG=y
> > > CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> > > CONFIG_GENERIC_CALIBRATE_DELAY=y
> > > CONFIG_ARCH_HAS_CPU_RELAX=y
> > > CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> > > CONFIG_ARCH_HAS_FILTER_PGPROT=y
> > > CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> > > CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> > > CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> > > CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> > > CONFIG_ARCH_SUSPEND_POSSIBLE=y
> > > CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> > > CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> > > CONFIG_HAVE_INTEL_TXT=y
> > > CONFIG_ARCH_SUPPORTS_UPROBES=y
> > > CONFIG_FIX_EARLYCON_MEM=y
> > > CONFIG_PGTABLE_LEVELS=3
> > > CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> > > 
> > > #
> > > # Processor type and features
> > > #
> > > CONFIG_ZONE_DMA=y
> > > # CONFIG_SMP is not set
> > > CONFIG_X86_FEATURE_NAMES=y
> > > CONFIG_X86_MPPARSE=y
> > > # CONFIG_GOLDFISH is not set
> > > # CONFIG_RETPOLINE is not set
> > > # CONFIG_X86_CPU_RESCTRL is not set
> > > # CONFIG_X86_EXTENDED_PLATFORM is not set
> > > # CONFIG_X86_INTEL_LPSS is not set
> > > # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> > > CONFIG_IOSF_MBI=y
> > > CONFIG_IOSF_MBI_DEBUG=y
> > > CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
> > > # CONFIG_X86_32_IRIS is not set
> > > # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> > > CONFIG_HYPERVISOR_GUEST=y
> > > CONFIG_PARAVIRT=y
> > > # CONFIG_PARAVIRT_DEBUG is not set
> > > # CONFIG_XEN is not set
> > > CONFIG_KVM_GUEST=y
> > > CONFIG_ARCH_CPUIDLE_HALTPOLL=y
> > > # CONFIG_PVH is not set
> > > # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> > > CONFIG_PARAVIRT_CLOCK=y
> > > # CONFIG_M486SX is not set
> > > # CONFIG_M486 is not set
> > > # CONFIG_M586 is not set
> > > CONFIG_M586TSC=y
> > > # CONFIG_M586MMX is not set
> > > # CONFIG_M686 is not set
> > > # CONFIG_MPENTIUMII is not set
> > > # CONFIG_MPENTIUMIII is not set
> > > # CONFIG_MPENTIUMM is not set
> > > # CONFIG_MPENTIUM4 is not set
> > > # CONFIG_MK6 is not set
> > > # CONFIG_MK7 is not set
> > > # CONFIG_MK8 is not set
> > > # CONFIG_MCRUSOE is not set
> > > # CONFIG_MEFFICEON is not set
> > > # CONFIG_MWINCHIPC6 is not set
> > > # CONFIG_MWINCHIP3D is not set
> > > # CONFIG_MELAN is not set
> > > # CONFIG_MGEODEGX1 is not set
> > > # CONFIG_MGEODE_LX is not set
> > > # CONFIG_MCYRIXIII is not set
> > > # CONFIG_MVIAC3_2 is not set
> > > # CONFIG_MVIAC7 is not set
> > > # CONFIG_MCORE2 is not set
> > > # CONFIG_MATOM is not set
> > > # CONFIG_X86_GENERIC is not set
> > > CONFIG_X86_INTERNODE_CACHE_SHIFT=5
> > > CONFIG_X86_L1_CACHE_SHIFT=5
> > > CONFIG_X86_F00F_BUG=y
> > > CONFIG_X86_ALIGNMENT_16=y
> > > CONFIG_X86_TSC=y
> > > CONFIG_X86_CMPXCHG64=y
> > > CONFIG_X86_MINIMUM_CPU_FAMILY=5
> > > CONFIG_IA32_FEAT_CTL=y
> > > CONFIG_X86_VMX_FEATURE_NAMES=y
> > > CONFIG_CPU_SUP_INTEL=y
> > > CONFIG_CPU_SUP_CYRIX_32=y
> > > CONFIG_CPU_SUP_AMD=y
> > > CONFIG_CPU_SUP_HYGON=y
> > > CONFIG_CPU_SUP_CENTAUR=y
> > > CONFIG_CPU_SUP_TRANSMETA_32=y
> > > CONFIG_CPU_SUP_ZHAOXIN=y
> > > CONFIG_HPET_TIMER=y
> > > CONFIG_DMI=y
> > > CONFIG_NR_CPUS_RANGE_BEGIN=1
> > > CONFIG_NR_CPUS_RANGE_END=1
> > > CONFIG_NR_CPUS_DEFAULT=1
> > > CONFIG_NR_CPUS=1
> > > CONFIG_UP_LATE_INIT=y
> > > CONFIG_X86_UP_APIC=y
> > > CONFIG_X86_UP_IOAPIC=y
> > > CONFIG_X86_LOCAL_APIC=y
> > > CONFIG_X86_IO_APIC=y
> > > # CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
> > > CONFIG_X86_MCE=y
> > > # CONFIG_X86_MCELOG_LEGACY is not set
> > > CONFIG_X86_MCE_INTEL=y
> > > CONFIG_X86_MCE_AMD=y
> > > # CONFIG_X86_ANCIENT_MCE is not set
> > > CONFIG_X86_MCE_THRESHOLD=y
> > > CONFIG_X86_MCE_INJECT=m
> > > CONFIG_X86_THERMAL_VECTOR=y
> > > 
> > > #
> > > # Performance monitoring
> > > #
> > > CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> > > # CONFIG_PERF_EVENTS_INTEL_RAPL is not set
> > > CONFIG_PERF_EVENTS_INTEL_CSTATE=m
> > > # CONFIG_PERF_EVENTS_AMD_POWER is not set
> > > # end of Performance monitoring
> > > 
> > > CONFIG_X86_LEGACY_VM86=y
> > > CONFIG_VM86=y
> > > CONFIG_X86_16BIT=y
> > > CONFIG_X86_ESPFIX32=y
> > > # CONFIG_X86_IOPL_IOPERM is not set
> > > CONFIG_TOSHIBA=y
> > > CONFIG_I8K=y
> > > # CONFIG_X86_REBOOTFIXUPS is not set
> > > # CONFIG_MICROCODE is not set
> > > CONFIG_X86_MSR=m
> > > # CONFIG_X86_CPUID is not set
> > > CONFIG_NOHIGHMEM=y
> > > # CONFIG_HIGHMEM4G is not set
> > > CONFIG_PAGE_OFFSET=0xC0000000
> > > CONFIG_X86_PAE=y
> > > CONFIG_X86_CPA_STATISTICS=y
> > > CONFIG_ARCH_FLATMEM_ENABLE=y
> > > CONFIG_ARCH_SPARSEMEM_ENABLE=y
> > > CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> > > CONFIG_ILLEGAL_POINTER_VALUE=0
> > > # CONFIG_X86_PMEM_LEGACY is not set
> > > # CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
> > > CONFIG_X86_RESERVE_LOW=64
> > > CONFIG_MTRR=y
> > > # CONFIG_MTRR_SANITIZER is not set
> > > CONFIG_X86_PAT=y
> > > CONFIG_ARCH_USES_PG_UNCACHED=y
> > > CONFIG_ARCH_RANDOM=y
> > > CONFIG_X86_SMAP=y
> > > CONFIG_X86_UMIP=y
> > > CONFIG_X86_INTEL_TSX_MODE_OFF=y
> > > # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> > > # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> > > CONFIG_EFI=y
> > > # CONFIG_EFI_STUB is not set
> > > # CONFIG_SECCOMP is not set
> > > # CONFIG_HZ_100 is not set
> > > # CONFIG_HZ_250 is not set
> > > CONFIG_HZ_300=y
> > > # CONFIG_HZ_1000 is not set
> > > CONFIG_HZ=300
> > > CONFIG_SCHED_HRTICK=y
> > > # CONFIG_KEXEC is not set
> > > CONFIG_PHYSICAL_START=0x1000000
> > > CONFIG_RELOCATABLE=y
> > > CONFIG_RANDOMIZE_BASE=y
> > > CONFIG_X86_NEED_RELOCS=y
> > > CONFIG_PHYSICAL_ALIGN=0x200000
> > > CONFIG_COMPAT_VDSO=y
> > > # CONFIG_CMDLINE_BOOL is not set
> > > CONFIG_MODIFY_LDT_SYSCALL=y
> > > # end of Processor type and features
> > > 
> > > CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> > > 
> > > #
> > > # Power management and ACPI options
> > > #
> > > CONFIG_SUSPEND=y
> > > CONFIG_SUSPEND_FREEZER=y
> > > CONFIG_PM_SLEEP=y
> > > CONFIG_PM_AUTOSLEEP=y
> > > # CONFIG_PM_WAKELOCKS is not set
> > > CONFIG_PM=y
> > > CONFIG_PM_DEBUG=y
> > > # CONFIG_PM_ADVANCED_DEBUG is not set
> > > CONFIG_PM_SLEEP_DEBUG=y
> > > CONFIG_PM_TRACE=y
> > > CONFIG_PM_TRACE_RTC=y
> > > CONFIG_PM_CLK=y
> > > CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
> > > CONFIG_ARCH_SUPPORTS_ACPI=y
> > > CONFIG_ACPI=y
> > > CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> > > CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> > > CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> > > CONFIG_ACPI_DEBUGGER=y
> > > # CONFIG_ACPI_DEBUGGER_USER is not set
> > > # CONFIG_ACPI_SPCR_TABLE is not set
> > > CONFIG_ACPI_SLEEP=y
> > > # CONFIG_ACPI_PROCFS_POWER is not set
> > > CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
> > > CONFIG_ACPI_EC_DEBUGFS=y
> > > CONFIG_ACPI_AC=y
> > > CONFIG_ACPI_BATTERY=y
> > > CONFIG_ACPI_BUTTON=y
> > > CONFIG_ACPI_VIDEO=m
> > > CONFIG_ACPI_FAN=y
> > > CONFIG_ACPI_TAD=m
> > > # CONFIG_ACPI_DOCK is not set
> > > CONFIG_ACPI_CPU_FREQ_PSS=y
> > > CONFIG_ACPI_PROCESSOR_CSTATE=y
> > > CONFIG_ACPI_PROCESSOR_IDLE=y
> > > CONFIG_ACPI_PROCESSOR=m
> > > CONFIG_ACPI_IPMI=m
> > > CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
> > > CONFIG_ACPI_THERMAL=m
> > > CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> > > CONFIG_ACPI_TABLE_UPGRADE=y
> > > CONFIG_ACPI_DEBUG=y
> > > CONFIG_ACPI_PCI_SLOT=y
> > > # CONFIG_ACPI_CONTAINER is not set
> > > CONFIG_ACPI_HOTPLUG_IOAPIC=y
> > > CONFIG_ACPI_SBS=y
> > > CONFIG_ACPI_HED=y
> > > # CONFIG_ACPI_CUSTOM_METHOD is not set
> > > # CONFIG_ACPI_BGRT is not set
> > > CONFIG_HAVE_ACPI_APEI=y
> > > CONFIG_HAVE_ACPI_APEI_NMI=y
> > > # CONFIG_ACPI_APEI is not set
> > > CONFIG_DPTF_POWER=m
> > > CONFIG_ACPI_EXTLOG=y
> > > CONFIG_PMIC_OPREGION=y
> > > # CONFIG_BYTCRC_PMIC_OPREGION is not set
> > > # CONFIG_CHTCRC_PMIC_OPREGION is not set
> > > CONFIG_XPOWER_PMIC_OPREGION=y
> > > CONFIG_CHT_DC_TI_PMIC_OPREGION=y
> > > CONFIG_ACPI_CONFIGFS=y
> > > CONFIG_X86_PM_TIMER=y
> > > CONFIG_SFI=y
> > > CONFIG_X86_APM_BOOT=y
> > > CONFIG_APM=m
> > > # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> > > # CONFIG_APM_DO_ENABLE is not set
> > > # CONFIG_APM_CPU_IDLE is not set
> > > CONFIG_APM_DISPLAY_BLANK=y
> > > # CONFIG_APM_ALLOW_INTS is not set
> > > 
> > > #
> > > # CPU Frequency scaling
> > > #
> > > # CONFIG_CPU_FREQ is not set
> > > # end of CPU Frequency scaling
> > > 
> > > #
> > > # CPU Idle
> > > #
> > > CONFIG_CPU_IDLE=y
> > > # CONFIG_CPU_IDLE_GOV_LADDER is not set
> > > CONFIG_CPU_IDLE_GOV_MENU=y
> > > CONFIG_CPU_IDLE_GOV_TEO=y
> > > # CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
> > > CONFIG_HALTPOLL_CPUIDLE=y
> > > # end of CPU Idle
> > > 
> > > # CONFIG_INTEL_IDLE is not set
> > > # end of Power management and ACPI options
> > > 
> > > #
> > > # Bus options (PCI etc.)
> > > #
> > > # CONFIG_PCI_GOBIOS is not set
> > > # CONFIG_PCI_GOMMCONFIG is not set
> > > CONFIG_PCI_GODIRECT=y
> > > # CONFIG_PCI_GOANY is not set
> > > CONFIG_PCI_DIRECT=y
> > > CONFIG_ISA_DMA_API=y
> > > CONFIG_ISA=y
> > > CONFIG_SCx200=y
> > > CONFIG_SCx200HR_TIMER=m
> > > # CONFIG_ALIX is not set
> > > # CONFIG_NET5501 is not set
> > > # CONFIG_GEOS is not set
> > > CONFIG_AMD_NB=y
> > > # CONFIG_X86_SYSFB is not set
> > > # end of Bus options (PCI etc.)
> > > 
> > > #
> > > # Binary Emulations
> > > #
> > > CONFIG_COMPAT_32=y
> > > # end of Binary Emulations
> > > 
> > > CONFIG_HAVE_ATOMIC_IOMAP=y
> > > 
> > > #
> > > # Firmware Drivers
> > > #
> > > # CONFIG_EDD is not set
> > > CONFIG_FIRMWARE_MEMMAP=y
> > > # CONFIG_DMIID is not set
> > > # CONFIG_DMI_SYSFS is not set
> > > CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> > > CONFIG_ISCSI_IBFT_FIND=y
> > > CONFIG_ISCSI_IBFT=m
> > > CONFIG_FW_CFG_SYSFS=m
> > > # CONFIG_FW_CFG_SYSFS_CMDLINE is not set
> > > CONFIG_GOOGLE_FIRMWARE=y
> > > CONFIG_GOOGLE_SMI=m
> > > # CONFIG_GOOGLE_COREBOOT_TABLE is not set
> > > # CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
> > > 
> > > #
> > > # EFI (Extensible Firmware Interface) Support
> > > #
> > > CONFIG_EFI_VARS=m
> > > CONFIG_EFI_ESRT=y
> > > CONFIG_EFI_FAKE_MEMMAP=y
> > > CONFIG_EFI_MAX_FAKE_MEM=8
> > > CONFIG_EFI_RUNTIME_WRAPPERS=y
> > > # CONFIG_EFI_BOOTLOADER_CONTROL is not set
> > > # CONFIG_EFI_CAPSULE_LOADER is not set
> > > # CONFIG_EFI_CAPSULE_QUIRK_QUARK_CSH is not set
> > > # CONFIG_EFI_TEST is not set
> > > CONFIG_EFI_RCI2_TABLE=y
> > > CONFIG_EFI_DISABLE_PCI_DMA=y
> > > # end of EFI (Extensible Firmware Interface) Support
> > > 
> > > CONFIG_UEFI_CPER=y
> > > CONFIG_UEFI_CPER_X86=y
> > > CONFIG_EFI_EARLYCON=y
> > > # CONFIG_EFI_CUSTOM_SSDT_OVERLAYS is not set
> > > 
> > > #
> > > # Tegra firmware driver
> > > #
> > > # end of Tegra firmware driver
> > > # end of Firmware Drivers
> > > 
> > > CONFIG_HAVE_KVM=y
> > > CONFIG_VIRTUALIZATION=y
> > > # CONFIG_KVM is not set
> > > CONFIG_AS_AVX512=y
> > > CONFIG_AS_SHA1_NI=y
> > > CONFIG_AS_SHA256_NI=y
> > > CONFIG_AS_TPAUSE=y
> > > 
> > > #
> > > # General architecture-dependent options
> > > #
> > > CONFIG_CRASH_CORE=y
> > > CONFIG_OPROFILE=m
> > > CONFIG_OPROFILE_EVENT_MULTIPLEX=y
> > > CONFIG_HAVE_OPROFILE=y
> > > CONFIG_OPROFILE_NMI_TIMER=y
> > > # CONFIG_KPROBES is not set
> > > CONFIG_JUMP_LABEL=y
> > > # CONFIG_STATIC_KEYS_SELFTEST is not set
> > > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> > > CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> > > CONFIG_HAVE_IOREMAP_PROT=y
> > > CONFIG_HAVE_KPROBES=y
> > > CONFIG_HAVE_KRETPROBES=y
> > > CONFIG_HAVE_OPTPROBES=y
> > > CONFIG_HAVE_KPROBES_ON_FTRACE=y
> > > CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> > > CONFIG_HAVE_NMI=y
> > > CONFIG_HAVE_ARCH_TRACEHOOK=y
> > > CONFIG_HAVE_DMA_CONTIGUOUS=y
> > > CONFIG_GENERIC_SMP_IDLE_THREAD=y
> > > CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> > > CONFIG_ARCH_HAS_SET_MEMORY=y
> > > CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
> > > CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> > > CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> > > CONFIG_ARCH_32BIT_OFF_T=y
> > > CONFIG_HAVE_ASM_MODVERSIONS=y
> > > CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> > > CONFIG_HAVE_RSEQ=y
> > > CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
> > > CONFIG_HAVE_HW_BREAKPOINT=y
> > > CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> > > CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> > > CONFIG_HAVE_PERF_EVENTS_NMI=y
> > > CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> > > CONFIG_HAVE_PERF_REGS=y
> > > CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> > > CONFIG_HAVE_ARCH_JUMP_LABEL=y
> > > CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
> > > CONFIG_MMU_GATHER_TABLE_FREE=y
> > > CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> > > CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> > > CONFIG_HAVE_CMPXCHG_LOCAL=y
> > > CONFIG_HAVE_CMPXCHG_DOUBLE=y
> > > CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
> > > CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> > > CONFIG_HAVE_ARCH_STACKLEAK=y
> > > CONFIG_HAVE_STACKPROTECTOR=y
> > > CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
> > > CONFIG_STACKPROTECTOR=y
> > > CONFIG_STACKPROTECTOR_STRONG=y
> > > CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> > > CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> > > CONFIG_HAVE_MOVE_PMD=y
> > > CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> > > CONFIG_HAVE_ARCH_HUGE_VMAP=y
> > > CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> > > CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> > > CONFIG_MODULES_USE_ELF_REL=y
> > > CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> > > CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> > > CONFIG_HAVE_EXIT_THREAD=y
> > > CONFIG_ARCH_MMAP_RND_BITS=8
> > > CONFIG_HAVE_COPY_THREAD_TLS=y
> > > CONFIG_ISA_BUS_API=y
> > > CONFIG_CLONE_BACKWARDS=y
> > > CONFIG_OLD_SIGSUSPEND3=y
> > > CONFIG_OLD_SIGACTION=y
> > > CONFIG_COMPAT_32BIT_TIME=y
> > > CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> > > CONFIG_STRICT_KERNEL_RWX=y
> > > CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> > > CONFIG_STRICT_MODULE_RWX=y
> > > CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
> > > CONFIG_ARCH_USE_MEMREMAP_PROT=y
> > > # CONFIG_LOCK_EVENT_COUNTS is not set
> > > CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> > > 
> > > #
> > > # GCOV-based kernel profiling
> > > #
> > > CONFIG_GCOV_KERNEL=y
> > > CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> > > # CONFIG_GCOV_PROFILE_ALL is not set
> > > # end of GCOV-based kernel profiling
> > > 
> > > CONFIG_HAVE_GCC_PLUGINS=y
> > > # end of General architecture-dependent options
> > > 
> > > CONFIG_RT_MUTEXES=y
> > > CONFIG_BASE_SMALL=0
> > > CONFIG_MODULE_SIG_FORMAT=y
> > > CONFIG_MODULES=y
> > > CONFIG_MODULE_FORCE_LOAD=y
> > > # CONFIG_MODULE_UNLOAD is not set
> > > # CONFIG_MODVERSIONS is not set
> > > # CONFIG_MODULE_SRCVERSION_ALL is not set
> > > CONFIG_MODULE_SIG=y
> > > # CONFIG_MODULE_SIG_FORCE is not set
> > > CONFIG_MODULE_SIG_ALL=y
> > > CONFIG_MODULE_SIG_SHA1=y
> > > # CONFIG_MODULE_SIG_SHA224 is not set
> > > # CONFIG_MODULE_SIG_SHA256 is not set
> > > # CONFIG_MODULE_SIG_SHA384 is not set
> > > # CONFIG_MODULE_SIG_SHA512 is not set
> > > CONFIG_MODULE_SIG_HASH="sha1"
> > > # CONFIG_MODULE_COMPRESS is not set
> > > CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
> > > CONFIG_UNUSED_SYMBOLS=y
> > > CONFIG_MODULES_TREE_LOOKUP=y
> > > CONFIG_BLOCK=y
> > > CONFIG_BLK_SCSI_REQUEST=y
> > > CONFIG_BLK_DEV_BSG=y
> > > CONFIG_BLK_DEV_BSGLIB=y
> > > CONFIG_BLK_DEV_INTEGRITY=y
> > > CONFIG_BLK_DEV_INTEGRITY_T10=y
> > > CONFIG_BLK_DEV_ZONED=y
> > > # CONFIG_BLK_CMDLINE_PARSER is not set
> > > # CONFIG_BLK_WBT is not set
> > > CONFIG_BLK_DEBUG_FS=y
> > > CONFIG_BLK_DEBUG_FS_ZONED=y
> > > CONFIG_BLK_SED_OPAL=y
> > > CONFIG_BLK_INLINE_ENCRYPTION=y
> > > # CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK is not set
> > > 
> > > #
> > > # Partition Types
> > > #
> > > CONFIG_PARTITION_ADVANCED=y
> > > # CONFIG_ACORN_PARTITION is not set
> > > CONFIG_AIX_PARTITION=y
> > > # CONFIG_OSF_PARTITION is not set
> > > CONFIG_AMIGA_PARTITION=y
> > > CONFIG_ATARI_PARTITION=y
> > > # CONFIG_MAC_PARTITION is not set
> > > CONFIG_MSDOS_PARTITION=y
> > > # CONFIG_BSD_DISKLABEL is not set
> > > # CONFIG_MINIX_SUBPARTITION is not set
> > > # CONFIG_SOLARIS_X86_PARTITION is not set
> > > CONFIG_UNIXWARE_DISKLABEL=y
> > > CONFIG_LDM_PARTITION=y
> > > CONFIG_LDM_DEBUG=y
> > > CONFIG_SGI_PARTITION=y
> > > CONFIG_ULTRIX_PARTITION=y
> > > # CONFIG_SUN_PARTITION is not set
> > > # CONFIG_KARMA_PARTITION is not set
> > > # CONFIG_EFI_PARTITION is not set
> > > CONFIG_SYSV68_PARTITION=y
> > > # CONFIG_CMDLINE_PARTITION is not set
> > > # end of Partition Types
> > > 
> > > CONFIG_BLK_MQ_PCI=y
> > > CONFIG_BLK_MQ_VIRTIO=y
> > > CONFIG_BLK_PM=y
> > > 
> > > #
> > > # IO Schedulers
> > > #
> > > CONFIG_MQ_IOSCHED_DEADLINE=y
> > > # CONFIG_MQ_IOSCHED_KYBER is not set
> > > # CONFIG_IOSCHED_BFQ is not set
> > > # end of IO Schedulers
> > > 
> > > CONFIG_ASN1=y
> > > CONFIG_UNINLINE_SPIN_UNLOCK=y
> > > CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> > > CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> > > CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> > > CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
> > > CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> > > CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> > > CONFIG_FREEZER=y
> > > 
> > > #
> > > # Executable file formats
> > > #
> > > CONFIG_BINFMT_ELF=y
> > > CONFIG_ELFCORE=y
> > > CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
> > > CONFIG_BINFMT_SCRIPT=y
> > > # CONFIG_BINFMT_MISC is not set
> > > CONFIG_COREDUMP=y
> > > # end of Executable file formats
> > > 
> > > #
> > > # Memory Management options
> > > #
> > > CONFIG_SELECT_MEMORY_MODEL=y
> > > CONFIG_FLATMEM_MANUAL=y
> > > # CONFIG_SPARSEMEM_MANUAL is not set
> > > CONFIG_FLATMEM=y
> > > CONFIG_FLAT_NODE_MEM_MAP=y
> > > CONFIG_SPARSEMEM_STATIC=y
> > > CONFIG_HAVE_FAST_GUP=y
> > > CONFIG_MEMORY_ISOLATION=y
> > > CONFIG_SPLIT_PTLOCK_CPUS=4
> > > CONFIG_COMPACTION=y
> > > # CONFIG_PAGE_REPORTING is not set
> > > CONFIG_MIGRATION=y
> > > CONFIG_CONTIG_ALLOC=y
> > > CONFIG_PHYS_ADDR_T_64BIT=y
> > > CONFIG_BOUNCE=y
> > > CONFIG_VIRT_TO_BUS=y
> > > # CONFIG_KSM is not set
> > > CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> > > CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
> > > CONFIG_MEMORY_FAILURE=y
> > > CONFIG_HWPOISON_INJECT=m
> > > CONFIG_TRANSPARENT_HUGEPAGE=y
> > > # CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
> > > CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
> > > CONFIG_NEED_PER_CPU_KM=y
> > > # CONFIG_CLEANCACHE is not set
> > > # CONFIG_CMA is not set
> > > CONFIG_ZPOOL=m
> > > # CONFIG_ZBUD is not set
> > > # CONFIG_Z3FOLD is not set
> > > CONFIG_ZSMALLOC=y
> > > CONFIG_ZSMALLOC_PGTABLE_MAPPING=y
> > > # CONFIG_ZSMALLOC_STAT is not set
> > > CONFIG_GENERIC_EARLY_IOREMAP=y
> > > # CONFIG_IDLE_PAGE_TRACKING is not set
> > > # CONFIG_PERCPU_STATS is not set
> > > CONFIG_GUP_BENCHMARK=y
> > > CONFIG_GUP_GET_PTE_LOW_HIGH=y
> > > CONFIG_READ_ONLY_THP_FOR_FS=y
> > > CONFIG_ARCH_HAS_PTE_SPECIAL=y
> > > # end of Memory Management options
> > > 
> > > CONFIG_NET=y
> > > 
> > > #
> > > # Networking options
> > > #
> > > # CONFIG_PACKET is not set
> > > CONFIG_UNIX=y
> > > CONFIG_UNIX_SCM=y
> > > # CONFIG_UNIX_DIAG is not set
> > > # CONFIG_TLS is not set
> > > # CONFIG_XFRM_USER is not set
> > > # CONFIG_NET_KEY is not set
> > > CONFIG_INET=y
> > > # CONFIG_IP_MULTICAST is not set
> > > # CONFIG_IP_ADVANCED_ROUTER is not set
> > > CONFIG_IP_PNP=y
> > > CONFIG_IP_PNP_DHCP=y
> > > # CONFIG_IP_PNP_BOOTP is not set
> > > # CONFIG_IP_PNP_RARP is not set
> > > # CONFIG_NET_IPIP is not set
> > > # CONFIG_NET_IPGRE_DEMUX is not set
> > > CONFIG_NET_IP_TUNNEL=y
> > > # CONFIG_SYN_COOKIES is not set
> > > # CONFIG_NET_IPVTI is not set
> > > # CONFIG_NET_FOU is not set
> > > # CONFIG_NET_FOU_IP_TUNNELS is not set
> > > # CONFIG_INET_AH is not set
> > > # CONFIG_INET_ESP is not set
> > > # CONFIG_INET_IPCOMP is not set
> > > CONFIG_INET_TUNNEL=y
> > > CONFIG_INET_DIAG=y
> > > CONFIG_INET_TCP_DIAG=y
> > > # CONFIG_INET_UDP_DIAG is not set
> > > # CONFIG_INET_RAW_DIAG is not set
> > > # CONFIG_INET_DIAG_DESTROY is not set
> > > # CONFIG_TCP_CONG_ADVANCED is not set
> > > CONFIG_TCP_CONG_CUBIC=y
> > > CONFIG_DEFAULT_TCP_CONG="cubic"
> > > # CONFIG_TCP_MD5SIG is not set
> > > CONFIG_IPV6=y
> > > # CONFIG_IPV6_ROUTER_PREF is not set
> > > # CONFIG_IPV6_OPTIMISTIC_DAD is not set
> > > # CONFIG_INET6_AH is not set
> > > # CONFIG_INET6_ESP is not set
> > > # CONFIG_INET6_IPCOMP is not set
> > > # CONFIG_IPV6_MIP6 is not set
> > > # CONFIG_IPV6_VTI is not set
> > > CONFIG_IPV6_SIT=y
> > > # CONFIG_IPV6_SIT_6RD is not set
> > > CONFIG_IPV6_NDISC_NODETYPE=y
> > > # CONFIG_IPV6_TUNNEL is not set
> > > # CONFIG_IPV6_MULTIPLE_TABLES is not set
> > > # CONFIG_IPV6_MROUTE is not set
> > > # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> > > # CONFIG_IPV6_SEG6_HMAC is not set
> > > # CONFIG_IPV6_RPL_LWTUNNEL is not set
> > > # CONFIG_NETLABEL is not set
> > > # CONFIG_MPTCP is not set
> > > # CONFIG_NETWORK_SECMARK is not set
> > > # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> > > # CONFIG_NETFILTER is not set
> > > # CONFIG_BPFILTER is not set
> > > # CONFIG_IP_DCCP is not set
> > > # CONFIG_IP_SCTP is not set
> > > # CONFIG_RDS is not set
> > > # CONFIG_TIPC is not set
> > > # CONFIG_ATM is not set
> > > # CONFIG_L2TP is not set
> > > # CONFIG_BRIDGE is not set
> > > CONFIG_HAVE_NET_DSA=y
> > > # CONFIG_NET_DSA is not set
> > > # CONFIG_VLAN_8021Q is not set
> > > # CONFIG_DECNET is not set
> > > # CONFIG_LLC2 is not set
> > > # CONFIG_ATALK is not set
> > > # CONFIG_X25 is not set
> > > # CONFIG_LAPB is not set
> > > # CONFIG_PHONET is not set
> > > # CONFIG_6LOWPAN is not set
> > > # CONFIG_IEEE802154 is not set
> > > # CONFIG_NET_SCHED is not set
> > > # CONFIG_DCB is not set
> > > CONFIG_DNS_RESOLVER=m
> > > # CONFIG_BATMAN_ADV is not set
> > > # CONFIG_OPENVSWITCH is not set
> > > # CONFIG_VSOCKETS is not set
> > > # CONFIG_NETLINK_DIAG is not set
> > > # CONFIG_MPLS is not set
> > > # CONFIG_NET_NSH is not set
> > > # CONFIG_HSR is not set
> > > # CONFIG_NET_SWITCHDEV is not set
> > > # CONFIG_NET_L3_MASTER_DEV is not set
> > > # CONFIG_QRTR is not set
> > > # CONFIG_NET_NCSI is not set
> > > # CONFIG_CGROUP_NET_PRIO is not set
> > > # CONFIG_CGROUP_NET_CLASSID is not set
> > > CONFIG_NET_RX_BUSY_POLL=y
> > > CONFIG_BQL=y
> > > # CONFIG_BPF_JIT is not set
> > > 
> > > #
> > > # Network testing
> > > #
> > > # CONFIG_NET_PKTGEN is not set
> > > # CONFIG_NET_DROP_MONITOR is not set
> > > # end of Network testing
> > > # end of Networking options
> > > 
> > > # CONFIG_HAMRADIO is not set
> > > # CONFIG_CAN is not set
> > > # CONFIG_BT is not set
> > > # CONFIG_AF_RXRPC is not set
> > > # CONFIG_AF_KCM is not set
> > > CONFIG_WIRELESS=y
> > > # CONFIG_CFG80211 is not set
> > > 
> > > #
> > > # CFG80211 needs to be enabled for MAC80211
> > > #
> > > CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> > > # CONFIG_WIMAX is not set
> > > # CONFIG_RFKILL is not set
> > > CONFIG_NET_9P=y
> > > CONFIG_NET_9P_VIRTIO=y
> > > # CONFIG_NET_9P_DEBUG is not set
> > > # CONFIG_CAIF is not set
> > > # CONFIG_CEPH_LIB is not set
> > > # CONFIG_NFC is not set
> > > # CONFIG_PSAMPLE is not set
> > > # CONFIG_NET_IFE is not set
> > > # CONFIG_LWTUNNEL is not set
> > > CONFIG_DST_CACHE=y
> > > CONFIG_GRO_CELLS=y
> > > # CONFIG_FAILOVER is not set
> > > CONFIG_ETHTOOL_NETLINK=y
> > > CONFIG_HAVE_EBPF_JIT=y
> > > 
> > > #
> > > # Device Drivers
> > > #
> > > CONFIG_HAVE_EISA=y
> > > # CONFIG_EISA is not set
> > > CONFIG_HAVE_PCI=y
> > > CONFIG_PCI=y
> > > CONFIG_PCI_DOMAINS=y
> > > CONFIG_PCIEPORTBUS=y
> > > # CONFIG_PCIEAER is not set
> > > CONFIG_PCIEASPM=y
> > > # CONFIG_PCIEASPM_DEFAULT is not set
> > > # CONFIG_PCIEASPM_POWERSAVE is not set
> > > CONFIG_PCIEASPM_POWER_SUPERSAVE=y
> > > # CONFIG_PCIEASPM_PERFORMANCE is not set
> > > CONFIG_PCIE_PME=y
> > > CONFIG_PCIE_PTM=y
> > > CONFIG_PCIE_BW=y
> > > CONFIG_PCI_MSI=y
> > > CONFIG_PCI_MSI_IRQ_DOMAIN=y
> > > CONFIG_PCI_QUIRKS=y
> > > # CONFIG_PCI_DEBUG is not set
> > > CONFIG_PCI_STUB=y
> > > CONFIG_PCI_ATS=y
> > > CONFIG_PCI_LOCKLESS_CONFIG=y
> > > # CONFIG_PCI_IOV is not set
> > > # CONFIG_PCI_PRI is not set
> > > CONFIG_PCI_PASID=y
> > > CONFIG_PCI_LABEL=y
> > > # CONFIG_HOTPLUG_PCI is not set
> > > 
> > > #
> > > # PCI controller drivers
> > > #
> > > 
> > > #
> > > # DesignWare PCI Core Support
> > > #
> > > # CONFIG_PCIE_DW_PLAT_HOST is not set
> > > # CONFIG_PCI_MESON is not set
> > > # end of DesignWare PCI Core Support
> > > 
> > > #
> > > # Mobiveil PCIe Core Support
> > > #
> > > # end of Mobiveil PCIe Core Support
> > > 
> > > #
> > > # Cadence PCIe controllers support
> > > #
> > > # end of Cadence PCIe controllers support
> > > # end of PCI controller drivers
> > > 
> > > #
> > > # PCI Endpoint
> > > #
> > > # CONFIG_PCI_ENDPOINT is not set
> > > # end of PCI Endpoint
> > > 
> > > #
> > > # PCI switch controller drivers
> > > #
> > > CONFIG_PCI_SW_SWITCHTEC=m
> > > # end of PCI switch controller drivers
> > > 
> > > CONFIG_PCCARD=m
> > > # CONFIG_PCMCIA is not set
> > > # CONFIG_CARDBUS is not set
> > > 
> > > #
> > > # PC-card bridges
> > > #
> > > # CONFIG_YENTA is not set
> > > CONFIG_PCMCIA_PROBE=y
> > > # CONFIG_RAPIDIO is not set
> > > 
> > > #
> > > # Generic Driver Options
> > > #
> > > CONFIG_UEVENT_HELPER=y
> > > CONFIG_UEVENT_HELPER_PATH=""
> > > CONFIG_DEVTMPFS=y
> > > # CONFIG_DEVTMPFS_MOUNT is not set
> > > CONFIG_STANDALONE=y
> > > CONFIG_PREVENT_FIRMWARE_BUILD=y
> > > 
> > > #
> > > # Firmware loader
> > > #
> > > CONFIG_FW_LOADER=y
> > > CONFIG_FW_LOADER_PAGED_BUF=y
> > > CONFIG_EXTRA_FIRMWARE=""
> > > CONFIG_FW_LOADER_USER_HELPER=y
> > > CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
> > > CONFIG_FW_LOADER_COMPRESS=y
> > > # CONFIG_FW_CACHE is not set
> > > # end of Firmware loader
> > > 
> > > CONFIG_ALLOW_DEV_COREDUMP=y
> > > # CONFIG_DEBUG_DRIVER is not set
> > > CONFIG_DEBUG_DEVRES=y
> > > # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> > > # CONFIG_PM_QOS_KUNIT_TEST is not set
> > > CONFIG_TEST_ASYNC_DRIVER_PROBE=m
> > > # CONFIG_KUNIT_DRIVER_PE_TEST is not set
> > > CONFIG_GENERIC_CPU_AUTOPROBE=y
> > > CONFIG_GENERIC_CPU_VULNERABILITIES=y
> > > CONFIG_REGMAP=y
> > > CONFIG_REGMAP_I2C=y
> > > CONFIG_REGMAP_W1=y
> > > CONFIG_REGMAP_MMIO=y
> > > CONFIG_REGMAP_IRQ=y
> > > CONFIG_DMA_SHARED_BUFFER=y
> > > # CONFIG_DMA_FENCE_TRACE is not set
> > > # end of Generic Driver Options
> > > 
> > > #
> > > # Bus devices
> > > #
> > > # CONFIG_MHI_BUS is not set
> > > # end of Bus devices
> > > 
> > > # CONFIG_CONNECTOR is not set
> > > CONFIG_GNSS=y
> > > CONFIG_MTD=m
> > > CONFIG_MTD_TESTS=m
> > > 
> > > #
> > > # Partition parsers
> > > #
> > > CONFIG_MTD_AR7_PARTS=m
> > > CONFIG_MTD_CMDLINE_PARTS=m
> > > CONFIG_MTD_REDBOOT_PARTS=m
> > > CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
> > > CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
> > > CONFIG_MTD_REDBOOT_PARTS_READONLY=y
> > > # end of Partition parsers
> > > 
> > > #
> > > # User Modules And Translation Layers
> > > #
> > > CONFIG_MTD_BLKDEVS=m
> > > CONFIG_MTD_BLOCK=m
> > > # CONFIG_MTD_BLOCK_RO is not set
> > > # CONFIG_FTL is not set
> > > CONFIG_NFTL=m
> > > # CONFIG_NFTL_RW is not set
> > > CONFIG_INFTL=m
> > > CONFIG_RFD_FTL=m
> > > CONFIG_SSFDC=m
> > > CONFIG_SM_FTL=m
> > > CONFIG_MTD_OOPS=m
> > > # CONFIG_MTD_PARTITIONED_MASTER is not set
> > > 
> > > #
> > > # RAM/ROM/Flash chip drivers
> > > #
> > > CONFIG_MTD_CFI=m
> > > CONFIG_MTD_JEDECPROBE=m
> > > CONFIG_MTD_GEN_PROBE=m
> > > # CONFIG_MTD_CFI_ADV_OPTIONS is not set
> > > CONFIG_MTD_MAP_BANK_WIDTH_1=y
> > > CONFIG_MTD_MAP_BANK_WIDTH_2=y
> > > CONFIG_MTD_MAP_BANK_WIDTH_4=y
> > > CONFIG_MTD_CFI_I1=y
> > > CONFIG_MTD_CFI_I2=y
> > > CONFIG_MTD_CFI_INTELEXT=m
> > > CONFIG_MTD_CFI_AMDSTD=m
> > > CONFIG_MTD_CFI_STAA=m
> > > CONFIG_MTD_CFI_UTIL=m
> > > CONFIG_MTD_RAM=m
> > > CONFIG_MTD_ROM=m
> > > CONFIG_MTD_ABSENT=m
> > > # end of RAM/ROM/Flash chip drivers
> > > 
> > > #
> > > # Mapping drivers for chip access
> > > #
> > > CONFIG_MTD_COMPLEX_MAPPINGS=y
> > > # CONFIG_MTD_PHYSMAP is not set
> > > # CONFIG_MTD_SBC_GXX is not set
> > > # CONFIG_MTD_SCx200_DOCFLASH is not set
> > > CONFIG_MTD_AMD76XROM=m
> > > CONFIG_MTD_ICHXROM=m
> > > CONFIG_MTD_ESB2ROM=m
> > > CONFIG_MTD_CK804XROM=m
> > > # CONFIG_MTD_SCB2_FLASH is not set
> > > CONFIG_MTD_NETtel=m
> > > CONFIG_MTD_L440GX=m
> > > CONFIG_MTD_PCI=m
> > > CONFIG_MTD_INTEL_VR_NOR=m
> > > # CONFIG_MTD_PLATRAM is not set
> > > # end of Mapping drivers for chip access
> > > 
> > > #
> > > # Self-contained MTD device drivers
> > > #
> > > CONFIG_MTD_PMC551=m
> > > # CONFIG_MTD_PMC551_BUGFIX is not set
> > > # CONFIG_MTD_PMC551_DEBUG is not set
> > > # CONFIG_MTD_SLRAM is not set
> > > # CONFIG_MTD_PHRAM is not set
> > > # CONFIG_MTD_MTDRAM is not set
> > > # CONFIG_MTD_BLOCK2MTD is not set
> > > 
> > > #
> > > # Disk-On-Chip Device Drivers
> > > #
> > > CONFIG_MTD_DOCG3=m
> > > CONFIG_BCH_CONST_M=14
> > > CONFIG_BCH_CONST_T=4
> > > # end of Self-contained MTD device drivers
> > > 
> > > CONFIG_MTD_NAND_CORE=m
> > > CONFIG_MTD_ONENAND=m
> > > CONFIG_MTD_ONENAND_VERIFY_WRITE=y
> > > CONFIG_MTD_ONENAND_GENERIC=m
> > > # CONFIG_MTD_ONENAND_OTP is not set
> > > CONFIG_MTD_ONENAND_2X_PROGRAM=y
> > > CONFIG_MTD_NAND_ECC_SW_HAMMING=m
> > > # CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
> > > CONFIG_MTD_RAW_NAND=m
> > > # CONFIG_MTD_NAND_ECC_SW_BCH is not set
> > > 
> > > #
> > > # Raw/parallel NAND flash controllers
> > > #
> > > # CONFIG_MTD_NAND_DENALI_PCI is not set
> > > CONFIG_MTD_NAND_CAFE=m
> > > CONFIG_MTD_NAND_CS553X=m
> > > CONFIG_MTD_NAND_MXIC=m
> > > CONFIG_MTD_NAND_GPIO=m
> > > CONFIG_MTD_NAND_PLATFORM=m
> > > CONFIG_MTD_NAND_ARASAN=m
> > > 
> > > #
> > > # Misc
> > > #
> > > CONFIG_MTD_SM_COMMON=m
> > > CONFIG_MTD_NAND_NANDSIM=m
> > > CONFIG_MTD_NAND_RICOH=m
> > > # CONFIG_MTD_NAND_DISKONCHIP is not set
> > > 
> > > #
> > > # LPDDR & LPDDR2 PCM memory drivers
> > > #
> > > CONFIG_MTD_LPDDR=m
> > > CONFIG_MTD_QINFO_PROBE=m
> > > # end of LPDDR & LPDDR2 PCM memory drivers
> > > 
> > > # CONFIG_MTD_UBI is not set
> > > # CONFIG_MTD_HYPERBUS is not set
> > > # CONFIG_OF is not set
> > > CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> > > CONFIG_PARPORT=y
> > > CONFIG_PARPORT_PC=m
> > > # CONFIG_PARPORT_PC_FIFO is not set
> > > CONFIG_PARPORT_PC_SUPERIO=y
> > > CONFIG_PARPORT_AX88796=y
> > > CONFIG_PARPORT_1284=y
> > > CONFIG_PARPORT_NOT_PC=y
> > > CONFIG_PNP=y
> > > # CONFIG_PNP_DEBUG_MESSAGES is not set
> > > 
> > > #
> > > # Protocols
> > > #
> > > # CONFIG_ISAPNP is not set
> > > # CONFIG_PNPBIOS is not set
> > > CONFIG_PNPACPI=y
> > > CONFIG_BLK_DEV=y
> > > CONFIG_BLK_DEV_NULL_BLK=y
> > > CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
> > > CONFIG_BLK_DEV_FD=y
> > > CONFIG_CDROM=y
> > > # CONFIG_PARIDE is not set
> > > CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
> > > # CONFIG_ZRAM is not set
> > > CONFIG_BLK_DEV_UMEM=m
> > > CONFIG_BLK_DEV_LOOP=m
> > > CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
> > > # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> > > # CONFIG_BLK_DEV_DRBD is not set
> > > # CONFIG_BLK_DEV_NBD is not set
> > > # CONFIG_BLK_DEV_SX8 is not set
> > > CONFIG_BLK_DEV_RAM=m
> > > CONFIG_BLK_DEV_RAM_COUNT=16
> > > CONFIG_BLK_DEV_RAM_SIZE=4096
> > > # CONFIG_CDROM_PKTCDVD is not set
> > > # CONFIG_ATA_OVER_ETH is not set
> > > CONFIG_VIRTIO_BLK=y
> > > # CONFIG_BLK_DEV_RBD is not set
> > > CONFIG_BLK_DEV_RSXX=m
> > > 
> > > #
> > > # NVME Support
> > > #
> > > CONFIG_NVME_CORE=y
> > > # CONFIG_BLK_DEV_NVME is not set
> > > CONFIG_NVME_MULTIPATH=y
> > > CONFIG_NVME_HWMON=y
> > > CONFIG_NVME_FABRICS=y
> > > CONFIG_NVME_FC=y
> > > # CONFIG_NVME_TARGET is not set
> > > # end of NVME Support
> > > 
> > > #
> > > # Misc devices
> > > #
> > > CONFIG_SENSORS_LIS3LV02D=m
> > > CONFIG_AD525X_DPOT=m
> > > CONFIG_AD525X_DPOT_I2C=m
> > > CONFIG_DUMMY_IRQ=y
> > > CONFIG_IBM_ASM=m
> > > CONFIG_PHANTOM=y
> > > CONFIG_TIFM_CORE=m
> > > CONFIG_TIFM_7XX1=m
> > > CONFIG_ICS932S401=m
> > > # CONFIG_ENCLOSURE_SERVICES is not set
> > > # CONFIG_HP_ILO is not set
> > > # CONFIG_APDS9802ALS is not set
> > > # CONFIG_ISL29003 is not set
> > > # CONFIG_ISL29020 is not set
> > > CONFIG_SENSORS_TSL2550=y
> > > CONFIG_SENSORS_BH1770=m
> > > CONFIG_SENSORS_APDS990X=m
> > > CONFIG_HMC6352=y
> > > # CONFIG_DS1682 is not set
> > > CONFIG_PCH_PHUB=y
> > > # CONFIG_SRAM is not set
> > > # CONFIG_PCI_ENDPOINT_TEST is not set
> > > # CONFIG_XILINX_SDFEC is not set
> > > CONFIG_MISC_RTSX=y
> > > CONFIG_PVPANIC=m
> > > CONFIG_C2PORT=y
> > > CONFIG_C2PORT_DURAMAR_2150=m
> > > 
> > > #
> > > # EEPROM support
> > > #
> > > CONFIG_EEPROM_AT24=m
> > > CONFIG_EEPROM_LEGACY=y
> > > CONFIG_EEPROM_MAX6875=m
> > > # CONFIG_EEPROM_93CX6 is not set
> > > CONFIG_EEPROM_IDT_89HPESX=y
> > > CONFIG_EEPROM_EE1004=m
> > > # end of EEPROM support
> > > 
> > > CONFIG_CB710_CORE=y
> > > CONFIG_CB710_DEBUG=y
> > > CONFIG_CB710_DEBUG_ASSUMPTIONS=y
> > > 
> > > #
> > > # Texas Instruments shared transport line discipline
> > > #
> > > # CONFIG_TI_ST is not set
> > > # end of Texas Instruments shared transport line discipline
> > > 
> > > CONFIG_SENSORS_LIS3_I2C=m
> > > CONFIG_ALTERA_STAPL=m
> > > CONFIG_INTEL_MEI=m
> > > CONFIG_INTEL_MEI_ME=m
> > > CONFIG_INTEL_MEI_TXE=m
> > > # CONFIG_VMWARE_VMCI is not set
> > > 
> > > #
> > > # Intel MIC & related support
> > > #
> > > CONFIG_VOP_BUS=y
> > > CONFIG_VOP=y
> > > # end of Intel MIC & related support
> > > 
> > > CONFIG_ECHO=m
> > > # CONFIG_MISC_ALCOR_PCI is not set
> > > CONFIG_MISC_RTSX_PCI=y
> > > # CONFIG_MISC_RTSX_USB is not set
> > > # CONFIG_HABANA_AI is not set
> > > CONFIG_UACCE=m
> > > # end of Misc devices
> > > 
> > > CONFIG_HAVE_IDE=y
> > > CONFIG_IDE=m
> > > 
> > > #
> > > # Please see Documentation/ide/ide.rst for help/info on IDE drives
> > > #
> > > CONFIG_IDE_XFER_MODE=y
> > > CONFIG_IDE_TIMINGS=y
> > > CONFIG_IDE_ATAPI=y
> > > CONFIG_IDE_LEGACY=y
> > > # CONFIG_BLK_DEV_IDE_SATA is not set
> > > CONFIG_IDE_GD=m
> > > # CONFIG_IDE_GD_ATA is not set
> > > CONFIG_IDE_GD_ATAPI=y
> > > CONFIG_BLK_DEV_IDECD=m
> > > CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
> > > CONFIG_BLK_DEV_IDETAPE=m
> > > # CONFIG_BLK_DEV_IDEACPI is not set
> > > CONFIG_IDE_TASK_IOCTL=y
> > > # CONFIG_IDE_PROC_FS is not set
> > > 
> > > #
> > > # IDE chipset support/bugfixes
> > > #
> > > CONFIG_IDE_GENERIC=m
> > > CONFIG_BLK_DEV_PLATFORM=m
> > > # CONFIG_BLK_DEV_CMD640 is not set
> > > CONFIG_BLK_DEV_IDEPNP=m
> > > CONFIG_BLK_DEV_IDEDMA_SFF=y
> > > 
> > > #
> > > # PCI IDE chipsets support
> > > #
> > > CONFIG_BLK_DEV_IDEPCI=y
> > > # CONFIG_BLK_DEV_OFFBOARD is not set
> > > CONFIG_BLK_DEV_GENERIC=m
> > > # CONFIG_BLK_DEV_OPTI621 is not set
> > > CONFIG_BLK_DEV_RZ1000=m
> > > CONFIG_BLK_DEV_IDEDMA_PCI=y
> > > CONFIG_BLK_DEV_AEC62XX=m
> > > # CONFIG_BLK_DEV_ALI15X3 is not set
> > > CONFIG_BLK_DEV_AMD74XX=m
> > > CONFIG_BLK_DEV_ATIIXP=m
> > > CONFIG_BLK_DEV_CMD64X=m
> > > CONFIG_BLK_DEV_TRIFLEX=m
> > > CONFIG_BLK_DEV_CS5520=m
> > > CONFIG_BLK_DEV_CS5530=m
> > > CONFIG_BLK_DEV_CS5535=m
> > > # CONFIG_BLK_DEV_CS5536 is not set
> > > CONFIG_BLK_DEV_HPT366=m
> > > # CONFIG_BLK_DEV_JMICRON is not set
> > > CONFIG_BLK_DEV_SC1200=m
> > > # CONFIG_BLK_DEV_PIIX is not set
> > > # CONFIG_BLK_DEV_IT8172 is not set
> > > CONFIG_BLK_DEV_IT8213=m
> > > CONFIG_BLK_DEV_IT821X=m
> > > CONFIG_BLK_DEV_NS87415=m
> > > # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> > > CONFIG_BLK_DEV_PDC202XX_NEW=m
> > > CONFIG_BLK_DEV_SVWKS=m
> > > # CONFIG_BLK_DEV_SIIMAGE is not set
> > > CONFIG_BLK_DEV_SIS5513=m
> > > # CONFIG_BLK_DEV_SLC90E66 is not set
> > > # CONFIG_BLK_DEV_TRM290 is not set
> > > CONFIG_BLK_DEV_VIA82CXXX=m
> > > CONFIG_BLK_DEV_TC86C001=m
> > > 
> > > #
> > > # Other IDE chipsets support
> > > #
> > > 
> > > #
> > > # Note: most of these also require special kernel boot parameters
> > > #
> > > # CONFIG_BLK_DEV_4DRIVES is not set
> > > # CONFIG_BLK_DEV_ALI14XX is not set
> > > CONFIG_BLK_DEV_DTC2278=m
> > > CONFIG_BLK_DEV_HT6560B=m
> > > CONFIG_BLK_DEV_QD65XX=m
> > > CONFIG_BLK_DEV_UMC8672=m
> > > CONFIG_BLK_DEV_IDEDMA=y
> > > 
> > > #
> > > # SCSI device support
> > > #
> > > CONFIG_SCSI_MOD=y
> > > CONFIG_RAID_ATTRS=y
> > > CONFIG_SCSI=y
> > > CONFIG_SCSI_DMA=y
> > > CONFIG_SCSI_PROC_FS=y
> > > 
> > > #
> > > # SCSI support type (disk, tape, CD-ROM)
> > > #
> > > # CONFIG_BLK_DEV_SD is not set
> > > CONFIG_CHR_DEV_ST=m
> > > CONFIG_BLK_DEV_SR=y
> > > CONFIG_CHR_DEV_SG=m
> > > CONFIG_CHR_DEV_SCH=m
> > > CONFIG_SCSI_CONSTANTS=y
> > > # CONFIG_SCSI_LOGGING is not set
> > > # CONFIG_SCSI_SCAN_ASYNC is not set
> > > 
> > > #
> > > # SCSI Transports
> > > #
> > > CONFIG_SCSI_SPI_ATTRS=y
> > > # CONFIG_SCSI_FC_ATTRS is not set
> > > # CONFIG_SCSI_ISCSI_ATTRS is not set
> > > CONFIG_SCSI_SAS_ATTRS=y
> > > CONFIG_SCSI_SAS_LIBSAS=y
> > > CONFIG_SCSI_SAS_HOST_SMP=y
> > > CONFIG_SCSI_SRP_ATTRS=m
> > > # end of SCSI Transports
> > > 
> > > CONFIG_SCSI_LOWLEVEL=y
> > > # CONFIG_ISCSI_TCP is not set
> > > CONFIG_ISCSI_BOOT_SYSFS=m
> > > # CONFIG_SCSI_CXGB3_ISCSI is not set
> > > # CONFIG_SCSI_CXGB4_ISCSI is not set
> > > # CONFIG_SCSI_BNX2_ISCSI is not set
> > > # CONFIG_BE2ISCSI is not set
> > > CONFIG_BLK_DEV_3W_XXXX_RAID=m
> > > # CONFIG_SCSI_HPSA is not set
> > > CONFIG_SCSI_3W_9XXX=m
> > > # CONFIG_SCSI_3W_SAS is not set
> > > CONFIG_SCSI_ACARD=y
> > > # CONFIG_SCSI_AHA152X is not set
> > > # CONFIG_SCSI_AHA1542 is not set
> > > # CONFIG_SCSI_AACRAID is not set
> > > # CONFIG_SCSI_AIC7XXX is not set
> > > CONFIG_SCSI_AIC79XX=m
> > > CONFIG_AIC79XX_CMDS_PER_DEVICE=32
> > > CONFIG_AIC79XX_RESET_DELAY_MS=5000
> > > CONFIG_AIC79XX_DEBUG_ENABLE=y
> > > CONFIG_AIC79XX_DEBUG_MASK=0
> > > CONFIG_AIC79XX_REG_PRETTY_PRINT=y
> > > CONFIG_SCSI_AIC94XX=y
> > > # CONFIG_AIC94XX_DEBUG is not set
> > > # CONFIG_SCSI_MVSAS is not set
> > > # CONFIG_SCSI_MVUMI is not set
> > > CONFIG_SCSI_DPT_I2O=m
> > > CONFIG_SCSI_ADVANSYS=m
> > > # CONFIG_SCSI_ARCMSR is not set
> > > CONFIG_SCSI_ESAS2R=m
> > > # CONFIG_MEGARAID_NEWGEN is not set
> > > CONFIG_MEGARAID_LEGACY=y
> > > # CONFIG_MEGARAID_SAS is not set
> > > CONFIG_SCSI_MPT3SAS=y
> > > CONFIG_SCSI_MPT2SAS_MAX_SGE=128
> > > CONFIG_SCSI_MPT3SAS_MAX_SGE=128
> > > CONFIG_SCSI_MPT2SAS=y
> > > CONFIG_SCSI_SMARTPQI=y
> > > # CONFIG_SCSI_UFSHCD is not set
> > > CONFIG_SCSI_HPTIOP=m
> > > CONFIG_SCSI_BUSLOGIC=y
> > > # CONFIG_SCSI_FLASHPOINT is not set
> > > # CONFIG_SCSI_MYRB is not set
> > > # CONFIG_SCSI_MYRS is not set
> > > CONFIG_VMWARE_PVSCSI=y
> > > CONFIG_SCSI_SNIC=y
> > > CONFIG_SCSI_SNIC_DEBUG_FS=y
> > > # CONFIG_SCSI_DMX3191D is not set
> > > CONFIG_SCSI_FDOMAIN=m
> > > CONFIG_SCSI_FDOMAIN_PCI=m
> > > CONFIG_SCSI_FDOMAIN_ISA=m
> > > # CONFIG_SCSI_GDTH is not set
> > > CONFIG_SCSI_ISCI=y
> > > # CONFIG_SCSI_GENERIC_NCR5380 is not set
> > > CONFIG_SCSI_IPS=m
> > > CONFIG_SCSI_INITIO=y
> > > CONFIG_SCSI_INIA100=m
> > > # CONFIG_SCSI_PPA is not set
> > > CONFIG_SCSI_IMM=m
> > > CONFIG_SCSI_IZIP_EPP16=y
> > > CONFIG_SCSI_IZIP_SLOW_CTR=y
> > > CONFIG_SCSI_STEX=m
> > > CONFIG_SCSI_SYM53C8XX_2=y
> > > CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
> > > CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
> > > CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
> > > # CONFIG_SCSI_SYM53C8XX_MMIO is not set
> > > CONFIG_SCSI_QLOGIC_FAS=m
> > > CONFIG_SCSI_QLOGIC_1280=y
> > > # CONFIG_SCSI_QLA_ISCSI is not set
> > > # CONFIG_SCSI_DC395x is not set
> > > CONFIG_SCSI_AM53C974=y
> > > CONFIG_SCSI_NSP32=y
> > > # CONFIG_SCSI_WD719X is not set
> > > CONFIG_SCSI_DEBUG=m
> > > # CONFIG_SCSI_PMCRAID is not set
> > > # CONFIG_SCSI_PM8001 is not set
> > > CONFIG_SCSI_VIRTIO=m
> > > # CONFIG_SCSI_DH is not set
> > > # end of SCSI device support
> > > 
> > > # CONFIG_ATA is not set
> > > CONFIG_MD=y
> > > CONFIG_BLK_DEV_MD=m
> > > CONFIG_MD_LINEAR=m
> > > # CONFIG_MD_RAID0 is not set
> > > # CONFIG_MD_RAID1 is not set
> > > CONFIG_MD_RAID10=m
> > > CONFIG_MD_RAID456=m
> > > CONFIG_MD_MULTIPATH=m
> > > CONFIG_MD_FAULTY=m
> > > CONFIG_BCACHE=y
> > > # CONFIG_BCACHE_DEBUG is not set
> > > CONFIG_BCACHE_CLOSURES_DEBUG=y
> > > CONFIG_BCACHE_ASYNC_REGISTRAION=y
> > > CONFIG_BLK_DEV_DM_BUILTIN=y
> > > CONFIG_BLK_DEV_DM=m
> > > CONFIG_DM_DEBUG=y
> > > CONFIG_DM_BUFIO=m
> > > # CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
> > > CONFIG_DM_BIO_PRISON=m
> > > CONFIG_DM_PERSISTENT_DATA=m
> > > # CONFIG_DM_UNSTRIPED is not set
> > > CONFIG_DM_CRYPT=m
> > > CONFIG_DM_SNAPSHOT=m
> > > # CONFIG_DM_THIN_PROVISIONING is not set
> > > # CONFIG_DM_CACHE is not set
> > > CONFIG_DM_WRITECACHE=m
> > > CONFIG_DM_EBS=m
> > > CONFIG_DM_ERA=m
> > > CONFIG_DM_CLONE=m
> > > CONFIG_DM_MIRROR=m
> > > # CONFIG_DM_LOG_USERSPACE is not set
> > > # CONFIG_DM_RAID is not set
> > > CONFIG_DM_ZERO=m
> > > CONFIG_DM_MULTIPATH=m
> > > CONFIG_DM_MULTIPATH_QL=m
> > > CONFIG_DM_MULTIPATH_ST=m
> > > CONFIG_DM_MULTIPATH_HST=m
> > > # CONFIG_DM_DELAY is not set
> > > CONFIG_DM_DUST=m
> > > CONFIG_DM_UEVENT=y
> > > # CONFIG_DM_FLAKEY is not set
> > > CONFIG_DM_VERITY=m
> > > CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y
> > > # CONFIG_DM_VERITY_FEC is not set
> > > CONFIG_DM_SWITCH=m
> > > CONFIG_DM_LOG_WRITES=m
> > > CONFIG_DM_INTEGRITY=m
> > > CONFIG_DM_ZONED=m
> > > CONFIG_TARGET_CORE=m
> > > CONFIG_TCM_IBLOCK=m
> > > # CONFIG_TCM_FILEIO is not set
> > > # CONFIG_TCM_PSCSI is not set
> > > # CONFIG_TCM_USER2 is not set
> > > CONFIG_LOOPBACK_TARGET=m
> > > # CONFIG_ISCSI_TARGET is not set
> > > CONFIG_SBP_TARGET=m
> > > # CONFIG_FUSION is not set
> > > 
> > > #
> > > # IEEE 1394 (FireWire) support
> > > #
> > > CONFIG_FIREWIRE=m
> > > # CONFIG_FIREWIRE_OHCI is not set
> > > # CONFIG_FIREWIRE_SBP2 is not set
> > > # CONFIG_FIREWIRE_NET is not set
> > > # CONFIG_FIREWIRE_NOSY is not set
> > > # end of IEEE 1394 (FireWire) support
> > > 
> > > CONFIG_MACINTOSH_DRIVERS=y
> > > # CONFIG_MAC_EMUMOUSEBTN is not set
> > > CONFIG_NETDEVICES=y
> > > CONFIG_NET_CORE=y
> > > # CONFIG_BONDING is not set
> > > # CONFIG_DUMMY is not set
> > > # CONFIG_WIREGUARD is not set
> > > # CONFIG_EQUALIZER is not set
> > > # CONFIG_NET_FC is not set
> > > # CONFIG_NET_TEAM is not set
> > > # CONFIG_MACVLAN is not set
> > > # CONFIG_IPVLAN is not set
> > > # CONFIG_VXLAN is not set
> > > # CONFIG_GENEVE is not set
> > > # CONFIG_BAREUDP is not set
> > > # CONFIG_GTP is not set
> > > # CONFIG_MACSEC is not set
> > > # CONFIG_NETCONSOLE is not set
> > > # CONFIG_NTB_NETDEV is not set
> > > # CONFIG_TUN is not set
> > > # CONFIG_TUN_VNET_CROSS_LE is not set
> > > # CONFIG_VETH is not set
> > > # CONFIG_VIRTIO_NET is not set
> > > # CONFIG_NLMON is not set
> > > # CONFIG_ARCNET is not set
> > > 
> > > #
> > > # Distributed Switch Architecture drivers
> > > #
> > > # end of Distributed Switch Architecture drivers
> > > 
> > > CONFIG_ETHERNET=y
> > > CONFIG_NET_VENDOR_3COM=y
> > > # CONFIG_EL3 is not set
> > > # CONFIG_3C515 is not set
> > > # CONFIG_VORTEX is not set
> > > # CONFIG_TYPHOON is not set
> > > CONFIG_NET_VENDOR_ADAPTEC=y
> > > # CONFIG_ADAPTEC_STARFIRE is not set
> > > CONFIG_NET_VENDOR_AGERE=y
> > > # CONFIG_ET131X is not set
> > > CONFIG_NET_VENDOR_ALACRITECH=y
> > > # CONFIG_SLICOSS is not set
> > > CONFIG_NET_VENDOR_ALTEON=y
> > > # CONFIG_ACENIC is not set
> > > # CONFIG_ALTERA_TSE is not set
> > > CONFIG_NET_VENDOR_AMAZON=y
> > > # CONFIG_ENA_ETHERNET is not set
> > > CONFIG_NET_VENDOR_AMD=y
> > > # CONFIG_AMD8111_ETH is not set
> > > # CONFIG_LANCE is not set
> > > # CONFIG_PCNET32 is not set
> > > # CONFIG_NI65 is not set
> > > # CONFIG_AMD_XGBE is not set
> > > CONFIG_NET_VENDOR_AQUANTIA=y
> > > CONFIG_NET_VENDOR_ARC=y
> > > CONFIG_NET_VENDOR_ATHEROS=y
> > > # CONFIG_ATL2 is not set
> > > # CONFIG_ATL1 is not set
> > > # CONFIG_ATL1E is not set
> > > # CONFIG_ATL1C is not set
> > > # CONFIG_ALX is not set
> > > CONFIG_NET_VENDOR_AURORA=y
> > > # CONFIG_AURORA_NB8800 is not set
> > > CONFIG_NET_VENDOR_BROADCOM=y
> > > # CONFIG_B44 is not set
> > > # CONFIG_BCMGENET is not set
> > > # CONFIG_BNX2 is not set
> > > # CONFIG_CNIC is not set
> > > # CONFIG_TIGON3 is not set
> > > # CONFIG_BNX2X is not set
> > > # CONFIG_SYSTEMPORT is not set
> > > # CONFIG_BNXT is not set
> > > CONFIG_NET_VENDOR_BROCADE=y
> > > # CONFIG_BNA is not set
> > > CONFIG_NET_VENDOR_CADENCE=y
> > > # CONFIG_MACB is not set
> > > CONFIG_NET_VENDOR_CAVIUM=y
> > > CONFIG_NET_VENDOR_CHELSIO=y
> > > # CONFIG_CHELSIO_T1 is not set
> > > # CONFIG_CHELSIO_T3 is not set
> > > # CONFIG_CHELSIO_T4 is not set
> > > # CONFIG_CHELSIO_T4VF is not set
> > > CONFIG_NET_VENDOR_CIRRUS=y
> > > # CONFIG_CS89x0 is not set
> > > CONFIG_NET_VENDOR_CISCO=y
> > > # CONFIG_ENIC is not set
> > > CONFIG_NET_VENDOR_CORTINA=y
> > > # CONFIG_CX_ECAT is not set
> > > # CONFIG_DNET is not set
> > > CONFIG_NET_VENDOR_DEC=y
> > > # CONFIG_NET_TULIP is not set
> > > CONFIG_NET_VENDOR_DLINK=y
> > > # CONFIG_DL2K is not set
> > > # CONFIG_SUNDANCE is not set
> > > CONFIG_NET_VENDOR_EMULEX=y
> > > # CONFIG_BE2NET is not set
> > > CONFIG_NET_VENDOR_EZCHIP=y
> > > CONFIG_NET_VENDOR_GOOGLE=y
> > > # CONFIG_GVE is not set
> > > CONFIG_NET_VENDOR_HUAWEI=y
> > > # CONFIG_HINIC is not set
> > > CONFIG_NET_VENDOR_I825XX=y
> > > CONFIG_NET_VENDOR_INTEL=y
> > > # CONFIG_E100 is not set
> > > CONFIG_E1000=y
> > > # CONFIG_E1000E is not set
> > > # CONFIG_IGB is not set
> > > # CONFIG_IGBVF is not set
> > > # CONFIG_IXGB is not set
> > > # CONFIG_IXGBE is not set
> > > # CONFIG_IXGBEVF is not set
> > > # CONFIG_I40E is not set
> > > # CONFIG_I40EVF is not set
> > > # CONFIG_ICE is not set
> > > # CONFIG_FM10K is not set
> > > # CONFIG_IGC is not set
> > > # CONFIG_JME is not set
> > > CONFIG_NET_VENDOR_MARVELL=y
> > > # CONFIG_MVMDIO is not set
> > > # CONFIG_SKGE is not set
> > > # CONFIG_SKY2 is not set
> > > CONFIG_NET_VENDOR_MELLANOX=y
> > > # CONFIG_MLX4_EN is not set
> > > # CONFIG_MLX5_CORE is not set
> > > # CONFIG_MLXSW_CORE is not set
> > > # CONFIG_MLXFW is not set
> > > CONFIG_NET_VENDOR_MICREL=y
> > > # CONFIG_KS8842 is not set
> > > # CONFIG_KS8851_MLL is not set
> > > # CONFIG_KSZ884X_PCI is not set
> > > CONFIG_NET_VENDOR_MICROCHIP=y
> > > # CONFIG_LAN743X is not set
> > > CONFIG_NET_VENDOR_MICROSEMI=y
> > > CONFIG_NET_VENDOR_MYRI=y
> > > # CONFIG_MYRI10GE is not set
> > > # CONFIG_FEALNX is not set
> > > CONFIG_NET_VENDOR_NATSEMI=y
> > > # CONFIG_NATSEMI is not set
> > > # CONFIG_NS83820 is not set
> > > CONFIG_NET_VENDOR_NETERION=y
> > > # CONFIG_S2IO is not set
> > > # CONFIG_VXGE is not set
> > > CONFIG_NET_VENDOR_NETRONOME=y
> > > # CONFIG_NFP is not set
> > > CONFIG_NET_VENDOR_NI=y
> > > # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
> > > CONFIG_NET_VENDOR_8390=y
> > > # CONFIG_NE2000 is not set
> > > # CONFIG_NE2K_PCI is not set
> > > # CONFIG_ULTRA is not set
> > > # CONFIG_WD80x3 is not set
> > > CONFIG_NET_VENDOR_NVIDIA=y
> > > # CONFIG_FORCEDETH is not set
> > > CONFIG_NET_VENDOR_OKI=y
> > > # CONFIG_PCH_GBE is not set
> > > # CONFIG_ETHOC is not set
> > > CONFIG_NET_VENDOR_PACKET_ENGINES=y
> > > # CONFIG_HAMACHI is not set
> > > # CONFIG_YELLOWFIN is not set
> > > CONFIG_NET_VENDOR_PENSANDO=y
> > > CONFIG_NET_VENDOR_QLOGIC=y
> > > # CONFIG_QLA3XXX is not set
> > > # CONFIG_QLCNIC is not set
> > > # CONFIG_NETXEN_NIC is not set
> > > # CONFIG_QED is not set
> > > CONFIG_NET_VENDOR_QUALCOMM=y
> > > # CONFIG_QCOM_EMAC is not set
> > > # CONFIG_RMNET is not set
> > > CONFIG_NET_VENDOR_RDC=y
> > > # CONFIG_R6040 is not set
> > > CONFIG_NET_VENDOR_REALTEK=y
> > > # CONFIG_ATP is not set
> > > # CONFIG_8139CP is not set
> > > # CONFIG_8139TOO is not set
> > > # CONFIG_R8169 is not set
> > > CONFIG_NET_VENDOR_RENESAS=y
> > > CONFIG_NET_VENDOR_ROCKER=y
> > > CONFIG_NET_VENDOR_SAMSUNG=y
> > > # CONFIG_SXGBE_ETH is not set
> > > CONFIG_NET_VENDOR_SEEQ=y
> > > CONFIG_NET_VENDOR_SOLARFLARE=y
> > > # CONFIG_SFC is not set
> > > # CONFIG_SFC_FALCON is not set
> > > CONFIG_NET_VENDOR_SILAN=y
> > > # CONFIG_SC92031 is not set
> > > CONFIG_NET_VENDOR_SIS=y
> > > # CONFIG_SIS900 is not set
> > > # CONFIG_SIS190 is not set
> > > CONFIG_NET_VENDOR_SMSC=y
> > > # CONFIG_SMC9194 is not set
> > > # CONFIG_EPIC100 is not set
> > > # CONFIG_SMSC911X is not set
> > > # CONFIG_SMSC9420 is not set
> > > CONFIG_NET_VENDOR_SOCIONEXT=y
> > > CONFIG_NET_VENDOR_STMICRO=y
> > > # CONFIG_STMMAC_ETH is not set
> > > CONFIG_NET_VENDOR_SUN=y
> > > # CONFIG_HAPPYMEAL is not set
> > > # CONFIG_SUNGEM is not set
> > > # CONFIG_CASSINI is not set
> > > # CONFIG_NIU is not set
> > > CONFIG_NET_VENDOR_SYNOPSYS=y
> > > # CONFIG_DWC_XLGMAC is not set
> > > CONFIG_NET_VENDOR_TEHUTI=y
> > > # CONFIG_TEHUTI is not set
> > > CONFIG_NET_VENDOR_TI=y
> > > # CONFIG_TI_CPSW_PHY_SEL is not set
> > > # CONFIG_TLAN is not set
> > > CONFIG_NET_VENDOR_VIA=y
> > > # CONFIG_VIA_RHINE is not set
> > > # CONFIG_VIA_VELOCITY is not set
> > > CONFIG_NET_VENDOR_WIZNET=y
> > > # CONFIG_WIZNET_W5100 is not set
> > > # CONFIG_WIZNET_W5300 is not set
> > > CONFIG_NET_VENDOR_XILINX=y
> > > # CONFIG_XILINX_AXI_EMAC is not set
> > > # CONFIG_XILINX_LL_TEMAC is not set
> > > # CONFIG_FDDI is not set
> > > # CONFIG_HIPPI is not set
> > > # CONFIG_NET_SB1000 is not set
> > > # CONFIG_MDIO_DEVICE is not set
> > > # CONFIG_PHYLIB is not set
> > > # CONFIG_PLIP is not set
> > > # CONFIG_PPP is not set
> > > # CONFIG_SLIP is not set
> > > CONFIG_USB_NET_DRIVERS=y
> > > # CONFIG_USB_CATC is not set
> > > # CONFIG_USB_KAWETH is not set
> > > # CONFIG_USB_PEGASUS is not set
> > > # CONFIG_USB_RTL8150 is not set
> > > # CONFIG_USB_RTL8152 is not set
> > > # CONFIG_USB_LAN78XX is not set
> > > # CONFIG_USB_USBNET is not set
> > > # CONFIG_USB_IPHETH is not set
> > > CONFIG_WLAN=y
> > > CONFIG_WLAN_VENDOR_ADMTEK=y
> > > CONFIG_WLAN_VENDOR_ATH=y
> > > # CONFIG_ATH_DEBUG is not set
> > > # CONFIG_ATH5K_PCI is not set
> > > CONFIG_WLAN_VENDOR_ATMEL=y
> > > CONFIG_WLAN_VENDOR_BROADCOM=y
> > > CONFIG_WLAN_VENDOR_CISCO=y
> > > CONFIG_WLAN_VENDOR_INTEL=y
> > > CONFIG_WLAN_VENDOR_INTERSIL=y
> > > # CONFIG_HOSTAP is not set
> > > # CONFIG_PRISM54 is not set
> > > CONFIG_WLAN_VENDOR_MARVELL=y
> > > CONFIG_WLAN_VENDOR_MEDIATEK=y
> > > CONFIG_WLAN_VENDOR_RALINK=y
> > > CONFIG_WLAN_VENDOR_REALTEK=y
> > > CONFIG_WLAN_VENDOR_RSI=y
> > > CONFIG_WLAN_VENDOR_ST=y
> > > CONFIG_WLAN_VENDOR_TI=y
> > > CONFIG_WLAN_VENDOR_ZYDAS=y
> > > CONFIG_WLAN_VENDOR_QUANTENNA=y
> > > 
> > > #
> > > # Enable WiMAX (Networking options) to see the WiMAX drivers
> > > #
> > > # CONFIG_WAN is not set
> > > # CONFIG_VMXNET3 is not set
> > > # CONFIG_FUJITSU_ES is not set
> > > # CONFIG_USB4_NET is not set
> > > # CONFIG_NETDEVSIM is not set
> > > # CONFIG_NET_FAILOVER is not set
> > > # CONFIG_ISDN is not set
> > > CONFIG_NVM=y
> > > # CONFIG_NVM_PBLK is not set
> > > 
> > > #
> > > # Input device support
> > > #
> > > CONFIG_INPUT=y
> > > CONFIG_INPUT_LEDS=y
> > > CONFIG_INPUT_FF_MEMLESS=y
> > > # CONFIG_INPUT_POLLDEV is not set
> > > CONFIG_INPUT_SPARSEKMAP=m
> > > CONFIG_INPUT_MATRIXKMAP=y
> > > 
> > > #
> > > # Userland interfaces
> > > #
> > > # CONFIG_INPUT_MOUSEDEV is not set
> > > # CONFIG_INPUT_JOYDEV is not set
> > > CONFIG_INPUT_EVDEV=y
> > > CONFIG_INPUT_EVBUG=y
> > > 
> > > #
> > > # Input Device Drivers
> > > #
> > > CONFIG_INPUT_KEYBOARD=y
> > > CONFIG_KEYBOARD_ADP5520=m
> > > # CONFIG_KEYBOARD_ADP5588 is not set
> > > CONFIG_KEYBOARD_ADP5589=m
> > > CONFIG_KEYBOARD_ATKBD=y
> > > CONFIG_KEYBOARD_QT1050=y
> > > CONFIG_KEYBOARD_QT1070=m
> > > CONFIG_KEYBOARD_QT2160=m
> > > CONFIG_KEYBOARD_DLINK_DIR685=m
> > > # CONFIG_KEYBOARD_LKKBD is not set
> > > # CONFIG_KEYBOARD_GPIO is not set
> > > # CONFIG_KEYBOARD_GPIO_POLLED is not set
> > > # CONFIG_KEYBOARD_TCA6416 is not set
> > > CONFIG_KEYBOARD_TCA8418=y
> > > # CONFIG_KEYBOARD_MATRIX is not set
> > > CONFIG_KEYBOARD_LM8323=y
> > > CONFIG_KEYBOARD_LM8333=y
> > > # CONFIG_KEYBOARD_MAX7359 is not set
> > > CONFIG_KEYBOARD_MCS=y
> > > # CONFIG_KEYBOARD_MPR121 is not set
> > > # CONFIG_KEYBOARD_NEWTON is not set
> > > CONFIG_KEYBOARD_OPENCORES=m
> > > # CONFIG_KEYBOARD_SAMSUNG is not set
> > > CONFIG_KEYBOARD_STOWAWAY=y
> > > # CONFIG_KEYBOARD_SUNKBD is not set
> > > # CONFIG_KEYBOARD_IQS62X is not set
> > > CONFIG_KEYBOARD_TM2_TOUCHKEY=y
> > > # CONFIG_KEYBOARD_XTKBD is not set
> > > CONFIG_KEYBOARD_CROS_EC=m
> > > CONFIG_KEYBOARD_MTK_PMIC=m
> > > CONFIG_INPUT_MOUSE=y
> > > CONFIG_MOUSE_PS2=m
> > > CONFIG_MOUSE_PS2_ALPS=y
> > > CONFIG_MOUSE_PS2_BYD=y
> > > CONFIG_MOUSE_PS2_LOGIPS2PP=y
> > > CONFIG_MOUSE_PS2_SYNAPTICS=y
> > > CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
> > > CONFIG_MOUSE_PS2_CYPRESS=y
> > > CONFIG_MOUSE_PS2_LIFEBOOK=y
> > > CONFIG_MOUSE_PS2_TRACKPOINT=y
> > > CONFIG_MOUSE_PS2_ELANTECH=y
> > > CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
> > > # CONFIG_MOUSE_PS2_SENTELIC is not set
> > > CONFIG_MOUSE_PS2_TOUCHKIT=y
> > > CONFIG_MOUSE_PS2_FOCALTECH=y
> > > # CONFIG_MOUSE_PS2_VMMOUSE is not set
> > > CONFIG_MOUSE_PS2_SMBUS=y
> > > CONFIG_MOUSE_SERIAL=y
> > > # CONFIG_MOUSE_APPLETOUCH is not set
> > > CONFIG_MOUSE_BCM5974=y
> > > CONFIG_MOUSE_CYAPA=y
> > > CONFIG_MOUSE_ELAN_I2C=y
> > > CONFIG_MOUSE_ELAN_I2C_I2C=y
> > > # CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
> > > CONFIG_MOUSE_INPORT=m
> > > # CONFIG_MOUSE_ATIXL is not set
> > > CONFIG_MOUSE_LOGIBM=y
> > > CONFIG_MOUSE_PC110PAD=m
> > > CONFIG_MOUSE_VSXXXAA=y
> > > CONFIG_MOUSE_GPIO=y
> > > CONFIG_MOUSE_SYNAPTICS_I2C=m
> > > CONFIG_MOUSE_SYNAPTICS_USB=m
> > > CONFIG_INPUT_JOYSTICK=y
> > > # CONFIG_JOYSTICK_ANALOG is not set
> > > CONFIG_JOYSTICK_A3D=m
> > > CONFIG_JOYSTICK_ADI=y
> > > # CONFIG_JOYSTICK_COBRA is not set
> > > # CONFIG_JOYSTICK_GF2K is not set
> > > CONFIG_JOYSTICK_GRIP=y
> > > CONFIG_JOYSTICK_GRIP_MP=y
> > > # CONFIG_JOYSTICK_GUILLEMOT is not set
> > > CONFIG_JOYSTICK_INTERACT=m
> > > # CONFIG_JOYSTICK_SIDEWINDER is not set
> > > CONFIG_JOYSTICK_TMDC=m
> > > CONFIG_JOYSTICK_IFORCE=y
> > > CONFIG_JOYSTICK_IFORCE_USB=m
> > > CONFIG_JOYSTICK_IFORCE_232=y
> > > # CONFIG_JOYSTICK_WARRIOR is not set
> > > CONFIG_JOYSTICK_MAGELLAN=m
> > > CONFIG_JOYSTICK_SPACEORB=m
> > > CONFIG_JOYSTICK_SPACEBALL=m
> > > # CONFIG_JOYSTICK_STINGER is not set
> > > CONFIG_JOYSTICK_TWIDJOY=m
> > > CONFIG_JOYSTICK_ZHENHUA=y
> > > CONFIG_JOYSTICK_DB9=m
> > > CONFIG_JOYSTICK_GAMECON=m
> > > CONFIG_JOYSTICK_TURBOGRAFX=m
> > > # CONFIG_JOYSTICK_AS5011 is not set
> > > CONFIG_JOYSTICK_JOYDUMP=m
> > > CONFIG_JOYSTICK_XPAD=m
> > > CONFIG_JOYSTICK_XPAD_FF=y
> > > CONFIG_JOYSTICK_XPAD_LEDS=y
> > > # CONFIG_JOYSTICK_WALKERA0701 is not set
> > > # CONFIG_JOYSTICK_PXRC is not set
> > > # CONFIG_JOYSTICK_FSIA6B is not set
> > > CONFIG_INPUT_TABLET=y
> > > CONFIG_TABLET_USB_ACECAD=y
> > > # CONFIG_TABLET_USB_AIPTEK is not set
> > > # CONFIG_TABLET_USB_GTCO is not set
> > > # CONFIG_TABLET_USB_HANWANG is not set
> > > # CONFIG_TABLET_USB_KBTAB is not set
> > > CONFIG_TABLET_USB_PEGASUS=m
> > > CONFIG_TABLET_SERIAL_WACOM4=y
> > > CONFIG_INPUT_TOUCHSCREEN=y
> > > CONFIG_TOUCHSCREEN_PROPERTIES=y
> > > CONFIG_TOUCHSCREEN_88PM860X=m
> > > CONFIG_TOUCHSCREEN_AD7879=m
> > > CONFIG_TOUCHSCREEN_AD7879_I2C=m
> > > # CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
> > > # CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
> > > CONFIG_TOUCHSCREEN_BU21013=y
> > > # CONFIG_TOUCHSCREEN_BU21029 is not set
> > > CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=y
> > > CONFIG_TOUCHSCREEN_CY8CTMA140=m
> > > CONFIG_TOUCHSCREEN_CY8CTMG110=m
> > > CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
> > > CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
> > > CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
> > > # CONFIG_TOUCHSCREEN_CYTTSP4_I2C is not set
> > > CONFIG_TOUCHSCREEN_DYNAPRO=m
> > > # CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
> > > CONFIG_TOUCHSCREEN_EETI=m
> > > # CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
> > > CONFIG_TOUCHSCREEN_EXC3000=m
> > > CONFIG_TOUCHSCREEN_FUJITSU=y
> > > CONFIG_TOUCHSCREEN_GOODIX=y
> > > CONFIG_TOUCHSCREEN_HIDEEP=y
> > > # CONFIG_TOUCHSCREEN_ILI210X is not set
> > > CONFIG_TOUCHSCREEN_S6SY761=y
> > > # CONFIG_TOUCHSCREEN_GUNZE is not set
> > > CONFIG_TOUCHSCREEN_EKTF2127=y
> > > CONFIG_TOUCHSCREEN_ELAN=m
> > > CONFIG_TOUCHSCREEN_ELO=y
> > > CONFIG_TOUCHSCREEN_WACOM_W8001=m
> > > CONFIG_TOUCHSCREEN_WACOM_I2C=m
> > > # CONFIG_TOUCHSCREEN_MAX11801 is not set
> > > # CONFIG_TOUCHSCREEN_MCS5000 is not set
> > > CONFIG_TOUCHSCREEN_MMS114=y
> > > CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
> > > # CONFIG_TOUCHSCREEN_MTOUCH is not set
> > > CONFIG_TOUCHSCREEN_INEXIO=m
> > > # CONFIG_TOUCHSCREEN_MK712 is not set
> > > CONFIG_TOUCHSCREEN_HTCPEN=y
> > > CONFIG_TOUCHSCREEN_PENMOUNT=y
> > > CONFIG_TOUCHSCREEN_EDT_FT5X06=y
> > > # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
> > > # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
> > > CONFIG_TOUCHSCREEN_TI_AM335X_TSC=m
> > > CONFIG_TOUCHSCREEN_PIXCIR=m
> > > # CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
> > > CONFIG_TOUCHSCREEN_USB_COMPOSITE=m
> > > CONFIG_TOUCHSCREEN_MC13783=m
> > > CONFIG_TOUCHSCREEN_USB_EGALAX=y
> > > CONFIG_TOUCHSCREEN_USB_PANJIT=y
> > > CONFIG_TOUCHSCREEN_USB_3M=y
> > > CONFIG_TOUCHSCREEN_USB_ITM=y
> > > CONFIG_TOUCHSCREEN_USB_ETURBO=y
> > > CONFIG_TOUCHSCREEN_USB_GUNZE=y
> > > CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
> > > CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
> > > CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
> > > CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
> > > CONFIG_TOUCHSCREEN_USB_GOTOP=y
> > > CONFIG_TOUCHSCREEN_USB_JASTEC=y
> > > CONFIG_TOUCHSCREEN_USB_ELO=y
> > > CONFIG_TOUCHSCREEN_USB_E2I=y
> > > CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
> > > CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
> > > CONFIG_TOUCHSCREEN_USB_NEXIO=y
> > > CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
> > > # CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
> > > CONFIG_TOUCHSCREEN_TSC_SERIO=y
> > > CONFIG_TOUCHSCREEN_TSC200X_CORE=m
> > > CONFIG_TOUCHSCREEN_TSC2004=m
> > > CONFIG_TOUCHSCREEN_TSC2007=y
> > > CONFIG_TOUCHSCREEN_RM_TS=y
> > > CONFIG_TOUCHSCREEN_SILEAD=m
> > > CONFIG_TOUCHSCREEN_SIS_I2C=m
> > > # CONFIG_TOUCHSCREEN_ST1232 is not set
> > > CONFIG_TOUCHSCREEN_STMFTS=y
> > > CONFIG_TOUCHSCREEN_SX8654=y
> > > CONFIG_TOUCHSCREEN_TPS6507X=m
> > > CONFIG_TOUCHSCREEN_ZET6223=y
> > > CONFIG_TOUCHSCREEN_ZFORCE=y
> > > CONFIG_TOUCHSCREEN_ROHM_BU21023=m
> > > # CONFIG_TOUCHSCREEN_IQS5XX is not set
> > > # CONFIG_INPUT_MISC is not set
> > > CONFIG_RMI4_CORE=m
> > > # CONFIG_RMI4_I2C is not set
> > > CONFIG_RMI4_SMB=m
> > > # CONFIG_RMI4_F03 is not set
> > > CONFIG_RMI4_2D_SENSOR=y
> > > CONFIG_RMI4_F11=y
> > > CONFIG_RMI4_F12=y
> > > # CONFIG_RMI4_F30 is not set
> > > # CONFIG_RMI4_F34 is not set
> > > # CONFIG_RMI4_F55 is not set
> > > 
> > > #
> > > # Hardware I/O ports
> > > #
> > > CONFIG_SERIO=y
> > > CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> > > CONFIG_SERIO_I8042=y
> > > CONFIG_SERIO_SERPORT=y
> > > CONFIG_SERIO_CT82C710=m
> > > # CONFIG_SERIO_PARKBD is not set
> > > CONFIG_SERIO_PCIPS2=y
> > > CONFIG_SERIO_LIBPS2=y
> > > CONFIG_SERIO_RAW=y
> > > # CONFIG_SERIO_ALTERA_PS2 is not set
> > > # CONFIG_SERIO_PS2MULT is not set
> > > CONFIG_SERIO_ARC_PS2=m
> > > CONFIG_SERIO_GPIO_PS2=y
> > > CONFIG_USERIO=y
> > > CONFIG_GAMEPORT=y
> > > CONFIG_GAMEPORT_NS558=m
> > > CONFIG_GAMEPORT_L4=y
> > > # CONFIG_GAMEPORT_EMU10K1 is not set
> > > # CONFIG_GAMEPORT_FM801 is not set
> > > # end of Hardware I/O ports
> > > # end of Input device support
> > > 
> > > #
> > > # Character devices
> > > #
> > > CONFIG_TTY=y
> > > CONFIG_VT=y
> > > CONFIG_CONSOLE_TRANSLATIONS=y
> > > CONFIG_VT_CONSOLE=y
> > > CONFIG_VT_CONSOLE_SLEEP=y
> > > CONFIG_HW_CONSOLE=y
> > > CONFIG_VT_HW_CONSOLE_BINDING=y
> > > CONFIG_UNIX98_PTYS=y
> > > # CONFIG_LEGACY_PTYS is not set
> > > # CONFIG_LDISC_AUTOLOAD is not set
> > > 
> > > #
> > > # Serial drivers
> > > #
> > > CONFIG_SERIAL_EARLYCON=y
> > > CONFIG_SERIAL_8250=y
> > > CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
> > > CONFIG_SERIAL_8250_PNP=y
> > > # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> > > CONFIG_SERIAL_8250_FINTEK=y
> > > CONFIG_SERIAL_8250_CONSOLE=y
> > > CONFIG_SERIAL_8250_DMA=y
> > > # CONFIG_SERIAL_8250_PCI is not set
> > > CONFIG_SERIAL_8250_MEN_MCB=m
> > > CONFIG_SERIAL_8250_NR_UARTS=4
> > > CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> > > CONFIG_SERIAL_8250_EXTENDED=y
> > > # CONFIG_SERIAL_8250_MANY_PORTS is not set
> > > CONFIG_SERIAL_8250_SHARE_IRQ=y
> > > # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> > > CONFIG_SERIAL_8250_RSA=y
> > > # CONFIG_SERIAL_8250_DW is not set
> > > CONFIG_SERIAL_8250_RT288X=y
> > > # CONFIG_SERIAL_8250_LPSS is not set
> > > CONFIG_SERIAL_8250_MID=m
> > > 
> > > #
> > > # Non-8250 serial port support
> > > #
> > > # CONFIG_SERIAL_UARTLITE is not set
> > > CONFIG_SERIAL_CORE=y
> > > CONFIG_SERIAL_CORE_CONSOLE=y
> > > CONFIG_SERIAL_JSM=m
> > > CONFIG_SERIAL_LANTIQ=m
> > > # CONFIG_SERIAL_SCCNXP is not set
> > > CONFIG_SERIAL_SC16IS7XX_CORE=m
> > > CONFIG_SERIAL_SC16IS7XX=m
> > > CONFIG_SERIAL_SC16IS7XX_I2C=y
> > > # CONFIG_SERIAL_TIMBERDALE is not set
> > > CONFIG_SERIAL_ALTERA_JTAGUART=m
> > > CONFIG_SERIAL_ALTERA_UART=m
> > > CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
> > > CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
> > > CONFIG_SERIAL_PCH_UART=y
> > > CONFIG_SERIAL_PCH_UART_CONSOLE=y
> > > # CONFIG_SERIAL_ARC is not set
> > > CONFIG_SERIAL_RP2=y
> > > CONFIG_SERIAL_RP2_NR_UARTS=32
> > > CONFIG_SERIAL_FSL_LPUART=y
> > > # CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
> > > CONFIG_SERIAL_FSL_LINFLEXUART=m
> > > CONFIG_SERIAL_MEN_Z135=m
> > > CONFIG_SERIAL_SPRD=m
> > > # end of Serial drivers
> > > 
> > > CONFIG_SERIAL_MCTRL_GPIO=y
> > > # CONFIG_SERIAL_NONSTANDARD is not set
> > > # CONFIG_N_GSM is not set
> > > CONFIG_NOZOMI=m
> > > # CONFIG_NULL_TTY is not set
> > > # CONFIG_TRACE_ROUTER is not set
> > > CONFIG_TRACE_SINK=m
> > > CONFIG_HVC_DRIVER=y
> > > # CONFIG_SERIAL_DEV_BUS is not set
> > > CONFIG_PRINTER=m
> > > CONFIG_LP_CONSOLE=y
> > > # CONFIG_PPDEV is not set
> > > CONFIG_VIRTIO_CONSOLE=y
> > > CONFIG_IPMI_HANDLER=m
> > > CONFIG_IPMI_DMI_DECODE=y
> > > CONFIG_IPMI_PLAT_DATA=y
> > > CONFIG_IPMI_PANIC_EVENT=y
> > > # CONFIG_IPMI_PANIC_STRING is not set
> > > CONFIG_IPMI_DEVICE_INTERFACE=m
> > > CONFIG_IPMI_SI=m
> > > # CONFIG_IPMI_SSIF is not set
> > > CONFIG_IPMI_WATCHDOG=m
> > > # CONFIG_IPMI_POWEROFF is not set
> > > CONFIG_IPMB_DEVICE_INTERFACE=y
> > > CONFIG_HW_RANDOM=m
> > > CONFIG_HW_RANDOM_TIMERIOMEM=m
> > > # CONFIG_HW_RANDOM_INTEL is not set
> > > # CONFIG_HW_RANDOM_AMD is not set
> > > CONFIG_HW_RANDOM_GEODE=m
> > > # CONFIG_HW_RANDOM_VIA is not set
> > > CONFIG_HW_RANDOM_VIRTIO=m
> > > CONFIG_DTLK=y
> > > CONFIG_APPLICOM=m
> > > CONFIG_SONYPI=y
> > > CONFIG_MWAVE=m
> > > CONFIG_SCx200_GPIO=y
> > > CONFIG_PC8736x_GPIO=y
> > > CONFIG_NSC_GPIO=y
> > > CONFIG_DEVMEM=y
> > > CONFIG_DEVKMEM=y
> > > CONFIG_NVRAM=y
> > > CONFIG_RAW_DRIVER=m
> > > CONFIG_MAX_RAW_DEVS=256
> > > CONFIG_DEVPORT=y
> > > # CONFIG_HPET is not set
> > > CONFIG_HANGCHECK_TIMER=y
> > > CONFIG_TCG_TPM=y
> > > CONFIG_TCG_TIS_CORE=y
> > > CONFIG_TCG_TIS=y
> > > # CONFIG_TCG_TIS_I2C_ATMEL is not set
> > > CONFIG_TCG_TIS_I2C_INFINEON=y
> > > # CONFIG_TCG_TIS_I2C_NUVOTON is not set
> > > CONFIG_TCG_NSC=m
> > > # CONFIG_TCG_ATMEL is not set
> > > # CONFIG_TCG_INFINEON is not set
> > > CONFIG_TCG_CRB=y
> > > CONFIG_TCG_VTPM_PROXY=m
> > > CONFIG_TCG_TIS_ST33ZP24=y
> > > CONFIG_TCG_TIS_ST33ZP24_I2C=y
> > > # CONFIG_TELCLOCK is not set
> > > CONFIG_XILLYBUS=m
> > > CONFIG_XILLYBUS_PCIE=m
> > > # end of Character devices
> > > 
> > > # CONFIG_RANDOM_TRUST_CPU is not set
> > > # CONFIG_RANDOM_TRUST_BOOTLOADER is not set
> > > 
> > > #
> > > # I2C support
> > > #
> > > CONFIG_I2C=y
> > > CONFIG_ACPI_I2C_OPREGION=y
> > > CONFIG_I2C_BOARDINFO=y
> > > # CONFIG_I2C_COMPAT is not set
> > > # CONFIG_I2C_CHARDEV is not set
> > > CONFIG_I2C_MUX=m
> > > 
> > > #
> > > # Multiplexer I2C Chip support
> > > #
> > > CONFIG_I2C_MUX_GPIO=m
> > > CONFIG_I2C_MUX_LTC4306=m
> > > # CONFIG_I2C_MUX_PCA9541 is not set
> > > CONFIG_I2C_MUX_PCA954x=m
> > > # CONFIG_I2C_MUX_REG is not set
> > > # CONFIG_I2C_MUX_MLXCPLD is not set
> > > # end of Multiplexer I2C Chip support
> > > 
> > > CONFIG_I2C_HELPER_AUTO=y
> > > CONFIG_I2C_SMBUS=y
> > > CONFIG_I2C_ALGOBIT=y
> > > CONFIG_I2C_ALGOPCF=y
> > > CONFIG_I2C_ALGOPCA=m
> > > 
> > > #
> > > # I2C Hardware Bus support
> > > #
> > > 
> > > #
> > > # PC SMBus host controller drivers
> > > #
> > > # CONFIG_I2C_ALI1535 is not set
> > > # CONFIG_I2C_ALI1563 is not set
> > > CONFIG_I2C_ALI15X3=y
> > > CONFIG_I2C_AMD756=y
> > > # CONFIG_I2C_AMD756_S4882 is not set
> > > # CONFIG_I2C_AMD8111 is not set
> > > CONFIG_I2C_AMD_MP2=y
> > > CONFIG_I2C_I801=y
> > > CONFIG_I2C_ISCH=y
> > > CONFIG_I2C_ISMT=y
> > > # CONFIG_I2C_PIIX4 is not set
> > > # CONFIG_I2C_NFORCE2 is not set
> > > # CONFIG_I2C_NVIDIA_GPU is not set
> > > # CONFIG_I2C_SIS5595 is not set
> > > # CONFIG_I2C_SIS630 is not set
> > > # CONFIG_I2C_SIS96X is not set
> > > # CONFIG_I2C_VIA is not set
> > > # CONFIG_I2C_VIAPRO is not set
> > > 
> > > #
> > > # ACPI drivers
> > > #
> > > # CONFIG_I2C_SCMI is not set
> > > 
> > > #
> > > # I2C system bus drivers (mostly embedded / system-on-chip)
> > > #
> > > CONFIG_I2C_CBUS_GPIO=m
> > > CONFIG_I2C_DESIGNWARE_CORE=y
> > > # CONFIG_I2C_DESIGNWARE_SLAVE is not set
> > > CONFIG_I2C_DESIGNWARE_PLATFORM=y
> > > CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
> > > CONFIG_I2C_DESIGNWARE_PCI=m
> > > # CONFIG_I2C_EG20T is not set
> > > # CONFIG_I2C_EMEV2 is not set
> > > CONFIG_I2C_GPIO=y
> > > CONFIG_I2C_GPIO_FAULT_INJECTOR=y
> > > CONFIG_I2C_KEMPLD=y
> > > CONFIG_I2C_OCORES=m
> > > # CONFIG_I2C_PCA_PLATFORM is not set
> > > CONFIG_I2C_SIMTEC=y
> > > CONFIG_I2C_XILINX=y
> > > 
> > > #
> > > # External I2C/SMBus adapter drivers
> > > #
> > > CONFIG_I2C_DIOLAN_U2C=m
> > > # CONFIG_I2C_DLN2 is not set
> > > CONFIG_I2C_PARPORT=y
> > > CONFIG_I2C_ROBOTFUZZ_OSIF=y
> > > # CONFIG_I2C_TAOS_EVM is not set
> > > CONFIG_I2C_TINY_USB=m
> > > # CONFIG_I2C_VIPERBOARD is not set
> > > 
> > > #
> > > # Other I2C/SMBus bus drivers
> > > #
> > > CONFIG_I2C_ELEKTOR=y
> > > CONFIG_I2C_PCA_ISA=m
> > > CONFIG_I2C_CROS_EC_TUNNEL=y
> > > CONFIG_SCx200_ACB=y
> > > # end of I2C Hardware Bus support
> > > 
> > > CONFIG_I2C_STUB=m
> > > CONFIG_I2C_SLAVE=y
> > > # CONFIG_I2C_SLAVE_EEPROM is not set
> > > # CONFIG_I2C_DEBUG_CORE is not set
> > > # CONFIG_I2C_DEBUG_ALGO is not set
> > > # CONFIG_I2C_DEBUG_BUS is not set
> > > # end of I2C support
> > > 
> > > CONFIG_I3C=m
> > > CONFIG_CDNS_I3C_MASTER=m
> > > CONFIG_DW_I3C_MASTER=m
> > > # CONFIG_SPI is not set
> > > # CONFIG_SPMI is not set
> > > # CONFIG_HSI is not set
> > > CONFIG_PPS=y
> > > # CONFIG_PPS_DEBUG is not set
> > > 
> > > #
> > > # PPS clients support
> > > #
> > > CONFIG_PPS_CLIENT_KTIMER=y
> > > CONFIG_PPS_CLIENT_LDISC=y
> > > CONFIG_PPS_CLIENT_PARPORT=y
> > > CONFIG_PPS_CLIENT_GPIO=y
> > > 
> > > #
> > > # PPS generators support
> > > #
> > > 
> > > #
> > > # PTP clock support
> > > #
> > > # CONFIG_PTP_1588_CLOCK is not set
> > > 
> > > #
> > > # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> > > #
> > > # CONFIG_PTP_1588_CLOCK_PCH is not set
> > > # end of PTP clock support
> > > 
> > > CONFIG_PINCTRL=y
> > > CONFIG_PINMUX=y
> > > CONFIG_PINCONF=y
> > > CONFIG_GENERIC_PINCONF=y
> > > CONFIG_DEBUG_PINCTRL=y
> > > # CONFIG_PINCTRL_AMD is not set
> > > # CONFIG_PINCTRL_DA9062 is not set
> > > CONFIG_PINCTRL_MCP23S08_I2C=m
> > > CONFIG_PINCTRL_MCP23S08=m
> > > # CONFIG_PINCTRL_SX150X is not set
> > > # CONFIG_PINCTRL_BAYTRAIL is not set
> > > CONFIG_PINCTRL_CHERRYVIEW=m
> > > CONFIG_PINCTRL_LYNXPOINT=y
> > > CONFIG_PINCTRL_INTEL=y
> > > CONFIG_PINCTRL_BROXTON=m
> > > CONFIG_PINCTRL_CANNONLAKE=y
> > > # CONFIG_PINCTRL_CEDARFORK is not set
> > > CONFIG_PINCTRL_DENVERTON=m
> > > CONFIG_PINCTRL_GEMINILAKE=y
> > > # CONFIG_PINCTRL_ICELAKE is not set
> > > # CONFIG_PINCTRL_JASPERLAKE is not set
> > > CONFIG_PINCTRL_LEWISBURG=m
> > > CONFIG_PINCTRL_SUNRISEPOINT=m
> > > CONFIG_PINCTRL_TIGERLAKE=y
> > > CONFIG_PINCTRL_MADERA=y
> > > CONFIG_PINCTRL_CS47L85=y
> > > CONFIG_PINCTRL_CS47L92=y
> > > CONFIG_GPIOLIB=y
> > > CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> > > CONFIG_GPIO_ACPI=y
> > > CONFIG_GPIOLIB_IRQCHIP=y
> > > CONFIG_DEBUG_GPIO=y
> > > CONFIG_GPIO_SYSFS=y
> > > CONFIG_GPIO_GENERIC=m
> > > CONFIG_GPIO_MAX730X=m
> > > 
> > > #
> > > # Memory mapped GPIO drivers
> > > #
> > > CONFIG_GPIO_AMDPT=m
> > > # CONFIG_GPIO_DWAPB is not set
> > > CONFIG_GPIO_GENERIC_PLATFORM=m
> > > CONFIG_GPIO_ICH=y
> > > CONFIG_GPIO_MB86S7X=m
> > > # CONFIG_GPIO_MENZ127 is not set
> > > CONFIG_GPIO_SIOX=m
> > > CONFIG_GPIO_VX855=m
> > > # CONFIG_GPIO_XILINX is not set
> > > CONFIG_GPIO_AMD_FCH=y
> > > # end of Memory mapped GPIO drivers
> > > 
> > > #
> > > # Port-mapped I/O GPIO drivers
> > > #
> > > CONFIG_GPIO_F7188X=y
> > > CONFIG_GPIO_IT87=y
> > > # CONFIG_GPIO_SCH is not set
> > > # CONFIG_GPIO_SCH311X is not set
> > > CONFIG_GPIO_WINBOND=y
> > > CONFIG_GPIO_WS16C48=y
> > > # end of Port-mapped I/O GPIO drivers
> > > 
> > > #
> > > # I2C GPIO expanders
> > > #
> > > CONFIG_GPIO_ADP5588=y
> > > # CONFIG_GPIO_ADP5588_IRQ is not set
> > > CONFIG_GPIO_MAX7300=m
> > > CONFIG_GPIO_MAX732X=m
> > > # CONFIG_GPIO_PCA953X is not set
> > > CONFIG_GPIO_PCF857X=m
> > > CONFIG_GPIO_TPIC2810=m
> > > # end of I2C GPIO expanders
> > > 
> > > #
> > > # MFD GPIO expanders
> > > #
> > > # CONFIG_GPIO_ADP5520 is not set
> > > CONFIG_GPIO_ARIZONA=y
> > > CONFIG_GPIO_BD9571MWV=m
> > > CONFIG_GPIO_CRYSTAL_COVE=y
> > > # CONFIG_GPIO_DA9055 is not set
> > > CONFIG_GPIO_DLN2=m
> > > CONFIG_GPIO_JANZ_TTL=m
> > > CONFIG_GPIO_KEMPLD=y
> > > CONFIG_GPIO_MADERA=m
> > > # CONFIG_GPIO_PALMAS is not set
> > > CONFIG_GPIO_TIMBERDALE=y
> > > # CONFIG_GPIO_TPS65086 is not set
> > > # CONFIG_GPIO_TPS65912 is not set
> > > # CONFIG_GPIO_TWL6040 is not set
> > > CONFIG_GPIO_WM8350=m
> > > # CONFIG_GPIO_WM8994 is not set
> > > # end of MFD GPIO expanders
> > > 
> > > #
> > > # PCI GPIO expanders
> > > #
> > > CONFIG_GPIO_AMD8111=y
> > > # CONFIG_GPIO_BT8XX is not set
> > > CONFIG_GPIO_ML_IOH=y
> > > CONFIG_GPIO_PCH=y
> > > CONFIG_GPIO_PCI_IDIO_16=m
> > > # CONFIG_GPIO_PCIE_IDIO_24 is not set
> > > CONFIG_GPIO_RDC321X=m
> > > # end of PCI GPIO expanders
> > > 
> > > #
> > > # USB GPIO expanders
> > > #
> > > CONFIG_GPIO_VIPERBOARD=m
> > > # end of USB GPIO expanders
> > > 
> > > # CONFIG_GPIO_AGGREGATOR is not set
> > > # CONFIG_GPIO_MOCKUP is not set
> > > CONFIG_W1=y
> > > 
> > > #
> > > # 1-wire Bus Masters
> > > #
> > > CONFIG_W1_MASTER_MATROX=y
> > > # CONFIG_W1_MASTER_DS2490 is not set
> > > CONFIG_W1_MASTER_DS2482=m
> > > CONFIG_W1_MASTER_DS1WM=y
> > > CONFIG_W1_MASTER_GPIO=m
> > > CONFIG_W1_MASTER_SGI=m
> > > # end of 1-wire Bus Masters
> > > 
> > > #
> > > # 1-wire Slaves
> > > #
> > > # CONFIG_W1_SLAVE_THERM is not set
> > > # CONFIG_W1_SLAVE_SMEM is not set
> > > # CONFIG_W1_SLAVE_DS2405 is not set
> > > CONFIG_W1_SLAVE_DS2408=m
> > > # CONFIG_W1_SLAVE_DS2408_READBACK is not set
> > > CONFIG_W1_SLAVE_DS2413=y
> > > CONFIG_W1_SLAVE_DS2406=m
> > > # CONFIG_W1_SLAVE_DS2423 is not set
> > > CONFIG_W1_SLAVE_DS2805=m
> > > CONFIG_W1_SLAVE_DS2430=y
> > > CONFIG_W1_SLAVE_DS2431=y
> > > CONFIG_W1_SLAVE_DS2433=y
> > > CONFIG_W1_SLAVE_DS2433_CRC=y
> > > # CONFIG_W1_SLAVE_DS2438 is not set
> > > # CONFIG_W1_SLAVE_DS250X is not set
> > > CONFIG_W1_SLAVE_DS2780=y
> > > CONFIG_W1_SLAVE_DS2781=m
> > > # CONFIG_W1_SLAVE_DS28E04 is not set
> > > # CONFIG_W1_SLAVE_DS28E17 is not set
> > > # end of 1-wire Slaves
> > > 
> > > CONFIG_POWER_AVS=y
> > > # CONFIG_QCOM_CPR is not set
> > > CONFIG_POWER_RESET=y
> > > CONFIG_POWER_RESET_MT6323=y
> > > CONFIG_POWER_RESET_RESTART=y
> > > CONFIG_POWER_SUPPLY=y
> > > # CONFIG_POWER_SUPPLY_DEBUG is not set
> > > CONFIG_POWER_SUPPLY_HWMON=y
> > > # CONFIG_PDA_POWER is not set
> > > CONFIG_WM8350_POWER=m
> > > # CONFIG_TEST_POWER is not set
> > > # CONFIG_BATTERY_88PM860X is not set
> > > CONFIG_CHARGER_ADP5061=m
> > > CONFIG_BATTERY_CW2015=y
> > > CONFIG_BATTERY_DS2760=m
> > > CONFIG_BATTERY_DS2780=y
> > > CONFIG_BATTERY_DS2781=m
> > > CONFIG_BATTERY_DS2782=y
> > > # CONFIG_BATTERY_SBS is not set
> > > CONFIG_CHARGER_SBS=m
> > > CONFIG_MANAGER_SBS=m
> > > # CONFIG_BATTERY_BQ27XXX is not set
> > > CONFIG_BATTERY_DA9150=m
> > > # CONFIG_AXP288_CHARGER is not set
> > > # CONFIG_BATTERY_MAX17040 is not set
> > > # CONFIG_BATTERY_MAX17042 is not set
> > > CONFIG_BATTERY_MAX1721X=y
> > > CONFIG_CHARGER_ISP1704=m
> > > CONFIG_CHARGER_MAX8903=y
> > > CONFIG_CHARGER_LP8727=m
> > > CONFIG_CHARGER_GPIO=y
> > > CONFIG_CHARGER_MANAGER=y
> > > CONFIG_CHARGER_LT3651=y
> > > CONFIG_CHARGER_MAX14577=y
> > > CONFIG_CHARGER_MAX77693=m
> > > # CONFIG_CHARGER_BQ2415X is not set
> > > CONFIG_CHARGER_BQ24190=y
> > > # CONFIG_CHARGER_BQ24257 is not set
> > > # CONFIG_CHARGER_BQ24735 is not set
> > > CONFIG_CHARGER_BQ25890=m
> > > # CONFIG_CHARGER_SMB347 is not set
> > > CONFIG_BATTERY_GAUGE_LTC2941=y
> > > CONFIG_BATTERY_RT5033=m
> > > CONFIG_CHARGER_RT9455=y
> > > CONFIG_CHARGER_CROS_USBPD=m
> > > CONFIG_CHARGER_BD99954=y
> > > CONFIG_CHARGER_WILCO=m
> > > CONFIG_HWMON=y
> > > CONFIG_HWMON_VID=y
> > > CONFIG_HWMON_DEBUG_CHIP=y
> > > 
> > > #
> > > # Native drivers
> > > #
> > > CONFIG_SENSORS_ABITUGURU=y
> > > CONFIG_SENSORS_ABITUGURU3=y
> > > # CONFIG_SENSORS_AD7414 is not set
> > > CONFIG_SENSORS_AD7418=y
> > > CONFIG_SENSORS_ADM1021=y
> > > CONFIG_SENSORS_ADM1025=y
> > > CONFIG_SENSORS_ADM1026=m
> > > # CONFIG_SENSORS_ADM1029 is not set
> > > CONFIG_SENSORS_ADM1031=y
> > > # CONFIG_SENSORS_ADM1177 is not set
> > > CONFIG_SENSORS_ADM9240=y
> > > CONFIG_SENSORS_ADT7X10=y
> > > CONFIG_SENSORS_ADT7410=y
> > > CONFIG_SENSORS_ADT7411=y
> > > CONFIG_SENSORS_ADT7462=m
> > > CONFIG_SENSORS_ADT7470=y
> > > # CONFIG_SENSORS_ADT7475 is not set
> > > CONFIG_SENSORS_AS370=m
> > > CONFIG_SENSORS_ASC7621=y
> > > CONFIG_SENSORS_AXI_FAN_CONTROL=m
> > > # CONFIG_SENSORS_K8TEMP is not set
> > > # CONFIG_SENSORS_K10TEMP is not set
> > > CONFIG_SENSORS_FAM15H_POWER=y
> > > # CONFIG_SENSORS_AMD_ENERGY is not set
> > > CONFIG_SENSORS_APPLESMC=m
> > > CONFIG_SENSORS_ASB100=y
> > > CONFIG_SENSORS_ASPEED=y
> > > CONFIG_SENSORS_ATXP1=m
> > > CONFIG_SENSORS_DS620=m
> > > # CONFIG_SENSORS_DS1621 is not set
> > > CONFIG_SENSORS_DELL_SMM=y
> > > CONFIG_SENSORS_DA9055=m
> > > CONFIG_SENSORS_I5K_AMB=m
> > > CONFIG_SENSORS_F71805F=m
> > > # CONFIG_SENSORS_F71882FG is not set
> > > # CONFIG_SENSORS_F75375S is not set
> > > CONFIG_SENSORS_MC13783_ADC=m
> > > CONFIG_SENSORS_FSCHMD=m
> > > # CONFIG_SENSORS_FTSTEUTATES is not set
> > > # CONFIG_SENSORS_GL518SM is not set
> > > CONFIG_SENSORS_GL520SM=m
> > > CONFIG_SENSORS_G760A=m
> > > CONFIG_SENSORS_G762=y
> > > CONFIG_SENSORS_HIH6130=m
> > > CONFIG_SENSORS_IBMAEM=m
> > > CONFIG_SENSORS_IBMPEX=m
> > > # CONFIG_SENSORS_I5500 is not set
> > > CONFIG_SENSORS_CORETEMP=m
> > > # CONFIG_SENSORS_IT87 is not set
> > > CONFIG_SENSORS_JC42=y
> > > CONFIG_SENSORS_POWR1220=m
> > > # CONFIG_SENSORS_LINEAGE is not set
> > > CONFIG_SENSORS_LTC2945=m
> > > CONFIG_SENSORS_LTC2947=m
> > > CONFIG_SENSORS_LTC2947_I2C=m
> > > CONFIG_SENSORS_LTC2990=y
> > > CONFIG_SENSORS_LTC4151=m
> > > CONFIG_SENSORS_LTC4215=y
> > > # CONFIG_SENSORS_LTC4222 is not set
> > > CONFIG_SENSORS_LTC4245=m
> > > CONFIG_SENSORS_LTC4260=m
> > > CONFIG_SENSORS_LTC4261=y
> > > # CONFIG_SENSORS_MAX16065 is not set
> > > CONFIG_SENSORS_MAX1619=y
> > > # CONFIG_SENSORS_MAX1668 is not set
> > > CONFIG_SENSORS_MAX197=m
> > > CONFIG_SENSORS_MAX31730=m
> > > CONFIG_SENSORS_MAX6621=m
> > > CONFIG_SENSORS_MAX6639=y
> > > # CONFIG_SENSORS_MAX6642 is not set
> > > # CONFIG_SENSORS_MAX6650 is not set
> > > CONFIG_SENSORS_MAX6697=m
> > > CONFIG_SENSORS_MAX31790=y
> > > # CONFIG_SENSORS_MCP3021 is not set
> > > CONFIG_SENSORS_MLXREG_FAN=y
> > > # CONFIG_SENSORS_TC654 is not set
> > > # CONFIG_SENSORS_MENF21BMC_HWMON is not set
> > > CONFIG_SENSORS_LM63=m
> > > CONFIG_SENSORS_LM73=y
> > > # CONFIG_SENSORS_LM75 is not set
> > > # CONFIG_SENSORS_LM77 is not set
> > > CONFIG_SENSORS_LM78=m
> > > CONFIG_SENSORS_LM80=y
> > > # CONFIG_SENSORS_LM83 is not set
> > > CONFIG_SENSORS_LM85=m
> > > # CONFIG_SENSORS_LM87 is not set
> > > CONFIG_SENSORS_LM90=y
> > > CONFIG_SENSORS_LM92=m
> > > # CONFIG_SENSORS_LM93 is not set
> > > # CONFIG_SENSORS_LM95234 is not set
> > > CONFIG_SENSORS_LM95241=y
> > > # CONFIG_SENSORS_LM95245 is not set
> > > CONFIG_SENSORS_PC87360=m
> > > CONFIG_SENSORS_PC87427=y
> > > CONFIG_SENSORS_NTC_THERMISTOR=y
> > > CONFIG_SENSORS_NCT6683=m
> > > # CONFIG_SENSORS_NCT6775 is not set
> > > CONFIG_SENSORS_NCT7802=y
> > > CONFIG_SENSORS_NCT7904=y
> > > # CONFIG_SENSORS_NPCM7XX is not set
> > > # CONFIG_SENSORS_PCF8591 is not set
> > > CONFIG_PMBUS=y
> > > # CONFIG_SENSORS_PMBUS is not set
> > > # CONFIG_SENSORS_ADM1275 is not set
> > > CONFIG_SENSORS_BEL_PFE=m
> > > CONFIG_SENSORS_IBM_CFFPS=y
> > > CONFIG_SENSORS_INSPUR_IPSPS=m
> > > CONFIG_SENSORS_IR35221=m
> > > CONFIG_SENSORS_IR38064=y
> > > # CONFIG_SENSORS_IRPS5401 is not set
> > > # CONFIG_SENSORS_ISL68137 is not set
> > > CONFIG_SENSORS_LM25066=m
> > > # CONFIG_SENSORS_LTC2978 is not set
> > > # CONFIG_SENSORS_LTC3815 is not set
> > > CONFIG_SENSORS_MAX16064=y
> > > # CONFIG_SENSORS_MAX16601 is not set
> > > CONFIG_SENSORS_MAX20730=m
> > > CONFIG_SENSORS_MAX20751=y
> > > # CONFIG_SENSORS_MAX31785 is not set
> > > CONFIG_SENSORS_MAX34440=y
> > > # CONFIG_SENSORS_MAX8688 is not set
> > > CONFIG_SENSORS_PXE1610=m
> > > # CONFIG_SENSORS_TPS40422 is not set
> > > CONFIG_SENSORS_TPS53679=m
> > > CONFIG_SENSORS_UCD9000=y
> > > # CONFIG_SENSORS_UCD9200 is not set
> > > CONFIG_SENSORS_XDPE122=y
> > > CONFIG_SENSORS_ZL6100=m
> > > CONFIG_SENSORS_SHT15=y
> > > # CONFIG_SENSORS_SHT21 is not set
> > > CONFIG_SENSORS_SHT3x=m
> > > # CONFIG_SENSORS_SHTC1 is not set
> > > CONFIG_SENSORS_SIS5595=m
> > > CONFIG_SENSORS_DME1737=m
> > > CONFIG_SENSORS_EMC1403=y
> > > CONFIG_SENSORS_EMC2103=m
> > > # CONFIG_SENSORS_EMC6W201 is not set
> > > CONFIG_SENSORS_SMSC47M1=y
> > > CONFIG_SENSORS_SMSC47M192=y
> > > CONFIG_SENSORS_SMSC47B397=m
> > > CONFIG_SENSORS_SCH56XX_COMMON=m
> > > CONFIG_SENSORS_SCH5627=m
> > > # CONFIG_SENSORS_SCH5636 is not set
> > > # CONFIG_SENSORS_STTS751 is not set
> > > # CONFIG_SENSORS_SMM665 is not set
> > > CONFIG_SENSORS_ADC128D818=y
> > > CONFIG_SENSORS_ADS7828=m
> > > CONFIG_SENSORS_AMC6821=m
> > > CONFIG_SENSORS_INA209=y
> > > CONFIG_SENSORS_INA2XX=y
> > > # CONFIG_SENSORS_INA3221 is not set
> > > # CONFIG_SENSORS_TC74 is not set
> > > # CONFIG_SENSORS_THMC50 is not set
> > > CONFIG_SENSORS_TMP102=m
> > > # CONFIG_SENSORS_TMP103 is not set
> > > CONFIG_SENSORS_TMP108=y
> > > # CONFIG_SENSORS_TMP401 is not set
> > > # CONFIG_SENSORS_TMP421 is not set
> > > CONFIG_SENSORS_TMP513=m
> > > CONFIG_SENSORS_VIA_CPUTEMP=m
> > > CONFIG_SENSORS_VIA686A=y
> > > # CONFIG_SENSORS_VT1211 is not set
> > > CONFIG_SENSORS_VT8231=m
> > > CONFIG_SENSORS_W83773G=m
> > > CONFIG_SENSORS_W83781D=y
> > > CONFIG_SENSORS_W83791D=y
> > > # CONFIG_SENSORS_W83792D is not set
> > > CONFIG_SENSORS_W83793=y
> > > CONFIG_SENSORS_W83795=y
> > > # CONFIG_SENSORS_W83795_FANCTRL is not set
> > > # CONFIG_SENSORS_W83L785TS is not set
> > > # CONFIG_SENSORS_W83L786NG is not set
> > > # CONFIG_SENSORS_W83627HF is not set
> > > CONFIG_SENSORS_W83627EHF=y
> > > # CONFIG_SENSORS_WM8350 is not set
> > > 
> > > #
> > > # ACPI drivers
> > > #
> > > CONFIG_SENSORS_ACPI_POWER=y
> > > CONFIG_SENSORS_ATK0110=m
> > > CONFIG_THERMAL=y
> > > CONFIG_THERMAL_STATISTICS=y
> > > CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> > > # CONFIG_THERMAL_HWMON is not set
> > > CONFIG_THERMAL_WRITABLE_TRIPS=y
> > > # CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
> > > # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> > > CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
> > > # CONFIG_THERMAL_GOV_FAIR_SHARE is not set
> > > # CONFIG_THERMAL_GOV_STEP_WISE is not set
> > > # CONFIG_THERMAL_GOV_BANG_BANG is not set
> > > CONFIG_THERMAL_GOV_USER_SPACE=y
> > > # CONFIG_THERMAL_EMULATION is not set
> > > 
> > > #
> > > # Intel thermal drivers
> > > #
> > > # CONFIG_INTEL_POWERCLAMP is not set
> > > CONFIG_X86_PKG_TEMP_THERMAL=m
> > > # CONFIG_INTEL_SOC_DTS_THERMAL is not set
> > > 
> > > #
> > > # ACPI INT340X thermal drivers
> > > #
> > > # CONFIG_INT340X_THERMAL is not set
> > > # end of ACPI INT340X thermal drivers
> > > 
> > > CONFIG_INTEL_PCH_THERMAL=y
> > > # end of Intel thermal drivers
> > > 
> > > CONFIG_WATCHDOG=y
> > > CONFIG_WATCHDOG_CORE=y
> > > # CONFIG_WATCHDOG_NOWAYOUT is not set
> > > # CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
> > > CONFIG_WATCHDOG_OPEN_TIMEOUT=0
> > > # CONFIG_WATCHDOG_SYSFS is not set
> > > 
> > > #
> > > # Watchdog Pretimeout Governors
> > > #
> > > # CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
> > > 
> > > #
> > > # Watchdog Device Drivers
> > > #
> > > # CONFIG_SOFT_WATCHDOG is not set
> > > CONFIG_DA9055_WATCHDOG=y
> > > CONFIG_DA9063_WATCHDOG=m
> > > CONFIG_DA9062_WATCHDOG=m
> > > CONFIG_MENF21BMC_WATCHDOG=m
> > > CONFIG_MENZ069_WATCHDOG=m
> > > # CONFIG_WDAT_WDT is not set
> > > CONFIG_WM8350_WATCHDOG=y
> > > CONFIG_XILINX_WATCHDOG=y
> > > CONFIG_ZIIRAVE_WATCHDOG=m
> > > CONFIG_MLX_WDT=m
> > > CONFIG_CADENCE_WATCHDOG=m
> > > # CONFIG_DW_WATCHDOG is not set
> > > # CONFIG_MAX63XX_WATCHDOG is not set
> > > CONFIG_RETU_WATCHDOG=y
> > > CONFIG_ACQUIRE_WDT=m
> > > # CONFIG_ADVANTECH_WDT is not set
> > > # CONFIG_ALIM1535_WDT is not set
> > > # CONFIG_ALIM7101_WDT is not set
> > > CONFIG_EBC_C384_WDT=y
> > > # CONFIG_F71808E_WDT is not set
> > > CONFIG_SP5100_TCO=m
> > > # CONFIG_SBC_FITPC2_WATCHDOG is not set
> > > # CONFIG_EUROTECH_WDT is not set
> > > # CONFIG_IB700_WDT is not set
> > > CONFIG_IBMASR=m
> > > # CONFIG_WAFER_WDT is not set
> > > CONFIG_I6300ESB_WDT=m
> > > CONFIG_IE6XX_WDT=m
> > > # CONFIG_ITCO_WDT is not set
> > > CONFIG_IT8712F_WDT=m
> > > CONFIG_IT87_WDT=y
> > > # CONFIG_HP_WATCHDOG is not set
> > > # CONFIG_KEMPLD_WDT is not set
> > > CONFIG_SC1200_WDT=y
> > > CONFIG_SCx200_WDT=m
> > > CONFIG_PC87413_WDT=y
> > > CONFIG_NV_TCO=y
> > > CONFIG_60XX_WDT=y
> > > # CONFIG_SBC8360_WDT is not set
> > > CONFIG_SBC7240_WDT=y
> > > CONFIG_CPU5_WDT=y
> > > CONFIG_SMSC_SCH311X_WDT=y
> > > # CONFIG_SMSC37B787_WDT is not set
> > > # CONFIG_TQMX86_WDT is not set
> > > CONFIG_VIA_WDT=y
> > > CONFIG_W83627HF_WDT=m
> > > # CONFIG_W83877F_WDT is not set
> > > CONFIG_W83977F_WDT=m
> > > CONFIG_MACHZ_WDT=y
> > > # CONFIG_SBC_EPX_C3_WATCHDOG is not set
> > > # CONFIG_INTEL_MEI_WDT is not set
> > > # CONFIG_NI903X_WDT is not set
> > > # CONFIG_NIC7018_WDT is not set
> > > CONFIG_MEN_A21_WDT=m
> > > 
> > > #
> > > # ISA-based Watchdog Cards
> > > #
> > > CONFIG_PCWATCHDOG=y
> > > CONFIG_MIXCOMWD=y
> > > # CONFIG_WDT is not set
> > > 
> > > #
> > > # PCI-based Watchdog Cards
> > > #
> > > CONFIG_PCIPCWATCHDOG=m
> > > CONFIG_WDTPCI=y
> > > 
> > > #
> > > # USB-based Watchdog Cards
> > > #
> > > # CONFIG_USBPCWATCHDOG is not set
> > > CONFIG_SSB_POSSIBLE=y
> > > # CONFIG_SSB is not set
> > > CONFIG_BCMA_POSSIBLE=y
> > > CONFIG_BCMA=m
> > > CONFIG_BCMA_HOST_PCI_POSSIBLE=y
> > > CONFIG_BCMA_HOST_PCI=y
> > > # CONFIG_BCMA_HOST_SOC is not set
> > > CONFIG_BCMA_DRIVER_PCI=y
> > > # CONFIG_BCMA_DRIVER_GMAC_CMN is not set
> > > CONFIG_BCMA_DRIVER_GPIO=y
> > > CONFIG_BCMA_DEBUG=y
> > > 
> > > #
> > > # Multifunction device drivers
> > > #
> > > CONFIG_MFD_CORE=y
> > > # CONFIG_MFD_CS5535 is not set
> > > CONFIG_MFD_AS3711=y
> > > CONFIG_PMIC_ADP5520=y
> > > CONFIG_MFD_AAT2870_CORE=y
> > > CONFIG_MFD_BCM590XX=y
> > > CONFIG_MFD_BD9571MWV=m
> > > CONFIG_MFD_AXP20X=m
> > > CONFIG_MFD_AXP20X_I2C=m
> > > CONFIG_MFD_CROS_EC_DEV=y
> > > CONFIG_MFD_MADERA=y
> > > CONFIG_MFD_MADERA_I2C=y
> > > # CONFIG_MFD_CS47L15 is not set
> > > # CONFIG_MFD_CS47L35 is not set
> > > CONFIG_MFD_CS47L85=y
> > > # CONFIG_MFD_CS47L90 is not set
> > > CONFIG_MFD_CS47L92=y
> > > # CONFIG_PMIC_DA903X is not set
> > > # CONFIG_MFD_DA9052_I2C is not set
> > > CONFIG_MFD_DA9055=y
> > > CONFIG_MFD_DA9062=y
> > > CONFIG_MFD_DA9063=m
> > > CONFIG_MFD_DA9150=y
> > > CONFIG_MFD_DLN2=m
> > > CONFIG_MFD_MC13XXX=m
> > > CONFIG_MFD_MC13XXX_I2C=m
> > > # CONFIG_MFD_MP2629 is not set
> > > CONFIG_HTC_PASIC3=y
> > > # CONFIG_HTC_I2CPLD is not set
> > > CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
> > > CONFIG_LPC_ICH=y
> > > CONFIG_LPC_SCH=y
> > > CONFIG_INTEL_SOC_PMIC=y
> > > # CONFIG_INTEL_SOC_PMIC_CHTWC is not set
> > > CONFIG_INTEL_SOC_PMIC_CHTDC_TI=y
> > > CONFIG_MFD_INTEL_LPSS=y
> > > CONFIG_MFD_INTEL_LPSS_ACPI=m
> > > CONFIG_MFD_INTEL_LPSS_PCI=y
> > > CONFIG_MFD_IQS62X=y
> > > CONFIG_MFD_JANZ_CMODIO=m
> > > CONFIG_MFD_KEMPLD=y
> > > CONFIG_MFD_88PM800=m
> > > CONFIG_MFD_88PM805=y
> > > CONFIG_MFD_88PM860X=y
> > > CONFIG_MFD_MAX14577=y
> > > CONFIG_MFD_MAX77693=m
> > > CONFIG_MFD_MAX77843=y
> > > CONFIG_MFD_MAX8907=m
> > > # CONFIG_MFD_MAX8925 is not set
> > > # CONFIG_MFD_MAX8997 is not set
> > > # CONFIG_MFD_MAX8998 is not set
> > > CONFIG_MFD_MT6360=y
> > > CONFIG_MFD_MT6397=y
> > > CONFIG_MFD_MENF21BMC=m
> > > CONFIG_MFD_VIPERBOARD=y
> > > CONFIG_MFD_RETU=y
> > > # CONFIG_MFD_PCF50633 is not set
> > > CONFIG_MFD_RDC321X=y
> > > CONFIG_MFD_RT5033=m
> > > # CONFIG_MFD_RC5T583 is not set
> > > CONFIG_MFD_SEC_CORE=m
> > > CONFIG_MFD_SI476X_CORE=y
> > > CONFIG_MFD_SM501=m
> > > CONFIG_MFD_SM501_GPIO=y
> > > CONFIG_MFD_SKY81452=m
> > > CONFIG_MFD_SMSC=y
> > > CONFIG_ABX500_CORE=y
> > > CONFIG_AB3100_CORE=y
> > > # CONFIG_AB3100_OTP is not set
> > > CONFIG_MFD_SYSCON=y
> > > CONFIG_MFD_TI_AM335X_TSCADC=m
> > > # CONFIG_MFD_LP3943 is not set
> > > CONFIG_MFD_LP8788=y
> > > CONFIG_MFD_TI_LMU=y
> > > CONFIG_MFD_PALMAS=y
> > > # CONFIG_TPS6105X is not set
> > > # CONFIG_TPS65010 is not set
> > > # CONFIG_TPS6507X is not set
> > > CONFIG_MFD_TPS65086=y
> > > # CONFIG_MFD_TPS65090 is not set
> > > # CONFIG_MFD_TPS68470 is not set
> > > # CONFIG_MFD_TI_LP873X is not set
> > > # CONFIG_MFD_TPS6586X is not set
> > > # CONFIG_MFD_TPS65910 is not set
> > > CONFIG_MFD_TPS65912=m
> > > CONFIG_MFD_TPS65912_I2C=m
> > > # CONFIG_MFD_TPS80031 is not set
> > > # CONFIG_TWL4030_CORE is not set
> > > CONFIG_TWL6040_CORE=y
> > > CONFIG_MFD_WL1273_CORE=y
> > > CONFIG_MFD_LM3533=y
> > > CONFIG_MFD_TIMBERDALE=m
> > > # CONFIG_MFD_TQMX86 is not set
> > > CONFIG_MFD_VX855=m
> > > CONFIG_MFD_ARIZONA=y
> > > CONFIG_MFD_ARIZONA_I2C=y
> > > CONFIG_MFD_CS47L24=y
> > > CONFIG_MFD_WM5102=y
> > > CONFIG_MFD_WM5110=y
> > > CONFIG_MFD_WM8997=y
> > > # CONFIG_MFD_WM8998 is not set
> > > CONFIG_MFD_WM8400=y
> > > # CONFIG_MFD_WM831X_I2C is not set
> > > CONFIG_MFD_WM8350=y
> > > CONFIG_MFD_WM8350_I2C=y
> > > CONFIG_MFD_WM8994=y
> > > # end of Multifunction device drivers
> > > 
> > > CONFIG_REGULATOR=y
> > > CONFIG_REGULATOR_DEBUG=y
> > > CONFIG_REGULATOR_FIXED_VOLTAGE=y
> > > CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
> > > # CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
> > > CONFIG_REGULATOR_88PG86X=y
> > > CONFIG_REGULATOR_88PM800=m
> > > CONFIG_REGULATOR_88PM8607=y
> > > CONFIG_REGULATOR_ACT8865=y
> > > CONFIG_REGULATOR_AD5398=m
> > > # CONFIG_REGULATOR_AAT2870 is not set
> > > # CONFIG_REGULATOR_AB3100 is not set
> > > # CONFIG_REGULATOR_AS3711 is not set
> > > CONFIG_REGULATOR_AXP20X=m
> > > CONFIG_REGULATOR_BCM590XX=y
> > > CONFIG_REGULATOR_BD9571MWV=m
> > > CONFIG_REGULATOR_DA9055=m
> > > CONFIG_REGULATOR_DA9062=y
> > > # CONFIG_REGULATOR_DA9210 is not set
> > > CONFIG_REGULATOR_DA9211=y
> > > # CONFIG_REGULATOR_FAN53555 is not set
> > > CONFIG_REGULATOR_GPIO=y
> > > CONFIG_REGULATOR_ISL9305=y
> > > # CONFIG_REGULATOR_ISL6271A is not set
> > > CONFIG_REGULATOR_LM363X=y
> > > CONFIG_REGULATOR_LP3971=y
> > > CONFIG_REGULATOR_LP3972=y
> > > CONFIG_REGULATOR_LP872X=m
> > > CONFIG_REGULATOR_LP8755=m
> > > CONFIG_REGULATOR_LP8788=y
> > > CONFIG_REGULATOR_LTC3589=m
> > > # CONFIG_REGULATOR_LTC3676 is not set
> > > CONFIG_REGULATOR_MAX14577=y
> > > CONFIG_REGULATOR_MAX1586=y
> > > CONFIG_REGULATOR_MAX8649=y
> > > CONFIG_REGULATOR_MAX8660=y
> > > # CONFIG_REGULATOR_MAX8907 is not set
> > > CONFIG_REGULATOR_MAX8952=y
> > > CONFIG_REGULATOR_MAX77693=y
> > > CONFIG_REGULATOR_MAX77826=m
> > > CONFIG_REGULATOR_MC13XXX_CORE=m
> > > CONFIG_REGULATOR_MC13783=m
> > > CONFIG_REGULATOR_MC13892=m
> > > CONFIG_REGULATOR_MP8859=m
> > > CONFIG_REGULATOR_MT6311=m
> > > CONFIG_REGULATOR_MT6323=m
> > > CONFIG_REGULATOR_MT6358=y
> > > CONFIG_REGULATOR_MT6397=m
> > > # CONFIG_REGULATOR_PALMAS is not set
> > > CONFIG_REGULATOR_PFUZE100=m
> > > # CONFIG_REGULATOR_PV88060 is not set
> > > CONFIG_REGULATOR_PV88080=y
> > > CONFIG_REGULATOR_PV88090=y
> > > # CONFIG_REGULATOR_PWM is not set
> > > CONFIG_REGULATOR_RT5033=m
> > > # CONFIG_REGULATOR_S2MPA01 is not set
> > > CONFIG_REGULATOR_S2MPS11=m
> > > CONFIG_REGULATOR_S5M8767=m
> > > CONFIG_REGULATOR_SKY81452=m
> > > CONFIG_REGULATOR_SLG51000=m
> > > # CONFIG_REGULATOR_TPS51632 is not set
> > > CONFIG_REGULATOR_TPS62360=m
> > > CONFIG_REGULATOR_TPS65023=m
> > > # CONFIG_REGULATOR_TPS6507X is not set
> > > # CONFIG_REGULATOR_TPS65086 is not set
> > > CONFIG_REGULATOR_TPS65132=m
> > > # CONFIG_REGULATOR_TPS65912 is not set
> > > CONFIG_REGULATOR_WM8350=m
> > > # CONFIG_REGULATOR_WM8400 is not set
> > > # CONFIG_REGULATOR_WM8994 is not set
> > > # CONFIG_RC_CORE is not set
> > > # CONFIG_MEDIA_CEC_SUPPORT is not set
> > > # CONFIG_MEDIA_SUPPORT is not set
> > > 
> > > #
> > > # Graphics support
> > > #
> > > CONFIG_AGP=y
> > > CONFIG_AGP_ALI=m
> > > # CONFIG_AGP_ATI is not set
> > > CONFIG_AGP_AMD=m
> > > CONFIG_AGP_AMD64=y
> > > # CONFIG_AGP_INTEL is not set
> > > CONFIG_AGP_NVIDIA=y
> > > # CONFIG_AGP_SIS is not set
> > > # CONFIG_AGP_SWORKS is not set
> > > # CONFIG_AGP_VIA is not set
> > > CONFIG_AGP_EFFICEON=y
> > > CONFIG_VGA_ARB=y
> > > CONFIG_VGA_ARB_MAX_GPUS=16
> > > # CONFIG_VGA_SWITCHEROO is not set
> > > # CONFIG_DRM is not set
> > > 
> > > #
> > > # ARM devices
> > > #
> > > # end of ARM devices
> > > 
> > > CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
> > > 
> > > #
> > > # Frame buffer Devices
> > > #
> > > CONFIG_FB_CMDLINE=y
> > > CONFIG_FB_NOTIFY=y
> > > CONFIG_FB=y
> > > CONFIG_FIRMWARE_EDID=y
> > > CONFIG_FB_DDC=y
> > > CONFIG_FB_BOOT_VESA_SUPPORT=y
> > > CONFIG_FB_CFB_FILLRECT=y
> > > CONFIG_FB_CFB_COPYAREA=y
> > > CONFIG_FB_CFB_IMAGEBLIT=y
> > > CONFIG_FB_SYS_FILLRECT=y
> > > CONFIG_FB_SYS_COPYAREA=y
> > > CONFIG_FB_SYS_IMAGEBLIT=y
> > > CONFIG_FB_FOREIGN_ENDIAN=y
> > > # CONFIG_FB_BOTH_ENDIAN is not set
> > > CONFIG_FB_BIG_ENDIAN=y
> > > # CONFIG_FB_LITTLE_ENDIAN is not set
> > > CONFIG_FB_SYS_FOPS=y
> > > CONFIG_FB_DEFERRED_IO=y
> > > CONFIG_FB_HECUBA=m
> > > CONFIG_FB_SVGALIB=y
> > > CONFIG_FB_BACKLIGHT=y
> > > CONFIG_FB_MODE_HELPERS=y
> > > CONFIG_FB_TILEBLITTING=y
> > > 
> > > #
> > > # Frame buffer hardware drivers
> > > #
> > > # CONFIG_FB_CIRRUS is not set
> > > CONFIG_FB_PM2=y
> > > CONFIG_FB_PM2_FIFO_DISCONNECT=y
> > > # CONFIG_FB_CYBER2000 is not set
> > > CONFIG_FB_ARC=m
> > > # CONFIG_FB_ASILIANT is not set
> > > # CONFIG_FB_IMSTT is not set
> > > # CONFIG_FB_VGA16 is not set
> > > CONFIG_FB_VESA=y
> > > CONFIG_FB_EFI=y
> > > CONFIG_FB_N411=m
> > > CONFIG_FB_HGA=y
> > > CONFIG_FB_OPENCORES=m
> > > # CONFIG_FB_S1D13XXX is not set
> > > CONFIG_FB_NVIDIA=m
> > > CONFIG_FB_NVIDIA_I2C=y
> > > # CONFIG_FB_NVIDIA_DEBUG is not set
> > > CONFIG_FB_NVIDIA_BACKLIGHT=y
> > > # CONFIG_FB_RIVA is not set
> > > CONFIG_FB_I740=y
> > > CONFIG_FB_LE80578=m
> > > CONFIG_FB_CARILLO_RANCH=m
> > > # CONFIG_FB_MATROX is not set
> > > CONFIG_FB_RADEON=y
> > > CONFIG_FB_RADEON_I2C=y
> > > CONFIG_FB_RADEON_BACKLIGHT=y
> > > CONFIG_FB_RADEON_DEBUG=y
> > > CONFIG_FB_ATY128=y
> > > # CONFIG_FB_ATY128_BACKLIGHT is not set
> > > CONFIG_FB_ATY=y
> > > # CONFIG_FB_ATY_CT is not set
> > > # CONFIG_FB_ATY_GX is not set
> > > CONFIG_FB_ATY_BACKLIGHT=y
> > > CONFIG_FB_S3=m
> > > # CONFIG_FB_S3_DDC is not set
> > > # CONFIG_FB_SAVAGE is not set
> > > # CONFIG_FB_SIS is not set
> > > CONFIG_FB_VIA=y
> > > CONFIG_FB_VIA_DIRECT_PROCFS=y
> > > # CONFIG_FB_VIA_X_COMPATIBILITY is not set
> > > # CONFIG_FB_NEOMAGIC is not set
> > > # CONFIG_FB_KYRO is not set
> > > CONFIG_FB_3DFX=m
> > > # CONFIG_FB_3DFX_ACCEL is not set
> > > # CONFIG_FB_3DFX_I2C is not set
> > > CONFIG_FB_VOODOO1=m
> > > CONFIG_FB_VT8623=y
> > > CONFIG_FB_TRIDENT=y
> > > # CONFIG_FB_ARK is not set
> > > CONFIG_FB_PM3=m
> > > # CONFIG_FB_CARMINE is not set
> > > CONFIG_FB_GEODE=y
> > > CONFIG_FB_GEODE_LX=y
> > > # CONFIG_FB_GEODE_GX is not set
> > > CONFIG_FB_GEODE_GX1=m
> > > # CONFIG_FB_SM501 is not set
> > > CONFIG_FB_SMSCUFX=y
> > > # CONFIG_FB_UDL is not set
> > > CONFIG_FB_IBM_GXT4500=m
> > > CONFIG_FB_VIRTUAL=y
> > > # CONFIG_FB_METRONOME is not set
> > > CONFIG_FB_MB862XX=y
> > > CONFIG_FB_MB862XX_PCI_GDC=y
> > > # CONFIG_FB_MB862XX_I2C is not set
> > > CONFIG_FB_SIMPLE=y
> > > CONFIG_FB_SM712=m
> > > # end of Frame buffer Devices
> > > 
> > > #
> > > # Backlight & LCD device support
> > > #
> > > CONFIG_LCD_CLASS_DEVICE=y
> > > CONFIG_LCD_PLATFORM=y
> > > CONFIG_BACKLIGHT_CLASS_DEVICE=y
> > > # CONFIG_BACKLIGHT_GENERIC is not set
> > > # CONFIG_BACKLIGHT_LM3533 is not set
> > > CONFIG_BACKLIGHT_CARILLO_RANCH=m
> > > CONFIG_BACKLIGHT_PWM=y
> > > CONFIG_BACKLIGHT_APPLE=m
> > > # CONFIG_BACKLIGHT_QCOM_WLED is not set
> > > # CONFIG_BACKLIGHT_SAHARA is not set
> > > # CONFIG_BACKLIGHT_ADP5520 is not set
> > > CONFIG_BACKLIGHT_ADP8860=m
> > > CONFIG_BACKLIGHT_ADP8870=m
> > > CONFIG_BACKLIGHT_88PM860X=m
> > > CONFIG_BACKLIGHT_AAT2870=m
> > > CONFIG_BACKLIGHT_LM3630A=y
> > > CONFIG_BACKLIGHT_LM3639=y
> > > CONFIG_BACKLIGHT_LP855X=y
> > > CONFIG_BACKLIGHT_LP8788=y
> > > CONFIG_BACKLIGHT_SKY81452=m
> > > # CONFIG_BACKLIGHT_AS3711 is not set
> > > CONFIG_BACKLIGHT_GPIO=m
> > > # CONFIG_BACKLIGHT_LV5207LP is not set
> > > CONFIG_BACKLIGHT_BD6107=y
> > > CONFIG_BACKLIGHT_ARCXCNN=m
> > > # end of Backlight & LCD device support
> > > 
> > > CONFIG_VGASTATE=y
> > > 
> > > #
> > > # Console display driver support
> > > #
> > > CONFIG_VGA_CONSOLE=y
> > > CONFIG_VGACON_SOFT_SCROLLBACK=y
> > > CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
> > > CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT=y
> > > # CONFIG_MDA_CONSOLE is not set
> > > CONFIG_DUMMY_CONSOLE=y
> > > CONFIG_DUMMY_CONSOLE_COLUMNS=80
> > > CONFIG_DUMMY_CONSOLE_ROWS=25
> > > CONFIG_FRAMEBUFFER_CONSOLE=y
> > > CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
> > > CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
> > > CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER=y
> > > # end of Console display driver support
> > > 
> > > # CONFIG_LOGO is not set
> > > # end of Graphics support
> > > 
> > > # CONFIG_SOUND is not set
> > > 
> > > #
> > > # HID support
> > > #
> > > CONFIG_HID=y
> > > # CONFIG_HID_BATTERY_STRENGTH is not set
> > > CONFIG_HIDRAW=y
> > > CONFIG_UHID=m
> > > CONFIG_HID_GENERIC=m
> > > 
> > > #
> > > # Special HID drivers
> > > #
> > > CONFIG_HID_A4TECH=y
> > > CONFIG_HID_ACCUTOUCH=m
> > > CONFIG_HID_ACRUX=y
> > > # CONFIG_HID_ACRUX_FF is not set
> > > CONFIG_HID_APPLE=y
> > > CONFIG_HID_APPLEIR=m
> > > CONFIG_HID_ASUS=m
> > > # CONFIG_HID_AUREAL is not set
> > > CONFIG_HID_BELKIN=m
> > > # CONFIG_HID_BETOP_FF is not set
> > > CONFIG_HID_BIGBEN_FF=m
> > > CONFIG_HID_CHERRY=m
> > > CONFIG_HID_CHICONY=m
> > > CONFIG_HID_CORSAIR=m
> > > CONFIG_HID_COUGAR=y
> > > CONFIG_HID_MACALLY=y
> > > # CONFIG_HID_CMEDIA is not set
> > > CONFIG_HID_CP2112=m
> > > CONFIG_HID_CREATIVE_SB0540=m
> > > # CONFIG_HID_CYPRESS is not set
> > > CONFIG_HID_DRAGONRISE=y
> > > CONFIG_DRAGONRISE_FF=y
> > > # CONFIG_HID_EMS_FF is not set
> > > # CONFIG_HID_ELAN is not set
> > > CONFIG_HID_ELECOM=m
> > > CONFIG_HID_ELO=m
> > > # CONFIG_HID_EZKEY is not set
> > > CONFIG_HID_GEMBIRD=y
> > > CONFIG_HID_GFRM=m
> > > # CONFIG_HID_GLORIOUS is not set
> > > # CONFIG_HID_HOLTEK is not set
> > > CONFIG_HID_GOOGLE_HAMMER=m
> > > # CONFIG_HID_GT683R is not set
> > > CONFIG_HID_KEYTOUCH=y
> > > CONFIG_HID_KYE=m
> > > CONFIG_HID_UCLOGIC=m
> > > CONFIG_HID_WALTOP=m
> > > CONFIG_HID_VIEWSONIC=m
> > > CONFIG_HID_GYRATION=y
> > > CONFIG_HID_ICADE=m
> > > CONFIG_HID_ITE=y
> > > CONFIG_HID_JABRA=y
> > > # CONFIG_HID_TWINHAN is not set
> > > # CONFIG_HID_KENSINGTON is not set
> > > CONFIG_HID_LCPOWER=y
> > > CONFIG_HID_LED=y
> > > # CONFIG_HID_LENOVO is not set
> > > # CONFIG_HID_LOGITECH is not set
> > > # CONFIG_HID_MAGICMOUSE is not set
> > > # CONFIG_HID_MALTRON is not set
> > > CONFIG_HID_MAYFLASH=y
> > > CONFIG_HID_REDRAGON=m
> > > CONFIG_HID_MICROSOFT=m
> > > CONFIG_HID_MONTEREY=y
> > > CONFIG_HID_MULTITOUCH=y
> > > CONFIG_HID_NTI=y
> > > CONFIG_HID_NTRIG=m
> > > CONFIG_HID_ORTEK=y
> > > CONFIG_HID_PANTHERLORD=y
> > > CONFIG_PANTHERLORD_FF=y
> > > # CONFIG_HID_PENMOUNT is not set
> > > CONFIG_HID_PETALYNX=y
> > > CONFIG_HID_PICOLCD=m
> > > CONFIG_HID_PICOLCD_FB=y
> > > CONFIG_HID_PICOLCD_BACKLIGHT=y
> > > CONFIG_HID_PICOLCD_LCD=y
> > > CONFIG_HID_PICOLCD_LEDS=y
> > > # CONFIG_HID_PLANTRONICS is not set
> > > CONFIG_HID_PRIMAX=y
> > > CONFIG_HID_RETRODE=m
> > > CONFIG_HID_ROCCAT=m
> > > CONFIG_HID_SAITEK=y
> > > CONFIG_HID_SAMSUNG=m
> > > CONFIG_HID_SONY=m
> > > # CONFIG_SONY_FF is not set
> > > # CONFIG_HID_SPEEDLINK is not set
> > > # CONFIG_HID_STEAM is not set
> > > CONFIG_HID_STEELSERIES=y
> > > # CONFIG_HID_SUNPLUS is not set
> > > # CONFIG_HID_RMI is not set
> > > CONFIG_HID_GREENASIA=y
> > > CONFIG_GREENASIA_FF=y
> > > # CONFIG_HID_SMARTJOYPLUS is not set
> > > CONFIG_HID_TIVO=m
> > > CONFIG_HID_TOPSEED=m
> > > # CONFIG_HID_THINGM is not set
> > > CONFIG_HID_THRUSTMASTER=y
> > > # CONFIG_THRUSTMASTER_FF is not set
> > > CONFIG_HID_UDRAW_PS3=y
> > > # CONFIG_HID_U2FZERO is not set
> > > # CONFIG_HID_WACOM is not set
> > > CONFIG_HID_WIIMOTE=y
> > > CONFIG_HID_XINMO=y
> > > # CONFIG_HID_ZEROPLUS is not set
> > > CONFIG_HID_ZYDACRON=m
> > > CONFIG_HID_SENSOR_HUB=m
> > > CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
> > > # CONFIG_HID_ALPS is not set
> > > CONFIG_HID_MCP2221=m
> > > # end of Special HID drivers
> > > 
> > > #
> > > # USB HID support
> > > #
> > > CONFIG_USB_HID=m
> > > CONFIG_HID_PID=y
> > > # CONFIG_USB_HIDDEV is not set
> > > # end of USB HID support
> > > 
> > > #
> > > # I2C HID support
> > > #
> > > # CONFIG_I2C_HID is not set
> > > # end of I2C HID support
> > > # end of HID support
> > > 
> > > CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> > > CONFIG_USB_SUPPORT=y
> > > CONFIG_USB_COMMON=y
> > > CONFIG_USB_ULPI_BUS=m
> > > # CONFIG_USB_CONN_GPIO is not set
> > > CONFIG_USB_ARCH_HAS_HCD=y
> > > CONFIG_USB=y
> > > CONFIG_USB_PCI=y
> > > CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> > > 
> > > #
> > > # Miscellaneous USB options
> > > #
> > > CONFIG_USB_DEFAULT_PERSIST=y
> > > CONFIG_USB_DYNAMIC_MINORS=y
> > > CONFIG_USB_OTG=y
> > > # CONFIG_USB_OTG_WHITELIST is not set
> > > # CONFIG_USB_OTG_BLACKLIST_HUB is not set
> > > # CONFIG_USB_OTG_FSM is not set
> > > CONFIG_USB_AUTOSUSPEND_DELAY=2
> > > # CONFIG_USB_MON is not set
> > > 
> > > #
> > > # USB Host Controller Drivers
> > > #
> > > CONFIG_USB_C67X00_HCD=y
> > > CONFIG_USB_XHCI_HCD=y
> > > CONFIG_USB_XHCI_DBGCAP=y
> > > CONFIG_USB_XHCI_PCI=m
> > > CONFIG_USB_XHCI_PCI_RENESAS=m
> > > CONFIG_USB_XHCI_PLATFORM=y
> > > CONFIG_USB_EHCI_HCD=m
> > > CONFIG_USB_EHCI_ROOT_HUB_TT=y
> > > # CONFIG_USB_EHCI_TT_NEWSCHED is not set
> > > CONFIG_USB_EHCI_PCI=m
> > > CONFIG_USB_EHCI_FSL=m
> > > CONFIG_USB_EHCI_HCD_PLATFORM=m
> > > CONFIG_USB_OXU210HP_HCD=y
> > > CONFIG_USB_ISP116X_HCD=m
> > > CONFIG_USB_FOTG210_HCD=y
> > > # CONFIG_USB_OHCI_HCD is not set
> > > # CONFIG_USB_UHCI_HCD is not set
> > > # CONFIG_USB_SL811_HCD is not set
> > > CONFIG_USB_R8A66597_HCD=y
> > > # CONFIG_USB_HCD_BCMA is not set
> > > CONFIG_USB_HCD_TEST_MODE=y
> > > 
> > > #
> > > # USB Device Class drivers
> > > #
> > > CONFIG_USB_ACM=y
> > > # CONFIG_USB_PRINTER is not set
> > > CONFIG_USB_WDM=m
> > > # CONFIG_USB_TMC is not set
> > > 
> > > #
> > > # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> > > #
> > > 
> > > #
> > > # also be needed; see USB_STORAGE Help for more info
> > > #
> > > CONFIG_USB_STORAGE=m
> > > # CONFIG_USB_STORAGE_DEBUG is not set
> > > # CONFIG_USB_STORAGE_REALTEK is not set
> > > CONFIG_USB_STORAGE_DATAFAB=m
> > > # CONFIG_USB_STORAGE_FREECOM is not set
> > > # CONFIG_USB_STORAGE_ISD200 is not set
> > > # CONFIG_USB_STORAGE_USBAT is not set
> > > # CONFIG_USB_STORAGE_SDDR09 is not set
> > > # CONFIG_USB_STORAGE_SDDR55 is not set
> > > CONFIG_USB_STORAGE_JUMPSHOT=m
> > > CONFIG_USB_STORAGE_ALAUDA=m
> > > CONFIG_USB_STORAGE_ONETOUCH=m
> > > CONFIG_USB_STORAGE_KARMA=m
> > > CONFIG_USB_STORAGE_CYPRESS_ATACB=m
> > > CONFIG_USB_STORAGE_ENE_UB6250=m
> > > CONFIG_USB_UAS=m
> > > 
> > > #
> > > # USB Imaging devices
> > > #
> > > CONFIG_USB_MDC800=m
> > > CONFIG_USB_MICROTEK=y
> > > # CONFIG_USBIP_CORE is not set
> > > CONFIG_USB_CDNS3=m
> > > # CONFIG_USB_CDNS3_GADGET is not set
> > > # CONFIG_USB_CDNS3_HOST is not set
> > > CONFIG_USB_CDNS3_PCI_WRAP=m
> > > # CONFIG_USB_MUSB_HDRC is not set
> > > CONFIG_USB_DWC3=m
> > > CONFIG_USB_DWC3_ULPI=y
> > > # CONFIG_USB_DWC3_HOST is not set
> > > CONFIG_USB_DWC3_GADGET=y
> > > # CONFIG_USB_DWC3_DUAL_ROLE is not set
> > > 
> > > #
> > > # Platform Glue Driver Support
> > > #
> > > CONFIG_USB_DWC3_PCI=m
> > > CONFIG_USB_DWC3_HAPS=m
> > > CONFIG_USB_DWC2=m
> > > CONFIG_USB_DWC2_HOST=y
> > > 
> > > #
> > > # Gadget/Dual-role mode requires USB Gadget support to be enabled
> > > #
> > > # CONFIG_USB_DWC2_PERIPHERAL is not set
> > > # CONFIG_USB_DWC2_DUAL_ROLE is not set
> > > CONFIG_USB_DWC2_PCI=m
> > > # CONFIG_USB_DWC2_DEBUG is not set
> > > # CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
> > > CONFIG_USB_CHIPIDEA=m
> > > # CONFIG_USB_CHIPIDEA_UDC is not set
> > > # CONFIG_USB_CHIPIDEA_HOST is not set
> > > CONFIG_USB_CHIPIDEA_PCI=m
> > > CONFIG_USB_CHIPIDEA_MSM=m
> > > CONFIG_USB_CHIPIDEA_GENERIC=m
> > > CONFIG_USB_ISP1760=y
> > > CONFIG_USB_ISP1760_HCD=y
> > > CONFIG_USB_ISP1760_HOST_ROLE=y
> > > 
> > > #
> > > # USB port drivers
> > > #
> > > CONFIG_USB_USS720=y
> > > # CONFIG_USB_SERIAL is not set
> > > 
> > > #
> > > # USB Miscellaneous drivers
> > > #
> > > CONFIG_USB_EMI62=y
> > > CONFIG_USB_EMI26=m
> > > # CONFIG_USB_ADUTUX is not set
> > > # CONFIG_USB_SEVSEG is not set
> > > CONFIG_USB_LEGOTOWER=m
> > > # CONFIG_USB_LCD is not set
> > > CONFIG_USB_CYPRESS_CY7C63=y
> > > CONFIG_USB_CYTHERM=m
> > > CONFIG_USB_IDMOUSE=m
> > > # CONFIG_USB_FTDI_ELAN is not set
> > > CONFIG_USB_APPLEDISPLAY=m
> > > CONFIG_APPLE_MFI_FASTCHARGE=m
> > > CONFIG_USB_SISUSBVGA=m
> > > # CONFIG_USB_SISUSBVGA_CON is not set
> > > # CONFIG_USB_LD is not set
> > > CONFIG_USB_TRANCEVIBRATOR=y
> > > CONFIG_USB_IOWARRIOR=y
> > > CONFIG_USB_TEST=m
> > > CONFIG_USB_EHSET_TEST_FIXTURE=y
> > > # CONFIG_USB_ISIGHTFW is not set
> > > # CONFIG_USB_YUREX is not set
> > > CONFIG_USB_EZUSB_FX2=m
> > > CONFIG_USB_HUB_USB251XB=y
> > > CONFIG_USB_HSIC_USB3503=m
> > > # CONFIG_USB_HSIC_USB4604 is not set
> > > # CONFIG_USB_LINK_LAYER_TEST is not set
> > > # CONFIG_USB_CHAOSKEY is not set
> > > 
> > > #
> > > # USB Physical Layer drivers
> > > #
> > > CONFIG_USB_PHY=y
> > > CONFIG_NOP_USB_XCEIV=m
> > > # CONFIG_USB_GPIO_VBUS is not set
> > > CONFIG_TAHVO_USB=m
> > > CONFIG_TAHVO_USB_HOST_BY_DEFAULT=y
> > > CONFIG_USB_ISP1301=y
> > > # end of USB Physical Layer drivers
> > > 
> > > CONFIG_USB_GADGET=m
> > > # CONFIG_USB_GADGET_DEBUG is not set
> > > # CONFIG_USB_GADGET_DEBUG_FILES is not set
> > > # CONFIG_USB_GADGET_DEBUG_FS is not set
> > > CONFIG_USB_GADGET_VBUS_DRAW=2
> > > CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
> > > # CONFIG_U_SERIAL_CONSOLE is not set
> > > 
> > > #
> > > # USB Peripheral Controller
> > > #
> > > # CONFIG_USB_FOTG210_UDC is not set
> > > # CONFIG_USB_GR_UDC is not set
> > > CONFIG_USB_R8A66597=m
> > > CONFIG_USB_PXA27X=m
> > > CONFIG_USB_MV_UDC=m
> > > # CONFIG_USB_MV_U3D is not set
> > > CONFIG_USB_M66592=m
> > > CONFIG_USB_BDC_UDC=m
> > > 
> > > #
> > > # Platform Support
> > > #
> > > CONFIG_USB_BDC_PCI=m
> > > # CONFIG_USB_AMD5536UDC is not set
> > > CONFIG_USB_NET2272=m
> > > CONFIG_USB_NET2272_DMA=y
> > > CONFIG_USB_NET2280=m
> > > # CONFIG_USB_GOKU is not set
> > > CONFIG_USB_EG20T=m
> > > CONFIG_USB_DUMMY_HCD=m
> > > # end of USB Peripheral Controller
> > > 
> > > CONFIG_USB_LIBCOMPOSITE=m
> > > CONFIG_USB_F_ACM=m
> > > CONFIG_USB_F_SS_LB=m
> > > CONFIG_USB_U_SERIAL=m
> > > CONFIG_USB_F_SERIAL=m
> > > CONFIG_USB_F_OBEX=m
> > > CONFIG_USB_F_MASS_STORAGE=m
> > > CONFIG_USB_F_FS=m
> > > CONFIG_USB_F_HID=m
> > > CONFIG_USB_F_TCM=m
> > > CONFIG_USB_CONFIGFS=m
> > > CONFIG_USB_CONFIGFS_SERIAL=y
> > > # CONFIG_USB_CONFIGFS_ACM is not set
> > > CONFIG_USB_CONFIGFS_OBEX=y
> > > # CONFIG_USB_CONFIGFS_NCM is not set
> > > # CONFIG_USB_CONFIGFS_ECM is not set
> > > # CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
> > > # CONFIG_USB_CONFIGFS_RNDIS is not set
> > > # CONFIG_USB_CONFIGFS_EEM is not set
> > > # CONFIG_USB_CONFIGFS_MASS_STORAGE is not set
> > > # CONFIG_USB_CONFIGFS_F_LB_SS is not set
> > > CONFIG_USB_CONFIGFS_F_FS=y
> > > # CONFIG_USB_CONFIGFS_F_HID is not set
> > > # CONFIG_USB_CONFIGFS_F_PRINTER is not set
> > > CONFIG_USB_CONFIGFS_F_TCM=y
> > > 
> > > #
> > > # USB Gadget precomposed configurations
> > > #
> > > CONFIG_USB_ZERO=m
> > > CONFIG_USB_ZERO_HNPTEST=y
> > > # CONFIG_USB_ETH is not set
> > > # CONFIG_USB_G_NCM is not set
> > > # CONFIG_USB_GADGETFS is not set
> > > CONFIG_USB_FUNCTIONFS=m
> > > # CONFIG_USB_FUNCTIONFS_ETH is not set
> > > # CONFIG_USB_FUNCTIONFS_RNDIS is not set
> > > CONFIG_USB_FUNCTIONFS_GENERIC=y
> > > CONFIG_USB_MASS_STORAGE=m
> > > CONFIG_USB_GADGET_TARGET=m
> > > CONFIG_USB_G_SERIAL=m
> > > # CONFIG_USB_G_PRINTER is not set
> > > # CONFIG_USB_CDC_COMPOSITE is not set
> > > CONFIG_USB_G_ACM_MS=m
> > > # CONFIG_USB_G_MULTI is not set
> > > CONFIG_USB_G_HID=m
> > > # CONFIG_USB_G_DBGP is not set
> > > # CONFIG_USB_RAW_GADGET is not set
> > > # end of USB Gadget precomposed configurations
> > > 
> > > CONFIG_TYPEC=y
> > > # CONFIG_TYPEC_TCPM is not set
> > > CONFIG_TYPEC_UCSI=m
> > > CONFIG_UCSI_CCG=m
> > > CONFIG_UCSI_ACPI=m
> > > CONFIG_TYPEC_HD3SS3220=m
> > > # CONFIG_TYPEC_TPS6598X is not set
> > > 
> > > #
> > > # USB Type-C Multiplexer/DeMultiplexer Switch support
> > > #
> > > # CONFIG_TYPEC_MUX_PI3USB30532 is not set
> > > # end of USB Type-C Multiplexer/DeMultiplexer Switch support
> > > 
> > > #
> > > # USB Type-C Alternate Mode drivers
> > > #
> > > CONFIG_TYPEC_DP_ALTMODE=y
> > > CONFIG_TYPEC_NVIDIA_ALTMODE=m
> > > # end of USB Type-C Alternate Mode drivers
> > > 
> > > CONFIG_USB_ROLE_SWITCH=m
> > > CONFIG_USB_ROLES_INTEL_XHCI=m
> > > # CONFIG_MMC is not set
> > > CONFIG_MEMSTICK=y
> > > # CONFIG_MEMSTICK_DEBUG is not set
> > > 
> > > #
> > > # MemoryStick drivers
> > > #
> > > CONFIG_MEMSTICK_UNSAFE_RESUME=y
> > > # CONFIG_MSPRO_BLOCK is not set
> > > # CONFIG_MS_BLOCK is not set
> > > 
> > > #
> > > # MemoryStick Host Controller Drivers
> > > #
> > > CONFIG_MEMSTICK_TIFM_MS=m
> > > # CONFIG_MEMSTICK_JMICRON_38X is not set
> > > CONFIG_MEMSTICK_R592=y
> > > # CONFIG_MEMSTICK_REALTEK_PCI is not set
> > > CONFIG_NEW_LEDS=y
> > > CONFIG_LEDS_CLASS=y
> > > CONFIG_LEDS_CLASS_FLASH=y
> > > CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y
> > > 
> > > #
> > > # LED drivers
> > > #
> > > CONFIG_LEDS_88PM860X=y
> > > # CONFIG_LEDS_APU is not set
> > > CONFIG_LEDS_AS3645A=y
> > > # CONFIG_LEDS_LM3530 is not set
> > > # CONFIG_LEDS_LM3532 is not set
> > > CONFIG_LEDS_LM3533=m
> > > CONFIG_LEDS_LM3642=y
> > > # CONFIG_LEDS_LM3601X is not set
> > > CONFIG_LEDS_MT6323=y
> > > CONFIG_LEDS_NET48XX=m
> > > # CONFIG_LEDS_WRAP is not set
> > > CONFIG_LEDS_PCA9532=m
> > > CONFIG_LEDS_PCA9532_GPIO=y
> > > CONFIG_LEDS_GPIO=m
> > > # CONFIG_LEDS_LP3944 is not set
> > > # CONFIG_LEDS_LP3952 is not set
> > > CONFIG_LEDS_LP55XX_COMMON=y
> > > CONFIG_LEDS_LP5521=m
> > > CONFIG_LEDS_LP5523=m
> > > CONFIG_LEDS_LP5562=y
> > > CONFIG_LEDS_LP8501=y
> > > CONFIG_LEDS_LP8788=m
> > > CONFIG_LEDS_CLEVO_MAIL=m
> > > CONFIG_LEDS_PCA955X=m
> > > # CONFIG_LEDS_PCA955X_GPIO is not set
> > > CONFIG_LEDS_PCA963X=y
> > > CONFIG_LEDS_WM8350=y
> > > CONFIG_LEDS_PWM=y
> > > CONFIG_LEDS_REGULATOR=m
> > > # CONFIG_LEDS_BD2802 is not set
> > > CONFIG_LEDS_INTEL_SS4200=y
> > > CONFIG_LEDS_ADP5520=m
> > > CONFIG_LEDS_MC13783=m
> > > # CONFIG_LEDS_TCA6507 is not set
> > > CONFIG_LEDS_TLC591XX=y
> > > CONFIG_LEDS_LM355x=m
> > > CONFIG_LEDS_OT200=m
> > > CONFIG_LEDS_MENF21BMC=m
> > > 
> > > #
> > > # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> > > #
> > > CONFIG_LEDS_BLINKM=y
> > > # CONFIG_LEDS_MLXCPLD is not set
> > > # CONFIG_LEDS_MLXREG is not set
> > > CONFIG_LEDS_USER=m
> > > # CONFIG_LEDS_NIC78BX is not set
> > > CONFIG_LEDS_TI_LMU_COMMON=m
> > > # CONFIG_LEDS_LM36274 is not set
> > > CONFIG_LEDS_SGM3140=y
> > > 
> > > #
> > > # LED Triggers
> > > #
> > > # CONFIG_LEDS_TRIGGERS is not set
> > > # CONFIG_ACCESSIBILITY is not set
> > > # CONFIG_INFINIBAND is not set
> > > CONFIG_EDAC_ATOMIC_SCRUB=y
> > > CONFIG_EDAC_SUPPORT=y
> > > CONFIG_EDAC=y
> > > # CONFIG_EDAC_LEGACY_SYSFS is not set
> > > CONFIG_EDAC_DEBUG=y
> > > CONFIG_EDAC_DECODE_MCE=m
> > > # CONFIG_EDAC_AMD64 is not set
> > > CONFIG_EDAC_AMD76X=m
> > > # CONFIG_EDAC_E7XXX is not set
> > > CONFIG_EDAC_E752X=m
> > > CONFIG_EDAC_I82875P=m
> > > CONFIG_EDAC_I82975X=y
> > > # CONFIG_EDAC_I3000 is not set
> > > CONFIG_EDAC_I3200=y
> > > # CONFIG_EDAC_IE31200 is not set
> > > # CONFIG_EDAC_X38 is not set
> > > CONFIG_EDAC_I5400=m
> > > # CONFIG_EDAC_I7CORE is not set
> > > CONFIG_EDAC_I82860=y
> > > CONFIG_EDAC_R82600=y
> > > CONFIG_EDAC_I5000=m
> > > CONFIG_EDAC_I5100=y
> > > # CONFIG_EDAC_I7300 is not set
> > > CONFIG_RTC_LIB=y
> > > CONFIG_RTC_MC146818_LIB=y
> > > # CONFIG_RTC_CLASS is not set
> > > CONFIG_DMADEVICES=y
> > > CONFIG_DMADEVICES_DEBUG=y
> > > CONFIG_DMADEVICES_VDEBUG=y
> > > 
> > > #
> > > # DMA Devices
> > > #
> > > CONFIG_DMA_ENGINE=y
> > > CONFIG_DMA_VIRTUAL_CHANNELS=y
> > > CONFIG_DMA_ACPI=y
> > > CONFIG_ALTERA_MSGDMA=m
> > > CONFIG_INTEL_IDMA64=y
> > > # CONFIG_PCH_DMA is not set
> > > CONFIG_PLX_DMA=m
> > > CONFIG_TIMB_DMA=m
> > > # CONFIG_QCOM_HIDMA_MGMT is not set
> > > CONFIG_QCOM_HIDMA=y
> > > CONFIG_DW_DMAC_CORE=m
> > > CONFIG_DW_DMAC=m
> > > # CONFIG_DW_DMAC_PCI is not set
> > > # CONFIG_DW_EDMA is not set
> > > # CONFIG_DW_EDMA_PCIE is not set
> > > CONFIG_HSU_DMA=m
> > > # CONFIG_SF_PDMA is not set
> > > 
> > > #
> > > # DMA Clients
> > > #
> > > CONFIG_ASYNC_TX_DMA=y
> > > CONFIG_DMATEST=m
> > > CONFIG_DMA_ENGINE_RAID=y
> > > 
> > > #
> > > # DMABUF options
> > > #
> > > CONFIG_SYNC_FILE=y
> > > # CONFIG_SW_SYNC is not set
> > > # CONFIG_UDMABUF is not set
> > > # CONFIG_DMABUF_MOVE_NOTIFY is not set
> > > # CONFIG_DMABUF_SELFTESTS is not set
> > > CONFIG_DMABUF_HEAPS=y
> > > # CONFIG_DMABUF_HEAPS_SYSTEM is not set
> > > # end of DMABUF options
> > > 
> > > CONFIG_AUXDISPLAY=y
> > > CONFIG_HD44780=m
> > > CONFIG_KS0108=m
> > > CONFIG_KS0108_PORT=0x378
> > > CONFIG_KS0108_DELAY=2
> > > # CONFIG_CFAG12864B is not set
> > > CONFIG_IMG_ASCII_LCD=y
> > > CONFIG_PARPORT_PANEL=m
> > > CONFIG_PANEL_PARPORT=0
> > > CONFIG_PANEL_PROFILE=5
> > > # CONFIG_PANEL_CHANGE_MESSAGE is not set
> > > # CONFIG_CHARLCD_BL_OFF is not set
> > > # CONFIG_CHARLCD_BL_ON is not set
> > > CONFIG_CHARLCD_BL_FLASH=y
> > > CONFIG_PANEL=m
> > > CONFIG_CHARLCD=m
> > > CONFIG_UIO=y
> > > CONFIG_UIO_CIF=y
> > > # CONFIG_UIO_PDRV_GENIRQ is not set
> > > CONFIG_UIO_DMEM_GENIRQ=y
> > > # CONFIG_UIO_AEC is not set
> > > # CONFIG_UIO_SERCOS3 is not set
> > > CONFIG_UIO_PCI_GENERIC=m
> > > CONFIG_UIO_NETX=y
> > > CONFIG_UIO_PRUSS=m
> > > CONFIG_UIO_MF624=m
> > > CONFIG_VFIO_IOMMU_TYPE1=m
> > > CONFIG_VFIO=m
> > > CONFIG_VFIO_NOIOMMU=y
> > > # CONFIG_VFIO_PCI is not set
> > > # CONFIG_VFIO_MDEV is not set
> > > CONFIG_VIRT_DRIVERS=y
> > > CONFIG_VBOXGUEST=m
> > > CONFIG_VIRTIO=y
> > > # CONFIG_VIRTIO_MENU is not set
> > > CONFIG_VDPA=y
> > > CONFIG_VDPA_SIM=y
> > > CONFIG_IFCVF=m
> > > CONFIG_VHOST_IOTLB=y
> > > CONFIG_VHOST_RING=y
> > > CONFIG_VHOST=m
> > > CONFIG_VHOST_MENU=y
> > > # CONFIG_VHOST_NET is not set
> > > CONFIG_VHOST_SCSI=m
> > > # CONFIG_VHOST_VDPA is not set
> > > # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
> > > 
> > > #
> > > # Microsoft Hyper-V guest support
> > > #
> > > # CONFIG_HYPERV is not set
> > > # end of Microsoft Hyper-V guest support
> > > 
> > > CONFIG_GREYBUS=y
> > > # CONFIG_GREYBUS_ES2 is not set
> > > # CONFIG_STAGING is not set
> > > # CONFIG_X86_PLATFORM_DEVICES is not set
> > > CONFIG_PMC_ATOM=y
> > > CONFIG_MFD_CROS_EC=y
> > > CONFIG_CHROME_PLATFORMS=y
> > > CONFIG_CHROMEOS_LAPTOP=m
> > > # CONFIG_CHROMEOS_PSTORE is not set
> > > # CONFIG_CHROMEOS_TBMC is not set
> > > CONFIG_CROS_EC=y
> > > # CONFIG_CROS_EC_I2C is not set
> > > CONFIG_CROS_EC_LPC=m
> > > CONFIG_CROS_EC_PROTO=y
> > > CONFIG_CROS_KBD_LED_BACKLIGHT=y
> > > # CONFIG_CROS_EC_CHARDEV is not set
> > > CONFIG_CROS_EC_LIGHTBAR=y
> > > # CONFIG_CROS_EC_DEBUGFS is not set
> > > CONFIG_CROS_EC_SENSORHUB=y
> > > CONFIG_CROS_EC_SYSFS=m
> > > # CONFIG_CROS_EC_TYPEC is not set
> > > CONFIG_CROS_USBPD_LOGGER=m
> > > CONFIG_CROS_USBPD_NOTIFY=m
> > > CONFIG_WILCO_EC=m
> > > CONFIG_WILCO_EC_DEBUGFS=m
> > > CONFIG_WILCO_EC_EVENTS=m
> > > # CONFIG_WILCO_EC_TELEMETRY is not set
> > > CONFIG_MELLANOX_PLATFORM=y
> > > CONFIG_MLXREG_HOTPLUG=m
> > > CONFIG_MLXREG_IO=m
> > > CONFIG_HAVE_CLK=y
> > > CONFIG_CLKDEV_LOOKUP=y
> > > CONFIG_HAVE_CLK_PREPARE=y
> > > CONFIG_COMMON_CLK=y
> > > CONFIG_COMMON_CLK_MAX9485=y
> > > CONFIG_COMMON_CLK_SI5341=m
> > > CONFIG_COMMON_CLK_SI5351=y
> > > CONFIG_COMMON_CLK_SI544=m
> > > CONFIG_COMMON_CLK_CDCE706=y
> > > CONFIG_COMMON_CLK_CS2000_CP=m
> > > CONFIG_COMMON_CLK_S2MPS11=m
> > > # CONFIG_CLK_TWL6040 is not set
> > > CONFIG_COMMON_CLK_PALMAS=m
> > > # CONFIG_COMMON_CLK_PWM is not set
> > > # CONFIG_HWSPINLOCK is not set
> > > 
> > > #
> > > # Clock Source drivers
> > > #
> > > CONFIG_CLKSRC_I8253=y
> > > CONFIG_CLKEVT_I8253=y
> > > CONFIG_I8253_LOCK=y
> > > CONFIG_CLKBLD_I8253=y
> > > # end of Clock Source drivers
> > > 
> > > CONFIG_MAILBOX=y
> > > # CONFIG_PCC is not set
> > > CONFIG_ALTERA_MBOX=y
> > > CONFIG_IOMMU_IOVA=y
> > > CONFIG_IOASID=y
> > > CONFIG_IOMMU_API=y
> > > CONFIG_IOMMU_SUPPORT=y
> > > 
> > > #
> > > # Generic IOMMU Pagetable Support
> > > #
> > > # end of Generic IOMMU Pagetable Support
> > > 
> > > CONFIG_IOMMU_DEBUGFS=y
> > > # CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
> > > CONFIG_DMAR_TABLE=y
> > > CONFIG_INTEL_IOMMU=y
> > > CONFIG_INTEL_IOMMU_DEBUGFS=y
> > > CONFIG_INTEL_IOMMU_DEFAULT_ON=y
> > > CONFIG_INTEL_IOMMU_FLOPPY_WA=y
> > > # CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
> > > 
> > > #
> > > # Remoteproc drivers
> > > #
> > > # CONFIG_REMOTEPROC is not set
> > > # end of Remoteproc drivers
> > > 
> > > #
> > > # Rpmsg drivers
> > > #
> > > CONFIG_RPMSG=y
> > > # CONFIG_RPMSG_CHAR is not set
> > > CONFIG_RPMSG_QCOM_GLINK=y
> > > CONFIG_RPMSG_QCOM_GLINK_RPM=y
> > > CONFIG_RPMSG_VIRTIO=m
> > > # end of Rpmsg drivers
> > > 
> > > CONFIG_SOUNDWIRE=y
> > > 
> > > #
> > > # SoundWire Devices
> > > #
> > > 
> > > #
> > > # SOC (System On Chip) specific Drivers
> > > #
> > > 
> > > #
> > > # Amlogic SoC drivers
> > > #
> > > # end of Amlogic SoC drivers
> > > 
> > > #
> > > # Aspeed SoC drivers
> > > #
> > > # end of Aspeed SoC drivers
> > > 
> > > #
> > > # Broadcom SoC drivers
> > > #
> > > # end of Broadcom SoC drivers
> > > 
> > > #
> > > # NXP/Freescale QorIQ SoC drivers
> > > #
> > > # end of NXP/Freescale QorIQ SoC drivers
> > > 
> > > #
> > > # i.MX SoC drivers
> > > #
> > > # end of i.MX SoC drivers
> > > 
> > > #
> > > # Qualcomm SoC drivers
> > > #
> > > # end of Qualcomm SoC drivers
> > > 
> > > # CONFIG_SOC_TI is not set
> > > 
> > > #
> > > # Xilinx SoC drivers
> > > #
> > > # CONFIG_XILINX_VCU is not set
> > > # end of Xilinx SoC drivers
> > > # end of SOC (System On Chip) specific Drivers
> > > 
> > > # CONFIG_PM_DEVFREQ is not set
> > > CONFIG_EXTCON=y
> > > 
> > > #
> > > # Extcon Device Drivers
> > > #
> > > CONFIG_EXTCON_AXP288=m
> > > CONFIG_EXTCON_FSA9480=y
> > > CONFIG_EXTCON_GPIO=m
> > > # CONFIG_EXTCON_INTEL_INT3496 is not set
> > > CONFIG_EXTCON_MAX14577=y
> > > CONFIG_EXTCON_MAX3355=m
> > > # CONFIG_EXTCON_MAX77693 is not set
> > > # CONFIG_EXTCON_MAX77843 is not set
> > > CONFIG_EXTCON_PALMAS=y
> > > CONFIG_EXTCON_PTN5150=y
> > > # CONFIG_EXTCON_RT8973A is not set
> > > # CONFIG_EXTCON_SM5502 is not set
> > > CONFIG_EXTCON_USB_GPIO=y
> > > CONFIG_EXTCON_USBC_CROS_EC=m
> > > CONFIG_MEMORY=y
> > > # CONFIG_IIO is not set
> > > CONFIG_NTB=m
> > > # CONFIG_NTB_MSI is not set
> > > CONFIG_NTB_IDT=m
> > > # CONFIG_NTB_SWITCHTEC is not set
> > > CONFIG_NTB_PINGPONG=m
> > > CONFIG_NTB_TOOL=m
> > > CONFIG_NTB_PERF=m
> > > CONFIG_NTB_TRANSPORT=m
> > > # CONFIG_VME_BUS is not set
> > > CONFIG_PWM=y
> > > CONFIG_PWM_SYSFS=y
> > > CONFIG_PWM_DEBUG=y
> > > # CONFIG_PWM_CRC is not set
> > > # CONFIG_PWM_CROS_EC is not set
> > > # CONFIG_PWM_IQS620A is not set
> > > CONFIG_PWM_LPSS=m
> > > # CONFIG_PWM_LPSS_PCI is not set
> > > CONFIG_PWM_LPSS_PLATFORM=m
> > > # CONFIG_PWM_PCA9685 is not set
> > > 
> > > #
> > > # IRQ chip support
> > > #
> > > CONFIG_MADERA_IRQ=y
> > > # end of IRQ chip support
> > > 
> > > CONFIG_IPACK_BUS=m
> > > # CONFIG_BOARD_TPCI200 is not set
> > > # CONFIG_SERIAL_IPOCTAL is not set
> > > CONFIG_RESET_CONTROLLER=y
> > > CONFIG_RESET_BRCMSTB_RESCAL=y
> > > CONFIG_RESET_TI_SYSCON=m
> > > 
> > > #
> > > # PHY Subsystem
> > > #
> > > CONFIG_GENERIC_PHY=y
> > > # CONFIG_BCM_KONA_USB2_PHY is not set
> > > CONFIG_PHY_PXA_28NM_HSIC=y
> > > CONFIG_PHY_PXA_28NM_USB2=y
> > > CONFIG_PHY_QCOM_USB_HS=m
> > > CONFIG_PHY_QCOM_USB_HSIC=m
> > > CONFIG_PHY_SAMSUNG_USB2=m
> > > # CONFIG_PHY_TUSB1210 is not set
> > > CONFIG_PHY_INTEL_EMMC=m
> > > # end of PHY Subsystem
> > > 
> > > CONFIG_POWERCAP=y
> > > CONFIG_INTEL_RAPL_CORE=y
> > > CONFIG_INTEL_RAPL=y
> > > # CONFIG_IDLE_INJECT is not set
> > > CONFIG_MCB=m
> > > # CONFIG_MCB_PCI is not set
> > > # CONFIG_MCB_LPC is not set
> > > 
> > > #
> > > # Performance monitor support
> > > #
> > > # end of Performance monitor support
> > > 
> > > CONFIG_RAS=y
> > > # CONFIG_RAS_CEC is not set
> > > CONFIG_USB4=y
> > > 
> > > #
> > > # Android
> > > #
> > > CONFIG_ANDROID=y
> > > # CONFIG_ANDROID_BINDER_IPC is not set
> > > # end of Android
> > > 
> > > CONFIG_LIBNVDIMM=m
> > > CONFIG_BLK_DEV_PMEM=m
> > > # CONFIG_ND_BLK is not set
> > > # CONFIG_BTT is not set
> > > CONFIG_DAX_DRIVER=y
> > > CONFIG_DAX=y
> > > CONFIG_DEV_DAX=y
> > > CONFIG_NVMEM=y
> > > CONFIG_NVMEM_SYSFS=y
> > > 
> > > #
> > > # HW tracing support
> > > #
> > > CONFIG_STM=m
> > > # CONFIG_STM_PROTO_BASIC is not set
> > > # CONFIG_STM_PROTO_SYS_T is not set
> > > # CONFIG_STM_DUMMY is not set
> > > CONFIG_STM_SOURCE_CONSOLE=m
> > > CONFIG_STM_SOURCE_HEARTBEAT=m
> > > # CONFIG_STM_SOURCE_FTRACE is not set
> > > # CONFIG_INTEL_TH is not set
> > > # end of HW tracing support
> > > 
> > > CONFIG_FPGA=m
> > > CONFIG_ALTERA_PR_IP_CORE=m
> > > CONFIG_FPGA_MGR_ALTERA_CVP=m
> > > # CONFIG_FPGA_BRIDGE is not set
> > > # CONFIG_FPGA_DFL is not set
> > > CONFIG_TEE=y
> > > 
> > > #
> > > # TEE drivers
> > > #
> > > # end of TEE drivers
> > > 
> > > CONFIG_SIOX=m
> > > CONFIG_SIOX_BUS_GPIO=m
> > > # CONFIG_SLIMBUS is not set
> > > # CONFIG_INTERCONNECT is not set
> > > CONFIG_COUNTER=m
> > > CONFIG_MOST=m
> > > # end of Device Drivers
> > > 
> > > #
> > > # File systems
> > > #
> > > CONFIG_DCACHE_WORD_ACCESS=y
> > > # CONFIG_VALIDATE_FS_PARSER is not set
> > > CONFIG_FS_IOMAP=y
> > > CONFIG_EXT2_FS=m
> > > # CONFIG_EXT2_FS_XATTR is not set
> > > CONFIG_EXT3_FS=y
> > > # CONFIG_EXT3_FS_POSIX_ACL is not set
> > > # CONFIG_EXT3_FS_SECURITY is not set
> > > CONFIG_EXT4_FS=y
> > > # CONFIG_EXT4_FS_POSIX_ACL is not set
> > > # CONFIG_EXT4_FS_SECURITY is not set
> > > # CONFIG_EXT4_DEBUG is not set
> > > # CONFIG_EXT4_KUNIT_TESTS is not set
> > > CONFIG_JBD2=y
> > > # CONFIG_JBD2_DEBUG is not set
> > > CONFIG_FS_MBCACHE=y
> > > CONFIG_REISERFS_FS=y
> > > # CONFIG_REISERFS_CHECK is not set
> > > CONFIG_REISERFS_PROC_INFO=y
> > > # CONFIG_REISERFS_FS_XATTR is not set
> > > # CONFIG_JFS_FS is not set
> > > CONFIG_XFS_FS=m
> > > CONFIG_XFS_QUOTA=y
> > > # CONFIG_XFS_POSIX_ACL is not set
> > > CONFIG_XFS_RT=y
> > > # CONFIG_XFS_ONLINE_SCRUB is not set
> > > CONFIG_XFS_WARN=y
> > > # CONFIG_XFS_DEBUG is not set
> > > # CONFIG_GFS2_FS is not set
> > > # CONFIG_OCFS2_FS is not set
> > > CONFIG_BTRFS_FS=m
> > > CONFIG_BTRFS_FS_POSIX_ACL=y
> > > # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> > > # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> > > # CONFIG_BTRFS_DEBUG is not set
> > > # CONFIG_BTRFS_ASSERT is not set
> > > # CONFIG_BTRFS_FS_REF_VERIFY is not set
> > > CONFIG_NILFS2_FS=m
> > > # CONFIG_F2FS_FS is not set
> > > CONFIG_ZONEFS_FS=y
> > > # CONFIG_FS_DAX is not set
> > > CONFIG_FS_POSIX_ACL=y
> > > CONFIG_EXPORTFS=y
> > > # CONFIG_EXPORTFS_BLOCK_OPS is not set
> > > CONFIG_FILE_LOCKING=y
> > > CONFIG_MANDATORY_FILE_LOCKING=y
> > > CONFIG_FS_ENCRYPTION=y
> > > CONFIG_FS_ENCRYPTION_ALGS=y
> > > # CONFIG_FS_VERITY is not set
> > > CONFIG_FSNOTIFY=y
> > > CONFIG_DNOTIFY=y
> > > CONFIG_INOTIFY_USER=y
> > > CONFIG_FANOTIFY=y
> > > # CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
> > > # CONFIG_QUOTA is not set
> > > # CONFIG_QUOTA_NETLINK_INTERFACE is not set
> > > CONFIG_QUOTACTL=y
> > > CONFIG_AUTOFS4_FS=m
> > > CONFIG_AUTOFS_FS=m
> > > CONFIG_FUSE_FS=y
> > > # CONFIG_CUSE is not set
> > > CONFIG_VIRTIO_FS=m
> > > CONFIG_OVERLAY_FS=y
> > > # CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
> > > # CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
> > > # CONFIG_OVERLAY_FS_INDEX is not set
> > > # CONFIG_OVERLAY_FS_METACOPY is not set
> > > 
> > > #
> > > # Caches
> > > #
> > > CONFIG_FSCACHE=m
> > > # CONFIG_FSCACHE_STATS is not set
> > > # CONFIG_FSCACHE_HISTOGRAM is not set
> > > # CONFIG_FSCACHE_DEBUG is not set
> > > # CONFIG_FSCACHE_OBJECT_LIST is not set
> > > # CONFIG_CACHEFILES is not set
> > > # end of Caches
> > > 
> > > #
> > > # CD-ROM/DVD Filesystems
> > > #
> > > CONFIG_ISO9660_FS=m
> > > CONFIG_JOLIET=y
> > > CONFIG_ZISOFS=y
> > > CONFIG_UDF_FS=y
> > > # end of CD-ROM/DVD Filesystems
> > > 
> > > #
> > > # DOS/FAT/EXFAT/NT Filesystems
> > > #
> > > CONFIG_FAT_FS=m
> > > CONFIG_MSDOS_FS=m
> > > # CONFIG_VFAT_FS is not set
> > > CONFIG_FAT_DEFAULT_CODEPAGE=437
> > > # CONFIG_EXFAT_FS is not set
> > > # CONFIG_NTFS_FS is not set
> > > # end of DOS/FAT/EXFAT/NT Filesystems
> > > 
> > > #
> > > # Pseudo filesystems
> > > #
> > > CONFIG_PROC_FS=y
> > > CONFIG_PROC_KCORE=y
> > > CONFIG_PROC_SYSCTL=y
> > > CONFIG_PROC_PAGE_MONITOR=y
> > > CONFIG_PROC_CHILDREN=y
> > > CONFIG_PROC_PID_ARCH_STATUS=y
> > > CONFIG_KERNFS=y
> > > CONFIG_SYSFS=y
> > > CONFIG_TMPFS=y
> > > # CONFIG_TMPFS_POSIX_ACL is not set
> > > CONFIG_TMPFS_XATTR=y
> > > CONFIG_HUGETLBFS=y
> > > CONFIG_HUGETLB_PAGE=y
> > > CONFIG_MEMFD_CREATE=y
> > > CONFIG_CONFIGFS_FS=y
> > > CONFIG_EFIVAR_FS=y
> > > # end of Pseudo filesystems
> > > 
> > > # CONFIG_MISC_FILESYSTEMS is not set
> > > CONFIG_NETWORK_FILESYSTEMS=y
> > > CONFIG_NFS_FS=y
> > > CONFIG_NFS_V2=y
> > > CONFIG_NFS_V3=y
> > > # CONFIG_NFS_V3_ACL is not set
> > > CONFIG_NFS_V4=m
> > > # CONFIG_NFS_V4_1 is not set
> > > # CONFIG_ROOT_NFS is not set
> > > # CONFIG_NFS_USE_LEGACY_DNS is not set
> > > CONFIG_NFS_USE_KERNEL_DNS=y
> > > CONFIG_NFS_DISABLE_UDP_SUPPORT=y
> > > # CONFIG_NFSD is not set
> > > CONFIG_GRACE_PERIOD=y
> > > CONFIG_LOCKD=y
> > > CONFIG_LOCKD_V4=y
> > > CONFIG_NFS_COMMON=y
> > > CONFIG_SUNRPC=y
> > > CONFIG_SUNRPC_GSS=m
> > > # CONFIG_SUNRPC_DEBUG is not set
> > > # CONFIG_CEPH_FS is not set
> > > CONFIG_CIFS=m
> > > # CONFIG_CIFS_STATS2 is not set
> > > CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
> > > # CONFIG_CIFS_WEAK_PW_HASH is not set
> > > # CONFIG_CIFS_UPCALL is not set
> > > # CONFIG_CIFS_XATTR is not set
> > > CONFIG_CIFS_DEBUG=y
> > > # CONFIG_CIFS_DEBUG2 is not set
> > > # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> > > # CONFIG_CIFS_DFS_UPCALL is not set
> > > # CONFIG_CIFS_FSCACHE is not set
> > > # CONFIG_CODA_FS is not set
> > > # CONFIG_AFS_FS is not set
> > > # CONFIG_9P_FS is not set
> > > CONFIG_NLS=y
> > > CONFIG_NLS_DEFAULT="iso8859-1"
> > > CONFIG_NLS_CODEPAGE_437=m
> > > # CONFIG_NLS_CODEPAGE_737 is not set
> > > CONFIG_NLS_CODEPAGE_775=m
> > > CONFIG_NLS_CODEPAGE_850=m
> > > # CONFIG_NLS_CODEPAGE_852 is not set
> > > CONFIG_NLS_CODEPAGE_855=m
> > > CONFIG_NLS_CODEPAGE_857=y
> > > # CONFIG_NLS_CODEPAGE_860 is not set
> > > # CONFIG_NLS_CODEPAGE_861 is not set
> > > CONFIG_NLS_CODEPAGE_862=y
> > > # CONFIG_NLS_CODEPAGE_863 is not set
> > > # CONFIG_NLS_CODEPAGE_864 is not set
> > > # CONFIG_NLS_CODEPAGE_865 is not set
> > > CONFIG_NLS_CODEPAGE_866=y
> > > CONFIG_NLS_CODEPAGE_869=m
> > > # CONFIG_NLS_CODEPAGE_936 is not set
> > > CONFIG_NLS_CODEPAGE_950=y
> > > CONFIG_NLS_CODEPAGE_932=m
> > > CONFIG_NLS_CODEPAGE_949=y
> > > CONFIG_NLS_CODEPAGE_874=m
> > > CONFIG_NLS_ISO8859_8=m
> > > CONFIG_NLS_CODEPAGE_1250=m
> > > # CONFIG_NLS_CODEPAGE_1251 is not set
> > > CONFIG_NLS_ASCII=y
> > > CONFIG_NLS_ISO8859_1=m
> > > # CONFIG_NLS_ISO8859_2 is not set
> > > CONFIG_NLS_ISO8859_3=m
> > > # CONFIG_NLS_ISO8859_4 is not set
> > > CONFIG_NLS_ISO8859_5=y
> > > CONFIG_NLS_ISO8859_6=m
> > > CONFIG_NLS_ISO8859_7=y
> > > CONFIG_NLS_ISO8859_9=y
> > > CONFIG_NLS_ISO8859_13=m
> > > CONFIG_NLS_ISO8859_14=m
> > > CONFIG_NLS_ISO8859_15=m
> > > CONFIG_NLS_KOI8_R=y
> > > # CONFIG_NLS_KOI8_U is not set
> > > CONFIG_NLS_MAC_ROMAN=m
> > > CONFIG_NLS_MAC_CELTIC=y
> > > # CONFIG_NLS_MAC_CENTEURO is not set
> > > CONFIG_NLS_MAC_CROATIAN=m
> > > # CONFIG_NLS_MAC_CYRILLIC is not set
> > > CONFIG_NLS_MAC_GAELIC=y
> > > CONFIG_NLS_MAC_GREEK=m
> > > CONFIG_NLS_MAC_ICELAND=m
> > > CONFIG_NLS_MAC_INUIT=y
> > > CONFIG_NLS_MAC_ROMANIAN=y
> > > CONFIG_NLS_MAC_TURKISH=m
> > > CONFIG_NLS_UTF8=y
> > > # CONFIG_DLM is not set
> > > # CONFIG_UNICODE is not set
> > > CONFIG_IO_WQ=y
> > > # end of File systems
> > > 
> > > #
> > > # Security options
> > > #
> > > CONFIG_KEYS=y
> > > CONFIG_KEYS_REQUEST_CACHE=y
> > > # CONFIG_PERSISTENT_KEYRINGS is not set
> > > # CONFIG_TRUSTED_KEYS is not set
> > > # CONFIG_ENCRYPTED_KEYS is not set
> > > # CONFIG_KEY_DH_OPERATIONS is not set
> > > # CONFIG_KEY_NOTIFICATIONS is not set
> > > # CONFIG_SECURITY_DMESG_RESTRICT is not set
> > > CONFIG_SECURITY=y
> > > CONFIG_SECURITYFS=y
> > > # CONFIG_SECURITY_NETWORK is not set
> > > CONFIG_PAGE_TABLE_ISOLATION=y
> > > CONFIG_SECURITY_PATH=y
> > > # CONFIG_INTEL_TXT is not set
> > > CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> > > # CONFIG_HARDENED_USERCOPY is not set
> > > CONFIG_FORTIFY_SOURCE=y
> > > # CONFIG_STATIC_USERMODEHELPER is not set
> > > # CONFIG_SECURITY_SMACK is not set
> > > # CONFIG_SECURITY_TOMOYO is not set
> > > # CONFIG_SECURITY_APPARMOR is not set
> > > CONFIG_SECURITY_LOADPIN=y
> > > # CONFIG_SECURITY_LOADPIN_ENFORCE is not set
> > > CONFIG_SECURITY_YAMA=y
> > > CONFIG_SECURITY_SAFESETID=y
> > > CONFIG_SECURITY_LOCKDOWN_LSM=y
> > > CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
> > > CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE=y
> > > # CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY is not set
> > > # CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set
> > > CONFIG_INTEGRITY=y
> > > CONFIG_INTEGRITY_SIGNATURE=y
> > > # CONFIG_INTEGRITY_ASYMMETRIC_KEYS is not set
> > > CONFIG_IMA=y
> > > CONFIG_IMA_MEASURE_PCR_IDX=10
> > > CONFIG_IMA_TEMPLATE=y
> > > # CONFIG_IMA_NG_TEMPLATE is not set
> > > # CONFIG_IMA_SIG_TEMPLATE is not set
> > > CONFIG_IMA_DEFAULT_TEMPLATE="ima"
> > > CONFIG_IMA_DEFAULT_HASH_SHA1=y
> > > CONFIG_IMA_DEFAULT_HASH="sha1"
> > > # CONFIG_IMA_WRITE_POLICY is not set
> > > # CONFIG_IMA_READ_POLICY is not set
> > > CONFIG_IMA_APPRAISE=y
> > > CONFIG_IMA_APPRAISE_BOOTPARAM=y
> > > CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
> > > CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
> > > # CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
> > > # CONFIG_EVM is not set
> > > CONFIG_DEFAULT_SECURITY_DAC=y
> > > CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"
> > > 
> > > #
> > > # Kernel hardening options
> > > #
> > > 
> > > #
> > > # Memory initialization
> > > #
> > > CONFIG_INIT_STACK_NONE=y
> > > # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> > > # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> > > # end of Memory initialization
> > > # end of Kernel hardening options
> > > # end of Security options
> > > 
> > > CONFIG_XOR_BLOCKS=m
> > > CONFIG_ASYNC_CORE=m
> > > CONFIG_ASYNC_MEMCPY=m
> > > CONFIG_ASYNC_XOR=m
> > > CONFIG_ASYNC_PQ=m
> > > CONFIG_ASYNC_RAID6_RECOV=m
> > > CONFIG_CRYPTO=y
> > > 
> > > #
> > > # Crypto core or helper
> > > #
> > > CONFIG_CRYPTO_ALGAPI=y
> > > CONFIG_CRYPTO_ALGAPI2=y
> > > CONFIG_CRYPTO_AEAD=y
> > > CONFIG_CRYPTO_AEAD2=y
> > > CONFIG_CRYPTO_SKCIPHER=y
> > > CONFIG_CRYPTO_SKCIPHER2=y
> > > CONFIG_CRYPTO_HASH=y
> > > CONFIG_CRYPTO_HASH2=y
> > > CONFIG_CRYPTO_RNG=y
> > > CONFIG_CRYPTO_RNG2=y
> > > CONFIG_CRYPTO_RNG_DEFAULT=y
> > > CONFIG_CRYPTO_AKCIPHER2=y
> > > CONFIG_CRYPTO_AKCIPHER=y
> > > CONFIG_CRYPTO_KPP2=y
> > > CONFIG_CRYPTO_KPP=y
> > > CONFIG_CRYPTO_ACOMP2=y
> > > CONFIG_CRYPTO_MANAGER=y
> > > CONFIG_CRYPTO_MANAGER2=y
> > > # CONFIG_CRYPTO_USER is not set
> > > CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> > > CONFIG_CRYPTO_GF128MUL=m
> > > CONFIG_CRYPTO_NULL=y
> > > CONFIG_CRYPTO_NULL2=y
> > > CONFIG_CRYPTO_CRYPTD=m
> > > CONFIG_CRYPTO_AUTHENC=m
> > > CONFIG_CRYPTO_TEST=m
> > > CONFIG_CRYPTO_SIMD=m
> > > CONFIG_CRYPTO_GLUE_HELPER_X86=m
> > > 
> > > #
> > > # Public-key cryptography
> > > #
> > > CONFIG_CRYPTO_RSA=y
> > > # CONFIG_CRYPTO_DH is not set
> > > CONFIG_CRYPTO_ECC=y
> > > CONFIG_CRYPTO_ECDH=y
> > > CONFIG_CRYPTO_ECRDSA=m
> > > CONFIG_CRYPTO_CURVE25519=y
> > > 
> > > #
> > > # Authenticated Encryption with Associated Data
> > > #
> > > CONFIG_CRYPTO_CCM=y
> > > CONFIG_CRYPTO_GCM=m
> > > CONFIG_CRYPTO_CHACHA20POLY1305=m
> > > CONFIG_CRYPTO_AEGIS128=y
> > > CONFIG_CRYPTO_SEQIV=y
> > > # CONFIG_CRYPTO_ECHAINIV is not set
> > > 
> > > #
> > > # Block modes
> > > #
> > > CONFIG_CRYPTO_CBC=y
> > > CONFIG_CRYPTO_CFB=m
> > > CONFIG_CRYPTO_CTR=y
> > > CONFIG_CRYPTO_CTS=y
> > > CONFIG_CRYPTO_ECB=y
> > > # CONFIG_CRYPTO_LRW is not set
> > > # CONFIG_CRYPTO_OFB is not set
> > > CONFIG_CRYPTO_PCBC=y
> > > CONFIG_CRYPTO_XTS=y
> > > CONFIG_CRYPTO_KEYWRAP=y
> > > CONFIG_CRYPTO_NHPOLY1305=m
> > > CONFIG_CRYPTO_ADIANTUM=m
> > > CONFIG_CRYPTO_ESSIV=m
> > > 
> > > #
> > > # Hash modes
> > > #
> > > CONFIG_CRYPTO_CMAC=y
> > > CONFIG_CRYPTO_HMAC=y
> > > CONFIG_CRYPTO_XCBC=m
> > > # CONFIG_CRYPTO_VMAC is not set
> > > 
> > > #
> > > # Digest
> > > #
> > > CONFIG_CRYPTO_CRC32C=y
> > > CONFIG_CRYPTO_CRC32C_INTEL=y
> > > # CONFIG_CRYPTO_CRC32 is not set
> > > # CONFIG_CRYPTO_CRC32_PCLMUL is not set
> > > CONFIG_CRYPTO_XXHASH=m
> > > CONFIG_CRYPTO_BLAKE2B=y
> > > CONFIG_CRYPTO_BLAKE2S=y
> > > CONFIG_CRYPTO_CRCT10DIF=y
> > > CONFIG_CRYPTO_GHASH=m
> > > CONFIG_CRYPTO_POLY1305=m
> > > CONFIG_CRYPTO_MD4=m
> > > CONFIG_CRYPTO_MD5=y
> > > # CONFIG_CRYPTO_MICHAEL_MIC is not set
> > > # CONFIG_CRYPTO_RMD128 is not set
> > > CONFIG_CRYPTO_RMD160=y
> > > CONFIG_CRYPTO_RMD256=m
> > > # CONFIG_CRYPTO_RMD320 is not set
> > > CONFIG_CRYPTO_SHA1=y
> > > CONFIG_CRYPTO_SHA256=y
> > > CONFIG_CRYPTO_SHA512=y
> > > # CONFIG_CRYPTO_SHA3 is not set
> > > CONFIG_CRYPTO_SM3=m
> > > CONFIG_CRYPTO_STREEBOG=m
> > > CONFIG_CRYPTO_TGR192=y
> > > CONFIG_CRYPTO_WP512=m
> > > 
> > > #
> > > # Ciphers
> > > #
> > > CONFIG_CRYPTO_AES=y
> > > # CONFIG_CRYPTO_AES_TI is not set
> > > # CONFIG_CRYPTO_AES_NI_INTEL is not set
> > > CONFIG_CRYPTO_ANUBIS=y
> > > # CONFIG_CRYPTO_ARC4 is not set
> > > CONFIG_CRYPTO_BLOWFISH=y
> > > CONFIG_CRYPTO_BLOWFISH_COMMON=y
> > > # CONFIG_CRYPTO_CAMELLIA is not set
> > > CONFIG_CRYPTO_CAST_COMMON=y
> > > # CONFIG_CRYPTO_CAST5 is not set
> > > CONFIG_CRYPTO_CAST6=y
> > > CONFIG_CRYPTO_DES=m
> > > # CONFIG_CRYPTO_FCRYPT is not set
> > > # CONFIG_CRYPTO_KHAZAD is not set
> > > # CONFIG_CRYPTO_SALSA20 is not set
> > > CONFIG_CRYPTO_CHACHA20=y
> > > CONFIG_CRYPTO_SEED=y
> > > CONFIG_CRYPTO_SERPENT=y
> > > CONFIG_CRYPTO_SERPENT_SSE2_586=m
> > > # CONFIG_CRYPTO_SM4 is not set
> > > # CONFIG_CRYPTO_TEA is not set
> > > # CONFIG_CRYPTO_TWOFISH is not set
> > > CONFIG_CRYPTO_TWOFISH_COMMON=y
> > > CONFIG_CRYPTO_TWOFISH_586=y
> > > 
> > > #
> > > # Compression
> > > #
> > > CONFIG_CRYPTO_DEFLATE=m
> > > CONFIG_CRYPTO_LZO=y
> > > CONFIG_CRYPTO_842=y
> > > # CONFIG_CRYPTO_LZ4 is not set
> > > CONFIG_CRYPTO_LZ4HC=y
> > > # CONFIG_CRYPTO_ZSTD is not set
> > > 
> > > #
> > > # Random Number Generation
> > > #
> > > # CONFIG_CRYPTO_ANSI_CPRNG is not set
> > > CONFIG_CRYPTO_DRBG_MENU=y
> > > CONFIG_CRYPTO_DRBG_HMAC=y
> > > # CONFIG_CRYPTO_DRBG_HASH is not set
> > > # CONFIG_CRYPTO_DRBG_CTR is not set
> > > CONFIG_CRYPTO_DRBG=y
> > > CONFIG_CRYPTO_JITTERENTROPY=y
> > > # CONFIG_CRYPTO_USER_API_HASH is not set
> > > # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> > > # CONFIG_CRYPTO_USER_API_RNG is not set
> > > # CONFIG_CRYPTO_USER_API_AEAD is not set
> > > CONFIG_CRYPTO_HASH_INFO=y
> > > 
> > > #
> > > # Crypto library routines
> > > #
> > > CONFIG_CRYPTO_LIB_AES=y
> > > CONFIG_CRYPTO_LIB_ARC4=m
> > > CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
> > > CONFIG_CRYPTO_LIB_BLAKE2S=y
> > > CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
> > > # CONFIG_CRYPTO_LIB_CHACHA is not set
> > > CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
> > > CONFIG_CRYPTO_LIB_CURVE25519=m
> > > CONFIG_CRYPTO_LIB_DES=m
> > > CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
> > > CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
> > > # CONFIG_CRYPTO_LIB_POLY1305 is not set
> > > # CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
> > > CONFIG_CRYPTO_LIB_SHA256=y
> > > # CONFIG_CRYPTO_HW is not set
> > > CONFIG_ASYMMETRIC_KEY_TYPE=y
> > > CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> > > CONFIG_X509_CERTIFICATE_PARSER=y
> > > CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
> > > CONFIG_PKCS7_MESSAGE_PARSER=y
> > > CONFIG_PKCS7_TEST_KEY=y
> > > # CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
> > > 
> > > #
> > > # Certificates for signature checking
> > > #
> > > CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
> > > CONFIG_SYSTEM_TRUSTED_KEYRING=y
> > > CONFIG_SYSTEM_TRUSTED_KEYS=""
> > > CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
> > > CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
> > > # CONFIG_SECONDARY_TRUSTED_KEYRING is not set
> > > # CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
> > > # end of Certificates for signature checking
> > > 
> > > CONFIG_BINARY_PRINTF=y
> > > 
> > > #
> > > # Library routines
> > > #
> > > CONFIG_RAID6_PQ=m
> > > CONFIG_RAID6_PQ_BENCHMARK=y
> > > CONFIG_LINEAR_RANGES=y
> > > CONFIG_PACKING=y
> > > CONFIG_BITREVERSE=y
> > > CONFIG_GENERIC_STRNCPY_FROM_USER=y
> > > CONFIG_GENERIC_STRNLEN_USER=y
> > > CONFIG_GENERIC_NET_UTILS=y
> > > CONFIG_GENERIC_FIND_FIRST_BIT=y
> > > CONFIG_CORDIC=y
> > > # CONFIG_PRIME_NUMBERS is not set
> > > CONFIG_RATIONAL=y
> > > CONFIG_GENERIC_PCI_IOMAP=y
> > > CONFIG_GENERIC_IOMAP=y
> > > CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> > > CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
> > > # CONFIG_CRC_CCITT is not set
> > > CONFIG_CRC16=y
> > > CONFIG_CRC_T10DIF=y
> > > CONFIG_CRC_ITU_T=y
> > > CONFIG_CRC32=y
> > > CONFIG_CRC32_SELFTEST=y
> > > CONFIG_CRC32_SLICEBY8=y
> > > # CONFIG_CRC32_SLICEBY4 is not set
> > > # CONFIG_CRC32_SARWATE is not set
> > > # CONFIG_CRC32_BIT is not set
> > > CONFIG_CRC64=y
> > > CONFIG_CRC4=y
> > > CONFIG_CRC7=m
> > > CONFIG_LIBCRC32C=m
> > > CONFIG_CRC8=m
> > > CONFIG_XXHASH=m
> > > # CONFIG_RANDOM32_SELFTEST is not set
> > > CONFIG_842_COMPRESS=y
> > > CONFIG_842_DECOMPRESS=y
> > > CONFIG_ZLIB_INFLATE=y
> > > CONFIG_ZLIB_DEFLATE=m
> > > CONFIG_LZO_COMPRESS=y
> > > CONFIG_LZO_DECOMPRESS=y
> > > CONFIG_LZ4HC_COMPRESS=y
> > > CONFIG_LZ4_DECOMPRESS=y
> > > CONFIG_ZSTD_COMPRESS=m
> > > CONFIG_ZSTD_DECOMPRESS=m
> > > CONFIG_XZ_DEC=y
> > > CONFIG_XZ_DEC_X86=y
> > > CONFIG_XZ_DEC_POWERPC=y
> > > CONFIG_XZ_DEC_IA64=y
> > > CONFIG_XZ_DEC_ARM=y
> > > CONFIG_XZ_DEC_ARMTHUMB=y
> > > CONFIG_XZ_DEC_SPARC=y
> > > CONFIG_XZ_DEC_BCJ=y
> > > # CONFIG_XZ_DEC_TEST is not set
> > > CONFIG_DECOMPRESS_GZIP=y
> > > CONFIG_DECOMPRESS_BZIP2=y
> > > CONFIG_DECOMPRESS_LZMA=y
> > > CONFIG_DECOMPRESS_XZ=y
> > > CONFIG_DECOMPRESS_LZO=y
> > > CONFIG_GENERIC_ALLOCATOR=y
> > > CONFIG_REED_SOLOMON=m
> > > CONFIG_REED_SOLOMON_DEC16=y
> > > CONFIG_BCH=m
> > > CONFIG_BCH_CONST_PARAMS=y
> > > CONFIG_XARRAY_MULTI=y
> > > CONFIG_ASSOCIATIVE_ARRAY=y
> > > CONFIG_HAS_IOMEM=y
> > > CONFIG_HAS_IOPORT_MAP=y
> > > CONFIG_HAS_DMA=y
> > > CONFIG_NEED_SG_DMA_LENGTH=y
> > > CONFIG_NEED_DMA_MAP_STATE=y
> > > CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> > > CONFIG_SWIOTLB=y
> > > # CONFIG_DMA_API_DEBUG is not set
> > > CONFIG_SGL_ALLOC=y
> > > CONFIG_CHECK_SIGNATURE=y
> > > CONFIG_DQL=y
> > > CONFIG_GLOB=y
> > > CONFIG_GLOB_SELFTEST=m
> > > CONFIG_NLATTR=y
> > > CONFIG_CLZ_TAB=y
> > > CONFIG_IRQ_POLL=y
> > > CONFIG_MPILIB=y
> > > CONFIG_SIGNATURE=y
> > > CONFIG_OID_REGISTRY=y
> > > CONFIG_UCS2_STRING=y
> > > CONFIG_HAVE_GENERIC_VDSO=y
> > > CONFIG_GENERIC_GETTIMEOFDAY=y
> > > CONFIG_GENERIC_VDSO_32=y
> > > CONFIG_GENERIC_VDSO_TIME_NS=y
> > > CONFIG_FONT_SUPPORT=y
> > > # CONFIG_FONTS is not set
> > > CONFIG_FONT_8x8=y
> > > CONFIG_FONT_8x16=y
> > > CONFIG_SG_POOL=y
> > > CONFIG_MEMREGION=y
> > > CONFIG_ARCH_STACKWALK=y
> > > CONFIG_SBITMAP=y
> > > CONFIG_STRING_SELFTEST=m
> > > # end of Library routines
> > > 
> > > #
> > > # Kernel hacking
> > > #
> > > 
> > > #
> > > # printk and dmesg options
> > > #
> > > CONFIG_PRINTK_TIME=y
> > > # CONFIG_PRINTK_CALLER is not set
> > > CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> > > CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> > > CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> > > CONFIG_BOOT_PRINTK_DELAY=y
> > > CONFIG_DYNAMIC_DEBUG=y
> > > CONFIG_DYNAMIC_DEBUG_CORE=y
> > > # CONFIG_SYMBOLIC_ERRNAME is not set
> > > CONFIG_DEBUG_BUGVERBOSE=y
> > > # end of printk and dmesg options
> > > 
> > > #
> > > # Compile-time checks and compiler options
> > > #
> > > CONFIG_DEBUG_INFO=y
> > > CONFIG_DEBUG_INFO_REDUCED=y
> > > # CONFIG_DEBUG_INFO_COMPRESSED is not set
> > > # CONFIG_DEBUG_INFO_SPLIT is not set
> > > # CONFIG_DEBUG_INFO_DWARF4 is not set
> > > # CONFIG_GDB_SCRIPTS is not set
> > > CONFIG_ENABLE_MUST_CHECK=y
> > > CONFIG_FRAME_WARN=1024
> > > # CONFIG_STRIP_ASM_SYMS is not set
> > > # CONFIG_READABLE_ASM is not set
> > > CONFIG_HEADERS_INSTALL=y
> > > CONFIG_DEBUG_SECTION_MISMATCH=y
> > > CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> > > CONFIG_FRAME_POINTER=y
> > > CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
> > > # end of Compile-time checks and compiler options
> > > 
> > > #
> > > # Generic Kernel Debugging Instruments
> > > #
> > > CONFIG_MAGIC_SYSRQ=y
> > > CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> > > CONFIG_MAGIC_SYSRQ_SERIAL=y
> > > CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
> > > CONFIG_DEBUG_FS=y
> > > CONFIG_HAVE_ARCH_KGDB=y
> > > # CONFIG_KGDB is not set
> > > CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> > > CONFIG_UBSAN=y
> > > # CONFIG_UBSAN_TRAP is not set
> > > CONFIG_UBSAN_BOUNDS=y
> > > # CONFIG_UBSAN_MISC is not set
> > > CONFIG_UBSAN_SANITIZE_ALL=y
> > > # CONFIG_UBSAN_ALIGNMENT is not set
> > > CONFIG_TEST_UBSAN=m
> > > # end of Generic Kernel Debugging Instruments
> > > 
> > > CONFIG_DEBUG_KERNEL=y
> > > CONFIG_DEBUG_MISC=y
> > > 
> > > #
> > > # Memory Debugging
> > > #
> > > CONFIG_PAGE_EXTENSION=y
> > > # CONFIG_DEBUG_PAGEALLOC is not set
> > > # CONFIG_PAGE_OWNER is not set
> > > CONFIG_PAGE_POISONING=y
> > > # CONFIG_PAGE_POISONING_NO_SANITY is not set
> > > # CONFIG_PAGE_POISONING_ZERO is not set
> > > CONFIG_DEBUG_PAGE_REF=y
> > > CONFIG_DEBUG_RODATA_TEST=y
> > > CONFIG_ARCH_HAS_DEBUG_WX=y
> > > # CONFIG_DEBUG_WX is not set
> > > CONFIG_GENERIC_PTDUMP=y
> > > # CONFIG_PTDUMP_DEBUGFS is not set
> > > # CONFIG_DEBUG_OBJECTS is not set
> > > CONFIG_DEBUG_SLAB=y
> > > CONFIG_HAVE_DEBUG_KMEMLEAK=y
> > > CONFIG_DEBUG_KMEMLEAK=y
> > > CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
> > > CONFIG_DEBUG_KMEMLEAK_TEST=m
> > > # CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
> > > CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
> > > CONFIG_DEBUG_STACK_USAGE=y
> > > # CONFIG_SCHED_STACK_END_CHECK is not set
> > > # CONFIG_DEBUG_VM is not set
> > > CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> > > # CONFIG_DEBUG_VIRTUAL is not set
> > > CONFIG_DEBUG_MEMORY_INIT=y
> > > CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
> > > # CONFIG_DEBUG_STACKOVERFLOW is not set
> > > CONFIG_CC_HAS_KASAN_GENERIC=y
> > > CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> > > CONFIG_KASAN_STACK=1
> > > # end of Memory Debugging
> > > 
> > > CONFIG_DEBUG_SHIRQ=y
> > > 
> > > #
> > > # Debug Oops, Lockups and Hangs
> > > #
> > > # CONFIG_PANIC_ON_OOPS is not set
> > > CONFIG_PANIC_ON_OOPS_VALUE=0
> > > CONFIG_PANIC_TIMEOUT=0
> > > CONFIG_LOCKUP_DETECTOR=y
> > > CONFIG_SOFTLOCKUP_DETECTOR=y
> > > # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> > > CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
> > > # CONFIG_HARDLOCKUP_DETECTOR is not set
> > > # CONFIG_DETECT_HUNG_TASK is not set
> > > # CONFIG_WQ_WATCHDOG is not set
> > > # CONFIG_TEST_LOCKUP is not set
> > > # end of Debug Oops, Lockups and Hangs
> > > 
> > > #
> > > # Scheduler Debugging
> > > #
> > > CONFIG_SCHED_DEBUG=y
> > > CONFIG_SCHED_INFO=y
> > > CONFIG_SCHEDSTATS=y
> > > # end of Scheduler Debugging
> > > 
> > > # CONFIG_DEBUG_TIMEKEEPING is not set
> > > 
> > > #
> > > # Lock Debugging (spinlocks, mutexes, etc...)
> > > #
> > > CONFIG_LOCK_DEBUGGING_SUPPORT=y
> > > # CONFIG_PROVE_LOCKING is not set
> > > CONFIG_LOCK_STAT=y
> > > CONFIG_DEBUG_RT_MUTEXES=y
> > > CONFIG_DEBUG_SPINLOCK=y
> > > CONFIG_DEBUG_MUTEXES=y
> > > CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> > > CONFIG_DEBUG_RWSEMS=y
> > > CONFIG_DEBUG_LOCK_ALLOC=y
> > > CONFIG_LOCKDEP=y
> > > # CONFIG_DEBUG_LOCKDEP is not set
> > > CONFIG_DEBUG_ATOMIC_SLEEP=y
> > > CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
> > > # CONFIG_LOCK_TORTURE_TEST is not set
> > > CONFIG_WW_MUTEX_SELFTEST=m
> > > # end of Lock Debugging (spinlocks, mutexes, etc...)
> > > 
> > > CONFIG_TRACE_IRQFLAGS=y
> > > CONFIG_STACKTRACE=y
> > > # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> > > # CONFIG_DEBUG_KOBJECT is not set
> > > 
> > > #
> > > # Debug kernel data structures
> > > #
> > > CONFIG_DEBUG_LIST=y
> > > # CONFIG_DEBUG_PLIST is not set
> > > # CONFIG_DEBUG_SG is not set
> > > # CONFIG_DEBUG_NOTIFIERS is not set
> > > CONFIG_BUG_ON_DATA_CORRUPTION=y
> > > # end of Debug kernel data structures
> > > 
> > > CONFIG_DEBUG_CREDENTIALS=y
> > > 
> > > #
> > > # RCU Debugging
> > > #
> > > CONFIG_TORTURE_TEST=y
> > > CONFIG_RCU_PERF_TEST=m
> > > CONFIG_RCU_TORTURE_TEST=m
> > > CONFIG_RCU_REF_SCALE_TEST=y
> > > # CONFIG_RCU_TRACE is not set
> > > CONFIG_RCU_EQS_DEBUG=y
> > > # end of RCU Debugging
> > > 
> > > CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
> > > # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> > > CONFIG_LATENCYTOP=y
> > > CONFIG_USER_STACKTRACE_SUPPORT=y
> > > CONFIG_NOP_TRACER=y
> > > CONFIG_HAVE_FUNCTION_TRACER=y
> > > CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> > > CONFIG_HAVE_DYNAMIC_FTRACE=y
> > > CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> > > CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> > > CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> > > CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> > > CONFIG_HAVE_FENTRY=y
> > > CONFIG_HAVE_C_RECORDMCOUNT=y
> > > CONFIG_TRACER_MAX_TRACE=y
> > > CONFIG_TRACE_CLOCK=y
> > > CONFIG_RING_BUFFER=y
> > > CONFIG_EVENT_TRACING=y
> > > CONFIG_CONTEXT_SWITCH_TRACER=y
> > > CONFIG_RING_BUFFER_ALLOW_SWAP=y
> > > CONFIG_PREEMPTIRQ_TRACEPOINTS=y
> > > CONFIG_TRACING=y
> > > CONFIG_GENERIC_TRACER=y
> > > CONFIG_TRACING_SUPPORT=y
> > > CONFIG_FTRACE=y
> > > CONFIG_BOOTTIME_TRACING=y
> > > CONFIG_FUNCTION_TRACER=y
> > > CONFIG_DYNAMIC_FTRACE=y
> > > CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
> > > CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> > > CONFIG_FUNCTION_PROFILER=y
> > > # CONFIG_STACK_TRACER is not set
> > > CONFIG_IRQSOFF_TRACER=y
> > > # CONFIG_SCHED_TRACER is not set
> > > CONFIG_HWLAT_TRACER=y
> > > # CONFIG_MMIOTRACE is not set
> > > # CONFIG_FTRACE_SYSCALLS is not set
> > > CONFIG_TRACER_SNAPSHOT=y
> > > CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
> > > CONFIG_BRANCH_PROFILE_NONE=y
> > > # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> > > CONFIG_BLK_DEV_IO_TRACE=y
> > > # CONFIG_UPROBE_EVENTS is not set
> > > CONFIG_DYNAMIC_EVENTS=y
> > > CONFIG_FTRACE_MCOUNT_RECORD=y
> > > CONFIG_SYNTH_EVENTS=y
> > > # CONFIG_HIST_TRIGGERS is not set
> > > # CONFIG_TRACE_EVENT_INJECT is not set
> > > CONFIG_TRACEPOINT_BENCHMARK=y
> > > CONFIG_RING_BUFFER_BENCHMARK=y
> > > # CONFIG_TRACE_EVAL_MAP_FILE is not set
> > > # CONFIG_GCOV_PROFILE_FTRACE is not set
> > > # CONFIG_FTRACE_STARTUP_TEST is not set
> > > # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> > > CONFIG_PREEMPTIRQ_DELAY_TEST=m
> > > CONFIG_SYNTH_EVENT_GEN_TEST=y
> > > CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
> > > # CONFIG_SAMPLES is not set
> > > CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> > > # CONFIG_STRICT_DEVMEM is not set
> > > 
> > > #
> > > # x86 Debugging
> > > #
> > > CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> > > CONFIG_EARLY_PRINTK_USB=y
> > > CONFIG_X86_VERBOSE_BOOTUP=y
> > > CONFIG_EARLY_PRINTK=y
> > > # CONFIG_EARLY_PRINTK_DBGP is not set
> > > CONFIG_EARLY_PRINTK_USB_XDBC=y
> > > # CONFIG_EFI_PGT_DUMP is not set
> > > CONFIG_DEBUG_TLBFLUSH=y
> > > CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> > > # CONFIG_X86_DECODER_SELFTEST is not set
> > > # CONFIG_IO_DELAY_0X80 is not set
> > > CONFIG_IO_DELAY_0XED=y
> > > # CONFIG_IO_DELAY_UDELAY is not set
> > > # CONFIG_IO_DELAY_NONE is not set
> > > CONFIG_DEBUG_BOOT_PARAMS=y
> > > # CONFIG_CPA_DEBUG is not set
> > > # CONFIG_DEBUG_ENTRY is not set
> > > CONFIG_DEBUG_NMI_SELFTEST=y
> > > # CONFIG_X86_DEBUG_FPU is not set
> > > # CONFIG_PUNIT_ATOM_DEBUG is not set
> > > CONFIG_UNWINDER_FRAME_POINTER=y
> > > # end of x86 Debugging
> > > 
> > > #
> > > # Kernel Testing and Coverage
> > > #
> > > CONFIG_KUNIT=y
> > > CONFIG_KUNIT_DEBUGFS=y
> > > CONFIG_KUNIT_TEST=m
> > > CONFIG_KUNIT_EXAMPLE_TEST=m
> > > CONFIG_KUNIT_ALL_TESTS=m
> > > CONFIG_NOTIFIER_ERROR_INJECTION=m
> > > CONFIG_PM_NOTIFIER_ERROR_INJECT=m
> > > # CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
> > > CONFIG_FAULT_INJECTION=y
> > > CONFIG_FAILSLAB=y
> > > # CONFIG_FAIL_PAGE_ALLOC is not set
> > > CONFIG_FAIL_MAKE_REQUEST=y
> > > # CONFIG_FAIL_IO_TIMEOUT is not set
> > > CONFIG_FAIL_FUTEX=y
> > > # CONFIG_FAULT_INJECTION_DEBUG_FS is not set
> > > CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> > > CONFIG_RUNTIME_TESTING_MENU=y
> > > # CONFIG_LKDTM is not set
> > > # CONFIG_TEST_LIST_SORT is not set
> > > # CONFIG_TEST_MIN_HEAP is not set
> > > # CONFIG_TEST_SORT is not set
> > > # CONFIG_BACKTRACE_SELF_TEST is not set
> > > # CONFIG_RBTREE_TEST is not set
> > > # CONFIG_REED_SOLOMON_TEST is not set
> > > # CONFIG_INTERVAL_TREE_TEST is not set
> > > # CONFIG_PERCPU_TEST is not set
> > > CONFIG_ATOMIC64_SELFTEST=y
> > > # CONFIG_ASYNC_RAID6_TEST is not set
> > > # CONFIG_TEST_HEXDUMP is not set
> > > # CONFIG_TEST_STRING_HELPERS is not set
> > > CONFIG_TEST_STRSCPY=m
> > > # CONFIG_TEST_KSTRTOX is not set
> > > # CONFIG_TEST_PRINTF is not set
> > > CONFIG_TEST_BITMAP=y
> > > # CONFIG_TEST_BITFIELD is not set
> > > # CONFIG_TEST_UUID is not set
> > > # CONFIG_TEST_XARRAY is not set
> > > # CONFIG_TEST_OVERFLOW is not set
> > > # CONFIG_TEST_RHASHTABLE is not set
> > > # CONFIG_TEST_HASH is not set
> > > # CONFIG_TEST_IDA is not set
> > > CONFIG_TEST_LKM=m
> > > CONFIG_TEST_BITOPS=m
> > > # CONFIG_TEST_VMALLOC is not set
> > > CONFIG_TEST_USER_COPY=m
> > > # CONFIG_TEST_BPF is not set
> > > # CONFIG_TEST_BLACKHOLE_DEV is not set
> > > # CONFIG_FIND_BIT_BENCHMARK is not set
> > > # CONFIG_TEST_FIRMWARE is not set
> > > CONFIG_TEST_SYSCTL=y
> > > CONFIG_SYSCTL_KUNIT_TEST=m
> > > # CONFIG_LIST_KUNIT_TEST is not set
> > > # CONFIG_LINEAR_RANGES_TEST is not set
> > > # CONFIG_TEST_UDELAY is not set
> > > # CONFIG_TEST_STATIC_KEYS is not set
> > > # CONFIG_TEST_KMOD is not set
> > > # CONFIG_TEST_MEMCAT_P is not set
> > > # CONFIG_TEST_STACKINIT is not set
> > > # CONFIG_TEST_MEMINIT is not set
> > > # CONFIG_MEMTEST is not set
> > > # end of Kernel Testing and Coverage
> > > # end of Kernel hacking
> > > #!/bin/sh
> > > 
> > > export_top_env()
> > > {
> > > 	export suite='trinity'
> > > 	export testcase='trinity'
> > > 	export category='functional'
> > > 	export need_memory='300MB'
> > > 	export runtime=300
> > > 	export job_origin='/lkp-src/allot/rand/vm-snb-i386/trinity.yaml'
> > > 	export queue_cmdline_keys='branch
> > > commit
> > > queue_at_least_once'
> > > 	export queue='validate'
> > > 	export testbox='vm-snb-i386-61'
> > > 	export tbox_group='vm-snb-i386'
> > > 	export branch='linux-devel/devel-hourly-2020070406'
> > > 	export commit='8e4ec3d02b549a731c94b4bcddff212bb92cdbaf'
> > > 	export kconfig='i386-randconfig-a005-20200701'
> > > 	export repeat_to=4
> > > 	export nr_vm=64
> > > 	export submit_id='5f0108d6faf42638ef7b7f63'
> > > 	export job_file='/lkp/jobs/scheduled/vm-snb-i386-61/trinity-300s-quantal-i386-core-20190426.cgz-8e4ec3d02b549a731c94b4bcddff212bb92cdbaf-20200705-14575-1jh6udu-2.yaml'
> > > 	export id='4f7429f54a24489ca7285aab853d1bbfc73178fe'
> > > 	export queuer_version='/lkp-src'
> > > 	export model='qemu-system-i386 -enable-kvm -cpu SandyBridge'
> > > 	export nr_cpu=2
> > > 	export memory='16G'
> > > 	export hdd_partitions='/dev/vda /dev/vdb /dev/vdc /dev/vdd /dev/vde /dev/vdf'
> > > 	export swap_partitions='/dev/vdg'
> > > 	export need_kconfig='CONFIG_KVM_GUEST=y'
> > > 	export ssh_base_port=23032
> > > 	export rootfs='quantal-i386-core-20190426.cgz'
> > > 	export compiler='gcc-9'
> > > 	export enqueue_time='2020-07-05 06:55:18 +0800'
> > > 	export _id='5f0108d6faf42638ef7b7f63'
> > > 	export _rt='/result/trinity/300s/vm-snb-i386/quantal-i386-core-20190426.cgz/i386-randconfig-a005-20200701/gcc-9/8e4ec3d02b549a731c94b4bcddff212bb92cdbaf'
> > > 	export user='lkp'
> > > 	export result_root='/result/trinity/300s/vm-snb-i386/quantal-i386-core-20190426.cgz/i386-randconfig-a005-20200701/gcc-9/8e4ec3d02b549a731c94b4bcddff212bb92cdbaf/3'
> > > 	export scheduler_version='/lkp/lkp/.src-20200703-182242'
> > > 	export LKP_SERVER='inn'
> > > 	export arch='i386'
> > > 	export max_uptime=1500
> > > 	export initrd='/osimage/quantal/quantal-i386-core-20190426.cgz'
> > > 	export bootloader_append='root=/dev/ram0
> > > user=lkp
> > > job=/lkp/jobs/scheduled/vm-snb-i386-61/trinity-300s-quantal-i386-core-20190426.cgz-8e4ec3d02b549a731c94b4bcddff212bb92cdbaf-20200705-14575-1jh6udu-2.yaml
> > > ARCH=i386
> > > kconfig=i386-randconfig-a005-20200701
> > > branch=linux-devel/devel-hourly-2020070406
> > > commit=8e4ec3d02b549a731c94b4bcddff212bb92cdbaf
> > > BOOT_IMAGE=/pkg/linux/i386-randconfig-a005-20200701/gcc-9/8e4ec3d02b549a731c94b4bcddff212bb92cdbaf/vmlinuz-5.8.0-rc3-00028-g8e4ec3d02b549
> > > max_uptime=1500
> > > RESULT_ROOT=/result/trinity/300s/vm-snb-i386/quantal-i386-core-20190426.cgz/i386-randconfig-a005-20200701/gcc-9/8e4ec3d02b549a731c94b4bcddff212bb92cdbaf/3
> > > LKP_SERVER=inn
> > > selinux=0
> > > debug
> > > apic=debug
> > > sysrq_always_enabled
> > > rcupdate.rcu_cpu_stall_timeout=100
> > > net.ifnames=0
> > > printk.devkmsg=on
> > > panic=-1
> > > softlockup_panic=1
> > > nmi_watchdog=panic
> > > oops=panic
> > > load_ramdisk=2
> > > prompt_ramdisk=0
> > > drbd.minor_count=8
> > > systemd.log_level=err
> > > ignore_loglevel
> > > console=tty0
> > > earlyprintk=ttyS0,115200
> > > console=ttyS0,115200
> > > vga=normal
> > > rw'
> > > 	export modules_initrd='/pkg/linux/i386-randconfig-a005-20200701/gcc-9/8e4ec3d02b549a731c94b4bcddff212bb92cdbaf/modules.cgz'
> > > 	export bm_initrd='/osimage/pkg/quantal-i386-core.cgz/trinity-static-i386-x86_64-f93256fb_2019-08-28.cgz'
> > > 	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
> > > 	export site='inn'
> > > 	export LKP_CGI_PORT=80
> > > 	export LKP_CIFS_PORT=139
> > > 	export schedule_notify_address=
> > > 	export queue_at_least_once=1
> > > 	export kernel='/pkg/linux/i386-randconfig-a005-20200701/gcc-9/8e4ec3d02b549a731c94b4bcddff212bb92cdbaf/vmlinuz-5.8.0-rc3-00028-g8e4ec3d02b549'
> > > 	export dequeue_time='2020-07-05 11:11:01 +0800'
> > > 	export job_initrd='/lkp/jobs/scheduled/vm-snb-i386-61/trinity-300s-quantal-i386-core-20190426.cgz-8e4ec3d02b549a731c94b4bcddff212bb92cdbaf-20200705-14575-1jh6udu-2.cgz'
> > > 
> > > 	[ -n "$LKP_SRC" ] ||
> > > 	export LKP_SRC=/lkp/${user:-lkp}/src
> > > }
> > > 
> > > run_job()
> > > {
> > > 	echo $$ > $TMP/run-job.pid
> > > 
> > > 	. $LKP_SRC/lib/http.sh
> > > 	. $LKP_SRC/lib/job.sh
> > > 	. $LKP_SRC/lib/env.sh
> > > 
> > > 	export_top_env
> > > 
> > > 	run_monitor $LKP_SRC/monitors/wrapper kmsg
> > > 	run_monitor $LKP_SRC/monitors/wrapper heartbeat
> > > 	run_monitor $LKP_SRC/monitors/wrapper meminfo
> > > 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
> > > 	run_monitor $LKP_SRC/monitors/plain/watchdog
> > > 
> > > 	run_test $LKP_SRC/tests/wrapper trinity
> > > }
> > > 
> > > extract_stats()
> > > {
> > > 	export stats_part_begin=
> > > 	export stats_part_end=
> > > 
> > > 	$LKP_SRC/stats/wrapper kmsg
> > > 	$LKP_SRC/stats/wrapper meminfo
> > > 
> > > 	$LKP_SRC/stats/wrapper time trinity.time
> > > 	$LKP_SRC/stats/wrapper dmesg
> > > 	$LKP_SRC/stats/wrapper kmsg
> > > 	$LKP_SRC/stats/wrapper last_state
> > > 	$LKP_SRC/stats/wrapper stderr
> > > 	$LKP_SRC/stats/wrapper time
> > > }
> > > 
> > > "$@"
> > _______________________________________________
> > LKP mailing list -- lkp@lists.01.org
> > To unsubscribe send an email to lkp-leave@lists.01.org
> 
