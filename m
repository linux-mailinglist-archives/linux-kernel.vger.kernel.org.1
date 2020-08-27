Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17AD254B34
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 18:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgH0QxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 12:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726093AbgH0QxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:53:23 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78A722087C;
        Thu, 27 Aug 2020 16:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598547196;
        bh=h7HhwIj5ddsOtTX0kFdXB7QUhBiwHlFCYan7V5K/LTU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=atXxyM1v5XbpACKlP5qjoGLCk3sMe0HeULgNA4SgVxcRcusWllIWO07S25U6jhbrj
         u1nniUrn4SOA91J6sXeK0x+abd/DcnAv3lZPtrIQpo3qx+HfmBkdg9ukEhA9FpH42i
         1u1ZxvdjTJSIhTPm2khaQ4kf/NhB8XoJPkVPPH6U=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 52A2D3521B7A; Thu, 27 Aug 2020 09:53:16 -0700 (PDT)
Date:   Thu, 27 Aug 2020 09:53:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        joel@joelfernandes.org
Subject: Re: [rcuperf] c02cb02f8f: error:#[##]
Message-ID: <20200827165316.GH2855@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200824002919.GQ18179@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824002919.GQ18179@shao2-debian>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 08:29:20AM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: c02cb02f8f59b8d26a0cc0352d2a2fa4e55073df ("rcuperf: Change rcuperf to rcuscale")
> https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git rcu/next
> 
> 
> in testcase: trinity
> with following parameters:
> 
> 	runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +------------------------------------------+------------+------------+
> |                                          | 1b1d8bf165 | c02cb02f8f |
> +------------------------------------------+------------+------------+
> | boot_successes                           | 4          | 0          |
> | boot_failures                            | 0          | 8          |
> | error:#[##]                              | 0          | 8          |
> | EIP:main_func                            | 0          | 8          |
> | Kernel_panic-not_syncing:Fatal_exception | 0          | 8          |
> +------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>

My first thought was that either the refscale.loops or the refscale.nruns
module parameters were being set to zero, which would explain the divide
error.  But in your dmesg, I see:

rcu-ref-scale: --- Start of test:  verbose=0 shutdown=1 holdoff=10 loops=10000 nreaders=-1 nruns=30 readdelay=0

The only divides that I see are by 1000 and by (nreaders * loops).

Ah, but you have CONFIG_NR_CPUS=1, so the default value computed when
nreaders==-1 is 0.75, which rounds to zero.  Which explains the divide
error.

Adding bounds checking.  But only for less than or equal to zero.
If trinity specifies these module parameters to be so big that your test
system OOMs, that is not refscale's fault.  ;-)

							Thanx, Paul

