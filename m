Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1B42A0958
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgJ3PNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:13:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:49540 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgJ3PNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:13:41 -0400
IronPort-SDR: 8p4ApmAuhOepE1nIiFsuJ2RDGQnekiM8j9ci7MmPHrLdwRXB1HAXaofrBAs6/NQB5ddESRlM/X
 12zztzh/umhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="155595166"
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="155595166"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 08:13:38 -0700
IronPort-SDR: Jb6QQhXx16BFvc5/UkNIsn2Lcdu9SHHCHOFxwQPrL9lyYUQ2u6AH1iEZTB7EbfY+z237Sm5SVk
 qyY6LAwAy4HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="351889556"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga004.fm.intel.com with ESMTP; 30 Oct 2020 08:13:35 -0700
Date:   Fri, 30 Oct 2020 23:11:10 +0800
From:   Philip Li <philip.li@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [LKP] Re: [rcu] 44bad5b3cc:
 dmesg.INFO:rcu_preempt_detected_stalls_on_CPUs/tasks
Message-ID: <20201030151109.GA27406@intel.com>
References: <20201030074740.GX31092@shao2-debian>
 <20201030135621.GR3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030135621.GR3249@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 06:56:21AM -0700, Paul E. McKenney wrote:
> On Fri, Oct 30, 2020 at 03:47:40PM +0800, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: 44bad5b3cca2d452d17ef82841b20b42a2cf11a0 ("rcu: Do full report for .need_qs for strict GPs")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > 
> > in testcase: trinity
> > version: trinity-i386-4d2343bd-1_20200320
> > with following parameters:
> > 
> > 	runtime: 300s
> > 
> > test-description: Trinity is a linux system call fuzz tester.
> > test-url: http://codemonkey.org.uk/projects/trinity/
> > 
> > 
> > on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > +--------------------------------------------------+------------+------------+
> > |                                                  | f19920e412 | 44bad5b3cc |
> > +--------------------------------------------------+------------+------------+
> > | boot_successes                                   | 23         | 16         |
> > | boot_failures                                    | 21         | 48         |
> > | BUG:kernel_hang_in_test_stage                    | 21         | 47         |
> > | INFO:rcu_preempt_self-detected_stall_on_CPU      | 4          |            |
> > | EIP:_raw_spin_unlock_irq                         | 5          | 25         |
> > | EIP:___might_sleep                               | 1          |            |
> > | EIP:preempt_schedule_common                      | 4          | 2          |
> > | EIP:preempt_schedule_notrace                     | 4          |            |
> > | EIP:__put_user_4                                 | 1          |            |
> > | EIP:schedule                                     | 9          | 40         |
> > | INFO:rcu_preempt_detected_stalls_on_CPUs/tasks   | 8          | 40         |
> > | WARNING:at_net/sched/sch_generic.c:#dev_watchdog | 2          | 1          |
> > | EIP:dev_watchdog                                 | 2          | 1          |
> > +--------------------------------------------------+------------+------------+
> 
> Interesting test.
> 
> You enabled CONFIG_RCU_STRICT_GRACE_PERIOD, otherwise this commit
> would have had no effect.  You are running locktorture built in testing
> spinlocks, but are running 4 locktorture kthreads testing a pure spinlock
> on a system that has only 2 CPUs.  It appears that you are also trying to
> run rcutorture concurrently, but the torture-test subsystem told you "no":
> 
> [    7.409818] torture_init_begin: Refusing rcu init: spin_lock running.
> [    7.409823] spin_lock-torture: lock_torture_stats task started
> [    7.410938] torture_init_begin: One torture test at a time!
> 
> The boot failure is due to an RCU CPU stall warning, which shows that
> RCU's grace-period kthread has not gotten a chance to run for about 100
> seconds, during which time it has been in a three-millisecond timed wait.
> The grace period has actually completed, but this kthread hasn't been
> allowed to run, preventing it from detecting this completion.
> 
> So from what I can see, the root cause of this boot failure is
> oversubscribing CPUs during the locktorture test.  If so, the fact that
> this worked earlier is strictly coincidence.  Plus please note that
> having more locktorture kthreads than CPUs does not increase stress on
> spinlock primitives.  (Maybe I should make locktorture cap this, except
> that the stress on other parts of the system is sometimes useful.)
> 
> Could you please make your setup limit locktorture.nwriters_stress to
> at most the number of CPUs available?
> 
> My best guess is that this test was just barely working before, but
> enabling CONFIG_RCU_STRICT_GRACE_PERIOD increased RCU's CPU overhead
> (by design!), which pushed this test over the edge.
> 
> The reason I don't believe that this commit is directly to blame
> (other than the increase in CPU overhead) is that I don't see
> rcu_preempt_deferred_qs_irqrestore() or anything related to it on
> the stack traces.  But please feel free to rerun this test with
> CONFIG_PROVE_LOCKING=y, just in case there is a deadlock hiding in
> there somewhere.
Thanks a lot Paul for detail analysis and sharing. We will carefully
learn this and update test script to make it reasonable. And we will
rerun it per your suggestion next week.