> [   10.892130] igt_debug 0x0000000000000a00-0x0000000000000e00: 1024: used
> [   10.892626] igt_debug 0x0000000000000e00-0x0000000000001000: 512: free
> [   10.893115] igt_debug total: 4096, used 2048 free 2048
> [   20.901339] rcu-ref-scale: Experiment #0 (Format: <THREAD-NUM>:<Total loop time in ns>)
> [   20.901339] 
> [   20.902931] divide_error: 0000 [#1] PREEMPT
> [   20.903184] CPU: 0 PID: 124 Comm: main_func Not tainted 5.9.0-rc1-00125-gc02cb02f8f59b #1
> [   20.903664] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   20.904156] EIP: main_func+0x1f9/0x2d8
> [   20.904381] Code: c8 c2 be e8 03 00 00 0f af d8 e8 c2 fc ff ff 69 ca e8 03 00 00 f7 e6 31 f6 89 55 b0 8d 14 11 89 45 ac 39 d3 77 08 89 d0 31 d2 <f7> f3 89 c6 8b 4d a4 8b 45 ac f7 f3 89 74 f9 04 89 04 f9 83 c7 01
> [   20.904661] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
> [   20.904661] ESI: 00000000 EDI: 00000000 EBP: e756bf84 ESP: e756bf24
> [   20.904661] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010246
> [   20.904661] CR0: 80050033 CR2: 00000000 CR3: 02e7a000 CR4: 000406b0
> [   20.904661] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   20.904661] DR6: fffe0ff0 DR7: 00000400
> [   20.904661] Call Trace:
> [   20.904661]  ? __kthread_parkme+0x39/0x80
> [   20.904661]  kthread+0xed/0x120
> [   20.904661]  ? process_durations+0x160/0x160
> [   20.904661]  ? kthread_create_on_node+0x20/0x20
> [   20.904661]  ret_from_fork+0x19/0x30
> [   20.904661] Modules linked in:
> [   21.438000] ---[ end trace 1841504cf0e16069 ]---
> [   21.438311] EIP: main_func+0x1f9/0x2d8
> [   21.438541] Code: c8 c2 be e8 03 00 00 0f af d8 e8 c2 fc ff ff 69 ca e8 03 00 00 f7 e6 31 f6 89 55 b0 8d 14 11 89 45 ac 39 d3 77 08 89 d0 31 d2 <f7> f3 89 c6 8b 4d a4 8b 45 ac f7 f3 89 74 f9 04 89 04 f9 83 c7 01
> [   21.439651] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
> [   21.440026] ESI: 00000000 EDI: 00000000 EBP: e756bf84 ESP: e756bf24
> [   21.440402] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010246
> [   21.440809] CR0: 80050033 CR2: 00000000 CR3: 02e7a000 CR4: 000406b0
> [   21.441186] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   21.684665] DR6: fffe0ff0 DR7: 00000400
> [   21.684919] Kernel panic - not syncing: Fatal exception
> [   21.685231] Kernel Offset: disabled
> 
> Kboot worker: lkp-worker41
> Elapsed time: 60
> 
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.9.0-rc1-00125-gc02cb02f8f59b .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
> 
> 
> Thanks,
> lkp
> 

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/i386 5.9.0-rc1 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-15) 9.3.0"
> CONFIG_CC_IS_GCC=y
> CONFIG_GCC_VERSION=90300
> CONFIG_LD_VERSION=235000000
> CONFIG_CLANG_VERSION=0
> CONFIG_CC_HAS_ASM_GOTO=y
> CONFIG_CC_HAS_ASM_INLINE=y
> CONFIG_CONSTRUCTORS=y
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_TABLE_SORT=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> #
> # General setup
> #
> CONFIG_BROKEN_ON_SMP=y
> CONFIG_INIT_ENV_ARG_LIMIT=32
> # CONFIG_COMPILE_TEST is not set
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_BUILD_SALT=""
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_BZIP2=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> CONFIG_HAVE_KERNEL_ZSTD=y
> # CONFIG_KERNEL_GZIP is not set
> CONFIG_KERNEL_BZIP2=y
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> # CONFIG_KERNEL_ZSTD is not set
> CONFIG_DEFAULT_INIT=""
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> # CONFIG_POSIX_MQUEUE is not set
> # CONFIG_WATCH_QUEUE is not set
> # CONFIG_CROSS_MEMORY_ATTACH is not set
> CONFIG_USELIB=y
> # CONFIG_AUDIT is not set
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_GENERIC_IRQ_INJECTION=y
> CONFIG_HARDIRQS_SW_RESEND=y
> CONFIG_GENERIC_IRQ_CHIP=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_SIM=y
> CONFIG_IRQ_DOMAIN_HIERARCHY=y
> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> CONFIG_GENERIC_IRQ_DEBUGFS=y
> # end of IRQ subsystem
> 
> CONFIG_CLOCKSOURCE_WATCHDOG=y
> CONFIG_ARCH_CLOCKSOURCE_INIT=y
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> CONFIG_GENERIC_CMOS_UPDATE=y
> CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
> CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
> 
> #
> # Timers subsystem
> #
> CONFIG_HZ_PERIODIC=y
> # CONFIG_NO_HZ_IDLE is not set
> # CONFIG_NO_HZ is not set
> # CONFIG_HIGH_RES_TIMERS is not set
> # end of Timers subsystem
> 
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_COUNT=y
> CONFIG_PREEMPTION=y
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_TICK_CPU_ACCOUNTING=y
> CONFIG_IRQ_TIME_ACCOUNTING=y
> # CONFIG_BSD_PROCESS_ACCT is not set
> # CONFIG_TASKSTATS is not set
> # CONFIG_PSI is not set
> # end of CPU/Task time and stats accounting
> 
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=y
> CONFIG_PREEMPT_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> CONFIG_TASKS_RCU_GENERIC=y
> CONFIG_TASKS_RCU=y
> CONFIG_TASKS_RUDE_RCU=y
> CONFIG_TASKS_TRACE_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> # end of RCU Subsystem
> 
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> CONFIG_IKHEADERS=y
> CONFIG_LOG_BUF_SHIFT=20
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> 
> #
> # Scheduler features
> #
> # end of Scheduler features
> 
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> CONFIG_CGROUPS=y
> # CONFIG_MEMCG is not set
> CONFIG_BLK_CGROUP=y
> # CONFIG_CGROUP_SCHED is not set
> CONFIG_CGROUP_PIDS=y
> CONFIG_CGROUP_RDMA=y
> # CONFIG_CGROUP_FREEZER is not set
> # CONFIG_CGROUP_DEVICE is not set
> CONFIG_CGROUP_CPUACCT=y
> CONFIG_CGROUP_PERF=y
> # CONFIG_CGROUP_BPF is not set
> CONFIG_CGROUP_DEBUG=y
> CONFIG_NAMESPACES=y
> # CONFIG_UTS_NS is not set
> # CONFIG_TIME_NS is not set
> CONFIG_IPC_NS=y
> # CONFIG_USER_NS is not set
> # CONFIG_PID_NS is not set
> CONFIG_NET_NS=y
> # CONFIG_CHECKPOINT_RESTORE is not set
> # CONFIG_SCHED_AUTOGROUP is not set
> # CONFIG_SYSFS_DEPRECATED is not set
> # CONFIG_RELAY is not set
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_RD_GZIP=y
> CONFIG_RD_BZIP2=y
> CONFIG_RD_LZMA=y
> CONFIG_RD_XZ=y
> CONFIG_RD_LZO=y
> # CONFIG_RD_LZ4 is not set
> # CONFIG_RD_ZSTD is not set
> CONFIG_BOOT_CONFIG=y
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_SYSCTL=y
> CONFIG_HAVE_UID16=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_HAVE_PCSPKR_PLATFORM=y
> CONFIG_BPF=y
> CONFIG_EXPERT=y
> CONFIG_UID16=y
> CONFIG_MULTIUSER=y
> # CONFIG_SGETMASK_SYSCALL is not set
> # CONFIG_SYSFS_SYSCALL is not set
> CONFIG_FHANDLE=y
> CONFIG_POSIX_TIMERS=y
> CONFIG_PRINTK=y
> CONFIG_PRINTK_NMI=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> # CONFIG_PCSPKR_PLATFORM is not set
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> CONFIG_IO_URING=y
> # CONFIG_ADVISE_SYSCALLS is not set
> # CONFIG_MEMBARRIER is not set
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> CONFIG_BPF_SYSCALL=y
> CONFIG_USERFAULTFD=y
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> # CONFIG_RSEQ is not set
> CONFIG_EMBEDDED=y
> CONFIG_HAVE_PERF_EVENTS=y
> # CONFIG_PC104 is not set
> 
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=y
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> # end of Kernel Performance Events And Counters
> 
> CONFIG_VM_EVENT_COUNTERS=y
> # CONFIG_SLUB_DEBUG is not set
> CONFIG_COMPAT_BRK=y
> # CONFIG_SLAB is not set
> CONFIG_SLUB=y
> # CONFIG_SLOB is not set
> # CONFIG_SLAB_MERGE_DEFAULT is not set
> CONFIG_SLAB_FREELIST_RANDOM=y
> # CONFIG_SLAB_FREELIST_HARDENED is not set
> # CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
> CONFIG_SYSTEM_DATA_VERIFICATION=y
> CONFIG_PROFILING=y
> # end of General setup
> 
> CONFIG_X86_32=y
> CONFIG_X86=y
> CONFIG_INSTRUCTION_DECODER=y
> CONFIG_OUTPUT_FORMAT="elf32-i386"
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_MMU=y
> CONFIG_ARCH_MMAP_RND_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_BITS_MAX=16
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_BUG=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_ARCH_HAS_CPU_RELAX=y
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> CONFIG_ARCH_HAS_FILTER_PGPROT=y
> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_X86_32_LAZY_GS=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_PGTABLE_LEVELS=3
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> 
> #
> # Processor type and features
> #
> # CONFIG_ZONE_DMA is not set
> # CONFIG_SMP is not set
> CONFIG_X86_FEATURE_NAMES=y
> CONFIG_X86_MPPARSE=y
> # CONFIG_GOLDFISH is not set
> # CONFIG_RETPOLINE is not set
> # CONFIG_X86_CPU_RESCTRL is not set
> # CONFIG_X86_EXTENDED_PLATFORM is not set
> # CONFIG_X86_INTEL_LPSS is not set
> # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> # CONFIG_IOSF_MBI is not set
> CONFIG_X86_32_IRIS=y
> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> CONFIG_HYPERVISOR_GUEST=y
> CONFIG_PARAVIRT=y
> # CONFIG_PARAVIRT_DEBUG is not set
> CONFIG_X86_HV_CALLBACK_VECTOR=y
> CONFIG_KVM_GUEST=y
> CONFIG_ARCH_CPUIDLE_HALTPOLL=y
> # CONFIG_PVH is not set
> # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> CONFIG_PARAVIRT_CLOCK=y
> CONFIG_M486SX=y
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMII is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUMM is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MEFFICEON is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MELAN is not set
> # CONFIG_MGEODEGX1 is not set
> # CONFIG_MGEODE_LX is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> # CONFIG_MVIAC7 is not set
> # CONFIG_MCORE2 is not set
> # CONFIG_MATOM is not set
> CONFIG_X86_GENERIC=y
> CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_F00F_BUG=y
> CONFIG_X86_INVD_BUG=y
> CONFIG_X86_ALIGNMENT_16=y
> CONFIG_X86_INTEL_USERCOPY=y
> CONFIG_X86_CMPXCHG64=y
> CONFIG_X86_MINIMUM_CPU_FAMILY=5
> CONFIG_IA32_FEAT_CTL=y
> CONFIG_X86_VMX_FEATURE_NAMES=y
> CONFIG_PROCESSOR_SELECT=y
> # CONFIG_CPU_SUP_INTEL is not set
> # CONFIG_CPU_SUP_CYRIX_32 is not set
> CONFIG_CPU_SUP_AMD=y
> CONFIG_CPU_SUP_HYGON=y
> CONFIG_CPU_SUP_CENTAUR=y
> CONFIG_CPU_SUP_TRANSMETA_32=y
> # CONFIG_CPU_SUP_UMC_32 is not set
> # CONFIG_CPU_SUP_ZHAOXIN is not set
> CONFIG_HPET_TIMER=y
> CONFIG_DMI=y
> CONFIG_NR_CPUS_RANGE_BEGIN=1
> CONFIG_NR_CPUS_RANGE_END=1
> CONFIG_NR_CPUS_DEFAULT=1
> CONFIG_NR_CPUS=1
> CONFIG_UP_LATE_INIT=y
> CONFIG_X86_UP_APIC=y
> # CONFIG_X86_UP_IOAPIC is not set
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
> # CONFIG_X86_MCE is not set
> 
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_RAPL=y
> CONFIG_PERF_EVENTS_AMD_POWER=y
> # end of Performance monitoring
> 
> CONFIG_X86_LEGACY_VM86=y
> CONFIG_VM86=y
> # CONFIG_X86_16BIT is not set
> # CONFIG_X86_IOPL_IOPERM is not set
> CONFIG_TOSHIBA=y
> # CONFIG_I8K is not set
> CONFIG_X86_REBOOTFIXUPS=y
> # CONFIG_MICROCODE is not set
> CONFIG_X86_MSR=y
> CONFIG_X86_CPUID=y
> # CONFIG_NOHIGHMEM is not set
> # CONFIG_HIGHMEM4G is not set
> CONFIG_HIGHMEM64G=y
> CONFIG_VMSPLIT_3G=y
> # CONFIG_VMSPLIT_2G is not set
> # CONFIG_VMSPLIT_1G is not set
> CONFIG_PAGE_OFFSET=0xC0000000
> CONFIG_HIGHMEM=y
> CONFIG_X86_PAE=y
> CONFIG_X86_CPA_STATISTICS=y
> CONFIG_ARCH_FLATMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> CONFIG_ILLEGAL_POINTER_VALUE=0
> CONFIG_X86_PMEM_LEGACY_DEVICE=y
> CONFIG_X86_PMEM_LEGACY=y
> CONFIG_HIGHPTE=y
> # CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
> CONFIG_X86_RESERVE_LOW=64
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> CONFIG_MTRR_SANITIZER=y
> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
> CONFIG_X86_PAT=y
> CONFIG_ARCH_USES_PG_UNCACHED=y
> CONFIG_ARCH_RANDOM=y
> CONFIG_X86_SMAP=y
> # CONFIG_X86_UMIP is not set
> # CONFIG_EFI is not set
> # CONFIG_SECCOMP is not set
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_250 is not set
> CONFIG_HZ_300=y
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=300
> # CONFIG_KEXEC is not set
> # CONFIG_CRASH_DUMP is not set
> CONFIG_PHYSICAL_START=0x1000000
> CONFIG_RELOCATABLE=y
> # CONFIG_RANDOMIZE_BASE is not set
> CONFIG_X86_NEED_RELOCS=y
> CONFIG_PHYSICAL_ALIGN=0x200000
> CONFIG_COMPAT_VDSO=y
> # CONFIG_CMDLINE_BOOL is not set
> CONFIG_MODIFY_LDT_SYSCALL=y
> # end of Processor type and features
> 
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> 
> #
> # Power management and ACPI options
> #
> CONFIG_ARCH_HIBERNATION_HEADER=y
> # CONFIG_SUSPEND is not set
> CONFIG_HIBERNATE_CALLBACKS=y
> CONFIG_HIBERNATION=y
> # CONFIG_HIBERNATION_SNAPSHOT_DEV is not set
> CONFIG_PM_STD_PARTITION=""
> CONFIG_PM_SLEEP=y
> CONFIG_PM_AUTOSLEEP=y
> # CONFIG_PM_WAKELOCKS is not set
> CONFIG_PM=y
> # CONFIG_PM_DEBUG is not set
> CONFIG_PM_CLK=y
> CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
> CONFIG_ARCH_SUPPORTS_ACPI=y
> CONFIG_ACPI=y
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> # CONFIG_ACPI_DEBUGGER is not set
> CONFIG_ACPI_SPCR_TABLE=y
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
> # CONFIG_ACPI_EC_DEBUGFS is not set
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> # CONFIG_ACPI_VIDEO is not set
> CONFIG_ACPI_FAN=y
> # CONFIG_ACPI_TAD is not set
> # CONFIG_ACPI_DOCK is not set
> CONFIG_ACPI_CPU_FREQ_PSS=y
> CONFIG_ACPI_PROCESSOR_CSTATE=y
> CONFIG_ACPI_PROCESSOR_IDLE=y
> CONFIG_ACPI_PROCESSOR=y
> # CONFIG_ACPI_IPMI is not set
> # CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
> CONFIG_ACPI_THERMAL=y
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_TABLE_UPGRADE=y
> # CONFIG_ACPI_DEBUG is not set
> # CONFIG_ACPI_PCI_SLOT is not set
> # CONFIG_ACPI_CONTAINER is not set
> CONFIG_ACPI_HOTPLUG_IOAPIC=y
> # CONFIG_ACPI_SBS is not set
> # CONFIG_ACPI_HED is not set
> # CONFIG_ACPI_CUSTOM_METHOD is not set
> # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> CONFIG_HAVE_ACPI_APEI=y
> CONFIG_HAVE_ACPI_APEI_NMI=y
> # CONFIG_ACPI_APEI is not set
> # CONFIG_DPTF_POWER is not set
> # CONFIG_PMIC_OPREGION is not set
> # CONFIG_ACPI_CONFIGFS is not set
> CONFIG_X86_PM_TIMER=y
> # CONFIG_SFI is not set
> # CONFIG_APM is not set
> 
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
> # end of CPU Frequency scaling
> 
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=y
> CONFIG_CPU_IDLE_GOV_LADDER=y
> CONFIG_CPU_IDLE_GOV_MENU=y
> # CONFIG_CPU_IDLE_GOV_TEO is not set
> # CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
> CONFIG_HALTPOLL_CPUIDLE=y
> # end of CPU Idle
> # end of Power management and ACPI options
> 
> #
> # Bus options (PCI etc.)
> #
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GOMMCONFIG is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> # CONFIG_PCI_CNB20LE_QUIRK is not set
> CONFIG_ISA_BUS=y
> CONFIG_ISA_DMA_API=y
> CONFIG_ISA=y
> # CONFIG_SCx200 is not set
> # CONFIG_ALIX is not set
> # CONFIG_NET5501 is not set
> CONFIG_GEOS=y
> CONFIG_AMD_NB=y
> CONFIG_X86_SYSFB=y
> # end of Bus options (PCI etc.)
> 
> #
> # Binary Emulations
> #
> CONFIG_COMPAT_32=y
> # end of Binary Emulations
> 
> CONFIG_HAVE_ATOMIC_IOMAP=y
> 
> #
> # Firmware Drivers
> #
> CONFIG_EDD=y
> CONFIG_EDD_OFF=y
> # CONFIG_FIRMWARE_MEMMAP is not set
> # CONFIG_DMIID is not set
> # CONFIG_DMI_SYSFS is not set
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> CONFIG_FW_CFG_SYSFS=y
> CONFIG_FW_CFG_SYSFS_CMDLINE=y
> # CONFIG_GOOGLE_FIRMWARE is not set
> CONFIG_EFI_EARLYCON=y
> 
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
> 
> CONFIG_HAVE_KVM=y
> # CONFIG_VIRTUALIZATION is not set
> CONFIG_AS_AVX512=y
> CONFIG_AS_SHA1_NI=y
> CONFIG_AS_SHA256_NI=y
> CONFIG_AS_TPAUSE=y
> 
> #
> # General architecture-dependent options
> #
> CONFIG_CRASH_CORE=y
> CONFIG_GENERIC_ENTRY=y
> # CONFIG_OPROFILE is not set
> CONFIG_HAVE_OPROFILE=y
> CONFIG_OPROFILE_NMI_TIMER=y
> # CONFIG_KPROBES is not set
> CONFIG_JUMP_LABEL=y
> # CONFIG_STATIC_KEYS_SELFTEST is not set
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_OPTPROBES=y
> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> CONFIG_HAVE_NMI=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> CONFIG_ARCH_32BIT_OFF_T=y
> CONFIG_HAVE_ASM_MODVERSIONS=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_RSEQ=y
> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
> CONFIG_HAVE_HW_BREAKPOINT=y
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_PERF_EVENTS_NMI=y
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
> CONFIG_MMU_GATHER_TABLE_FREE=y
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
> CONFIG_HAVE_CMPXCHG_LOCAL=y
> CONFIG_HAVE_CMPXCHG_DOUBLE=y
> CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> CONFIG_HAVE_ARCH_STACKLEAK=y
> CONFIG_HAVE_STACKPROTECTOR=y
> # CONFIG_STACKPROTECTOR is not set
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_MOVE_PMD=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_HAVE_ARCH_HUGE_VMAP=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_REL=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> CONFIG_HAVE_EXIT_THREAD=y
> CONFIG_ARCH_MMAP_RND_BITS=8
> CONFIG_ISA_BUS_API=y
> CONFIG_CLONE_BACKWARDS=y
> CONFIG_OLD_SIGSUSPEND3=y
> CONFIG_OLD_SIGACTION=y
> CONFIG_COMPAT_32BIT_TIME=y
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> CONFIG_STRICT_KERNEL_RWX=y
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> CONFIG_STRICT_MODULE_RWX=y
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
> CONFIG_ARCH_USE_MEMREMAP_PROT=y
> CONFIG_LOCK_EVENT_COUNTS=y
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> 
> #
> # GCOV-based kernel profiling
> #
> CONFIG_GCOV_KERNEL=y
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> # CONFIG_GCOV_PROFILE_ALL is not set
> # end of GCOV-based kernel profiling
> 
> CONFIG_HAVE_GCC_PLUGINS=y
> # end of General architecture-dependent options
> 
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> CONFIG_MODULE_SIG_FORMAT=y
> CONFIG_MODULES=y
> # CONFIG_MODULE_FORCE_LOAD is not set
> # CONFIG_MODULE_UNLOAD is not set
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> CONFIG_MODULE_SIG=y
> # CONFIG_MODULE_SIG_FORCE is not set
> CONFIG_MODULE_SIG_ALL=y
> CONFIG_MODULE_SIG_SHA1=y
> # CONFIG_MODULE_SIG_SHA224 is not set
> # CONFIG_MODULE_SIG_SHA256 is not set
> # CONFIG_MODULE_SIG_SHA384 is not set
> # CONFIG_MODULE_SIG_SHA512 is not set
> CONFIG_MODULE_SIG_HASH="sha1"
> # CONFIG_MODULE_COMPRESS is not set
> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> CONFIG_UNUSED_SYMBOLS=y
> CONFIG_MODULES_TREE_LOOKUP=y
> CONFIG_BLOCK=y
> CONFIG_BLK_SCSI_REQUEST=y
> CONFIG_BLK_DEV_BSG=y
> CONFIG_BLK_DEV_BSGLIB=y
> CONFIG_BLK_DEV_INTEGRITY=y
> # CONFIG_BLK_DEV_ZONED is not set
> # CONFIG_BLK_DEV_THROTTLING is not set
> CONFIG_BLK_CMDLINE_PARSER=y
> # CONFIG_BLK_WBT is not set
> CONFIG_BLK_CGROUP_IOLATENCY=y
> # CONFIG_BLK_CGROUP_IOCOST is not set
> # CONFIG_BLK_DEBUG_FS is not set
> CONFIG_BLK_SED_OPAL=y
> # CONFIG_BLK_INLINE_ENCRYPTION is not set
> 
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=y
> # CONFIG_ACORN_PARTITION is not set
> CONFIG_AIX_PARTITION=y
> CONFIG_OSF_PARTITION=y
> CONFIG_AMIGA_PARTITION=y
> # CONFIG_ATARI_PARTITION is not set
> # CONFIG_MAC_PARTITION is not set
> # CONFIG_MSDOS_PARTITION is not set
> # CONFIG_LDM_PARTITION is not set
> # CONFIG_SGI_PARTITION is not set
> CONFIG_ULTRIX_PARTITION=y
> # CONFIG_SUN_PARTITION is not set
> # CONFIG_KARMA_PARTITION is not set
> # CONFIG_EFI_PARTITION is not set
> CONFIG_SYSV68_PARTITION=y
> CONFIG_CMDLINE_PARTITION=y
> # end of Partition Types
> 
> CONFIG_BLK_MQ_PCI=y
> CONFIG_BLK_MQ_VIRTIO=y
> CONFIG_BLK_PM=y
> 
> #
> # IO Schedulers
> #
> # CONFIG_MQ_IOSCHED_DEADLINE is not set
> CONFIG_MQ_IOSCHED_KYBER=y
> CONFIG_IOSCHED_BFQ=y
> # CONFIG_BFQ_GROUP_IOSCHED is not set
> # end of IO Schedulers
> 
> CONFIG_ASN1=y
> CONFIG_UNINLINE_SPIN_UNLOCK=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> CONFIG_FREEZER=y
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_ELFCORE=y
> # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> CONFIG_BINFMT_SCRIPT=y
> CONFIG_BINFMT_MISC=y
> CONFIG_COREDUMP=y
> # end of Executable file formats
> 
> #
> # Memory Management options
> #
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_FLATMEM_MANUAL=y
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_FLATMEM=y
> CONFIG_FLAT_NODE_MEM_MAP=y
> CONFIG_SPARSEMEM_STATIC=y
> CONFIG_HAVE_FAST_GUP=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> # CONFIG_COMPACTION is not set
> CONFIG_PAGE_REPORTING=y
> CONFIG_PHYS_ADDR_T_64BIT=y
> CONFIG_BOUNCE=y
> CONFIG_VIRT_TO_BUS=y
> CONFIG_KSM=y
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> # CONFIG_TRANSPARENT_HUGEPAGE is not set
> CONFIG_NEED_PER_CPU_KM=y
> CONFIG_CLEANCACHE=y
> CONFIG_FRONTSWAP=y
> # CONFIG_CMA is not set
> # CONFIG_ZSWAP is not set
> # CONFIG_ZPOOL is not set
> CONFIG_ZBUD=y
> CONFIG_ZSMALLOC=y
> CONFIG_ZSMALLOC_PGTABLE_MAPPING=y
> CONFIG_ZSMALLOC_STAT=y
> CONFIG_GENERIC_EARLY_IOREMAP=y
> # CONFIG_IDLE_PAGE_TRACKING is not set
> CONFIG_FRAME_VECTOR=y
> # CONFIG_PERCPU_STATS is not set
> # CONFIG_GUP_BENCHMARK is not set
> CONFIG_GUP_GET_PTE_LOW_HIGH=y
> CONFIG_ARCH_HAS_PTE_SPECIAL=y
> # end of Memory Management options
> 
> CONFIG_NET=y
> CONFIG_SKB_EXTENSIONS=y
> 
> #
> # Networking options
> #
> # CONFIG_PACKET is not set
> CONFIG_UNIX=y
> CONFIG_UNIX_SCM=y
> # CONFIG_UNIX_DIAG is not set
> # CONFIG_TLS is not set
> # CONFIG_XFRM_USER is not set
> # CONFIG_NET_KEY is not set
> # CONFIG_XDP_SOCKETS is not set
> CONFIG_INET=y
> # CONFIG_IP_MULTICAST is not set
> # CONFIG_IP_ADVANCED_ROUTER is not set
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> # CONFIG_IP_PNP_BOOTP is not set
> # CONFIG_IP_PNP_RARP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE_DEMUX is not set
> CONFIG_NET_IP_TUNNEL=y
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_NET_IPVTI is not set
> # CONFIG_NET_FOU is not set
> # CONFIG_NET_FOU_IP_TUNNELS is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> CONFIG_INET_TUNNEL=y
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> # CONFIG_INET_UDP_DIAG is not set
> # CONFIG_INET_RAW_DIAG is not set
> # CONFIG_INET_DIAG_DESTROY is not set
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_DEFAULT_TCP_CONG="cubic"
> # CONFIG_TCP_MD5SIG is not set
> CONFIG_IPV6=y
> # CONFIG_IPV6_ROUTER_PREF is not set
> # CONFIG_IPV6_OPTIMISTIC_DAD is not set
> # CONFIG_INET6_AH is not set
> # CONFIG_INET6_ESP is not set
> # CONFIG_INET6_IPCOMP is not set
> # CONFIG_IPV6_MIP6 is not set
> # CONFIG_IPV6_VTI is not set
> CONFIG_IPV6_SIT=y
> # CONFIG_IPV6_SIT_6RD is not set
> CONFIG_IPV6_NDISC_NODETYPE=y
> # CONFIG_IPV6_TUNNEL is not set
> # CONFIG_IPV6_MULTIPLE_TABLES is not set
> # CONFIG_IPV6_MROUTE is not set
> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> # CONFIG_IPV6_SEG6_HMAC is not set
> # CONFIG_IPV6_RPL_LWTUNNEL is not set
> # CONFIG_NETLABEL is not set
> CONFIG_MPTCP=y
> CONFIG_INET_MPTCP_DIAG=y
> CONFIG_MPTCP_IPV6=y
> CONFIG_MPTCP_KUNIT_TESTS=y
> # CONFIG_NETWORK_SECMARK is not set
> # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> # CONFIG_NETFILTER is not set
> # CONFIG_BPFILTER is not set
> # CONFIG_IP_DCCP is not set
> # CONFIG_IP_SCTP is not set
> # CONFIG_RDS is not set
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_L2TP is not set
> # CONFIG_BRIDGE is not set
> CONFIG_HAVE_NET_DSA=y
> # CONFIG_NET_DSA is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> # CONFIG_LLC2 is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_PHONET is not set
> # CONFIG_6LOWPAN is not set
> # CONFIG_IEEE802154 is not set
> # CONFIG_NET_SCHED is not set
> # CONFIG_DCB is not set
> CONFIG_DNS_RESOLVER=m
> # CONFIG_BATMAN_ADV is not set
> # CONFIG_OPENVSWITCH is not set
> # CONFIG_VSOCKETS is not set
> # CONFIG_NETLINK_DIAG is not set
> # CONFIG_MPLS is not set
> # CONFIG_NET_NSH is not set
> # CONFIG_HSR is not set
> # CONFIG_NET_SWITCHDEV is not set
> # CONFIG_NET_L3_MASTER_DEV is not set
> # CONFIG_QRTR is not set
> # CONFIG_NET_NCSI is not set
> # CONFIG_CGROUP_NET_PRIO is not set
> # CONFIG_CGROUP_NET_CLASSID is not set
> CONFIG_NET_RX_BUSY_POLL=y
> CONFIG_BQL=y
> # CONFIG_BPF_JIT is not set
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # end of Network testing
> # end of Networking options
> 
> # CONFIG_HAMRADIO is not set
> # CONFIG_CAN is not set
> # CONFIG_BT is not set
> # CONFIG_AF_RXRPC is not set
> # CONFIG_AF_KCM is not set
> CONFIG_WIRELESS=y
> # CONFIG_CFG80211 is not set
> 
> #
> # CFG80211 needs to be enabled for MAC80211
> #
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> # CONFIG_WIMAX is not set
> # CONFIG_RFKILL is not set
> CONFIG_NET_9P=y
> CONFIG_NET_9P_VIRTIO=y
> # CONFIG_NET_9P_DEBUG is not set
> # CONFIG_CAIF is not set
> # CONFIG_CEPH_LIB is not set
> # CONFIG_NFC is not set
> # CONFIG_PSAMPLE is not set
> # CONFIG_NET_IFE is not set
> # CONFIG_LWTUNNEL is not set
> CONFIG_DST_CACHE=y
> CONFIG_GRO_CELLS=y
> # CONFIG_FAILOVER is not set
> CONFIG_ETHTOOL_NETLINK=y
> CONFIG_HAVE_EBPF_JIT=y
> 
> #
> # Device Drivers
> #
> CONFIG_HAVE_EISA=y
> # CONFIG_EISA is not set
> CONFIG_HAVE_PCI=y
> CONFIG_PCI=y
> CONFIG_PCI_DOMAINS=y
> # CONFIG_PCIEPORTBUS is not set
> CONFIG_PCIEASPM=y
> CONFIG_PCIEASPM_DEFAULT=y
> # CONFIG_PCIEASPM_POWERSAVE is not set
> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> # CONFIG_PCIE_PTM is not set
> # CONFIG_PCI_MSI is not set
> CONFIG_PCI_QUIRKS=y
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCI_STUB is not set
> CONFIG_PCI_LOCKLESS_CONFIG=y
> # CONFIG_PCI_IOV is not set
> # CONFIG_PCI_PRI is not set
> # CONFIG_PCI_PASID is not set
> CONFIG_PCI_LABEL=y
> # CONFIG_HOTPLUG_PCI is not set
> 
> #
> # PCI controller drivers
> #
> # CONFIG_PCI_FTPCI100 is not set
> # CONFIG_PCI_HOST_GENERIC is not set
> # CONFIG_PCIE_XILINX is not set
> 
> #
> # DesignWare PCI Core Support
> #
> # end of DesignWare PCI Core Support
> 
> #
> # Mobiveil PCIe Core Support
> #
> # end of Mobiveil PCIe Core Support
> 
> #
> # Cadence PCIe controllers support
> #
> # CONFIG_PCIE_CADENCE_PLAT_HOST is not set
> # CONFIG_PCI_J721E_HOST is not set
> # end of Cadence PCIe controllers support
> # end of PCI controller drivers
> 
> #
> # PCI Endpoint
> #
> # CONFIG_PCI_ENDPOINT is not set
> # end of PCI Endpoint
> 
> #
> # PCI switch controller drivers
> #
> # CONFIG_PCI_SW_SWITCHTEC is not set
> # end of PCI switch controller drivers
> 
> CONFIG_PCCARD=y
> CONFIG_PCMCIA=y
> # CONFIG_PCMCIA_LOAD_CIS is not set
> CONFIG_CARDBUS=y
> 
> #
> # PC-card bridges
> #
> # CONFIG_YENTA is not set
> # CONFIG_PD6729 is not set
> # CONFIG_I82092 is not set
> CONFIG_I82365=y
> CONFIG_TCIC=y
> CONFIG_PCMCIA_PROBE=y
> CONFIG_PCCARD_NONSTATIC=y
> # CONFIG_RAPIDIO is not set
> 
> #
> # Generic Driver Options
> #
> CONFIG_UEVENT_HELPER=y
> CONFIG_UEVENT_HELPER_PATH=""
> CONFIG_DEVTMPFS=y
> # CONFIG_DEVTMPFS_MOUNT is not set
> CONFIG_STANDALONE=y
> # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_FW_LOADER_PAGED_BUF=y
> CONFIG_EXTRA_FIRMWARE=""
> CONFIG_FW_LOADER_USER_HELPER=y
> CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
> CONFIG_FW_LOADER_COMPRESS=y
> # CONFIG_FW_CACHE is not set
> # end of Firmware loader
> 
> CONFIG_ALLOW_DEV_COREDUMP=y
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> CONFIG_PM_QOS_KUNIT_TEST=y
> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> CONFIG_KUNIT_DRIVER_PE_TEST=y
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_GENERIC_CPU_VULNERABILITIES=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=y
> CONFIG_REGMAP_MMIO=y
> CONFIG_REGMAP_IRQ=y
> CONFIG_REGMAP_SCCB=y
> CONFIG_REGMAP_I3C=y
> CONFIG_DMA_SHARED_BUFFER=y
> # CONFIG_DMA_FENCE_TRACE is not set
> # end of Generic Driver Options
> 
> #
> # Bus devices
> #
> # CONFIG_SIMPLE_PM_BUS is not set
> CONFIG_MHI_BUS=y
> # end of Bus devices
> 
> # CONFIG_CONNECTOR is not set
> CONFIG_GNSS=y
> CONFIG_GNSS_SERIAL=y
> CONFIG_GNSS_MTK_SERIAL=y
> # CONFIG_GNSS_SIRF_SERIAL is not set
> # CONFIG_GNSS_UBX_SERIAL is not set
> CONFIG_MTD=y
> # CONFIG_MTD_TESTS is not set
> 
> #
> # Partition parsers
> #
> CONFIG_MTD_AR7_PARTS=y
> # CONFIG_MTD_CMDLINE_PARTS is not set
> # CONFIG_MTD_OF_PARTS is not set
> CONFIG_MTD_REDBOOT_PARTS=y
> CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
> # CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
> # CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
> # end of Partition parsers
> 
> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_BLKDEVS=y
> # CONFIG_MTD_BLOCK is not set
> CONFIG_MTD_BLOCK_RO=y
> CONFIG_FTL=y
> # CONFIG_NFTL is not set
> CONFIG_INFTL=y
> CONFIG_RFD_FTL=y
> CONFIG_SSFDC=y
> CONFIG_SM_FTL=y
> CONFIG_MTD_OOPS=y
> CONFIG_MTD_SWAP=y
> # CONFIG_MTD_PARTITIONED_MASTER is not set
> 
> #
> # RAM/ROM/Flash chip drivers
> #
> CONFIG_MTD_CFI=y
> # CONFIG_MTD_JEDECPROBE is not set
> CONFIG_MTD_GEN_PROBE=y
> # CONFIG_MTD_CFI_ADV_OPTIONS is not set
> CONFIG_MTD_MAP_BANK_WIDTH_1=y
> CONFIG_MTD_MAP_BANK_WIDTH_2=y
> CONFIG_MTD_MAP_BANK_WIDTH_4=y
> CONFIG_MTD_CFI_I1=y
> CONFIG_MTD_CFI_I2=y
> # CONFIG_MTD_CFI_INTELEXT is not set
> CONFIG_MTD_CFI_AMDSTD=y
> CONFIG_MTD_CFI_STAA=y
> CONFIG_MTD_CFI_UTIL=y
> CONFIG_MTD_RAM=y
> CONFIG_MTD_ROM=y
> CONFIG_MTD_ABSENT=y
> # end of RAM/ROM/Flash chip drivers
> 
> #
> # Mapping drivers for chip access
> #
> CONFIG_MTD_COMPLEX_MAPPINGS=y
> # CONFIG_MTD_PHYSMAP is not set
> # CONFIG_MTD_PCI is not set
> CONFIG_MTD_PCMCIA=y
> # CONFIG_MTD_PCMCIA_ANONYMOUS is not set
> # CONFIG_MTD_INTEL_VR_NOR is not set
> CONFIG_MTD_PLATRAM=y
> # end of Mapping drivers for chip access
> 
> #
> # Self-contained MTD device drivers
> #
> # CONFIG_MTD_PMC551 is not set
> CONFIG_MTD_SLRAM=y
> CONFIG_MTD_PHRAM=y
> # CONFIG_MTD_MTDRAM is not set
> # CONFIG_MTD_BLOCK2MTD is not set
> 
> #
> # Disk-On-Chip Device Drivers
> #
> CONFIG_MTD_DOCG3=y
> CONFIG_BCH_CONST_M=14
> CONFIG_BCH_CONST_T=4
> # end of Self-contained MTD device drivers
> 
> #
> # NAND
> #
> CONFIG_MTD_NAND_CORE=y
> CONFIG_MTD_ONENAND=y
> # CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
> # CONFIG_MTD_ONENAND_GENERIC is not set
> CONFIG_MTD_ONENAND_OTP=y
> # CONFIG_MTD_ONENAND_2X_PROGRAM is not set
> CONFIG_MTD_NAND_ECC_SW_HAMMING=y
> CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
> CONFIG_MTD_RAW_NAND=y
> CONFIG_MTD_NAND_ECC_SW_BCH=y
> 
> #
> # Raw/parallel NAND flash controllers
> #
> # CONFIG_MTD_NAND_DENALI_PCI is not set
> # CONFIG_MTD_NAND_DENALI_DT is not set
> # CONFIG_MTD_NAND_CAFE is not set
> CONFIG_MTD_NAND_CS553X=y
> # CONFIG_MTD_NAND_MXIC is not set
> # CONFIG_MTD_NAND_GPIO is not set
> CONFIG_MTD_NAND_PLATFORM=y
> CONFIG_MTD_NAND_CADENCE=y
> CONFIG_MTD_NAND_ARASAN=y
> 
> #
> # Misc
> #
> # CONFIG_MTD_NAND_NANDSIM is not set
> # CONFIG_MTD_NAND_RICOH is not set
> CONFIG_MTD_NAND_DISKONCHIP=y
> # CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
> CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
> # CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
> # end of NAND
> 
> #
> # LPDDR & LPDDR2 PCM memory drivers
> #
> CONFIG_MTD_LPDDR=y
> CONFIG_MTD_QINFO_PROBE=y
> # end of LPDDR & LPDDR2 PCM memory drivers
> 
> CONFIG_MTD_UBI=y
> CONFIG_MTD_UBI_WL_THRESHOLD=4096
> CONFIG_MTD_UBI_BEB_LIMIT=20
> CONFIG_MTD_UBI_FASTMAP=y
> CONFIG_MTD_UBI_GLUEBI=y
> CONFIG_MTD_UBI_BLOCK=y
> CONFIG_MTD_HYPERBUS=y
> CONFIG_DTC=y
> CONFIG_OF=y
> # CONFIG_OF_UNITTEST is not set
> CONFIG_OF_FLATTREE=y
> CONFIG_OF_KOBJ=y
> CONFIG_OF_DYNAMIC=y
> CONFIG_OF_ADDRESS=y
> CONFIG_OF_IRQ=y
> CONFIG_OF_NET=y
> CONFIG_OF_RESOLVE=y
> CONFIG_OF_OVERLAY=y
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> # CONFIG_PARPORT is not set
> CONFIG_PNP=y
> CONFIG_PNP_DEBUG_MESSAGES=y
> 
> #
> # Protocols
> #
> # CONFIG_ISAPNP is not set
> # CONFIG_PNPBIOS is not set
> CONFIG_PNPACPI=y
> CONFIG_BLK_DEV=y
> CONFIG_BLK_DEV_NULL_BLK=y
> # CONFIG_BLK_DEV_FD is not set
> CONFIG_CDROM=y
> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> # CONFIG_ZRAM is not set
> # CONFIG_BLK_DEV_UMEM is not set
> # CONFIG_BLK_DEV_LOOP is not set
> # CONFIG_BLK_DEV_DRBD is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> # CONFIG_BLK_DEV_RAM is not set
> CONFIG_CDROM_PKTCDVD=y
> CONFIG_CDROM_PKTCDVD_BUFFERS=8
> # CONFIG_CDROM_PKTCDVD_WCACHE is not set
> # CONFIG_ATA_OVER_ETH is not set
> CONFIG_VIRTIO_BLK=y
> # CONFIG_BLK_DEV_RBD is not set
> # CONFIG_BLK_DEV_RSXX is not set
> 
> #
> # NVME Support
> #
> # CONFIG_BLK_DEV_NVME is not set
> # CONFIG_NVME_FC is not set
> # CONFIG_NVME_TARGET is not set
> # end of NVME Support
> 
> #
> # Misc devices
> #
> CONFIG_AD525X_DPOT=y
> # CONFIG_AD525X_DPOT_I2C is not set
> CONFIG_DUMMY_IRQ=y
> # CONFIG_IBM_ASM is not set
> # CONFIG_PHANTOM is not set
> # CONFIG_TIFM_CORE is not set
> # CONFIG_ICS932S401 is not set
> CONFIG_ENCLOSURE_SERVICES=y
> # CONFIG_HP_ILO is not set
> CONFIG_APDS9802ALS=y
> # CONFIG_ISL29003 is not set
> CONFIG_ISL29020=y
> # CONFIG_SENSORS_TSL2550 is not set
> # CONFIG_SENSORS_BH1770 is not set
> CONFIG_SENSORS_APDS990X=y
> CONFIG_HMC6352=y
> # CONFIG_DS1682 is not set
> # CONFIG_PCH_PHUB is not set
> # CONFIG_SRAM is not set
> # CONFIG_PCI_ENDPOINT_TEST is not set
> # CONFIG_XILINX_SDFEC is not set
> CONFIG_MISC_RTSX=y
> # CONFIG_PVPANIC is not set
> CONFIG_C2PORT=y
> CONFIG_C2PORT_DURAMAR_2150=y
> 
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_AT24 is not set
> CONFIG_EEPROM_LEGACY=y
> # CONFIG_EEPROM_MAX6875 is not set
> # CONFIG_EEPROM_93CX6 is not set
> # CONFIG_EEPROM_IDT_89HPESX is not set
> CONFIG_EEPROM_EE1004=y
> # end of EEPROM support
> 
> # CONFIG_CB710_CORE is not set
> 
> #
> # Texas Instruments shared transport line discipline
> #
> # CONFIG_TI_ST is not set
> # end of Texas Instruments shared transport line discipline
> 
> # CONFIG_SENSORS_LIS3_I2C is not set
> CONFIG_ALTERA_STAPL=y
> # CONFIG_INTEL_MEI is not set
> # CONFIG_INTEL_MEI_ME is not set
> # CONFIG_INTEL_MEI_TXE is not set
> # CONFIG_VMWARE_VMCI is not set
> 
> #
> # Intel MIC & related support
> #
> CONFIG_VOP_BUS=y
> # CONFIG_VOP is not set
> # end of Intel MIC & related support
> 
> CONFIG_ECHO=y
> # CONFIG_MISC_ALCOR_PCI is not set
> # CONFIG_MISC_RTSX_PCI is not set
> CONFIG_MISC_RTSX_USB=y
> # CONFIG_HABANA_AI is not set
> # end of Misc devices
> 
> CONFIG_HAVE_IDE=y
> # CONFIG_IDE is not set
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> # CONFIG_RAID_ATTRS is not set
> CONFIG_SCSI=y
> CONFIG_SCSI_DMA=y
> CONFIG_SCSI_PROC_FS=y
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> # CONFIG_BLK_DEV_SD is not set
> # CONFIG_CHR_DEV_ST is not set
> # CONFIG_BLK_DEV_SR is not set
> CONFIG_CHR_DEV_SG=y
> CONFIG_CHR_DEV_SCH=y
> # CONFIG_SCSI_ENCLOSURE is not set
> # CONFIG_SCSI_CONSTANTS is not set
> CONFIG_SCSI_LOGGING=y
> CONFIG_SCSI_SCAN_ASYNC=y
> 
> #
> # SCSI Transports
> #
> # CONFIG_SCSI_SPI_ATTRS is not set
> # CONFIG_SCSI_FC_ATTRS is not set
> # CONFIG_SCSI_ISCSI_ATTRS is not set
> CONFIG_SCSI_SAS_ATTRS=y
> # CONFIG_SCSI_SAS_LIBSAS is not set
> CONFIG_SCSI_SRP_ATTRS=y
> # end of SCSI Transports
> 
> # CONFIG_SCSI_LOWLEVEL is not set
> # CONFIG_SCSI_DH is not set
> # end of SCSI device support
> 
> # CONFIG_ATA is not set
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=y
> CONFIG_MD_AUTODETECT=y
> # CONFIG_MD_LINEAR is not set
> # CONFIG_MD_RAID0 is not set
> CONFIG_MD_RAID1=y
> CONFIG_MD_RAID10=y
> # CONFIG_MD_RAID456 is not set
> CONFIG_MD_MULTIPATH=y
> CONFIG_MD_FAULTY=y
> CONFIG_BCACHE=y
> # CONFIG_BCACHE_DEBUG is not set
> CONFIG_BCACHE_CLOSURES_DEBUG=y
> # CONFIG_BCACHE_ASYNC_REGISTRATION is not set
> # CONFIG_BLK_DEV_DM is not set
> CONFIG_TARGET_CORE=y
> # CONFIG_TCM_IBLOCK is not set
> CONFIG_TCM_FILEIO=y
> # CONFIG_TCM_PSCSI is not set
> # CONFIG_TCM_USER2 is not set
> # CONFIG_LOOPBACK_TARGET is not set
> # CONFIG_ISCSI_TARGET is not set
> # CONFIG_FUSION is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_FIREWIRE is not set
> # CONFIG_FIREWIRE_NOSY is not set
> # end of IEEE 1394 (FireWire) support
> 
> CONFIG_MACINTOSH_DRIVERS=y
> # CONFIG_MAC_EMUMOUSEBTN is not set
> CONFIG_NETDEVICES=y
> CONFIG_NET_CORE=y
> # CONFIG_BONDING is not set
> # CONFIG_DUMMY is not set
> # CONFIG_WIREGUARD is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_NET_FC is not set
> # CONFIG_NET_TEAM is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_IPVLAN is not set
> # CONFIG_VXLAN is not set
> # CONFIG_GENEVE is not set
> # CONFIG_BAREUDP is not set
> # CONFIG_GTP is not set
> # CONFIG_MACSEC is not set
> # CONFIG_NETCONSOLE is not set
> # CONFIG_TUN is not set
> # CONFIG_TUN_VNET_CROSS_LE is not set
> # CONFIG_VETH is not set
> # CONFIG_VIRTIO_NET is not set
> # CONFIG_NLMON is not set
> # CONFIG_ARCNET is not set
> 
> #
> # Distributed Switch Architecture drivers
> #
> # end of Distributed Switch Architecture drivers
> 
> CONFIG_ETHERNET=y
> CONFIG_NET_VENDOR_3COM=y
> # CONFIG_EL3 is not set
> # CONFIG_3C515 is not set
> # CONFIG_PCMCIA_3C574 is not set
> # CONFIG_PCMCIA_3C589 is not set
> # CONFIG_VORTEX is not set
> # CONFIG_TYPHOON is not set
> CONFIG_NET_VENDOR_ADAPTEC=y
> # CONFIG_ADAPTEC_STARFIRE is not set
> CONFIG_NET_VENDOR_AGERE=y
> # CONFIG_ET131X is not set
> CONFIG_NET_VENDOR_ALACRITECH=y
> # CONFIG_SLICOSS is not set
> CONFIG_NET_VENDOR_ALTEON=y
> # CONFIG_ACENIC is not set
> # CONFIG_ALTERA_TSE is not set
> CONFIG_NET_VENDOR_AMAZON=y
> CONFIG_NET_VENDOR_AMD=y
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_LANCE is not set
> # CONFIG_PCNET32 is not set
> # CONFIG_PCMCIA_NMCLAN is not set
> # CONFIG_NI65 is not set
> # CONFIG_AMD_XGBE is not set
> CONFIG_NET_VENDOR_AQUANTIA=y
> CONFIG_NET_VENDOR_ARC=y
> CONFIG_NET_VENDOR_ATHEROS=y
> # CONFIG_ATL2 is not set
> # CONFIG_ATL1 is not set
> # CONFIG_ATL1E is not set
> # CONFIG_ATL1C is not set
> # CONFIG_ALX is not set
> CONFIG_NET_VENDOR_AURORA=y
> # CONFIG_AURORA_NB8800 is not set
> CONFIG_NET_VENDOR_BROADCOM=y
> # CONFIG_B44 is not set
> # CONFIG_BCMGENET is not set
> # CONFIG_BNX2 is not set
> # CONFIG_CNIC is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_BNX2X is not set
> # CONFIG_SYSTEMPORT is not set
> # CONFIG_BNXT is not set
> CONFIG_NET_VENDOR_BROCADE=y
> # CONFIG_BNA is not set
> CONFIG_NET_VENDOR_CADENCE=y
> # CONFIG_MACB is not set
> CONFIG_NET_VENDOR_CAVIUM=y
> CONFIG_NET_VENDOR_CHELSIO=y
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_CHELSIO_T3 is not set
> # CONFIG_CHELSIO_T4 is not set
> # CONFIG_CHELSIO_T4VF is not set
> CONFIG_NET_VENDOR_CIRRUS=y
> # CONFIG_CS89x0 is not set
> CONFIG_NET_VENDOR_CISCO=y
> # CONFIG_ENIC is not set
> CONFIG_NET_VENDOR_CORTINA=y
> # CONFIG_GEMINI_ETHERNET is not set
> # CONFIG_CX_ECAT is not set
> # CONFIG_DNET is not set
> CONFIG_NET_VENDOR_DEC=y
> # CONFIG_NET_TULIP is not set
> CONFIG_NET_VENDOR_DLINK=y
> # CONFIG_DL2K is not set
> # CONFIG_SUNDANCE is not set
> CONFIG_NET_VENDOR_EMULEX=y
> # CONFIG_BE2NET is not set
> CONFIG_NET_VENDOR_EZCHIP=y
> # CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
> CONFIG_NET_VENDOR_FUJITSU=y
> # CONFIG_PCMCIA_FMVJ18X is not set
> CONFIG_NET_VENDOR_GOOGLE=y
> CONFIG_NET_VENDOR_HUAWEI=y
> CONFIG_NET_VENDOR_I825XX=y
> CONFIG_NET_VENDOR_INTEL=y
> # CONFIG_E100 is not set
> CONFIG_E1000=y
> # CONFIG_E1000E is not set
> # CONFIG_IGB is not set
> # CONFIG_IGBVF is not set
> # CONFIG_IXGB is not set
> # CONFIG_IXGBE is not set
> # CONFIG_I40E is not set
> # CONFIG_IGC is not set
> # CONFIG_JME is not set
> CONFIG_NET_VENDOR_MARVELL=y
> # CONFIG_MVMDIO is not set
> # CONFIG_SKGE is not set
> # CONFIG_SKY2 is not set
> CONFIG_NET_VENDOR_MELLANOX=y
> # CONFIG_MLX4_EN is not set
> # CONFIG_MLX5_CORE is not set
> # CONFIG_MLXSW_CORE is not set
> # CONFIG_MLXFW is not set
> CONFIG_NET_VENDOR_MICREL=y
> # CONFIG_KS8842 is not set
> # CONFIG_KS8851_MLL is not set
> # CONFIG_KSZ884X_PCI is not set
> CONFIG_NET_VENDOR_MICROCHIP=y
> # CONFIG_LAN743X is not set
> CONFIG_NET_VENDOR_MICROSEMI=y
> CONFIG_NET_VENDOR_MYRI=y
> # CONFIG_MYRI10GE is not set
> # CONFIG_FEALNX is not set
> CONFIG_NET_VENDOR_NATSEMI=y
> # CONFIG_NATSEMI is not set
> # CONFIG_NS83820 is not set
> CONFIG_NET_VENDOR_NETERION=y
> # CONFIG_S2IO is not set
> # CONFIG_VXGE is not set
> CONFIG_NET_VENDOR_NETRONOME=y
> CONFIG_NET_VENDOR_NI=y
> # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
> CONFIG_NET_VENDOR_8390=y
> # CONFIG_PCMCIA_AXNET is not set
> # CONFIG_NE2000 is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_PCMCIA_PCNET is not set
> # CONFIG_ULTRA is not set
> # CONFIG_WD80x3 is not set
> CONFIG_NET_VENDOR_NVIDIA=y
> # CONFIG_FORCEDETH is not set
> CONFIG_NET_VENDOR_OKI=y
> # CONFIG_PCH_GBE is not set
> # CONFIG_ETHOC is not set
> CONFIG_NET_VENDOR_PACKET_ENGINES=y
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> CONFIG_NET_VENDOR_PENSANDO=y
> CONFIG_NET_VENDOR_QLOGIC=y
> # CONFIG_QLA3XXX is not set
> # CONFIG_QLCNIC is not set
> # CONFIG_NETXEN_NIC is not set
> # CONFIG_QED is not set
> CONFIG_NET_VENDOR_QUALCOMM=y
> # CONFIG_QCA7000_UART is not set
> # CONFIG_QCOM_EMAC is not set
> # CONFIG_RMNET is not set
> CONFIG_NET_VENDOR_RDC=y
> # CONFIG_R6040 is not set
> CONFIG_NET_VENDOR_REALTEK=y
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> # CONFIG_R8169 is not set
> CONFIG_NET_VENDOR_RENESAS=y
> CONFIG_NET_VENDOR_ROCKER=y
> CONFIG_NET_VENDOR_SAMSUNG=y
> # CONFIG_SXGBE_ETH is not set
> CONFIG_NET_VENDOR_SEEQ=y
> CONFIG_NET_VENDOR_SOLARFLARE=y
> # CONFIG_SFC is not set
> # CONFIG_SFC_FALCON is not set
> CONFIG_NET_VENDOR_SILAN=y
> # CONFIG_SC92031 is not set
> CONFIG_NET_VENDOR_SIS=y
> # CONFIG_SIS900 is not set
> # CONFIG_SIS190 is not set
> CONFIG_NET_VENDOR_SMSC=y
> # CONFIG_SMC9194 is not set
> # CONFIG_PCMCIA_SMC91C92 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SMSC911X is not set
> # CONFIG_SMSC9420 is not set
> CONFIG_NET_VENDOR_SOCIONEXT=y
> CONFIG_NET_VENDOR_STMICRO=y
> # CONFIG_STMMAC_ETH is not set
> CONFIG_NET_VENDOR_SUN=y
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> # CONFIG_NIU is not set
> CONFIG_NET_VENDOR_SYNOPSYS=y
> # CONFIG_DWC_XLGMAC is not set
> CONFIG_NET_VENDOR_TEHUTI=y
> # CONFIG_TEHUTI is not set
> CONFIG_NET_VENDOR_TI=y
> # CONFIG_TI_CPSW_PHY_SEL is not set
> # CONFIG_TLAN is not set
> CONFIG_NET_VENDOR_VIA=y
> # CONFIG_VIA_RHINE is not set
> # CONFIG_VIA_VELOCITY is not set
> CONFIG_NET_VENDOR_WIZNET=y
> # CONFIG_WIZNET_W5100 is not set
> # CONFIG_WIZNET_W5300 is not set
> CONFIG_NET_VENDOR_XILINX=y
> # CONFIG_XILINX_AXI_EMAC is not set
> # CONFIG_XILINX_LL_TEMAC is not set
> CONFIG_NET_VENDOR_XIRCOM=y
> # CONFIG_PCMCIA_XIRC2PS is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_NET_SB1000 is not set
> # CONFIG_MDIO_DEVICE is not set
> # CONFIG_PHYLIB is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> CONFIG_USB_NET_DRIVERS=y
> # CONFIG_USB_CATC is not set
> # CONFIG_USB_KAWETH is not set
> # CONFIG_USB_PEGASUS is not set
> # CONFIG_USB_RTL8150 is not set
> # CONFIG_USB_RTL8152 is not set
> # CONFIG_USB_LAN78XX is not set
> # CONFIG_USB_USBNET is not set
> # CONFIG_USB_IPHETH is not set
> CONFIG_WLAN=y
> # CONFIG_WIRELESS_WDS is not set
> CONFIG_WLAN_VENDOR_ADMTEK=y
> CONFIG_WLAN_VENDOR_ATH=y
> # CONFIG_ATH_DEBUG is not set
> # CONFIG_ATH5K_PCI is not set
> CONFIG_WLAN_VENDOR_ATMEL=y
> CONFIG_WLAN_VENDOR_BROADCOM=y
> CONFIG_WLAN_VENDOR_CISCO=y
> CONFIG_WLAN_VENDOR_INTEL=y
> CONFIG_WLAN_VENDOR_INTERSIL=y
> # CONFIG_HOSTAP is not set
> # CONFIG_PRISM54 is not set
> CONFIG_WLAN_VENDOR_MARVELL=y
> CONFIG_WLAN_VENDOR_MEDIATEK=y
> CONFIG_WLAN_VENDOR_MICROCHIP=y
> CONFIG_WLAN_VENDOR_RALINK=y
> CONFIG_WLAN_VENDOR_REALTEK=y
> CONFIG_WLAN_VENDOR_RSI=y
> CONFIG_WLAN_VENDOR_ST=y
> CONFIG_WLAN_VENDOR_TI=y
> CONFIG_WLAN_VENDOR_ZYDAS=y
> CONFIG_WLAN_VENDOR_QUANTENNA=y
> # CONFIG_PCMCIA_RAYCS is not set
> 
> #
> # Enable WiMAX (Networking options) to see the WiMAX drivers
> #
> # CONFIG_WAN is not set
> # CONFIG_VMXNET3 is not set
> # CONFIG_FUJITSU_ES is not set
> # CONFIG_NETDEVSIM is not set
> # CONFIG_NET_FAILOVER is not set
> # CONFIG_ISDN is not set
> CONFIG_NVM=y
> # CONFIG_NVM_PBLK is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> # CONFIG_INPUT_LEDS is not set
> CONFIG_INPUT_FF_MEMLESS=y
> CONFIG_INPUT_POLLDEV=y
> CONFIG_INPUT_SPARSEKMAP=y
> CONFIG_INPUT_MATRIXKMAP=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> # CONFIG_INPUT_JOYDEV is not set
> CONFIG_INPUT_EVDEV=y
> CONFIG_INPUT_EVBUG=y
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ADC=y
> CONFIG_KEYBOARD_ADP5588=y
> # CONFIG_KEYBOARD_ADP5589 is not set
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_QT1050 is not set
> # CONFIG_KEYBOARD_QT1070 is not set
> CONFIG_KEYBOARD_QT2160=y
> CONFIG_KEYBOARD_DLINK_DIR685=y
> CONFIG_KEYBOARD_LKKBD=y
> # CONFIG_KEYBOARD_GPIO is not set
> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> CONFIG_KEYBOARD_TCA6416=y
> # CONFIG_KEYBOARD_TCA8418 is not set
> # CONFIG_KEYBOARD_MATRIX is not set
> CONFIG_KEYBOARD_LM8323=y
> CONFIG_KEYBOARD_LM8333=y
> CONFIG_KEYBOARD_MAX7359=y
> CONFIG_KEYBOARD_MCS=y
> CONFIG_KEYBOARD_MPR121=y
> CONFIG_KEYBOARD_NEWTON=y
> CONFIG_KEYBOARD_OPENCORES=y
> # CONFIG_KEYBOARD_SAMSUNG is not set
> CONFIG_KEYBOARD_STOWAWAY=y
> # CONFIG_KEYBOARD_SUNKBD is not set
> CONFIG_KEYBOARD_OMAP4=y
> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> CONFIG_KEYBOARD_TWL4030=y
> CONFIG_KEYBOARD_XTKBD=y
> # CONFIG_KEYBOARD_CROS_EC is not set
> CONFIG_KEYBOARD_CAP11XX=y
> # CONFIG_KEYBOARD_BCM is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> # CONFIG_MOUSE_PS2_ALPS is not set
> CONFIG_MOUSE_PS2_BYD=y
> # CONFIG_MOUSE_PS2_LOGIPS2PP is not set
> CONFIG_MOUSE_PS2_SYNAPTICS=y
> # CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS is not set
> # CONFIG_MOUSE_PS2_CYPRESS is not set
> CONFIG_MOUSE_PS2_LIFEBOOK=y
> # CONFIG_MOUSE_PS2_TRACKPOINT is not set
> CONFIG_MOUSE_PS2_ELANTECH=y
> # CONFIG_MOUSE_PS2_ELANTECH_SMBUS is not set
> # CONFIG_MOUSE_PS2_SENTELIC is not set
> # CONFIG_MOUSE_PS2_TOUCHKIT is not set
> # CONFIG_MOUSE_PS2_FOCALTECH is not set
> # CONFIG_MOUSE_PS2_VMMOUSE is not set
> # CONFIG_MOUSE_SERIAL is not set
> CONFIG_MOUSE_APPLETOUCH=y
> CONFIG_MOUSE_BCM5974=y
> CONFIG_MOUSE_CYAPA=y
> CONFIG_MOUSE_ELAN_I2C=y
> CONFIG_MOUSE_ELAN_I2C_I2C=y
> CONFIG_MOUSE_ELAN_I2C_SMBUS=y
> CONFIG_MOUSE_INPORT=y
> CONFIG_MOUSE_ATIXL=y
> # CONFIG_MOUSE_LOGIBM is not set
> CONFIG_MOUSE_PC110PAD=y
> CONFIG_MOUSE_VSXXXAA=y
> CONFIG_MOUSE_GPIO=y
> CONFIG_MOUSE_SYNAPTICS_I2C=y
> CONFIG_MOUSE_SYNAPTICS_USB=y
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TABLET is not set
> CONFIG_INPUT_TOUCHSCREEN=y
> CONFIG_TOUCHSCREEN_PROPERTIES=y
> CONFIG_TOUCHSCREEN_88PM860X=y
> # CONFIG_TOUCHSCREEN_AD7879 is not set
> # CONFIG_TOUCHSCREEN_ADC is not set
> CONFIG_TOUCHSCREEN_AR1021_I2C=y
> # CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
> CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
> # CONFIG_TOUCHSCREEN_BU21013 is not set
> CONFIG_TOUCHSCREEN_BU21029=y
> # CONFIG_TOUCHSCREEN_CHIPONE_ICN8318 is not set
> # CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
> # CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
> CONFIG_TOUCHSCREEN_CY8CTMG110=y
> CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
> CONFIG_TOUCHSCREEN_CYTTSP_I2C=y
> CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
> # CONFIG_TOUCHSCREEN_CYTTSP4_I2C is not set
> CONFIG_TOUCHSCREEN_DA9034=y
> CONFIG_TOUCHSCREEN_DA9052=y
> CONFIG_TOUCHSCREEN_DYNAPRO=y
> # CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
> # CONFIG_TOUCHSCREEN_EETI is not set
> CONFIG_TOUCHSCREEN_EGALAX=y
> CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
> CONFIG_TOUCHSCREEN_EXC3000=y
> # CONFIG_TOUCHSCREEN_FUJITSU is not set
> CONFIG_TOUCHSCREEN_GOODIX=y
> CONFIG_TOUCHSCREEN_HIDEEP=y
> # CONFIG_TOUCHSCREEN_ILI210X is not set
> CONFIG_TOUCHSCREEN_S6SY761=y
> # CONFIG_TOUCHSCREEN_GUNZE is not set
> CONFIG_TOUCHSCREEN_EKTF2127=y
> CONFIG_TOUCHSCREEN_ELAN=y
> CONFIG_TOUCHSCREEN_ELO=y
> CONFIG_TOUCHSCREEN_WACOM_W8001=y
> # CONFIG_TOUCHSCREEN_WACOM_I2C is not set
> # CONFIG_TOUCHSCREEN_MAX11801 is not set
> # CONFIG_TOUCHSCREEN_MCS5000 is not set
> CONFIG_TOUCHSCREEN_MMS114=y
> # CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
> CONFIG_TOUCHSCREEN_MTOUCH=y
> # CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
> CONFIG_TOUCHSCREEN_INEXIO=y
> # CONFIG_TOUCHSCREEN_MK712 is not set
> CONFIG_TOUCHSCREEN_HTCPEN=y
> CONFIG_TOUCHSCREEN_PENMOUNT=y
> # CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
> CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
> CONFIG_TOUCHSCREEN_TOUCHWIN=y
> # CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
> CONFIG_TOUCHSCREEN_PIXCIR=y
> CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
> # CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
> CONFIG_TOUCHSCREEN_TOUCHIT213=y
> # CONFIG_TOUCHSCREEN_TSC_SERIO is not set
> # CONFIG_TOUCHSCREEN_TSC2004 is not set
> CONFIG_TOUCHSCREEN_TSC2007=y
> CONFIG_TOUCHSCREEN_TSC2007_IIO=y
> # CONFIG_TOUCHSCREEN_RM_TS is not set
> CONFIG_TOUCHSCREEN_SILEAD=y
> CONFIG_TOUCHSCREEN_SIS_I2C=y
> CONFIG_TOUCHSCREEN_ST1232=y
> # CONFIG_TOUCHSCREEN_STMFTS is not set
> CONFIG_TOUCHSCREEN_SUR40=y
> CONFIG_TOUCHSCREEN_SX8654=y
> CONFIG_TOUCHSCREEN_TPS6507X=y
> # CONFIG_TOUCHSCREEN_ZET6223 is not set
> CONFIG_TOUCHSCREEN_ZFORCE=y
> CONFIG_TOUCHSCREEN_COLIBRI_VF50=y
> CONFIG_TOUCHSCREEN_ROHM_BU21023=y
> CONFIG_TOUCHSCREEN_IQS5XX=y
> # CONFIG_INPUT_MISC is not set
> CONFIG_RMI4_CORE=y
> CONFIG_RMI4_I2C=y
> CONFIG_RMI4_SMB=y
> CONFIG_RMI4_F03=y
> CONFIG_RMI4_F03_SERIO=y
> CONFIG_RMI4_2D_SENSOR=y
> CONFIG_RMI4_F11=y
> CONFIG_RMI4_F12=y
> CONFIG_RMI4_F30=y
> # CONFIG_RMI4_F34 is not set
> CONFIG_RMI4_F54=y
> CONFIG_RMI4_F55=y
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=y
> # CONFIG_SERIO_RAW is not set
> CONFIG_SERIO_ALTERA_PS2=y
> CONFIG_SERIO_PS2MULT=y
> CONFIG_SERIO_ARC_PS2=y
> # CONFIG_SERIO_APBPS2 is not set
> # CONFIG_SERIO_GPIO_PS2 is not set
> # CONFIG_USERIO is not set
> CONFIG_GAMEPORT=y
> CONFIG_GAMEPORT_NS558=y
> CONFIG_GAMEPORT_L4=y
> # CONFIG_GAMEPORT_EMU10K1 is not set
> # CONFIG_GAMEPORT_FM801 is not set
> # end of Hardware I/O ports
> # end of Input device support
> 
> #
> # Character devices
> #
> CONFIG_TTY=y
> # CONFIG_VT is not set
> CONFIG_UNIX98_PTYS=y
> # CONFIG_LEGACY_PTYS is not set
> CONFIG_LDISC_AUTOLOAD=y
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
> CONFIG_SERIAL_8250_PNP=y
> CONFIG_SERIAL_8250_16550A_VARIANTS=y
> CONFIG_SERIAL_8250_FINTEK=y
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_DMA=y
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_EXAR=y
> CONFIG_SERIAL_8250_CS=y
> # CONFIG_SERIAL_8250_MEN_MCB is not set
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> CONFIG_SERIAL_8250_ASPEED_VUART=y
> CONFIG_SERIAL_8250_DWLIB=y
> # CONFIG_SERIAL_8250_DW is not set
> CONFIG_SERIAL_8250_RT288X=y
> CONFIG_SERIAL_8250_LPSS=y
> CONFIG_SERIAL_8250_MID=y
> CONFIG_SERIAL_OF_PLATFORM=y
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_IMX_EARLYCON=y
> CONFIG_SERIAL_UARTLITE=y
> # CONFIG_SERIAL_UARTLITE_CONSOLE is not set
> CONFIG_SERIAL_UARTLITE_NR_UARTS=1
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> # CONFIG_SERIAL_JSM is not set
> CONFIG_SERIAL_SIFIVE=y
> CONFIG_SERIAL_SIFIVE_CONSOLE=y
> CONFIG_SERIAL_LANTIQ=y
> # CONFIG_SERIAL_LANTIQ_CONSOLE is not set
> CONFIG_SERIAL_SCCNXP=y
> CONFIG_SERIAL_SCCNXP_CONSOLE=y
> CONFIG_SERIAL_SC16IS7XX_CORE=y
> CONFIG_SERIAL_SC16IS7XX=y
> CONFIG_SERIAL_SC16IS7XX_I2C=y
> # CONFIG_SERIAL_TIMBERDALE is not set
> CONFIG_SERIAL_ALTERA_JTAGUART=y
> CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
> # CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS is not set
> CONFIG_SERIAL_ALTERA_UART=y
> CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
> CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
> CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
> # CONFIG_SERIAL_PCH_UART is not set
> CONFIG_SERIAL_XILINX_PS_UART=y
> # CONFIG_SERIAL_XILINX_PS_UART_CONSOLE is not set
> CONFIG_SERIAL_ARC=y
> # CONFIG_SERIAL_ARC_CONSOLE is not set
> CONFIG_SERIAL_ARC_NR_PORTS=1
> # CONFIG_SERIAL_RP2 is not set
> CONFIG_SERIAL_FSL_LPUART=y
> CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
> # CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE is not set
> CONFIG_SERIAL_MEN_Z135=y
> # CONFIG_SERIAL_SPRD is not set
> # end of Serial drivers
> 
> CONFIG_SERIAL_MCTRL_GPIO=y
> # CONFIG_SERIAL_NONSTANDARD is not set
> # CONFIG_N_GSM is not set
> # CONFIG_NOZOMI is not set
> # CONFIG_NULL_TTY is not set
> # CONFIG_TRACE_SINK is not set
> CONFIG_HVC_DRIVER=y
> CONFIG_SERIAL_DEV_BUS=y
> CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
> CONFIG_TTY_PRINTK=y
> CONFIG_TTY_PRINTK_LEVEL=6
> CONFIG_VIRTIO_CONSOLE=y
> CONFIG_IPMI_HANDLER=y
> CONFIG_IPMI_DMI_DECODE=y
> CONFIG_IPMI_PLAT_DATA=y
> CONFIG_IPMI_PANIC_EVENT=y
> CONFIG_IPMI_PANIC_STRING=y
> CONFIG_IPMI_DEVICE_INTERFACE=y
> CONFIG_IPMI_SI=y
> CONFIG_IPMI_SSIF=y
> CONFIG_IPMI_WATCHDOG=y
> CONFIG_IPMI_POWEROFF=y
> CONFIG_IPMB_DEVICE_INTERFACE=y
> # CONFIG_HW_RANDOM is not set
> CONFIG_DTLK=y
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
> 
> #
> # PCMCIA character devices
> #
> CONFIG_SYNCLINK_CS=y
> CONFIG_CARDMAN_4000=y
> CONFIG_CARDMAN_4040=y
> # CONFIG_SCR24X is not set
> # CONFIG_IPWIRELESS is not set
> # end of PCMCIA character devices
> 
> CONFIG_MWAVE=y
> CONFIG_PC8736x_GPIO=y
> CONFIG_NSC_GPIO=y
> # CONFIG_DEVMEM is not set
> # CONFIG_DEVKMEM is not set
> # CONFIG_NVRAM is not set
> CONFIG_RAW_DRIVER=y
> CONFIG_MAX_RAW_DEVS=256
> CONFIG_DEVPORT=y
> # CONFIG_HPET is not set
> CONFIG_HANGCHECK_TIMER=y
> CONFIG_TCG_TPM=y
> # CONFIG_TCG_TIS is not set
> # CONFIG_TCG_TIS_I2C_ATMEL is not set
> CONFIG_TCG_TIS_I2C_INFINEON=y
> CONFIG_TCG_TIS_I2C_NUVOTON=y
> CONFIG_TCG_NSC=y
> CONFIG_TCG_ATMEL=y
> # CONFIG_TCG_INFINEON is not set
> # CONFIG_TCG_CRB is not set
> CONFIG_TCG_VTPM_PROXY=y
> # CONFIG_TCG_TIS_ST33ZP24_I2C is not set
> # CONFIG_TELCLOCK is not set
> CONFIG_XILLYBUS=y
> CONFIG_XILLYBUS_OF=y
> # end of Character devices
> 
> # CONFIG_RANDOM_TRUST_CPU is not set
> CONFIG_RANDOM_TRUST_BOOTLOADER=y
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> CONFIG_ACPI_I2C_OPREGION=y
> CONFIG_I2C_BOARDINFO=y
> # CONFIG_I2C_COMPAT is not set
> CONFIG_I2C_CHARDEV=y
> CONFIG_I2C_MUX=y
> 
> #
> # Multiplexer I2C Chip support
> #
> CONFIG_I2C_ARB_GPIO_CHALLENGE=y
> CONFIG_I2C_MUX_GPIO=y
> CONFIG_I2C_MUX_GPMUX=y
> CONFIG_I2C_MUX_LTC4306=y
> # CONFIG_I2C_MUX_PCA9541 is not set
> CONFIG_I2C_MUX_PCA954x=y
> CONFIG_I2C_MUX_PINCTRL=y
> CONFIG_I2C_MUX_REG=y
> CONFIG_I2C_DEMUX_PINCTRL=y
> CONFIG_I2C_MUX_MLXCPLD=y
> # end of Multiplexer I2C Chip support
> 
> CONFIG_I2C_HELPER_AUTO=y
> CONFIG_I2C_ALGOBIT=y
> CONFIG_I2C_ALGOPCF=y
> CONFIG_I2C_ALGOPCA=y
> 
> #
> # I2C Hardware Bus support
> #
> 
> #
> # PC SMBus host controller drivers
> #
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI1563 is not set
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_AMD_MP2 is not set
> # CONFIG_I2C_I801 is not set
> # CONFIG_I2C_ISCH is not set
> # CONFIG_I2C_ISMT is not set
> # CONFIG_I2C_PIIX4 is not set
> # CONFIG_I2C_NFORCE2 is not set
> # CONFIG_I2C_NVIDIA_GPU is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> # CONFIG_I2C_SIS96X is not set
> # CONFIG_I2C_VIA is not set
> # CONFIG_I2C_VIAPRO is not set
> 
> #
> # ACPI drivers
> #
> # CONFIG_I2C_SCMI is not set
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_CBUS_GPIO is not set
> CONFIG_I2C_DESIGNWARE_CORE=y
> # CONFIG_I2C_DESIGNWARE_SLAVE is not set
> CONFIG_I2C_DESIGNWARE_PLATFORM=y
> # CONFIG_I2C_DESIGNWARE_PCI is not set
> # CONFIG_I2C_EG20T is not set
> CONFIG_I2C_EMEV2=y
> CONFIG_I2C_GPIO=y
> CONFIG_I2C_GPIO_FAULT_INJECTOR=y
> CONFIG_I2C_OCORES=y
> CONFIG_I2C_PCA_PLATFORM=y
> # CONFIG_I2C_PXA is not set
> # CONFIG_I2C_RK3X is not set
> CONFIG_I2C_SIMTEC=y
> CONFIG_I2C_XILINX=y
> 
> #
> # External I2C/SMBus adapter drivers
> #
> # CONFIG_I2C_DIOLAN_U2C is not set
> CONFIG_I2C_DLN2=y
> # CONFIG_I2C_ROBOTFUZZ_OSIF is not set
> CONFIG_I2C_TAOS_EVM=y
> # CONFIG_I2C_TINY_USB is not set
> 
> #
> # Other I2C/SMBus bus drivers
> #
> CONFIG_I2C_ELEKTOR=y
> CONFIG_I2C_PCA_ISA=y
> CONFIG_I2C_CROS_EC_TUNNEL=y
> # CONFIG_SCx200_ACB is not set
> # end of I2C Hardware Bus support
> 
> # CONFIG_I2C_STUB is not set
> CONFIG_I2C_SLAVE=y
> CONFIG_I2C_SLAVE_EEPROM=y
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # end of I2C support
> 
> CONFIG_I3C=y
> CONFIG_CDNS_I3C_MASTER=y
> CONFIG_DW_I3C_MASTER=y
> # CONFIG_SPI is not set
> CONFIG_SPMI=y
> CONFIG_HSI=y
> CONFIG_HSI_BOARDINFO=y
> 
> #
> # HSI controllers
> #
> 
> #
> # HSI clients
> #
> CONFIG_HSI_CHAR=y
> CONFIG_PPS=y
> # CONFIG_PPS_DEBUG is not set
> # CONFIG_NTP_PPS is not set
> 
> #
> # PPS clients support
> #
> # CONFIG_PPS_CLIENT_KTIMER is not set
> CONFIG_PPS_CLIENT_LDISC=y
> # CONFIG_PPS_CLIENT_GPIO is not set
> 
> #
> # PPS generators support
> #
> 
> #
> # PTP clock support
> #
> # CONFIG_PTP_1588_CLOCK is not set
> 
> #
> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> #
> # CONFIG_PTP_1588_CLOCK_PCH is not set
> # end of PTP clock support
> 
> CONFIG_PINCTRL=y
> CONFIG_GENERIC_PINCTRL_GROUPS=y
> CONFIG_PINMUX=y
> CONFIG_GENERIC_PINMUX_FUNCTIONS=y
> CONFIG_PINCONF=y
> CONFIG_GENERIC_PINCONF=y
> CONFIG_DEBUG_PINCTRL=y
> # CONFIG_PINCTRL_AS3722 is not set
> CONFIG_PINCTRL_AXP209=y
> # CONFIG_PINCTRL_AMD is not set
> CONFIG_PINCTRL_MCP23S08_I2C=y
> CONFIG_PINCTRL_MCP23S08=y
> CONFIG_PINCTRL_SINGLE=y
> # CONFIG_PINCTRL_SX150X is not set
> # CONFIG_PINCTRL_STMFX is not set
> # CONFIG_PINCTRL_RK805 is not set
> CONFIG_PINCTRL_OCELOT=y
> # CONFIG_PINCTRL_BAYTRAIL is not set
> # CONFIG_PINCTRL_CHERRYVIEW is not set
> # CONFIG_PINCTRL_LYNXPOINT is not set
> # CONFIG_PINCTRL_BROXTON is not set
> # CONFIG_PINCTRL_CANNONLAKE is not set
> # CONFIG_PINCTRL_CEDARFORK is not set
> # CONFIG_PINCTRL_DENVERTON is not set
> # CONFIG_PINCTRL_EMMITSBURG is not set
> # CONFIG_PINCTRL_GEMINILAKE is not set
> # CONFIG_PINCTRL_ICELAKE is not set
> # CONFIG_PINCTRL_JASPERLAKE is not set
> # CONFIG_PINCTRL_LEWISBURG is not set
> # CONFIG_PINCTRL_SUNRISEPOINT is not set
> # CONFIG_PINCTRL_TIGERLAKE is not set
> CONFIG_PINCTRL_MADERA=y
> CONFIG_PINCTRL_CS47L15=y
> CONFIG_PINCTRL_CS47L35=y
> CONFIG_PINCTRL_CS47L92=y
> CONFIG_PINCTRL_EQUILIBRIUM=y
> CONFIG_GPIOLIB=y
> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> CONFIG_OF_GPIO=y
> CONFIG_GPIO_ACPI=y
> CONFIG_GPIOLIB_IRQCHIP=y
> CONFIG_DEBUG_GPIO=y
> # CONFIG_GPIO_SYSFS is not set
> CONFIG_GPIO_GENERIC=y
> CONFIG_GPIO_MAX730X=y
> 
> #
> # Memory mapped GPIO drivers
> #
> CONFIG_GPIO_74XX_MMIO=y
> CONFIG_GPIO_ALTERA=y
> # CONFIG_GPIO_AMDPT is not set
> CONFIG_GPIO_CADENCE=y
> CONFIG_GPIO_DWAPB=y
> # CONFIG_GPIO_EXAR is not set
> # CONFIG_GPIO_FTGPIO010 is not set
> CONFIG_GPIO_GENERIC_PLATFORM=y
> CONFIG_GPIO_GRGPIO=y
> # CONFIG_GPIO_HLWD is not set
> # CONFIG_GPIO_ICH is not set
> CONFIG_GPIO_LOGICVC=y
> CONFIG_GPIO_MB86S7X=y
> CONFIG_GPIO_MENZ127=y
> # CONFIG_GPIO_SAMA5D2_PIOBU is not set
> CONFIG_GPIO_SIFIVE=y
> CONFIG_GPIO_SIOX=y
> # CONFIG_GPIO_SYSCON is not set
> # CONFIG_GPIO_VX855 is not set
> # CONFIG_GPIO_XILINX is not set
> CONFIG_GPIO_AMD_FCH=y
> # end of Memory mapped GPIO drivers
> 
> #
> # Port-mapped I/O GPIO drivers
> #
> CONFIG_GPIO_F7188X=y
> CONFIG_GPIO_IT87=y
> # CONFIG_GPIO_SCH is not set
> CONFIG_GPIO_SCH311X=y
> # CONFIG_GPIO_WINBOND is not set
> CONFIG_GPIO_WS16C48=y
> # end of Port-mapped I/O GPIO drivers
> 
> #
> # I2C GPIO expanders
> #
> # CONFIG_GPIO_ADP5588 is not set
> CONFIG_GPIO_ADNP=y
> CONFIG_GPIO_GW_PLD=y
> CONFIG_GPIO_MAX7300=y
> CONFIG_GPIO_MAX732X=y
> CONFIG_GPIO_MAX732X_IRQ=y
> CONFIG_GPIO_PCA953X=y
> # CONFIG_GPIO_PCA953X_IRQ is not set
> # CONFIG_GPIO_PCA9570 is not set
> CONFIG_GPIO_PCF857X=y
> CONFIG_GPIO_TPIC2810=y
> # end of I2C GPIO expanders
> 
> #
> # MFD GPIO expanders
> #
> CONFIG_GPIO_ARIZONA=y
> CONFIG_GPIO_BD71828=y
> CONFIG_GPIO_BD9571MWV=y
> CONFIG_GPIO_DA9052=y
> # CONFIG_GPIO_DA9055 is not set
> CONFIG_GPIO_DLN2=y
> CONFIG_GPIO_LP3943=y
> # CONFIG_GPIO_LP873X is not set
> CONFIG_GPIO_LP87565=y
> CONFIG_GPIO_MADERA=y
> CONFIG_GPIO_MAX77650=y
> CONFIG_GPIO_RC5T583=y
> CONFIG_GPIO_TPS65086=y
> CONFIG_GPIO_TPS65912=y
> CONFIG_GPIO_TWL4030=y
> # end of MFD GPIO expanders
> 
> #
> # PCI GPIO expanders
> #
> # CONFIG_GPIO_AMD8111 is not set
> # CONFIG_GPIO_BT8XX is not set
> # CONFIG_GPIO_ML_IOH is not set
> # CONFIG_GPIO_PCH is not set
> # CONFIG_GPIO_PCI_IDIO_16 is not set
> # CONFIG_GPIO_PCIE_IDIO_24 is not set
> # CONFIG_GPIO_RDC321X is not set
> # CONFIG_GPIO_SODAVILLE is not set
> # end of PCI GPIO expanders
> 
> #
> # USB GPIO expanders
> #
> # end of USB GPIO expanders
> 
> CONFIG_GPIO_AGGREGATOR=y
> CONFIG_GPIO_MOCKUP=y
> # CONFIG_W1 is not set
> # CONFIG_POWER_AVS is not set
> CONFIG_POWER_RESET=y
> # CONFIG_POWER_RESET_AS3722 is not set
> CONFIG_POWER_RESET_GPIO=y
> CONFIG_POWER_RESET_GPIO_RESTART=y
> # CONFIG_POWER_RESET_LTC2952 is not set
> # CONFIG_POWER_RESET_RESTART is not set
> # CONFIG_POWER_RESET_SYSCON is not set
> # CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
> CONFIG_REBOOT_MODE=y
> CONFIG_SYSCON_REBOOT_MODE=y
> CONFIG_NVMEM_REBOOT_MODE=y
> CONFIG_POWER_SUPPLY=y
> CONFIG_POWER_SUPPLY_DEBUG=y
> # CONFIG_POWER_SUPPLY_HWMON is not set
> CONFIG_PDA_POWER=y
> CONFIG_GENERIC_ADC_BATTERY=y
> # CONFIG_TEST_POWER is not set
> CONFIG_BATTERY_88PM860X=y
> CONFIG_CHARGER_ADP5061=y
> # CONFIG_BATTERY_CW2015 is not set
> # CONFIG_BATTERY_DS2780 is not set
> # CONFIG_BATTERY_DS2781 is not set
> CONFIG_BATTERY_DS2782=y
> # CONFIG_BATTERY_LEGO_EV3 is not set
> CONFIG_BATTERY_SBS=y
> CONFIG_CHARGER_SBS=y
> # CONFIG_MANAGER_SBS is not set
> CONFIG_BATTERY_BQ27XXX=y
> CONFIG_BATTERY_BQ27XXX_I2C=y
> CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
> CONFIG_BATTERY_DA9030=y
> CONFIG_BATTERY_DA9052=y
> # CONFIG_AXP20X_POWER is not set
> # CONFIG_AXP288_FUEL_GAUGE is not set
> CONFIG_BATTERY_MAX17040=y
> CONFIG_BATTERY_MAX17042=y
> CONFIG_CHARGER_88PM860X=y
> CONFIG_CHARGER_ISP1704=y
> CONFIG_CHARGER_MAX8903=y
> CONFIG_CHARGER_TWL4030=y
> CONFIG_CHARGER_LP8727=y
> # CONFIG_CHARGER_GPIO is not set
> # CONFIG_CHARGER_MANAGER is not set
> # CONFIG_CHARGER_LT3651 is not set
> CONFIG_CHARGER_DETECTOR_MAX14656=y
> # CONFIG_CHARGER_MAX77650 is not set
> CONFIG_CHARGER_MAX8997=y
> CONFIG_CHARGER_BQ2415X=y
> CONFIG_CHARGER_BQ24190=y
> # CONFIG_CHARGER_BQ24257 is not set
> CONFIG_CHARGER_BQ24735=y
> CONFIG_CHARGER_BQ2515X=y
> # CONFIG_CHARGER_BQ25890 is not set
> CONFIG_CHARGER_SMB347=y
> CONFIG_CHARGER_TPS65217=y
> CONFIG_BATTERY_GAUGE_LTC2941=y
> CONFIG_BATTERY_RT5033=y
> # CONFIG_CHARGER_RT9455 is not set
> # CONFIG_CHARGER_CROS_USBPD is not set
> CONFIG_CHARGER_UCS1002=y
> # CONFIG_CHARGER_BD99954 is not set
> CONFIG_HWMON=y
> CONFIG_HWMON_VID=y
> # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> #
> # Native drivers
> #
> CONFIG_SENSORS_ABITUGURU=y
> CONFIG_SENSORS_ABITUGURU3=y
> CONFIG_SENSORS_AD7414=y
> # CONFIG_SENSORS_AD7418 is not set
> CONFIG_SENSORS_ADM1021=y
> CONFIG_SENSORS_ADM1025=y
> # CONFIG_SENSORS_ADM1026 is not set
> # CONFIG_SENSORS_ADM1029 is not set
> CONFIG_SENSORS_ADM1031=y
> CONFIG_SENSORS_ADM1177=y
> # CONFIG_SENSORS_ADM9240 is not set
> # CONFIG_SENSORS_ADT7410 is not set
> # CONFIG_SENSORS_ADT7411 is not set
> CONFIG_SENSORS_ADT7462=y
> # CONFIG_SENSORS_ADT7470 is not set
> CONFIG_SENSORS_ADT7475=y
> # CONFIG_SENSORS_AS370 is not set
> CONFIG_SENSORS_ASC7621=y
> # CONFIG_SENSORS_AXI_FAN_CONTROL is not set
> # CONFIG_SENSORS_K8TEMP is not set
> # CONFIG_SENSORS_K10TEMP is not set
> # CONFIG_SENSORS_FAM15H_POWER is not set
> # CONFIG_SENSORS_AMD_ENERGY is not set
> # CONFIG_SENSORS_APPLESMC is not set
> # CONFIG_SENSORS_ASB100 is not set
> CONFIG_SENSORS_ASPEED=y
> # CONFIG_SENSORS_ATXP1 is not set
> CONFIG_SENSORS_CORSAIR_CPRO=y
> CONFIG_SENSORS_DS620=y
> CONFIG_SENSORS_DS1621=y
> CONFIG_SENSORS_DELL_SMM=y
> CONFIG_SENSORS_DA9052_ADC=y
> CONFIG_SENSORS_DA9055=y
> # CONFIG_SENSORS_I5K_AMB is not set
> CONFIG_SENSORS_F71805F=y
> # CONFIG_SENSORS_F71882FG is not set
> # CONFIG_SENSORS_F75375S is not set
> CONFIG_SENSORS_GSC=y
> CONFIG_SENSORS_FSCHMD=y
> CONFIG_SENSORS_GL518SM=y
> # CONFIG_SENSORS_GL520SM is not set
> # CONFIG_SENSORS_G760A is not set
> # CONFIG_SENSORS_G762 is not set
> CONFIG_SENSORS_GPIO_FAN=y
> # CONFIG_SENSORS_HIH6130 is not set
> CONFIG_SENSORS_IBMAEM=y
> CONFIG_SENSORS_IBMPEX=y
> # CONFIG_SENSORS_IIO_HWMON is not set
> # CONFIG_SENSORS_I5500 is not set
> # CONFIG_SENSORS_CORETEMP is not set
> CONFIG_SENSORS_IT87=y
> CONFIG_SENSORS_JC42=y
> # CONFIG_SENSORS_POWR1220 is not set
> CONFIG_SENSORS_LINEAGE=y
> # CONFIG_SENSORS_LTC2945 is not set
> CONFIG_SENSORS_LTC2947=y
> CONFIG_SENSORS_LTC2947_I2C=y
> # CONFIG_SENSORS_LTC2990 is not set
> CONFIG_SENSORS_LTC4151=y
> # CONFIG_SENSORS_LTC4215 is not set
> # CONFIG_SENSORS_LTC4222 is not set
> # CONFIG_SENSORS_LTC4245 is not set
> CONFIG_SENSORS_LTC4260=y
> # CONFIG_SENSORS_LTC4261 is not set
> CONFIG_SENSORS_MAX16065=y
> CONFIG_SENSORS_MAX1619=y
> CONFIG_SENSORS_MAX1668=y
> CONFIG_SENSORS_MAX197=y
> # CONFIG_SENSORS_MAX31730 is not set
> CONFIG_SENSORS_MAX6621=y
> CONFIG_SENSORS_MAX6639=y
> # CONFIG_SENSORS_MAX6642 is not set
> CONFIG_SENSORS_MAX6650=y
> CONFIG_SENSORS_MAX6697=y
> CONFIG_SENSORS_MAX31790=y
> # CONFIG_SENSORS_MCP3021 is not set
> CONFIG_SENSORS_TC654=y
> CONFIG_SENSORS_MENF21BMC_HWMON=y
> CONFIG_SENSORS_LM63=y
> # CONFIG_SENSORS_LM73 is not set
> CONFIG_SENSORS_LM75=y
> CONFIG_SENSORS_LM77=y
> CONFIG_SENSORS_LM78=y
> CONFIG_SENSORS_LM80=y
> CONFIG_SENSORS_LM83=y
> # CONFIG_SENSORS_LM85 is not set
> # CONFIG_SENSORS_LM87 is not set
> # CONFIG_SENSORS_LM90 is not set
> CONFIG_SENSORS_LM92=y
> # CONFIG_SENSORS_LM93 is not set
> CONFIG_SENSORS_LM95234=y
> # CONFIG_SENSORS_LM95241 is not set
> CONFIG_SENSORS_LM95245=y
> CONFIG_SENSORS_PC87360=y
> # CONFIG_SENSORS_PC87427 is not set
> # CONFIG_SENSORS_NTC_THERMISTOR is not set
> # CONFIG_SENSORS_NCT6683 is not set
> CONFIG_SENSORS_NCT6775=y
> # CONFIG_SENSORS_NCT7802 is not set
> # CONFIG_SENSORS_NPCM7XX is not set
> CONFIG_SENSORS_PCF8591=y
> # CONFIG_PMBUS is not set
> # CONFIG_SENSORS_PWM_FAN is not set
> CONFIG_SENSORS_SHT15=y
> # CONFIG_SENSORS_SHT21 is not set
> # CONFIG_SENSORS_SHT3x is not set
> CONFIG_SENSORS_SHTC1=y
> # CONFIG_SENSORS_SIS5595 is not set
> CONFIG_SENSORS_DME1737=y
> # CONFIG_SENSORS_EMC1403 is not set
> CONFIG_SENSORS_EMC2103=y
> CONFIG_SENSORS_EMC6W201=y
> # CONFIG_SENSORS_SMSC47M1 is not set
> CONFIG_SENSORS_SMSC47M192=y
> CONFIG_SENSORS_SMSC47B397=y
> CONFIG_SENSORS_STTS751=y
> CONFIG_SENSORS_SMM665=y
> CONFIG_SENSORS_ADC128D818=y
> CONFIG_SENSORS_ADS7828=y
> CONFIG_SENSORS_AMC6821=y
> CONFIG_SENSORS_INA209=y
> # CONFIG_SENSORS_INA2XX is not set
> CONFIG_SENSORS_INA3221=y
> # CONFIG_SENSORS_TC74 is not set
> CONFIG_SENSORS_THMC50=y
> CONFIG_SENSORS_TMP102=y
> CONFIG_SENSORS_TMP103=y
> # CONFIG_SENSORS_TMP108 is not set
> # CONFIG_SENSORS_TMP401 is not set
> # CONFIG_SENSORS_TMP421 is not set
> # CONFIG_SENSORS_TMP513 is not set
> CONFIG_SENSORS_VIA_CPUTEMP=y
> # CONFIG_SENSORS_VIA686A is not set
> CONFIG_SENSORS_VT1211=y
> # CONFIG_SENSORS_VT8231 is not set
> # CONFIG_SENSORS_W83773G is not set
> CONFIG_SENSORS_W83781D=y
> CONFIG_SENSORS_W83791D=y
> CONFIG_SENSORS_W83792D=y
> CONFIG_SENSORS_W83793=y
> CONFIG_SENSORS_W83795=y
> # CONFIG_SENSORS_W83795_FANCTRL is not set
> CONFIG_SENSORS_W83L785TS=y
> CONFIG_SENSORS_W83L786NG=y
> CONFIG_SENSORS_W83627HF=y
> CONFIG_SENSORS_W83627EHF=y
> 
> #
> # ACPI drivers
> #
> # CONFIG_SENSORS_ACPI_POWER is not set
> # CONFIG_SENSORS_ATK0110 is not set
> CONFIG_THERMAL=y
> # CONFIG_THERMAL_NETLINK is not set
> # CONFIG_THERMAL_STATISTICS is not set
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> CONFIG_THERMAL_HWMON=y
> CONFIG_THERMAL_OF=y
> # CONFIG_THERMAL_WRITABLE_TRIPS is not set
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> # CONFIG_THERMAL_GOV_FAIR_SHARE is not set
> CONFIG_THERMAL_GOV_STEP_WISE=y
> # CONFIG_THERMAL_GOV_BANG_BANG is not set
> # CONFIG_THERMAL_GOV_USER_SPACE is not set
> # CONFIG_CPU_THERMAL is not set
> # CONFIG_DEVFREQ_THERMAL is not set
> # CONFIG_THERMAL_EMULATION is not set
> # CONFIG_THERMAL_MMIO is not set
> 
> #
> # Intel thermal drivers
> #
> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
> 
> #
> # ACPI INT340X thermal drivers
> #
> # CONFIG_INT340X_THERMAL is not set
> # end of ACPI INT340X thermal drivers
> 
> # CONFIG_INTEL_PCH_THERMAL is not set
> # end of Intel thermal drivers
> 
> # CONFIG_GENERIC_ADC_THERMAL is not set
> # CONFIG_WATCHDOG is not set
> CONFIG_SSB_POSSIBLE=y
> CONFIG_SSB=y
> CONFIG_SSB_SPROM=y
> CONFIG_SSB_PCIHOST_POSSIBLE=y
> CONFIG_SSB_PCIHOST=y
> CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
> # CONFIG_SSB_PCMCIAHOST is not set
> CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
> # CONFIG_SSB_DRIVER_PCICORE is not set
> # CONFIG_SSB_DRIVER_GPIO is not set
> CONFIG_BCMA_POSSIBLE=y
> # CONFIG_BCMA is not set
> 
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=y
> # CONFIG_MFD_CS5535 is not set
> # CONFIG_MFD_ACT8945A is not set
> CONFIG_MFD_AS3711=y
> CONFIG_MFD_AS3722=y
> # CONFIG_PMIC_ADP5520 is not set
> # CONFIG_MFD_AAT2870_CORE is not set
> # CONFIG_MFD_ATMEL_FLEXCOM is not set
> CONFIG_MFD_ATMEL_HLCDC=y
> CONFIG_MFD_BCM590XX=y
> CONFIG_MFD_BD9571MWV=y
> CONFIG_MFD_AXP20X=y
> CONFIG_MFD_AXP20X_I2C=y
> CONFIG_MFD_CROS_EC_DEV=y
> CONFIG_MFD_MADERA=y
> CONFIG_MFD_MADERA_I2C=y
> CONFIG_MFD_CS47L15=y
> CONFIG_MFD_CS47L35=y
> # CONFIG_MFD_CS47L85 is not set
> # CONFIG_MFD_CS47L90 is not set
> CONFIG_MFD_CS47L92=y
> CONFIG_PMIC_DA903X=y
> CONFIG_PMIC_DA9052=y
> CONFIG_MFD_DA9052_I2C=y
> CONFIG_MFD_DA9055=y
> # CONFIG_MFD_DA9062 is not set
> CONFIG_MFD_DA9063=y
> # CONFIG_MFD_DA9150 is not set
> CONFIG_MFD_DLN2=y
> CONFIG_MFD_GATEWORKS_GSC=y
> # CONFIG_MFD_MC13XXX_I2C is not set
> CONFIG_MFD_MP2629=y
> CONFIG_MFD_HI6421_PMIC=y
> # CONFIG_HTC_PASIC3 is not set
> CONFIG_HTC_I2CPLD=y
> # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> # CONFIG_LPC_ICH is not set
> # CONFIG_LPC_SCH is not set
> # CONFIG_INTEL_SOC_PMIC is not set
> # CONFIG_INTEL_SOC_PMIC_CHTWC is not set
> # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
> # CONFIG_MFD_INTEL_LPSS_ACPI is not set
> # CONFIG_MFD_INTEL_LPSS_PCI is not set
> # CONFIG_MFD_IQS62X is not set
> # CONFIG_MFD_JANZ_CMODIO is not set
> # CONFIG_MFD_KEMPLD is not set
> # CONFIG_MFD_88PM800 is not set
> # CONFIG_MFD_88PM805 is not set
> CONFIG_MFD_88PM860X=y
> # CONFIG_MFD_MAX14577 is not set
> # CONFIG_MFD_MAX77620 is not set
> CONFIG_MFD_MAX77650=y
> # CONFIG_MFD_MAX77686 is not set
> # CONFIG_MFD_MAX77693 is not set
> CONFIG_MFD_MAX77843=y
> CONFIG_MFD_MAX8907=y
> # CONFIG_MFD_MAX8925 is not set
> CONFIG_MFD_MAX8997=y
> # CONFIG_MFD_MAX8998 is not set
> CONFIG_MFD_MT6360=y
> # CONFIG_MFD_MT6397 is not set
> CONFIG_MFD_MENF21BMC=y
> # CONFIG_MFD_VIPERBOARD is not set
> CONFIG_MFD_RETU=y
> # CONFIG_MFD_PCF50633 is not set
> # CONFIG_MFD_RDC321X is not set
> CONFIG_MFD_RT5033=y
> CONFIG_MFD_RC5T583=y
> CONFIG_MFD_RK808=y
> CONFIG_MFD_RN5T618=y
> # CONFIG_MFD_SEC_CORE is not set
> # CONFIG_MFD_SI476X_CORE is not set
> CONFIG_MFD_SM501=y
> # CONFIG_MFD_SM501_GPIO is not set
> CONFIG_MFD_SKY81452=y
> CONFIG_ABX500_CORE=y
> # CONFIG_AB3100_CORE is not set
> # CONFIG_MFD_STMPE is not set
> CONFIG_MFD_SYSCON=y
> CONFIG_MFD_TI_AM335X_TSCADC=y
> CONFIG_MFD_LP3943=y
> # CONFIG_MFD_LP8788 is not set
> CONFIG_MFD_TI_LMU=y
> # CONFIG_MFD_PALMAS is not set
> CONFIG_TPS6105X=y
> # CONFIG_TPS65010 is not set
> CONFIG_TPS6507X=y
> CONFIG_MFD_TPS65086=y
> # CONFIG_MFD_TPS65090 is not set
> CONFIG_MFD_TPS65217=y
> # CONFIG_MFD_TPS68470 is not set
> CONFIG_MFD_TI_LP873X=y
> CONFIG_MFD_TI_LP87565=y
> # CONFIG_MFD_TPS65218 is not set
> # CONFIG_MFD_TPS6586X is not set
> # CONFIG_MFD_TPS65910 is not set
> CONFIG_MFD_TPS65912=y
> CONFIG_MFD_TPS65912_I2C=y
> # CONFIG_MFD_TPS80031 is not set
> CONFIG_TWL4030_CORE=y
> CONFIG_MFD_TWL4030_AUDIO=y
> # CONFIG_TWL6040_CORE is not set
> CONFIG_MFD_WL1273_CORE=y
> CONFIG_MFD_LM3533=y
> # CONFIG_MFD_TIMBERDALE is not set
> # CONFIG_MFD_TC3589X is not set
> # CONFIG_MFD_TQMX86 is not set
> # CONFIG_MFD_VX855 is not set
> # CONFIG_MFD_LOCHNAGAR is not set
> CONFIG_MFD_ARIZONA=y
> CONFIG_MFD_ARIZONA_I2C=y
> # CONFIG_MFD_CS47L24 is not set
> CONFIG_MFD_WM5102=y
> CONFIG_MFD_WM5110=y
> CONFIG_MFD_WM8997=y
> CONFIG_MFD_WM8998=y
> # CONFIG_MFD_WM8400 is not set
> # CONFIG_MFD_WM831X_I2C is not set
> # CONFIG_MFD_WM8350_I2C is not set
> # CONFIG_MFD_WM8994 is not set
> CONFIG_MFD_ROHM_BD718XX=y
> # CONFIG_MFD_ROHM_BD70528 is not set
> CONFIG_MFD_ROHM_BD71828=y
> CONFIG_MFD_STPMIC1=y
> CONFIG_MFD_STMFX=y
> CONFIG_RAVE_SP_CORE=y
> # end of Multifunction device drivers
> 
> CONFIG_REGULATOR=y
> # CONFIG_REGULATOR_DEBUG is not set
> CONFIG_REGULATOR_FIXED_VOLTAGE=y
> CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
> # CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
> CONFIG_REGULATOR_88PG86X=y
> CONFIG_REGULATOR_88PM8607=y
> CONFIG_REGULATOR_ACT8865=y
> # CONFIG_REGULATOR_AD5398 is not set
> CONFIG_REGULATOR_AS3711=y
> # CONFIG_REGULATOR_AS3722 is not set
> # CONFIG_REGULATOR_AXP20X is not set
> CONFIG_REGULATOR_BCM590XX=y
> CONFIG_REGULATOR_BD71828=y
> CONFIG_REGULATOR_BD718XX=y
> # CONFIG_REGULATOR_BD9571MWV is not set
> # CONFIG_REGULATOR_CROS_EC is not set
> CONFIG_REGULATOR_DA903X=y
> # CONFIG_REGULATOR_DA9052 is not set
> CONFIG_REGULATOR_DA9055=y
> # CONFIG_REGULATOR_DA9063 is not set
> CONFIG_REGULATOR_DA9210=y
> CONFIG_REGULATOR_DA9211=y
> CONFIG_REGULATOR_FAN53555=y
> CONFIG_REGULATOR_FAN53880=y
> # CONFIG_REGULATOR_GPIO is not set
> CONFIG_REGULATOR_HI6421=y
> CONFIG_REGULATOR_HI6421V530=y
> # CONFIG_REGULATOR_ISL9305 is not set
> # CONFIG_REGULATOR_ISL6271A is not set
> CONFIG_REGULATOR_LM363X=y
> CONFIG_REGULATOR_LP3971=y
> # CONFIG_REGULATOR_LP3972 is not set
> # CONFIG_REGULATOR_LP872X is not set
> # CONFIG_REGULATOR_LP873X is not set
> CONFIG_REGULATOR_LP8755=y
> # CONFIG_REGULATOR_LP87565 is not set
> CONFIG_REGULATOR_LTC3589=y
> CONFIG_REGULATOR_LTC3676=y
> CONFIG_REGULATOR_MAX1586=y
> # CONFIG_REGULATOR_MAX77650 is not set
> CONFIG_REGULATOR_MAX8649=y
> CONFIG_REGULATOR_MAX8660=y
> # CONFIG_REGULATOR_MAX8907 is not set
> # CONFIG_REGULATOR_MAX8952 is not set
> # CONFIG_REGULATOR_MAX8973 is not set
> CONFIG_REGULATOR_MAX8997=y
> # CONFIG_REGULATOR_MAX77693 is not set
> CONFIG_REGULATOR_MAX77826=y
> # CONFIG_REGULATOR_MCP16502 is not set
> CONFIG_REGULATOR_MP5416=y
> # CONFIG_REGULATOR_MP8859 is not set
> CONFIG_REGULATOR_MP886X=y
> CONFIG_REGULATOR_MPQ7920=y
> # CONFIG_REGULATOR_MT6311 is not set
> CONFIG_REGULATOR_PCA9450=y
> CONFIG_REGULATOR_PFUZE100=y
> # CONFIG_REGULATOR_PV88060 is not set
> CONFIG_REGULATOR_PV88080=y
> CONFIG_REGULATOR_PV88090=y
> CONFIG_REGULATOR_PWM=y
> # CONFIG_REGULATOR_QCOM_SPMI is not set
> CONFIG_REGULATOR_QCOM_USB_VBUS=y
> # CONFIG_REGULATOR_RC5T583 is not set
> # CONFIG_REGULATOR_RK808 is not set
> CONFIG_REGULATOR_RN5T618=y
> CONFIG_REGULATOR_ROHM=y
> # CONFIG_REGULATOR_RT5033 is not set
> # CONFIG_REGULATOR_SKY81452 is not set
> # CONFIG_REGULATOR_SLG51000 is not set
> CONFIG_REGULATOR_STPMIC1=y
> CONFIG_REGULATOR_SY8106A=y
> CONFIG_REGULATOR_SY8824X=y
> # CONFIG_REGULATOR_SY8827N is not set
> # CONFIG_REGULATOR_TPS51632 is not set
> # CONFIG_REGULATOR_TPS6105X is not set
> CONFIG_REGULATOR_TPS62360=y
> CONFIG_REGULATOR_TPS65023=y
> CONFIG_REGULATOR_TPS6507X=y
> CONFIG_REGULATOR_TPS65086=y
> # CONFIG_REGULATOR_TPS65132 is not set
> # CONFIG_REGULATOR_TPS65217 is not set
> CONFIG_REGULATOR_TPS65912=y
> CONFIG_REGULATOR_TWL4030=y
> CONFIG_REGULATOR_VCTRL=y
> # CONFIG_REGULATOR_QCOM_LABIBB is not set
> CONFIG_RC_CORE=y
> CONFIG_RC_MAP=y
> # CONFIG_LIRC is not set
> CONFIG_RC_DECODERS=y
> # CONFIG_IR_NEC_DECODER is not set
> CONFIG_IR_RC5_DECODER=y
> CONFIG_IR_RC6_DECODER=y
> CONFIG_IR_JVC_DECODER=y
> CONFIG_IR_SONY_DECODER=y
> # CONFIG_IR_SANYO_DECODER is not set
> CONFIG_IR_SHARP_DECODER=y
> # CONFIG_IR_MCE_KBD_DECODER is not set
> CONFIG_IR_XMP_DECODER=y
> # CONFIG_IR_IMON_DECODER is not set
> # CONFIG_IR_RCMM_DECODER is not set
> # CONFIG_RC_DEVICES is not set
> CONFIG_CEC_CORE=y
> # CONFIG_MEDIA_CEC_RC is not set
> # CONFIG_MEDIA_CEC_SUPPORT is not set
> CONFIG_MEDIA_SUPPORT=y
> CONFIG_MEDIA_SUPPORT_FILTER=y
> CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
> 
> #
> # Media device types
> #
> CONFIG_MEDIA_CAMERA_SUPPORT=y
> # CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
> CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
> # CONFIG_MEDIA_RADIO_SUPPORT is not set
> CONFIG_MEDIA_SDR_SUPPORT=y
> # CONFIG_MEDIA_PLATFORM_SUPPORT is not set
> # CONFIG_MEDIA_TEST_SUPPORT is not set
> # end of Media device types
> 
> CONFIG_VIDEO_DEV=y
> CONFIG_MEDIA_CONTROLLER=y
> CONFIG_DVB_CORE=y
> 
> #
> # Video4Linux options
> #
> CONFIG_VIDEO_V4L2=y
> CONFIG_VIDEO_V4L2_I2C=y
> CONFIG_VIDEO_V4L2_SUBDEV_API=y
> CONFIG_VIDEO_ADV_DEBUG=y
> # CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
> CONFIG_VIDEO_TUNER=y
> CONFIG_V4L2_FWNODE=y
> CONFIG_VIDEOBUF_GEN=y
> CONFIG_VIDEOBUF_VMALLOC=y
> # end of Video4Linux options
> 
> #
> # Media controller options
> #
> CONFIG_MEDIA_CONTROLLER_DVB=y
> # end of Media controller options
> 
> #
> # Digital TV options
> #
> # CONFIG_DVB_MMAP is not set
> CONFIG_DVB_NET=y
> CONFIG_DVB_MAX_ADAPTERS=16
> # CONFIG_DVB_DYNAMIC_MINORS is not set
> # CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
> CONFIG_DVB_ULE_DEBUG=y
> # end of Digital TV options
> 
> #
> # Media drivers
> #
> 
> #
> # Drivers filtered as selected at 'Filter media drivers'
> #
> CONFIG_TTPCI_EEPROM=y
> CONFIG_MEDIA_USB_SUPPORT=y
> 
> #
> # Webcam devices
> #
> CONFIG_USB_VIDEO_CLASS=y
> CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
> # CONFIG_USB_GSPCA is not set
> CONFIG_USB_PWC=y
> # CONFIG_USB_PWC_DEBUG is not set
> CONFIG_USB_PWC_INPUT_EVDEV=y
> CONFIG_VIDEO_CPIA2=y
> CONFIG_USB_ZR364XX=y
> # CONFIG_USB_STKWEBCAM is not set
> # CONFIG_USB_S2255 is not set
> 
> #
> # Analog/digital TV USB devices
> #
> CONFIG_VIDEO_AU0828=y
> CONFIG_VIDEO_AU0828_V4L2=y
> CONFIG_VIDEO_AU0828_RC=y
> CONFIG_VIDEO_CX231XX=y
> # CONFIG_VIDEO_CX231XX_RC is not set
> # CONFIG_VIDEO_CX231XX_DVB is not set
> CONFIG_VIDEO_TM6000=y
> CONFIG_VIDEO_TM6000_DVB=y
> 
> #
> # Digital TV USB devices
> #
> CONFIG_DVB_USB=y
> # CONFIG_DVB_USB_DEBUG is not set
> CONFIG_DVB_USB_DIB3000MC=y
> CONFIG_DVB_USB_A800=y
> CONFIG_DVB_USB_DIBUSB_MB=y
> CONFIG_DVB_USB_DIBUSB_MB_FAULTY=y
> CONFIG_DVB_USB_DIBUSB_MC=y
> # CONFIG_DVB_USB_DIB0700 is not set
> CONFIG_DVB_USB_UMT_010=y
> CONFIG_DVB_USB_CXUSB=y
> # CONFIG_DVB_USB_CXUSB_ANALOG is not set
> # CONFIG_DVB_USB_M920X is not set
> CONFIG_DVB_USB_DIGITV=y
> # CONFIG_DVB_USB_VP7045 is not set
> CONFIG_DVB_USB_VP702X=y
> CONFIG_DVB_USB_GP8PSK=y
> # CONFIG_DVB_USB_NOVA_T_USB2 is not set
> # CONFIG_DVB_USB_TTUSB2 is not set
> CONFIG_DVB_USB_DTT200U=y
> # CONFIG_DVB_USB_OPERA1 is not set
> CONFIG_DVB_USB_AF9005=y
> # CONFIG_DVB_USB_AF9005_REMOTE is not set
> CONFIG_DVB_USB_PCTV452E=y
> # CONFIG_DVB_USB_DW2102 is not set
> # CONFIG_DVB_USB_CINERGY_T2 is not set
> CONFIG_DVB_USB_DTV5100=y
> CONFIG_DVB_USB_AZ6027=y
> CONFIG_DVB_USB_TECHNISAT_USB2=y
> # CONFIG_DVB_USB_V2 is not set
> # CONFIG_DVB_TTUSB_BUDGET is not set
> # CONFIG_DVB_TTUSB_DEC is not set
> # CONFIG_SMS_USB_DRV is not set
> CONFIG_DVB_B2C2_FLEXCOP_USB=y
> # CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
> CONFIG_DVB_AS102=y
> 
> #
> # Webcam, TV (analog/digital) USB devices
> #
> CONFIG_VIDEO_EM28XX=y
> # CONFIG_VIDEO_EM28XX_V4L2 is not set
> CONFIG_VIDEO_EM28XX_DVB=y
> CONFIG_VIDEO_EM28XX_RC=y
> 
> #
> # Software defined radio USB devices
> #
> CONFIG_USB_AIRSPY=y
> # CONFIG_USB_HACKRF is not set
> # CONFIG_MEDIA_PCI_SUPPORT is not set
> CONFIG_VIDEO_CX2341X=y
> CONFIG_VIDEO_TVEEPROM=y
> CONFIG_CYPRESS_FIRMWARE=y
> CONFIG_VIDEOBUF2_CORE=y
> CONFIG_VIDEOBUF2_V4L2=y
> CONFIG_VIDEOBUF2_MEMOPS=y
> CONFIG_VIDEOBUF2_VMALLOC=y
> CONFIG_VIDEOBUF2_DMA_SG=y
> CONFIG_DVB_B2C2_FLEXCOP=y
> # end of Media drivers
> 
> #
> # Media ancillary drivers
> #
> CONFIG_MEDIA_ATTACH=y
> 
> #
> # IR I2C driver auto-selected by 'Autoselect ancillary drivers'
> #
> # CONFIG_VIDEO_IR_I2C is not set
> 
> #
> # Audio decoders, processors and mixers
> #
> CONFIG_VIDEO_TVAUDIO=y
> CONFIG_VIDEO_TDA7432=y
> # CONFIG_VIDEO_TDA9840 is not set
> # CONFIG_VIDEO_TEA6415C is not set
> # CONFIG_VIDEO_TEA6420 is not set
> # CONFIG_VIDEO_MSP3400 is not set
> # CONFIG_VIDEO_CS3308 is not set
> CONFIG_VIDEO_CS5345=y
> CONFIG_VIDEO_CS53L32A=y
> CONFIG_VIDEO_TLV320AIC23B=y
> CONFIG_VIDEO_UDA1342=y
> CONFIG_VIDEO_WM8775=y
> CONFIG_VIDEO_WM8739=y
> # CONFIG_VIDEO_VP27SMPX is not set
> # CONFIG_VIDEO_SONY_BTF_MPX is not set
> # end of Audio decoders, processors and mixers
> 
> #
> # RDS decoders
> #
> CONFIG_VIDEO_SAA6588=y
> # end of RDS decoders
> 
> #
> # Video decoders
> #
> CONFIG_VIDEO_ADV7180=y
> # CONFIG_VIDEO_ADV7183 is not set
> # CONFIG_VIDEO_ADV748X is not set
> # CONFIG_VIDEO_ADV7604 is not set
> # CONFIG_VIDEO_ADV7842 is not set
> CONFIG_VIDEO_BT819=y
> CONFIG_VIDEO_BT856=y
> CONFIG_VIDEO_BT866=y
> CONFIG_VIDEO_KS0127=y
> CONFIG_VIDEO_ML86V7667=y
> # CONFIG_VIDEO_SAA7110 is not set
> # CONFIG_VIDEO_SAA711X is not set
> CONFIG_VIDEO_TC358743=y
> # CONFIG_VIDEO_TC358743_CEC is not set
> CONFIG_VIDEO_TVP514X=y
> CONFIG_VIDEO_TVP5150=y
> # CONFIG_VIDEO_TVP7002 is not set
> CONFIG_VIDEO_TW2804=y
> CONFIG_VIDEO_TW9903=y
> CONFIG_VIDEO_TW9906=y
> CONFIG_VIDEO_TW9910=y
> CONFIG_VIDEO_VPX3220=y
> CONFIG_VIDEO_MAX9286=y
> 
> #
> # Video and audio decoders
> #
> # CONFIG_VIDEO_SAA717X is not set
> CONFIG_VIDEO_CX25840=y
> # end of Video decoders
> 
> #
> # Video encoders
> #
> CONFIG_VIDEO_SAA7127=y
> CONFIG_VIDEO_SAA7185=y
> CONFIG_VIDEO_ADV7170=y
> CONFIG_VIDEO_ADV7175=y
> CONFIG_VIDEO_ADV7343=y
> CONFIG_VIDEO_ADV7393=y
> CONFIG_VIDEO_ADV7511=y
> # CONFIG_VIDEO_ADV7511_CEC is not set
> CONFIG_VIDEO_AD9389B=y
> CONFIG_VIDEO_AK881X=y
> # CONFIG_VIDEO_THS8200 is not set
> # end of Video encoders
> 
> #
> # Video improvement chips
> #
> CONFIG_VIDEO_UPD64031A=y
> # CONFIG_VIDEO_UPD64083 is not set
> # end of Video improvement chips
> 
> #
> # Audio/Video compression chips
> #
> CONFIG_VIDEO_SAA6752HS=y
> # end of Audio/Video compression chips
> 
> #
> # SDR tuner chips
> #
> # CONFIG_SDR_MAX2175 is not set
> # end of SDR tuner chips
> 
> #
> # Miscellaneous helper chips
> #
> # CONFIG_VIDEO_THS7303 is not set
> CONFIG_VIDEO_M52790=y
> CONFIG_VIDEO_I2C=y
> CONFIG_VIDEO_ST_MIPID02=y
> # end of Miscellaneous helper chips
> 
> #
> # Camera sensor devices
> #
> CONFIG_VIDEO_APTINA_PLL=y
> CONFIG_VIDEO_SMIAPP_PLL=y
> CONFIG_VIDEO_HI556=y
> CONFIG_VIDEO_IMX214=y
> CONFIG_VIDEO_IMX219=y
> CONFIG_VIDEO_IMX258=y
> CONFIG_VIDEO_IMX274=y
> CONFIG_VIDEO_IMX290=y
> # CONFIG_VIDEO_IMX319 is not set
> CONFIG_VIDEO_IMX355=y
> CONFIG_VIDEO_OV2640=y
> # CONFIG_VIDEO_OV2659 is not set
> CONFIG_VIDEO_OV2680=y
> # CONFIG_VIDEO_OV2685 is not set
> # CONFIG_VIDEO_OV2740 is not set
> CONFIG_VIDEO_OV5640=y
> # CONFIG_VIDEO_OV5645 is not set
> # CONFIG_VIDEO_OV5647 is not set
> CONFIG_VIDEO_OV6650=y
> CONFIG_VIDEO_OV5670=y
> CONFIG_VIDEO_OV5675=y
> CONFIG_VIDEO_OV5695=y
> CONFIG_VIDEO_OV7251=y
> CONFIG_VIDEO_OV772X=y
> CONFIG_VIDEO_OV7640=y
> CONFIG_VIDEO_OV7670=y
> # CONFIG_VIDEO_OV7740 is not set
> # CONFIG_VIDEO_OV8856 is not set
> CONFIG_VIDEO_OV9640=y
> # CONFIG_VIDEO_OV9650 is not set
> CONFIG_VIDEO_OV13858=y
> CONFIG_VIDEO_VS6624=y
> # CONFIG_VIDEO_MT9M001 is not set
> CONFIG_VIDEO_MT9M032=y
> # CONFIG_VIDEO_MT9M111 is not set
> CONFIG_VIDEO_MT9P031=y
> CONFIG_VIDEO_MT9T001=y
> CONFIG_VIDEO_MT9T112=y
> CONFIG_VIDEO_MT9V011=y
> # CONFIG_VIDEO_MT9V032 is not set
> CONFIG_VIDEO_MT9V111=y
> CONFIG_VIDEO_SR030PC30=y
> # CONFIG_VIDEO_NOON010PC30 is not set
> CONFIG_VIDEO_M5MOLS=y
> CONFIG_VIDEO_RDACM20=y
> CONFIG_VIDEO_RJ54N1=y
> # CONFIG_VIDEO_S5K6AA is not set
> CONFIG_VIDEO_S5K6A3=y
> CONFIG_VIDEO_S5K4ECGX=y
> CONFIG_VIDEO_S5K5BAF=y
> CONFIG_VIDEO_SMIAPP=y
> # CONFIG_VIDEO_ET8EK8 is not set
> # end of Camera sensor devices
> 
> #
> # Lens drivers
> #
> CONFIG_VIDEO_AD5820=y
> # CONFIG_VIDEO_AK7375 is not set
> CONFIG_VIDEO_DW9714=y
> # CONFIG_VIDEO_DW9768 is not set
> CONFIG_VIDEO_DW9807_VCM=y
> # end of Lens drivers
> 
> #
> # Flash devices
> #
> CONFIG_VIDEO_ADP1653=y
> CONFIG_VIDEO_LM3560=y
> CONFIG_VIDEO_LM3646=y
> # end of Flash devices
> 
> #
> # SPI helper chips
> #
> # end of SPI helper chips
> 
> CONFIG_MEDIA_TUNER=y
> 
> #
> # Customize TV tuners
> #
> CONFIG_MEDIA_TUNER_SIMPLE=y
> CONFIG_MEDIA_TUNER_TDA18250=y
> CONFIG_MEDIA_TUNER_TDA8290=y
> CONFIG_MEDIA_TUNER_TDA827X=y
> CONFIG_MEDIA_TUNER_TDA18271=y
> CONFIG_MEDIA_TUNER_TDA9887=y
> CONFIG_MEDIA_TUNER_TEA5761=y
> # CONFIG_MEDIA_TUNER_TEA5767 is not set
> CONFIG_MEDIA_TUNER_MT20XX=y
> CONFIG_MEDIA_TUNER_MT2060=y
> CONFIG_MEDIA_TUNER_MT2063=y
> # CONFIG_MEDIA_TUNER_MT2266 is not set
> CONFIG_MEDIA_TUNER_MT2131=y
> CONFIG_MEDIA_TUNER_QT1010=y
> CONFIG_MEDIA_TUNER_XC2028=y
> CONFIG_MEDIA_TUNER_XC5000=y
> CONFIG_MEDIA_TUNER_XC4000=y
> CONFIG_MEDIA_TUNER_MXL5005S=y
> CONFIG_MEDIA_TUNER_MXL5007T=y
> CONFIG_MEDIA_TUNER_MC44S803=y
> CONFIG_MEDIA_TUNER_MAX2165=y
> # CONFIG_MEDIA_TUNER_TDA18218 is not set
> CONFIG_MEDIA_TUNER_FC0011=y
> CONFIG_MEDIA_TUNER_FC0012=y
> CONFIG_MEDIA_TUNER_FC0013=y
> CONFIG_MEDIA_TUNER_TDA18212=y
> CONFIG_MEDIA_TUNER_E4000=y
> CONFIG_MEDIA_TUNER_FC2580=y
> CONFIG_MEDIA_TUNER_M88RS6000T=y
> CONFIG_MEDIA_TUNER_TUA9001=y
> CONFIG_MEDIA_TUNER_SI2157=y
> # CONFIG_MEDIA_TUNER_IT913X is not set
> CONFIG_MEDIA_TUNER_R820T=y
> CONFIG_MEDIA_TUNER_MXL301RF=y
> CONFIG_MEDIA_TUNER_QM1D1C0042=y
> CONFIG_MEDIA_TUNER_QM1D1B0004=y
> # end of Customize TV tuners
> 
> #
> # Customise DVB Frontends
> #
> 
> #
> # Multistandard (satellite) frontends
> #
> CONFIG_DVB_STB0899=y
> CONFIG_DVB_STB6100=y
> CONFIG_DVB_STV090x=y
> CONFIG_DVB_STV0910=y
> CONFIG_DVB_STV6110x=y
> # CONFIG_DVB_STV6111 is not set
> CONFIG_DVB_MXL5XX=y
> CONFIG_DVB_M88DS3103=y
> 
> #
> # Multistandard (cable + terrestrial) frontends
> #
> CONFIG_DVB_DRXK=y
> CONFIG_DVB_TDA18271C2DD=y
> # CONFIG_DVB_SI2165 is not set
> # CONFIG_DVB_MN88472 is not set
> CONFIG_DVB_MN88473=y
> 
> #
> # DVB-S (satellite) frontends
> #
> CONFIG_DVB_CX24110=y
> CONFIG_DVB_CX24123=y
> CONFIG_DVB_MT312=y
> # CONFIG_DVB_ZL10036 is not set
> CONFIG_DVB_ZL10039=y
> CONFIG_DVB_S5H1420=y
> CONFIG_DVB_STV0288=y
> # CONFIG_DVB_STB6000 is not set
> CONFIG_DVB_STV0299=y
> # CONFIG_DVB_STV6110 is not set
> CONFIG_DVB_STV0900=y
> CONFIG_DVB_TDA8083=y
> CONFIG_DVB_TDA10086=y
> CONFIG_DVB_TDA8261=y
> CONFIG_DVB_VES1X93=y
> CONFIG_DVB_TUNER_ITD1000=y
> CONFIG_DVB_TUNER_CX24113=y
> CONFIG_DVB_TDA826X=y
> CONFIG_DVB_TUA6100=y
> CONFIG_DVB_CX24116=y
> # CONFIG_DVB_CX24117 is not set
> CONFIG_DVB_CX24120=y
> CONFIG_DVB_SI21XX=y
> CONFIG_DVB_TS2020=y
> CONFIG_DVB_DS3000=y
> # CONFIG_DVB_MB86A16 is not set
> CONFIG_DVB_TDA10071=y
> 
> #
> # DVB-T (terrestrial) frontends
> #
> # CONFIG_DVB_SP8870 is not set
> # CONFIG_DVB_SP887X is not set
> # CONFIG_DVB_CX22700 is not set
> CONFIG_DVB_CX22702=y
> # CONFIG_DVB_S5H1432 is not set
> CONFIG_DVB_DRXD=y
> CONFIG_DVB_L64781=y
> # CONFIG_DVB_TDA1004X is not set
> CONFIG_DVB_NXT6000=y
> CONFIG_DVB_MT352=y
> CONFIG_DVB_ZL10353=y
> CONFIG_DVB_DIB3000MB=y
> CONFIG_DVB_DIB3000MC=y
> # CONFIG_DVB_DIB7000M is not set
> CONFIG_DVB_DIB7000P=y
> CONFIG_DVB_DIB9000=y
> CONFIG_DVB_TDA10048=y
> CONFIG_DVB_AF9013=y
> CONFIG_DVB_EC100=y
> CONFIG_DVB_STV0367=y
> CONFIG_DVB_CXD2820R=y
> CONFIG_DVB_CXD2841ER=y
> CONFIG_DVB_RTL2830=y
> CONFIG_DVB_RTL2832=y
> CONFIG_DVB_RTL2832_SDR=y
> CONFIG_DVB_SI2168=y
> CONFIG_DVB_AS102_FE=y
> CONFIG_DVB_ZD1301_DEMOD=y
> CONFIG_DVB_GP8PSK_FE=y
> 
> #
> # DVB-C (cable) frontends
> #
> CONFIG_DVB_VES1820=y
> CONFIG_DVB_TDA10021=y
> CONFIG_DVB_TDA10023=y
> CONFIG_DVB_STV0297=y
> 
> #
> # ATSC (North American/Korean Terrestrial/Cable DTV) frontends
> #
> CONFIG_DVB_NXT200X=y
> CONFIG_DVB_OR51211=y
> # CONFIG_DVB_OR51132 is not set
> CONFIG_DVB_BCM3510=y
> CONFIG_DVB_LGDT330X=y
> CONFIG_DVB_LGDT3305=y
> CONFIG_DVB_LGDT3306A=y
> # CONFIG_DVB_LG2160 is not set
> CONFIG_DVB_S5H1409=y
> CONFIG_DVB_AU8522=y
> CONFIG_DVB_AU8522_DTV=y
> CONFIG_DVB_AU8522_V4L=y
> CONFIG_DVB_S5H1411=y
> 
> #
> # ISDB-T (terrestrial) frontends
> #
> CONFIG_DVB_S921=y
> CONFIG_DVB_DIB8000=y
> CONFIG_DVB_MB86A20S=y
> 
> #
> # ISDB-S (satellite) & ISDB-T (terrestrial) frontends
> #
> CONFIG_DVB_TC90522=y
> CONFIG_DVB_MN88443X=y
> 
> #
> # Digital terrestrial only tuners/PLL
> #
> CONFIG_DVB_PLL=y
> CONFIG_DVB_TUNER_DIB0070=y
> # CONFIG_DVB_TUNER_DIB0090 is not set
> 
> #
> # SEC control devices for DVB-S
> #
> CONFIG_DVB_DRX39XYJ=y
> # CONFIG_DVB_LNBH25 is not set
> CONFIG_DVB_LNBH29=y
> CONFIG_DVB_LNBP21=y
> CONFIG_DVB_LNBP22=y
> # CONFIG_DVB_ISL6405 is not set
> CONFIG_DVB_ISL6421=y
> CONFIG_DVB_ISL6423=y
> CONFIG_DVB_A8293=y
> # CONFIG_DVB_LGS8GL5 is not set
> CONFIG_DVB_LGS8GXX=y
> CONFIG_DVB_ATBM8830=y
> CONFIG_DVB_TDA665x=y
> # CONFIG_DVB_IX2505V is not set
> CONFIG_DVB_M88RS2000=y
> CONFIG_DVB_AF9033=y
> # CONFIG_DVB_HORUS3A is not set
> CONFIG_DVB_ASCOT2E=y
> CONFIG_DVB_HELENE=y
> 
> #
> # Common Interface (EN50221) controller drivers
> #
> CONFIG_DVB_CXD2099=y
> CONFIG_DVB_SP2=y
> # end of Customise DVB Frontends
> # end of Media ancillary drivers
> 
> #
> # Graphics support
> #
> # CONFIG_AGP is not set
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=16
> # CONFIG_VGA_SWITCHEROO is not set
> CONFIG_DRM=y
> CONFIG_DRM_MIPI_DSI=y
> CONFIG_DRM_DP_AUX_CHARDEV=y
> CONFIG_DRM_DEBUG_MM=y
> CONFIG_DRM_DEBUG_SELFTEST=y
> CONFIG_DRM_KMS_HELPER=y
> CONFIG_DRM_KMS_FB_HELPER=y
> # CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
> # CONFIG_DRM_FBDEV_EMULATION is not set
> # CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
> CONFIG_DRM_DP_CEC=y
> CONFIG_DRM_GEM_CMA_HELPER=y
> CONFIG_DRM_KMS_CMA_HELPER=y
> CONFIG_DRM_GEM_SHMEM_HELPER=y
> 
> #
> # I2C encoder or helper chips
> #
> CONFIG_DRM_I2C_CH7006=y
> CONFIG_DRM_I2C_SIL164=y
> CONFIG_DRM_I2C_NXP_TDA998X=y
> # CONFIG_DRM_I2C_NXP_TDA9950 is not set
> # end of I2C encoder or helper chips
> 
> #
> # ARM devices
> #
> CONFIG_DRM_KOMEDA=y
> # end of ARM devices
> 
> # CONFIG_DRM_RADEON is not set
> # CONFIG_DRM_AMDGPU is not set
> # CONFIG_DRM_NOUVEAU is not set
> # CONFIG_DRM_I915 is not set
> CONFIG_DRM_VGEM=y
> CONFIG_DRM_VKMS=y
> # CONFIG_DRM_VMWGFX is not set
> # CONFIG_DRM_GMA500 is not set
> CONFIG_DRM_UDL=y
> # CONFIG_DRM_AST is not set
> # CONFIG_DRM_MGAG200 is not set
> # CONFIG_DRM_RCAR_DW_HDMI is not set
> CONFIG_DRM_RCAR_LVDS=y
> # CONFIG_DRM_QXL is not set
> # CONFIG_DRM_BOCHS is not set
> CONFIG_DRM_VIRTIO_GPU=y
> CONFIG_DRM_PANEL=y
> 
> #
> # Display Panels
> #
> CONFIG_DRM_PANEL_ARM_VERSATILE=y
> CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596=y
> # CONFIG_DRM_PANEL_BOE_HIMAX8279D is not set
> CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=y
> CONFIG_DRM_PANEL_LVDS=y
> # CONFIG_DRM_PANEL_SIMPLE is not set
> # CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
> # CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
> CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=y
> # CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
> # CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
> CONFIG_DRM_PANEL_JDI_LT070ME05000=y
> # CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
> CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W=y
> CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=y
> CONFIG_DRM_PANEL_NOVATEK_NT35510=y
> CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=y
> CONFIG_DRM_PANEL_ORISETECH_OTM8009A=y
> # CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set
> # CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
> CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
> CONFIG_DRM_PANEL_RAYDIUM_RM67191=y
> CONFIG_DRM_PANEL_RAYDIUM_RM68200=y
> # CONFIG_DRM_PANEL_RONBO_RB070D30 is not set
> CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=y
> # CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
> CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
> CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01=y
> CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
> CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
> CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
> CONFIG_DRM_PANEL_SHARP_LS037V7DW01=y
> CONFIG_DRM_PANEL_SHARP_LS043T1LE01=y
> CONFIG_DRM_PANEL_SITRONIX_ST7701=y
> # CONFIG_DRM_PANEL_SITRONIX_ST7703 is not set
> CONFIG_DRM_PANEL_SONY_ACX424AKP=y
> # CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
> CONFIG_DRM_PANEL_VISIONOX_RM69299=y
> CONFIG_DRM_PANEL_XINPENG_XPP055C272=y
> # end of Display Panels
> 
> CONFIG_DRM_BRIDGE=y
> CONFIG_DRM_PANEL_BRIDGE=y
> 
> #
> # Display Interface Bridges
> #
> CONFIG_DRM_CDNS_DSI=y
> CONFIG_DRM_CHRONTEL_CH7033=y
> CONFIG_DRM_DISPLAY_CONNECTOR=y
> # CONFIG_DRM_LVDS_CODEC is not set
> CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
> CONFIG_DRM_NWL_MIPI_DSI=y
> CONFIG_DRM_NXP_PTN3460=y
> CONFIG_DRM_PARADE_PS8622=y
> CONFIG_DRM_PARADE_PS8640=y
> CONFIG_DRM_SIL_SII8620=y
> # CONFIG_DRM_SII902X is not set
> CONFIG_DRM_SII9234=y
> CONFIG_DRM_SIMPLE_BRIDGE=y
> # CONFIG_DRM_THINE_THC63LVD1024 is not set
> # CONFIG_DRM_TOSHIBA_TC358764 is not set
> # CONFIG_DRM_TOSHIBA_TC358767 is not set
> CONFIG_DRM_TOSHIBA_TC358768=y
> CONFIG_DRM_TI_TFP410=y
> # CONFIG_DRM_TI_SN65DSI86 is not set
> CONFIG_DRM_TI_TPD12S015=y
> CONFIG_DRM_ANALOGIX_ANX6345=y
> CONFIG_DRM_ANALOGIX_ANX78XX=y
> CONFIG_DRM_ANALOGIX_DP=y
> # CONFIG_DRM_I2C_ADV7511 is not set
> # end of Display Interface Bridges
> 
> # CONFIG_DRM_ETNAVIV is not set
> CONFIG_DRM_ARCPGU=y
> CONFIG_DRM_MXS=y
> CONFIG_DRM_MXSFB=y
> # CONFIG_DRM_CIRRUS_QEMU is not set
> CONFIG_DRM_GM12U320=y
> # CONFIG_DRM_VBOXVIDEO is not set
> # CONFIG_DRM_LEGACY is not set
> CONFIG_DRM_EXPORT_FOR_TESTS=y
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
> CONFIG_DRM_LIB_RANDOM=y
> 
> #
> # Frame buffer Devices
> #
> CONFIG_FB_CMDLINE=y
> CONFIG_FB_NOTIFY=y
> CONFIG_FB=y
> CONFIG_FIRMWARE_EDID=y
> CONFIG_FB_BOOT_VESA_SUPPORT=y
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> CONFIG_FB_SYS_FILLRECT=y
> CONFIG_FB_SYS_COPYAREA=y
> CONFIG_FB_SYS_IMAGEBLIT=y
> CONFIG_FB_FOREIGN_ENDIAN=y
> # CONFIG_FB_BOTH_ENDIAN is not set
> # CONFIG_FB_BIG_ENDIAN is not set
> CONFIG_FB_LITTLE_ENDIAN=y
> CONFIG_FB_SYS_FOPS=y
> CONFIG_FB_DEFERRED_IO=y
> CONFIG_FB_BACKLIGHT=y
> CONFIG_FB_MODE_HELPERS=y
> CONFIG_FB_TILEBLITTING=y
> 
> #
> # Frame buffer hardware drivers
> #
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> CONFIG_FB_ARC=y
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> CONFIG_FB_VESA=y
> # CONFIG_FB_N411 is not set
> # CONFIG_FB_HGA is not set
> CONFIG_FB_OPENCORES=y
> CONFIG_FB_S1D13XXX=y
> # CONFIG_FB_NVIDIA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_I740 is not set
> # CONFIG_FB_LE80578 is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_S3 is not set
> # CONFIG_FB_SAVAGE is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_VIA is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_VT8623 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_ARK is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_CARMINE is not set
> # CONFIG_FB_GEODE is not set
> CONFIG_FB_SM501=y
> CONFIG_FB_SMSCUFX=y
> CONFIG_FB_UDL=y
> CONFIG_FB_IBM_GXT4500=y
> # CONFIG_FB_VIRTUAL is not set
> CONFIG_FB_METRONOME=y
> # CONFIG_FB_MB862XX is not set
> # CONFIG_FB_SIMPLE is not set
> # CONFIG_FB_SSD1307 is not set
> # CONFIG_FB_SM712 is not set
> # end of Frame buffer Devices
> 
> #
> # Backlight & LCD device support
> #
> # CONFIG_LCD_CLASS_DEVICE is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> # CONFIG_BACKLIGHT_LM3533 is not set
> CONFIG_BACKLIGHT_PWM=y
> CONFIG_BACKLIGHT_DA903X=y
> # CONFIG_BACKLIGHT_DA9052 is not set
> # CONFIG_BACKLIGHT_APPLE is not set
> CONFIG_BACKLIGHT_QCOM_WLED=y
> # CONFIG_BACKLIGHT_SAHARA is not set
> CONFIG_BACKLIGHT_ADP8860=y
> # CONFIG_BACKLIGHT_ADP8870 is not set
> # CONFIG_BACKLIGHT_88PM860X is not set
> CONFIG_BACKLIGHT_LM3630A=y
> CONFIG_BACKLIGHT_LM3639=y
> CONFIG_BACKLIGHT_LP855X=y
> CONFIG_BACKLIGHT_PANDORA=y
> CONFIG_BACKLIGHT_SKY81452=y
> CONFIG_BACKLIGHT_TPS65217=y
> # CONFIG_BACKLIGHT_AS3711 is not set
> CONFIG_BACKLIGHT_GPIO=y
> CONFIG_BACKLIGHT_LV5207LP=y
> CONFIG_BACKLIGHT_BD6107=y
> CONFIG_BACKLIGHT_ARCXCNN=y
> # CONFIG_BACKLIGHT_RAVE_SP is not set
> CONFIG_BACKLIGHT_LED=y
> # end of Backlight & LCD device support
> 
> CONFIG_VIDEOMODE_HELPERS=y
> CONFIG_HDMI=y
> # CONFIG_LOGO is not set
> # end of Graphics support
> 
> # CONFIG_SOUND is not set
> 
> #
> # HID support
> #
> CONFIG_HID=y
> # CONFIG_HID_BATTERY_STRENGTH is not set
> CONFIG_HIDRAW=y
> # CONFIG_UHID is not set
> # CONFIG_HID_GENERIC is not set
> 
> #
> # Special HID drivers
> #
> CONFIG_HID_A4TECH=y
> CONFIG_HID_ACRUX=y
> CONFIG_HID_ACRUX_FF=y
> CONFIG_HID_APPLE=y
> # CONFIG_HID_AUREAL is not set
> # CONFIG_HID_BELKIN is not set
> CONFIG_HID_CHERRY=y
> CONFIG_HID_CHICONY=y
> # CONFIG_HID_CORSAIR is not set
> # CONFIG_HID_COUGAR is not set
> CONFIG_HID_MACALLY=y
> CONFIG_HID_CMEDIA=y
> # CONFIG_HID_CYPRESS is not set
> # CONFIG_HID_DRAGONRISE is not set
> CONFIG_HID_EMS_FF=y
> CONFIG_HID_ELECOM=y
> CONFIG_HID_EZKEY=y
> CONFIG_HID_GEMBIRD=y
> # CONFIG_HID_GFRM is not set
> CONFIG_HID_GLORIOUS=y
> # CONFIG_HID_KEYTOUCH is not set
> CONFIG_HID_KYE=y
> CONFIG_HID_WALTOP=y
> # CONFIG_HID_VIEWSONIC is not set
> # CONFIG_HID_GYRATION is not set
> # CONFIG_HID_ICADE is not set
> CONFIG_HID_ITE=y
> # CONFIG_HID_JABRA is not set
> CONFIG_HID_TWINHAN=y
> CONFIG_HID_KENSINGTON=y
> # CONFIG_HID_LCPOWER is not set
> CONFIG_HID_LED=y
> CONFIG_HID_LENOVO=y
> CONFIG_HID_LOGITECH=y
> # CONFIG_HID_LOGITECH_HIDPP is not set
> # CONFIG_LOGITECH_FF is not set
> # CONFIG_LOGIRUMBLEPAD2_FF is not set
> # CONFIG_LOGIG940_FF is not set
> # CONFIG_LOGIWHEELS_FF is not set
> # CONFIG_HID_MAGICMOUSE is not set
> # CONFIG_HID_MALTRON is not set
> CONFIG_HID_MAYFLASH=y
> CONFIG_HID_REDRAGON=y
> CONFIG_HID_MICROSOFT=y
> CONFIG_HID_MONTEREY=y
> CONFIG_HID_MULTITOUCH=y
> # CONFIG_HID_NTI is not set
> CONFIG_HID_ORTEK=y
> CONFIG_HID_PANTHERLORD=y
> CONFIG_PANTHERLORD_FF=y
> # CONFIG_HID_PETALYNX is not set
> # CONFIG_HID_PICOLCD is not set
> CONFIG_HID_PLANTRONICS=y
> # CONFIG_HID_PRIMAX is not set
> CONFIG_HID_SAITEK=y
> # CONFIG_HID_SAMSUNG is not set
> # CONFIG_HID_SPEEDLINK is not set
> CONFIG_HID_STEAM=y
> # CONFIG_HID_STEELSERIES is not set
> CONFIG_HID_SUNPLUS=y
> CONFIG_HID_RMI=y
> CONFIG_HID_GREENASIA=y
> # CONFIG_GREENASIA_FF is not set
> CONFIG_HID_SMARTJOYPLUS=y
> CONFIG_SMARTJOYPLUS_FF=y
> CONFIG_HID_TIVO=y
> # CONFIG_HID_TOPSEED is not set
> # CONFIG_HID_THINGM is not set
> CONFIG_HID_THRUSTMASTER=y
> # CONFIG_THRUSTMASTER_FF is not set
> CONFIG_HID_UDRAW_PS3=y
> CONFIG_HID_WIIMOTE=y
> # CONFIG_HID_XINMO is not set
> # CONFIG_HID_ZEROPLUS is not set
> CONFIG_HID_ZYDACRON=y
> CONFIG_HID_SENSOR_HUB=y
> CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
> CONFIG_HID_ALPS=y
> # end of Special HID drivers
> 
> #
> # USB HID support
> #
> # CONFIG_USB_HID is not set
> # CONFIG_HID_PID is not set
> 
> #
> # USB HID Boot Protocol drivers
> #
> # CONFIG_USB_KBD is not set
> # CONFIG_USB_MOUSE is not set
> # end of USB HID Boot Protocol drivers
> # end of USB HID support
> 
> #
> # I2C HID support
> #
> CONFIG_I2C_HID=y
> # end of I2C HID support
> # end of HID support
> 
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_COMMON=y
> CONFIG_USB_ULPI_BUS=y
> CONFIG_USB_CONN_GPIO=y
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB=y
> CONFIG_USB_PCI=y
> # CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
> 
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEFAULT_PERSIST=y
> CONFIG_USB_DYNAMIC_MINORS=y
> # CONFIG_USB_OTG is not set
> # CONFIG_USB_OTG_PRODUCTLIST is not set
> # CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
> CONFIG_USB_AUTOSUSPEND_DELAY=2
> # CONFIG_USB_MON is not set
> 
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_C67X00_HCD=y
> CONFIG_USB_XHCI_HCD=y
> CONFIG_USB_XHCI_DBGCAP=y
> CONFIG_USB_XHCI_PCI=y
> CONFIG_USB_XHCI_PCI_RENESAS=y
> CONFIG_USB_XHCI_PLATFORM=y
> # CONFIG_USB_EHCI_HCD is not set
> CONFIG_USB_OXU210HP_HCD=y
> # CONFIG_USB_ISP116X_HCD is not set
> CONFIG_USB_FOTG210_HCD=y
> CONFIG_USB_OHCI_HCD=y
> CONFIG_USB_OHCI_HCD_PCI=y
> CONFIG_USB_OHCI_HCD_SSB=y
> CONFIG_USB_OHCI_HCD_PLATFORM=y
> # CONFIG_USB_UHCI_HCD is not set
> CONFIG_USB_U132_HCD=y
> # CONFIG_USB_SL811_HCD is not set
> CONFIG_USB_R8A66597_HCD=y
> CONFIG_USB_HCD_SSB=y
> # CONFIG_USB_HCD_TEST_MODE is not set
> 
> #
> # USB Device Class drivers
> #
> # CONFIG_USB_ACM is not set
> # CONFIG_USB_PRINTER is not set
> CONFIG_USB_WDM=y
> # CONFIG_USB_TMC is not set
> 
> #
> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> #
> 
> #
> # also be needed; see USB_STORAGE Help for more info
> #
> # CONFIG_USB_STORAGE is not set
> 
> #
> # USB Imaging devices
> #
> CONFIG_USB_MDC800=y
> CONFIG_USB_MICROTEK=y
> # CONFIG_USBIP_CORE is not set
> CONFIG_USB_CDNS3=y
> CONFIG_USB_CDNS3_GADGET=y
> CONFIG_USB_CDNS3_HOST=y
> CONFIG_USB_CDNS3_PCI_WRAP=y
> # CONFIG_USB_MUSB_HDRC is not set
> CONFIG_USB_DWC3=y
> # CONFIG_USB_DWC3_ULPI is not set
> # CONFIG_USB_DWC3_HOST is not set
> CONFIG_USB_DWC3_GADGET=y
> # CONFIG_USB_DWC3_DUAL_ROLE is not set
> 
> #
> # Platform Glue Driver Support
> #
> CONFIG_USB_DWC3_PCI=y
> CONFIG_USB_DWC3_HAPS=y
> # CONFIG_USB_DWC3_OF_SIMPLE is not set
> CONFIG_USB_DWC2=y
> CONFIG_USB_DWC2_HOST=y
> 
> #
> # Gadget/Dual-role mode requires USB Gadget support to be enabled
> #
> # CONFIG_USB_DWC2_PERIPHERAL is not set
> # CONFIG_USB_DWC2_DUAL_ROLE is not set
> # CONFIG_USB_DWC2_PCI is not set
> CONFIG_USB_DWC2_DEBUG=y
> # CONFIG_USB_DWC2_VERBOSE is not set
> CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
> CONFIG_USB_DWC2_DEBUG_PERIODIC=y
> CONFIG_USB_CHIPIDEA=y
> CONFIG_USB_CHIPIDEA_UDC=y
> # CONFIG_USB_CHIPIDEA_MSM is not set
> CONFIG_USB_CHIPIDEA_IMX=y
> # CONFIG_USB_CHIPIDEA_GENERIC is not set
> CONFIG_USB_CHIPIDEA_TEGRA=y
> # CONFIG_USB_ISP1760 is not set
> 
> #
> # USB port drivers
> #
> CONFIG_USB_SERIAL=y
> # CONFIG_USB_SERIAL_CONSOLE is not set
> # CONFIG_USB_SERIAL_GENERIC is not set
> # CONFIG_USB_SERIAL_SIMPLE is not set
> # CONFIG_USB_SERIAL_AIRCABLE is not set
> CONFIG_USB_SERIAL_ARK3116=y
> CONFIG_USB_SERIAL_BELKIN=y
> CONFIG_USB_SERIAL_CH341=y
> CONFIG_USB_SERIAL_WHITEHEAT=y
> # CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
> CONFIG_USB_SERIAL_CP210X=y
> CONFIG_USB_SERIAL_CYPRESS_M8=y
> # CONFIG_USB_SERIAL_EMPEG is not set
> # CONFIG_USB_SERIAL_FTDI_SIO is not set
> CONFIG_USB_SERIAL_VISOR=y
> CONFIG_USB_SERIAL_IPAQ=y
> CONFIG_USB_SERIAL_IR=y
> CONFIG_USB_SERIAL_EDGEPORT=y
> CONFIG_USB_SERIAL_EDGEPORT_TI=y
> CONFIG_USB_SERIAL_F81232=y
> CONFIG_USB_SERIAL_F8153X=y
> # CONFIG_USB_SERIAL_GARMIN is not set
> # CONFIG_USB_SERIAL_IPW is not set
> CONFIG_USB_SERIAL_IUU=y
> # CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
> CONFIG_USB_SERIAL_KEYSPAN=y
> CONFIG_USB_SERIAL_KLSI=y
> # CONFIG_USB_SERIAL_KOBIL_SCT is not set
> CONFIG_USB_SERIAL_MCT_U232=y
> CONFIG_USB_SERIAL_METRO=y
> CONFIG_USB_SERIAL_MOS7720=y
> CONFIG_USB_SERIAL_MOS7840=y
> CONFIG_USB_SERIAL_MXUPORT=y
> CONFIG_USB_SERIAL_NAVMAN=y
> # CONFIG_USB_SERIAL_PL2303 is not set
> # CONFIG_USB_SERIAL_OTI6858 is not set
> CONFIG_USB_SERIAL_QCAUX=y
> # CONFIG_USB_SERIAL_QUALCOMM is not set
> CONFIG_USB_SERIAL_SPCP8X5=y
> CONFIG_USB_SERIAL_SAFE=y
> CONFIG_USB_SERIAL_SAFE_PADDED=y
> CONFIG_USB_SERIAL_SIERRAWIRELESS=y
> CONFIG_USB_SERIAL_SYMBOL=y
> # CONFIG_USB_SERIAL_TI is not set
> CONFIG_USB_SERIAL_CYBERJACK=y
> # CONFIG_USB_SERIAL_XIRCOM is not set
> # CONFIG_USB_SERIAL_OPTION is not set
> CONFIG_USB_SERIAL_OMNINET=y
> # CONFIG_USB_SERIAL_OPTICON is not set
> CONFIG_USB_SERIAL_XSENS_MT=y
> CONFIG_USB_SERIAL_WISHBONE=y
> CONFIG_USB_SERIAL_SSU100=y
> CONFIG_USB_SERIAL_QT2=y
> # CONFIG_USB_SERIAL_UPD78F0730 is not set
> # CONFIG_USB_SERIAL_DEBUG is not set
> 
> #
> # USB Miscellaneous drivers
> #
> CONFIG_USB_EMI62=y
> CONFIG_USB_EMI26=y
> # CONFIG_USB_ADUTUX is not set
> CONFIG_USB_SEVSEG=y
> # CONFIG_USB_LEGOTOWER is not set
> CONFIG_USB_LCD=y
> CONFIG_USB_CYPRESS_CY7C63=y
> # CONFIG_USB_CYTHERM is not set
> # CONFIG_USB_IDMOUSE is not set
> CONFIG_USB_FTDI_ELAN=y
> # CONFIG_USB_APPLEDISPLAY is not set
> CONFIG_APPLE_MFI_FASTCHARGE=y
> CONFIG_USB_LD=y
> CONFIG_USB_TRANCEVIBRATOR=y
> CONFIG_USB_IOWARRIOR=y
> CONFIG_USB_TEST=y
> # CONFIG_USB_EHSET_TEST_FIXTURE is not set
> CONFIG_USB_ISIGHTFW=y
> # CONFIG_USB_YUREX is not set
> CONFIG_USB_EZUSB_FX2=y
> CONFIG_USB_HUB_USB251XB=y
> CONFIG_USB_HSIC_USB3503=y
> CONFIG_USB_HSIC_USB4604=y
> # CONFIG_USB_LINK_LAYER_TEST is not set
> 
> #
> # USB Physical Layer drivers
> #
> CONFIG_USB_PHY=y
> # CONFIG_NOP_USB_XCEIV is not set
> CONFIG_USB_GPIO_VBUS=y
> CONFIG_TAHVO_USB=y
> # CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
> CONFIG_USB_ISP1301=y
> # end of USB Physical Layer drivers
> 
> CONFIG_USB_GADGET=y
> CONFIG_USB_GADGET_DEBUG=y
> # CONFIG_USB_GADGET_VERBOSE is not set
> # CONFIG_USB_GADGET_DEBUG_FILES is not set
> CONFIG_USB_GADGET_DEBUG_FS=y
> CONFIG_USB_GADGET_VBUS_DRAW=2
> CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
> # CONFIG_U_SERIAL_CONSOLE is not set
> 
> #
> # USB Peripheral Controller
> #
> # CONFIG_USB_FOTG210_UDC is not set
> # CONFIG_USB_GR_UDC is not set
> CONFIG_USB_R8A66597=y
> CONFIG_USB_PXA27X=y
> # CONFIG_USB_MV_UDC is not set
> # CONFIG_USB_MV_U3D is not set
> # CONFIG_USB_SNP_UDC_PLAT is not set
> CONFIG_USB_M66592=y
> CONFIG_USB_BDC_UDC=y
> 
> #
> # Platform Support
> #
> CONFIG_USB_BDC_PCI=y
> # CONFIG_USB_AMD5536UDC is not set
> CONFIG_USB_NET2272=y
> CONFIG_USB_NET2272_DMA=y
> # CONFIG_USB_NET2280 is not set
> # CONFIG_USB_GOKU is not set
> # CONFIG_USB_EG20T is not set
> CONFIG_USB_GADGET_XILINX=y
> CONFIG_USB_DUMMY_HCD=y
> # end of USB Peripheral Controller
> 
> CONFIG_USB_LIBCOMPOSITE=y
> CONFIG_USB_F_ACM=y
> CONFIG_USB_F_SS_LB=y
> CONFIG_USB_U_SERIAL=y
> CONFIG_USB_F_SERIAL=y
> CONFIG_USB_F_OBEX=y
> CONFIG_USB_F_MASS_STORAGE=y
> CONFIG_USB_F_FS=y
> CONFIG_USB_F_UVC=y
> CONFIG_USB_F_HID=y
> CONFIG_USB_F_TCM=y
> CONFIG_USB_CONFIGFS=y
> CONFIG_USB_CONFIGFS_SERIAL=y
> # CONFIG_USB_CONFIGFS_ACM is not set
> CONFIG_USB_CONFIGFS_OBEX=y
> # CONFIG_USB_CONFIGFS_NCM is not set
> # CONFIG_USB_CONFIGFS_ECM is not set
> # CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
> # CONFIG_USB_CONFIGFS_RNDIS is not set
> # CONFIG_USB_CONFIGFS_EEM is not set
> # CONFIG_USB_CONFIGFS_MASS_STORAGE is not set
> # CONFIG_USB_CONFIGFS_F_LB_SS is not set
> # CONFIG_USB_CONFIGFS_F_FS is not set
> # CONFIG_USB_CONFIGFS_F_HID is not set
> CONFIG_USB_CONFIGFS_F_UVC=y
> # CONFIG_USB_CONFIGFS_F_PRINTER is not set
> CONFIG_USB_CONFIGFS_F_TCM=y
> 
> #
> # USB Gadget precomposed configurations
> #
> CONFIG_USB_ZERO=y
> # CONFIG_USB_ETH is not set
> # CONFIG_USB_G_NCM is not set
> CONFIG_USB_GADGETFS=y
> CONFIG_USB_FUNCTIONFS=y
> # CONFIG_USB_FUNCTIONFS_ETH is not set
> # CONFIG_USB_FUNCTIONFS_RNDIS is not set
> CONFIG_USB_FUNCTIONFS_GENERIC=y
> # CONFIG_USB_MASS_STORAGE is not set
> # CONFIG_USB_GADGET_TARGET is not set
> CONFIG_USB_G_SERIAL=y
> # CONFIG_USB_G_PRINTER is not set
> # CONFIG_USB_CDC_COMPOSITE is not set
> CONFIG_USB_G_ACM_MS=y
> # CONFIG_USB_G_MULTI is not set
> CONFIG_USB_G_HID=y
> # CONFIG_USB_G_DBGP is not set
> # CONFIG_USB_G_WEBCAM is not set
> CONFIG_USB_RAW_GADGET=y
> # end of USB Gadget precomposed configurations
> 
> # CONFIG_TYPEC is not set
> CONFIG_USB_ROLE_SWITCH=y
> # CONFIG_USB_ROLES_INTEL_XHCI is not set
> # CONFIG_MMC is not set
> # CONFIG_MEMSTICK is not set
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=y
> # CONFIG_LEDS_CLASS_FLASH is not set
> CONFIG_LEDS_CLASS_MULTICOLOR=y
> CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y
> 
> #
> # LED drivers
> #
> # CONFIG_LEDS_88PM860X is not set
> # CONFIG_LEDS_AN30259A is not set
> CONFIG_LEDS_APU=y
> CONFIG_LEDS_AW2013=y
> CONFIG_LEDS_BCM6328=y
> CONFIG_LEDS_BCM6358=y
> CONFIG_LEDS_LM3530=y
> # CONFIG_LEDS_LM3532 is not set
> CONFIG_LEDS_LM3533=y
> # CONFIG_LEDS_LM3642 is not set
> CONFIG_LEDS_LM3692X=y
> CONFIG_LEDS_PCA9532=y
> CONFIG_LEDS_PCA9532_GPIO=y
> # CONFIG_LEDS_GPIO is not set
> # CONFIG_LEDS_LP3944 is not set
> CONFIG_LEDS_LP3952=y
> CONFIG_LEDS_LP55XX_COMMON=y
> # CONFIG_LEDS_LP5521 is not set
> CONFIG_LEDS_LP5523=y
> CONFIG_LEDS_LP5562=y
> CONFIG_LEDS_LP8501=y
> CONFIG_LEDS_LP8860=y
> CONFIG_LEDS_CLEVO_MAIL=y
> CONFIG_LEDS_PCA955X=y
> CONFIG_LEDS_PCA955X_GPIO=y
> # CONFIG_LEDS_PCA963X is not set
> CONFIG_LEDS_DA903X=y
> # CONFIG_LEDS_DA9052 is not set
> CONFIG_LEDS_PWM=y
> CONFIG_LEDS_REGULATOR=y
> CONFIG_LEDS_BD2802=y
> # CONFIG_LEDS_INTEL_SS4200 is not set
> CONFIG_LEDS_LT3593=y
> # CONFIG_LEDS_TCA6507 is not set
> CONFIG_LEDS_TLC591XX=y
> CONFIG_LEDS_MAX77650=y
> CONFIG_LEDS_MAX8997=y
> CONFIG_LEDS_LM355x=y
> # CONFIG_LEDS_OT200 is not set
> CONFIG_LEDS_MENF21BMC=y
> CONFIG_LEDS_IS31FL319X=y
> CONFIG_LEDS_IS31FL32XX=y
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> CONFIG_LEDS_BLINKM=y
> # CONFIG_LEDS_SYSCON is not set
> CONFIG_LEDS_MLXCPLD=y
> CONFIG_LEDS_MLXREG=y
> # CONFIG_LEDS_USER is not set
> # CONFIG_LEDS_NIC78BX is not set
> # CONFIG_LEDS_TI_LMU_COMMON is not set
> CONFIG_LEDS_TPS6105X=y
> 
> #
> # LED Triggers
> #
> # CONFIG_LEDS_TRIGGERS is not set
> # CONFIG_ACCESSIBILITY is not set
> # CONFIG_INFINIBAND is not set
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> # CONFIG_EDAC is not set
> CONFIG_RTC_LIB=y
> CONFIG_RTC_MC146818_LIB=y
> # CONFIG_RTC_CLASS is not set
> CONFIG_DMADEVICES=y
> # CONFIG_DMADEVICES_DEBUG is not set
> 
> #
> # DMA Devices
> #
> CONFIG_DMA_ENGINE=y
> CONFIG_DMA_VIRTUAL_CHANNELS=y
> CONFIG_DMA_ACPI=y
> CONFIG_DMA_OF=y
> # CONFIG_ALTERA_MSGDMA is not set
> CONFIG_DW_AXI_DMAC=y
> CONFIG_FSL_EDMA=y
> CONFIG_INTEL_IDMA64=y
> # CONFIG_PCH_DMA is not set
> # CONFIG_PLX_DMA is not set
> CONFIG_XILINX_ZYNQMP_DPDMA=y
> CONFIG_QCOM_HIDMA_MGMT=y
> CONFIG_QCOM_HIDMA=y
> CONFIG_DW_DMAC_CORE=y
> CONFIG_DW_DMAC=y
> # CONFIG_DW_DMAC_PCI is not set
> CONFIG_HSU_DMA=y
> CONFIG_SF_PDMA=y
> 
> #
> # DMA Clients
> #
> CONFIG_ASYNC_TX_DMA=y
> # CONFIG_DMATEST is not set
> 
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=y
> # CONFIG_SW_SYNC is not set
> # CONFIG_UDMABUF is not set
> CONFIG_DMABUF_MOVE_NOTIFY=y
> # CONFIG_DMABUF_SELFTESTS is not set
> CONFIG_DMABUF_HEAPS=y
> CONFIG_DMABUF_HEAPS_SYSTEM=y
> # end of DMABUF options
> 
> CONFIG_AUXDISPLAY=y
> CONFIG_HD44780=y
> CONFIG_IMG_ASCII_LCD=y
> CONFIG_HT16K33=y
> CONFIG_PANEL_CHANGE_MESSAGE=y
> CONFIG_PANEL_BOOT_MESSAGE=""
> # CONFIG_CHARLCD_BL_OFF is not set
> # CONFIG_CHARLCD_BL_ON is not set
> CONFIG_CHARLCD_BL_FLASH=y
> CONFIG_CHARLCD=y
> CONFIG_UIO=y
> # CONFIG_UIO_CIF is not set
> CONFIG_UIO_PDRV_GENIRQ=y
> # CONFIG_UIO_DMEM_GENIRQ is not set
> # CONFIG_UIO_AEC is not set
> # CONFIG_UIO_SERCOS3 is not set
> # CONFIG_UIO_PCI_GENERIC is not set
> # CONFIG_UIO_NETX is not set
> CONFIG_UIO_PRUSS=y
> # CONFIG_UIO_MF624 is not set
> # CONFIG_VIRT_DRIVERS is not set
> CONFIG_VIRTIO=y
> # CONFIG_VIRTIO_MENU is not set
> # CONFIG_VDPA is not set
> CONFIG_VHOST_IOTLB=y
> CONFIG_VHOST=y
> CONFIG_VHOST_MENU=y
> # CONFIG_VHOST_NET is not set
> CONFIG_VHOST_SCSI=y
> CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y
> 
> #
> # Microsoft Hyper-V guest support
> #
> # CONFIG_HYPERV is not set
> # end of Microsoft Hyper-V guest support
> 
> CONFIG_GREYBUS=y
> CONFIG_GREYBUS_ES2=y
> CONFIG_STAGING=y
> CONFIG_COMEDI=y
> # CONFIG_COMEDI_DEBUG is not set
> CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
> CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
> CONFIG_COMEDI_MISC_DRIVERS=y
> CONFIG_COMEDI_BOND=y
> CONFIG_COMEDI_TEST=y
> # CONFIG_COMEDI_PARPORT is not set
> CONFIG_COMEDI_SSV_DNP=y
> CONFIG_COMEDI_ISA_DRIVERS=y
> CONFIG_COMEDI_PCL711=y
> CONFIG_COMEDI_PCL724=y
> CONFIG_COMEDI_PCL726=y
> CONFIG_COMEDI_PCL730=y
> CONFIG_COMEDI_PCL812=y
> CONFIG_COMEDI_PCL816=y
> # CONFIG_COMEDI_PCL818 is not set
> CONFIG_COMEDI_PCM3724=y
> # CONFIG_COMEDI_AMPLC_DIO200_ISA is not set
> # CONFIG_COMEDI_AMPLC_PC236_ISA is not set
> CONFIG_COMEDI_AMPLC_PC263_ISA=y
> CONFIG_COMEDI_RTI800=y
> CONFIG_COMEDI_RTI802=y
> CONFIG_COMEDI_DAC02=y
> CONFIG_COMEDI_DAS16M1=y
> CONFIG_COMEDI_DAS08_ISA=y
> # CONFIG_COMEDI_DAS16 is not set
> # CONFIG_COMEDI_DAS800 is not set
> CONFIG_COMEDI_DAS1800=y
> # CONFIG_COMEDI_DAS6402 is not set
> CONFIG_COMEDI_DT2801=y
> CONFIG_COMEDI_DT2811=y
> CONFIG_COMEDI_DT2814=y
> CONFIG_COMEDI_DT2815=y
> CONFIG_COMEDI_DT2817=y
> CONFIG_COMEDI_DT282X=y
> # CONFIG_COMEDI_DMM32AT is not set
> CONFIG_COMEDI_FL512=y
> CONFIG_COMEDI_AIO_AIO12_8=y
> CONFIG_COMEDI_AIO_IIRO_16=y
> CONFIG_COMEDI_II_PCI20KC=y
> # CONFIG_COMEDI_C6XDIGIO is not set
> CONFIG_COMEDI_MPC624=y
> # CONFIG_COMEDI_ADQ12B is not set
> # CONFIG_COMEDI_NI_AT_A2150 is not set
> CONFIG_COMEDI_NI_AT_AO=y
> CONFIG_COMEDI_NI_ATMIO=y
> CONFIG_COMEDI_NI_ATMIO16D=y
> CONFIG_COMEDI_NI_LABPC_ISA=y
> # CONFIG_COMEDI_PCMAD is not set
> # CONFIG_COMEDI_PCMDA12 is not set
> CONFIG_COMEDI_PCMMIO=y
> # CONFIG_COMEDI_PCMUIO is not set
> CONFIG_COMEDI_MULTIQ3=y
> CONFIG_COMEDI_S526=y
> # CONFIG_COMEDI_PCI_DRIVERS is not set
> CONFIG_COMEDI_PCMCIA_DRIVERS=y
> CONFIG_COMEDI_CB_DAS16_CS=y
> CONFIG_COMEDI_DAS08_CS=y
> CONFIG_COMEDI_NI_DAQ_700_CS=y
> CONFIG_COMEDI_NI_DAQ_DIO24_CS=y
> CONFIG_COMEDI_NI_LABPC_CS=y
> CONFIG_COMEDI_NI_MIO_CS=y
> # CONFIG_COMEDI_QUATECH_DAQP_CS is not set
> CONFIG_COMEDI_USB_DRIVERS=y
> # CONFIG_COMEDI_DT9812 is not set
> # CONFIG_COMEDI_NI_USB6501 is not set
> CONFIG_COMEDI_USBDUX=y
> # CONFIG_COMEDI_USBDUXFAST is not set
> CONFIG_COMEDI_USBDUXSIGMA=y
> CONFIG_COMEDI_VMK80XX=y
> CONFIG_COMEDI_8254=y
> CONFIG_COMEDI_8255=y
> CONFIG_COMEDI_8255_SA=y
> CONFIG_COMEDI_KCOMEDILIB=y
> CONFIG_COMEDI_DAS08=y
> CONFIG_COMEDI_ISADMA=y
> CONFIG_COMEDI_NI_LABPC=y
> CONFIG_COMEDI_NI_LABPC_ISADMA=y
> CONFIG_COMEDI_NI_TIO=y
> CONFIG_COMEDI_NI_ROUTING=y
> # CONFIG_RTL8192U is not set
> # CONFIG_RTLLIB is not set
> # CONFIG_RTS5208 is not set
> 
> #
> # IIO staging drivers
> #
> 
> #
> # Accelerometers
> #
> # end of Accelerometers
> 
> #
> # Analog to digital converters
> #
> # end of Analog to digital converters
> 
> #
> # Analog digital bi-direction converters
> #
> CONFIG_ADT7316=y
> CONFIG_ADT7316_I2C=y
> # end of Analog digital bi-direction converters
> 
> #
> # Capacitance to digital converters
> #
> # CONFIG_AD7150 is not set
> # CONFIG_AD7746 is not set
> # end of Capacitance to digital converters
> 
> #
> # Direct Digital Synthesis
> #
> # end of Direct Digital Synthesis
> 
> #
> # Network Analyzer, Impedance Converters
> #
> # CONFIG_AD5933 is not set
> # end of Network Analyzer, Impedance Converters
> 
> #
> # Active energy metering IC
> #
> # CONFIG_ADE7854 is not set
> # end of Active energy metering IC
> 
> #
> # Resolver to digital converters
> #
> # end of Resolver to digital converters
> # end of IIO staging drivers
> 
> # CONFIG_FB_SM750 is not set
> CONFIG_STAGING_MEDIA=y
> # CONFIG_VIDEO_IPU3_IMGU is not set
> 
> #
> # Android
> #
> # CONFIG_ASHMEM is not set
> # CONFIG_ION is not set
> # end of Android
> 
> CONFIG_STAGING_BOARD=y
> # CONFIG_LTE_GDM724X is not set
> # CONFIG_GS_FPGABOOT is not set
> CONFIG_UNISYSSPAR=y
> CONFIG_MOST_COMPONENTS=y
> # CONFIG_MOST_CDEV is not set
> # CONFIG_MOST_NET is not set
> CONFIG_MOST_VIDEO=y
> # CONFIG_MOST_DIM2 is not set
> CONFIG_MOST_I2C=y
> # CONFIG_GREYBUS_BOOTROM is not set
> CONFIG_GREYBUS_HID=y
> # CONFIG_GREYBUS_LIGHT is not set
> CONFIG_GREYBUS_LOG=y
> # CONFIG_GREYBUS_LOOPBACK is not set
> CONFIG_GREYBUS_POWER=y
> CONFIG_GREYBUS_RAW=y
> CONFIG_GREYBUS_VIBRATOR=y
> CONFIG_GREYBUS_BRIDGED_PHY=y
> CONFIG_GREYBUS_GPIO=y
> CONFIG_GREYBUS_I2C=y
> CONFIG_GREYBUS_PWM=y
> CONFIG_GREYBUS_UART=y
> CONFIG_GREYBUS_USB=y
> 
> #
> # Gasket devices
> #
> # end of Gasket devices
> 
> CONFIG_XIL_AXIS_FIFO=y
> # CONFIG_FIELDBUS_DEV is not set
> # CONFIG_KPC2000 is not set
> # CONFIG_QLGE is not set
> # CONFIG_X86_PLATFORM_DEVICES is not set
> CONFIG_PMC_ATOM=y
> # CONFIG_MFD_CROS_EC is not set
> CONFIG_CHROME_PLATFORMS=y
> CONFIG_CHROMEOS_LAPTOP=y
> CONFIG_CHROMEOS_PSTORE=y
> # CONFIG_CHROMEOS_TBMC is not set
> CONFIG_CROS_EC=y
> CONFIG_CROS_EC_I2C=y
> # CONFIG_CROS_EC_RPMSG is not set
> # CONFIG_CROS_EC_LPC is not set
> CONFIG_CROS_EC_PROTO=y
> # CONFIG_CROS_KBD_LED_BACKLIGHT is not set
> # CONFIG_CROS_EC_CHARDEV is not set
> CONFIG_CROS_EC_LIGHTBAR=y
> # CONFIG_CROS_EC_VBC is not set
> CONFIG_CROS_EC_DEBUGFS=y
> CONFIG_CROS_EC_SENSORHUB=y
> # CONFIG_CROS_EC_SYSFS is not set
> CONFIG_CROS_USBPD_NOTIFY=y
> # CONFIG_MELLANOX_PLATFORM is not set
> CONFIG_HAVE_CLK=y
> CONFIG_CLKDEV_LOOKUP=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> CONFIG_CLK_HSDK=y
> # CONFIG_COMMON_CLK_MAX9485 is not set
> CONFIG_COMMON_CLK_RK808=y
> CONFIG_COMMON_CLK_SI5341=y
> # CONFIG_COMMON_CLK_SI5351 is not set
> CONFIG_COMMON_CLK_SI514=y
> # CONFIG_COMMON_CLK_SI544 is not set
> CONFIG_COMMON_CLK_SI570=y
> # CONFIG_COMMON_CLK_CDCE706 is not set
> # CONFIG_COMMON_CLK_CDCE925 is not set
> CONFIG_COMMON_CLK_CS2000_CP=y
> # CONFIG_COMMON_CLK_PWM is not set
> CONFIG_COMMON_CLK_VC5=y
> CONFIG_COMMON_CLK_BD718XX=y
> CONFIG_COMMON_CLK_FIXED_MMIO=y
> # CONFIG_CLK_LGM_CGU is not set
> # CONFIG_HWSPINLOCK is not set
> 
> #
> # Clock Source drivers
> #
> CONFIG_TIMER_OF=y
> CONFIG_TIMER_PROBE=y
> CONFIG_CLKSRC_I8253=y
> CONFIG_CLKEVT_I8253=y
> CONFIG_CLKBLD_I8253=y
> CONFIG_CLKSRC_MMIO=y
> CONFIG_MICROCHIP_PIT64B=y
> # end of Clock Source drivers
> 
> # CONFIG_MAILBOX is not set
> CONFIG_IOMMU_SUPPORT=y
> 
> #
> # Generic IOMMU Pagetable Support
> #
> # end of Generic IOMMU Pagetable Support
> 
> CONFIG_IOMMU_DEBUGFS=y
> 
> #
> # Remoteproc drivers
> #
> # CONFIG_REMOTEPROC is not set
> # end of Remoteproc drivers
> 
> #
> # Rpmsg drivers
> #
> CONFIG_RPMSG=y
> # CONFIG_RPMSG_CHAR is not set
> CONFIG_RPMSG_VIRTIO=y
> # end of Rpmsg drivers
> 
> CONFIG_SOUNDWIRE=y
> 
> #
> # SoundWire Devices
> #
> 
> #
> # SOC (System On Chip) specific Drivers
> #
> 
> #
> # Amlogic SoC drivers
> #
> # end of Amlogic SoC drivers
> 
> #
> # Aspeed SoC drivers
> #
> # end of Aspeed SoC drivers
> 
> #
> # Broadcom SoC drivers
> #
> # end of Broadcom SoC drivers
> 
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # end of NXP/Freescale QorIQ SoC drivers
> 
> #
> # i.MX SoC drivers
> #
> # end of i.MX SoC drivers
> 
> #
> # Qualcomm SoC drivers
> #
> # end of Qualcomm SoC drivers
> 
> CONFIG_SOC_TI=y
> 
> #
> # Xilinx SoC drivers
> #
> CONFIG_XILINX_VCU=y
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
> 
> CONFIG_PM_DEVFREQ=y
> 
> #
> # DEVFREQ Governors
> #
> CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
> CONFIG_DEVFREQ_GOV_PERFORMANCE=y
> # CONFIG_DEVFREQ_GOV_POWERSAVE is not set
> CONFIG_DEVFREQ_GOV_USERSPACE=y
> # CONFIG_DEVFREQ_GOV_PASSIVE is not set
> 
> #
> # DEVFREQ Drivers
> #
> # CONFIG_PM_DEVFREQ_EVENT is not set
> CONFIG_EXTCON=y
> 
> #
> # Extcon Device Drivers
> #
> # CONFIG_EXTCON_ADC_JACK is not set
> # CONFIG_EXTCON_AXP288 is not set
> CONFIG_EXTCON_FSA9480=y
> CONFIG_EXTCON_GPIO=y
> # CONFIG_EXTCON_INTEL_INT3496 is not set
> CONFIG_EXTCON_MAX3355=y
> CONFIG_EXTCON_MAX77843=y
> CONFIG_EXTCON_MAX8997=y
> CONFIG_EXTCON_PTN5150=y
> # CONFIG_EXTCON_RT8973A is not set
> CONFIG_EXTCON_SM5502=y
> CONFIG_EXTCON_USB_GPIO=y
> CONFIG_EXTCON_USBC_CROS_EC=y
> CONFIG_MEMORY=y
> CONFIG_IIO=y
> CONFIG_IIO_BUFFER=y
> CONFIG_IIO_BUFFER_CB=y
> CONFIG_IIO_BUFFER_DMA=y
> CONFIG_IIO_BUFFER_DMAENGINE=y
> CONFIG_IIO_BUFFER_HW_CONSUMER=y
> CONFIG_IIO_KFIFO_BUF=y
> CONFIG_IIO_TRIGGERED_BUFFER=y
> CONFIG_IIO_CONFIGFS=y
> CONFIG_IIO_TRIGGER=y
> CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
> CONFIG_IIO_SW_DEVICE=y
> CONFIG_IIO_SW_TRIGGER=y
> 
> #
> # Accelerometers
> #
> CONFIG_ADXL345=y
> CONFIG_ADXL345_I2C=y
> CONFIG_ADXL372=y
> CONFIG_ADXL372_I2C=y
> CONFIG_BMA180=y
> # CONFIG_BMA400 is not set
> CONFIG_BMC150_ACCEL=y
> CONFIG_BMC150_ACCEL_I2C=y
> CONFIG_DA280=y
> CONFIG_DA311=y
> CONFIG_DMARD06=y
> # CONFIG_DMARD09 is not set
> CONFIG_DMARD10=y
> # CONFIG_HID_SENSOR_ACCEL_3D is not set
> CONFIG_IIO_ST_ACCEL_3AXIS=y
> CONFIG_IIO_ST_ACCEL_I2C_3AXIS=y
> CONFIG_KXSD9=y
> CONFIG_KXSD9_I2C=y
> CONFIG_KXCJK1013=y
> # CONFIG_MC3230 is not set
> CONFIG_MMA7455=y
> CONFIG_MMA7455_I2C=y
> CONFIG_MMA7660=y
> CONFIG_MMA8452=y
> CONFIG_MMA9551_CORE=y
> CONFIG_MMA9551=y
> CONFIG_MMA9553=y
> CONFIG_MXC4005=y
> CONFIG_MXC6255=y
> CONFIG_STK8312=y
> CONFIG_STK8BA50=y
> # end of Accelerometers
> 
> #
> # Analog to digital converters
> #
> CONFIG_AD7091R5=y
> CONFIG_AD7291=y
> CONFIG_AD7606=y
> CONFIG_AD7606_IFACE_PARALLEL=y
> CONFIG_AD799X=y
> CONFIG_ADI_AXI_ADC=y
> # CONFIG_AXP20X_ADC is not set
> CONFIG_AXP288_ADC=y
> # CONFIG_CC10001_ADC is not set
> # CONFIG_DLN2_ADC is not set
> # CONFIG_ENVELOPE_DETECTOR is not set
> CONFIG_HX711=y
> CONFIG_INA2XX_ADC=y
> CONFIG_LTC2471=y
> CONFIG_LTC2485=y
> # CONFIG_LTC2497 is not set
> # CONFIG_MAX1363 is not set
> CONFIG_MAX9611=y
> CONFIG_MCP3422=y
> # CONFIG_MEN_Z188_ADC is not set
> # CONFIG_MP2629_ADC is not set
> # CONFIG_NAU7802 is not set
> # CONFIG_QCOM_SPMI_IADC is not set
> # CONFIG_QCOM_SPMI_VADC is not set
> # CONFIG_QCOM_SPMI_ADC5 is not set
> CONFIG_RN5T618_ADC=y
> CONFIG_SD_ADC_MODULATOR=y
> # CONFIG_TI_ADC081C is not set
> CONFIG_TI_ADS1015=y
> CONFIG_TI_AM335X_ADC=y
> # CONFIG_TWL4030_MADC is not set
> CONFIG_TWL6030_GPADC=y
> CONFIG_VF610_ADC=y
> CONFIG_XILINX_XADC=y
> # end of Analog to digital converters
> 
> #
> # Analog Front Ends
> #
> CONFIG_IIO_RESCALE=y
> # end of Analog Front Ends
> 
> #
> # Amplifiers
> #
> CONFIG_HMC425=y
> # end of Amplifiers
> 
> #
> # Chemical Sensors
> #
> # CONFIG_ATLAS_PH_SENSOR is not set
> CONFIG_ATLAS_EZO_SENSOR=y
> CONFIG_BME680=y
> CONFIG_BME680_I2C=y
> # CONFIG_CCS811 is not set
> CONFIG_IAQCORE=y
> CONFIG_PMS7003=y
> # CONFIG_SCD30_CORE is not set
> # CONFIG_SENSIRION_SGP30 is not set
> CONFIG_SPS30=y
> CONFIG_VZ89X=y
> # end of Chemical Sensors
> 
> # CONFIG_IIO_CROS_EC_SENSORS_CORE is not set
> 
> #
> # Hid Sensor IIO Common
> #
> CONFIG_HID_SENSOR_IIO_COMMON=y
> CONFIG_HID_SENSOR_IIO_TRIGGER=y
> # end of Hid Sensor IIO Common
> 
> CONFIG_IIO_MS_SENSORS_I2C=y
> 
> #
> # SSP Sensor Common
> #
> # end of SSP Sensor Common
> 
> CONFIG_IIO_ST_SENSORS_I2C=y
> CONFIG_IIO_ST_SENSORS_CORE=y
> 
> #
> # Digital to analog converters
> #
> CONFIG_AD5064=y
> CONFIG_AD5380=y
> CONFIG_AD5446=y
> CONFIG_AD5592R_BASE=y
> CONFIG_AD5593R=y
> CONFIG_AD5686=y
> CONFIG_AD5696_I2C=y
> CONFIG_CIO_DAC=y
> CONFIG_DPOT_DAC=y
> CONFIG_DS4424=y
> CONFIG_M62332=y
> CONFIG_MAX517=y
> # CONFIG_MAX5821 is not set
> CONFIG_MCP4725=y
> CONFIG_TI_DAC5571=y
> CONFIG_VF610_DAC=y
> # end of Digital to analog converters
> 
> #
> # IIO dummy driver
> #
> CONFIG_IIO_SIMPLE_DUMMY=y
> # CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
> # CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set
> # end of IIO dummy driver
> 
> #
> # Frequency Synthesizers DDS/PLL
> #
> 
> #
> # Clock Generator/Distribution
> #
> # end of Clock Generator/Distribution
> 
> #
> # Phase-Locked Loop (PLL) frequency synthesizers
> #
> # end of Phase-Locked Loop (PLL) frequency synthesizers
> # end of Frequency Synthesizers DDS/PLL
> 
> #
> # Digital gyroscope sensors
> #
> # CONFIG_BMG160 is not set
> # CONFIG_FXAS21002C is not set
> CONFIG_HID_SENSOR_GYRO_3D=y
> CONFIG_MPU3050=y
> CONFIG_MPU3050_I2C=y
> CONFIG_IIO_ST_GYRO_3AXIS=y
> CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
> # CONFIG_ITG3200 is not set
> # end of Digital gyroscope sensors
> 
> #
> # Health Sensors
> #
> 
> #
> # Heart Rate Monitors
> #
> # CONFIG_AFE4404 is not set
> # CONFIG_MAX30100 is not set
> # CONFIG_MAX30102 is not set
> # end of Heart Rate Monitors
> # end of Health Sensors
> 
> #
> # Humidity sensors
> #
> CONFIG_AM2315=y
> CONFIG_DHT11=y
> CONFIG_HDC100X=y
> # CONFIG_HID_SENSOR_HUMIDITY is not set
> CONFIG_HTS221=y
> CONFIG_HTS221_I2C=y
> # CONFIG_HTU21 is not set
> CONFIG_SI7005=y
> CONFIG_SI7020=y
> # end of Humidity sensors
> 
> #
> # Inertial measurement units
> #
> CONFIG_BMI160=y
> CONFIG_BMI160_I2C=y
> CONFIG_FXOS8700=y
> CONFIG_FXOS8700_I2C=y
> # CONFIG_KMX61 is not set
> CONFIG_INV_ICM42600=y
> CONFIG_INV_ICM42600_I2C=y
> CONFIG_INV_MPU6050_IIO=y
> CONFIG_INV_MPU6050_I2C=y
> CONFIG_IIO_ST_LSM6DSX=y
> CONFIG_IIO_ST_LSM6DSX_I2C=y
> CONFIG_IIO_ST_LSM6DSX_I3C=y
> # end of Inertial measurement units
> 
> #
> # Light sensors
> #
> # CONFIG_ACPI_ALS is not set
> # CONFIG_ADJD_S311 is not set
> CONFIG_ADUX1020=y
> CONFIG_AL3010=y
> # CONFIG_AL3320A is not set
> CONFIG_APDS9300=y
> CONFIG_APDS9960=y
> CONFIG_BH1750=y
> CONFIG_BH1780=y
> CONFIG_CM32181=y
> CONFIG_CM3232=y
> CONFIG_CM3323=y
> CONFIG_CM3605=y
> # CONFIG_CM36651 is not set
> # CONFIG_GP2AP002 is not set
> # CONFIG_GP2AP020A00F is not set
> CONFIG_SENSORS_ISL29018=y
> CONFIG_SENSORS_ISL29028=y
> CONFIG_ISL29125=y
> CONFIG_HID_SENSOR_ALS=y
> # CONFIG_HID_SENSOR_PROX is not set
> CONFIG_JSA1212=y
> CONFIG_RPR0521=y
> CONFIG_SENSORS_LM3533=y
> # CONFIG_LTR501 is not set
> CONFIG_LV0104CS=y
> CONFIG_MAX44000=y
> # CONFIG_MAX44009 is not set
> # CONFIG_NOA1305 is not set
> CONFIG_OPT3001=y
> CONFIG_PA12203001=y
> CONFIG_SI1133=y
> CONFIG_SI1145=y
> # CONFIG_STK3310 is not set
> # CONFIG_ST_UVIS25 is not set
> CONFIG_TCS3414=y
> CONFIG_TCS3472=y
> # CONFIG_SENSORS_TSL2563 is not set
> CONFIG_TSL2583=y
> CONFIG_TSL2772=y
> CONFIG_TSL4531=y
> CONFIG_US5182D=y
> CONFIG_VCNL4000=y
> CONFIG_VCNL4035=y
> CONFIG_VEML6030=y
> # CONFIG_VEML6070 is not set
> CONFIG_VL6180=y
> CONFIG_ZOPT2201=y
> # end of Light sensors
> 
> #
> # Magnetometer sensors
> #
> CONFIG_AK8974=y
> CONFIG_AK8975=y
> CONFIG_AK09911=y
> CONFIG_BMC150_MAGN=y
> CONFIG_BMC150_MAGN_I2C=y
> CONFIG_MAG3110=y
> CONFIG_HID_SENSOR_MAGNETOMETER_3D=y
> CONFIG_MMC35240=y
> CONFIG_IIO_ST_MAGN_3AXIS=y
> CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
> CONFIG_SENSORS_HMC5843=y
> CONFIG_SENSORS_HMC5843_I2C=y
> CONFIG_SENSORS_RM3100=y
> CONFIG_SENSORS_RM3100_I2C=y
> # end of Magnetometer sensors
> 
> #
> # Multiplexers
> #
> CONFIG_IIO_MUX=y
> # end of Multiplexers
> 
> #
> # Inclinometer sensors
> #
> # CONFIG_HID_SENSOR_INCLINOMETER_3D is not set
> CONFIG_HID_SENSOR_DEVICE_ROTATION=y
> # end of Inclinometer sensors
> 
> #
> # Triggers - standalone
> #
> CONFIG_IIO_HRTIMER_TRIGGER=y
> # CONFIG_IIO_INTERRUPT_TRIGGER is not set
> CONFIG_IIO_TIGHTLOOP_TRIGGER=y
> CONFIG_IIO_SYSFS_TRIGGER=y
> # end of Triggers - standalone
> 
> #
> # Linear and angular position sensors
> #
> # end of Linear and angular position sensors
> 
> #
> # Digital potentiometers
> #
> CONFIG_AD5272=y
> CONFIG_DS1803=y
> # CONFIG_MAX5432 is not set
> CONFIG_MCP4018=y
> CONFIG_MCP4531=y
> CONFIG_TPL0102=y
> # end of Digital potentiometers
> 
> #
> # Digital potentiostats
> #
> CONFIG_LMP91000=y
> # end of Digital potentiostats
> 
> #
> # Pressure sensors
> #
> # CONFIG_ABP060MG is not set
> CONFIG_BMP280=y
> CONFIG_BMP280_I2C=y
> CONFIG_DLHL60D=y
> CONFIG_DPS310=y
> # CONFIG_HID_SENSOR_PRESS is not set
> CONFIG_HP03=y
> CONFIG_ICP10100=y
> CONFIG_MPL115=y
> CONFIG_MPL115_I2C=y
> # CONFIG_MPL3115 is not set
> # CONFIG_MS5611 is not set
> # CONFIG_MS5637 is not set
> CONFIG_IIO_ST_PRESS=y
> CONFIG_IIO_ST_PRESS_I2C=y
> # CONFIG_T5403 is not set
> CONFIG_HP206C=y
> CONFIG_ZPA2326=y
> CONFIG_ZPA2326_I2C=y
> # end of Pressure sensors
> 
> #
> # Lightning sensors
> #
> # end of Lightning sensors
> 
> #
> # Proximity and distance sensors
> #
> CONFIG_ISL29501=y
> # CONFIG_LIDAR_LITE_V2 is not set
> CONFIG_MB1232=y
> CONFIG_PING=y
> CONFIG_RFD77402=y
> # CONFIG_SRF04 is not set
> CONFIG_SX9310=y
> CONFIG_SX9500=y
> CONFIG_SRF08=y
> CONFIG_VCNL3020=y
> CONFIG_VL53L0X_I2C=y
> # end of Proximity and distance sensors
> 
> #
> # Resolver to digital converters
> #
> # end of Resolver to digital converters
> 
> #
> # Temperature sensors
> #
> # CONFIG_HID_SENSOR_TEMP is not set
> # CONFIG_MLX90614 is not set
> # CONFIG_MLX90632 is not set
> CONFIG_TMP006=y
> CONFIG_TMP007=y
> CONFIG_TSYS01=y
> CONFIG_TSYS02D=y
> # end of Temperature sensors
> 
> # CONFIG_NTB is not set
> # CONFIG_VME_BUS is not set
> CONFIG_PWM=y
> CONFIG_PWM_SYSFS=y
> CONFIG_PWM_DEBUG=y
> # CONFIG_PWM_ATMEL_HLCDC_PWM is not set
> CONFIG_PWM_CROS_EC=y
> CONFIG_PWM_FSL_FTM=y
> # CONFIG_PWM_LP3943 is not set
> # CONFIG_PWM_LPSS_PCI is not set
> # CONFIG_PWM_LPSS_PLATFORM is not set
> CONFIG_PWM_PCA9685=y
> CONFIG_PWM_TWL=y
> CONFIG_PWM_TWL_LED=y
> 
> #
> # IRQ chip support
> #
> CONFIG_IRQCHIP=y
> # CONFIG_AL_FIC is not set
> CONFIG_MADERA_IRQ=y
> # end of IRQ chip support
> 
> CONFIG_IPACK_BUS=y
> # CONFIG_BOARD_TPCI200 is not set
> # CONFIG_SERIAL_IPOCTAL is not set
> CONFIG_RESET_CONTROLLER=y
> CONFIG_RESET_BRCMSTB_RESCAL=y
> # CONFIG_RESET_INTEL_GW is not set
> CONFIG_RESET_TI_SYSCON=y
> 
> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=y
> CONFIG_GENERIC_PHY_MIPI_DPHY=y
> CONFIG_BCM_KONA_USB2_PHY=y
> CONFIG_PHY_CADENCE_TORRENT=y
> CONFIG_PHY_CADENCE_DPHY=y
> CONFIG_PHY_CADENCE_SIERRA=y
> # CONFIG_PHY_CADENCE_SALVO is not set
> CONFIG_PHY_FSL_IMX8MQ_USB=y
> CONFIG_PHY_MIXEL_MIPI_DPHY=y
> CONFIG_PHY_PXA_28NM_HSIC=y
> CONFIG_PHY_PXA_28NM_USB2=y
> CONFIG_PHY_CPCAP_USB=y
> CONFIG_PHY_MAPPHONE_MDM6600=y
> CONFIG_PHY_OCELOT_SERDES=y
> # CONFIG_PHY_QCOM_USB_HS is not set
> CONFIG_PHY_QCOM_USB_HSIC=y
> CONFIG_PHY_SAMSUNG_USB2=y
> # CONFIG_PHY_TUSB1210 is not set
> # CONFIG_PHY_INTEL_COMBO is not set
> CONFIG_PHY_INTEL_EMMC=y
> # end of PHY Subsystem
> 
> # CONFIG_POWERCAP is not set
> CONFIG_MCB=y
> # CONFIG_MCB_PCI is not set
> # CONFIG_MCB_LPC is not set
> 
> #
> # Performance monitor support
> #
> # end of Performance monitor support
> 
> CONFIG_RAS=y
> # CONFIG_USB4 is not set
> 
> #
> # Android
> #
> CONFIG_ANDROID=y
> CONFIG_ANDROID_BINDER_IPC=y
> CONFIG_ANDROID_BINDERFS=y
> CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
> # CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
> # end of Android
> 
> CONFIG_LIBNVDIMM=y
> # CONFIG_BLK_DEV_PMEM is not set
> CONFIG_ND_BLK=y
> CONFIG_ND_CLAIM=y
> CONFIG_ND_BTT=y
> CONFIG_BTT=y
> CONFIG_OF_PMEM=y
> # CONFIG_DAX is not set
> CONFIG_NVMEM=y
> CONFIG_NVMEM_SYSFS=y
> CONFIG_NVMEM_SPMI_SDAM=y
> CONFIG_RAVE_SP_EEPROM=y
> 
> #
> # HW tracing support
> #
> # CONFIG_STM is not set
> CONFIG_INTEL_TH=y
> # CONFIG_INTEL_TH_PCI is not set
> # CONFIG_INTEL_TH_ACPI is not set
> # CONFIG_INTEL_TH_GTH is not set
> CONFIG_INTEL_TH_MSU=y
> CONFIG_INTEL_TH_PTI=y
> CONFIG_INTEL_TH_DEBUG=y
> # end of HW tracing support
> 
> CONFIG_FPGA=y
> CONFIG_ALTERA_PR_IP_CORE=y
> # CONFIG_ALTERA_PR_IP_CORE_PLAT is not set
> # CONFIG_FPGA_MGR_ALTERA_CVP is not set
> # CONFIG_FPGA_BRIDGE is not set
> # CONFIG_FPGA_DFL is not set
> # CONFIG_FSI is not set
> CONFIG_TEE=y
> 
> #
> # TEE drivers
> #
> # end of TEE drivers
> 
> CONFIG_MULTIPLEXER=y
> 
> #
> # Multiplexer drivers
> #
> # CONFIG_MUX_ADG792A is not set
> # CONFIG_MUX_GPIO is not set
> CONFIG_MUX_MMIO=y
> # end of Multiplexer drivers
> 
> CONFIG_PM_OPP=y
> CONFIG_SIOX=y
> # CONFIG_SIOX_BUS_GPIO is not set
> # CONFIG_SLIMBUS is not set
> # CONFIG_INTERCONNECT is not set
> # CONFIG_COUNTER is not set
> CONFIG_MOST=y
> # CONFIG_MOST_USB_HDM is not set
> # end of Device Drivers
> 
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=y
> # CONFIG_VALIDATE_FS_PARSER is not set
> CONFIG_FS_IOMAP=y
> # CONFIG_EXT2_FS is not set
> CONFIG_EXT3_FS=y
> CONFIG_EXT3_FS_POSIX_ACL=y
> # CONFIG_EXT3_FS_SECURITY is not set
> CONFIG_EXT4_FS=y
> CONFIG_EXT4_USE_FOR_EXT2=y
> CONFIG_EXT4_FS_POSIX_ACL=y
> CONFIG_EXT4_FS_SECURITY=y
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_EXT4_KUNIT_TESTS=y
> CONFIG_JBD2=y
> CONFIG_JBD2_DEBUG=y
> CONFIG_FS_MBCACHE=y
> CONFIG_REISERFS_FS=y
> # CONFIG_REISERFS_CHECK is not set
> # CONFIG_REISERFS_PROC_INFO is not set
> CONFIG_REISERFS_FS_XATTR=y
> # CONFIG_REISERFS_FS_POSIX_ACL is not set
> CONFIG_REISERFS_FS_SECURITY=y
> CONFIG_JFS_FS=y
> # CONFIG_JFS_POSIX_ACL is not set
> # CONFIG_JFS_SECURITY is not set
> # CONFIG_JFS_DEBUG is not set
> CONFIG_JFS_STATISTICS=y
> CONFIG_XFS_FS=y
> # CONFIG_XFS_QUOTA is not set
> # CONFIG_XFS_POSIX_ACL is not set
> CONFIG_XFS_RT=y
> # CONFIG_XFS_ONLINE_SCRUB is not set
> CONFIG_XFS_DEBUG=y
> CONFIG_XFS_ASSERT_FATAL=y
> CONFIG_GFS2_FS=y
> # CONFIG_OCFS2_FS is not set
> CONFIG_BTRFS_FS=y
> CONFIG_BTRFS_FS_POSIX_ACL=y
> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> CONFIG_BTRFS_DEBUG=y
> # CONFIG_BTRFS_ASSERT is not set
> # CONFIG_BTRFS_FS_REF_VERIFY is not set
> CONFIG_NILFS2_FS=y
> CONFIG_F2FS_FS=y
> CONFIG_F2FS_STAT_FS=y
> CONFIG_F2FS_FS_XATTR=y
> # CONFIG_F2FS_FS_POSIX_ACL is not set
> CONFIG_F2FS_FS_SECURITY=y
> # CONFIG_F2FS_CHECK_FS is not set
> # CONFIG_F2FS_FAULT_INJECTION is not set
> # CONFIG_F2FS_FS_COMPRESSION is not set
> # CONFIG_FS_DAX is not set
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> CONFIG_EXPORTFS_BLOCK_OPS=y
> CONFIG_FILE_LOCKING=y
> CONFIG_MANDATORY_FILE_LOCKING=y
> # CONFIG_FS_ENCRYPTION is not set
> # CONFIG_FS_VERITY is not set
> CONFIG_FSNOTIFY=y
> # CONFIG_DNOTIFY is not set
> CONFIG_INOTIFY_USER=y
> # CONFIG_FANOTIFY is not set
> CONFIG_QUOTA=y
> # CONFIG_QUOTA_NETLINK_INTERFACE is not set
> CONFIG_PRINT_QUOTA_WARNING=y
> # CONFIG_QUOTA_DEBUG is not set
> CONFIG_QUOTA_TREE=y
> CONFIG_QFMT_V1=y
> CONFIG_QFMT_V2=y
> CONFIG_QUOTACTL=y
> CONFIG_AUTOFS4_FS=y
> CONFIG_AUTOFS_FS=y
> CONFIG_FUSE_FS=y
> # CONFIG_CUSE is not set
> CONFIG_VIRTIO_FS=y
> CONFIG_OVERLAY_FS=y
> CONFIG_OVERLAY_FS_REDIRECT_DIR=y
> CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
> CONFIG_OVERLAY_FS_INDEX=y
> CONFIG_OVERLAY_FS_METACOPY=y
> 
> #
> # Caches
> #
> # CONFIG_FSCACHE is not set
> # end of Caches
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> # CONFIG_ZISOFS is not set
> # CONFIG_UDF_FS is not set
> # end of CD-ROM/DVD Filesystems
> 
> #
> # DOS/FAT/EXFAT/NT Filesystems
> #
> CONFIG_FAT_FS=y
> CONFIG_MSDOS_FS=y
> CONFIG_VFAT_FS=y
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> # CONFIG_FAT_DEFAULT_UTF8 is not set
> CONFIG_EXFAT_FS=y
> CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
> CONFIG_NTFS_FS=y
> # CONFIG_NTFS_DEBUG is not set
> # CONFIG_NTFS_RW is not set
> # end of DOS/FAT/EXFAT/NT Filesystems
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_PROC_SYSCTL=y
> # CONFIG_PROC_PAGE_MONITOR is not set
> # CONFIG_PROC_CHILDREN is not set
> CONFIG_PROC_PID_ARCH_STATUS=y
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> # CONFIG_TMPFS_POSIX_ACL is not set
> # CONFIG_TMPFS_XATTR is not set
> # CONFIG_HUGETLBFS is not set
> CONFIG_MEMFD_CREATE=y
> CONFIG_CONFIGFS_FS=y
> # end of Pseudo filesystems
> 
> CONFIG_MISC_FILESYSTEMS=y
> CONFIG_ORANGEFS_FS=y
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_ECRYPT_FS is not set
> CONFIG_HFS_FS=y
> CONFIG_HFSPLUS_FS=y
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_JFFS2_FS is not set
> # CONFIG_UBIFS_FS is not set
> CONFIG_CRAMFS=y
> CONFIG_CRAMFS_BLOCKDEV=y
> # CONFIG_CRAMFS_MTD is not set
> CONFIG_SQUASHFS=y
> # CONFIG_SQUASHFS_FILE_CACHE is not set
> CONFIG_SQUASHFS_FILE_DIRECT=y
> # CONFIG_SQUASHFS_DECOMP_SINGLE is not set
> # CONFIG_SQUASHFS_DECOMP_MULTI is not set
> CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
> CONFIG_SQUASHFS_XATTR=y
> CONFIG_SQUASHFS_ZLIB=y
> CONFIG_SQUASHFS_LZ4=y
> CONFIG_SQUASHFS_LZO=y
> # CONFIG_SQUASHFS_XZ is not set
> CONFIG_SQUASHFS_ZSTD=y
> CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
> # CONFIG_SQUASHFS_EMBEDDED is not set
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
> CONFIG_VXFS_FS=y
> # CONFIG_MINIX_FS is not set
> CONFIG_OMFS_FS=y
> # CONFIG_HPFS_FS is not set
> CONFIG_QNX4FS_FS=y
> # CONFIG_QNX6FS_FS is not set
> CONFIG_ROMFS_FS=y
> CONFIG_ROMFS_BACKED_BY_BLOCK=y
> # CONFIG_ROMFS_BACKED_BY_MTD is not set
> # CONFIG_ROMFS_BACKED_BY_BOTH is not set
> CONFIG_ROMFS_ON_BLOCK=y
> # CONFIG_PSTORE is not set
> # CONFIG_SYSV_FS is not set
> CONFIG_UFS_FS=y
> CONFIG_UFS_FS_WRITE=y
> # CONFIG_UFS_DEBUG is not set
> # CONFIG_EROFS_FS is not set
> CONFIG_NETWORK_FILESYSTEMS=y
> CONFIG_NFS_FS=y
> CONFIG_NFS_V2=y
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V3_ACL is not set
> CONFIG_NFS_V4=m
> # CONFIG_NFS_SWAP is not set
> # CONFIG_NFS_V4_1 is not set
> # CONFIG_ROOT_NFS is not set
> # CONFIG_NFS_USE_LEGACY_DNS is not set
> CONFIG_NFS_USE_KERNEL_DNS=y
> CONFIG_NFS_DISABLE_UDP_SUPPORT=y
> # CONFIG_NFSD is not set
> CONFIG_GRACE_PERIOD=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=y
> CONFIG_SUNRPC_GSS=m
> # CONFIG_SUNRPC_DEBUG is not set
> # CONFIG_CEPH_FS is not set
> CONFIG_CIFS=m
> # CONFIG_CIFS_STATS2 is not set
> CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
> # CONFIG_CIFS_WEAK_PW_HASH is not set
> # CONFIG_CIFS_UPCALL is not set
> # CONFIG_CIFS_XATTR is not set
> CONFIG_CIFS_DEBUG=y
> # CONFIG_CIFS_DEBUG2 is not set
> # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> # CONFIG_CIFS_DFS_UPCALL is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> # CONFIG_9P_FS is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> # CONFIG_NLS_CODEPAGE_437 is not set
> CONFIG_NLS_CODEPAGE_737=y
> CONFIG_NLS_CODEPAGE_775=y
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> CONFIG_NLS_CODEPAGE_855=y
> CONFIG_NLS_CODEPAGE_857=y
> # CONFIG_NLS_CODEPAGE_860 is not set
> CONFIG_NLS_CODEPAGE_861=y
> CONFIG_NLS_CODEPAGE_862=y
> CONFIG_NLS_CODEPAGE_863=y
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> CONFIG_NLS_CODEPAGE_866=y
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> CONFIG_NLS_CODEPAGE_950=y
> # CONFIG_NLS_CODEPAGE_932 is not set
> CONFIG_NLS_CODEPAGE_949=y
> CONFIG_NLS_CODEPAGE_874=y
> # CONFIG_NLS_ISO8859_8 is not set
> CONFIG_NLS_CODEPAGE_1250=y
> CONFIG_NLS_CODEPAGE_1251=y
> # CONFIG_NLS_ASCII is not set
> CONFIG_NLS_ISO8859_1=y
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> CONFIG_NLS_ISO8859_5=y
> CONFIG_NLS_ISO8859_6=y
> CONFIG_NLS_ISO8859_7=y
> CONFIG_NLS_ISO8859_9=y
> CONFIG_NLS_ISO8859_13=y
> CONFIG_NLS_ISO8859_14=y
> # CONFIG_NLS_ISO8859_15 is not set
> CONFIG_NLS_KOI8_R=y
> CONFIG_NLS_KOI8_U=y
> CONFIG_NLS_MAC_ROMAN=y
> CONFIG_NLS_MAC_CELTIC=y
> CONFIG_NLS_MAC_CENTEURO=y
> CONFIG_NLS_MAC_CROATIAN=y
> # CONFIG_NLS_MAC_CYRILLIC is not set
> # CONFIG_NLS_MAC_GAELIC is not set
> CONFIG_NLS_MAC_GREEK=y
> CONFIG_NLS_MAC_ICELAND=y
> # CONFIG_NLS_MAC_INUIT is not set
> CONFIG_NLS_MAC_ROMANIAN=y
> CONFIG_NLS_MAC_TURKISH=y
> CONFIG_NLS_UTF8=y
> # CONFIG_DLM is not set
> CONFIG_UNICODE=y
> # CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
> CONFIG_IO_WQ=y
> # end of File systems
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> # CONFIG_KEYS_REQUEST_CACHE is not set
> # CONFIG_PERSISTENT_KEYRINGS is not set
> # CONFIG_BIG_KEYS is not set
> # CONFIG_TRUSTED_KEYS is not set
> # CONFIG_ENCRYPTED_KEYS is not set
> # CONFIG_KEY_DH_OPERATIONS is not set
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> CONFIG_SECURITY=y
> # CONFIG_SECURITYFS is not set
> CONFIG_SECURITY_NETWORK=y
> # CONFIG_PAGE_TABLE_ISOLATION is not set
> # CONFIG_SECURITY_PATH is not set
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> CONFIG_HARDENED_USERCOPY=y
> CONFIG_HARDENED_USERCOPY_FALLBACK=y
> CONFIG_HARDENED_USERCOPY_PAGESPAN=y
> CONFIG_FORTIFY_SOURCE=y
> # CONFIG_STATIC_USERMODEHELPER is not set
> # CONFIG_SECURITY_SMACK is not set
> # CONFIG_SECURITY_TOMOYO is not set
> # CONFIG_SECURITY_APPARMOR is not set
> CONFIG_SECURITY_LOADPIN=y
> # CONFIG_SECURITY_LOADPIN_ENFORCE is not set
> # CONFIG_SECURITY_YAMA is not set
> # CONFIG_SECURITY_SAFESETID is not set
> CONFIG_SECURITY_LOCKDOWN_LSM=y
> # CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is not set
> # CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE is not set
> CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY=y
> # CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set
> # CONFIG_INTEGRITY is not set
> CONFIG_DEFAULT_SECURITY_DAC=y
> CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"
> 
> #
> # Kernel hardening options
> #
> 
> #
> # Memory initialization
> #
> CONFIG_INIT_STACK_NONE=y
> CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
> # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> # end of Memory initialization
> # end of Kernel hardening options
> # end of Security options
> 
> CONFIG_XOR_BLOCKS=y
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=y
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_SKCIPHER=y
> CONFIG_CRYPTO_SKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=y
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_RNG_DEFAULT=y
> CONFIG_CRYPTO_AKCIPHER2=y
> CONFIG_CRYPTO_AKCIPHER=y
> CONFIG_CRYPTO_KPP2=y
> CONFIG_CRYPTO_KPP=y
> CONFIG_CRYPTO_ACOMP2=y
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> # CONFIG_CRYPTO_USER is not set
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> CONFIG_CRYPTO_GF128MUL=y
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_NULL2=y
> CONFIG_CRYPTO_CRYPTD=y
> CONFIG_CRYPTO_AUTHENC=y
> # CONFIG_CRYPTO_TEST is not set
> CONFIG_CRYPTO_ENGINE=y
> 
> #
> # Public-key cryptography
> #
> CONFIG_CRYPTO_RSA=y
> CONFIG_CRYPTO_DH=y
> CONFIG_CRYPTO_ECC=y
> CONFIG_CRYPTO_ECDH=y
> # CONFIG_CRYPTO_ECRDSA is not set
> # CONFIG_CRYPTO_CURVE25519 is not set
> 
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=y
> CONFIG_CRYPTO_GCM=m
> CONFIG_CRYPTO_CHACHA20POLY1305=y
> CONFIG_CRYPTO_AEGIS128=y
> # CONFIG_CRYPTO_SEQIV is not set
> # CONFIG_CRYPTO_ECHAINIV is not set
> 
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=y
> CONFIG_CRYPTO_CFB=y
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_CTS=y
> CONFIG_CRYPTO_ECB=y
> CONFIG_CRYPTO_LRW=y
> CONFIG_CRYPTO_OFB=y
> CONFIG_CRYPTO_PCBC=y
> CONFIG_CRYPTO_XTS=y
> CONFIG_CRYPTO_KEYWRAP=y
> CONFIG_CRYPTO_NHPOLY1305=y
> CONFIG_CRYPTO_ADIANTUM=y
> # CONFIG_CRYPTO_ESSIV is not set
> 
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=y
> CONFIG_CRYPTO_HMAC=y
> # CONFIG_CRYPTO_XCBC is not set
> CONFIG_CRYPTO_VMAC=y
> 
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=y
> # CONFIG_CRYPTO_CRC32C_INTEL is not set
> CONFIG_CRYPTO_CRC32=y
> CONFIG_CRYPTO_CRC32_PCLMUL=y
> CONFIG_CRYPTO_XXHASH=y
> CONFIG_CRYPTO_BLAKE2B=y
> CONFIG_CRYPTO_BLAKE2S=y
> CONFIG_CRYPTO_CRCT10DIF=y
> CONFIG_CRYPTO_GHASH=y
> CONFIG_CRYPTO_POLY1305=y
> CONFIG_CRYPTO_MD4=y
> CONFIG_CRYPTO_MD5=y
> CONFIG_CRYPTO_MICHAEL_MIC=y
> # CONFIG_CRYPTO_RMD128 is not set
> # CONFIG_CRYPTO_RMD160 is not set
> CONFIG_CRYPTO_RMD256=y
> CONFIG_CRYPTO_RMD320=y
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=y
> CONFIG_CRYPTO_SHA3=y
> CONFIG_CRYPTO_SM3=y
> CONFIG_CRYPTO_STREEBOG=y
> # CONFIG_CRYPTO_TGR192 is not set
> CONFIG_CRYPTO_WP512=y
> 
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=y
> CONFIG_CRYPTO_AES_TI=y
> # CONFIG_CRYPTO_AES_NI_INTEL is not set
> CONFIG_CRYPTO_ANUBIS=y
> CONFIG_CRYPTO_ARC4=y
> CONFIG_CRYPTO_BLOWFISH=y
> CONFIG_CRYPTO_BLOWFISH_COMMON=y
> # CONFIG_CRYPTO_CAMELLIA is not set
> CONFIG_CRYPTO_CAST_COMMON=y
> CONFIG_CRYPTO_CAST5=y
> CONFIG_CRYPTO_CAST6=y
> # CONFIG_CRYPTO_DES is not set
> CONFIG_CRYPTO_FCRYPT=y
> CONFIG_CRYPTO_KHAZAD=y
> CONFIG_CRYPTO_SALSA20=y
> CONFIG_CRYPTO_CHACHA20=y
> CONFIG_CRYPTO_SEED=y
> CONFIG_CRYPTO_SERPENT=y
> # CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
> CONFIG_CRYPTO_SM4=y
> CONFIG_CRYPTO_TEA=y
> CONFIG_CRYPTO_TWOFISH=y
> CONFIG_CRYPTO_TWOFISH_COMMON=y
> CONFIG_CRYPTO_TWOFISH_586=y
> 
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=y
> CONFIG_CRYPTO_LZO=y
> CONFIG_CRYPTO_842=y
> # CONFIG_CRYPTO_LZ4 is not set
> # CONFIG_CRYPTO_LZ4HC is not set
> # CONFIG_CRYPTO_ZSTD is not set
> 
> #
> # Random Number Generation
> #
> # CONFIG_CRYPTO_ANSI_CPRNG is not set
> CONFIG_CRYPTO_DRBG_MENU=y
> CONFIG_CRYPTO_DRBG_HMAC=y
> # CONFIG_CRYPTO_DRBG_HASH is not set
> CONFIG_CRYPTO_DRBG_CTR=y
> CONFIG_CRYPTO_DRBG=y
> CONFIG_CRYPTO_JITTERENTROPY=y
> # CONFIG_CRYPTO_USER_API_HASH is not set
> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> # CONFIG_CRYPTO_USER_API_RNG is not set
> # CONFIG_CRYPTO_USER_API_AEAD is not set
> CONFIG_CRYPTO_HASH_INFO=y
> 
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_AES=y
> CONFIG_CRYPTO_LIB_ARC4=y
> CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
> # CONFIG_CRYPTO_LIB_BLAKE2S is not set
> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
> CONFIG_CRYPTO_LIB_CHACHA=y
> # CONFIG_CRYPTO_LIB_CURVE25519 is not set
> CONFIG_CRYPTO_LIB_DES=y
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
> CONFIG_CRYPTO_LIB_POLY1305=y
> CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
> CONFIG_CRYPTO_LIB_SHA256=y
> CONFIG_CRYPTO_HW=y
> CONFIG_CRYPTO_DEV_PADLOCK=y
> CONFIG_CRYPTO_DEV_PADLOCK_AES=y
> CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
> # CONFIG_CRYPTO_DEV_GEODE is not set
> CONFIG_CRYPTO_DEV_ATMEL_I2C=y
> CONFIG_CRYPTO_DEV_ATMEL_ECC=y
> # CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
> # CONFIG_CRYPTO_DEV_CCP is not set
> # CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
> # CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
> # CONFIG_CRYPTO_DEV_QAT_C62X is not set
> # CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
> # CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
> # CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
> CONFIG_CRYPTO_DEV_VIRTIO=y
> # CONFIG_CRYPTO_DEV_SAFEXCEL is not set
> CONFIG_CRYPTO_DEV_CCREE=y
> CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
> # CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=y
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> CONFIG_X509_CERTIFICATE_PARSER=y
> # CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
> CONFIG_PKCS7_MESSAGE_PARSER=y
> # CONFIG_PKCS7_TEST_KEY is not set
> # CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
> 
> #
> # Certificates for signature checking
> #
> CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_TRUSTED_KEYS=""
> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> # CONFIG_SECONDARY_TRUSTED_KEYRING is not set
> # CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
> # end of Certificates for signature checking
> 
> #
> # Library routines
> #
> CONFIG_RAID6_PQ=y
> CONFIG_RAID6_PQ_BENCHMARK=y
> CONFIG_LINEAR_RANGES=y
> CONFIG_PACKING=y
> CONFIG_BITREVERSE=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> CONFIG_GENERIC_FIND_FIRST_BIT=y
> CONFIG_CORDIC=y
> CONFIG_PRIME_NUMBERS=y
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
> CONFIG_CRC_CCITT=y
> CONFIG_CRC16=y
> CONFIG_CRC_T10DIF=y
> CONFIG_CRC_ITU_T=y
> CONFIG_CRC32=y
> # CONFIG_CRC32_SELFTEST is not set
> # CONFIG_CRC32_SLICEBY8 is not set
> # CONFIG_CRC32_SLICEBY4 is not set
> # CONFIG_CRC32_SARWATE is not set
> CONFIG_CRC32_BIT=y
> CONFIG_CRC64=y
> # CONFIG_CRC4 is not set
> CONFIG_CRC7=y
> CONFIG_LIBCRC32C=y
> CONFIG_CRC8=y
> CONFIG_XXHASH=y
> CONFIG_RANDOM32_SELFTEST=y
> CONFIG_842_COMPRESS=y
> CONFIG_842_DECOMPRESS=y
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_ZSTD_COMPRESS=y
> CONFIG_ZSTD_DECOMPRESS=y
> CONFIG_XZ_DEC=y
> # CONFIG_XZ_DEC_X86 is not set
> CONFIG_XZ_DEC_POWERPC=y
> # CONFIG_XZ_DEC_IA64 is not set
> CONFIG_XZ_DEC_ARM=y
> CONFIG_XZ_DEC_ARMTHUMB=y
> CONFIG_XZ_DEC_SPARC=y
> CONFIG_XZ_DEC_BCJ=y
> CONFIG_XZ_DEC_TEST=y
> CONFIG_DECOMPRESS_GZIP=y
> CONFIG_DECOMPRESS_BZIP2=y
> CONFIG_DECOMPRESS_LZMA=y
> CONFIG_DECOMPRESS_XZ=y
> CONFIG_DECOMPRESS_LZO=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_REED_SOLOMON=y
> CONFIG_REED_SOLOMON_DEC16=y
> CONFIG_BCH=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> CONFIG_DMA_OPS=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> CONFIG_SWIOTLB=y
> # CONFIG_DMA_API_DEBUG is not set
> CONFIG_SGL_ALLOC=y
> CONFIG_DQL=y
> CONFIG_NLATTR=y
> CONFIG_CLZ_TAB=y
> CONFIG_IRQ_POLL=y
> CONFIG_MPILIB=y
> CONFIG_LIBFDT=y
> CONFIG_OID_REGISTRY=y
> CONFIG_HAVE_GENERIC_VDSO=y
> CONFIG_GENERIC_GETTIMEOFDAY=y
> CONFIG_GENERIC_VDSO_32=y
> CONFIG_GENERIC_VDSO_TIME_NS=y
> CONFIG_FONT_SUPPORT=y
> CONFIG_FONT_8x16=y
> CONFIG_FONT_AUTOSELECT=y
> CONFIG_SG_POOL=y
> CONFIG_MEMREGION=y
> CONFIG_ARCH_STACKWALK=y
> CONFIG_STACKDEPOT=y
> CONFIG_SBITMAP=y
> # CONFIG_STRING_SELFTEST is not set
> # end of Library routines
> 
> #
> # Kernel hacking
> #
> 
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=y
> # CONFIG_PRINTK_CALLER is not set
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> # CONFIG_BOOT_PRINTK_DELAY is not set
> # CONFIG_DYNAMIC_DEBUG is not set
> # CONFIG_DYNAMIC_DEBUG_CORE is not set
> CONFIG_SYMBOLIC_ERRNAME=y
> CONFIG_DEBUG_BUGVERBOSE=y
> # end of printk and dmesg options
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=y
> CONFIG_DEBUG_INFO_REDUCED=y
> # CONFIG_DEBUG_INFO_COMPRESSED is not set
> # CONFIG_DEBUG_INFO_SPLIT is not set
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> CONFIG_GDB_SCRIPTS=y
> CONFIG_ENABLE_MUST_CHECK=y
> CONFIG_FRAME_WARN=1024
> # CONFIG_STRIP_ASM_SYMS is not set
> # CONFIG_READABLE_ASM is not set
> # CONFIG_HEADERS_INSTALL is not set
> CONFIG_DEBUG_SECTION_MISMATCH=y
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B=y
> CONFIG_FRAME_POINTER=y
> CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
> # end of Compile-time checks and compiler options
> 
> #
> # Generic Kernel Debugging Instruments
> #
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> CONFIG_MAGIC_SYSRQ_SERIAL=y
> CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
> CONFIG_DEBUG_FS=y
> CONFIG_DEBUG_FS_ALLOW_ALL=y
> # CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
> # CONFIG_DEBUG_FS_ALLOW_NONE is not set
> CONFIG_HAVE_ARCH_KGDB=y
> # CONFIG_KGDB is not set
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> CONFIG_UBSAN=y
> CONFIG_UBSAN_TRAP=y
> # CONFIG_UBSAN_BOUNDS is not set
> # CONFIG_UBSAN_MISC is not set
> # CONFIG_UBSAN_SANITIZE_ALL is not set
> # CONFIG_TEST_UBSAN is not set
> # end of Generic Kernel Debugging Instruments
> 
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_MISC=y
> 
> #
> # Memory Debugging
> #
> CONFIG_PAGE_EXTENSION=y
> # CONFIG_DEBUG_PAGEALLOC is not set
> CONFIG_PAGE_OWNER=y
> CONFIG_PAGE_POISONING=y
> CONFIG_PAGE_POISONING_NO_SANITY=y
> # CONFIG_PAGE_POISONING_ZERO is not set
> # CONFIG_DEBUG_RODATA_TEST is not set
> CONFIG_ARCH_HAS_DEBUG_WX=y
> # CONFIG_DEBUG_WX is not set
> CONFIG_GENERIC_PTDUMP=y
> # CONFIG_PTDUMP_DEBUGFS is not set
> CONFIG_DEBUG_OBJECTS=y
> # CONFIG_DEBUG_OBJECTS_SELFTEST is not set
> CONFIG_DEBUG_OBJECTS_FREE=y
> # CONFIG_DEBUG_OBJECTS_TIMERS is not set
> CONFIG_DEBUG_OBJECTS_WORK=y
> # CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
> CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
> CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
> CONFIG_SLUB_STATS=y
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> CONFIG_DEBUG_KMEMLEAK=y
> CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
> # CONFIG_DEBUG_KMEMLEAK_TEST is not set
> # CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
> CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_SCHED_STACK_END_CHECK is not set
> CONFIG_DEBUG_VM=y
> CONFIG_DEBUG_VM_VMACACHE=y
> # CONFIG_DEBUG_VM_RB is not set
> # CONFIG_DEBUG_VM_PGFLAGS is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> CONFIG_DEBUG_VIRTUAL=y
> CONFIG_DEBUG_MEMORY_INIT=y
> # CONFIG_DEBUG_HIGHMEM is not set
> CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
> CONFIG_DEBUG_STACKOVERFLOW=y
> CONFIG_CC_HAS_KASAN_GENERIC=y
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> # end of Memory Debugging
> 
> CONFIG_DEBUG_SHIRQ=y
> 
> #
> # Debug Oops, Lockups and Hangs
> #
> # CONFIG_PANIC_ON_OOPS is not set
> CONFIG_PANIC_ON_OOPS_VALUE=0
> CONFIG_PANIC_TIMEOUT=0
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_SOFTLOCKUP_DETECTOR=y
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
> CONFIG_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HARDLOCKUP_DETECTOR=y
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
> # CONFIG_DETECT_HUNG_TASK is not set
> CONFIG_WQ_WATCHDOG=y
> # CONFIG_TEST_LOCKUP is not set
> # end of Debug Oops, Lockups and Hangs
> 
> #
> # Scheduler Debugging
> #
> CONFIG_SCHED_DEBUG=y
> CONFIG_SCHED_INFO=y
> CONFIG_SCHEDSTATS=y
> # end of Scheduler Debugging
> 
> # CONFIG_DEBUG_TIMEKEEPING is not set
> # CONFIG_DEBUG_PREEMPT is not set
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> # CONFIG_PROVE_LOCKING is not set
> CONFIG_LOCK_STAT=y
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> CONFIG_DEBUG_RWSEMS=y
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_LOCKDEP=y
> # CONFIG_DEBUG_LOCKDEP is not set
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
> # CONFIG_LOCK_TORTURE_TEST is not set
> CONFIG_WW_MUTEX_SELFTEST=y
> # CONFIG_SCF_TORTURE_TEST is not set
> # end of Lock Debugging (spinlocks, mutexes, etc...)
> 
> CONFIG_STACKTRACE=y
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
> 
> #
> # Debug kernel data structures
> #
> CONFIG_DEBUG_LIST=y
> CONFIG_DEBUG_PLIST=y
> CONFIG_DEBUG_SG=y
> # CONFIG_DEBUG_NOTIFIERS is not set
> # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> # end of Debug kernel data structures
> 
> CONFIG_DEBUG_CREDENTIALS=y
> 
> #
> # RCU Debugging
> #
> CONFIG_TORTURE_TEST=y
> # CONFIG_RCU_SCALE_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> CONFIG_RCU_REF_SCALE_TEST=y
> CONFIG_RCU_CPU_STALL_TIMEOUT=21
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
> 
> CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
> # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> CONFIG_LATENCYTOP=y
> CONFIG_USER_STACKTRACE_SUPPORT=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_TRACING_SUPPORT=y
> # CONFIG_FTRACE is not set
> # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> # CONFIG_SAMPLES is not set
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> # CONFIG_STRICT_DEVMEM is not set
> 
> #
> # x86 Debugging
> #
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
> CONFIG_X86_VERBOSE_BOOTUP=y
> # CONFIG_EARLY_PRINTK is not set
> # CONFIG_DEBUG_TLBFLUSH is not set
> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> CONFIG_X86_DECODER_SELFTEST=y
> CONFIG_IO_DELAY_0X80=y
> # CONFIG_IO_DELAY_0XED is not set
> # CONFIG_IO_DELAY_UDELAY is not set
> # CONFIG_IO_DELAY_NONE is not set
> # CONFIG_DEBUG_BOOT_PARAMS is not set
> # CONFIG_CPA_DEBUG is not set
> CONFIG_DEBUG_ENTRY=y
> # CONFIG_DEBUG_NMI_SELFTEST is not set
> # CONFIG_X86_DEBUG_FPU is not set
> # CONFIG_PUNIT_ATOM_DEBUG is not set
> CONFIG_UNWINDER_FRAME_POINTER=y
> # end of x86 Debugging
> 
> #
> # Kernel Testing and Coverage
> #
> CONFIG_KUNIT=y
> CONFIG_KUNIT_DEBUGFS=y
> CONFIG_KUNIT_TEST=y
> CONFIG_KUNIT_EXAMPLE_TEST=y
> CONFIG_KUNIT_ALL_TESTS=y
> CONFIG_NOTIFIER_ERROR_INJECTION=y
> # CONFIG_PM_NOTIFIER_ERROR_INJECT is not set
> # CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT is not set
> # CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
> # CONFIG_FAULT_INJECTION is not set
> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> CONFIG_RUNTIME_TESTING_MENU=y
> # CONFIG_LKDTM is not set
> # CONFIG_TEST_LIST_SORT is not set
> # CONFIG_TEST_MIN_HEAP is not set
> # CONFIG_TEST_SORT is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_RBTREE_TEST is not set
> # CONFIG_REED_SOLOMON_TEST is not set
> # CONFIG_INTERVAL_TREE_TEST is not set
> # CONFIG_PERCPU_TEST is not set
> CONFIG_ATOMIC64_SELFTEST=y
> # CONFIG_TEST_HEXDUMP is not set
> # CONFIG_TEST_STRING_HELPERS is not set
> # CONFIG_TEST_STRSCPY is not set
> # CONFIG_TEST_KSTRTOX is not set
> # CONFIG_TEST_PRINTF is not set
> CONFIG_TEST_BITMAP=y
> # CONFIG_TEST_BITFIELD is not set
> # CONFIG_TEST_UUID is not set
> # CONFIG_TEST_XARRAY is not set
> # CONFIG_TEST_OVERFLOW is not set
> # CONFIG_TEST_RHASHTABLE is not set
> # CONFIG_TEST_HASH is not set
> # CONFIG_TEST_IDA is not set
> # CONFIG_TEST_LKM is not set
> # CONFIG_TEST_BITOPS is not set
> # CONFIG_TEST_VMALLOC is not set
> # CONFIG_TEST_USER_COPY is not set
> # CONFIG_TEST_BPF is not set
> # CONFIG_TEST_BLACKHOLE_DEV is not set
> # CONFIG_FIND_BIT_BENCHMARK is not set
> CONFIG_TEST_FIRMWARE=y
> CONFIG_TEST_SYSCTL=y
> CONFIG_SYSCTL_KUNIT_TEST=y
> CONFIG_LIST_KUNIT_TEST=y
> # CONFIG_LINEAR_RANGES_TEST is not set
> # CONFIG_BITS_TEST is not set
> # CONFIG_TEST_UDELAY is not set
> # CONFIG_TEST_STATIC_KEYS is not set
> # CONFIG_TEST_KMOD is not set
> # CONFIG_TEST_DEBUG_VIRTUAL is not set
> # CONFIG_TEST_MEMCAT_P is not set
> # CONFIG_TEST_STACKINIT is not set
> # CONFIG_TEST_MEMINIT is not set
> # CONFIG_TEST_FPU is not set
> CONFIG_MEMTEST=y
> # end of Kernel Testing and Coverage
> # end of Kernel hacking