> 
> 							Thanx, Paul
> 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > 
> > [  311.442723] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > [  311.445504] 	(detected by 1, t=100002 jiffies, g=83721, q=12)
> > [  311.446491] rcu: All QSes seen, last rcu_preempt kthread activity 100002 (10023--89979), jiffies_till_next_fqs=3, root ->qsmask 0x0
> > [  311.448502] rcu: rcu_preempt kthread starved for 100002 jiffies! g83721 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
> > [  311.450260] rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> > [  311.451793] rcu: RCU grace-period kthread stack dump:
> > [  311.452650] task:rcu_preempt     state:R  running task     stack:    0 pid:   10 ppid:     2 flags:0x00004008
> > [  311.454190] Call Trace:
> > [  311.454569]  sched_show_task+0x125/0x137
> > [  311.455208]  rcu_check_gp_kthread_starvation+0xe4/0xf6
> > [  311.456058]  rcu_sched_clock_irq+0x7c3/0x89a
> > [  311.456793]  ? account_system_time+0x68/0x71
> > [  311.457543]  update_process_times+0x24/0x4f
> > [  311.458273]  tick_sched_handle+0x55/0x63
> > [  311.458959]  tick_sched_timer+0x3b/0x79
> > [  311.459634]  ? tick_sched_do_timer+0x44/0x44
> > [  311.460353]  __hrtimer_run_queues+0x13a/0x1fe
> > [  311.461130]  ? tick_sched_do_timer+0x44/0x44
> > [  311.461861]  hrtimer_interrupt+0xb0/0x1bc
> > [  311.462575]  ? sysvec_call_function_single+0x2c/0x2c
> > [  311.463423]  __sysvec_apic_timer_interrupt+0xc3/0x13b
> > [  311.464306]  sysvec_apic_timer_interrupt+0x1b/0x2e
> > [  311.465097]  handle_exception+0x143/0x143
> > [  311.465747] EIP: _raw_spin_unlock_irq+0x25/0x2f
> > [  311.466519] Code: 9e ff 5b 5d c3 66 66 66 66 90 55 89 e5 53 89 c3 83 c0 10 8b 55 04 e8 e5 80 a2 ff 89 d8 e8 1e b4 a2 ff fb 64 ff 0d f4 06 c8 41 <75> 05 e8 fe 77 98 ff 5b 5d c3 66 66 66 66 90 55 89 e5 56 89 d6 53
> > [  311.469547] EAX: 00000001 EBX: f57777c0 ECX: 00000000 EDX: f4eab840
> > [  311.470573] ESI: 00000000 EDI: f4eab840 EBP: f4eb5df8 ESP: f4eb5df4
> > [  311.471709] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00000202
> > [  311.472930]  ? sysvec_call_function_single+0x2c/0x2c
> > [  311.473771]  ? _raw_spin_unlock_irq+0x25/0x2f
> > [  311.474512]  finish_task_switch+0x151/0x1dd
> > [  311.475244]  ? finish_task_switch+0x129/0x1dd
> > [  311.476000]  __schedule+0x4a2/0x4df
> > [  311.476630]  ? sysvec_call_function_single+0x2c/0x2c
> > [  311.477479]  preempt_schedule_irq+0x45/0x56
> > [  311.478204]  irqentry_exit_cond_resched+0x37/0x3a
> > [  311.479018]  irqentry_exit+0x33/0x42
> > [  311.479649]  sysvec_apic_timer_interrupt+0x2a/0x2e
> > [  311.480520]  handle_exception+0x143/0x143
> > [  311.481187] EIP: schedule+0x8c/0xb2
> > [  311.481752] Code: 39 d1 74 0a ba 01 00 00 00 e8 e7 de c8 ff 64 8b 35 fc 06 c8 41 64 ff 05 f4 06 c8 41 31 c0 e8 9c fa ff ff 64 ff 0d f4 06 c8 41 <8b> 06 a8 08 75 e5 8b 43 14 a9 20 00 00 20 74 12 a8 20 89 d8 74 07
> > [  311.484809] EAX: 00000000 EBX: f4eab840 ECX: 00000000 EDX: f4eab840
> > [  311.485882] ESI: f4eab840 EDI: 00000003 EBP: f4eb5ef8 ESP: f4eb5ef0
> > [  311.486967] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00000246
> > [  311.488134]  ? sysvec_call_function_single+0x2c/0x2c
> > [  311.489016]  ? schedule+0x8c/0xb2
> > [  311.489606]  schedule_timeout+0x88/0xbf
> > [  311.490291]  ? __next_timer_interrupt+0xb7/0xb7
> > [  311.491084]  rcu_gp_kthread+0x545/0x8fa
> > [  311.491761]  ? call_rcu+0x189/0x189
> > [  311.492381]  kthread+0x101/0x106
> > [  311.492923]  ? call_rcu+0x189/0x189
> > [  311.493522]  ? kthread_queue_delayed_work+0x55/0x55
> > [  311.494374]  ret_from_fork+0x1c/0x30
> > 
> > 
> > To reproduce:
> > 
> >         # build kernel
> > 	cd linux
> > 	cp config-5.9.0-rc1-00006-g44bad5b3cca2d .config
> > 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> > 
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> > 
> > 
> > 
> > Thanks,
> > lkp
> > 
> 
> > #
> > # Automatically generated file; DO NOT EDIT.
> > # Linux/i386 5.9.0-rc1 Kernel Configuration
> > #
> > CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-15) 9.3.0"
> > CONFIG_CC_IS_GCC=y
> > CONFIG_GCC_VERSION=90300
> > CONFIG_LD_VERSION=235000000
> > CONFIG_CLANG_VERSION=0
> > CONFIG_CC_HAS_ASM_GOTO=y
> > CONFIG_CC_HAS_ASM_INLINE=y
> > CONFIG_CONSTRUCTORS=y
> > CONFIG_IRQ_WORK=y
> > CONFIG_BUILDTIME_TABLE_SORT=y
> > CONFIG_THREAD_INFO_IN_TASK=y
> > 
> > #
> > # General setup
> > #
> > CONFIG_INIT_ENV_ARG_LIMIT=32
> > # CONFIG_COMPILE_TEST is not set
> > CONFIG_LOCALVERSION=""
> > CONFIG_LOCALVERSION_AUTO=y
> > CONFIG_BUILD_SALT=""
> > CONFIG_HAVE_KERNEL_GZIP=y
> > CONFIG_HAVE_KERNEL_BZIP2=y
> > CONFIG_HAVE_KERNEL_LZMA=y
> > CONFIG_HAVE_KERNEL_XZ=y
> > CONFIG_HAVE_KERNEL_LZO=y
> > CONFIG_HAVE_KERNEL_LZ4=y
> > CONFIG_HAVE_KERNEL_ZSTD=y
> > # CONFIG_KERNEL_GZIP is not set
> > # CONFIG_KERNEL_BZIP2 is not set
> > # CONFIG_KERNEL_LZMA is not set
> > CONFIG_KERNEL_XZ=y
> > # CONFIG_KERNEL_LZO is not set
> > # CONFIG_KERNEL_LZ4 is not set
> > # CONFIG_KERNEL_ZSTD is not set
> > CONFIG_DEFAULT_INIT=""
> > CONFIG_DEFAULT_HOSTNAME="(none)"
> > # CONFIG_SWAP is not set
> > # CONFIG_SYSVIPC is not set
> > # CONFIG_POSIX_MQUEUE is not set
> > # CONFIG_WATCH_QUEUE is not set
> > # CONFIG_CROSS_MEMORY_ATTACH is not set
> > CONFIG_USELIB=y
> > # CONFIG_AUDIT is not set
> > CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> > 
> > #
> > # IRQ subsystem
> > #
> > CONFIG_GENERIC_IRQ_PROBE=y
> > CONFIG_GENERIC_IRQ_SHOW=y
> > CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
> > CONFIG_GENERIC_PENDING_IRQ=y
> > CONFIG_GENERIC_IRQ_MIGRATION=y
> > CONFIG_HARDIRQS_SW_RESEND=y
> > CONFIG_GENERIC_IRQ_CHIP=y
> > CONFIG_IRQ_DOMAIN=y
> > CONFIG_IRQ_SIM=y
> > CONFIG_IRQ_DOMAIN_HIERARCHY=y
> > CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> > CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> > CONFIG_IRQ_FORCED_THREADING=y
> > CONFIG_SPARSE_IRQ=y
> > # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> > # end of IRQ subsystem
> > 
> > CONFIG_CLOCKSOURCE_WATCHDOG=y
> > CONFIG_ARCH_CLOCKSOURCE_INIT=y
> > CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> > CONFIG_GENERIC_TIME_VSYSCALL=y
> > CONFIG_GENERIC_CLOCKEVENTS=y
> > CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> > CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> > CONFIG_GENERIC_CMOS_UPDATE=y
> > CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
> > 
> > #
> > # Timers subsystem
> > #
> > CONFIG_TICK_ONESHOT=y
> > CONFIG_NO_HZ_COMMON=y
> > # CONFIG_HZ_PERIODIC is not set
> > CONFIG_NO_HZ_IDLE=y
> > # CONFIG_NO_HZ is not set
> > CONFIG_HIGH_RES_TIMERS=y
> > # end of Timers subsystem
> > 
> > # CONFIG_PREEMPT_NONE is not set
> > # CONFIG_PREEMPT_VOLUNTARY is not set
> > CONFIG_PREEMPT=y
> > CONFIG_PREEMPT_COUNT=y
> > CONFIG_PREEMPTION=y
> > 
> > #
> > # CPU/Task time and stats accounting
> > #
> > CONFIG_TICK_CPU_ACCOUNTING=y
> > # CONFIG_IRQ_TIME_ACCOUNTING is not set
> > # CONFIG_BSD_PROCESS_ACCT is not set
> > # CONFIG_TASKSTATS is not set
> > CONFIG_PSI=y
> > # CONFIG_PSI_DEFAULT_DISABLED is not set
> > # end of CPU/Task time and stats accounting
> > 
> > CONFIG_CPU_ISOLATION=y
> > 
> > #
> > # RCU Subsystem
> > #
> > CONFIG_TREE_RCU=y
> > CONFIG_PREEMPT_RCU=y
> > CONFIG_RCU_EXPERT=y
> > CONFIG_SRCU=y
> > CONFIG_TREE_SRCU=y
> > CONFIG_TASKS_RCU_GENERIC=y
> > CONFIG_TASKS_RCU=y
> > CONFIG_TASKS_RUDE_RCU=y
> > CONFIG_TASKS_TRACE_RCU=y
> > CONFIG_RCU_STALL_COMMON=y
> > CONFIG_RCU_NEED_SEGCBLIST=y
> > CONFIG_RCU_FANOUT=32
> > CONFIG_RCU_FANOUT_LEAF=2
> > # CONFIG_RCU_FAST_NO_HZ is not set
> > # CONFIG_RCU_BOOST is not set
> > # CONFIG_RCU_NOCB_CPU is not set
> > CONFIG_TASKS_TRACE_RCU_READ_MB=y
> > # end of RCU Subsystem
> > 
> > CONFIG_IKCONFIG=y
> > CONFIG_IKCONFIG_PROC=y
> > CONFIG_IKHEADERS=m
> > CONFIG_LOG_BUF_SHIFT=20
> > CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> > CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> > CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> > 
> > #
> > # Scheduler features
> > #
> > # end of Scheduler features
> > 
> > CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> > CONFIG_CGROUPS=y
> > # CONFIG_MEMCG is not set
> > # CONFIG_BLK_CGROUP is not set
> > CONFIG_CGROUP_SCHED=y
> > CONFIG_FAIR_GROUP_SCHED=y
> > CONFIG_CFS_BANDWIDTH=y
> > CONFIG_RT_GROUP_SCHED=y
> > # CONFIG_CGROUP_PIDS is not set
> > CONFIG_CGROUP_RDMA=y
> > CONFIG_CGROUP_FREEZER=y
> > # CONFIG_CGROUP_HUGETLB is not set
> > # CONFIG_CPUSETS is not set
> > CONFIG_CGROUP_DEVICE=y
> > # CONFIG_CGROUP_CPUACCT is not set
> > # CONFIG_CGROUP_PERF is not set
> > # CONFIG_CGROUP_DEBUG is not set
> > # CONFIG_NAMESPACES is not set
> > # CONFIG_CHECKPOINT_RESTORE is not set
> > # CONFIG_SCHED_AUTOGROUP is not set
> > # CONFIG_SYSFS_DEPRECATED is not set
> > CONFIG_RELAY=y
> > CONFIG_BLK_DEV_INITRD=y
> > CONFIG_INITRAMFS_SOURCE=""
> > CONFIG_RD_GZIP=y
> > CONFIG_RD_BZIP2=y
> > CONFIG_RD_LZMA=y
> > CONFIG_RD_XZ=y
> > CONFIG_RD_LZO=y
> > CONFIG_RD_LZ4=y
> > # CONFIG_RD_ZSTD is not set
> > CONFIG_BOOT_CONFIG=y
> > # CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
> > CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> > CONFIG_SYSCTL=y
> > CONFIG_HAVE_UID16=y
> > CONFIG_SYSCTL_EXCEPTION_TRACE=y
> > CONFIG_HAVE_PCSPKR_PLATFORM=y
> > CONFIG_BPF=y
> > CONFIG_EXPERT=y
> > CONFIG_UID16=y
> > CONFIG_MULTIUSER=y
> > CONFIG_SGETMASK_SYSCALL=y
> > # CONFIG_SYSFS_SYSCALL is not set
> > CONFIG_FHANDLE=y
> > # CONFIG_POSIX_TIMERS is not set
> > CONFIG_PRINTK=y
> > CONFIG_PRINTK_NMI=y
> > CONFIG_BUG=y
> > CONFIG_ELF_CORE=y
> > CONFIG_PCSPKR_PLATFORM=y
> > CONFIG_BASE_FULL=y
> > CONFIG_FUTEX=y
> > CONFIG_FUTEX_PI=y
> > CONFIG_EPOLL=y
> > CONFIG_SIGNALFD=y
> > CONFIG_TIMERFD=y
> > # CONFIG_EVENTFD is not set
> > CONFIG_SHMEM=y
> > CONFIG_AIO=y
> > CONFIG_IO_URING=y
> > CONFIG_ADVISE_SYSCALLS=y
> > CONFIG_MEMBARRIER=y
> > CONFIG_KALLSYMS=y
> > CONFIG_KALLSYMS_ALL=y
> > CONFIG_KALLSYMS_BASE_RELATIVE=y
> > # CONFIG_BPF_SYSCALL is not set
> > CONFIG_USERFAULTFD=y
> > CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> > CONFIG_RSEQ=y
> > CONFIG_DEBUG_RSEQ=y
> > CONFIG_EMBEDDED=y
> > CONFIG_HAVE_PERF_EVENTS=y
> > CONFIG_PC104=y
> > 
> > #
> > # Kernel Performance Events And Counters
> > #
> > CONFIG_PERF_EVENTS=y
> > # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> > # end of Kernel Performance Events And Counters
> > 
> > # CONFIG_VM_EVENT_COUNTERS is not set
> > # CONFIG_SLUB_DEBUG is not set
> > # CONFIG_COMPAT_BRK is not set
> > # CONFIG_SLAB is not set
> > CONFIG_SLUB=y
> > # CONFIG_SLOB is not set
> > CONFIG_SLAB_MERGE_DEFAULT=y
> > # CONFIG_SLAB_FREELIST_RANDOM is not set
> > # CONFIG_SLAB_FREELIST_HARDENED is not set
> > CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
> > # CONFIG_SLUB_CPU_PARTIAL is not set
> > CONFIG_SYSTEM_DATA_VERIFICATION=y
> > CONFIG_PROFILING=y
> > CONFIG_TRACEPOINTS=y
> > # end of General setup
> > 
> > CONFIG_X86_32=y
> > CONFIG_FORCE_DYNAMIC_FTRACE=y
> > CONFIG_X86=y
> > CONFIG_INSTRUCTION_DECODER=y
> > CONFIG_OUTPUT_FORMAT="elf32-i386"
> > CONFIG_LOCKDEP_SUPPORT=y
> > CONFIG_STACKTRACE_SUPPORT=y
> > CONFIG_MMU=y
> > CONFIG_ARCH_MMAP_RND_BITS_MIN=8
> > CONFIG_ARCH_MMAP_RND_BITS_MAX=16
> > CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> > CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> > CONFIG_GENERIC_ISA_DMA=y
> > CONFIG_GENERIC_BUG=y
> > CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> > CONFIG_GENERIC_CALIBRATE_DELAY=y
> > CONFIG_ARCH_HAS_CPU_RELAX=y
> > CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> > CONFIG_ARCH_HAS_FILTER_PGPROT=y
> > CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> > CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> > CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> > CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> > CONFIG_ARCH_SUSPEND_POSSIBLE=y
> > CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> > CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> > CONFIG_X86_32_SMP=y
> > CONFIG_ARCH_SUPPORTS_UPROBES=y
> > CONFIG_FIX_EARLYCON_MEM=y
> > CONFIG_PGTABLE_LEVELS=2
> > CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> > 
> > #
> > # Processor type and features
> > #
> > CONFIG_ZONE_DMA=y
> > CONFIG_SMP=y
> > CONFIG_X86_FEATURE_NAMES=y
> > CONFIG_X86_MPPARSE=y
> > CONFIG_GOLDFISH=y
> > CONFIG_RETPOLINE=y
> > CONFIG_X86_CPU_RESCTRL=y
> > CONFIG_X86_BIGSMP=y
> > CONFIG_X86_EXTENDED_PLATFORM=y
> > # CONFIG_X86_GOLDFISH is not set
> > # CONFIG_X86_INTEL_LPSS is not set
> > # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> > CONFIG_IOSF_MBI=m
> > # CONFIG_IOSF_MBI_DEBUG is not set
> > CONFIG_X86_RDC321X=y
> > CONFIG_X86_32_NON_STANDARD=y
> > # CONFIG_STA2X11 is not set
> > CONFIG_X86_32_IRIS=y
> > # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> > CONFIG_HYPERVISOR_GUEST=y
> > CONFIG_PARAVIRT=y
> > # CONFIG_PARAVIRT_DEBUG is not set
> > # CONFIG_PARAVIRT_SPINLOCKS is not set
> > CONFIG_X86_HV_CALLBACK_VECTOR=y
> > CONFIG_KVM_GUEST=y
> > CONFIG_ARCH_CPUIDLE_HALTPOLL=y
> > # CONFIG_PVH is not set
> > # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> > CONFIG_PARAVIRT_CLOCK=y
> > CONFIG_M486SX=y
> > # CONFIG_M486 is not set
> > # CONFIG_M586 is not set
> > # CONFIG_M586TSC is not set
> > # CONFIG_M586MMX is not set
> > # CONFIG_M686 is not set
> > # CONFIG_MPENTIUMII is not set
> > # CONFIG_MPENTIUMIII is not set
> > # CONFIG_MPENTIUMM is not set
> > # CONFIG_MPENTIUM4 is not set
> > # CONFIG_MK6 is not set
> > # CONFIG_MK7 is not set
> > # CONFIG_MK8 is not set
> > # CONFIG_MCRUSOE is not set
> > # CONFIG_MEFFICEON is not set
> > # CONFIG_MWINCHIPC6 is not set
> > # CONFIG_MWINCHIP3D is not set
> > # CONFIG_MELAN is not set
> > # CONFIG_MGEODEGX1 is not set
> > # CONFIG_MGEODE_LX is not set
> > # CONFIG_MCYRIXIII is not set
> > # CONFIG_MVIAC3_2 is not set
> > # CONFIG_MVIAC7 is not set
> > # CONFIG_MCORE2 is not set
> > # CONFIG_MATOM is not set
> > CONFIG_X86_GENERIC=y
> > CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> > CONFIG_X86_L1_CACHE_SHIFT=6
> > CONFIG_X86_F00F_BUG=y
> > CONFIG_X86_INVD_BUG=y
> > CONFIG_X86_ALIGNMENT_16=y
> > CONFIG_X86_INTEL_USERCOPY=y
> > CONFIG_X86_MINIMUM_CPU_FAMILY=4
> > CONFIG_IA32_FEAT_CTL=y
> > CONFIG_X86_VMX_FEATURE_NAMES=y
> > CONFIG_PROCESSOR_SELECT=y
> > CONFIG_CPU_SUP_INTEL=y
> > # CONFIG_CPU_SUP_CYRIX_32 is not set
> > CONFIG_CPU_SUP_AMD=y
> > # CONFIG_CPU_SUP_HYGON is not set
> > CONFIG_CPU_SUP_CENTAUR=y
> > # CONFIG_CPU_SUP_TRANSMETA_32 is not set
> > CONFIG_CPU_SUP_UMC_32=y
> > CONFIG_CPU_SUP_ZHAOXIN=y
> > CONFIG_HPET_TIMER=y
> > CONFIG_HPET_EMULATE_RTC=y
> > CONFIG_DMI=y
> > CONFIG_NR_CPUS_RANGE_BEGIN=2
> > CONFIG_NR_CPUS_RANGE_END=64
> > CONFIG_NR_CPUS_DEFAULT=32
> > CONFIG_NR_CPUS=32
> > CONFIG_SCHED_SMT=y
> > # CONFIG_SCHED_MC is not set
> > CONFIG_X86_LOCAL_APIC=y
> > CONFIG_X86_IO_APIC=y
> > # CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
> > # CONFIG_X86_MCE is not set
> > 
> > #
> > # Performance monitoring
> > #
> > CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> > CONFIG_PERF_EVENTS_INTEL_RAPL=y
> > CONFIG_PERF_EVENTS_INTEL_CSTATE=y
> > CONFIG_PERF_EVENTS_AMD_POWER=m
> > # end of Performance monitoring
> > 
> > CONFIG_X86_LEGACY_VM86=y
> > CONFIG_VM86=y
> > # CONFIG_X86_16BIT is not set
> > CONFIG_X86_IOPL_IOPERM=y
> > CONFIG_TOSHIBA=y
> > CONFIG_I8K=m
> > CONFIG_X86_REBOOTFIXUPS=y
> > # CONFIG_MICROCODE is not set
> > CONFIG_X86_MSR=y
> > # CONFIG_X86_CPUID is not set
> > CONFIG_NOHIGHMEM=y
> > # CONFIG_HIGHMEM4G is not set
> > # CONFIG_HIGHMEM64G is not set
> > # CONFIG_VMSPLIT_3G is not set
> > # CONFIG_VMSPLIT_3G_OPT is not set
> > # CONFIG_VMSPLIT_2G is not set
> > # CONFIG_VMSPLIT_2G_OPT is not set
> > CONFIG_VMSPLIT_1G=y
> > CONFIG_PAGE_OFFSET=0x40000000
> > # CONFIG_X86_PAE is not set
> > CONFIG_X86_CPA_STATISTICS=y
> > CONFIG_ARCH_FLATMEM_ENABLE=y
> > CONFIG_ARCH_SPARSEMEM_ENABLE=y
> > CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> > CONFIG_ILLEGAL_POINTER_VALUE=0
> > CONFIG_X86_CHECK_BIOS_CORRUPTION=y
> > CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
> > CONFIG_X86_RESERVE_LOW=64
> > CONFIG_MATH_EMULATION=y
> > CONFIG_MTRR=y
> > CONFIG_MTRR_SANITIZER=y
> > CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
> > CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
> > CONFIG_X86_PAT=y
> > CONFIG_ARCH_USES_PG_UNCACHED=y
> > # CONFIG_ARCH_RANDOM is not set
> > CONFIG_X86_SMAP=y
> > # CONFIG_X86_UMIP is not set
> > # CONFIG_X86_INTEL_TSX_MODE_OFF is not set
> > # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> > CONFIG_X86_INTEL_TSX_MODE_AUTO=y
> > # CONFIG_EFI is not set
> > # CONFIG_SECCOMP is not set
> > # CONFIG_HZ_100 is not set
> > # CONFIG_HZ_250 is not set
> > # CONFIG_HZ_300 is not set
> > CONFIG_HZ_1000=y
> > CONFIG_HZ=1000
> > CONFIG_SCHED_HRTICK=y
> > CONFIG_KEXEC=y
> > CONFIG_PHYSICAL_START=0x1000000
> > # CONFIG_RELOCATABLE is not set
> > CONFIG_PHYSICAL_ALIGN=0x200000
> > CONFIG_HOTPLUG_CPU=y
> > CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
> > CONFIG_DEBUG_HOTPLUG_CPU0=y
> > CONFIG_COMPAT_VDSO=y
> > # CONFIG_CMDLINE_BOOL is not set
> > CONFIG_MODIFY_LDT_SYSCALL=y
> > # end of Processor type and features
> > 
> > #
> > # Power management and ACPI options
> > #
> > # CONFIG_SUSPEND is not set
> > # CONFIG_PM is not set
> > CONFIG_ARCH_SUPPORTS_ACPI=y
> > CONFIG_ACPI=y
> > CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> > CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> > CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> > # CONFIG_ACPI_DEBUGGER is not set
> > CONFIG_ACPI_SPCR_TABLE=y
> > CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
> > # CONFIG_ACPI_EC_DEBUGFS is not set
> > CONFIG_ACPI_AC=y
> > CONFIG_ACPI_BATTERY=y
> > CONFIG_ACPI_BUTTON=y
> > CONFIG_ACPI_FAN=y
> > # CONFIG_ACPI_DOCK is not set
> > CONFIG_ACPI_CPU_FREQ_PSS=y
> > CONFIG_ACPI_PROCESSOR_CSTATE=y
> > CONFIG_ACPI_PROCESSOR_IDLE=y
> > CONFIG_ACPI_PROCESSOR=y
> > CONFIG_ACPI_HOTPLUG_CPU=y
> > # CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
> > CONFIG_ACPI_THERMAL=y
> > CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> > CONFIG_ACPI_TABLE_UPGRADE=y
> > # CONFIG_ACPI_DEBUG is not set
> > # CONFIG_ACPI_PCI_SLOT is not set
> > CONFIG_ACPI_CONTAINER=y
> > CONFIG_ACPI_HOTPLUG_IOAPIC=y
> > # CONFIG_ACPI_SBS is not set
> > # CONFIG_ACPI_HED is not set
> > # CONFIG_ACPI_CUSTOM_METHOD is not set
> > # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> > CONFIG_HAVE_ACPI_APEI=y
> > CONFIG_HAVE_ACPI_APEI_NMI=y
> > # CONFIG_ACPI_APEI is not set
> > # CONFIG_DPTF_POWER is not set
> > # CONFIG_PMIC_OPREGION is not set
> > # CONFIG_ACPI_CONFIGFS is not set
> > CONFIG_X86_PM_TIMER=y
> > CONFIG_SFI=y
> > 
> > #
> > # CPU Frequency scaling
> > #
> > # CONFIG_CPU_FREQ is not set
> > # end of CPU Frequency scaling
> > 
> > #
> > # CPU Idle
> > #
> > CONFIG_CPU_IDLE=y
> > # CONFIG_CPU_IDLE_GOV_LADDER is not set
> > CONFIG_CPU_IDLE_GOV_MENU=y
> > # CONFIG_CPU_IDLE_GOV_TEO is not set
> > # CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
> > CONFIG_HALTPOLL_CPUIDLE=y
> > # end of CPU Idle
> > 
> > # CONFIG_INTEL_IDLE is not set
> > # end of Power management and ACPI options
> > 
> > #
> > # Bus options (PCI etc.)
> > #
> > # CONFIG_PCI_GOBIOS is not set
> > # CONFIG_PCI_GOMMCONFIG is not set
> > # CONFIG_PCI_GODIRECT is not set
> > # CONFIG_PCI_GOOLPC is not set
> > CONFIG_PCI_GOANY=y
> > CONFIG_PCI_BIOS=y
> > CONFIG_PCI_DIRECT=y
> > CONFIG_PCI_MMCONFIG=y
> > CONFIG_PCI_OLPC=y
> > # CONFIG_PCI_CNB20LE_QUIRK is not set
> > # CONFIG_ISA_BUS is not set
> > CONFIG_ISA_DMA_API=y
> > # CONFIG_ISA is not set
> > # CONFIG_SCx200 is not set
> > CONFIG_OLPC=y
> > # CONFIG_OLPC_XO15_SCI is not set
> > # CONFIG_ALIX is not set
> > # CONFIG_NET5501 is not set
> > # CONFIG_GEOS is not set
> > CONFIG_AMD_NB=y
> > CONFIG_X86_SYSFB=y
> > # end of Bus options (PCI etc.)
> > 
> > #
> > # Binary Emulations
> > #
> > CONFIG_COMPAT_32=y
> > # end of Binary Emulations
> > 
> > CONFIG_HAVE_ATOMIC_IOMAP=y
> > 
> > #
> > # Firmware Drivers
> > #
> > CONFIG_EDD=y
> > # CONFIG_EDD_OFF is not set
> > CONFIG_FIRMWARE_MEMMAP=y
> > CONFIG_DMIID=y
> > CONFIG_DMI_SYSFS=y
> > CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> > # CONFIG_ISCSI_IBFT is not set
> > CONFIG_FW_CFG_SYSFS=m
> > CONFIG_FW_CFG_SYSFS_CMDLINE=y
> > # CONFIG_GOOGLE_FIRMWARE is not set
> > CONFIG_EFI_EARLYCON=y
> > 
> > #
> > # Tegra firmware driver
> > #
> > # end of Tegra firmware driver
> > # end of Firmware Drivers
> > 
> > CONFIG_HAVE_KVM=y
> > # CONFIG_VIRTUALIZATION is not set
> > CONFIG_AS_AVX512=y
> > CONFIG_AS_SHA1_NI=y
> > CONFIG_AS_SHA256_NI=y
> > CONFIG_AS_TPAUSE=y
> > 
> > #
> > # General architecture-dependent options
> > #
> > CONFIG_CRASH_CORE=y
> > CONFIG_KEXEC_CORE=y
> > CONFIG_HOTPLUG_SMT=y
> > CONFIG_GENERIC_ENTRY=y
> > CONFIG_OPROFILE=m
> > # CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
> > CONFIG_HAVE_OPROFILE=y
> > CONFIG_OPROFILE_NMI_TIMER=y
> > CONFIG_KPROBES=y
> > CONFIG_JUMP_LABEL=y
> > # CONFIG_STATIC_KEYS_SELFTEST is not set
> > CONFIG_OPTPROBES=y
> > CONFIG_KPROBES_ON_FTRACE=y
> > CONFIG_UPROBES=y
> > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> > CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> > CONFIG_KRETPROBES=y
> > CONFIG_HAVE_IOREMAP_PROT=y
> > CONFIG_HAVE_KPROBES=y
> > CONFIG_HAVE_KRETPROBES=y
> > CONFIG_HAVE_OPTPROBES=y
> > CONFIG_HAVE_KPROBES_ON_FTRACE=y
> > CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> > CONFIG_HAVE_NMI=y
> > CONFIG_HAVE_ARCH_TRACEHOOK=y
> > CONFIG_HAVE_DMA_CONTIGUOUS=y
> > CONFIG_GENERIC_SMP_IDLE_THREAD=y
> > CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> > CONFIG_ARCH_HAS_SET_MEMORY=y
> > CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
> > CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> > CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> > CONFIG_ARCH_32BIT_OFF_T=y
> > CONFIG_HAVE_ASM_MODVERSIONS=y
> > CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> > CONFIG_HAVE_RSEQ=y
> > CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
> > CONFIG_HAVE_HW_BREAKPOINT=y
> > CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> > CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> > CONFIG_HAVE_PERF_EVENTS_NMI=y
> > CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> > CONFIG_HAVE_PERF_REGS=y
> > CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> > CONFIG_HAVE_ARCH_JUMP_LABEL=y
> > CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
> > CONFIG_MMU_GATHER_TABLE_FREE=y
> > CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> > CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> > CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
> > CONFIG_HAVE_CMPXCHG_LOCAL=y
> > CONFIG_HAVE_CMPXCHG_DOUBLE=y
> > CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
> > CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> > CONFIG_HAVE_ARCH_STACKLEAK=y
> > CONFIG_HAVE_STACKPROTECTOR=y
> > CONFIG_STACKPROTECTOR=y
> > CONFIG_STACKPROTECTOR_STRONG=y
> > CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> > CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> > CONFIG_HAVE_MOVE_PMD=y
> > CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> > CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> > CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> > CONFIG_MODULES_USE_ELF_REL=y
> > CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> > CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> > CONFIG_HAVE_EXIT_THREAD=y
> > CONFIG_ARCH_MMAP_RND_BITS=8
> > CONFIG_ISA_BUS_API=y
> > CONFIG_CLONE_BACKWARDS=y
> > CONFIG_OLD_SIGSUSPEND3=y
> > CONFIG_OLD_SIGACTION=y
> > CONFIG_COMPAT_32BIT_TIME=y
> > CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> > CONFIG_STRICT_KERNEL_RWX=y
> > CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> > CONFIG_STRICT_MODULE_RWX=y
> > CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
> > CONFIG_ARCH_USE_MEMREMAP_PROT=y
> > CONFIG_LOCK_EVENT_COUNTS=y
> > CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> > 
> > #
> > # GCOV-based kernel profiling
> > #
> > CONFIG_GCOV_KERNEL=y
> > CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> > # CONFIG_GCOV_PROFILE_ALL is not set
> > # end of GCOV-based kernel profiling
> > 
> > CONFIG_HAVE_GCC_PLUGINS=y
> > # end of General architecture-dependent options
> > 
> > CONFIG_RT_MUTEXES=y
> > CONFIG_BASE_SMALL=0
> > CONFIG_MODULES=y
> > CONFIG_MODULE_FORCE_LOAD=y
> > CONFIG_MODULE_UNLOAD=y
> > CONFIG_MODULE_FORCE_UNLOAD=y
> > # CONFIG_MODVERSIONS is not set
> > # CONFIG_MODULE_SRCVERSION_ALL is not set
> > # CONFIG_MODULE_SIG is not set
> > # CONFIG_MODULE_COMPRESS is not set
> > CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
> > CONFIG_UNUSED_SYMBOLS=y
> > CONFIG_MODULES_TREE_LOOKUP=y
> > CONFIG_BLOCK=y
> > CONFIG_BLK_SCSI_REQUEST=y
> > CONFIG_BLK_DEV_BSG=y
> > CONFIG_BLK_DEV_BSGLIB=y
> > CONFIG_BLK_DEV_INTEGRITY=y
> > CONFIG_BLK_DEV_INTEGRITY_T10=y
> > # CONFIG_BLK_DEV_ZONED is not set
> > CONFIG_BLK_CMDLINE_PARSER=y
> > # CONFIG_BLK_WBT is not set
> > # CONFIG_BLK_DEBUG_FS is not set
> > CONFIG_BLK_SED_OPAL=y
> > # CONFIG_BLK_INLINE_ENCRYPTION is not set
> > 
> > #
> > # Partition Types
> > #
> > CONFIG_PARTITION_ADVANCED=y
> > # CONFIG_ACORN_PARTITION is not set
> > # CONFIG_AIX_PARTITION is not set
> > CONFIG_OSF_PARTITION=y
> > # CONFIG_AMIGA_PARTITION is not set
> > # CONFIG_ATARI_PARTITION is not set
> > CONFIG_MAC_PARTITION=y
> > # CONFIG_MSDOS_PARTITION is not set
> > CONFIG_LDM_PARTITION=y
> > CONFIG_LDM_DEBUG=y
> > CONFIG_SGI_PARTITION=y
> > # CONFIG_ULTRIX_PARTITION is not set
> > # CONFIG_SUN_PARTITION is not set
> > # CONFIG_KARMA_PARTITION is not set
> > CONFIG_EFI_PARTITION=y
> > # CONFIG_SYSV68_PARTITION is not set
> > CONFIG_CMDLINE_PARTITION=y
> > # end of Partition Types
> > 
> > CONFIG_BLK_MQ_PCI=y
> > CONFIG_BLK_MQ_VIRTIO=y
> > 
> > #
> > # IO Schedulers
> > #
> > CONFIG_MQ_IOSCHED_DEADLINE=m
> > CONFIG_MQ_IOSCHED_KYBER=y
> > # CONFIG_IOSCHED_BFQ is not set
> > # end of IO Schedulers
> > 
> > CONFIG_PADATA=y
> > CONFIG_ASN1=y
> > CONFIG_UNINLINE_SPIN_UNLOCK=y
> > CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> > CONFIG_MUTEX_SPIN_ON_OWNER=y
> > CONFIG_RWSEM_SPIN_ON_OWNER=y
> > CONFIG_LOCK_SPIN_ON_OWNER=y
> > CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> > CONFIG_QUEUED_SPINLOCKS=y
> > CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> > CONFIG_QUEUED_RWLOCKS=y
> > CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
> > CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> > CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> > CONFIG_FREEZER=y
> > 
> > #
> > # Executable file formats
> > #
> > CONFIG_BINFMT_ELF=y
> > CONFIG_ELFCORE=y
> > # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> > CONFIG_BINFMT_SCRIPT=y
> > CONFIG_BINFMT_MISC=y
> > CONFIG_COREDUMP=y
> > # end of Executable file formats
> > 
> > #
> > # Memory Management options
> > #
> > CONFIG_SELECT_MEMORY_MODEL=y
> > # CONFIG_FLATMEM_MANUAL is not set
> > CONFIG_SPARSEMEM_MANUAL=y
> > CONFIG_SPARSEMEM=y
> > CONFIG_SPARSEMEM_STATIC=y
> > CONFIG_HAVE_FAST_GUP=y
> > CONFIG_MEMORY_ISOLATION=y
> > CONFIG_SPLIT_PTLOCK_CPUS=4
> > CONFIG_COMPACTION=y
> > # CONFIG_PAGE_REPORTING is not set
> > CONFIG_MIGRATION=y
> > CONFIG_CONTIG_ALLOC=y
> > # CONFIG_BOUNCE is not set
> > CONFIG_VIRT_TO_BUS=y
> > # CONFIG_KSM is not set
> > CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> > CONFIG_TRANSPARENT_HUGEPAGE=y
> > # CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
> > CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
> > CONFIG_CLEANCACHE=y
> > CONFIG_CMA=y
> > # CONFIG_CMA_DEBUG is not set
> > # CONFIG_CMA_DEBUGFS is not set
> > CONFIG_CMA_AREAS=7
> > CONFIG_ZPOOL=y
> > # CONFIG_ZBUD is not set
> > # CONFIG_Z3FOLD is not set
> > CONFIG_ZSMALLOC=m
> > # CONFIG_ZSMALLOC_STAT is not set
> > CONFIG_GENERIC_EARLY_IOREMAP=y
> > # CONFIG_IDLE_PAGE_TRACKING is not set
> > CONFIG_PERCPU_STATS=y
> > CONFIG_GUP_BENCHMARK=y
> > # CONFIG_READ_ONLY_THP_FOR_FS is not set
> > CONFIG_ARCH_HAS_PTE_SPECIAL=y
> > # end of Memory Management options
> > 
> > CONFIG_NET=y
> > 
> > #
> > # Networking options
> > #
> > # CONFIG_PACKET is not set
> > CONFIG_UNIX=y
> > CONFIG_UNIX_SCM=y
> > # CONFIG_UNIX_DIAG is not set
> > # CONFIG_TLS is not set
> > # CONFIG_XFRM_USER is not set
> > # CONFIG_NET_KEY is not set
> > CONFIG_INET=y
> > # CONFIG_IP_MULTICAST is not set
> > # CONFIG_IP_ADVANCED_ROUTER is not set
> > CONFIG_IP_PNP=y
> > CONFIG_IP_PNP_DHCP=y
> > # CONFIG_IP_PNP_BOOTP is not set
> > # CONFIG_IP_PNP_RARP is not set
> > # CONFIG_NET_IPIP is not set
> > # CONFIG_NET_IPGRE_DEMUX is not set
> > CONFIG_NET_IP_TUNNEL=y
> > # CONFIG_SYN_COOKIES is not set
> > # CONFIG_NET_IPVTI is not set
> > # CONFIG_NET_FOU is not set
> > # CONFIG_NET_FOU_IP_TUNNELS is not set
> > # CONFIG_INET_AH is not set
> > # CONFIG_INET_ESP is not set
> > # CONFIG_INET_IPCOMP is not set
> > CONFIG_INET_TUNNEL=y
> > CONFIG_INET_DIAG=y
> > CONFIG_INET_TCP_DIAG=y
> > # CONFIG_INET_UDP_DIAG is not set
> > # CONFIG_INET_RAW_DIAG is not set
> > # CONFIG_INET_DIAG_DESTROY is not set
> > # CONFIG_TCP_CONG_ADVANCED is not set
> > CONFIG_TCP_CONG_CUBIC=y
> > CONFIG_DEFAULT_TCP_CONG="cubic"
> > # CONFIG_TCP_MD5SIG is not set
> > CONFIG_IPV6=y
> > # CONFIG_IPV6_ROUTER_PREF is not set
> > # CONFIG_IPV6_OPTIMISTIC_DAD is not set
> > # CONFIG_INET6_AH is not set
> > # CONFIG_INET6_ESP is not set
> > # CONFIG_INET6_IPCOMP is not set
> > # CONFIG_IPV6_MIP6 is not set
> > # CONFIG_IPV6_VTI is not set
> > CONFIG_IPV6_SIT=y
> > # CONFIG_IPV6_SIT_6RD is not set
> > CONFIG_IPV6_NDISC_NODETYPE=y
> > # CONFIG_IPV6_TUNNEL is not set
> > # CONFIG_IPV6_MULTIPLE_TABLES is not set
> > # CONFIG_IPV6_MROUTE is not set
> > # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> > # CONFIG_IPV6_SEG6_HMAC is not set
> > # CONFIG_IPV6_RPL_LWTUNNEL is not set
> > # CONFIG_MPTCP is not set
> > # CONFIG_MPTCP_KUNIT_TESTS is not set
> > # CONFIG_NETWORK_SECMARK is not set
> > # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> > # CONFIG_NETFILTER is not set
> > # CONFIG_BPFILTER is not set
> > # CONFIG_IP_DCCP is not set
> > # CONFIG_IP_SCTP is not set
> > # CONFIG_RDS is not set
> > # CONFIG_TIPC is not set
> > # CONFIG_ATM is not set
> > # CONFIG_L2TP is not set
> > # CONFIG_BRIDGE is not set
> > CONFIG_HAVE_NET_DSA=y
> > # CONFIG_NET_DSA is not set
> > # CONFIG_VLAN_8021Q is not set
> > # CONFIG_DECNET is not set
> > # CONFIG_LLC2 is not set
> > # CONFIG_ATALK is not set
> > # CONFIG_X25 is not set
> > # CONFIG_LAPB is not set
> > # CONFIG_PHONET is not set
> > # CONFIG_6LOWPAN is not set
> > # CONFIG_IEEE802154 is not set
> > # CONFIG_NET_SCHED is not set
> > # CONFIG_DCB is not set
> > CONFIG_DNS_RESOLVER=m
> > # CONFIG_BATMAN_ADV is not set
> > # CONFIG_OPENVSWITCH is not set
> > # CONFIG_VSOCKETS is not set
> > # CONFIG_NETLINK_DIAG is not set
> > # CONFIG_MPLS is not set
> > # CONFIG_NET_NSH is not set
> > # CONFIG_HSR is not set
> > # CONFIG_NET_SWITCHDEV is not set
> > # CONFIG_NET_L3_MASTER_DEV is not set
> > # CONFIG_QRTR is not set
> > # CONFIG_NET_NCSI is not set
> > CONFIG_RPS=y
> > CONFIG_RFS_ACCEL=y
> > CONFIG_XPS=y
> > # CONFIG_CGROUP_NET_PRIO is not set
> > # CONFIG_CGROUP_NET_CLASSID is not set
> > CONFIG_NET_RX_BUSY_POLL=y
> > CONFIG_BQL=y
> > # CONFIG_BPF_JIT is not set
> > CONFIG_NET_FLOW_LIMIT=y
> > 
> > #
> > # Network testing
> > #
> > # CONFIG_NET_PKTGEN is not set
> > # CONFIG_NET_DROP_MONITOR is not set
> > # end of Network testing
> > # end of Networking options
> > 
> > # CONFIG_HAMRADIO is not set
> > # CONFIG_CAN is not set
> > # CONFIG_BT is not set
> > # CONFIG_AF_RXRPC is not set
> > # CONFIG_AF_KCM is not set
> > CONFIG_WIRELESS=y
> > # CONFIG_CFG80211 is not set
> > 
> > #
> > # CFG80211 needs to be enabled for MAC80211
> > #
> > CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> > # CONFIG_WIMAX is not set
> > # CONFIG_RFKILL is not set
> > CONFIG_NET_9P=y
> > CONFIG_NET_9P_VIRTIO=y
> > # CONFIG_NET_9P_DEBUG is not set
> > # CONFIG_CAIF is not set
> > # CONFIG_CEPH_LIB is not set
> > # CONFIG_NFC is not set
> > # CONFIG_PSAMPLE is not set
> > # CONFIG_NET_IFE is not set
> > # CONFIG_LWTUNNEL is not set
> > CONFIG_DST_CACHE=y
> > CONFIG_GRO_CELLS=y
> > # CONFIG_FAILOVER is not set
> > CONFIG_ETHTOOL_NETLINK=y
> > CONFIG_HAVE_EBPF_JIT=y
> > 
> > #
> > # Device Drivers
> > #
> > CONFIG_HAVE_EISA=y
> > # CONFIG_EISA is not set
> > CONFIG_HAVE_PCI=y
> > CONFIG_PCI=y
> > CONFIG_PCI_DOMAINS=y
> > # CONFIG_PCIEPORTBUS is not set
> > CONFIG_PCIEASPM=y
> > CONFIG_PCIEASPM_DEFAULT=y
> > # CONFIG_PCIEASPM_POWERSAVE is not set
> > # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> > # CONFIG_PCIEASPM_PERFORMANCE is not set
> > # CONFIG_PCIE_PTM is not set
> > # CONFIG_PCI_MSI is not set
> > CONFIG_PCI_QUIRKS=y
> > # CONFIG_PCI_DEBUG is not set
> > # CONFIG_PCI_STUB is not set
> > CONFIG_PCI_LOCKLESS_CONFIG=y
> > # CONFIG_PCI_IOV is not set
> > # CONFIG_PCI_PRI is not set
> > # CONFIG_PCI_PASID is not set
> > CONFIG_PCI_LABEL=y
> > # CONFIG_HOTPLUG_PCI is not set
> > 
> > #
> > # PCI controller drivers
> > #
> > # CONFIG_PCI_FTPCI100 is not set
> > # CONFIG_PCI_HOST_GENERIC is not set
> > # CONFIG_PCIE_XILINX is not set
> > 
> > #
> > # DesignWare PCI Core Support
> > #
> > # end of DesignWare PCI Core Support
> > 
> > #
> > # Mobiveil PCIe Core Support
> > #
> > # end of Mobiveil PCIe Core Support
> > 
> > #
> > # Cadence PCIe controllers support
> > #
> > # CONFIG_PCIE_CADENCE_PLAT_HOST is not set
> > # CONFIG_PCI_J721E_HOST is not set
> > # end of Cadence PCIe controllers support
> > # end of PCI controller drivers
> > 
> > #
> > # PCI Endpoint
> > #
> > # CONFIG_PCI_ENDPOINT is not set
> > # end of PCI Endpoint
> > 
> > #
> > # PCI switch controller drivers
> > #
> > # CONFIG_PCI_SW_SWITCHTEC is not set
> > # end of PCI switch controller drivers
> > 
> > CONFIG_PCCARD=y
> > # CONFIG_PCMCIA is not set
> > CONFIG_CARDBUS=y
> > 
> > #
> > # PC-card bridges
> > #
> > # CONFIG_YENTA is not set
> > # CONFIG_RAPIDIO is not set
> > 
> > #
> > # Generic Driver Options
> > #
> > # CONFIG_UEVENT_HELPER is not set
> > CONFIG_DEVTMPFS=y
> > # CONFIG_DEVTMPFS_MOUNT is not set
> > CONFIG_STANDALONE=y
> > # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> > 
> > #
> > # Firmware loader
> > #
> > CONFIG_FW_LOADER=y
> > CONFIG_FW_LOADER_PAGED_BUF=y
> > CONFIG_EXTRA_FIRMWARE=""
> > CONFIG_FW_LOADER_USER_HELPER=y
> > CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
> > # CONFIG_FW_LOADER_COMPRESS is not set
> > # end of Firmware loader
> > 
> > CONFIG_WANT_DEV_COREDUMP=y
> > # CONFIG_ALLOW_DEV_COREDUMP is not set
> > # CONFIG_DEBUG_DRIVER is not set
> > # CONFIG_DEBUG_DEVRES is not set
> > # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> > # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> > CONFIG_GENERIC_CPU_AUTOPROBE=y
> > CONFIG_GENERIC_CPU_VULNERABILITIES=y
> > CONFIG_REGMAP=y
> > CONFIG_REGMAP_SPMI=m
> > CONFIG_REGMAP_MMIO=y
> > CONFIG_REGMAP_IRQ=y
> > CONFIG_REGMAP_SOUNDWIRE=m
> > CONFIG_DMA_SHARED_BUFFER=y
> > CONFIG_DMA_FENCE_TRACE=y
> > # end of Generic Driver Options
> > 
> > #
> > # Bus devices
> > #
> > CONFIG_MHI_BUS=m
> > # end of Bus devices
> > 
> > # CONFIG_CONNECTOR is not set
> > # CONFIG_GNSS is not set
> > CONFIG_MTD=y
> > CONFIG_MTD_TESTS=m
> > 
> > #
> > # Partition parsers
> > #
> > CONFIG_MTD_AR7_PARTS=m
> > CONFIG_MTD_CMDLINE_PARTS=y
> > CONFIG_MTD_OF_PARTS=m
> > CONFIG_MTD_REDBOOT_PARTS=y
> > CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
> > CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
> > CONFIG_MTD_REDBOOT_PARTS_READONLY=y
> > # end of Partition parsers
> > 
> > #
> > # User Modules And Translation Layers
> > #
> > CONFIG_MTD_BLKDEVS=y
> > # CONFIG_MTD_BLOCK is not set
> > # CONFIG_MTD_BLOCK_RO is not set
> > CONFIG_FTL=y
> > CONFIG_NFTL=m
> > # CONFIG_NFTL_RW is not set
> > CONFIG_INFTL=y
> > CONFIG_RFD_FTL=y
> > CONFIG_SSFDC=y
> > # CONFIG_SM_FTL is not set
> > CONFIG_MTD_OOPS=y
> > # CONFIG_MTD_PARTITIONED_MASTER is not set
> > 
> > #
> > # RAM/ROM/Flash chip drivers
> > #
> > CONFIG_MTD_CFI=y
> > CONFIG_MTD_JEDECPROBE=y
> > CONFIG_MTD_GEN_PROBE=y
> > # CONFIG_MTD_CFI_ADV_OPTIONS is not set
> > CONFIG_MTD_MAP_BANK_WIDTH_1=y
> > CONFIG_MTD_MAP_BANK_WIDTH_2=y
> > CONFIG_MTD_MAP_BANK_WIDTH_4=y
> > CONFIG_MTD_CFI_I1=y
> > CONFIG_MTD_CFI_I2=y
> > CONFIG_MTD_CFI_INTELEXT=m
> > CONFIG_MTD_CFI_AMDSTD=y
> > CONFIG_MTD_CFI_STAA=y
> > CONFIG_MTD_CFI_UTIL=y
> > CONFIG_MTD_RAM=y
> > CONFIG_MTD_ROM=y
> > CONFIG_MTD_ABSENT=y
> > # end of RAM/ROM/Flash chip drivers
> > 
> > #
> > # Mapping drivers for chip access
> > #
> > CONFIG_MTD_COMPLEX_MAPPINGS=y
> > CONFIG_MTD_PHYSMAP=m
> > CONFIG_MTD_PHYSMAP_COMPAT=y
> > CONFIG_MTD_PHYSMAP_START=0x8000000
> > CONFIG_MTD_PHYSMAP_LEN=0
> > CONFIG_MTD_PHYSMAP_BANKWIDTH=2
> > # CONFIG_MTD_PHYSMAP_OF is not set
> > CONFIG_MTD_PHYSMAP_GPIO_ADDR=y
> > CONFIG_MTD_SBC_GXX=m
> > CONFIG_MTD_AMD76XROM=y
> > # CONFIG_MTD_ICHXROM is not set
> > # CONFIG_MTD_ESB2ROM is not set
> > # CONFIG_MTD_CK804XROM is not set
> > # CONFIG_MTD_SCB2_FLASH is not set
> > # CONFIG_MTD_NETtel is not set
> > CONFIG_MTD_L440GX=y
> > # CONFIG_MTD_PCI is not set
> > # CONFIG_MTD_INTEL_VR_NOR is not set
> > # CONFIG_MTD_PLATRAM is not set
> > # end of Mapping drivers for chip access
> > 
> > #
> > # Self-contained MTD device drivers
> > #
> > # CONFIG_MTD_PMC551 is not set
> > CONFIG_MTD_SLRAM=m
> > CONFIG_MTD_PHRAM=m
> > CONFIG_MTD_MTDRAM=m
> > CONFIG_MTDRAM_TOTAL_SIZE=4096
> > CONFIG_MTDRAM_ERASE_SIZE=128
> > # CONFIG_MTD_BLOCK2MTD is not set
> > 
> > #
> > # Disk-On-Chip Device Drivers
> > #
> > # CONFIG_MTD_DOCG3 is not set
> > # end of Self-contained MTD device drivers
> > 
> > #
> > # NAND
> > #
> > CONFIG_MTD_NAND_CORE=m
> > CONFIG_MTD_ONENAND=m
> > # CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
> > # CONFIG_MTD_ONENAND_GENERIC is not set
> > CONFIG_MTD_ONENAND_OTP=y
> > CONFIG_MTD_ONENAND_2X_PROGRAM=y
> > CONFIG_MTD_NAND_ECC_SW_HAMMING=m
> > CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
> > CONFIG_MTD_RAW_NAND=m
> > CONFIG_MTD_NAND_ECC_SW_BCH=y
> > 
> > #
> > # Raw/parallel NAND flash controllers
> > #
> > # CONFIG_MTD_NAND_DENALI_PCI is not set
> > # CONFIG_MTD_NAND_DENALI_DT is not set
> > # CONFIG_MTD_NAND_CAFE is not set
> > # CONFIG_MTD_NAND_CS553X is not set
> > CONFIG_MTD_NAND_MXIC=m
> > CONFIG_MTD_NAND_GPIO=m
> > # CONFIG_MTD_NAND_PLATFORM is not set
> > CONFIG_MTD_NAND_CADENCE=m
> > CONFIG_MTD_NAND_ARASAN=m
> > 
> > #
> > # Misc
> > #
> > # CONFIG_MTD_NAND_NANDSIM is not set
> > # CONFIG_MTD_NAND_RICOH is not set
> > # CONFIG_MTD_NAND_DISKONCHIP is not set
> > # end of NAND
> > 
> > #
> > # LPDDR & LPDDR2 PCM memory drivers
> > #
> > CONFIG_MTD_LPDDR=m
> > CONFIG_MTD_QINFO_PROBE=m
> > # end of LPDDR & LPDDR2 PCM memory drivers
> > 
> > CONFIG_MTD_UBI=m
> > CONFIG_MTD_UBI_WL_THRESHOLD=4096
> > CONFIG_MTD_UBI_BEB_LIMIT=20
> > # CONFIG_MTD_UBI_FASTMAP is not set
> > CONFIG_MTD_UBI_GLUEBI=m
> > # CONFIG_MTD_UBI_BLOCK is not set
> > CONFIG_MTD_HYPERBUS=m
> > CONFIG_OF=y
> > # CONFIG_OF_UNITTEST is not set
> > CONFIG_OF_PROMTREE=y
> > CONFIG_OF_KOBJ=y
> > CONFIG_OF_ADDRESS=y
> > CONFIG_OF_IRQ=y
> > CONFIG_OF_NET=y
> > # CONFIG_OF_OVERLAY is not set
> > CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> > CONFIG_PARPORT=m
> > # CONFIG_PARPORT_PC is not set
> > CONFIG_PARPORT_AX88796=m
> > CONFIG_PARPORT_1284=y
> > CONFIG_PARPORT_NOT_PC=y
> > CONFIG_PNP=y
> > CONFIG_PNP_DEBUG_MESSAGES=y
> > 
> > #
> > # Protocols
> > #
> > CONFIG_PNPACPI=y
> > CONFIG_BLK_DEV=y
> > # CONFIG_BLK_DEV_NULL_BLK is not set
> > # CONFIG_BLK_DEV_FD is not set
> > # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> > # CONFIG_ZRAM is not set
> > # CONFIG_BLK_DEV_UMEM is not set
> > # CONFIG_BLK_DEV_LOOP is not set
> > # CONFIG_BLK_DEV_DRBD is not set
> > # CONFIG_BLK_DEV_NBD is not set
> > # CONFIG_BLK_DEV_SX8 is not set
> > # CONFIG_BLK_DEV_RAM is not set
> > # CONFIG_CDROM_PKTCDVD is not set
> > # CONFIG_ATA_OVER_ETH is not set
> > # CONFIG_VIRTIO_BLK is not set
> > # CONFIG_BLK_DEV_RBD is not set
> > # CONFIG_BLK_DEV_RSXX is not set
> > 
> > #
> > # NVME Support
> > #
> > CONFIG_NVME_CORE=y
> > # CONFIG_BLK_DEV_NVME is not set
> > CONFIG_NVME_MULTIPATH=y
> > # CONFIG_NVME_HWMON is not set
> > CONFIG_NVME_FABRICS=y
> > CONFIG_NVME_FC=y
> > CONFIG_NVME_TARGET=m
> > CONFIG_NVME_TARGET_PASSTHRU=y
> > CONFIG_NVME_TARGET_LOOP=m
> > # CONFIG_NVME_TARGET_FC is not set
> > # CONFIG_NVME_TARGET_TCP is not set
> > # end of NVME Support
> > 
> > #
> > # Misc devices
> > #
> > CONFIG_DUMMY_IRQ=m
> > # CONFIG_IBM_ASM is not set
> > # CONFIG_PHANTOM is not set
> > # CONFIG_TIFM_CORE is not set
> > CONFIG_ENCLOSURE_SERVICES=m
> > # CONFIG_HP_ILO is not set
> > # CONFIG_PCH_PHUB is not set
> > CONFIG_SRAM=y
> > # CONFIG_PCI_ENDPOINT_TEST is not set
> > CONFIG_XILINX_SDFEC=y
> > CONFIG_PVPANIC=y
> > # CONFIG_C2PORT is not set
> > 
> > #
> > # EEPROM support
> > #
> > CONFIG_EEPROM_93CX6=y
> > # end of EEPROM support
> > 
> > # CONFIG_CB710_CORE is not set
> > 
> > #
> > # Texas Instruments shared transport line discipline
> > #
> > # CONFIG_TI_ST is not set
> > # end of Texas Instruments shared transport line discipline
> > 
> > #
> > # Altera FPGA firmware download module (requires I2C)
> > #
> > # CONFIG_INTEL_MEI is not set
> > # CONFIG_INTEL_MEI_ME is not set
> > # CONFIG_INTEL_MEI_TXE is not set
> > # CONFIG_VMWARE_VMCI is not set
> > 
> > #
> > # Intel MIC & related support
> > #
> > CONFIG_VOP_BUS=y
> > CONFIG_VOP=m
> > # end of Intel MIC & related support
> > 
> > # CONFIG_ECHO is not set
> > # CONFIG_MISC_ALCOR_PCI is not set
> > # CONFIG_MISC_RTSX_PCI is not set
> > # CONFIG_HABANA_AI is not set
> > # end of Misc devices
> > 
> > CONFIG_HAVE_IDE=y
> > CONFIG_IDE=y
> > 
> > #
> > # Please see Documentation/ide/ide.rst for help/info on IDE drives
> > #
> > CONFIG_IDE_XFER_MODE=y
> > CONFIG_IDE_TIMINGS=y
> > CONFIG_BLK_DEV_IDE_SATA=y
> > # CONFIG_IDE_GD is not set
> > # CONFIG_BLK_DEV_DELKIN is not set
> > # CONFIG_BLK_DEV_IDECD is not set
> > # CONFIG_BLK_DEV_IDETAPE is not set
> > # CONFIG_BLK_DEV_IDEACPI is not set
> > # CONFIG_IDE_TASK_IOCTL is not set
> > CONFIG_IDE_PROC_FS=y
> > 
> > #
> > # IDE chipset support/bugfixes
> > #
> > CONFIG_IDE_GENERIC=y
> > CONFIG_BLK_DEV_PLATFORM=m
> > CONFIG_BLK_DEV_CMD640=y
> > # CONFIG_BLK_DEV_CMD640_ENHANCED is not set
> > # CONFIG_BLK_DEV_IDEPNP is not set
> > 
> > #
> > # PCI IDE chipsets support
> > #
> > # CONFIG_BLK_DEV_GENERIC is not set
> > # CONFIG_BLK_DEV_OPTI621 is not set
> > # CONFIG_BLK_DEV_RZ1000 is not set
> > # CONFIG_BLK_DEV_AEC62XX is not set
> > # CONFIG_BLK_DEV_ALI15X3 is not set
> > # CONFIG_BLK_DEV_AMD74XX is not set
> > # CONFIG_BLK_DEV_ATIIXP is not set
> > # CONFIG_BLK_DEV_CMD64X is not set
> > # CONFIG_BLK_DEV_TRIFLEX is not set
> > # CONFIG_BLK_DEV_CS5520 is not set
> > # CONFIG_BLK_DEV_CS5530 is not set
> > # CONFIG_BLK_DEV_CS5535 is not set
> > # CONFIG_BLK_DEV_CS5536 is not set
> > # CONFIG_BLK_DEV_HPT366 is not set
> > # CONFIG_BLK_DEV_JMICRON is not set
> > # CONFIG_BLK_DEV_SC1200 is not set
> > # CONFIG_BLK_DEV_PIIX is not set
> > # CONFIG_BLK_DEV_IT8172 is not set
> > # CONFIG_BLK_DEV_IT8213 is not set
> > # CONFIG_BLK_DEV_IT821X is not set
> > # CONFIG_BLK_DEV_NS87415 is not set
> > # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> > # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> > # CONFIG_BLK_DEV_SVWKS is not set
> > # CONFIG_BLK_DEV_SIIMAGE is not set
> > # CONFIG_BLK_DEV_SIS5513 is not set
> > # CONFIG_BLK_DEV_SLC90E66 is not set
> > # CONFIG_BLK_DEV_TRM290 is not set
> > # CONFIG_BLK_DEV_VIA82CXXX is not set
> > # CONFIG_BLK_DEV_TC86C001 is not set
> > 
> > #
> > # SCSI device support
> > #
> > CONFIG_SCSI_MOD=m
> > # CONFIG_RAID_ATTRS is not set
> > CONFIG_SCSI=m
> > CONFIG_SCSI_DMA=y
> > CONFIG_SCSI_PROC_FS=y
> > 
> > #
> > # SCSI support type (disk, tape, CD-ROM)
> > #
> > CONFIG_BLK_DEV_SD=m
> > # CONFIG_CHR_DEV_ST is not set
> > # CONFIG_BLK_DEV_SR is not set
> > CONFIG_CHR_DEV_SG=m
> > # CONFIG_CHR_DEV_SCH is not set
> > CONFIG_SCSI_ENCLOSURE=m
> > CONFIG_SCSI_CONSTANTS=y
> > # CONFIG_SCSI_LOGGING is not set
> > # CONFIG_SCSI_SCAN_ASYNC is not set
> > 
> > #
> > # SCSI Transports
> > #
> > # CONFIG_SCSI_SPI_ATTRS is not set
> > # CONFIG_SCSI_FC_ATTRS is not set
> > # CONFIG_SCSI_ISCSI_ATTRS is not set
> > CONFIG_SCSI_SAS_ATTRS=m
> > # CONFIG_SCSI_SAS_LIBSAS is not set
> > CONFIG_SCSI_SRP_ATTRS=m
> > # end of SCSI Transports
> > 
> > CONFIG_SCSI_LOWLEVEL=y
> > # CONFIG_ISCSI_TCP is not set
> > # CONFIG_ISCSI_BOOT_SYSFS is not set
> > # CONFIG_SCSI_CXGB3_ISCSI is not set
> > # CONFIG_SCSI_CXGB4_ISCSI is not set
> > # CONFIG_SCSI_BNX2_ISCSI is not set
> > # CONFIG_BE2ISCSI is not set
> > # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> > # CONFIG_SCSI_HPSA is not set
> > # CONFIG_SCSI_3W_9XXX is not set
> > # CONFIG_SCSI_3W_SAS is not set
> > # CONFIG_SCSI_ACARD is not set
> > # CONFIG_SCSI_AACRAID is not set
> > # CONFIG_SCSI_AIC7XXX is not set
> > # CONFIG_SCSI_AIC79XX is not set
> > # CONFIG_SCSI_AIC94XX is not set
> > # CONFIG_SCSI_MVSAS is not set
> > # CONFIG_SCSI_MVUMI is not set
> > # CONFIG_SCSI_DPT_I2O is not set
> > # CONFIG_SCSI_ADVANSYS is not set
> > # CONFIG_SCSI_ARCMSR is not set
> > # CONFIG_SCSI_ESAS2R is not set
> > # CONFIG_MEGARAID_NEWGEN is not set
> > # CONFIG_MEGARAID_LEGACY is not set
> > # CONFIG_MEGARAID_SAS is not set
> > # CONFIG_SCSI_MPT3SAS is not set
> > # CONFIG_SCSI_MPT2SAS is not set
> > # CONFIG_SCSI_SMARTPQI is not set
> > CONFIG_SCSI_UFSHCD=m
> > # CONFIG_SCSI_UFSHCD_PCI is not set
> > # CONFIG_SCSI_UFSHCD_PLATFORM is not set
> > CONFIG_SCSI_UFS_BSG=y
> > # CONFIG_SCSI_HPTIOP is not set
> > # CONFIG_SCSI_BUSLOGIC is not set
> > # CONFIG_SCSI_MYRB is not set
> > # CONFIG_SCSI_MYRS is not set
> > # CONFIG_VMWARE_PVSCSI is not set
> > # CONFIG_SCSI_SNIC is not set
> > # CONFIG_SCSI_DMX3191D is not set
> > # CONFIG_SCSI_FDOMAIN_PCI is not set
> > # CONFIG_SCSI_GDTH is not set
> > # CONFIG_SCSI_ISCI is not set
> > # CONFIG_SCSI_IPS is not set
> > # CONFIG_SCSI_INITIO is not set
> > # CONFIG_SCSI_INIA100 is not set
> > # CONFIG_SCSI_STEX is not set
> > # CONFIG_SCSI_SYM53C8XX_2 is not set
> > # CONFIG_SCSI_QLOGIC_1280 is not set
> > # CONFIG_SCSI_QLA_ISCSI is not set
> > # CONFIG_SCSI_DC395x is not set
> > # CONFIG_SCSI_AM53C974 is not set
> > # CONFIG_SCSI_NSP32 is not set
> > # CONFIG_SCSI_WD719X is not set
> > CONFIG_SCSI_DEBUG=m
> > # CONFIG_SCSI_PMCRAID is not set
> > # CONFIG_SCSI_PM8001 is not set
> > # CONFIG_SCSI_VIRTIO is not set
> > CONFIG_SCSI_DH=y
> > CONFIG_SCSI_DH_RDAC=m
> > # CONFIG_SCSI_DH_HP_SW is not set
> > # CONFIG_SCSI_DH_EMC is not set
> > CONFIG_SCSI_DH_ALUA=m
> > # end of SCSI device support
> > 
> > # CONFIG_ATA is not set
> > # CONFIG_MD is not set
> > CONFIG_TARGET_CORE=m
> > CONFIG_TCM_IBLOCK=m
> > CONFIG_TCM_FILEIO=m
> > # CONFIG_TCM_PSCSI is not set
> > CONFIG_LOOPBACK_TARGET=m
> > # CONFIG_ISCSI_TARGET is not set
> > CONFIG_SBP_TARGET=m
> > # CONFIG_FUSION is not set
> > 
> > #
> > # IEEE 1394 (FireWire) support
> > #
> > CONFIG_FIREWIRE=y
> > # CONFIG_FIREWIRE_OHCI is not set
> > CONFIG_FIREWIRE_SBP2=m
> > # CONFIG_FIREWIRE_NET is not set
> > # CONFIG_FIREWIRE_NOSY is not set
> > # end of IEEE 1394 (FireWire) support
> > 
> > CONFIG_MACINTOSH_DRIVERS=y
> > # CONFIG_MAC_EMUMOUSEBTN is not set
> > CONFIG_NETDEVICES=y
> > CONFIG_NET_CORE=y
> > # CONFIG_BONDING is not set
> > # CONFIG_DUMMY is not set
> > # CONFIG_WIREGUARD is not set
> > # CONFIG_EQUALIZER is not set
> > # CONFIG_NET_FC is not set
> > # CONFIG_NET_TEAM is not set
> > # CONFIG_MACVLAN is not set
> > # CONFIG_IPVLAN is not set
> > # CONFIG_VXLAN is not set
> > # CONFIG_GENEVE is not set
> > # CONFIG_BAREUDP is not set
> > # CONFIG_GTP is not set
> > # CONFIG_MACSEC is not set
> > # CONFIG_NETCONSOLE is not set
> > # CONFIG_TUN is not set
> > # CONFIG_TUN_VNET_CROSS_LE is not set
> > # CONFIG_VETH is not set
> > # CONFIG_VIRTIO_NET is not set
> > # CONFIG_NLMON is not set
> > # CONFIG_ARCNET is not set
> > 
> > #
> > # Distributed Switch Architecture drivers
> > #
> > # end of Distributed Switch Architecture drivers
> > 
> > CONFIG_ETHERNET=y
> > CONFIG_NET_VENDOR_3COM=y
> > # CONFIG_VORTEX is not set
> > # CONFIG_TYPHOON is not set
> > CONFIG_NET_VENDOR_ADAPTEC=y
> > # CONFIG_ADAPTEC_STARFIRE is not set
> > CONFIG_NET_VENDOR_AGERE=y
> > # CONFIG_ET131X is not set
> > CONFIG_NET_VENDOR_ALACRITECH=y
> > # CONFIG_SLICOSS is not set
> > CONFIG_NET_VENDOR_ALTEON=y
> > # CONFIG_ACENIC is not set
> > # CONFIG_ALTERA_TSE is not set
> > CONFIG_NET_VENDOR_AMAZON=y
> > CONFIG_NET_VENDOR_AMD=y
> > # CONFIG_AMD8111_ETH is not set
> > # CONFIG_PCNET32 is not set
> > # CONFIG_AMD_XGBE is not set
> > CONFIG_NET_VENDOR_AQUANTIA=y
> > CONFIG_NET_VENDOR_ARC=y
> > CONFIG_NET_VENDOR_ATHEROS=y
> > # CONFIG_ATL2 is not set
> > # CONFIG_ATL1 is not set
> > # CONFIG_ATL1E is not set
> > # CONFIG_ATL1C is not set
> > # CONFIG_ALX is not set
> > CONFIG_NET_VENDOR_AURORA=y
> > # CONFIG_AURORA_NB8800 is not set
> > CONFIG_NET_VENDOR_BROADCOM=y
> > # CONFIG_B44 is not set
> > # CONFIG_BCMGENET is not set
> > # CONFIG_BNX2 is not set
> > # CONFIG_CNIC is not set
> > # CONFIG_TIGON3 is not set
> > # CONFIG_BNX2X is not set
> > # CONFIG_SYSTEMPORT is not set
> > # CONFIG_BNXT is not set
> > CONFIG_NET_VENDOR_BROCADE=y
> > # CONFIG_BNA is not set
> > CONFIG_NET_VENDOR_CADENCE=y
> > # CONFIG_MACB is not set
> > CONFIG_NET_VENDOR_CAVIUM=y
> > CONFIG_NET_VENDOR_CHELSIO=y
> > # CONFIG_CHELSIO_T1 is not set
> > # CONFIG_CHELSIO_T3 is not set
> > # CONFIG_CHELSIO_T4 is not set
> > # CONFIG_CHELSIO_T4VF is not set
> > CONFIG_NET_VENDOR_CISCO=y
> > # CONFIG_ENIC is not set
> > CONFIG_NET_VENDOR_CORTINA=y
> > # CONFIG_GEMINI_ETHERNET is not set
> > # CONFIG_CX_ECAT is not set
> > # CONFIG_DNET is not set
> > CONFIG_NET_VENDOR_DEC=y
> > # CONFIG_NET_TULIP is not set
> > CONFIG_NET_VENDOR_DLINK=y
> > # CONFIG_DL2K is not set
> > # CONFIG_SUNDANCE is not set
> > CONFIG_NET_VENDOR_EMULEX=y
> > # CONFIG_BE2NET is not set
> > CONFIG_NET_VENDOR_EZCHIP=y
> > # CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
> > CONFIG_NET_VENDOR_GOOGLE=y
> > CONFIG_NET_VENDOR_HUAWEI=y
> > CONFIG_NET_VENDOR_I825XX=y
> > CONFIG_NET_VENDOR_INTEL=y
> > # CONFIG_E100 is not set
> > CONFIG_E1000=y
> > # CONFIG_E1000E is not set
> > # CONFIG_IGB is not set
> > # CONFIG_IGBVF is not set
> > # CONFIG_IXGB is not set
> > # CONFIG_IXGBE is not set
> > # CONFIG_I40E is not set
> > # CONFIG_IGC is not set
> > # CONFIG_JME is not set
> > CONFIG_NET_VENDOR_MARVELL=y
> > # CONFIG_MVMDIO is not set
> > # CONFIG_SKGE is not set
> > # CONFIG_SKY2 is not set
> > CONFIG_NET_VENDOR_MELLANOX=y
> > # CONFIG_MLX4_EN is not set
> > # CONFIG_MLX5_CORE is not set
> > # CONFIG_MLXSW_CORE is not set
> > # CONFIG_MLXFW is not set
> > CONFIG_NET_VENDOR_MICREL=y
> > # CONFIG_KS8851_MLL is not set
> > # CONFIG_KSZ884X_PCI is not set
> > CONFIG_NET_VENDOR_MICROCHIP=y
> > # CONFIG_LAN743X is not set
> > CONFIG_NET_VENDOR_MICROSEMI=y
> > CONFIG_NET_VENDOR_MYRI=y
> > # CONFIG_MYRI10GE is not set
> > # CONFIG_FEALNX is not set
> > CONFIG_NET_VENDOR_NATSEMI=y
> > # CONFIG_NATSEMI is not set
> > # CONFIG_NS83820 is not set
> > CONFIG_NET_VENDOR_NETERION=y
> > # CONFIG_S2IO is not set
> > # CONFIG_VXGE is not set
> > CONFIG_NET_VENDOR_NETRONOME=y
> > CONFIG_NET_VENDOR_NI=y
> > # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
> > CONFIG_NET_VENDOR_8390=y
> > # CONFIG_NE2K_PCI is not set
> > CONFIG_NET_VENDOR_NVIDIA=y
> > # CONFIG_FORCEDETH is not set
> > CONFIG_NET_VENDOR_OKI=y
> > # CONFIG_PCH_GBE is not set
> > # CONFIG_ETHOC is not set
> > CONFIG_NET_VENDOR_PACKET_ENGINES=y
> > # CONFIG_HAMACHI is not set
> > # CONFIG_YELLOWFIN is not set
> > CONFIG_NET_VENDOR_PENSANDO=y
> > CONFIG_NET_VENDOR_QLOGIC=y
> > # CONFIG_QLA3XXX is not set
> > # CONFIG_QLCNIC is not set
> > # CONFIG_NETXEN_NIC is not set
> > # CONFIG_QED is not set
> > CONFIG_NET_VENDOR_QUALCOMM=y
> > # CONFIG_QCA7000_UART is not set
> > # CONFIG_QCOM_EMAC is not set
> > # CONFIG_RMNET is not set
> > CONFIG_NET_VENDOR_RDC=y
> > # CONFIG_R6040 is not set
> > CONFIG_NET_VENDOR_REALTEK=y
> > # CONFIG_ATP is not set
> > # CONFIG_8139CP is not set
> > # CONFIG_8139TOO is not set
> > # CONFIG_R8169 is not set
> > CONFIG_NET_VENDOR_RENESAS=y
> > CONFIG_NET_VENDOR_ROCKER=y
> > CONFIG_NET_VENDOR_SAMSUNG=y
> > # CONFIG_SXGBE_ETH is not set
> > CONFIG_NET_VENDOR_SEEQ=y
> > CONFIG_NET_VENDOR_SOLARFLARE=y
> > # CONFIG_SFC is not set
> > # CONFIG_SFC_FALCON is not set
> > CONFIG_NET_VENDOR_SILAN=y
> > # CONFIG_SC92031 is not set
> > CONFIG_NET_VENDOR_SIS=y
> > # CONFIG_SIS900 is not set
> > # CONFIG_SIS190 is not set
> > CONFIG_NET_VENDOR_SMSC=y
> > # CONFIG_EPIC100 is not set
> > # CONFIG_SMSC911X is not set
> > # CONFIG_SMSC9420 is not set
> > CONFIG_NET_VENDOR_SOCIONEXT=y
> > CONFIG_NET_VENDOR_STMICRO=y
> > # CONFIG_STMMAC_ETH is not set
> > CONFIG_NET_VENDOR_SUN=y
> > # CONFIG_HAPPYMEAL is not set
> > # CONFIG_SUNGEM is not set
> > # CONFIG_CASSINI is not set
> > # CONFIG_NIU is not set
> > CONFIG_NET_VENDOR_SYNOPSYS=y
> > # CONFIG_DWC_XLGMAC is not set
> > CONFIG_NET_VENDOR_TEHUTI=y
> > # CONFIG_TEHUTI is not set
> > CONFIG_NET_VENDOR_TI=y
> > # CONFIG_TI_CPSW_PHY_SEL is not set
> > # CONFIG_TLAN is not set
> > CONFIG_NET_VENDOR_VIA=y
> > # CONFIG_VIA_RHINE is not set
> > # CONFIG_VIA_VELOCITY is not set
> > CONFIG_NET_VENDOR_WIZNET=y
> > # CONFIG_WIZNET_W5100 is not set
> > # CONFIG_WIZNET_W5300 is not set
> > CONFIG_NET_VENDOR_XILINX=y
> > # CONFIG_XILINX_AXI_EMAC is not set
> > # CONFIG_XILINX_LL_TEMAC is not set
> > # CONFIG_FDDI is not set
> > # CONFIG_HIPPI is not set
> > # CONFIG_NET_SB1000 is not set
> > # CONFIG_MDIO_DEVICE is not set
> > # CONFIG_PHYLIB is not set
> > # CONFIG_PLIP is not set
> > # CONFIG_PPP is not set
> > # CONFIG_SLIP is not set
> > 
> > #
> > # Host-side USB support is needed for USB Network Adapter support
> > #
> > CONFIG_WLAN=y
> > # CONFIG_WIRELESS_WDS is not set
> > CONFIG_WLAN_VENDOR_ADMTEK=y
> > CONFIG_WLAN_VENDOR_ATH=y
> > # CONFIG_ATH_DEBUG is not set
> > # CONFIG_ATH5K_PCI is not set
> > CONFIG_WLAN_VENDOR_ATMEL=y
> > CONFIG_WLAN_VENDOR_BROADCOM=y
> > CONFIG_WLAN_VENDOR_CISCO=y
> > CONFIG_WLAN_VENDOR_INTEL=y
> > CONFIG_WLAN_VENDOR_INTERSIL=y
> > # CONFIG_HOSTAP is not set
> > # CONFIG_PRISM54 is not set
> > CONFIG_WLAN_VENDOR_MARVELL=y
> > CONFIG_WLAN_VENDOR_MEDIATEK=y
> > CONFIG_WLAN_VENDOR_MICROCHIP=y
> > CONFIG_WLAN_VENDOR_RALINK=y
> > CONFIG_WLAN_VENDOR_REALTEK=y
> > CONFIG_WLAN_VENDOR_RSI=y
> > CONFIG_WLAN_VENDOR_ST=y
> > CONFIG_WLAN_VENDOR_TI=y
> > CONFIG_WLAN_VENDOR_ZYDAS=y
> > CONFIG_WLAN_VENDOR_QUANTENNA=y
> > 
> > #
> > # Enable WiMAX (Networking options) to see the WiMAX drivers
> > #
> > # CONFIG_WAN is not set
> > # CONFIG_VMXNET3 is not set
> > # CONFIG_FUJITSU_ES is not set
> > # CONFIG_NETDEVSIM is not set
> > # CONFIG_NET_FAILOVER is not set
> > # CONFIG_ISDN is not set
> > CONFIG_NVM=y
> > # CONFIG_NVM_PBLK is not set
> > 
> > #
> > # Input device support
> > #
> > CONFIG_INPUT=y
> > # CONFIG_INPUT_LEDS is not set
> > CONFIG_INPUT_FF_MEMLESS=y
> > # CONFIG_INPUT_POLLDEV is not set
> > # CONFIG_INPUT_SPARSEKMAP is not set
> > CONFIG_INPUT_MATRIXKMAP=y
> > 
> > #
> > # Userland interfaces
> > #
> > CONFIG_INPUT_MOUSEDEV=m
> > # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> > CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> > CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> > CONFIG_INPUT_JOYDEV=y
> > CONFIG_INPUT_EVDEV=y
> > CONFIG_INPUT_EVBUG=y
> > 
> > #
> > # Input Device Drivers
> > #
> > CONFIG_INPUT_KEYBOARD=y
> > # CONFIG_KEYBOARD_ADC is not set
> > CONFIG_KEYBOARD_ATKBD=y
> > CONFIG_KEYBOARD_LKKBD=m
> > CONFIG_KEYBOARD_GPIO=m
> > # CONFIG_KEYBOARD_GPIO_POLLED is not set
> > CONFIG_KEYBOARD_MATRIX=y
> > CONFIG_KEYBOARD_NEWTON=m
> > CONFIG_KEYBOARD_OPENCORES=y
> > # CONFIG_KEYBOARD_SAMSUNG is not set
> > CONFIG_KEYBOARD_GOLDFISH_EVENTS=m
> > # CONFIG_KEYBOARD_STOWAWAY is not set
> > CONFIG_KEYBOARD_SUNKBD=y
> > CONFIG_KEYBOARD_OMAP4=y
> > # CONFIG_KEYBOARD_XTKBD is not set
> > # CONFIG_KEYBOARD_BCM is not set
> > CONFIG_KEYBOARD_MTK_PMIC=m
> > CONFIG_INPUT_MOUSE=y
> > CONFIG_MOUSE_PS2=m
> > CONFIG_MOUSE_PS2_ALPS=y
> > # CONFIG_MOUSE_PS2_BYD is not set
> > # CONFIG_MOUSE_PS2_LOGIPS2PP is not set
> > # CONFIG_MOUSE_PS2_SYNAPTICS is not set
> > # CONFIG_MOUSE_PS2_CYPRESS is not set
> > # CONFIG_MOUSE_PS2_LIFEBOOK is not set
> > # CONFIG_MOUSE_PS2_TRACKPOINT is not set
> > CONFIG_MOUSE_PS2_ELANTECH=y
> > CONFIG_MOUSE_PS2_SENTELIC=y
> > CONFIG_MOUSE_PS2_TOUCHKIT=y
> > # CONFIG_MOUSE_PS2_OLPC is not set
> > CONFIG_MOUSE_PS2_FOCALTECH=y
> > # CONFIG_MOUSE_PS2_VMMOUSE is not set
> > CONFIG_MOUSE_SERIAL=m
> > # CONFIG_MOUSE_APPLETOUCH is not set
> > # CONFIG_MOUSE_BCM5974 is not set
> > # CONFIG_MOUSE_VSXXXAA is not set
> > # CONFIG_MOUSE_GPIO is not set
> > # CONFIG_MOUSE_SYNAPTICS_USB is not set
> > # CONFIG_INPUT_JOYSTICK is not set
> > CONFIG_INPUT_TABLET=y
> > # CONFIG_TABLET_USB_ACECAD is not set
> > # CONFIG_TABLET_USB_AIPTEK is not set
> > # CONFIG_TABLET_USB_HANWANG is not set
> > # CONFIG_TABLET_USB_KBTAB is not set
> > # CONFIG_TABLET_USB_PEGASUS is not set
> > CONFIG_TABLET_SERIAL_WACOM4=m
> > CONFIG_INPUT_TOUCHSCREEN=y
> > CONFIG_TOUCHSCREEN_PROPERTIES=y
> > # CONFIG_TOUCHSCREEN_AD7879 is not set
> > CONFIG_TOUCHSCREEN_ADC=m
> > # CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
> > # CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
> > CONFIG_TOUCHSCREEN_DYNAPRO=m
> > CONFIG_TOUCHSCREEN_HAMPSHIRE=m
> > CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
> > CONFIG_TOUCHSCREEN_FUJITSU=m
> > CONFIG_TOUCHSCREEN_GUNZE=y
> > CONFIG_TOUCHSCREEN_ELO=m
> > # CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
> > CONFIG_TOUCHSCREEN_MTOUCH=y
> > # CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
> > CONFIG_TOUCHSCREEN_INEXIO=y
> > CONFIG_TOUCHSCREEN_MK712=y
> > CONFIG_TOUCHSCREEN_PENMOUNT=m
> > CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
> > # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
> > CONFIG_TOUCHSCREEN_UCB1400=m
> > # CONFIG_TOUCHSCREEN_WM97XX is not set
> > # CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
> > # CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
> > CONFIG_TOUCHSCREEN_TSC_SERIO=m
> > CONFIG_INPUT_MISC=y
> > CONFIG_INPUT_AD714X=y
> > CONFIG_INPUT_E3X0_BUTTON=y
> > CONFIG_INPUT_PCSPKR=y
> > CONFIG_INPUT_GPIO_BEEPER=y
> > CONFIG_INPUT_GPIO_DECODER=m
> > CONFIG_INPUT_GPIO_VIBRA=y
> > # CONFIG_INPUT_WISTRON_BTNS is not set
> > # CONFIG_INPUT_ATLAS_BTNS is not set
> > # CONFIG_INPUT_ATI_REMOTE2 is not set
> > # CONFIG_INPUT_KEYSPAN_REMOTE is not set
> > # CONFIG_INPUT_POWERMATE is not set
> > # CONFIG_INPUT_YEALINK is not set
> > # CONFIG_INPUT_CM109 is not set
> > # CONFIG_INPUT_REGULATOR_HAPTIC is not set
> > CONFIG_INPUT_UINPUT=m
> > # CONFIG_INPUT_PWM_BEEPER is not set
> > CONFIG_INPUT_PWM_VIBRA=y
> > CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
> > # CONFIG_INPUT_ADXL34X is not set
> > CONFIG_INPUT_CMA3000=y
> > # CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
> > # CONFIG_INPUT_SOC_BUTTON_ARRAY is not set
> > CONFIG_RMI4_CORE=y
> > CONFIG_RMI4_F03=y
> > CONFIG_RMI4_F03_SERIO=y
> > CONFIG_RMI4_2D_SENSOR=y
> > CONFIG_RMI4_F11=y
> > CONFIG_RMI4_F12=y
> > # CONFIG_RMI4_F30 is not set
> > CONFIG_RMI4_F34=y
> > CONFIG_RMI4_F55=y
> > 
> > #
> > # Hardware I/O ports
> > #
> > CONFIG_SERIO=y
> > CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> > CONFIG_SERIO_I8042=y
> > # CONFIG_SERIO_SERPORT is not set
> > CONFIG_SERIO_CT82C710=m
> > CONFIG_SERIO_PARKBD=m
> > # CONFIG_SERIO_PCIPS2 is not set
> > CONFIG_SERIO_LIBPS2=y
> > CONFIG_SERIO_RAW=m
> > CONFIG_SERIO_ALTERA_PS2=y
> > CONFIG_SERIO_PS2MULT=y
> > CONFIG_SERIO_ARC_PS2=y
> > CONFIG_SERIO_APBPS2=y
> > CONFIG_SERIO_GPIO_PS2=m
> > # CONFIG_USERIO is not set
> > CONFIG_GAMEPORT=y
> > CONFIG_GAMEPORT_NS558=m
> > CONFIG_GAMEPORT_L4=y
> > # CONFIG_GAMEPORT_EMU10K1 is not set
> > # CONFIG_GAMEPORT_FM801 is not set
> > # end of Hardware I/O ports
> > # end of Input device support
> > 
> > #
> > # Character devices
> > #
> > CONFIG_TTY=y
> > # CONFIG_VT is not set
> > CONFIG_UNIX98_PTYS=y
> > # CONFIG_LEGACY_PTYS is not set
> > # CONFIG_LDISC_AUTOLOAD is not set
> > 
> > #
> > # Serial drivers
> > #
> > CONFIG_SERIAL_EARLYCON=y
> > CONFIG_SERIAL_8250=y
> > CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
> > CONFIG_SERIAL_8250_PNP=y
> > # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> > CONFIG_SERIAL_8250_FINTEK=y
> > CONFIG_SERIAL_8250_CONSOLE=y
> > CONFIG_SERIAL_8250_PCI=y
> > CONFIG_SERIAL_8250_EXAR=y
> > CONFIG_SERIAL_8250_MEN_MCB=m
> > CONFIG_SERIAL_8250_NR_UARTS=4
> > CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> > CONFIG_SERIAL_8250_EXTENDED=y
> > # CONFIG_SERIAL_8250_MANY_PORTS is not set
> > CONFIG_SERIAL_8250_ASPEED_VUART=m
> > CONFIG_SERIAL_8250_SHARE_IRQ=y
> > # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> > # CONFIG_SERIAL_8250_RSA is not set
> > CONFIG_SERIAL_8250_DWLIB=y
> > CONFIG_SERIAL_8250_DW=m
> > CONFIG_SERIAL_8250_RT288X=y
> > CONFIG_SERIAL_8250_LPSS=y
> > CONFIG_SERIAL_8250_MID=y
> > CONFIG_SERIAL_OF_PLATFORM=m
> > 
> > #
> > # Non-8250 serial port support
> > #
> > # CONFIG_SERIAL_IMX_EARLYCON is not set
> > # CONFIG_SERIAL_UARTLITE is not set
> > CONFIG_SERIAL_CORE=y
> > CONFIG_SERIAL_CORE_CONSOLE=y
> > # CONFIG_SERIAL_JSM is not set
> > CONFIG_SERIAL_SIFIVE=y
> > CONFIG_SERIAL_SIFIVE_CONSOLE=y
> > CONFIG_SERIAL_LANTIQ=y
> > # CONFIG_SERIAL_LANTIQ_CONSOLE is not set
> > CONFIG_SERIAL_SCCNXP=m
> > CONFIG_SERIAL_TIMBERDALE=m
> > # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> > CONFIG_SERIAL_ALTERA_UART=y
> > CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
> > CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
> > CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
> > # CONFIG_SERIAL_PCH_UART is not set
> > CONFIG_SERIAL_XILINX_PS_UART=m
> > # CONFIG_SERIAL_ARC is not set
> > # CONFIG_SERIAL_RP2 is not set
> > # CONFIG_SERIAL_FSL_LPUART is not set
> > CONFIG_SERIAL_FSL_LINFLEXUART=m
> > CONFIG_SERIAL_CONEXANT_DIGICOLOR=m
> > CONFIG_SERIAL_MEN_Z135=m
> > # CONFIG_SERIAL_SPRD is not set
> > # end of Serial drivers
> > 
> > CONFIG_SERIAL_MCTRL_GPIO=y
> > # CONFIG_SERIAL_NONSTANDARD is not set
> > # CONFIG_GOLDFISH_TTY is not set
> > # CONFIG_N_GSM is not set
> > # CONFIG_NOZOMI is not set
> > CONFIG_NULL_TTY=m
> > # CONFIG_TRACE_SINK is not set
> > CONFIG_HVC_DRIVER=y
> > CONFIG_SERIAL_DEV_BUS=m
> > CONFIG_TTY_PRINTK=m
> > CONFIG_TTY_PRINTK_LEVEL=6
> > CONFIG_PRINTER=m
> > CONFIG_LP_CONSOLE=y
> > # CONFIG_PPDEV is not set
> > CONFIG_VIRTIO_CONSOLE=y
> > # CONFIG_IPMI_HANDLER is not set
> > CONFIG_HW_RANDOM=m
> > # CONFIG_HW_RANDOM_TIMERIOMEM is not set
> > CONFIG_HW_RANDOM_INTEL=m
> > CONFIG_HW_RANDOM_AMD=m
> > CONFIG_HW_RANDOM_BA431=m
> > CONFIG_HW_RANDOM_GEODE=m
> > # CONFIG_HW_RANDOM_VIA is not set
> > CONFIG_HW_RANDOM_VIRTIO=m
> > # CONFIG_HW_RANDOM_CCTRNG is not set
> > # CONFIG_APPLICOM is not set
> > # CONFIG_SONYPI is not set
> > CONFIG_MWAVE=m
> > # CONFIG_PC8736x_GPIO is not set
> > CONFIG_NSC_GPIO=y
> > CONFIG_DEVMEM=y
> > CONFIG_DEVKMEM=y
> > CONFIG_NVRAM=y
> > CONFIG_RAW_DRIVER=y
> > CONFIG_MAX_RAW_DEVS=256
> > CONFIG_DEVPORT=y
> > # CONFIG_HPET is not set
> > CONFIG_HANGCHECK_TIMER=m
> > CONFIG_TCG_TPM=y
> > # CONFIG_TCG_TIS is not set
> > # CONFIG_TCG_NSC is not set
> > CONFIG_TCG_ATMEL=m
> > # CONFIG_TCG_INFINEON is not set
> > # CONFIG_TCG_CRB is not set
> > CONFIG_TCG_VTPM_PROXY=y
> > CONFIG_TELCLOCK=y
> > CONFIG_XILLYBUS=m
> > CONFIG_XILLYBUS_OF=m
> > # end of Character devices
> > 
> > # CONFIG_RANDOM_TRUST_BOOTLOADER is not set
> > 
> > #
> > # I2C support
> > #
> > # CONFIG_I2C is not set
> > # end of I2C support
> > 
> > # CONFIG_I3C is not set
> > # CONFIG_SPI is not set
> > CONFIG_SPMI=m
> > CONFIG_HSI=m
> > CONFIG_HSI_BOARDINFO=y
> > 
> > #
> > # HSI controllers
> > #
> > 
> > #
> > # HSI clients
> > #
> > # CONFIG_HSI_CHAR is not set
> > CONFIG_PPS=y
> > # CONFIG_PPS_DEBUG is not set
> > 
> > #
> > # PPS clients support
> > #
> > # CONFIG_PPS_CLIENT_KTIMER is not set
> > CONFIG_PPS_CLIENT_LDISC=y
> > CONFIG_PPS_CLIENT_PARPORT=m
> > # CONFIG_PPS_CLIENT_GPIO is not set
> > 
> > #
> > # PPS generators support
> > #
> > 
> > #
> > # PTP clock support
> > #
> > 
> > #
> > # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> > #
> > # CONFIG_PTP_1588_CLOCK_PCH is not set
> > # end of PTP clock support
> > 
> > CONFIG_PINCTRL=y
> > CONFIG_GENERIC_PINCTRL_GROUPS=y
> > CONFIG_PINMUX=y
> > CONFIG_GENERIC_PINMUX_FUNCTIONS=y
> > CONFIG_PINCONF=y
> > CONFIG_GENERIC_PINCONF=y
> > # CONFIG_DEBUG_PINCTRL is not set
> > CONFIG_PINCTRL_AMD=m
> > # CONFIG_PINCTRL_SINGLE is not set
> > CONFIG_PINCTRL_OCELOT=y
> > # CONFIG_PINCTRL_BAYTRAIL is not set
> > # CONFIG_PINCTRL_CHERRYVIEW is not set
> > # CONFIG_PINCTRL_LYNXPOINT is not set
> > # CONFIG_PINCTRL_BROXTON is not set
> > # CONFIG_PINCTRL_CANNONLAKE is not set
> > # CONFIG_PINCTRL_CEDARFORK is not set
> > # CONFIG_PINCTRL_DENVERTON is not set
> > # CONFIG_PINCTRL_EMMITSBURG is not set
> > # CONFIG_PINCTRL_GEMINILAKE is not set
> > # CONFIG_PINCTRL_ICELAKE is not set
> > # CONFIG_PINCTRL_JASPERLAKE is not set
> > # CONFIG_PINCTRL_LEWISBURG is not set
> > # CONFIG_PINCTRL_SUNRISEPOINT is not set
> > # CONFIG_PINCTRL_TIGERLAKE is not set
> > CONFIG_PINCTRL_MADERA=y
> > CONFIG_PINCTRL_CS47L35=y
> > CONFIG_PINCTRL_CS47L92=y
> > CONFIG_PINCTRL_EQUILIBRIUM=y
> > CONFIG_GPIOLIB=y
> > CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> > CONFIG_OF_GPIO=y
> > CONFIG_GPIO_ACPI=y
> > CONFIG_GPIOLIB_IRQCHIP=y
> > CONFIG_DEBUG_GPIO=y
> > CONFIG_GPIO_SYSFS=y
> > CONFIG_GPIO_GENERIC=y
> > 
> > #
> > # Memory mapped GPIO drivers
> > #
> > # CONFIG_GPIO_74XX_MMIO is not set
> > CONFIG_GPIO_ALTERA=m
> > # CONFIG_GPIO_AMDPT is not set
> > CONFIG_GPIO_CADENCE=y
> > CONFIG_GPIO_DWAPB=y
> > # CONFIG_GPIO_EXAR is not set
> > CONFIG_GPIO_FTGPIO010=y
> > # CONFIG_GPIO_GENERIC_PLATFORM is not set
> > CONFIG_GPIO_GRGPIO=m
> > CONFIG_GPIO_HLWD=y
> > # CONFIG_GPIO_ICH is not set
> > CONFIG_GPIO_LOGICVC=m
> > CONFIG_GPIO_MB86S7X=m
> > CONFIG_GPIO_MENZ127=m
> > # CONFIG_GPIO_SAMA5D2_PIOBU is not set
> > # CONFIG_GPIO_SIFIVE is not set
> > # CONFIG_GPIO_SYSCON is not set
> > # CONFIG_GPIO_VX855 is not set
> > # CONFIG_GPIO_XILINX is not set
> > CONFIG_GPIO_AMD_FCH=m
> > # end of Memory mapped GPIO drivers
> > 
> > #
> > # Port-mapped I/O GPIO drivers
> > #
> > # CONFIG_GPIO_104_DIO_48E is not set
> > CONFIG_GPIO_104_IDIO_16=y
> > CONFIG_GPIO_104_IDI_48=y
> > CONFIG_GPIO_F7188X=m
> > CONFIG_GPIO_GPIO_MM=y
> > CONFIG_GPIO_IT87=m
> > # CONFIG_GPIO_SCH is not set
> > # CONFIG_GPIO_SCH311X is not set
> > CONFIG_GPIO_WINBOND=y
> > CONFIG_GPIO_WS16C48=y
> > # end of Port-mapped I/O GPIO drivers
> > 
> > #
> > # MFD GPIO expanders
> > #
> > # CONFIG_GPIO_MADERA is not set
> > CONFIG_GPIO_TQMX86=m
> > # CONFIG_GPIO_UCB1400 is not set
> > # end of MFD GPIO expanders
> > 
> > #
> > # PCI GPIO expanders
> > #
> > # CONFIG_GPIO_AMD8111 is not set
> > # CONFIG_GPIO_BT8XX is not set
> > # CONFIG_GPIO_ML_IOH is not set
> > # CONFIG_GPIO_PCH is not set
> > # CONFIG_GPIO_PCI_IDIO_16 is not set
> > # CONFIG_GPIO_PCIE_IDIO_24 is not set
> > # CONFIG_GPIO_RDC321X is not set
> > # CONFIG_GPIO_SODAVILLE is not set
> > # end of PCI GPIO expanders
> > 
> > CONFIG_GPIO_AGGREGATOR=m
> > # CONFIG_GPIO_MOCKUP is not set
> > CONFIG_W1=y
> > 
> > #
> > # 1-wire Bus Masters
> > #
> > # CONFIG_W1_MASTER_MATROX is not set
> > CONFIG_W1_MASTER_DS1WM=y
> > CONFIG_W1_MASTER_GPIO=m
> > CONFIG_W1_MASTER_SGI=y
> > # end of 1-wire Bus Masters
> > 
> > #
> > # 1-wire Slaves
> > #
> > # CONFIG_W1_SLAVE_THERM is not set
> > # CONFIG_W1_SLAVE_SMEM is not set
> > CONFIG_W1_SLAVE_DS2405=y
> > CONFIG_W1_SLAVE_DS2408=y
> > # CONFIG_W1_SLAVE_DS2408_READBACK is not set
> > CONFIG_W1_SLAVE_DS2413=m
> > CONFIG_W1_SLAVE_DS2406=y
> > # CONFIG_W1_SLAVE_DS2423 is not set
> > CONFIG_W1_SLAVE_DS2805=m
> > # CONFIG_W1_SLAVE_DS2430 is not set
> > CONFIG_W1_SLAVE_DS2431=m
> > CONFIG_W1_SLAVE_DS2433=y
> > # CONFIG_W1_SLAVE_DS2433_CRC is not set
> > CONFIG_W1_SLAVE_DS2438=y
> > CONFIG_W1_SLAVE_DS250X=m
> > CONFIG_W1_SLAVE_DS2780=m
> > CONFIG_W1_SLAVE_DS2781=y
> > CONFIG_W1_SLAVE_DS28E04=y
> > # end of 1-wire Slaves
> > 
> > # CONFIG_POWER_AVS is not set
> > # CONFIG_POWER_RESET is not set
> > CONFIG_POWER_SUPPLY=y
> > # CONFIG_POWER_SUPPLY_DEBUG is not set
> > CONFIG_POWER_SUPPLY_HWMON=y
> > # CONFIG_PDA_POWER is not set
> > # CONFIG_GENERIC_ADC_BATTERY is not set
> > # CONFIG_TEST_POWER is not set
> > # CONFIG_BATTERY_DS2760 is not set
> > # CONFIG_BATTERY_DS2780 is not set
> > # CONFIG_BATTERY_DS2781 is not set
> > # CONFIG_BATTERY_LEGO_EV3 is not set
> > # CONFIG_BATTERY_OLPC is not set
> > # CONFIG_BATTERY_BQ27XXX is not set
> > # CONFIG_BATTERY_MAX1721X is not set
> > # CONFIG_CHARGER_MAX8903 is not set
> > # CONFIG_CHARGER_GPIO is not set
> > # CONFIG_CHARGER_MANAGER is not set
> > # CONFIG_CHARGER_LT3651 is not set
> > # CONFIG_BATTERY_GOLDFISH is not set
> > CONFIG_HWMON=y
> > CONFIG_HWMON_VID=y
> > # CONFIG_HWMON_DEBUG_CHIP is not set
> > 
> > #
> > # Native drivers
> > #
> > # CONFIG_SENSORS_ABITUGURU is not set
> > CONFIG_SENSORS_ABITUGURU3=m
> > CONFIG_SENSORS_AS370=y
> > # CONFIG_SENSORS_AXI_FAN_CONTROL is not set
> > # CONFIG_SENSORS_K8TEMP is not set
> > # CONFIG_SENSORS_K10TEMP is not set
> > # CONFIG_SENSORS_FAM15H_POWER is not set
> > CONFIG_SENSORS_AMD_ENERGY=y
> > # CONFIG_SENSORS_APPLESMC is not set
> > CONFIG_SENSORS_ASPEED=m
> > CONFIG_SENSORS_DELL_SMM=m
> > # CONFIG_SENSORS_I5K_AMB is not set
> > CONFIG_SENSORS_F71805F=y
> > # CONFIG_SENSORS_F71882FG is not set
> > # CONFIG_SENSORS_GPIO_FAN is not set
> > # CONFIG_SENSORS_IIO_HWMON is not set
> > # CONFIG_SENSORS_I5500 is not set
> > # CONFIG_SENSORS_CORETEMP is not set
> > # CONFIG_SENSORS_IT87 is not set
> > CONFIG_SENSORS_MAX197=m
> > CONFIG_SENSORS_MLXREG_FAN=y
> > # CONFIG_SENSORS_PC87360 is not set
> > CONFIG_SENSORS_PC87427=m
> > CONFIG_SENSORS_NTC_THERMISTOR=m
> > # CONFIG_SENSORS_NCT6683 is not set
> > CONFIG_SENSORS_NCT6775=y
> > # CONFIG_SENSORS_NPCM7XX is not set
> > # CONFIG_SENSORS_PWM_FAN is not set
> > CONFIG_SENSORS_SHT15=y
> > # CONFIG_SENSORS_SIS5595 is not set
> > # CONFIG_SENSORS_SMSC47M1 is not set
> > # CONFIG_SENSORS_SMSC47B397 is not set
> > # CONFIG_SENSORS_VIA_CPUTEMP is not set
> > # CONFIG_SENSORS_VIA686A is not set
> > # CONFIG_SENSORS_VT1211 is not set
> > # CONFIG_SENSORS_VT8231 is not set
> > CONFIG_SENSORS_W83627HF=m
> > CONFIG_SENSORS_W83627EHF=y
> > 
> > #
> > # ACPI drivers
> > #
> > # CONFIG_SENSORS_ACPI_POWER is not set
> > # CONFIG_SENSORS_ATK0110 is not set
> > CONFIG_THERMAL=y
> > # CONFIG_THERMAL_NETLINK is not set
> > # CONFIG_THERMAL_STATISTICS is not set
> > CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> > CONFIG_THERMAL_HWMON=y
> > # CONFIG_THERMAL_OF is not set
> > # CONFIG_THERMAL_WRITABLE_TRIPS is not set
> > # CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
> > # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> > CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
> > # CONFIG_THERMAL_GOV_FAIR_SHARE is not set
> > CONFIG_THERMAL_GOV_STEP_WISE=y
> > CONFIG_THERMAL_GOV_BANG_BANG=y
> > CONFIG_THERMAL_GOV_USER_SPACE=y
> > CONFIG_DEVFREQ_THERMAL=y
> > # CONFIG_THERMAL_EMULATION is not set
> > # CONFIG_THERMAL_MMIO is not set
> > 
> > #
> > # Intel thermal drivers
> > #
> > # CONFIG_INTEL_POWERCLAMP is not set
> > # CONFIG_INTEL_SOC_DTS_THERMAL is not set
> > 
> > #
> > # ACPI INT340X thermal drivers
> > #
> > # CONFIG_INT340X_THERMAL is not set
> > # end of ACPI INT340X thermal drivers
> > 
> > # CONFIG_INTEL_PCH_THERMAL is not set
> > # end of Intel thermal drivers
> > 
> > CONFIG_GENERIC_ADC_THERMAL=m
> > # CONFIG_WATCHDOG is not set
> > CONFIG_SSB_POSSIBLE=y
> > CONFIG_SSB=m
> > CONFIG_SSB_SPROM=y
> > CONFIG_SSB_PCIHOST_POSSIBLE=y
> > CONFIG_SSB_PCIHOST=y
> > CONFIG_SSB_SDIOHOST_POSSIBLE=y
> > CONFIG_SSB_SDIOHOST=y
> > CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
> > # CONFIG_SSB_DRIVER_PCICORE is not set
> > CONFIG_SSB_DRIVER_GPIO=y
> > CONFIG_BCMA_POSSIBLE=y
> > CONFIG_BCMA=y
> > CONFIG_BCMA_HOST_PCI_POSSIBLE=y
> > CONFIG_BCMA_HOST_PCI=y
> > CONFIG_BCMA_HOST_SOC=y
> > CONFIG_BCMA_DRIVER_PCI=y
> > CONFIG_BCMA_SFLASH=y
> > CONFIG_BCMA_DRIVER_GMAC_CMN=y
> > # CONFIG_BCMA_DRIVER_GPIO is not set
> > # CONFIG_BCMA_DEBUG is not set
> > 
> > #
> > # Multifunction device drivers
> > #
> > CONFIG_MFD_CORE=y
> > # CONFIG_MFD_CS5535 is not set
> > # CONFIG_MFD_ATMEL_FLEXCOM is not set
> > CONFIG_MFD_ATMEL_HLCDC=y
> > CONFIG_MFD_MADERA=y
> > # CONFIG_MFD_CS47L15 is not set
> > CONFIG_MFD_CS47L35=y
> > # CONFIG_MFD_CS47L85 is not set
> > # CONFIG_MFD_CS47L90 is not set
> > CONFIG_MFD_CS47L92=y
> > CONFIG_MFD_HI6421_PMIC=y
> > CONFIG_HTC_PASIC3=m
> > # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> > # CONFIG_LPC_ICH is not set
> > # CONFIG_LPC_SCH is not set
> > # CONFIG_MFD_INTEL_LPSS_ACPI is not set
> > # CONFIG_MFD_INTEL_LPSS_PCI is not set
> > # CONFIG_MFD_JANZ_CMODIO is not set
> > # CONFIG_MFD_KEMPLD is not set
> > CONFIG_MFD_MT6397=y
> > CONFIG_UCB1400_CORE=m
> > # CONFIG_MFD_RDC321X is not set
> > CONFIG_MFD_SM501=y
> > # CONFIG_MFD_SM501_GPIO is not set
> > # CONFIG_ABX500_CORE is not set
> > CONFIG_MFD_SYSCON=y
> > # CONFIG_MFD_TI_AM335X_TSCADC is not set
> > # CONFIG_MFD_TIMBERDALE is not set
> > CONFIG_MFD_TQMX86=y
> > # CONFIG_MFD_VX855 is not set
> > # CONFIG_MFD_WCD934X is not set
> > # CONFIG_RAVE_SP_CORE is not set
> > # end of Multifunction device drivers
> > 
> > CONFIG_REGULATOR=y
> > CONFIG_REGULATOR_DEBUG=y
> > # CONFIG_REGULATOR_FIXED_VOLTAGE is not set
> > CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
> > # CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
> > CONFIG_REGULATOR_ARIZONA_LDO1=m
> > # CONFIG_REGULATOR_ARIZONA_MICSUPP is not set
> > CONFIG_REGULATOR_GPIO=m
> > CONFIG_REGULATOR_HI6421=m
> > # CONFIG_REGULATOR_HI6421V530 is not set
> > CONFIG_REGULATOR_MT6323=y
> > # CONFIG_REGULATOR_MT6358 is not set
> > CONFIG_REGULATOR_MT6397=m
> > CONFIG_REGULATOR_PWM=y
> > CONFIG_REGULATOR_QCOM_SPMI=m
> > CONFIG_REGULATOR_QCOM_USB_VBUS=m
> > # CONFIG_REGULATOR_VCTRL is not set
> > # CONFIG_REGULATOR_QCOM_LABIBB is not set
> > CONFIG_RC_CORE=y
> > CONFIG_RC_MAP=y
> > CONFIG_LIRC=y
> > # CONFIG_RC_DECODERS is not set
> > CONFIG_RC_DEVICES=y
> > # CONFIG_RC_ATI_REMOTE is not set
> > CONFIG_IR_ENE=m
> > CONFIG_IR_HIX5HD2=y
> > # CONFIG_IR_IMON is not set
> > # CONFIG_IR_IMON_RAW is not set
> > # CONFIG_IR_MCEUSB is not set
> > # CONFIG_IR_ITE_CIR is not set
> > CONFIG_IR_FINTEK=m
> > # CONFIG_IR_NUVOTON is not set
> > # CONFIG_IR_REDRAT3 is not set
> > # CONFIG_IR_STREAMZAP is not set
> > CONFIG_IR_WINBOND_CIR=m
> > # CONFIG_IR_IGORPLUGUSB is not set
> > # CONFIG_IR_IGUANA is not set
> > # CONFIG_IR_TTUSBIR is not set
> > CONFIG_RC_LOOPBACK=y
> > # CONFIG_IR_GPIO_CIR is not set
> > CONFIG_IR_GPIO_TX=m
> > CONFIG_IR_PWM_TX=y
> > CONFIG_IR_SERIAL=y
> > CONFIG_IR_SERIAL_TRANSMITTER=y
> > # CONFIG_IR_SIR is not set
> > # CONFIG_RC_XBOX_DVD is not set
> > # CONFIG_IR_TOY is not set
> > # CONFIG_MEDIA_CEC_SUPPORT is not set
> > # CONFIG_MEDIA_SUPPORT is not set
> > 
> > #
> > # Graphics support
> > #
> > # CONFIG_AGP is not set
> > CONFIG_VGA_ARB=y
> > CONFIG_VGA_ARB_MAX_GPUS=16
> > # CONFIG_VGA_SWITCHEROO is not set
> > # CONFIG_DRM is not set
> > 
> > #
> > # ARM devices
> > #
> > # end of ARM devices
> > 
> > #
> > # Frame buffer Devices
> > #
> > # CONFIG_FB is not set
> > # end of Frame buffer Devices
> > 
> > #
> > # Backlight & LCD device support
> > #
> > CONFIG_LCD_CLASS_DEVICE=m
> > CONFIG_LCD_PLATFORM=m
> > # CONFIG_BACKLIGHT_CLASS_DEVICE is not set
> > # end of Backlight & LCD device support
> > # end of Graphics support
> > 
> > CONFIG_SOUND=y
> > CONFIG_SOUND_OSS_CORE=y
> > CONFIG_SOUND_OSS_CORE_PRECLAIM=y
> > CONFIG_SND=y
> > CONFIG_SND_TIMER=y
> > CONFIG_SND_PCM=y
> > CONFIG_SND_DMAENGINE_PCM=m
> > CONFIG_SND_RAWMIDI=m
> > CONFIG_SND_JACK=y
> > CONFIG_SND_JACK_INPUT_DEV=y
> > CONFIG_SND_OSSEMUL=y
> > # CONFIG_SND_MIXER_OSS is not set
> > CONFIG_SND_PCM_OSS=y
> > CONFIG_SND_PCM_OSS_PLUGINS=y
> > # CONFIG_SND_PCM_TIMER is not set
> > # CONFIG_SND_HRTIMER is not set
> > CONFIG_SND_DYNAMIC_MINORS=y
> > CONFIG_SND_MAX_CARDS=32
> > # CONFIG_SND_SUPPORT_OLD_API is not set
> > CONFIG_SND_PROC_FS=y
> > CONFIG_SND_VERBOSE_PROCFS=y
> > # CONFIG_SND_VERBOSE_PRINTK is not set
> > # CONFIG_SND_DEBUG is not set
> > CONFIG_SND_VMASTER=y
> > CONFIG_SND_DMA_SGBUF=y
> > # CONFIG_SND_SEQUENCER is not set
> > CONFIG_SND_MPU401_UART=m
> > CONFIG_SND_AC97_CODEC=m
> > CONFIG_SND_DRIVERS=y
> > CONFIG_SND_PCSP=y
> > CONFIG_SND_DUMMY=y
> > CONFIG_SND_ALOOP=y
> > # CONFIG_SND_MTPAV is not set
> > CONFIG_SND_MTS64=m
> > # CONFIG_SND_SERIAL_U16550 is not set
> > CONFIG_SND_MPU401=m
> > CONFIG_SND_PORTMAN2X4=m
> > CONFIG_SND_AC97_POWER_SAVE=y
> > CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
> > CONFIG_SND_PCI=y
> > # CONFIG_SND_AD1889 is not set
> > # CONFIG_SND_ALS300 is not set
> > # CONFIG_SND_ALS4000 is not set
> > # CONFIG_SND_ALI5451 is not set
> > # CONFIG_SND_ASIHPI is not set
> > # CONFIG_SND_ATIIXP is not set
> > # CONFIG_SND_ATIIXP_MODEM is not set
> > # CONFIG_SND_AU8810 is not set
> > # CONFIG_SND_AU8820 is not set
> > # CONFIG_SND_AU8830 is not set
> > # CONFIG_SND_AW2 is not set
> > # CONFIG_SND_AZT3328 is not set
> > # CONFIG_SND_BT87X is not set
> > # CONFIG_SND_CA0106 is not set
> > # CONFIG_SND_CMIPCI is not set
> > # CONFIG_SND_OXYGEN is not set
> > # CONFIG_SND_CS4281 is not set
> > # CONFIG_SND_CS46XX is not set
> > # CONFIG_SND_CS5530 is not set
> > # CONFIG_SND_CS5535AUDIO is not set
> > # CONFIG_SND_CTXFI is not set
> > # CONFIG_SND_DARLA20 is not set
> > # CONFIG_SND_GINA20 is not set
> > # CONFIG_SND_LAYLA20 is not set
> > # CONFIG_SND_DARLA24 is not set
> > # CONFIG_SND_GINA24 is not set
> > # CONFIG_SND_LAYLA24 is not set
> > # CONFIG_SND_MONA is not set
> > # CONFIG_SND_MIA is not set
> > # CONFIG_SND_ECHO3G is not set
> > # CONFIG_SND_INDIGO is not set
> > # CONFIG_SND_INDIGOIO is not set
> > # CONFIG_SND_INDIGODJ is not set
> > # CONFIG_SND_INDIGOIOX is not set
> > # CONFIG_SND_INDIGODJX is not set
> > # CONFIG_SND_EMU10K1 is not set
> > # CONFIG_SND_EMU10K1X is not set
> > # CONFIG_SND_ENS1370 is not set
> > # CONFIG_SND_ENS1371 is not set
> > # CONFIG_SND_ES1938 is not set
> > # CONFIG_SND_ES1968 is not set
> > # CONFIG_SND_FM801 is not set
> > # CONFIG_SND_HDSP is not set
> > # CONFIG_SND_HDSPM is not set
> > # CONFIG_SND_ICE1712 is not set
> > # CONFIG_SND_ICE1724 is not set
> > # CONFIG_SND_INTEL8X0 is not set
> > # CONFIG_SND_INTEL8X0M is not set
> > # CONFIG_SND_KORG1212 is not set
> > # CONFIG_SND_LOLA is not set
> > # CONFIG_SND_LX6464ES is not set
> > # CONFIG_SND_MAESTRO3 is not set
> > # CONFIG_SND_MIXART is not set
> > # CONFIG_SND_NM256 is not set
> > # CONFIG_SND_PCXHR is not set
> > # CONFIG_SND_RIPTIDE is not set
> > # CONFIG_SND_RME32 is not set
> > # CONFIG_SND_RME96 is not set
> > # CONFIG_SND_RME9652 is not set
> > # CONFIG_SND_SE6X is not set
> > # CONFIG_SND_SIS7019 is not set
> > # CONFIG_SND_SONICVIBES is not set
> > # CONFIG_SND_TRIDENT is not set
> > # CONFIG_SND_VIA82XX is not set
> > # CONFIG_SND_VIA82XX_MODEM is not set
> > # CONFIG_SND_VIRTUOSO is not set
> > # CONFIG_SND_VX222 is not set
> > # CONFIG_SND_YMFPCI is not set
> > 
> > #
> > # HD-Audio
> > #
> > # CONFIG_SND_HDA_INTEL is not set
> > # end of HD-Audio
> > 
> > CONFIG_SND_HDA_PREALLOC_SIZE=2048
> > # CONFIG_SND_FIREWIRE is not set
> > CONFIG_SND_SOC=m
> > CONFIG_SND_SOC_AC97_BUS=y
> > CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
> > CONFIG_SND_SOC_TOPOLOGY=y
> > CONFIG_SND_SOC_ACPI=m
> > CONFIG_SND_SOC_AMD_ACP=m
> > # CONFIG_SND_SOC_AMD_ACP3x is not set
> > # CONFIG_SND_SOC_AMD_RENOIR is not set
> > CONFIG_SND_ATMEL_SOC=m
> > CONFIG_SND_BCM63XX_I2S_WHISTLER=m
> > # CONFIG_SND_DESIGNWARE_I2S is not set
> > 
> > #
> > # SoC Audio for Freescale CPUs
> > #
> > 
> > #
> > # Common SoC Audio options for Freescale CPUs:
> > #
> > # CONFIG_SND_SOC_FSL_ASRC is not set
> > CONFIG_SND_SOC_FSL_SAI=m
> > # CONFIG_SND_SOC_FSL_MQS is not set
> > # CONFIG_SND_SOC_FSL_AUDMIX is not set
> > CONFIG_SND_SOC_FSL_SSI=m
> > CONFIG_SND_SOC_FSL_SPDIF=m
> > CONFIG_SND_SOC_FSL_ESAI=m
> > # CONFIG_SND_SOC_FSL_MICFIL is not set
> > CONFIG_SND_SOC_IMX_AUDMUX=m
> > # end of SoC Audio for Freescale CPUs
> > 
> > CONFIG_SND_I2S_HI6210_I2S=m
> > # CONFIG_SND_SOC_IMG is not set
> > # CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set
> > # CONFIG_SND_SOC_MTK_BTCVSD is not set
> > CONFIG_SND_SOC_SOF_TOPLEVEL=y
> > # CONFIG_SND_SOC_SOF_PCI is not set
> > CONFIG_SND_SOC_SOF_ACPI=m
> > CONFIG_SND_SOC_SOF_OF=m
> > # CONFIG_SND_SOC_SOF_DEBUG_PROBES is not set
> > # CONFIG_SND_SOC_SOF_DEVELOPER_SUPPORT is not set
> > CONFIG_SND_SOC_SOF=m
> > # CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL is not set
> > 
> > #
> > # STMicroelectronics STM32 SOC audio support
> > #
> > # end of STMicroelectronics STM32 SOC audio support
> > 
> > # CONFIG_SND_SOC_XILINX_I2S is not set
> > # CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
> > # CONFIG_SND_SOC_XILINX_SPDIF is not set
> > CONFIG_SND_SOC_XTFPGA_I2S=m
> > # CONFIG_ZX_TDM is not set
> > 
> > #
> > # CODEC drivers
> > #
> > CONFIG_SND_SOC_AC97_CODEC=m
> > CONFIG_SND_SOC_ADAU7002=m
> > CONFIG_SND_SOC_ADAU7118=m
> > CONFIG_SND_SOC_ADAU7118_HW=m
> > CONFIG_SND_SOC_AK4554=m
> > CONFIG_SND_SOC_AK5386=m
> > CONFIG_SND_SOC_BD28623=m
> > CONFIG_SND_SOC_BT_SCO=m
> > CONFIG_SND_SOC_DMIC=m
> > CONFIG_SND_SOC_ES7134=m
> > # CONFIG_SND_SOC_ES7241 is not set
> > CONFIG_SND_SOC_GTM601=m
> > CONFIG_SND_SOC_INNO_RK3036=m
> > # CONFIG_SND_SOC_MAX98357A is not set
> > CONFIG_SND_SOC_MAX98373=m
> > CONFIG_SND_SOC_MAX98373_SDW=m
> > CONFIG_SND_SOC_MSM8916_WCD_ANALOG=m
> > CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
> > # CONFIG_SND_SOC_RK3328 is not set
> > CONFIG_SND_SOC_RL6231=m
> > CONFIG_SND_SOC_RT5682=m
> > CONFIG_SND_SOC_RT5682_SDW=m
> > CONFIG_SND_SOC_RT700=m
> > CONFIG_SND_SOC_RT700_SDW=m
> > CONFIG_SND_SOC_RT711=m
> > CONFIG_SND_SOC_RT711_SDW=m
> > CONFIG_SND_SOC_RT715=m
> > CONFIG_SND_SOC_RT715_SDW=m
> > CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
> > CONFIG_SND_SOC_SIRF_AUDIO_CODEC=m
> > CONFIG_SND_SOC_SPDIF=m
> > # CONFIG_SND_SOC_SSM2305 is not set
> > CONFIG_SND_SOC_STI_SAS=m
> > CONFIG_SND_SOC_UDA1334=m
> > # CONFIG_SND_SOC_WCD9335 is not set
> > CONFIG_SND_SOC_WM8524=m
> > CONFIG_SND_SOC_WM8782=m
> > CONFIG_SND_SOC_WSA881X=m
> > # CONFIG_SND_SOC_MAX9759 is not set
> > # CONFIG_SND_SOC_MT6351 is not set
> > CONFIG_SND_SOC_MT6358=m
> > # end of CODEC drivers
> > 
> > CONFIG_SND_SIMPLE_CARD_UTILS=m
> > CONFIG_SND_SIMPLE_CARD=m
> > CONFIG_SND_AUDIO_GRAPH_CARD=m
> > # CONFIG_SND_X86 is not set
> > CONFIG_AC97_BUS=m
> > 
> > #
> > # HID support
> > #
> > # CONFIG_HID is not set
> > # end of HID support
> > 
> > CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> > CONFIG_USB_SUPPORT=y
> > # CONFIG_USB_LED_TRIG is not set
> > # CONFIG_USB_ULPI_BUS is not set
> > # CONFIG_USB_CONN_GPIO is not set
> > CONFIG_USB_ARCH_HAS_HCD=y
> > # CONFIG_USB is not set
> > CONFIG_USB_PCI=y
> > 
> > #
> > # USB port drivers
> > #
> > 
> > #
> > # USB Physical Layer drivers
> > #
> > # CONFIG_NOP_USB_XCEIV is not set
> > # CONFIG_USB_GPIO_VBUS is not set
> > # end of USB Physical Layer drivers
> > 
> > # CONFIG_USB_GADGET is not set
> > # CONFIG_TYPEC is not set
> > # CONFIG_USB_ROLE_SWITCH is not set
> > CONFIG_MMC=y
> > # CONFIG_PWRSEQ_EMMC is not set
> > # CONFIG_PWRSEQ_SIMPLE is not set
> > # CONFIG_MMC_BLOCK is not set
> > CONFIG_SDIO_UART=m
> > CONFIG_MMC_TEST=m
> > 
> > #
> > # MMC/SD/SDIO Host Controller Drivers
> > #
> > CONFIG_MMC_DEBUG=y
> > CONFIG_MMC_SDHCI=y
> > # CONFIG_MMC_SDHCI_PCI is not set
> > # CONFIG_MMC_SDHCI_ACPI is not set
> > # CONFIG_MMC_SDHCI_PLTFM is not set
> > # CONFIG_MMC_WBSD is not set
> > # CONFIG_MMC_TIFM_SD is not set
> > CONFIG_MMC_GOLDFISH=y
> > # CONFIG_MMC_CB710 is not set
> > # CONFIG_MMC_VIA_SDMMC is not set
> > # CONFIG_MMC_USDHI6ROL0 is not set
> > CONFIG_MMC_CQHCI=m
> > CONFIG_MMC_HSQ=y
> > # CONFIG_MMC_TOSHIBA_PCI is not set
> > CONFIG_MMC_MTK=m
> > CONFIG_MEMSTICK=y
> > CONFIG_MEMSTICK_DEBUG=y
> > 
> > #
> > # MemoryStick drivers
> > #
> > # CONFIG_MEMSTICK_UNSAFE_RESUME is not set
> > CONFIG_MSPRO_BLOCK=y
> > # CONFIG_MS_BLOCK is not set
> > 
> > #
> > # MemoryStick Host Controller Drivers
> > #
> > # CONFIG_MEMSTICK_TIFM_MS is not set
> > # CONFIG_MEMSTICK_JMICRON_38X is not set
> > # CONFIG_MEMSTICK_R592 is not set
> > CONFIG_NEW_LEDS=y
> > CONFIG_LEDS_CLASS=m
> > # CONFIG_LEDS_CLASS_FLASH is not set
> > # CONFIG_LEDS_CLASS_MULTICOLOR is not set
> > # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
> > 
> > #
> > # LED drivers
> > #
> > CONFIG_LEDS_APU=m
> > CONFIG_LEDS_BCM6328=m
> > CONFIG_LEDS_BCM6358=m
> > CONFIG_LEDS_MT6323=m
> > # CONFIG_LEDS_GPIO is not set
> > # CONFIG_LEDS_CLEVO_MAIL is not set
> > CONFIG_LEDS_PWM=m
> > CONFIG_LEDS_REGULATOR=m
> > # CONFIG_LEDS_INTEL_SS4200 is not set
> > CONFIG_LEDS_LT3593=m
> > # CONFIG_LEDS_OT200 is not set
> > 
> > #
> > # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> > #
> > CONFIG_LEDS_MLXCPLD=m
> > CONFIG_LEDS_MLXREG=m
> > CONFIG_LEDS_USER=m
> > # CONFIG_LEDS_NIC78BX is not set
> > CONFIG_LEDS_TI_LMU_COMMON=m
> > 
> > #
> > # LED Triggers
> > #
> > CONFIG_LEDS_TRIGGERS=y
> > # CONFIG_LEDS_TRIGGER_TIMER is not set
> > CONFIG_LEDS_TRIGGER_ONESHOT=y
> > CONFIG_LEDS_TRIGGER_MTD=y
> > # CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
> > # CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
> > # CONFIG_LEDS_TRIGGER_CPU is not set
> > CONFIG_LEDS_TRIGGER_ACTIVITY=m
> > CONFIG_LEDS_TRIGGER_GPIO=m
> > CONFIG_LEDS_TRIGGER_DEFAULT_ON=m
> > 
> > #
> > # iptables trigger is under Netfilter config (LED target)
> > #
> > # CONFIG_LEDS_TRIGGER_TRANSIENT is not set
> > # CONFIG_LEDS_TRIGGER_CAMERA is not set
> > CONFIG_LEDS_TRIGGER_PANIC=y
> > # CONFIG_LEDS_TRIGGER_NETDEV is not set
> > CONFIG_LEDS_TRIGGER_PATTERN=m
> > CONFIG_LEDS_TRIGGER_AUDIO=m
> > CONFIG_ACCESSIBILITY=y
> > 
> > #
> > # Speakup console speech
> > #
> > # end of Speakup console speech
> > 
> > # CONFIG_INFINIBAND is not set
> > CONFIG_EDAC_ATOMIC_SCRUB=y
> > CONFIG_EDAC_SUPPORT=y
> > CONFIG_EDAC=m
> > # CONFIG_EDAC_LEGACY_SYSFS is not set
> > CONFIG_EDAC_DEBUG=y
> > # CONFIG_EDAC_AMD76X is not set
> > # CONFIG_EDAC_E7XXX is not set
> > # CONFIG_EDAC_E752X is not set
> > # CONFIG_EDAC_I82875P is not set
> > # CONFIG_EDAC_I82975X is not set
> > # CONFIG_EDAC_I3000 is not set
> > # CONFIG_EDAC_I3200 is not set
> > # CONFIG_EDAC_IE31200 is not set
> > # CONFIG_EDAC_X38 is not set
> > # CONFIG_EDAC_I5400 is not set
> > # CONFIG_EDAC_I82860 is not set
> > # CONFIG_EDAC_R82600 is not set
> > # CONFIG_EDAC_I5000 is not set
> > # CONFIG_EDAC_I5100 is not set
> > # CONFIG_EDAC_I7300 is not set
> > CONFIG_RTC_LIB=y
> > CONFIG_RTC_MC146818_LIB=y
> > CONFIG_RTC_CLASS=y
> > CONFIG_RTC_HCTOSYS=y
> > CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
> > CONFIG_RTC_SYSTOHC=y
> > CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
> > # CONFIG_RTC_DEBUG is not set
> > CONFIG_RTC_NVMEM=y
> > 
> > #
> > # RTC interfaces
> > #
> > CONFIG_RTC_INTF_SYSFS=y
> > CONFIG_RTC_INTF_PROC=y
> > CONFIG_RTC_INTF_DEV=y
> > # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> > CONFIG_RTC_DRV_TEST=m
> > 
> > #
> > # I2C RTC drivers
> > #
> > 
> > #
> > # SPI RTC drivers
> > #
> > 
> > #
> > # SPI and I2C RTC drivers
> > #
> > 
> > #
> > # Platform RTC drivers
> > #
> > CONFIG_RTC_DRV_CMOS=y
> > CONFIG_RTC_DRV_DS1286=m
> > CONFIG_RTC_DRV_DS1511=m
> > CONFIG_RTC_DRV_DS1553=y
> > CONFIG_RTC_DRV_DS1685_FAMILY=m
> > # CONFIG_RTC_DRV_DS1685 is not set
> > CONFIG_RTC_DRV_DS1689=y
> > # CONFIG_RTC_DRV_DS17285 is not set
> > # CONFIG_RTC_DRV_DS17485 is not set
> > # CONFIG_RTC_DRV_DS17885 is not set
> > # CONFIG_RTC_DRV_DS1742 is not set
> > # CONFIG_RTC_DRV_DS2404 is not set
> > CONFIG_RTC_DRV_STK17TA8=y
> > CONFIG_RTC_DRV_M48T86=m
> > CONFIG_RTC_DRV_M48T35=y
> > CONFIG_RTC_DRV_M48T59=y
> > # CONFIG_RTC_DRV_MSM6242 is not set
> > CONFIG_RTC_DRV_BQ4802=y
> > CONFIG_RTC_DRV_RP5C01=y
> > # CONFIG_RTC_DRV_V3020 is not set
> > CONFIG_RTC_DRV_ZYNQMP=m
> > 
> > #
> > # on-CPU RTC drivers
> > #
> > CONFIG_RTC_DRV_CADENCE=y
> > # CONFIG_RTC_DRV_FTRTC010 is not set
> > CONFIG_RTC_DRV_MT6397=y
> > CONFIG_RTC_DRV_R7301=y
> > 
> > #
> > # HID Sensor RTC drivers
> > #
> > # CONFIG_RTC_DRV_GOLDFISH is not set
> > # CONFIG_DMADEVICES is not set
> > 
> > #
> > # DMABUF options
> > #
> > # CONFIG_SYNC_FILE is not set
> > # CONFIG_UDMABUF is not set
> > CONFIG_DMABUF_MOVE_NOTIFY=y
> > # CONFIG_DMABUF_SELFTESTS is not set
> > # CONFIG_DMABUF_HEAPS is not set
> > # end of DMABUF options
> > 
> > CONFIG_AUXDISPLAY=y
> > # CONFIG_HD44780 is not set
> > CONFIG_IMG_ASCII_LCD=m
> > CONFIG_PARPORT_PANEL=m
> > CONFIG_PANEL_PARPORT=0
> > CONFIG_PANEL_PROFILE=5
> > CONFIG_PANEL_CHANGE_MESSAGE=y
> > CONFIG_PANEL_BOOT_MESSAGE=""
> > # CONFIG_CHARLCD_BL_OFF is not set
> > CONFIG_CHARLCD_BL_ON=y
> > # CONFIG_CHARLCD_BL_FLASH is not set
> > CONFIG_PANEL=m
> > CONFIG_CHARLCD=m
> > # CONFIG_UIO is not set
> > CONFIG_VIRT_DRIVERS=y
> > # CONFIG_VBOXGUEST is not set
> > CONFIG_VIRTIO=y
> > # CONFIG_VIRTIO_MENU is not set
> > CONFIG_VDPA=m
> > # CONFIG_VDPA_SIM is not set
> > CONFIG_VHOST_IOTLB=m
> > CONFIG_VHOST_RING=m
> > # CONFIG_VHOST_MENU is not set
> > 
> > #
> > # Microsoft Hyper-V guest support
> > #
> > # CONFIG_HYPERV is not set
> > # end of Microsoft Hyper-V guest support
> > 
> > CONFIG_GREYBUS=y
> > CONFIG_STAGING=y
> > CONFIG_COMEDI=y
> > # CONFIG_COMEDI_DEBUG is not set
> > CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
> > CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
> > # CONFIG_COMEDI_MISC_DRIVERS is not set
> > CONFIG_COMEDI_ISA_DRIVERS=y
> > # CONFIG_COMEDI_PCL711 is not set
> > # CONFIG_COMEDI_PCL724 is not set
> > CONFIG_COMEDI_PCL726=m
> > # CONFIG_COMEDI_PCL730 is not set
> > CONFIG_COMEDI_PCL812=y
> > # CONFIG_COMEDI_PCL816 is not set
> > # CONFIG_COMEDI_PCL818 is not set
> > # CONFIG_COMEDI_PCM3724 is not set
> > # CONFIG_COMEDI_AMPLC_DIO200_ISA is not set
> > # CONFIG_COMEDI_AMPLC_PC236_ISA is not set
> > CONFIG_COMEDI_AMPLC_PC263_ISA=m
> > CONFIG_COMEDI_RTI800=y
> > CONFIG_COMEDI_RTI802=m
> > CONFIG_COMEDI_DAC02=y
> > CONFIG_COMEDI_DAS16M1=y
> > CONFIG_COMEDI_DAS08_ISA=m
> > CONFIG_COMEDI_DAS16=m
> > CONFIG_COMEDI_DAS800=m
> > # CONFIG_COMEDI_DAS1800 is not set
> > CONFIG_COMEDI_DAS6402=y
> > CONFIG_COMEDI_DT2801=y
> > # CONFIG_COMEDI_DT2811 is not set
> > CONFIG_COMEDI_DT2814=y
> > CONFIG_COMEDI_DT2815=m
> > # CONFIG_COMEDI_DT2817 is not set
> > CONFIG_COMEDI_DT282X=m
> > CONFIG_COMEDI_DMM32AT=y
> > CONFIG_COMEDI_FL512=m
> > CONFIG_COMEDI_AIO_AIO12_8=m
> > CONFIG_COMEDI_AIO_IIRO_16=y
> > CONFIG_COMEDI_II_PCI20KC=m
> > # CONFIG_COMEDI_C6XDIGIO is not set
> > CONFIG_COMEDI_MPC624=y
> > CONFIG_COMEDI_ADQ12B=y
> > # CONFIG_COMEDI_NI_AT_A2150 is not set
> > CONFIG_COMEDI_NI_AT_AO=y
> > CONFIG_COMEDI_NI_ATMIO=m
> > CONFIG_COMEDI_NI_ATMIO16D=y
> > # CONFIG_COMEDI_NI_LABPC_ISA is not set
> > CONFIG_COMEDI_PCMAD=m
> > # CONFIG_COMEDI_PCMDA12 is not set
> > CONFIG_COMEDI_PCMMIO=m
> > CONFIG_COMEDI_PCMUIO=m
> > # CONFIG_COMEDI_MULTIQ3 is not set
> > CONFIG_COMEDI_S526=m
> > # CONFIG_COMEDI_PCI_DRIVERS is not set
> > CONFIG_COMEDI_8254=y
> > CONFIG_COMEDI_8255=y
> > # CONFIG_COMEDI_8255_SA is not set
> > # CONFIG_COMEDI_KCOMEDILIB is not set
> > CONFIG_COMEDI_DAS08=m
> > CONFIG_COMEDI_ISADMA=y
> > CONFIG_COMEDI_NI_TIO=m
> > CONFIG_COMEDI_NI_ROUTING=m
> > # CONFIG_RTLLIB is not set
> > # CONFIG_RTS5208 is not set
> > 
> > #
> > # IIO staging drivers
> > #
> > 
> > #
> > # Accelerometers
> > #
> > # end of Accelerometers
> > 
> > #
> > # Analog to digital converters
> > #
> > # end of Analog to digital converters
> > 
> > #
> > # Analog digital bi-direction converters
> > #
> > CONFIG_ADT7316=m
> > # end of Analog digital bi-direction converters
> > 
> > #
> > # Capacitance to digital converters
> > #
> > # end of Capacitance to digital converters
> > 
> > #
> > # Direct Digital Synthesis
> > #
> > # end of Direct Digital Synthesis
> > 
> > #
> > # Network Analyzer, Impedance Converters
> > #
> > # end of Network Analyzer, Impedance Converters
> > 
> > #
> > # Active energy metering IC
> > #
> > # end of Active energy metering IC
> > 
> > #
> > # Resolver to digital converters
> > #
> > # end of Resolver to digital converters
> > # end of IIO staging drivers
> > 
> > # CONFIG_STAGING_MEDIA is not set
> > 
> > #
> > # Android
> > #
> > # CONFIG_ASHMEM is not set
> > # CONFIG_ION is not set
> > # end of Android
> > 
> > # CONFIG_STAGING_BOARD is not set
> > CONFIG_FIREWIRE_SERIAL=m
> > CONFIG_FWTTY_MAX_TOTAL_PORTS=64
> > CONFIG_FWTTY_MAX_CARD_PORTS=32
> > CONFIG_GOLDFISH_AUDIO=y
> > CONFIG_GS_FPGABOOT=y
> > CONFIG_UNISYSSPAR=y
> > # CONFIG_MOST_COMPONENTS is not set
> > # CONFIG_KS7010 is not set
> > CONFIG_GREYBUS_AUDIO=m
> > CONFIG_GREYBUS_AUDIO_APB_CODEC=m
> > CONFIG_GREYBUS_BOOTROM=m
> > CONFIG_GREYBUS_LIGHT=m
> > CONFIG_GREYBUS_LOG=m
> > CONFIG_GREYBUS_LOOPBACK=m
> > # CONFIG_GREYBUS_POWER is not set
> > CONFIG_GREYBUS_RAW=m
> > CONFIG_GREYBUS_VIBRATOR=m
> > CONFIG_GREYBUS_BRIDGED_PHY=y
> > CONFIG_GREYBUS_GPIO=m
> > # CONFIG_GREYBUS_PWM is not set
> > # CONFIG_GREYBUS_SDIO is not set
> > CONFIG_GREYBUS_UART=y
> > 
> > #
> > # Gasket devices
> > #
> > # end of Gasket devices
> > 
> > CONFIG_XIL_AXIS_FIFO=y
> > CONFIG_FIELDBUS_DEV=y
> > # CONFIG_HMS_ANYBUSS_BUS is not set
> > # CONFIG_QLGE is not set
> > # CONFIG_X86_PLATFORM_DEVICES is not set
> > CONFIG_PMC_ATOM=y
> > # CONFIG_GOLDFISH_PIPE is not set
> > # CONFIG_MFD_CROS_EC is not set
> > # CONFIG_CHROME_PLATFORMS is not set
> > CONFIG_MELLANOX_PLATFORM=y
> > # CONFIG_MLXREG_IO is not set
> > CONFIG_OLPC_EC=y
> > CONFIG_HAVE_CLK=y
> > CONFIG_CLKDEV_LOOKUP=y
> > CONFIG_HAVE_CLK_PREPARE=y
> > CONFIG_COMMON_CLK=y
> > # CONFIG_CLK_HSDK is not set
> > # CONFIG_COMMON_CLK_PWM is not set
> > # CONFIG_COMMON_CLK_FIXED_MMIO is not set
> > # CONFIG_CLK_LGM_CGU is not set
> > # CONFIG_HWSPINLOCK is not set
> > 
> > #
> > # Clock Source drivers
> > #
> > CONFIG_TIMER_OF=y
> > CONFIG_TIMER_PROBE=y
> > CONFIG_CLKSRC_I8253=y
> > CONFIG_CLKEVT_I8253=y
> > CONFIG_I8253_LOCK=y
> > CONFIG_CLKBLD_I8253=y
> > CONFIG_CLKSRC_MMIO=y
> > CONFIG_MICROCHIP_PIT64B=y
> > # end of Clock Source drivers
> > 
> > CONFIG_MAILBOX=y
> > CONFIG_PLATFORM_MHU=m
> > # CONFIG_PCC is not set
> > CONFIG_ALTERA_MBOX=y
> > CONFIG_MAILBOX_TEST=m
> > CONFIG_IOMMU_SUPPORT=y
> > 
> > #
> > # Generic IOMMU Pagetable Support
> > #
> > # end of Generic IOMMU Pagetable Support
> > 
> > CONFIG_IOMMU_DEBUGFS=y
> > 
> > #
> > # Remoteproc drivers
> > #
> > CONFIG_REMOTEPROC=y
> > # CONFIG_REMOTEPROC_CDEV is not set
> > # end of Remoteproc drivers
> > 
> > #
> > # Rpmsg drivers
> > #
> > CONFIG_RPMSG=y
> > # CONFIG_RPMSG_CHAR is not set
> > CONFIG_RPMSG_QCOM_GLINK=y
> > CONFIG_RPMSG_QCOM_GLINK_RPM=y
> > CONFIG_RPMSG_VIRTIO=y
> > # end of Rpmsg drivers
> > 
> > CONFIG_SOUNDWIRE=m
> > 
> > #
> > # SoundWire Devices
> > #
> > # CONFIG_SOUNDWIRE_INTEL is not set
> > CONFIG_SOUNDWIRE_QCOM=m
> > 
> > #
> > # SOC (System On Chip) specific Drivers
> > #
> > 
> > #
> > # Amlogic SoC drivers
> > #
> > # end of Amlogic SoC drivers
> > 
> > #
> > # Aspeed SoC drivers
> > #
> > # end of Aspeed SoC drivers
> > 
> > #
> > # Broadcom SoC drivers
> > #
> > # end of Broadcom SoC drivers
> > 
> > #
> > # NXP/Freescale QorIQ SoC drivers
> > #
> > # end of NXP/Freescale QorIQ SoC drivers
> > 
> > #
> > # i.MX SoC drivers
> > #
> > # end of i.MX SoC drivers
> > 
> > #
> > # Qualcomm SoC drivers
> > #
> > # end of Qualcomm SoC drivers
> > 
> > # CONFIG_SOC_TI is not set
> > 
> > #
> > # Xilinx SoC drivers
> > #
> > # CONFIG_XILINX_VCU is not set
> > # end of Xilinx SoC drivers
> > # end of SOC (System On Chip) specific Drivers
> > 
> > CONFIG_PM_DEVFREQ=y
> > 
> > #
> > # DEVFREQ Governors
> > #
> > CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
> > # CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
> > # CONFIG_DEVFREQ_GOV_POWERSAVE is not set
> > CONFIG_DEVFREQ_GOV_USERSPACE=m
> > CONFIG_DEVFREQ_GOV_PASSIVE=m
> > 
> > #
> > # DEVFREQ Drivers
> > #
> > CONFIG_PM_DEVFREQ_EVENT=y
> > CONFIG_EXTCON=y
> > 
> > #
> > # Extcon Device Drivers
> > #
> > # CONFIG_EXTCON_ADC_JACK is not set
> > CONFIG_EXTCON_GPIO=m
> > # CONFIG_EXTCON_INTEL_INT3496 is not set
> > CONFIG_EXTCON_MAX3355=m
> > CONFIG_EXTCON_USB_GPIO=y
> > CONFIG_MEMORY=y
> > CONFIG_IIO=m
> > CONFIG_IIO_BUFFER=y
> > CONFIG_IIO_BUFFER_CB=m
> > CONFIG_IIO_BUFFER_DMA=m
> > CONFIG_IIO_BUFFER_DMAENGINE=m
> > CONFIG_IIO_BUFFER_HW_CONSUMER=m
> > CONFIG_IIO_KFIFO_BUF=m
> > CONFIG_IIO_TRIGGERED_BUFFER=m
> > CONFIG_IIO_CONFIGFS=m
> > CONFIG_IIO_TRIGGER=y
> > CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
> > CONFIG_IIO_SW_DEVICE=m
> > # CONFIG_IIO_SW_TRIGGER is not set
> > 
> > #
> > # Accelerometers
> > #
> > CONFIG_BMA400=m
> > # CONFIG_BMC150_ACCEL is not set
> > CONFIG_KXSD9=m
> > # end of Accelerometers
> > 
> > #
> > # Analog to digital converters
> > #
> > CONFIG_AD7606=m
> > CONFIG_AD7606_IFACE_PARALLEL=m
> > CONFIG_ADI_AXI_ADC=m
> > # CONFIG_CC10001_ADC is not set
> > # CONFIG_ENVELOPE_DETECTOR is not set
> > # CONFIG_HX711 is not set
> > CONFIG_MEN_Z188_ADC=m
> > CONFIG_QCOM_VADC_COMMON=m
> > # CONFIG_QCOM_SPMI_IADC is not set
> > CONFIG_QCOM_SPMI_VADC=m
> > CONFIG_QCOM_SPMI_ADC5=m
> > CONFIG_SD_ADC_MODULATOR=m
> > # CONFIG_STX104 is not set
> > # CONFIG_VF610_ADC is not set
> > # CONFIG_XILINX_XADC is not set
> > # end of Analog to digital converters
> > 
> > #
> > # Analog Front Ends
> > #
> > # CONFIG_IIO_RESCALE is not set
> > # end of Analog Front Ends
> > 
> > #
> > # Amplifiers
> > #
> > CONFIG_HMC425=m
> > # end of Amplifiers
> > 
> > #
> > # Chemical Sensors
> > #
> > CONFIG_PMS7003=m
> > CONFIG_SCD30_CORE=m
> > CONFIG_SCD30_SERIAL=m
> > # end of Chemical Sensors
> > 
> > #
> > # Hid Sensor IIO Common
> > #
> > # end of Hid Sensor IIO Common
> > 
> > #
> > # SSP Sensor Common
> > #
> > # end of SSP Sensor Common
> > 
> > #
> > # Digital to analog converters
> > #
> > # CONFIG_CIO_DAC is not set
> > CONFIG_DPOT_DAC=m
> > CONFIG_VF610_DAC=m
> > # end of Digital to analog converters
> > 
> > #
> > # IIO dummy driver
> > #
> > CONFIG_IIO_DUMMY_EVGEN=m
> > CONFIG_IIO_SIMPLE_DUMMY=m
> > CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
> > CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y
> > # end of IIO dummy driver
> > 
> > #
> > # Frequency Synthesizers DDS/PLL
> > #
> > 
> > #
> > # Clock Generator/Distribution
> > #
> > # end of Clock Generator/Distribution
> > 
> > #
> > # Phase-Locked Loop (PLL) frequency synthesizers
> > #
> > # end of Phase-Locked Loop (PLL) frequency synthesizers
> > # end of Frequency Synthesizers DDS/PLL
> > 
> > #
> > # Digital gyroscope sensors
> > #
> > # end of Digital gyroscope sensors
> > 
> > #
> > # Health Sensors
> > #
> > 
> > #
> > # Heart Rate Monitors
> > #
> > # end of Heart Rate Monitors
> > # end of Health Sensors
> > 
> > #
> > # Humidity sensors
> > #
> > # CONFIG_DHT11 is not set
> > # end of Humidity sensors
> > 
> > #
> > # Inertial measurement units
> > #
> > # end of Inertial measurement units
> > 
> > #
> > # Light sensors
> > #
> > # CONFIG_ACPI_ALS is not set
> > # CONFIG_CM3605 is not set
> > # end of Light sensors
> > 
> > #
> > # Magnetometer sensors
> > #
> > # end of Magnetometer sensors
> > 
> > #
> > # Multiplexers
> > #
> > # CONFIG_IIO_MUX is not set
> > # end of Multiplexers
> > 
> > #
> > # Inclinometer sensors
> > #
> > # end of Inclinometer sensors
> > 
> > #
> > # Triggers - standalone
> > #
> > CONFIG_IIO_INTERRUPT_TRIGGER=m
> > CONFIG_IIO_SYSFS_TRIGGER=m
> > # end of Triggers - standalone
> > 
> > #
> > # Linear and angular position sensors
> > #
> > # end of Linear and angular position sensors
> > 
> > #
> > # Digital potentiometers
> > #
> > # end of Digital potentiometers
> > 
> > #
> > # Digital potentiostats
> > #
> > # end of Digital potentiostats
> > 
> > #
> > # Pressure sensors
> > #
> > CONFIG_MS5611=m
> > # CONFIG_ZPA2326 is not set
> > # end of Pressure sensors
> > 
> > #
> > # Lightning sensors
> > #
> > # end of Lightning sensors
> > 
> > #
> > # Proximity and distance sensors
> > #
> > CONFIG_PING=m
> > CONFIG_SRF04=m
> > # end of Proximity and distance sensors
> > 
> > #
> > # Resolver to digital converters
> > #
> > # end of Resolver to digital converters
> > 
> > #
> > # Temperature sensors
> > #
> > # end of Temperature sensors
> > 
> > # CONFIG_NTB is not set
> > # CONFIG_VME_BUS is not set
> > CONFIG_PWM=y
> > CONFIG_PWM_SYSFS=y
> > # CONFIG_PWM_DEBUG is not set
> > # CONFIG_PWM_ATMEL_HLCDC_PWM is not set
> > CONFIG_PWM_FSL_FTM=m
> > # CONFIG_PWM_LPSS_PCI is not set
> > # CONFIG_PWM_LPSS_PLATFORM is not set
> > 
> > #
> > # IRQ chip support
> > #
> > CONFIG_IRQCHIP=y
> > CONFIG_AL_FIC=y
> > CONFIG_MADERA_IRQ=y
> > # end of IRQ chip support
> > 
> > CONFIG_IPACK_BUS=m
> > # CONFIG_BOARD_TPCI200 is not set
> > CONFIG_SERIAL_IPOCTAL=m
> > CONFIG_RESET_CONTROLLER=y
> > # CONFIG_RESET_BRCMSTB_RESCAL is not set
> > CONFIG_RESET_INTEL_GW=y
> > # CONFIG_RESET_TI_SYSCON is not set
> > 
> > #
> > # PHY Subsystem
> > #
> > CONFIG_GENERIC_PHY=y
> > CONFIG_GENERIC_PHY_MIPI_DPHY=y
> > # CONFIG_BCM_KONA_USB2_PHY is not set
> > # CONFIG_PHY_CADENCE_TORRENT is not set
> > CONFIG_PHY_CADENCE_DPHY=y
> > # CONFIG_PHY_CADENCE_SIERRA is not set
> > CONFIG_PHY_CADENCE_SALVO=y
> > CONFIG_PHY_FSL_IMX8MQ_USB=m
> > # CONFIG_PHY_MIXEL_MIPI_DPHY is not set
> > # CONFIG_PHY_PXA_28NM_HSIC is not set
> > CONFIG_PHY_PXA_28NM_USB2=y
> > # CONFIG_PHY_CPCAP_USB is not set
> > # CONFIG_PHY_MAPPHONE_MDM6600 is not set
> > # CONFIG_PHY_OCELOT_SERDES is not set
> > # CONFIG_PHY_INTEL_COMBO is not set
> > # CONFIG_PHY_INTEL_EMMC is not set
> > # end of PHY Subsystem
> > 
> > CONFIG_POWERCAP=y
> > # CONFIG_INTEL_RAPL is not set
> > # CONFIG_IDLE_INJECT is not set
> > CONFIG_MCB=m
> > # CONFIG_MCB_PCI is not set
> > CONFIG_MCB_LPC=m
> > 
> > #
> > # Performance monitor support
> > #
> > # end of Performance monitor support
> > 
> > CONFIG_RAS=y
> > # CONFIG_USB4 is not set
> > 
> > #
> > # Android
> > #
> > CONFIG_ANDROID=y
> > # CONFIG_ANDROID_BINDER_IPC is not set
> > # end of Android
> > 
> > CONFIG_DAX=y
> > CONFIG_DEV_DAX=y
> > CONFIG_NVMEM=y
> > # CONFIG_NVMEM_SYSFS is not set
> > CONFIG_NVMEM_SPMI_SDAM=m
> > 
> > #
> > # HW tracing support
> > #
> > # CONFIG_STM is not set
> > CONFIG_INTEL_TH=y
> > # CONFIG_INTEL_TH_PCI is not set
> > # CONFIG_INTEL_TH_ACPI is not set
> > CONFIG_INTEL_TH_GTH=y
> > # CONFIG_INTEL_TH_MSU is not set
> > CONFIG_INTEL_TH_PTI=m
> > # CONFIG_INTEL_TH_DEBUG is not set
> > # end of HW tracing support
> > 
> > CONFIG_FPGA=y
> > # CONFIG_ALTERA_PR_IP_CORE is not set
> > # CONFIG_FPGA_MGR_ALTERA_CVP is not set
> > CONFIG_FPGA_BRIDGE=y
> > CONFIG_ALTERA_FREEZE_BRIDGE=m
> > # CONFIG_XILINX_PR_DECOUPLER is not set
> > CONFIG_FPGA_REGION=m
> > # CONFIG_OF_FPGA_REGION is not set
> > CONFIG_FPGA_DFL=m
> > # CONFIG_FPGA_DFL_FME is not set
> > # CONFIG_FPGA_DFL_AFU is not set
> > # CONFIG_FPGA_DFL_PCI is not set
> > CONFIG_FSI=m
> > # CONFIG_FSI_NEW_DEV_NODE is not set
> > # CONFIG_FSI_MASTER_GPIO is not set
> > CONFIG_FSI_MASTER_HUB=m
> > CONFIG_FSI_MASTER_ASPEED=m
> > # CONFIG_FSI_SCOM is not set
> > CONFIG_FSI_SBEFIFO=m
> > # CONFIG_FSI_OCC is not set
> > CONFIG_TEE=y
> > 
> > #
> > # TEE drivers
> > #
> > # end of TEE drivers
> > 
> > CONFIG_PM_OPP=y
> > # CONFIG_SIOX is not set
> > CONFIG_SLIMBUS=y
> > CONFIG_SLIM_QCOM_CTRL=m
> > # CONFIG_INTERCONNECT is not set
> > CONFIG_COUNTER=m
> > CONFIG_104_QUAD_8=m
> > # CONFIG_FTM_QUADDEC is not set
> > CONFIG_MICROCHIP_TCB_CAPTURE=m
> > CONFIG_MOST=m
> > # end of Device Drivers
> > 
> > #
> > # File systems
> > #
> > CONFIG_DCACHE_WORD_ACCESS=y
> > CONFIG_VALIDATE_FS_PARSER=y
> > CONFIG_FS_IOMAP=y
> > CONFIG_EXT2_FS=y
> > # CONFIG_EXT2_FS_XATTR is not set
> > CONFIG_EXT3_FS=m
> > # CONFIG_EXT3_FS_POSIX_ACL is not set
> > CONFIG_EXT3_FS_SECURITY=y
> > CONFIG_EXT4_FS=y
> > CONFIG_EXT4_FS_POSIX_ACL=y
> > CONFIG_EXT4_FS_SECURITY=y
> > # CONFIG_EXT4_DEBUG is not set
> > CONFIG_EXT4_KUNIT_TESTS=m
> > CONFIG_JBD2=y
> > # CONFIG_JBD2_DEBUG is not set
> > CONFIG_FS_MBCACHE=y
> > CONFIG_REISERFS_FS=m
> > # CONFIG_REISERFS_CHECK is not set
> > # CONFIG_REISERFS_PROC_INFO is not set
> > # CONFIG_REISERFS_FS_XATTR is not set
> > # CONFIG_JFS_FS is not set
> > # CONFIG_XFS_FS is not set
> > # CONFIG_GFS2_FS is not set
> > # CONFIG_OCFS2_FS is not set
> > # CONFIG_BTRFS_FS is not set
> > # CONFIG_NILFS2_FS is not set
> > CONFIG_F2FS_FS=y
> > CONFIG_F2FS_STAT_FS=y
> > # CONFIG_F2FS_FS_XATTR is not set
> > CONFIG_F2FS_CHECK_FS=y
> > CONFIG_F2FS_IO_TRACE=y
> > # CONFIG_F2FS_FAULT_INJECTION is not set
> > # CONFIG_F2FS_FS_COMPRESSION is not set
> > # CONFIG_FS_DAX is not set
> > CONFIG_FS_POSIX_ACL=y
> > CONFIG_EXPORTFS=y
> > CONFIG_EXPORTFS_BLOCK_OPS=y
> > CONFIG_FILE_LOCKING=y
> > CONFIG_MANDATORY_FILE_LOCKING=y
> > # CONFIG_FS_ENCRYPTION is not set
> > CONFIG_FS_VERITY=y
> > # CONFIG_FS_VERITY_DEBUG is not set
> > CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
> > CONFIG_FSNOTIFY=y
> > # CONFIG_DNOTIFY is not set
> > CONFIG_INOTIFY_USER=y
> > CONFIG_FANOTIFY=y
> > CONFIG_QUOTA=y
> > # CONFIG_QUOTA_NETLINK_INTERFACE is not set
> > CONFIG_PRINT_QUOTA_WARNING=y
> > CONFIG_QUOTA_DEBUG=y
> > CONFIG_QFMT_V1=m
> > # CONFIG_QFMT_V2 is not set
> > CONFIG_QUOTACTL=y
> > CONFIG_AUTOFS4_FS=y
> > CONFIG_AUTOFS_FS=y
> > CONFIG_FUSE_FS=m
> > # CONFIG_CUSE is not set
> > CONFIG_VIRTIO_FS=m
> > # CONFIG_OVERLAY_FS is not set
> > 
> > #
> > # Caches
> > #
> > # CONFIG_FSCACHE is not set
> > # end of Caches
> > 
> > #
> > # CD-ROM/DVD Filesystems
> > #
> > CONFIG_ISO9660_FS=m
> > CONFIG_JOLIET=y
> > CONFIG_ZISOFS=y
> > # CONFIG_UDF_FS is not set
> > # end of CD-ROM/DVD Filesystems
> > 
> > #
> > # DOS/FAT/EXFAT/NT Filesystems
> > #
> > # CONFIG_MSDOS_FS is not set
> > # CONFIG_VFAT_FS is not set
> > # CONFIG_EXFAT_FS is not set
> > CONFIG_NTFS_FS=m
> > # CONFIG_NTFS_DEBUG is not set
> > CONFIG_NTFS_RW=y
> > # end of DOS/FAT/EXFAT/NT Filesystems
> > 
> > #
> > # Pseudo filesystems
> > #
> > CONFIG_PROC_FS=y
> > # CONFIG_PROC_KCORE is not set
> > CONFIG_PROC_SYSCTL=y
> > CONFIG_PROC_PAGE_MONITOR=y
> > CONFIG_PROC_CHILDREN=y
> > CONFIG_PROC_PID_ARCH_STATUS=y
> > CONFIG_PROC_CPU_RESCTRL=y
> > CONFIG_KERNFS=y
> > CONFIG_SYSFS=y
> > CONFIG_TMPFS=y
> > # CONFIG_TMPFS_POSIX_ACL is not set
> > # CONFIG_TMPFS_XATTR is not set
> > CONFIG_HUGETLBFS=y
> > CONFIG_HUGETLB_PAGE=y
> > CONFIG_MEMFD_CREATE=y
> > CONFIG_CONFIGFS_FS=m
> > # end of Pseudo filesystems
> > 
> > # CONFIG_MISC_FILESYSTEMS is not set
> > CONFIG_NETWORK_FILESYSTEMS=y
> > CONFIG_NFS_FS=y
> > CONFIG_NFS_V2=y
> > CONFIG_NFS_V3=y
> > # CONFIG_NFS_V3_ACL is not set
> > CONFIG_NFS_V4=m
> > # CONFIG_NFS_V4_1 is not set
> > # CONFIG_ROOT_NFS is not set
> > # CONFIG_NFS_USE_LEGACY_DNS is not set
> > CONFIG_NFS_USE_KERNEL_DNS=y
> > CONFIG_NFS_DISABLE_UDP_SUPPORT=y
> > # CONFIG_NFSD is not set
> > CONFIG_GRACE_PERIOD=y
> > CONFIG_LOCKD=y
> > CONFIG_LOCKD_V4=y
> > CONFIG_NFS_COMMON=y
> > CONFIG_SUNRPC=y
> > CONFIG_SUNRPC_GSS=m
> > # CONFIG_SUNRPC_DEBUG is not set
> > # CONFIG_CEPH_FS is not set
> > CONFIG_CIFS=m
> > # CONFIG_CIFS_STATS2 is not set
> > CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
> > # CONFIG_CIFS_WEAK_PW_HASH is not set
> > # CONFIG_CIFS_UPCALL is not set
> > # CONFIG_CIFS_XATTR is not set
> > CONFIG_CIFS_DEBUG=y
> > # CONFIG_CIFS_DEBUG2 is not set
> > # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> > # CONFIG_CIFS_DFS_UPCALL is not set
> > # CONFIG_CODA_FS is not set
> > # CONFIG_AFS_FS is not set
> > # CONFIG_9P_FS is not set
> > CONFIG_NLS=y
> > CONFIG_NLS_DEFAULT="iso8859-1"
> > # CONFIG_NLS_CODEPAGE_437 is not set
> > # CONFIG_NLS_CODEPAGE_737 is not set
> > CONFIG_NLS_CODEPAGE_775=y
> > CONFIG_NLS_CODEPAGE_850=y
> > CONFIG_NLS_CODEPAGE_852=m
> > CONFIG_NLS_CODEPAGE_855=y
> > # CONFIG_NLS_CODEPAGE_857 is not set
> > CONFIG_NLS_CODEPAGE_860=y
> > CONFIG_NLS_CODEPAGE_861=m
> > # CONFIG_NLS_CODEPAGE_862 is not set
> > CONFIG_NLS_CODEPAGE_863=m
> > # CONFIG_NLS_CODEPAGE_864 is not set
> > CONFIG_NLS_CODEPAGE_865=y
> > CONFIG_NLS_CODEPAGE_866=y
> > CONFIG_NLS_CODEPAGE_869=y
> > CONFIG_NLS_CODEPAGE_936=y
> > CONFIG_NLS_CODEPAGE_950=y
> > CONFIG_NLS_CODEPAGE_932=m
> > CONFIG_NLS_CODEPAGE_949=m
> > CONFIG_NLS_CODEPAGE_874=y
> > CONFIG_NLS_ISO8859_8=m
> > CONFIG_NLS_CODEPAGE_1250=m
> > CONFIG_NLS_CODEPAGE_1251=y
> > CONFIG_NLS_ASCII=m
> > # CONFIG_NLS_ISO8859_1 is not set
> > CONFIG_NLS_ISO8859_2=y
> > CONFIG_NLS_ISO8859_3=m
> > CONFIG_NLS_ISO8859_4=m
> > CONFIG_NLS_ISO8859_5=y
> > CONFIG_NLS_ISO8859_6=y
> > CONFIG_NLS_ISO8859_7=m
> > # CONFIG_NLS_ISO8859_9 is not set
> > CONFIG_NLS_ISO8859_13=m
> > CONFIG_NLS_ISO8859_14=y
> > # CONFIG_NLS_ISO8859_15 is not set
> > CONFIG_NLS_KOI8_R=y
> > # CONFIG_NLS_KOI8_U is not set
> > # CONFIG_NLS_MAC_ROMAN is not set
> > # CONFIG_NLS_MAC_CELTIC is not set
> > CONFIG_NLS_MAC_CENTEURO=y
> > CONFIG_NLS_MAC_CROATIAN=m
> > CONFIG_NLS_MAC_CYRILLIC=y
> > # CONFIG_NLS_MAC_GAELIC is not set
> > CONFIG_NLS_MAC_GREEK=m
> > # CONFIG_NLS_MAC_ICELAND is not set
> > CONFIG_NLS_MAC_INUIT=m
> > # CONFIG_NLS_MAC_ROMANIAN is not set
> > CONFIG_NLS_MAC_TURKISH=y
> > CONFIG_NLS_UTF8=y
> > # CONFIG_DLM is not set
> > CONFIG_UNICODE=y
> > CONFIG_UNICODE_NORMALIZATION_SELFTEST=y
> > CONFIG_IO_WQ=y
> > # end of File systems
> > 
> > #
> > # Security options
> > #
> > CONFIG_KEYS=y
> > # CONFIG_KEYS_REQUEST_CACHE is not set
> > # CONFIG_PERSISTENT_KEYRINGS is not set
> > # CONFIG_BIG_KEYS is not set
> > CONFIG_TRUSTED_KEYS=y
> > CONFIG_ENCRYPTED_KEYS=m
> > # CONFIG_KEY_DH_OPERATIONS is not set
> > # CONFIG_SECURITY_DMESG_RESTRICT is not set
> > # CONFIG_SECURITY is not set
> > CONFIG_SECURITYFS=y
> > CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> > CONFIG_HARDENED_USERCOPY=y
> > # CONFIG_HARDENED_USERCOPY_FALLBACK is not set
> > # CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
> > # CONFIG_FORTIFY_SOURCE is not set
> > # CONFIG_STATIC_USERMODEHELPER is not set
> > CONFIG_DEFAULT_SECURITY_DAC=y
> > CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"
> > 
> > #
> > # Kernel hardening options
> > #
> > 
> > #
> > # Memory initialization
> > #
> > CONFIG_INIT_STACK_NONE=y
> > CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
> > CONFIG_INIT_ON_FREE_DEFAULT_ON=y
> > # end of Memory initialization
> > # end of Kernel hardening options
> > # end of Security options
> > 
> > CONFIG_CRYPTO=y
> > 
> > #
> > # Crypto core or helper
> > #
> > CONFIG_CRYPTO_ALGAPI=y
> > CONFIG_CRYPTO_ALGAPI2=y
> > CONFIG_CRYPTO_AEAD=y
> > CONFIG_CRYPTO_AEAD2=y
> > CONFIG_CRYPTO_SKCIPHER=y
> > CONFIG_CRYPTO_SKCIPHER2=y
> > CONFIG_CRYPTO_HASH=y
> > CONFIG_CRYPTO_HASH2=y
> > CONFIG_CRYPTO_RNG=m
> > CONFIG_CRYPTO_RNG2=y
> > CONFIG_CRYPTO_RNG_DEFAULT=m
> > CONFIG_CRYPTO_AKCIPHER2=y
> > CONFIG_CRYPTO_AKCIPHER=y
> > CONFIG_CRYPTO_KPP2=y
> > CONFIG_CRYPTO_KPP=m
> > CONFIG_CRYPTO_ACOMP2=y
> > CONFIG_CRYPTO_MANAGER=y
> > CONFIG_CRYPTO_MANAGER2=y
> > # CONFIG_CRYPTO_USER is not set
> > CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> > CONFIG_CRYPTO_GF128MUL=m
> > CONFIG_CRYPTO_NULL=y
> > CONFIG_CRYPTO_NULL2=y
> > CONFIG_CRYPTO_PCRYPT=m
> > CONFIG_CRYPTO_CRYPTD=y
> > CONFIG_CRYPTO_AUTHENC=y
> > # CONFIG_CRYPTO_TEST is not set
> > CONFIG_CRYPTO_SIMD=y
> > CONFIG_CRYPTO_GLUE_HELPER_X86=y
> > 
> > #
> > # Public-key cryptography
> > #
> > CONFIG_CRYPTO_RSA=y
> > # CONFIG_CRYPTO_DH is not set
> > # CONFIG_CRYPTO_ECDH is not set
> > # CONFIG_CRYPTO_ECRDSA is not set
> > CONFIG_CRYPTO_CURVE25519=m
> > 
> > #
> > # Authenticated Encryption with Associated Data
> > #
> > CONFIG_CRYPTO_CCM=m
> > CONFIG_CRYPTO_GCM=m
> > CONFIG_CRYPTO_CHACHA20POLY1305=y
> > # CONFIG_CRYPTO_AEGIS128 is not set
> > CONFIG_CRYPTO_SEQIV=m
> > CONFIG_CRYPTO_ECHAINIV=m
> > 
> > #
> > # Block modes
> > #
> > CONFIG_CRYPTO_CBC=m
> > CONFIG_CRYPTO_CFB=m
> > CONFIG_CRYPTO_CTR=m
> > CONFIG_CRYPTO_CTS=y
> > CONFIG_CRYPTO_ECB=y
> > CONFIG_CRYPTO_LRW=m
> > CONFIG_CRYPTO_OFB=m
> > CONFIG_CRYPTO_PCBC=m
> > # CONFIG_CRYPTO_XTS is not set
> > CONFIG_CRYPTO_KEYWRAP=m
> > CONFIG_CRYPTO_NHPOLY1305=m
> > CONFIG_CRYPTO_ADIANTUM=m
> > CONFIG_CRYPTO_ESSIV=m
> > 
> > #
> > # Hash modes
> > #
> > CONFIG_CRYPTO_CMAC=y
> > CONFIG_CRYPTO_HMAC=y
> > CONFIG_CRYPTO_XCBC=m
> > CONFIG_CRYPTO_VMAC=m
> > 
> > #
> > # Digest
> > #
> > CONFIG_CRYPTO_CRC32C=y
> > CONFIG_CRYPTO_CRC32C_INTEL=y
> > CONFIG_CRYPTO_CRC32=y
> > # CONFIG_CRYPTO_CRC32_PCLMUL is not set
> > CONFIG_CRYPTO_XXHASH=m
> > # CONFIG_CRYPTO_BLAKE2B is not set
> > # CONFIG_CRYPTO_BLAKE2S is not set
> > CONFIG_CRYPTO_CRCT10DIF=y
> > CONFIG_CRYPTO_GHASH=m
> > CONFIG_CRYPTO_POLY1305=y
> > CONFIG_CRYPTO_MD4=m
> > CONFIG_CRYPTO_MD5=m
> > CONFIG_CRYPTO_MICHAEL_MIC=m
> > # CONFIG_CRYPTO_RMD128 is not set
> > CONFIG_CRYPTO_RMD160=m
> > # CONFIG_CRYPTO_RMD256 is not set
> > CONFIG_CRYPTO_RMD320=y
> > CONFIG_CRYPTO_SHA1=y
> > CONFIG_CRYPTO_SHA256=y
> > CONFIG_CRYPTO_SHA512=m
> > # CONFIG_CRYPTO_SHA3 is not set
> > CONFIG_CRYPTO_SM3=m
> > CONFIG_CRYPTO_STREEBOG=m
> > CONFIG_CRYPTO_TGR192=y
> > CONFIG_CRYPTO_WP512=y
> > 
> > #
> > # Ciphers
> > #
> > CONFIG_CRYPTO_AES=m
> > # CONFIG_CRYPTO_AES_TI is not set
> > # CONFIG_CRYPTO_AES_NI_INTEL is not set
> > # CONFIG_CRYPTO_ANUBIS is not set
> > # CONFIG_CRYPTO_ARC4 is not set
> > CONFIG_CRYPTO_BLOWFISH=y
> > CONFIG_CRYPTO_BLOWFISH_COMMON=y
> > CONFIG_CRYPTO_CAMELLIA=y
> > CONFIG_CRYPTO_CAST_COMMON=y
> > CONFIG_CRYPTO_CAST5=y
> > CONFIG_CRYPTO_CAST6=m
> > CONFIG_CRYPTO_DES=y
> > # CONFIG_CRYPTO_FCRYPT is not set
> > # CONFIG_CRYPTO_KHAZAD is not set
> > CONFIG_CRYPTO_SALSA20=m
> > CONFIG_CRYPTO_CHACHA20=y
> > # CONFIG_CRYPTO_SEED is not set
> > CONFIG_CRYPTO_SERPENT=y
> > CONFIG_CRYPTO_SERPENT_SSE2_586=y
> > CONFIG_CRYPTO_SM4=m
> > # CONFIG_CRYPTO_TEA is not set
> > # CONFIG_CRYPTO_TWOFISH is not set
> > CONFIG_CRYPTO_TWOFISH_COMMON=m
> > CONFIG_CRYPTO_TWOFISH_586=m
> > 
> > #
> > # Compression
> > #
> > # CONFIG_CRYPTO_DEFLATE is not set
> > CONFIG_CRYPTO_LZO=y
> > CONFIG_CRYPTO_842=m
> > # CONFIG_CRYPTO_LZ4 is not set
> > CONFIG_CRYPTO_LZ4HC=y
> > # CONFIG_CRYPTO_ZSTD is not set
> > 
> > #
> > # Random Number Generation
> > #
> > CONFIG_CRYPTO_ANSI_CPRNG=m
> > CONFIG_CRYPTO_DRBG_MENU=m
> > CONFIG_CRYPTO_DRBG_HMAC=y
> > CONFIG_CRYPTO_DRBG_HASH=y
> > # CONFIG_CRYPTO_DRBG_CTR is not set
> > CONFIG_CRYPTO_DRBG=m
> > CONFIG_CRYPTO_JITTERENTROPY=m
> > # CONFIG_CRYPTO_USER_API_HASH is not set
> > # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> > # CONFIG_CRYPTO_USER_API_RNG is not set
> > # CONFIG_CRYPTO_USER_API_AEAD is not set
> > CONFIG_CRYPTO_HASH_INFO=y
> > 
> > #
> > # Crypto library routines
> > #
> > CONFIG_CRYPTO_LIB_AES=m
> > CONFIG_CRYPTO_LIB_ARC4=m
> > CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=m
> > CONFIG_CRYPTO_LIB_BLAKE2S=m
> > CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
> > CONFIG_CRYPTO_LIB_CHACHA=y
> > CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
> > CONFIG_CRYPTO_LIB_CURVE25519=y
> > CONFIG_CRYPTO_LIB_DES=y
> > CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
> > CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
> > CONFIG_CRYPTO_LIB_POLY1305=y
> > CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
> > CONFIG_CRYPTO_LIB_SHA256=y
> > # CONFIG_CRYPTO_HW is not set
> > CONFIG_ASYMMETRIC_KEY_TYPE=y
> > CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> > CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE=m
> > CONFIG_X509_CERTIFICATE_PARSER=y
> > # CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
> > CONFIG_TPM_KEY_PARSER=m
> > CONFIG_PKCS7_MESSAGE_PARSER=y
> > CONFIG_PKCS7_TEST_KEY=y
> > # CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
> > 
> > #
> > # Certificates for signature checking
> > #
> > CONFIG_SYSTEM_TRUSTED_KEYRING=y
> > CONFIG_SYSTEM_TRUSTED_KEYS=""
> > # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> > # CONFIG_SECONDARY_TRUSTED_KEYRING is not set
> > CONFIG_SYSTEM_BLACKLIST_KEYRING=y
> > CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
> > # end of Certificates for signature checking
> > 
> > CONFIG_BINARY_PRINTF=y
> > 
> > #
> > # Library routines
> > #
> > CONFIG_LINEAR_RANGES=y
> > # CONFIG_PACKING is not set
> > CONFIG_BITREVERSE=y
> > CONFIG_GENERIC_STRNCPY_FROM_USER=y
> > CONFIG_GENERIC_STRNLEN_USER=y
> > CONFIG_GENERIC_NET_UTILS=y
> > CONFIG_GENERIC_FIND_FIRST_BIT=y
> > CONFIG_CORDIC=m
> > CONFIG_PRIME_NUMBERS=m
> > CONFIG_RATIONAL=y
> > CONFIG_GENERIC_PCI_IOMAP=y
> > CONFIG_GENERIC_IOMAP=y
> > CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> > CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
> > CONFIG_CRC_CCITT=y
> > CONFIG_CRC16=y
> > CONFIG_CRC_T10DIF=y
> > CONFIG_CRC_ITU_T=y
> > CONFIG_CRC32=y
> > CONFIG_CRC32_SELFTEST=y
> > CONFIG_CRC32_SLICEBY8=y
> > # CONFIG_CRC32_SLICEBY4 is not set
> > # CONFIG_CRC32_SARWATE is not set
> > # CONFIG_CRC32_BIT is not set
> > CONFIG_CRC64=y
> > CONFIG_CRC4=y
> > CONFIG_CRC7=m
> > CONFIG_LIBCRC32C=y
> > CONFIG_CRC8=y
> > CONFIG_XXHASH=m
> > # CONFIG_RANDOM32_SELFTEST is not set
> > CONFIG_842_COMPRESS=m
> > CONFIG_842_DECOMPRESS=m
> > CONFIG_ZLIB_INFLATE=y
> > CONFIG_LZO_COMPRESS=y
> > CONFIG_LZO_DECOMPRESS=y
> > CONFIG_LZ4HC_COMPRESS=y
> > CONFIG_LZ4_DECOMPRESS=y
> > CONFIG_XZ_DEC=y
> > CONFIG_XZ_DEC_X86=y
> > # CONFIG_XZ_DEC_POWERPC is not set
> > CONFIG_XZ_DEC_IA64=y
> > # CONFIG_XZ_DEC_ARM is not set
> > # CONFIG_XZ_DEC_ARMTHUMB is not set
> > CONFIG_XZ_DEC_SPARC=y
> > CONFIG_XZ_DEC_BCJ=y
> > CONFIG_XZ_DEC_TEST=m
> > CONFIG_DECOMPRESS_GZIP=y
> > CONFIG_DECOMPRESS_BZIP2=y
> > CONFIG_DECOMPRESS_LZMA=y
> > CONFIG_DECOMPRESS_XZ=y
> > CONFIG_DECOMPRESS_LZO=y
> > CONFIG_DECOMPRESS_LZ4=y
> > CONFIG_GENERIC_ALLOCATOR=y
> > CONFIG_BCH=m
> > CONFIG_XARRAY_MULTI=y
> > CONFIG_ASSOCIATIVE_ARRAY=y
> > CONFIG_HAS_IOMEM=y
> > CONFIG_HAS_IOPORT_MAP=y
> > CONFIG_HAS_DMA=y
> > CONFIG_DMA_OPS=y
> > CONFIG_NEED_SG_DMA_LENGTH=y
> > # CONFIG_DMA_CMA is not set
> > # CONFIG_DMA_API_DEBUG is not set
> > CONFIG_SGL_ALLOC=y
> > # CONFIG_CPUMASK_OFFSTACK is not set
> > CONFIG_CPU_RMAP=y
> > CONFIG_DQL=y
> > CONFIG_GLOB=y
> > # CONFIG_GLOB_SELFTEST is not set
> > CONFIG_NLATTR=y
> > CONFIG_CLZ_TAB=y
> > # CONFIG_IRQ_POLL is not set
> > CONFIG_MPILIB=y
> > CONFIG_OID_REGISTRY=y
> > CONFIG_HAVE_GENERIC_VDSO=y
> > CONFIG_GENERIC_GETTIMEOFDAY=y
> > CONFIG_GENERIC_VDSO_32=y
> > CONFIG_GENERIC_VDSO_TIME_NS=y
> > CONFIG_FONT_SUPPORT=y
> > CONFIG_FONT_8x16=y
> > CONFIG_FONT_AUTOSELECT=y
> > CONFIG_SG_POOL=y
> > CONFIG_ARCH_STACKWALK=y
> > CONFIG_SBITMAP=y
> > # CONFIG_STRING_SELFTEST is not set
> > # end of Library routines
> > 
> > #
> > # Kernel hacking
> > #
> > 
> > #
> > # printk and dmesg options
> > #
> > CONFIG_PRINTK_TIME=y
> > # CONFIG_PRINTK_CALLER is not set
> > CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> > CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> > CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> > # CONFIG_BOOT_PRINTK_DELAY is not set
> > CONFIG_DYNAMIC_DEBUG=y
> > CONFIG_DYNAMIC_DEBUG_CORE=y
> > # CONFIG_SYMBOLIC_ERRNAME is not set
> > CONFIG_DEBUG_BUGVERBOSE=y
> > # end of printk and dmesg options
> > 
> > #
> > # Compile-time checks and compiler options
> > #
> > CONFIG_DEBUG_INFO=y
> > CONFIG_DEBUG_INFO_REDUCED=y
> > # CONFIG_DEBUG_INFO_COMPRESSED is not set
> > # CONFIG_DEBUG_INFO_SPLIT is not set
> > # CONFIG_DEBUG_INFO_DWARF4 is not set
> > # CONFIG_GDB_SCRIPTS is not set
> > # CONFIG_ENABLE_MUST_CHECK is not set
> > CONFIG_FRAME_WARN=1024
> > CONFIG_STRIP_ASM_SYMS=y
> > CONFIG_READABLE_ASM=y
> > # CONFIG_HEADERS_INSTALL is not set
> > CONFIG_DEBUG_SECTION_MISMATCH=y
> > CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> > # CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B is not set
> > CONFIG_FRAME_POINTER=y
> > # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> > # end of Compile-time checks and compiler options
> > 
> > #
> > # Generic Kernel Debugging Instruments
> > #
> > CONFIG_MAGIC_SYSRQ=y
> > CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> > # CONFIG_MAGIC_SYSRQ_SERIAL is not set
> > CONFIG_DEBUG_FS=y
> > # CONFIG_DEBUG_FS_ALLOW_ALL is not set
> > CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
> > # CONFIG_DEBUG_FS_ALLOW_NONE is not set
> > CONFIG_HAVE_ARCH_KGDB=y
> > # CONFIG_KGDB is not set
> > CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> > CONFIG_UBSAN=y
> > # CONFIG_UBSAN_TRAP is not set
> > CONFIG_UBSAN_BOUNDS=y
> > CONFIG_UBSAN_MISC=y
> > CONFIG_UBSAN_SANITIZE_ALL=y
> > # CONFIG_UBSAN_ALIGNMENT is not set
> > # CONFIG_TEST_UBSAN is not set
> > # end of Generic Kernel Debugging Instruments
> > 
> > CONFIG_DEBUG_KERNEL=y
> > # CONFIG_DEBUG_MISC is not set
> > 
> > #
> > # Memory Debugging
> > #
> > CONFIG_PAGE_EXTENSION=y
> > # CONFIG_DEBUG_PAGEALLOC is not set
> > # CONFIG_PAGE_OWNER is not set
> > CONFIG_PAGE_POISONING=y
> > CONFIG_PAGE_POISONING_NO_SANITY=y
> > # CONFIG_PAGE_POISONING_ZERO is not set
> > # CONFIG_DEBUG_PAGE_REF is not set
> > CONFIG_DEBUG_RODATA_TEST=y
> > CONFIG_ARCH_HAS_DEBUG_WX=y
> > CONFIG_DEBUG_WX=y
> > CONFIG_GENERIC_PTDUMP=y
> > CONFIG_PTDUMP_CORE=y
> > CONFIG_PTDUMP_DEBUGFS=y
> > CONFIG_DEBUG_OBJECTS=y
> > # CONFIG_DEBUG_OBJECTS_SELFTEST is not set
> > # CONFIG_DEBUG_OBJECTS_FREE is not set
> > CONFIG_DEBUG_OBJECTS_TIMERS=y
> > # CONFIG_DEBUG_OBJECTS_WORK is not set
> > CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
> > CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
> > CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
> > CONFIG_SLUB_STATS=y
> > CONFIG_HAVE_DEBUG_KMEMLEAK=y
> > # CONFIG_DEBUG_KMEMLEAK is not set
> > # CONFIG_DEBUG_STACK_USAGE is not set
> > CONFIG_SCHED_STACK_END_CHECK=y
> > CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
> > # CONFIG_DEBUG_VM is not set
> > CONFIG_DEBUG_VM_PGTABLE=y
> > CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> > # CONFIG_DEBUG_VIRTUAL is not set
> > # CONFIG_DEBUG_MEMORY_INIT is not set
> > CONFIG_DEBUG_PER_CPU_MAPS=y
> > CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
> > # CONFIG_DEBUG_STACKOVERFLOW is not set
> > CONFIG_CC_HAS_KASAN_GENERIC=y
> > CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> > # end of Memory Debugging
> > 
> > CONFIG_DEBUG_SHIRQ=y
> > 
> > #
> > # Debug Oops, Lockups and Hangs
> > #
> > # CONFIG_PANIC_ON_OOPS is not set
> > CONFIG_PANIC_ON_OOPS_VALUE=0
> > CONFIG_PANIC_TIMEOUT=0
> > CONFIG_LOCKUP_DETECTOR=y
> > CONFIG_SOFTLOCKUP_DETECTOR=y
> > # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> > CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
> > CONFIG_HARDLOCKUP_DETECTOR_PERF=y
> > CONFIG_HARDLOCKUP_DETECTOR=y
> > CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
> > CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
> > # CONFIG_DETECT_HUNG_TASK is not set
> > # CONFIG_WQ_WATCHDOG is not set
> > CONFIG_TEST_LOCKUP=m
> > # end of Debug Oops, Lockups and Hangs
> > 
> > #
> > # Scheduler Debugging
> > #
> > CONFIG_SCHED_DEBUG=y
> > # CONFIG_SCHEDSTATS is not set
> > # end of Scheduler Debugging
> > 
> > # CONFIG_DEBUG_TIMEKEEPING is not set
> > # CONFIG_DEBUG_PREEMPT is not set
> > 
> > #
> > # Lock Debugging (spinlocks, mutexes, etc...)
> > #
> > CONFIG_LOCK_DEBUGGING_SUPPORT=y
> > # CONFIG_PROVE_LOCKING is not set
> > CONFIG_LOCK_STAT=y
> > CONFIG_DEBUG_RT_MUTEXES=y
> > CONFIG_DEBUG_SPINLOCK=y
> > CONFIG_DEBUG_MUTEXES=y
> > # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> > # CONFIG_DEBUG_RWSEMS is not set
> > CONFIG_DEBUG_LOCK_ALLOC=y
> > CONFIG_LOCKDEP=y
> > # CONFIG_DEBUG_LOCKDEP is not set
> > CONFIG_DEBUG_ATOMIC_SLEEP=y
> > CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
> > CONFIG_LOCK_TORTURE_TEST=y
> > # CONFIG_WW_MUTEX_SELFTEST is not set
> > # end of Lock Debugging (spinlocks, mutexes, etc...)
> > 
> > CONFIG_STACKTRACE=y
> > CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
> > # CONFIG_DEBUG_KOBJECT is not set
> > # CONFIG_DEBUG_KOBJECT_RELEASE is not set
> > 
> > #
> > # Debug kernel data structures
> > #
> > CONFIG_DEBUG_LIST=y
> > CONFIG_DEBUG_PLIST=y
> > # CONFIG_DEBUG_SG is not set
> > # CONFIG_DEBUG_NOTIFIERS is not set
> > # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> > # end of Debug kernel data structures
> > 
> > CONFIG_DEBUG_CREDENTIALS=y
> > 
> > #
> > # RCU Debugging
> > #
> > CONFIG_TORTURE_TEST=y
> > # CONFIG_RCU_PERF_TEST is not set
> > CONFIG_RCU_TORTURE_TEST=m
> > CONFIG_RCU_REF_SCALE_TEST=y
> > CONFIG_RCU_CPU_STALL_TIMEOUT=21
> > # CONFIG_RCU_TRACE is not set
> > # CONFIG_RCU_EQS_DEBUG is not set
> > CONFIG_RCU_STRICT_GRACE_PERIOD=y
> > # end of RCU Debugging
> > 
> > # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> > # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> > CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
> > # CONFIG_LATENCYTOP is not set
> > CONFIG_USER_STACKTRACE_SUPPORT=y
> > CONFIG_NOP_TRACER=y
> > CONFIG_HAVE_FUNCTION_TRACER=y
> > CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> > CONFIG_HAVE_DYNAMIC_FTRACE=y
> > CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> > CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> > CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> > CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> > CONFIG_HAVE_FENTRY=y
> > CONFIG_HAVE_C_RECORDMCOUNT=y
> > CONFIG_TRACER_MAX_TRACE=y
> > CONFIG_TRACE_CLOCK=y
> > CONFIG_RING_BUFFER=y
> > CONFIG_EVENT_TRACING=y
> > CONFIG_CONTEXT_SWITCH_TRACER=y
> > CONFIG_RING_BUFFER_ALLOW_SWAP=y
> > CONFIG_TRACING=y
> > CONFIG_GENERIC_TRACER=y
> > CONFIG_TRACING_SUPPORT=y
> > CONFIG_FTRACE=y
> > # CONFIG_BOOTTIME_TRACING is not set
> > CONFIG_FUNCTION_TRACER=y
> > CONFIG_DYNAMIC_FTRACE=y
> > CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
> > CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> > CONFIG_FUNCTION_PROFILER=y
> > CONFIG_STACK_TRACER=y
> > # CONFIG_IRQSOFF_TRACER is not set
> > # CONFIG_PREEMPT_TRACER is not set
> > CONFIG_SCHED_TRACER=y
> > CONFIG_HWLAT_TRACER=y
> > # CONFIG_MMIOTRACE is not set
> > # CONFIG_FTRACE_SYSCALLS is not set
> > CONFIG_TRACER_SNAPSHOT=y
> > CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
> > CONFIG_BRANCH_PROFILE_NONE=y
> > # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> > # CONFIG_PROFILE_ALL_BRANCHES is not set
> > CONFIG_BLK_DEV_IO_TRACE=y
> > CONFIG_KPROBE_EVENTS=y
> > CONFIG_KPROBE_EVENTS_ON_NOTRACE=y
> > CONFIG_UPROBE_EVENTS=y
> > CONFIG_DYNAMIC_EVENTS=y
> > CONFIG_PROBE_EVENTS=y
> > CONFIG_FTRACE_MCOUNT_RECORD=y
> > # CONFIG_SYNTH_EVENTS is not set
> > # CONFIG_HIST_TRIGGERS is not set
> > # CONFIG_TRACE_EVENT_INJECT is not set
> > # CONFIG_TRACEPOINT_BENCHMARK is not set
> > CONFIG_RING_BUFFER_BENCHMARK=y
> > # CONFIG_TRACE_EVAL_MAP_FILE is not set
> > # CONFIG_GCOV_PROFILE_FTRACE is not set
> > # CONFIG_FTRACE_STARTUP_TEST is not set
> > # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> > # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> > # CONFIG_KPROBE_EVENT_GEN_TEST is not set
> > # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> > # CONFIG_SAMPLES is not set
> > CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> > CONFIG_STRICT_DEVMEM=y
> > CONFIG_IO_STRICT_DEVMEM=y
> > 
> > #
> > # x86 Debugging
> > #
> > CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> > CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
> > CONFIG_EARLY_PRINTK_USB=y
> > CONFIG_X86_VERBOSE_BOOTUP=y
> > CONFIG_EARLY_PRINTK=y
> > CONFIG_EARLY_PRINTK_DBGP=y
> > CONFIG_EARLY_PRINTK_USB_XDBC=y
> > # CONFIG_DEBUG_TLBFLUSH is not set
> > CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> > # CONFIG_X86_DECODER_SELFTEST is not set
> > CONFIG_IO_DELAY_0X80=y
> > # CONFIG_IO_DELAY_0XED is not set
> > # CONFIG_IO_DELAY_UDELAY is not set
> > # CONFIG_IO_DELAY_NONE is not set
> > # CONFIG_DEBUG_BOOT_PARAMS is not set
> > # CONFIG_CPA_DEBUG is not set
> > CONFIG_DEBUG_ENTRY=y
> > CONFIG_DEBUG_NMI_SELFTEST=y
> > CONFIG_X86_DEBUG_FPU=y
> > # CONFIG_PUNIT_ATOM_DEBUG is not set
> > CONFIG_UNWINDER_FRAME_POINTER=y
> > # CONFIG_UNWINDER_GUESS is not set
> > # end of x86 Debugging
> > 
> > #
> > # Kernel Testing and Coverage
> > #
> > CONFIG_KUNIT=m
> > # CONFIG_KUNIT_DEBUGFS is not set
> > # CONFIG_KUNIT_TEST is not set
> > # CONFIG_KUNIT_EXAMPLE_TEST is not set
> > # CONFIG_KUNIT_ALL_TESTS is not set
> > # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> > CONFIG_FUNCTION_ERROR_INJECTION=y
> > # CONFIG_FAULT_INJECTION is not set
> > CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> > CONFIG_RUNTIME_TESTING_MENU=y
> > # CONFIG_LKDTM is not set
> > # CONFIG_TEST_LIST_SORT is not set
> > # CONFIG_TEST_MIN_HEAP is not set
> > # CONFIG_TEST_SORT is not set
> > # CONFIG_KPROBES_SANITY_TEST is not set
> > # CONFIG_BACKTRACE_SELF_TEST is not set
> > # CONFIG_RBTREE_TEST is not set
> > # CONFIG_REED_SOLOMON_TEST is not set
> > # CONFIG_INTERVAL_TREE_TEST is not set
> > # CONFIG_PERCPU_TEST is not set
> > # CONFIG_ATOMIC64_SELFTEST is not set
> > # CONFIG_TEST_HEXDUMP is not set
> > # CONFIG_TEST_STRING_HELPERS is not set
> > CONFIG_TEST_STRSCPY=y
> > # CONFIG_TEST_KSTRTOX is not set
> > # CONFIG_TEST_PRINTF is not set
> > CONFIG_TEST_BITMAP=y
> > # CONFIG_TEST_BITFIELD is not set
> > # CONFIG_TEST_UUID is not set
> > # CONFIG_TEST_XARRAY is not set
> > # CONFIG_TEST_OVERFLOW is not set
> > # CONFIG_TEST_RHASHTABLE is not set
> > # CONFIG_TEST_HASH is not set
> > # CONFIG_TEST_IDA is not set
> > # CONFIG_TEST_LKM is not set
> > CONFIG_TEST_BITOPS=m
> > # CONFIG_TEST_VMALLOC is not set
> > CONFIG_TEST_USER_COPY=m
> > # CONFIG_TEST_BPF is not set
> > # CONFIG_TEST_BLACKHOLE_DEV is not set
> > # CONFIG_FIND_BIT_BENCHMARK is not set
> > CONFIG_TEST_FIRMWARE=y
> > # CONFIG_TEST_SYSCTL is not set
> > CONFIG_SYSCTL_KUNIT_TEST=m
> > CONFIG_LIST_KUNIT_TEST=m
> > CONFIG_LINEAR_RANGES_TEST=m
> > # CONFIG_BITS_TEST is not set
> > # CONFIG_TEST_UDELAY is not set
> > CONFIG_TEST_STATIC_KEYS=m
> > # CONFIG_TEST_KMOD is not set
> > # CONFIG_TEST_MEMCAT_P is not set
> > CONFIG_TEST_STACKINIT=y
> > # CONFIG_TEST_MEMINIT is not set
> > # CONFIG_TEST_FPU is not set
> > # CONFIG_MEMTEST is not set
> > # end of Kernel Testing and Coverage
> > # end of Kernel hacking
> 
> > #!/bin/sh
> > 
> > export_top_env()
> > {
> > 	export suite='trinity'
> > 	export testcase='trinity'
> > 	export category='functional'
> > 	export need_memory='300MB'
> > 	export runtime=300
> > 	export job_origin='/lkp-src/allot/rand/vm-snb-i386/trinity.yaml'
> > 	export queue_cmdline_keys='branch
> > commit
> > queue_at_least_once'
> > 	export queue='validate'
> > 	export testbox='vm-snb-i386-35'
> > 	export tbox_group='vm-snb-i386'
> > 	export branch='linus/master'
> > 	export commit='44bad5b3cca2d452d17ef82841b20b42a2cf11a0'
> > 	export kconfig='i386-randconfig-a014-20201026'
> > 	export repeat_to=4
> > 	export nr_vm=64
> > 	export submit_id='5f9acfd3e22f611dfc5bc21c'
> > 	export job_file='/lkp/jobs/scheduled/vm-snb-i386-35/trinity-300s-debian-i386-20191205.cgz-44bad5b3cca2d452d17ef82841b20b42a2cf11a0-20201029-7676-1d2wl3j-2.yaml'
> > 	export id='e1db2aea32bb28f5870e446baaded9b746ad3dd4'
> > 	export queuer_version='/lkp-src'
> > 	export model='qemu-system-i386 -enable-kvm -cpu SandyBridge'
> > 	export nr_cpu=2
> > 	export memory='8G'
> > 	export need_kconfig='CONFIG_KVM_GUEST=y'
> > 	export ssh_base_port=23032
> > 	export rootfs='debian-i386-20191205.cgz'
> > 	export compiler='gcc-9'
> > 	export enqueue_time='2020-10-29 22:21:07 +0800'
> > 	export _id='5f9acfd3e22f611dfc5bc21c'
> > 	export _rt='/result/trinity/300s/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a014-20201026/gcc-9/44bad5b3cca2d452d17ef82841b20b42a2cf11a0'
> > 	export user='lkp'
> > 	export result_root='/result/trinity/300s/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a014-20201026/gcc-9/44bad5b3cca2d452d17ef82841b20b42a2cf11a0/2'
> > 	export scheduler_version='/lkp/lkp/.src-20201029-110223'
> > 	export LKP_SERVER='internal-lkp-server'
> > 	export arch='i386'
> > 	export max_uptime=3600
> > 	export initrd='/osimage/debian/debian-i386-20191205.cgz'
> > 	export bootloader_append='root=/dev/ram0
> > user=lkp
> > job=/lkp/jobs/scheduled/vm-snb-i386-35/trinity-300s-debian-i386-20191205.cgz-44bad5b3cca2d452d17ef82841b20b42a2cf11a0-20201029-7676-1d2wl3j-2.yaml
> > ARCH=i386
> > kconfig=i386-randconfig-a014-20201026
> > branch=linus/master
> > commit=44bad5b3cca2d452d17ef82841b20b42a2cf11a0
> > BOOT_IMAGE=/pkg/linux/i386-randconfig-a014-20201026/gcc-9/44bad5b3cca2d452d17ef82841b20b42a2cf11a0/vmlinuz-5.9.0-rc1-00006-g44bad5b3cca2d
> > max_uptime=3600
> > RESULT_ROOT=/result/trinity/300s/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a014-20201026/gcc-9/44bad5b3cca2d452d17ef82841b20b42a2cf11a0/2
> > LKP_SERVER=internal-lkp-server
> > selinux=0
> > debug
> > apic=debug
> > sysrq_always_enabled
> > rcupdate.rcu_cpu_stall_timeout=100
> > net.ifnames=0
> > printk.devkmsg=on
> > panic=-1
> > softlockup_panic=1
> > nmi_watchdog=panic
> > oops=panic
> > load_ramdisk=2
> > prompt_ramdisk=0
> > drbd.minor_count=8
> > systemd.log_level=err
> > ignore_loglevel
> > console=tty0
> > earlyprintk=ttyS0,115200
> > console=ttyS0,115200
> > vga=normal
> > rw'
> > 	export modules_initrd='/pkg/linux/i386-randconfig-a014-20201026/gcc-9/44bad5b3cca2d452d17ef82841b20b42a2cf11a0/modules.cgz'
> > 	export bm_initrd='/osimage/pkg/debian-i386-20191205.cgz/trinity-i386-4d2343bd-1_20200320.cgz'
> > 	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
> > 	export site='lkp-wsx01'
> > 	export LKP_CGI_PORT=80
> > 	export LKP_CIFS_PORT=139
> > 	export schedule_notify_address=
> > 	export queue_at_least_once=1
> > 	export kernel='/pkg/linux/i386-randconfig-a014-20201026/gcc-9/44bad5b3cca2d452d17ef82841b20b42a2cf11a0/vmlinuz-5.9.0-rc1-00006-g44bad5b3cca2d'
> > 	export dequeue_time='2020-10-29 22:21:19 +0800'
> > 	export job_initrd='/lkp/jobs/scheduled/vm-snb-i386-35/trinity-300s-debian-i386-20191205.cgz-44bad5b3cca2d452d17ef82841b20b42a2cf11a0-20201029-7676-1d2wl3j-2.cgz'
> > 
> > 	[ -n "$LKP_SRC" ] ||
> > 	export LKP_SRC=/lkp/${user:-lkp}/src
> > }
> > 
> > run_job()
> > {
> > 	echo $$ > $TMP/run-job.pid
> > 
> > 	. $LKP_SRC/lib/http.sh
> > 	. $LKP_SRC/lib/job.sh
> > 	. $LKP_SRC/lib/env.sh
> > 
> > 	export_top_env
> > 
> > 	run_monitor $LKP_SRC/monitors/wrapper kmsg
> > 	run_monitor $LKP_SRC/monitors/wrapper heartbeat
> > 	run_monitor $LKP_SRC/monitors/wrapper meminfo
> > 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
> > 	run_monitor $LKP_SRC/monitors/plain/watchdog
> > 
> > 	run_test $LKP_SRC/tests/wrapper trinity
> > }
> > 
> > extract_stats()
> > {
> > 	export stats_part_begin=
> > 	export stats_part_end=
> > 
> > 	$LKP_SRC/stats/wrapper kmsg
> > 	$LKP_SRC/stats/wrapper meminfo
> > 
> > 	$LKP_SRC/stats/wrapper time trinity.time
> > 	$LKP_SRC/stats/wrapper dmesg
> > 	$LKP_SRC/stats/wrapper kmsg
> > 	$LKP_SRC/stats/wrapper last_state
> > 	$LKP_SRC/stats/wrapper stderr
> > 	$LKP_SRC/stats/wrapper time
> > }
> > 
> > "$@"
> 
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