> #!/bin/sh
> 
> export_top_env()
> {
> 	export suite='trinity'
> 	export testcase='trinity'
> 	export category='functional'
> 	export need_memory='300MB'
> 	export runtime=300
> 	export job_origin='/lkp-src/allot/rand/vm-snb-i386/trinity.yaml'
> 	export queue_cmdline_keys='branch
> commit
> queue_at_least_once'
> 	export queue='validate'
> 	export testbox='vm-snb-i386-13'
> 	export tbox_group='vm-snb-i386'
> 	export branch='rcu/rcu/next'
> 	export commit='c02cb02f8f59b8d26a0cc0352d2a2fa4e55073df'
> 	export kconfig='i386-randconfig-a011-20200823'
> 	export repeat_to=4
> 	export nr_vm=64
> 	export submit_id='5f426945bdf3bd41d058e62d'
> 	export job_file='/lkp/jobs/scheduled/vm-snb-i386-13/trinity-300s-debian-i386-20191205.cgz-c02cb02f8f59b8d26a0cc0352d2a2fa4e55073df-20200823-16848-ujh9cf-3.yaml'
> 	export id='a915ade109932d63afcdf7712b294530d1e48322'
> 	export queuer_version='/lkp-src'
> 	export model='qemu-system-i386 -enable-kvm -cpu SandyBridge'
> 	export nr_cpu=2
> 	export memory='8G'
> 	export hdd_partitions='/dev/vda /dev/vdb /dev/vdc /dev/vdd /dev/vde /dev/vdf'
> 	export swap_partitions='/dev/vdg'
> 	export need_kconfig='CONFIG_KVM_GUEST=y'
> 	export ssh_base_port=23032
> 	export rootfs='debian-i386-20191205.cgz'
> 	export compiler='gcc-9'
> 	export enqueue_time='2020-08-23 21:04:05 +0800'
> 	export _id='5f426948bdf3bd41d058e62e'
> 	export _rt='/result/trinity/300s/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a011-20200823/gcc-9/c02cb02f8f59b8d26a0cc0352d2a2fa4e55073df'
> 	export user='lkp'
> 	export result_root='/result/trinity/300s/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a011-20200823/gcc-9/c02cb02f8f59b8d26a0cc0352d2a2fa4e55073df/3'
> 	export scheduler_version='/lkp/lkp/.src-20200822-215254'
> 	export LKP_SERVER='inn'
> 	export arch='i386'
> 	export max_uptime=1500
> 	export initrd='/osimage/debian/debian-i386-20191205.cgz'
> 	export bootloader_append='root=/dev/ram0
> user=lkp
> job=/lkp/jobs/scheduled/vm-snb-i386-13/trinity-300s-debian-i386-20191205.cgz-c02cb02f8f59b8d26a0cc0352d2a2fa4e55073df-20200823-16848-ujh9cf-3.yaml
> ARCH=i386
> kconfig=i386-randconfig-a011-20200823
> branch=rcu/rcu/next
> commit=c02cb02f8f59b8d26a0cc0352d2a2fa4e55073df
> BOOT_IMAGE=/pkg/linux/i386-randconfig-a011-20200823/gcc-9/c02cb02f8f59b8d26a0cc0352d2a2fa4e55073df/vmlinuz-5.9.0-rc1-00125-gc02cb02f8f59b
> max_uptime=1500
> RESULT_ROOT=/result/trinity/300s/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a011-20200823/gcc-9/c02cb02f8f59b8d26a0cc0352d2a2fa4e55073df/3
> LKP_SERVER=inn
> selinux=0
> debug
> apic=debug
> sysrq_always_enabled
> rcupdate.rcu_cpu_stall_timeout=100
> net.ifnames=0
> printk.devkmsg=on
> panic=-1
> softlockup_panic=1
> nmi_watchdog=panic
> oops=panic
> load_ramdisk=2
> prompt_ramdisk=0
> drbd.minor_count=8
> systemd.log_level=err
> ignore_loglevel
> console=tty0
> earlyprintk=ttyS0,115200
> console=ttyS0,115200
> vga=normal
> rw'
> 	export modules_initrd='/pkg/linux/i386-randconfig-a011-20200823/gcc-9/c02cb02f8f59b8d26a0cc0352d2a2fa4e55073df/modules.cgz'
> 	export bm_initrd='/osimage/pkg/debian-i386-20191205.cgz/trinity-i386-4d2343bd-1_20200320.cgz'
> 	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
> 	export site='inn'
> 	export LKP_CGI_PORT=80
> 	export LKP_CIFS_PORT=139
> 	export schedule_notify_address=
> 	export queue_at_least_once=1
> 	export kernel='/pkg/linux/i386-randconfig-a011-20200823/gcc-9/c02cb02f8f59b8d26a0cc0352d2a2fa4e55073df/vmlinuz-5.9.0-rc1-00125-gc02cb02f8f59b'
> 	export dequeue_time='2020-08-23 21:04:40 +0800'
> 	export job_initrd='/lkp/jobs/scheduled/vm-snb-i386-13/trinity-300s-debian-i386-20191205.cgz-c02cb02f8f59b8d26a0cc0352d2a2fa4e55073df-20200823-16848-ujh9cf-3.cgz'
> 
> 	[ -n "$LKP_SRC" ] ||
> 	export LKP_SRC=/lkp/${user:-lkp}/src
> }
> 
> run_job()
> {
> 	echo $$ > $TMP/run-job.pid
> 
> 	. $LKP_SRC/lib/http.sh
> 	. $LKP_SRC/lib/job.sh
> 	. $LKP_SRC/lib/env.sh
> 
> 	export_top_env
> 
> 	run_monitor $LKP_SRC/monitors/wrapper kmsg
> 	run_monitor $LKP_SRC/monitors/wrapper heartbeat
> 	run_monitor $LKP_SRC/monitors/wrapper meminfo
> 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
> 	run_monitor $LKP_SRC/monitors/plain/watchdog
> 
> 	run_test $LKP_SRC/tests/wrapper trinity
> }
> 
> extract_stats()
> {
> 	export stats_part_begin=
> 	export stats_part_end=
> 
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper meminfo
> 
> 	$LKP_SRC/stats/wrapper time trinity.time
> 	$LKP_SRC/stats/wrapper dmesg
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper last_state
> 	$LKP_SRC/stats/wrapper stderr
> 	$LKP_SRC/stats/wrapper time
> }
> 
> "$@"


