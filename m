Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D2F22288C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 18:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgGPQue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 12:50:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgGPQub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:50:31 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63C092074B;
        Thu, 16 Jul 2020 16:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594918220;
        bh=S6MATXoMCJtkxrr9BgWVmggMOiUlGNu2epWovHKAGwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hO2BFepTaewBKMmnPjrQu1muIaE08cgdONHeBrcQj26Vf3HKTT0cIzGxUwFWk8aq3
         lDVyC3ANnohlnie3H1aMnPyHsVQguZCGkxYXDfvlX2bcRMvsSIoBgX2e4OM6HwfWT3
         /+el+7JhUWZEQNtnGCLsscwZGX2NmNEO56Ms/YcQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 442AA403C7; Thu, 16 Jul 2020 13:50:17 -0300 (-03)
Date:   Thu, 16 Jul 2020 13:50:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [tools/libperf] 8edd7f4133:
 perf-sanity-tests.Filter_fds_with_revents_mask_in_a_fdarray.fail
Message-ID: <20200716165017.GE374956@kernel.org>
References: <7123e415-4b42-1884-18d9-a0e9e150470b@linux.intel.com>
 <20200716083445.GI3874@shao2-debian>
 <20200716152002.GA373728@kernel.org>
 <2030d9f6-7300-dce5-e34d-45586f3b7ab9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2030d9f6-7300-dce5-e34d-45586f3b7ab9@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 16, 2020 at 07:09:52PM +0300, Alexey Budankov escreveu:
>=20
> On 16.07.2020 18:20, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Jul 16, 2020 at 04:34:45PM +0800, kernel test robot escreveu:
> >> Greeting,
> >=20
> > Alexey, I was about to try and process these patches, can you take a
> > look at this and perhaps provide a refresh addressing it?
>=20
> Working on v12 already.
> Reproduced locally and addressing the test failure.
> Will capture acquired Acks as well.

Thanks a lot!

- Arnaldo
=20
> Alexei
>=20
> >=20
> > - Arnaldo
> > =20
> >> FYI, we noticed the following commit (built with gcc-9):
> >>
> >> commit: 8edd7f41336b4462f69b011deb7cf37a2c3f8516 ("[PATCH v11 03/15] t=
ools/libperf: avoid counting of nonfilterable fdarray fds")
> >> url: https://github.com/0day-ci/linux/commits/Alexey-Budankov/perf-sup=
port-enable-and-disable-commands-in-stat-and-record-modes/20200714-171347
> >> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git c085fb8=
774671e83f6199a8e838fbc0e57094029
> >>
> >> in testcase: perf-sanity-tests
> >> with following parameters:
> >>
> >> 	perf_compiler: gcc
> >> 	ucode: 0x28
> >>
> >>
> >>
> >> on test machine: 8 threads Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz with=
 6G memory
> >>
> >> caused below changes (please refer to attached dmesg/kmsg for entire l=
og/backtrace):
> >>
> >>
> >>
> >>
> >> If you fix the issue, kindly add following tag
> >> Reported-by: kernel test robot <rong.a.chen@intel.com>
> >>
> >>
> >>
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 36
> >> 36: Filter fds with revents mask in a fdarray             : FAILED!
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 37
> >> 37: Add fd to a fdarray, making it autogrow               : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 38
> >> 38: kmod_path__parse                                      : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 39
> >> 39: Thread map                                            : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 41
> >> 41: Session topology                                      : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 43
> >> 43: Synthesize thread map                                 : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 44
> >> 44: Remove thread map                                     : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 45
> >> 45: Synthesize cpu map                                    : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 46
> >> 46: Synthesize stat config                                : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 47
> >> 47: Synthesize stat                                       : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 48
> >> 48: Synthesize stat round                                 : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 49
> >> 49: Synthesize attr update                                : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 50
> >> 50: Event times                                           : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 51
> >> 51: Read backward ring buffer                             : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 52
> >> 52: Print cpu map                                         : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 53
> >> 53: Merge cpu map                                         : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 54
> >> 54: Probe SDT events                                      : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 55
> >> 55: is_printable_array                                    : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 56
> >> 56: Print bitmap                                          : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 57
> >> 57: perf hooks                                            : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 59
> >> 59: unit_number__scnprintf                                : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 60
> >> 60: mem2node                                              : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 61
> >> 61: time utils                                            : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 62
> >> 62: Test jit_write_elf                                    : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 63
> >> 63: Test libpfm4 support                                  : Skip (not =
compiled in)
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 64
> >> 64: Test api io                                           : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 65
> >> 65: maps__merge_in                                        : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 66
> >> 66: Demangle Java                                         : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 67
> >> 67: x86 rdpmc                                             : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 68
> >> 68: Convert perf time to TSC                              : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 69
> >> 69: DWARF unwind                                          : Ok
> >> 2020-07-15 06:38:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 70
> >> 70: x86 instruction decoder - new instructions            : Ok
> >> 2020-07-15 06:38:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 71
> >> 71: Intel PT packet decoder                               : Ok
> >> 2020-07-15 06:38:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 72
> >> 72: x86 bp modify                                         : Ok
> >> 2020-07-15 06:38:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 73
> >> 73: probe libc's inet_pton & backtrace it with ping       : Ok
> >> 2020-07-15 06:38:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 75
> >> 75: Zstd perf.data compression/decompression              : Ok
> >>
> >>
> >>
> >> To reproduce:
> >>
> >>         git clone https://github.com/intel/lkp-tests.git
> >>         cd lkp-tests
> >>         bin/lkp install job.yaml  # job file is attached in this email
> >>         bin/lkp run     job.yaml
> >>
> >>
> >>
> >> Thanks,
> >> Rong Chen
> >>
> >=20
> >> #
> >> # Automatically generated file; DO NOT EDIT.
> >> # Linux/x86_64 5.8.0-rc3 Kernel Configuration
> >> #
> >> CONFIG_CC_VERSION_TEXT=3D"gcc-9 (Debian 9.3.0-14) 9.3.0"
> >> CONFIG_CC_IS_GCC=3Dy
> >> CONFIG_GCC_VERSION=3D90300
> >> CONFIG_LD_VERSION=3D234000000
> >> CONFIG_CLANG_VERSION=3D0
> >> CONFIG_CC_CAN_LINK=3Dy
> >> CONFIG_CC_CAN_LINK_STATIC=3Dy
> >> CONFIG_CC_HAS_ASM_GOTO=3Dy
> >> CONFIG_CC_HAS_ASM_INLINE=3Dy
> >> CONFIG_IRQ_WORK=3Dy
> >> CONFIG_BUILDTIME_TABLE_SORT=3Dy
> >> CONFIG_THREAD_INFO_IN_TASK=3Dy
> >>
> >> #
> >> # General setup
> >> #
> >> CONFIG_INIT_ENV_ARG_LIMIT=3D32
> >> # CONFIG_COMPILE_TEST is not set
> >> CONFIG_LOCALVERSION=3D""
> >> CONFIG_LOCALVERSION_AUTO=3Dy
> >> CONFIG_BUILD_SALT=3D""
> >> CONFIG_HAVE_KERNEL_GZIP=3Dy
> >> CONFIG_HAVE_KERNEL_BZIP2=3Dy
> >> CONFIG_HAVE_KERNEL_LZMA=3Dy
> >> CONFIG_HAVE_KERNEL_XZ=3Dy
> >> CONFIG_HAVE_KERNEL_LZO=3Dy
> >> CONFIG_HAVE_KERNEL_LZ4=3Dy
> >> CONFIG_KERNEL_GZIP=3Dy
> >> # CONFIG_KERNEL_BZIP2 is not set
> >> # CONFIG_KERNEL_LZMA is not set
> >> # CONFIG_KERNEL_XZ is not set
> >> # CONFIG_KERNEL_LZO is not set
> >> # CONFIG_KERNEL_LZ4 is not set
> >> CONFIG_DEFAULT_INIT=3D""
> >> CONFIG_DEFAULT_HOSTNAME=3D"(none)"
> >> CONFIG_SWAP=3Dy
> >> CONFIG_SYSVIPC=3Dy
> >> CONFIG_SYSVIPC_SYSCTL=3Dy
> >> CONFIG_POSIX_MQUEUE=3Dy
> >> CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
> >> # CONFIG_WATCH_QUEUE is not set
> >> CONFIG_CROSS_MEMORY_ATTACH=3Dy
> >> # CONFIG_USELIB is not set
> >> CONFIG_AUDIT=3Dy
> >> CONFIG_HAVE_ARCH_AUDITSYSCALL=3Dy
> >> CONFIG_AUDITSYSCALL=3Dy
> >>
> >> #
> >> # IRQ subsystem
> >> #
> >> CONFIG_GENERIC_IRQ_PROBE=3Dy
> >> CONFIG_GENERIC_IRQ_SHOW=3Dy
> >> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=3Dy
> >> CONFIG_GENERIC_PENDING_IRQ=3Dy
> >> CONFIG_GENERIC_IRQ_MIGRATION=3Dy
> >> CONFIG_GENERIC_IRQ_INJECTION=3Dy
> >> CONFIG_HARDIRQS_SW_RESEND=3Dy
> >> CONFIG_IRQ_DOMAIN=3Dy
> >> CONFIG_IRQ_DOMAIN_HIERARCHY=3Dy
> >> CONFIG_GENERIC_MSI_IRQ=3Dy
> >> CONFIG_GENERIC_MSI_IRQ_DOMAIN=3Dy
> >> CONFIG_IRQ_MSI_IOMMU=3Dy
> >> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=3Dy
> >> CONFIG_GENERIC_IRQ_RESERVATION_MODE=3Dy
> >> CONFIG_IRQ_FORCED_THREADING=3Dy
> >> CONFIG_SPARSE_IRQ=3Dy
> >> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> >> # end of IRQ subsystem
> >>
> >> CONFIG_CLOCKSOURCE_WATCHDOG=3Dy
> >> CONFIG_ARCH_CLOCKSOURCE_INIT=3Dy
> >> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=3Dy
> >> CONFIG_GENERIC_TIME_VSYSCALL=3Dy
> >> CONFIG_GENERIC_CLOCKEVENTS=3Dy
> >> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy
> >> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=3Dy
> >> CONFIG_GENERIC_CMOS_UPDATE=3Dy
> >>
> >> #
> >> # Timers subsystem
> >> #
> >> CONFIG_TICK_ONESHOT=3Dy
> >> CONFIG_NO_HZ_COMMON=3Dy
> >> # CONFIG_HZ_PERIODIC is not set
> >> # CONFIG_NO_HZ_IDLE is not set
> >> CONFIG_NO_HZ_FULL=3Dy
> >> CONFIG_CONTEXT_TRACKING=3Dy
> >> # CONFIG_CONTEXT_TRACKING_FORCE is not set
> >> CONFIG_NO_HZ=3Dy
> >> CONFIG_HIGH_RES_TIMERS=3Dy
> >> # end of Timers subsystem
> >>
> >> # CONFIG_PREEMPT_NONE is not set
> >> CONFIG_PREEMPT_VOLUNTARY=3Dy
> >> # CONFIG_PREEMPT is not set
> >> CONFIG_PREEMPT_COUNT=3Dy
> >>
> >> #
> >> # CPU/Task time and stats accounting
> >> #
> >> CONFIG_VIRT_CPU_ACCOUNTING=3Dy
> >> CONFIG_VIRT_CPU_ACCOUNTING_GEN=3Dy
> >> CONFIG_IRQ_TIME_ACCOUNTING=3Dy
> >> CONFIG_HAVE_SCHED_AVG_IRQ=3Dy
> >> # CONFIG_SCHED_THERMAL_PRESSURE is not set
> >> CONFIG_BSD_PROCESS_ACCT=3Dy
> >> CONFIG_BSD_PROCESS_ACCT_V3=3Dy
> >> CONFIG_TASKSTATS=3Dy
> >> CONFIG_TASK_DELAY_ACCT=3Dy
> >> CONFIG_TASK_XACCT=3Dy
> >> CONFIG_TASK_IO_ACCOUNTING=3Dy
> >> # CONFIG_PSI is not set
> >> # end of CPU/Task time and stats accounting
> >>
> >> CONFIG_CPU_ISOLATION=3Dy
> >>
> >> #
> >> # RCU Subsystem
> >> #
> >> CONFIG_TREE_RCU=3Dy
> >> # CONFIG_RCU_EXPERT is not set
> >> CONFIG_SRCU=3Dy
> >> CONFIG_TREE_SRCU=3Dy
> >> CONFIG_TASKS_RCU_GENERIC=3Dy
> >> CONFIG_TASKS_RCU=3Dy
> >> CONFIG_TASKS_RUDE_RCU=3Dy
> >> CONFIG_TASKS_TRACE_RCU=3Dy
> >> CONFIG_RCU_STALL_COMMON=3Dy
> >> CONFIG_RCU_NEED_SEGCBLIST=3Dy
> >> CONFIG_RCU_NOCB_CPU=3Dy
> >> # end of RCU Subsystem
> >>
> >> CONFIG_BUILD_BIN2C=3Dy
> >> CONFIG_IKCONFIG=3Dy
> >> CONFIG_IKCONFIG_PROC=3Dy
> >> # CONFIG_IKHEADERS is not set
> >> CONFIG_LOG_BUF_SHIFT=3D20
> >> CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12
> >> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=3D13
> >> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
> >>
> >> #
> >> # Scheduler features
> >> #
> >> # CONFIG_UCLAMP_TASK is not set
> >> # end of Scheduler features
> >>
> >> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=3Dy
> >> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=3Dy
> >> CONFIG_CC_HAS_INT128=3Dy
> >> CONFIG_ARCH_SUPPORTS_INT128=3Dy
> >> CONFIG_NUMA_BALANCING=3Dy
> >> CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=3Dy
> >> CONFIG_CGROUPS=3Dy
> >> CONFIG_PAGE_COUNTER=3Dy
> >> CONFIG_MEMCG=3Dy
> >> CONFIG_MEMCG_SWAP=3Dy
> >> CONFIG_MEMCG_KMEM=3Dy
> >> CONFIG_BLK_CGROUP=3Dy
> >> CONFIG_CGROUP_WRITEBACK=3Dy
> >> CONFIG_CGROUP_SCHED=3Dy
> >> CONFIG_FAIR_GROUP_SCHED=3Dy
> >> CONFIG_CFS_BANDWIDTH=3Dy
> >> CONFIG_RT_GROUP_SCHED=3Dy
> >> CONFIG_CGROUP_PIDS=3Dy
> >> CONFIG_CGROUP_RDMA=3Dy
> >> CONFIG_CGROUP_FREEZER=3Dy
> >> CONFIG_CGROUP_HUGETLB=3Dy
> >> CONFIG_CPUSETS=3Dy
> >> CONFIG_PROC_PID_CPUSET=3Dy
> >> CONFIG_CGROUP_DEVICE=3Dy
> >> CONFIG_CGROUP_CPUACCT=3Dy
> >> CONFIG_CGROUP_PERF=3Dy
> >> CONFIG_CGROUP_BPF=3Dy
> >> # CONFIG_CGROUP_DEBUG is not set
> >> CONFIG_SOCK_CGROUP_DATA=3Dy
> >> CONFIG_NAMESPACES=3Dy
> >> CONFIG_UTS_NS=3Dy
> >> CONFIG_TIME_NS=3Dy
> >> CONFIG_IPC_NS=3Dy
> >> CONFIG_USER_NS=3Dy
> >> CONFIG_PID_NS=3Dy
> >> CONFIG_NET_NS=3Dy
> >> # CONFIG_CHECKPOINT_RESTORE is not set
> >> CONFIG_SCHED_AUTOGROUP=3Dy
> >> # CONFIG_SYSFS_DEPRECATED is not set
> >> CONFIG_RELAY=3Dy
> >> CONFIG_BLK_DEV_INITRD=3Dy
> >> CONFIG_INITRAMFS_SOURCE=3D""
> >> CONFIG_RD_GZIP=3Dy
> >> CONFIG_RD_BZIP2=3Dy
> >> CONFIG_RD_LZMA=3Dy
> >> CONFIG_RD_XZ=3Dy
> >> CONFIG_RD_LZO=3Dy
> >> CONFIG_RD_LZ4=3Dy
> >> # CONFIG_BOOT_CONFIG is not set
> >> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy
> >> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> >> CONFIG_SYSCTL=3Dy
> >> CONFIG_HAVE_UID16=3Dy
> >> CONFIG_SYSCTL_EXCEPTION_TRACE=3Dy
> >> CONFIG_HAVE_PCSPKR_PLATFORM=3Dy
> >> CONFIG_BPF=3Dy
> >> # CONFIG_EXPERT is not set
> >> CONFIG_UID16=3Dy
> >> CONFIG_MULTIUSER=3Dy
> >> CONFIG_SGETMASK_SYSCALL=3Dy
> >> CONFIG_SYSFS_SYSCALL=3Dy
> >> CONFIG_FHANDLE=3Dy
> >> CONFIG_POSIX_TIMERS=3Dy
> >> CONFIG_PRINTK=3Dy
> >> CONFIG_PRINTK_NMI=3Dy
> >> CONFIG_BUG=3Dy
> >> CONFIG_ELF_CORE=3Dy
> >> CONFIG_PCSPKR_PLATFORM=3Dy
> >> CONFIG_BASE_FULL=3Dy
> >> CONFIG_FUTEX=3Dy
> >> CONFIG_FUTEX_PI=3Dy
> >> CONFIG_EPOLL=3Dy
> >> CONFIG_SIGNALFD=3Dy
> >> CONFIG_TIMERFD=3Dy
> >> CONFIG_EVENTFD=3Dy
> >> CONFIG_SHMEM=3Dy
> >> CONFIG_AIO=3Dy
> >> CONFIG_IO_URING=3Dy
> >> CONFIG_ADVISE_SYSCALLS=3Dy
> >> CONFIG_HAVE_ARCH_USERFAULTFD_WP=3Dy
> >> CONFIG_MEMBARRIER=3Dy
> >> CONFIG_KALLSYMS=3Dy
> >> CONFIG_KALLSYMS_ALL=3Dy
> >> CONFIG_KALLSYMS_ABSOLUTE_PERCPU=3Dy
> >> CONFIG_KALLSYMS_BASE_RELATIVE=3Dy
> >> # CONFIG_BPF_LSM is not set
> >> CONFIG_BPF_SYSCALL=3Dy
> >> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=3Dy
> >> CONFIG_BPF_JIT_ALWAYS_ON=3Dy
> >> CONFIG_BPF_JIT_DEFAULT_ON=3Dy
> >> CONFIG_USERFAULTFD=3Dy
> >> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=3Dy
> >> CONFIG_RSEQ=3Dy
> >> # CONFIG_EMBEDDED is not set
> >> CONFIG_HAVE_PERF_EVENTS=3Dy
> >>
> >> #
> >> # Kernel Performance Events And Counters
> >> #
> >> CONFIG_PERF_EVENTS=3Dy
> >> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> >> # end of Kernel Performance Events And Counters
> >>
> >> CONFIG_VM_EVENT_COUNTERS=3Dy
> >> CONFIG_SLUB_DEBUG=3Dy
> >> # CONFIG_COMPAT_BRK is not set
> >> # CONFIG_SLAB is not set
> >> CONFIG_SLUB=3Dy
> >> CONFIG_SLAB_MERGE_DEFAULT=3Dy
> >> CONFIG_SLAB_FREELIST_RANDOM=3Dy
> >> # CONFIG_SLAB_FREELIST_HARDENED is not set
> >> CONFIG_SHUFFLE_PAGE_ALLOCATOR=3Dy
> >> CONFIG_SLUB_CPU_PARTIAL=3Dy
> >> CONFIG_SYSTEM_DATA_VERIFICATION=3Dy
> >> CONFIG_PROFILING=3Dy
> >> CONFIG_TRACEPOINTS=3Dy
> >> # end of General setup
> >>
> >> CONFIG_64BIT=3Dy
> >> CONFIG_X86_64=3Dy
> >> CONFIG_X86=3Dy
> >> CONFIG_INSTRUCTION_DECODER=3Dy
> >> CONFIG_OUTPUT_FORMAT=3D"elf64-x86-64"
> >> CONFIG_LOCKDEP_SUPPORT=3Dy
> >> CONFIG_STACKTRACE_SUPPORT=3Dy
> >> CONFIG_MMU=3Dy
> >> CONFIG_ARCH_MMAP_RND_BITS_MIN=3D28
> >> CONFIG_ARCH_MMAP_RND_BITS_MAX=3D32
> >> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=3D8
> >> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=3D16
> >> CONFIG_GENERIC_ISA_DMA=3Dy
> >> CONFIG_GENERIC_BUG=3Dy
> >> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=3Dy
> >> CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
> >> CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
> >> CONFIG_ARCH_HAS_CPU_RELAX=3Dy
> >> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy
> >> CONFIG_ARCH_HAS_FILTER_PGPROT=3Dy
> >> CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
> >> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy
> >> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy
> >> CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
> >> CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
> >> CONFIG_ARCH_WANT_GENERAL_HUGETLB=3Dy
> >> CONFIG_ZONE_DMA32=3Dy
> >> CONFIG_AUDIT_ARCH=3Dy
> >> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
> >> CONFIG_HAVE_INTEL_TXT=3Dy
> >> CONFIG_X86_64_SMP=3Dy
> >> CONFIG_ARCH_SUPPORTS_UPROBES=3Dy
> >> CONFIG_FIX_EARLYCON_MEM=3Dy
> >> CONFIG_DYNAMIC_PHYSICAL_MASK=3Dy
> >> CONFIG_PGTABLE_LEVELS=3D5
> >> CONFIG_CC_HAS_SANE_STACKPROTECTOR=3Dy
> >>
> >> #
> >> # Processor type and features
> >> #
> >> CONFIG_ZONE_DMA=3Dy
> >> CONFIG_SMP=3Dy
> >> CONFIG_X86_FEATURE_NAMES=3Dy
> >> CONFIG_X86_X2APIC=3Dy
> >> CONFIG_X86_MPPARSE=3Dy
> >> # CONFIG_GOLDFISH is not set
> >> CONFIG_RETPOLINE=3Dy
> >> CONFIG_X86_CPU_RESCTRL=3Dy
> >> CONFIG_X86_EXTENDED_PLATFORM=3Dy
> >> # CONFIG_X86_NUMACHIP is not set
> >> # CONFIG_X86_VSMP is not set
> >> CONFIG_X86_UV=3Dy
> >> # CONFIG_X86_GOLDFISH is not set
> >> # CONFIG_X86_INTEL_MID is not set
> >> CONFIG_X86_INTEL_LPSS=3Dy
> >> CONFIG_X86_AMD_PLATFORM_DEVICE=3Dy
> >> CONFIG_IOSF_MBI=3Dy
> >> # CONFIG_IOSF_MBI_DEBUG is not set
> >> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=3Dy
> >> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> >> CONFIG_HYPERVISOR_GUEST=3Dy
> >> CONFIG_PARAVIRT=3Dy
> >> # CONFIG_PARAVIRT_DEBUG is not set
> >> CONFIG_PARAVIRT_SPINLOCKS=3Dy
> >> CONFIG_X86_HV_CALLBACK_VECTOR=3Dy
> >> CONFIG_XEN=3Dy
> >> # CONFIG_XEN_PV is not set
> >> CONFIG_XEN_PVHVM=3Dy
> >> CONFIG_XEN_PVHVM_SMP=3Dy
> >> CONFIG_XEN_SAVE_RESTORE=3Dy
> >> # CONFIG_XEN_DEBUG_FS is not set
> >> # CONFIG_XEN_PVH is not set
> >> CONFIG_KVM_GUEST=3Dy
> >> CONFIG_ARCH_CPUIDLE_HALTPOLL=3Dy
> >> # CONFIG_PVH is not set
> >> CONFIG_PARAVIRT_TIME_ACCOUNTING=3Dy
> >> CONFIG_PARAVIRT_CLOCK=3Dy
> >> # CONFIG_JAILHOUSE_GUEST is not set
> >> # CONFIG_ACRN_GUEST is not set
> >> # CONFIG_MK8 is not set
> >> # CONFIG_MPSC is not set
> >> # CONFIG_MCORE2 is not set
> >> # CONFIG_MATOM is not set
> >> CONFIG_GENERIC_CPU=3Dy
> >> CONFIG_X86_INTERNODE_CACHE_SHIFT=3D6
> >> CONFIG_X86_L1_CACHE_SHIFT=3D6
> >> CONFIG_X86_TSC=3Dy
> >> CONFIG_X86_CMPXCHG64=3Dy
> >> CONFIG_X86_CMOV=3Dy
> >> CONFIG_X86_MINIMUM_CPU_FAMILY=3D64
> >> CONFIG_X86_DEBUGCTLMSR=3Dy
> >> CONFIG_IA32_FEAT_CTL=3Dy
> >> CONFIG_X86_VMX_FEATURE_NAMES=3Dy
> >> CONFIG_CPU_SUP_INTEL=3Dy
> >> CONFIG_CPU_SUP_AMD=3Dy
> >> CONFIG_CPU_SUP_HYGON=3Dy
> >> CONFIG_CPU_SUP_CENTAUR=3Dy
> >> CONFIG_CPU_SUP_ZHAOXIN=3Dy
> >> CONFIG_HPET_TIMER=3Dy
> >> CONFIG_HPET_EMULATE_RTC=3Dy
> >> CONFIG_DMI=3Dy
> >> # CONFIG_GART_IOMMU is not set
> >> CONFIG_MAXSMP=3Dy
> >> CONFIG_NR_CPUS_RANGE_BEGIN=3D8192
> >> CONFIG_NR_CPUS_RANGE_END=3D8192
> >> CONFIG_NR_CPUS_DEFAULT=3D8192
> >> CONFIG_NR_CPUS=3D8192
> >> CONFIG_SCHED_SMT=3Dy
> >> CONFIG_SCHED_MC=3Dy
> >> CONFIG_SCHED_MC_PRIO=3Dy
> >> CONFIG_X86_LOCAL_APIC=3Dy
> >> CONFIG_X86_IO_APIC=3Dy
> >> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy
> >> CONFIG_X86_MCE=3Dy
> >> CONFIG_X86_MCELOG_LEGACY=3Dy
> >> CONFIG_X86_MCE_INTEL=3Dy
> >> CONFIG_X86_MCE_AMD=3Dy
> >> CONFIG_X86_MCE_THRESHOLD=3Dy
> >> CONFIG_X86_MCE_INJECT=3Dm
> >> CONFIG_X86_THERMAL_VECTOR=3Dy
> >>
> >> #
> >> # Performance monitoring
> >> #
> >> CONFIG_PERF_EVENTS_INTEL_UNCORE=3Dm
> >> CONFIG_PERF_EVENTS_INTEL_RAPL=3Dm
> >> CONFIG_PERF_EVENTS_INTEL_CSTATE=3Dm
> >> CONFIG_PERF_EVENTS_AMD_POWER=3Dm
> >> # end of Performance monitoring
> >>
> >> CONFIG_X86_16BIT=3Dy
> >> CONFIG_X86_ESPFIX64=3Dy
> >> CONFIG_X86_VSYSCALL_EMULATION=3Dy
> >> CONFIG_X86_IOPL_IOPERM=3Dy
> >> CONFIG_I8K=3Dm
> >> CONFIG_MICROCODE=3Dy
> >> CONFIG_MICROCODE_INTEL=3Dy
> >> CONFIG_MICROCODE_AMD=3Dy
> >> CONFIG_MICROCODE_OLD_INTERFACE=3Dy
> >> CONFIG_X86_MSR=3Dy
> >> CONFIG_X86_CPUID=3Dy
> >> CONFIG_X86_5LEVEL=3Dy
> >> CONFIG_X86_DIRECT_GBPAGES=3Dy
> >> # CONFIG_X86_CPA_STATISTICS is not set
> >> CONFIG_AMD_MEM_ENCRYPT=3Dy
> >> # CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
> >> CONFIG_NUMA=3Dy
> >> CONFIG_AMD_NUMA=3Dy
> >> CONFIG_X86_64_ACPI_NUMA=3Dy
> >> CONFIG_NUMA_EMU=3Dy
> >> CONFIG_NODES_SHIFT=3D10
> >> CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
> >> CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy
> >> CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
> >> # CONFIG_ARCH_MEMORY_PROBE is not set
> >> CONFIG_ARCH_PROC_KCORE_TEXT=3Dy
> >> CONFIG_ILLEGAL_POINTER_VALUE=3D0xdead000000000000
> >> CONFIG_X86_PMEM_LEGACY_DEVICE=3Dy
> >> CONFIG_X86_PMEM_LEGACY=3Dm
> >> CONFIG_X86_CHECK_BIOS_CORRUPTION=3Dy
> >> # CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
> >> CONFIG_X86_RESERVE_LOW=3D64
> >> CONFIG_MTRR=3Dy
> >> CONFIG_MTRR_SANITIZER=3Dy
> >> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=3D1
> >> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=3D1
> >> CONFIG_X86_PAT=3Dy
> >> CONFIG_ARCH_USES_PG_UNCACHED=3Dy
> >> CONFIG_ARCH_RANDOM=3Dy
> >> CONFIG_X86_SMAP=3Dy
> >> CONFIG_X86_UMIP=3Dy
> >> CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=3Dy
> >> CONFIG_X86_INTEL_TSX_MODE_OFF=3Dy
> >> # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> >> # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> >> CONFIG_EFI=3Dy
> >> CONFIG_EFI_STUB=3Dy
> >> CONFIG_EFI_MIXED=3Dy
> >> CONFIG_SECCOMP=3Dy
> >> # CONFIG_HZ_100 is not set
> >> # CONFIG_HZ_250 is not set
> >> # CONFIG_HZ_300 is not set
> >> CONFIG_HZ_1000=3Dy
> >> CONFIG_HZ=3D1000
> >> CONFIG_SCHED_HRTICK=3Dy
> >> CONFIG_KEXEC=3Dy
> >> CONFIG_KEXEC_FILE=3Dy
> >> CONFIG_ARCH_HAS_KEXEC_PURGATORY=3Dy
> >> # CONFIG_KEXEC_SIG is not set
> >> CONFIG_CRASH_DUMP=3Dy
> >> CONFIG_KEXEC_JUMP=3Dy
> >> CONFIG_PHYSICAL_START=3D0x1000000
> >> CONFIG_RELOCATABLE=3Dy
> >> CONFIG_RANDOMIZE_BASE=3Dy
> >> CONFIG_X86_NEED_RELOCS=3Dy
> >> CONFIG_PHYSICAL_ALIGN=3D0x200000
> >> CONFIG_DYNAMIC_MEMORY_LAYOUT=3Dy
> >> CONFIG_RANDOMIZE_MEMORY=3Dy
> >> CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=3D0xa
> >> CONFIG_HOTPLUG_CPU=3Dy
> >> CONFIG_BOOTPARAM_HOTPLUG_CPU0=3Dy
> >> # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
> >> # CONFIG_COMPAT_VDSO is not set
> >> CONFIG_LEGACY_VSYSCALL_EMULATE=3Dy
> >> # CONFIG_LEGACY_VSYSCALL_XONLY is not set
> >> # CONFIG_LEGACY_VSYSCALL_NONE is not set
> >> # CONFIG_CMDLINE_BOOL is not set
> >> CONFIG_MODIFY_LDT_SYSCALL=3Dy
> >> CONFIG_HAVE_LIVEPATCH=3Dy
> >> CONFIG_LIVEPATCH=3Dy
> >> # end of Processor type and features
> >>
> >> CONFIG_ARCH_HAS_ADD_PAGES=3Dy
> >> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
> >> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=3Dy
> >> CONFIG_USE_PERCPU_NUMA_NODE_ID=3Dy
> >> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=3Dy
> >> CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=3Dy
> >> CONFIG_ARCH_ENABLE_THP_MIGRATION=3Dy
> >>
> >> #
> >> # Power management and ACPI options
> >> #
> >> CONFIG_ARCH_HIBERNATION_HEADER=3Dy
> >> CONFIG_SUSPEND=3Dy
> >> CONFIG_SUSPEND_FREEZER=3Dy
> >> CONFIG_HIBERNATE_CALLBACKS=3Dy
> >> CONFIG_HIBERNATION=3Dy
> >> CONFIG_HIBERNATION_SNAPSHOT_DEV=3Dy
> >> CONFIG_PM_STD_PARTITION=3D""
> >> CONFIG_PM_SLEEP=3Dy
> >> CONFIG_PM_SLEEP_SMP=3Dy
> >> # CONFIG_PM_AUTOSLEEP is not set
> >> # CONFIG_PM_WAKELOCKS is not set
> >> CONFIG_PM=3Dy
> >> CONFIG_PM_DEBUG=3Dy
> >> # CONFIG_PM_ADVANCED_DEBUG is not set
> >> # CONFIG_PM_TEST_SUSPEND is not set
> >> CONFIG_PM_SLEEP_DEBUG=3Dy
> >> # CONFIG_PM_TRACE_RTC is not set
> >> CONFIG_PM_CLK=3Dy
> >> # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> >> # CONFIG_ENERGY_MODEL is not set
> >> CONFIG_ARCH_SUPPORTS_ACPI=3Dy
> >> CONFIG_ACPI=3Dy
> >> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=3Dy
> >> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=3Dy
> >> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=3Dy
> >> # CONFIG_ACPI_DEBUGGER is not set
> >> CONFIG_ACPI_SPCR_TABLE=3Dy
> >> CONFIG_ACPI_LPIT=3Dy
> >> CONFIG_ACPI_SLEEP=3Dy
> >> # CONFIG_ACPI_PROCFS_POWER is not set
> >> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=3Dy
> >> CONFIG_ACPI_EC_DEBUGFS=3Dm
> >> CONFIG_ACPI_AC=3Dy
> >> CONFIG_ACPI_BATTERY=3Dy
> >> CONFIG_ACPI_BUTTON=3Dy
> >> CONFIG_ACPI_VIDEO=3Dm
> >> CONFIG_ACPI_FAN=3Dy
> >> CONFIG_ACPI_TAD=3Dm
> >> CONFIG_ACPI_DOCK=3Dy
> >> CONFIG_ACPI_CPU_FREQ_PSS=3Dy
> >> CONFIG_ACPI_PROCESSOR_CSTATE=3Dy
> >> CONFIG_ACPI_PROCESSOR_IDLE=3Dy
> >> CONFIG_ACPI_CPPC_LIB=3Dy
> >> CONFIG_ACPI_PROCESSOR=3Dy
> >> CONFIG_ACPI_IPMI=3Dm
> >> CONFIG_ACPI_HOTPLUG_CPU=3Dy
> >> CONFIG_ACPI_PROCESSOR_AGGREGATOR=3Dm
> >> CONFIG_ACPI_THERMAL=3Dy
> >> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=3Dy
> >> CONFIG_ACPI_TABLE_UPGRADE=3Dy
> >> # CONFIG_ACPI_DEBUG is not set
> >> CONFIG_ACPI_PCI_SLOT=3Dy
> >> CONFIG_ACPI_CONTAINER=3Dy
> >> CONFIG_ACPI_HOTPLUG_MEMORY=3Dy
> >> CONFIG_ACPI_HOTPLUG_IOAPIC=3Dy
> >> CONFIG_ACPI_SBS=3Dm
> >> CONFIG_ACPI_HED=3Dy
> >> # CONFIG_ACPI_CUSTOM_METHOD is not set
> >> CONFIG_ACPI_BGRT=3Dy
> >> CONFIG_ACPI_NFIT=3Dm
> >> # CONFIG_NFIT_SECURITY_DEBUG is not set
> >> CONFIG_ACPI_NUMA=3Dy
> >> # CONFIG_ACPI_HMAT is not set
> >> CONFIG_HAVE_ACPI_APEI=3Dy
> >> CONFIG_HAVE_ACPI_APEI_NMI=3Dy
> >> CONFIG_ACPI_APEI=3Dy
> >> CONFIG_ACPI_APEI_GHES=3Dy
> >> CONFIG_ACPI_APEI_PCIEAER=3Dy
> >> CONFIG_ACPI_APEI_MEMORY_FAILURE=3Dy
> >> CONFIG_ACPI_APEI_EINJ=3Dm
> >> CONFIG_ACPI_APEI_ERST_DEBUG=3Dy
> >> CONFIG_DPTF_POWER=3Dm
> >> CONFIG_ACPI_WATCHDOG=3Dy
> >> CONFIG_ACPI_EXTLOG=3Dm
> >> CONFIG_ACPI_ADXL=3Dy
> >> CONFIG_PMIC_OPREGION=3Dy
> >> # CONFIG_ACPI_CONFIGFS is not set
> >> CONFIG_X86_PM_TIMER=3Dy
> >> CONFIG_SFI=3Dy
> >>
> >> #
> >> # CPU Frequency scaling
> >> #
> >> CONFIG_CPU_FREQ=3Dy
> >> CONFIG_CPU_FREQ_GOV_ATTR_SET=3Dy
> >> CONFIG_CPU_FREQ_GOV_COMMON=3Dy
> >> CONFIG_CPU_FREQ_STAT=3Dy
> >> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
> >> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> >> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> >> # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
> >> # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
> >> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> >> CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
> >> CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
> >> CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
> >> CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
> >> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy
> >> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=3Dy
> >>
> >> #
> >> # CPU frequency scaling drivers
> >> #
> >> CONFIG_X86_INTEL_PSTATE=3Dy
> >> # CONFIG_X86_PCC_CPUFREQ is not set
> >> CONFIG_X86_ACPI_CPUFREQ=3Dm
> >> CONFIG_X86_ACPI_CPUFREQ_CPB=3Dy
> >> CONFIG_X86_POWERNOW_K8=3Dm
> >> CONFIG_X86_AMD_FREQ_SENSITIVITY=3Dm
> >> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> >> CONFIG_X86_P4_CLOCKMOD=3Dm
> >>
> >> #
> >> # shared options
> >> #
> >> CONFIG_X86_SPEEDSTEP_LIB=3Dm
> >> # end of CPU Frequency scaling
> >>
> >> #
> >> # CPU Idle
> >> #
> >> CONFIG_CPU_IDLE=3Dy
> >> # CONFIG_CPU_IDLE_GOV_LADDER is not set
> >> CONFIG_CPU_IDLE_GOV_MENU=3Dy
> >> # CONFIG_CPU_IDLE_GOV_TEO is not set
> >> # CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
> >> CONFIG_HALTPOLL_CPUIDLE=3Dy
> >> # end of CPU Idle
> >>
> >> CONFIG_INTEL_IDLE=3Dy
> >> # end of Power management and ACPI options
> >>
> >> #
> >> # Bus options (PCI etc.)
> >> #
> >> CONFIG_PCI_DIRECT=3Dy
> >> CONFIG_PCI_MMCONFIG=3Dy
> >> CONFIG_PCI_XEN=3Dy
> >> CONFIG_MMCONF_FAM10H=3Dy
> >> CONFIG_ISA_DMA_API=3Dy
> >> CONFIG_AMD_NB=3Dy
> >> # CONFIG_X86_SYSFB is not set
> >> # end of Bus options (PCI etc.)
> >>
> >> #
> >> # Binary Emulations
> >> #
> >> CONFIG_IA32_EMULATION=3Dy
> >> # CONFIG_X86_X32 is not set
> >> CONFIG_COMPAT_32=3Dy
> >> CONFIG_COMPAT=3Dy
> >> CONFIG_COMPAT_FOR_U64_ALIGNMENT=3Dy
> >> CONFIG_SYSVIPC_COMPAT=3Dy
> >> # end of Binary Emulations
> >>
> >> #
> >> # Firmware Drivers
> >> #
> >> CONFIG_EDD=3Dm
> >> # CONFIG_EDD_OFF is not set
> >> CONFIG_FIRMWARE_MEMMAP=3Dy
> >> CONFIG_DMIID=3Dy
> >> CONFIG_DMI_SYSFS=3Dy
> >> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=3Dy
> >> # CONFIG_ISCSI_IBFT is not set
> >> CONFIG_FW_CFG_SYSFS=3Dy
> >> # CONFIG_FW_CFG_SYSFS_CMDLINE is not set
> >> # CONFIG_GOOGLE_FIRMWARE is not set
> >>
> >> #
> >> # EFI (Extensible Firmware Interface) Support
> >> #
> >> CONFIG_EFI_VARS=3Dy
> >> CONFIG_EFI_ESRT=3Dy
> >> CONFIG_EFI_VARS_PSTORE=3Dy
> >> CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=3Dy
> >> CONFIG_EFI_RUNTIME_MAP=3Dy
> >> # CONFIG_EFI_FAKE_MEMMAP is not set
> >> CONFIG_EFI_RUNTIME_WRAPPERS=3Dy
> >> CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=3Dy
> >> # CONFIG_EFI_BOOTLOADER_CONTROL is not set
> >> # CONFIG_EFI_CAPSULE_LOADER is not set
> >> # CONFIG_EFI_TEST is not set
> >> CONFIG_APPLE_PROPERTIES=3Dy
> >> # CONFIG_RESET_ATTACK_MITIGATION is not set
> >> # CONFIG_EFI_RCI2_TABLE is not set
> >> # CONFIG_EFI_DISABLE_PCI_DMA is not set
> >> # end of EFI (Extensible Firmware Interface) Support
> >>
> >> CONFIG_UEFI_CPER=3Dy
> >> CONFIG_UEFI_CPER_X86=3Dy
> >> CONFIG_EFI_DEV_PATH_PARSER=3Dy
> >> CONFIG_EFI_EARLYCON=3Dy
> >> CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=3Dy
> >>
> >> #
> >> # Tegra firmware driver
> >> #
> >> # end of Tegra firmware driver
> >> # end of Firmware Drivers
> >>
> >> CONFIG_HAVE_KVM=3Dy
> >> CONFIG_HAVE_KVM_IRQCHIP=3Dy
> >> CONFIG_HAVE_KVM_IRQFD=3Dy
> >> CONFIG_HAVE_KVM_IRQ_ROUTING=3Dy
> >> CONFIG_HAVE_KVM_EVENTFD=3Dy
> >> CONFIG_KVM_MMIO=3Dy
> >> CONFIG_KVM_ASYNC_PF=3Dy
> >> CONFIG_HAVE_KVM_MSI=3Dy
> >> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=3Dy
> >> CONFIG_KVM_VFIO=3Dy
> >> CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=3Dy
> >> CONFIG_KVM_COMPAT=3Dy
> >> CONFIG_HAVE_KVM_IRQ_BYPASS=3Dy
> >> CONFIG_HAVE_KVM_NO_POLL=3Dy
> >> CONFIG_VIRTUALIZATION=3Dy
> >> CONFIG_KVM=3Dm
> >> CONFIG_KVM_INTEL=3Dm
> >> CONFIG_KVM_AMD=3Dm
> >> CONFIG_KVM_AMD_SEV=3Dy
> >> CONFIG_KVM_MMU_AUDIT=3Dy
> >> CONFIG_AS_AVX512=3Dy
> >> CONFIG_AS_SHA1_NI=3Dy
> >> CONFIG_AS_SHA256_NI=3Dy
> >> CONFIG_AS_TPAUSE=3Dy
> >>
> >> #
> >> # General architecture-dependent options
> >> #
> >> CONFIG_CRASH_CORE=3Dy
> >> CONFIG_KEXEC_CORE=3Dy
> >> CONFIG_HOTPLUG_SMT=3Dy
> >> CONFIG_OPROFILE=3Dm
> >> CONFIG_OPROFILE_EVENT_MULTIPLEX=3Dy
> >> CONFIG_HAVE_OPROFILE=3Dy
> >> CONFIG_OPROFILE_NMI_TIMER=3Dy
> >> CONFIG_KPROBES=3Dy
> >> CONFIG_JUMP_LABEL=3Dy
> >> # CONFIG_STATIC_KEYS_SELFTEST is not set
> >> CONFIG_OPTPROBES=3Dy
> >> CONFIG_KPROBES_ON_FTRACE=3Dy
> >> CONFIG_UPROBES=3Dy
> >> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
> >> CONFIG_ARCH_USE_BUILTIN_BSWAP=3Dy
> >> CONFIG_KRETPROBES=3Dy
> >> CONFIG_USER_RETURN_NOTIFIER=3Dy
> >> CONFIG_HAVE_IOREMAP_PROT=3Dy
> >> CONFIG_HAVE_KPROBES=3Dy
> >> CONFIG_HAVE_KRETPROBES=3Dy
> >> CONFIG_HAVE_OPTPROBES=3Dy
> >> CONFIG_HAVE_KPROBES_ON_FTRACE=3Dy
> >> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=3Dy
> >> CONFIG_HAVE_NMI=3Dy
> >> CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
> >> CONFIG_HAVE_DMA_CONTIGUOUS=3Dy
> >> CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
> >> CONFIG_ARCH_HAS_FORTIFY_SOURCE=3Dy
> >> CONFIG_ARCH_HAS_SET_MEMORY=3Dy
> >> CONFIG_ARCH_HAS_SET_DIRECT_MAP=3Dy
> >> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=3Dy
> >> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=3Dy
> >> CONFIG_HAVE_ASM_MODVERSIONS=3Dy
> >> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
> >> CONFIG_HAVE_RSEQ=3Dy
> >> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=3Dy
> >> CONFIG_HAVE_HW_BREAKPOINT=3Dy
> >> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=3Dy
> >> CONFIG_HAVE_USER_RETURN_NOTIFIER=3Dy
> >> CONFIG_HAVE_PERF_EVENTS_NMI=3Dy
> >> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=3Dy
> >> CONFIG_HAVE_PERF_REGS=3Dy
> >> CONFIG_HAVE_PERF_USER_STACK_DUMP=3Dy
> >> CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy
> >> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=3Dy
> >> CONFIG_MMU_GATHER_TABLE_FREE=3Dy
> >> CONFIG_MMU_GATHER_RCU_TABLE_FREE=3Dy
> >> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy
> >> CONFIG_HAVE_ALIGNED_STRUCT_PAGE=3Dy
> >> CONFIG_HAVE_CMPXCHG_LOCAL=3Dy
> >> CONFIG_HAVE_CMPXCHG_DOUBLE=3Dy
> >> CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=3Dy
> >> CONFIG_ARCH_WANT_OLD_COMPAT_IPC=3Dy
> >> CONFIG_HAVE_ARCH_SECCOMP_FILTER=3Dy
> >> CONFIG_SECCOMP_FILTER=3Dy
> >> CONFIG_HAVE_ARCH_STACKLEAK=3Dy
> >> CONFIG_HAVE_STACKPROTECTOR=3Dy
> >> CONFIG_CC_HAS_STACKPROTECTOR_NONE=3Dy
> >> CONFIG_STACKPROTECTOR=3Dy
> >> CONFIG_STACKPROTECTOR_STRONG=3Dy
> >> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=3Dy
> >> CONFIG_HAVE_CONTEXT_TRACKING=3Dy
> >> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=3Dy
> >> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=3Dy
> >> CONFIG_HAVE_MOVE_PMD=3Dy
> >> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=3Dy
> >> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=3Dy
> >> CONFIG_HAVE_ARCH_HUGE_VMAP=3Dy
> >> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=3Dy
> >> CONFIG_HAVE_ARCH_SOFT_DIRTY=3Dy
> >> CONFIG_HAVE_MOD_ARCH_SPECIFIC=3Dy
> >> CONFIG_MODULES_USE_ELF_RELA=3Dy
> >> CONFIG_ARCH_HAS_ELF_RANDOMIZE=3Dy
> >> CONFIG_HAVE_ARCH_MMAP_RND_BITS=3Dy
> >> CONFIG_HAVE_EXIT_THREAD=3Dy
> >> CONFIG_ARCH_MMAP_RND_BITS=3D28
> >> CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=3Dy
> >> CONFIG_ARCH_MMAP_RND_COMPAT_BITS=3D8
> >> CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=3Dy
> >> CONFIG_HAVE_COPY_THREAD_TLS=3Dy
> >> CONFIG_HAVE_STACK_VALIDATION=3Dy
> >> CONFIG_HAVE_RELIABLE_STACKTRACE=3Dy
> >> CONFIG_OLD_SIGSUSPEND3=3Dy
> >> CONFIG_COMPAT_OLD_SIGACTION=3Dy
> >> CONFIG_COMPAT_32BIT_TIME=3Dy
> >> CONFIG_HAVE_ARCH_VMAP_STACK=3Dy
> >> CONFIG_VMAP_STACK=3Dy
> >> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=3Dy
> >> CONFIG_STRICT_KERNEL_RWX=3Dy
> >> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=3Dy
> >> CONFIG_STRICT_MODULE_RWX=3Dy
> >> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=3Dy
> >> CONFIG_ARCH_USE_MEMREMAP_PROT=3Dy
> >> # CONFIG_LOCK_EVENT_COUNTS is not set
> >> CONFIG_ARCH_HAS_MEM_ENCRYPT=3Dy
> >>
> >> #
> >> # GCOV-based kernel profiling
> >> #
> >> # CONFIG_GCOV_KERNEL is not set
> >> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=3Dy
> >> # end of GCOV-based kernel profiling
> >>
> >> CONFIG_HAVE_GCC_PLUGINS=3Dy
> >> # end of General architecture-dependent options
> >>
> >> CONFIG_RT_MUTEXES=3Dy
> >> CONFIG_BASE_SMALL=3D0
> >> CONFIG_MODULE_SIG_FORMAT=3Dy
> >> CONFIG_MODULES=3Dy
> >> CONFIG_MODULE_FORCE_LOAD=3Dy
> >> CONFIG_MODULE_UNLOAD=3Dy
> >> # CONFIG_MODULE_FORCE_UNLOAD is not set
> >> # CONFIG_MODVERSIONS is not set
> >> # CONFIG_MODULE_SRCVERSION_ALL is not set
> >> CONFIG_MODULE_SIG=3Dy
> >> # CONFIG_MODULE_SIG_FORCE is not set
> >> CONFIG_MODULE_SIG_ALL=3Dy
> >> # CONFIG_MODULE_SIG_SHA1 is not set
> >> # CONFIG_MODULE_SIG_SHA224 is not set
> >> CONFIG_MODULE_SIG_SHA256=3Dy
> >> # CONFIG_MODULE_SIG_SHA384 is not set
> >> # CONFIG_MODULE_SIG_SHA512 is not set
> >> CONFIG_MODULE_SIG_HASH=3D"sha256"
> >> # CONFIG_MODULE_COMPRESS is not set
> >> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> >> # CONFIG_UNUSED_SYMBOLS is not set
> >> # CONFIG_TRIM_UNUSED_KSYMS is not set
> >> CONFIG_MODULES_TREE_LOOKUP=3Dy
> >> CONFIG_BLOCK=3Dy
> >> CONFIG_BLK_SCSI_REQUEST=3Dy
> >> CONFIG_BLK_CGROUP_RWSTAT=3Dy
> >> CONFIG_BLK_DEV_BSG=3Dy
> >> CONFIG_BLK_DEV_BSGLIB=3Dy
> >> CONFIG_BLK_DEV_INTEGRITY=3Dy
> >> CONFIG_BLK_DEV_INTEGRITY_T10=3Dm
> >> CONFIG_BLK_DEV_ZONED=3Dy
> >> CONFIG_BLK_DEV_THROTTLING=3Dy
> >> # CONFIG_BLK_DEV_THROTTLING_LOW is not set
> >> # CONFIG_BLK_CMDLINE_PARSER is not set
> >> CONFIG_BLK_WBT=3Dy
> >> # CONFIG_BLK_CGROUP_IOLATENCY is not set
> >> # CONFIG_BLK_CGROUP_IOCOST is not set
> >> CONFIG_BLK_WBT_MQ=3Dy
> >> CONFIG_BLK_DEBUG_FS=3Dy
> >> CONFIG_BLK_DEBUG_FS_ZONED=3Dy
> >> # CONFIG_BLK_SED_OPAL is not set
> >> # CONFIG_BLK_INLINE_ENCRYPTION is not set
> >>
> >> #
> >> # Partition Types
> >> #
> >> CONFIG_PARTITION_ADVANCED=3Dy
> >> # CONFIG_ACORN_PARTITION is not set
> >> # CONFIG_AIX_PARTITION is not set
> >> CONFIG_OSF_PARTITION=3Dy
> >> CONFIG_AMIGA_PARTITION=3Dy
> >> # CONFIG_ATARI_PARTITION is not set
> >> CONFIG_MAC_PARTITION=3Dy
> >> CONFIG_MSDOS_PARTITION=3Dy
> >> CONFIG_BSD_DISKLABEL=3Dy
> >> CONFIG_MINIX_SUBPARTITION=3Dy
> >> CONFIG_SOLARIS_X86_PARTITION=3Dy
> >> CONFIG_UNIXWARE_DISKLABEL=3Dy
> >> # CONFIG_LDM_PARTITION is not set
> >> CONFIG_SGI_PARTITION=3Dy
> >> # CONFIG_ULTRIX_PARTITION is not set
> >> CONFIG_SUN_PARTITION=3Dy
> >> CONFIG_KARMA_PARTITION=3Dy
> >> CONFIG_EFI_PARTITION=3Dy
> >> # CONFIG_SYSV68_PARTITION is not set
> >> # CONFIG_CMDLINE_PARTITION is not set
> >> # end of Partition Types
> >>
> >> CONFIG_BLOCK_COMPAT=3Dy
> >> CONFIG_BLK_MQ_PCI=3Dy
> >> CONFIG_BLK_MQ_VIRTIO=3Dy
> >> CONFIG_BLK_MQ_RDMA=3Dy
> >> CONFIG_BLK_PM=3Dy
> >>
> >> #
> >> # IO Schedulers
> >> #
> >> CONFIG_MQ_IOSCHED_DEADLINE=3Dy
> >> CONFIG_MQ_IOSCHED_KYBER=3Dy
> >> CONFIG_IOSCHED_BFQ=3Dy
> >> CONFIG_BFQ_GROUP_IOSCHED=3Dy
> >> # CONFIG_BFQ_CGROUP_DEBUG is not set
> >> # end of IO Schedulers
> >>
> >> CONFIG_PREEMPT_NOTIFIERS=3Dy
> >> CONFIG_PADATA=3Dy
> >> CONFIG_ASN1=3Dy
> >> CONFIG_INLINE_SPIN_UNLOCK_IRQ=3Dy
> >> CONFIG_INLINE_READ_UNLOCK=3Dy
> >> CONFIG_INLINE_READ_UNLOCK_IRQ=3Dy
> >> CONFIG_INLINE_WRITE_UNLOCK=3Dy
> >> CONFIG_INLINE_WRITE_UNLOCK_IRQ=3Dy
> >> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy
> >> CONFIG_MUTEX_SPIN_ON_OWNER=3Dy
> >> CONFIG_RWSEM_SPIN_ON_OWNER=3Dy
> >> CONFIG_LOCK_SPIN_ON_OWNER=3Dy
> >> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=3Dy
> >> CONFIG_QUEUED_SPINLOCKS=3Dy
> >> CONFIG_ARCH_USE_QUEUED_RWLOCKS=3Dy
> >> CONFIG_QUEUED_RWLOCKS=3Dy
> >> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=3Dy
> >> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=3Dy
> >> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=3Dy
> >> CONFIG_FREEZER=3Dy
> >>
> >> #
> >> # Executable file formats
> >> #
> >> CONFIG_BINFMT_ELF=3Dy
> >> CONFIG_COMPAT_BINFMT_ELF=3Dy
> >> CONFIG_ELFCORE=3Dy
> >> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
> >> CONFIG_BINFMT_SCRIPT=3Dy
> >> CONFIG_BINFMT_MISC=3Dm
> >> CONFIG_COREDUMP=3Dy
> >> # end of Executable file formats
> >>
> >> #
> >> # Memory Management options
> >> #
> >> CONFIG_SELECT_MEMORY_MODEL=3Dy
> >> CONFIG_SPARSEMEM_MANUAL=3Dy
> >> CONFIG_SPARSEMEM=3Dy
> >> CONFIG_NEED_MULTIPLE_NODES=3Dy
> >> CONFIG_HAVE_MEMORY_PRESENT=3Dy
> >> CONFIG_SPARSEMEM_EXTREME=3Dy
> >> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
> >> CONFIG_SPARSEMEM_VMEMMAP=3Dy
> >> CONFIG_HAVE_FAST_GUP=3Dy
> >> CONFIG_NUMA_KEEP_MEMINFO=3Dy
> >> CONFIG_MEMORY_ISOLATION=3Dy
> >> CONFIG_HAVE_BOOTMEM_INFO_NODE=3Dy
> >> CONFIG_MEMORY_HOTPLUG=3Dy
> >> CONFIG_MEMORY_HOTPLUG_SPARSE=3Dy
> >> # CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
> >> CONFIG_MEMORY_HOTREMOVE=3Dy
> >> CONFIG_SPLIT_PTLOCK_CPUS=3D4
> >> CONFIG_MEMORY_BALLOON=3Dy
> >> CONFIG_BALLOON_COMPACTION=3Dy
> >> CONFIG_COMPACTION=3Dy
> >> CONFIG_PAGE_REPORTING=3Dy
> >> CONFIG_MIGRATION=3Dy
> >> CONFIG_CONTIG_ALLOC=3Dy
> >> CONFIG_PHYS_ADDR_T_64BIT=3Dy
> >> CONFIG_BOUNCE=3Dy
> >> CONFIG_VIRT_TO_BUS=3Dy
> >> CONFIG_MMU_NOTIFIER=3Dy
> >> CONFIG_KSM=3Dy
> >> CONFIG_DEFAULT_MMAP_MIN_ADDR=3D4096
> >> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=3Dy
> >> CONFIG_MEMORY_FAILURE=3Dy
> >> CONFIG_HWPOISON_INJECT=3Dm
> >> CONFIG_TRANSPARENT_HUGEPAGE=3Dy
> >> CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=3Dy
> >> # CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
> >> CONFIG_ARCH_WANTS_THP_SWAP=3Dy
> >> CONFIG_THP_SWAP=3Dy
> >> CONFIG_CLEANCACHE=3Dy
> >> CONFIG_FRONTSWAP=3Dy
> >> CONFIG_CMA=3Dy
> >> # CONFIG_CMA_DEBUG is not set
> >> # CONFIG_CMA_DEBUGFS is not set
> >> CONFIG_CMA_AREAS=3D7
> >> CONFIG_ZSWAP=3Dy
> >> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
> >> CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=3Dy
> >> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
> >> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
> >> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
> >> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
> >> CONFIG_ZSWAP_COMPRESSOR_DEFAULT=3D"lzo"
> >> CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=3Dy
> >> # CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
> >> # CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
> >> CONFIG_ZSWAP_ZPOOL_DEFAULT=3D"zbud"
> >> # CONFIG_ZSWAP_DEFAULT_ON is not set
> >> CONFIG_ZPOOL=3Dy
> >> CONFIG_ZBUD=3Dy
> >> # CONFIG_Z3FOLD is not set
> >> CONFIG_ZSMALLOC=3Dy
> >> # CONFIG_ZSMALLOC_PGTABLE_MAPPING is not set
> >> CONFIG_ZSMALLOC_STAT=3Dy
> >> CONFIG_GENERIC_EARLY_IOREMAP=3Dy
> >> CONFIG_DEFERRED_STRUCT_PAGE_INIT=3Dy
> >> CONFIG_IDLE_PAGE_TRACKING=3Dy
> >> CONFIG_ARCH_HAS_PTE_DEVMAP=3Dy
> >> CONFIG_ZONE_DEVICE=3Dy
> >> CONFIG_DEV_PAGEMAP_OPS=3Dy
> >> CONFIG_DEVICE_PRIVATE=3Dy
> >> CONFIG_ARCH_USES_HIGH_VMA_FLAGS=3Dy
> >> CONFIG_ARCH_HAS_PKEYS=3Dy
> >> # CONFIG_PERCPU_STATS is not set
> >> # CONFIG_GUP_BENCHMARK is not set
> >> # CONFIG_READ_ONLY_THP_FOR_FS is not set
> >> CONFIG_ARCH_HAS_PTE_SPECIAL=3Dy
> >> CONFIG_MAPPING_DIRTY_HELPERS=3Dy
> >> # end of Memory Management options
> >>
> >> CONFIG_NET=3Dy
> >> CONFIG_COMPAT_NETLINK_MESSAGES=3Dy
> >> CONFIG_NET_INGRESS=3Dy
> >> CONFIG_NET_EGRESS=3Dy
> >> CONFIG_SKB_EXTENSIONS=3Dy
> >>
> >> #
> >> # Networking options
> >> #
> >> CONFIG_PACKET=3Dy
> >> CONFIG_PACKET_DIAG=3Dm
> >> CONFIG_UNIX=3Dy
> >> CONFIG_UNIX_SCM=3Dy
> >> CONFIG_UNIX_DIAG=3Dm
> >> CONFIG_TLS=3Dm
> >> CONFIG_TLS_DEVICE=3Dy
> >> # CONFIG_TLS_TOE is not set
> >> CONFIG_XFRM=3Dy
> >> CONFIG_XFRM_OFFLOAD=3Dy
> >> CONFIG_XFRM_ALGO=3Dy
> >> CONFIG_XFRM_USER=3Dy
> >> # CONFIG_XFRM_INTERFACE is not set
> >> CONFIG_XFRM_SUB_POLICY=3Dy
> >> CONFIG_XFRM_MIGRATE=3Dy
> >> CONFIG_XFRM_STATISTICS=3Dy
> >> CONFIG_XFRM_AH=3Dm
> >> CONFIG_XFRM_ESP=3Dm
> >> CONFIG_XFRM_IPCOMP=3Dm
> >> CONFIG_NET_KEY=3Dm
> >> CONFIG_NET_KEY_MIGRATE=3Dy
> >> # CONFIG_SMC is not set
> >> CONFIG_XDP_SOCKETS=3Dy
> >> # CONFIG_XDP_SOCKETS_DIAG is not set
> >> CONFIG_INET=3Dy
> >> CONFIG_IP_MULTICAST=3Dy
> >> CONFIG_IP_ADVANCED_ROUTER=3Dy
> >> CONFIG_IP_FIB_TRIE_STATS=3Dy
> >> CONFIG_IP_MULTIPLE_TABLES=3Dy
> >> CONFIG_IP_ROUTE_MULTIPATH=3Dy
> >> CONFIG_IP_ROUTE_VERBOSE=3Dy
> >> CONFIG_IP_ROUTE_CLASSID=3Dy
> >> CONFIG_IP_PNP=3Dy
> >> CONFIG_IP_PNP_DHCP=3Dy
> >> # CONFIG_IP_PNP_BOOTP is not set
> >> # CONFIG_IP_PNP_RARP is not set
> >> CONFIG_NET_IPIP=3Dm
> >> CONFIG_NET_IPGRE_DEMUX=3Dm
> >> CONFIG_NET_IP_TUNNEL=3Dm
> >> CONFIG_NET_IPGRE=3Dm
> >> CONFIG_NET_IPGRE_BROADCAST=3Dy
> >> CONFIG_IP_MROUTE_COMMON=3Dy
> >> CONFIG_IP_MROUTE=3Dy
> >> CONFIG_IP_MROUTE_MULTIPLE_TABLES=3Dy
> >> CONFIG_IP_PIMSM_V1=3Dy
> >> CONFIG_IP_PIMSM_V2=3Dy
> >> CONFIG_SYN_COOKIES=3Dy
> >> CONFIG_NET_IPVTI=3Dm
> >> CONFIG_NET_UDP_TUNNEL=3Dm
> >> # CONFIG_NET_FOU is not set
> >> # CONFIG_NET_FOU_IP_TUNNELS is not set
> >> CONFIG_INET_AH=3Dm
> >> CONFIG_INET_ESP=3Dm
> >> CONFIG_INET_ESP_OFFLOAD=3Dm
> >> # CONFIG_INET_ESPINTCP is not set
> >> CONFIG_INET_IPCOMP=3Dm
> >> CONFIG_INET_XFRM_TUNNEL=3Dm
> >> CONFIG_INET_TUNNEL=3Dm
> >> CONFIG_INET_DIAG=3Dm
> >> CONFIG_INET_TCP_DIAG=3Dm
> >> CONFIG_INET_UDP_DIAG=3Dm
> >> CONFIG_INET_RAW_DIAG=3Dm
> >> # CONFIG_INET_DIAG_DESTROY is not set
> >> CONFIG_TCP_CONG_ADVANCED=3Dy
> >> CONFIG_TCP_CONG_BIC=3Dm
> >> CONFIG_TCP_CONG_CUBIC=3Dy
> >> CONFIG_TCP_CONG_WESTWOOD=3Dm
> >> CONFIG_TCP_CONG_HTCP=3Dm
> >> CONFIG_TCP_CONG_HSTCP=3Dm
> >> CONFIG_TCP_CONG_HYBLA=3Dm
> >> CONFIG_TCP_CONG_VEGAS=3Dm
> >> CONFIG_TCP_CONG_NV=3Dm
> >> CONFIG_TCP_CONG_SCALABLE=3Dm
> >> CONFIG_TCP_CONG_LP=3Dm
> >> CONFIG_TCP_CONG_VENO=3Dm
> >> CONFIG_TCP_CONG_YEAH=3Dm
> >> CONFIG_TCP_CONG_ILLINOIS=3Dm
> >> CONFIG_TCP_CONG_DCTCP=3Dm
> >> # CONFIG_TCP_CONG_CDG is not set
> >> CONFIG_TCP_CONG_BBR=3Dm
> >> CONFIG_DEFAULT_CUBIC=3Dy
> >> # CONFIG_DEFAULT_RENO is not set
> >> CONFIG_DEFAULT_TCP_CONG=3D"cubic"
> >> CONFIG_TCP_MD5SIG=3Dy
> >> CONFIG_IPV6=3Dy
> >> CONFIG_IPV6_ROUTER_PREF=3Dy
> >> CONFIG_IPV6_ROUTE_INFO=3Dy
> >> CONFIG_IPV6_OPTIMISTIC_DAD=3Dy
> >> CONFIG_INET6_AH=3Dm
> >> CONFIG_INET6_ESP=3Dm
> >> CONFIG_INET6_ESP_OFFLOAD=3Dm
> >> # CONFIG_INET6_ESPINTCP is not set
> >> CONFIG_INET6_IPCOMP=3Dm
> >> CONFIG_IPV6_MIP6=3Dm
> >> # CONFIG_IPV6_ILA is not set
> >> CONFIG_INET6_XFRM_TUNNEL=3Dm
> >> CONFIG_INET6_TUNNEL=3Dm
> >> CONFIG_IPV6_VTI=3Dm
> >> CONFIG_IPV6_SIT=3Dm
> >> CONFIG_IPV6_SIT_6RD=3Dy
> >> CONFIG_IPV6_NDISC_NODETYPE=3Dy
> >> CONFIG_IPV6_TUNNEL=3Dm
> >> CONFIG_IPV6_GRE=3Dm
> >> CONFIG_IPV6_MULTIPLE_TABLES=3Dy
> >> # CONFIG_IPV6_SUBTREES is not set
> >> CONFIG_IPV6_MROUTE=3Dy
> >> CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=3Dy
> >> CONFIG_IPV6_PIMSM_V2=3Dy
> >> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> >> # CONFIG_IPV6_SEG6_HMAC is not set
> >> # CONFIG_IPV6_RPL_LWTUNNEL is not set
> >> CONFIG_NETLABEL=3Dy
> >> # CONFIG_MPTCP is not set
> >> CONFIG_NETWORK_SECMARK=3Dy
> >> CONFIG_NET_PTP_CLASSIFY=3Dy
> >> CONFIG_NETWORK_PHY_TIMESTAMPING=3Dy
> >> CONFIG_NETFILTER=3Dy
> >> CONFIG_NETFILTER_ADVANCED=3Dy
> >> CONFIG_BRIDGE_NETFILTER=3Dm
> >>
> >> #
> >> # Core Netfilter Configuration
> >> #
> >> CONFIG_NETFILTER_INGRESS=3Dy
> >> CONFIG_NETFILTER_NETLINK=3Dm
> >> CONFIG_NETFILTER_FAMILY_BRIDGE=3Dy
> >> CONFIG_NETFILTER_FAMILY_ARP=3Dy
> >> # CONFIG_NETFILTER_NETLINK_ACCT is not set
> >> CONFIG_NETFILTER_NETLINK_QUEUE=3Dm
> >> CONFIG_NETFILTER_NETLINK_LOG=3Dm
> >> CONFIG_NETFILTER_NETLINK_OSF=3Dm
> >> CONFIG_NF_CONNTRACK=3Dm
> >> CONFIG_NF_LOG_COMMON=3Dm
> >> CONFIG_NF_LOG_NETDEV=3Dm
> >> CONFIG_NETFILTER_CONNCOUNT=3Dm
> >> CONFIG_NF_CONNTRACK_MARK=3Dy
> >> CONFIG_NF_CONNTRACK_SECMARK=3Dy
> >> CONFIG_NF_CONNTRACK_ZONES=3Dy
> >> CONFIG_NF_CONNTRACK_PROCFS=3Dy
> >> CONFIG_NF_CONNTRACK_EVENTS=3Dy
> >> CONFIG_NF_CONNTRACK_TIMEOUT=3Dy
> >> CONFIG_NF_CONNTRACK_TIMESTAMP=3Dy
> >> CONFIG_NF_CONNTRACK_LABELS=3Dy
> >> CONFIG_NF_CT_PROTO_DCCP=3Dy
> >> CONFIG_NF_CT_PROTO_GRE=3Dy
> >> CONFIG_NF_CT_PROTO_SCTP=3Dy
> >> CONFIG_NF_CT_PROTO_UDPLITE=3Dy
> >> CONFIG_NF_CONNTRACK_AMANDA=3Dm
> >> CONFIG_NF_CONNTRACK_FTP=3Dm
> >> CONFIG_NF_CONNTRACK_H323=3Dm
> >> CONFIG_NF_CONNTRACK_IRC=3Dm
> >> CONFIG_NF_CONNTRACK_BROADCAST=3Dm
> >> CONFIG_NF_CONNTRACK_NETBIOS_NS=3Dm
> >> CONFIG_NF_CONNTRACK_SNMP=3Dm
> >> CONFIG_NF_CONNTRACK_PPTP=3Dm
> >> CONFIG_NF_CONNTRACK_SANE=3Dm
> >> CONFIG_NF_CONNTRACK_SIP=3Dm
> >> CONFIG_NF_CONNTRACK_TFTP=3Dm
> >> CONFIG_NF_CT_NETLINK=3Dm
> >> CONFIG_NF_CT_NETLINK_TIMEOUT=3Dm
> >> CONFIG_NF_CT_NETLINK_HELPER=3Dm
> >> CONFIG_NETFILTER_NETLINK_GLUE_CT=3Dy
> >> CONFIG_NF_NAT=3Dm
> >> CONFIG_NF_NAT_AMANDA=3Dm
> >> CONFIG_NF_NAT_FTP=3Dm
> >> CONFIG_NF_NAT_IRC=3Dm
> >> CONFIG_NF_NAT_SIP=3Dm
> >> CONFIG_NF_NAT_TFTP=3Dm
> >> CONFIG_NF_NAT_REDIRECT=3Dy
> >> CONFIG_NF_NAT_MASQUERADE=3Dy
> >> CONFIG_NETFILTER_SYNPROXY=3Dm
> >> CONFIG_NF_TABLES=3Dm
> >> CONFIG_NF_TABLES_INET=3Dy
> >> CONFIG_NF_TABLES_NETDEV=3Dy
> >> CONFIG_NFT_NUMGEN=3Dm
> >> CONFIG_NFT_CT=3Dm
> >> CONFIG_NFT_COUNTER=3Dm
> >> CONFIG_NFT_CONNLIMIT=3Dm
> >> CONFIG_NFT_LOG=3Dm
> >> CONFIG_NFT_LIMIT=3Dm
> >> CONFIG_NFT_MASQ=3Dm
> >> CONFIG_NFT_REDIR=3Dm
> >> CONFIG_NFT_NAT=3Dm
> >> # CONFIG_NFT_TUNNEL is not set
> >> CONFIG_NFT_OBJREF=3Dm
> >> CONFIG_NFT_QUEUE=3Dm
> >> CONFIG_NFT_QUOTA=3Dm
> >> CONFIG_NFT_REJECT=3Dm
> >> CONFIG_NFT_REJECT_INET=3Dm
> >> CONFIG_NFT_COMPAT=3Dm
> >> CONFIG_NFT_HASH=3Dm
> >> CONFIG_NFT_FIB=3Dm
> >> CONFIG_NFT_FIB_INET=3Dm
> >> # CONFIG_NFT_XFRM is not set
> >> CONFIG_NFT_SOCKET=3Dm
> >> # CONFIG_NFT_OSF is not set
> >> # CONFIG_NFT_TPROXY is not set
> >> # CONFIG_NFT_SYNPROXY is not set
> >> CONFIG_NF_DUP_NETDEV=3Dm
> >> CONFIG_NFT_DUP_NETDEV=3Dm
> >> CONFIG_NFT_FWD_NETDEV=3Dm
> >> CONFIG_NFT_FIB_NETDEV=3Dm
> >> # CONFIG_NF_FLOW_TABLE is not set
> >> CONFIG_NETFILTER_XTABLES=3Dy
> >>
> >> #
> >> # Xtables combined modules
> >> #
> >> CONFIG_NETFILTER_XT_MARK=3Dm
> >> CONFIG_NETFILTER_XT_CONNMARK=3Dm
> >> CONFIG_NETFILTER_XT_SET=3Dm
> >>
> >> #
> >> # Xtables targets
> >> #
> >> CONFIG_NETFILTER_XT_TARGET_AUDIT=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_CHECKSUM=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_CT=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_DSCP=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_HL=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_HMARK=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_IDLETIMER=3Dm
> >> # CONFIG_NETFILTER_XT_TARGET_LED is not set
> >> CONFIG_NETFILTER_XT_TARGET_LOG=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_MARK=3Dm
> >> CONFIG_NETFILTER_XT_NAT=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_NETMAP=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_NOTRACK=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_RATEEST=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_REDIRECT=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_MASQUERADE=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_TEE=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_TPROXY=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_TRACE=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_SECMARK=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dm
> >> CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=3Dm
> >>
> >> #
> >> # Xtables matches
> >> #
> >> CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_CGROUP=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_CLUSTER=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_CONNBYTES=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_CONNLABEL=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_CPU=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_DCCP=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_DEVGROUP=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_DSCP=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_ECN=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_ESP=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_HELPER=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_HL=3Dm
> >> # CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
> >> CONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_IPVS=3Dm
> >> # CONFIG_NETFILTER_XT_MATCH_L2TP is not set
> >> CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_MAC=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_MARK=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_MULTIPORT=3Dm
> >> # CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
> >> CONFIG_NETFILTER_XT_MATCH_OSF=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_OWNER=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_POLICY=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_PHYSDEV=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_QUOTA=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_RATEEST=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_REALM=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_RECENT=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_SCTP=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_SOCKET=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_STATE=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_STRING=3Dm
> >> CONFIG_NETFILTER_XT_MATCH_TCPMSS=3Dm
> >> # CONFIG_NETFILTER_XT_MATCH_TIME is not set
> >> # CONFIG_NETFILTER_XT_MATCH_U32 is not set
> >> # end of Core Netfilter Configuration
> >>
> >> CONFIG_IP_SET=3Dm
> >> CONFIG_IP_SET_MAX=3D256
> >> CONFIG_IP_SET_BITMAP_IP=3Dm
> >> CONFIG_IP_SET_BITMAP_IPMAC=3Dm
> >> CONFIG_IP_SET_BITMAP_PORT=3Dm
> >> CONFIG_IP_SET_HASH_IP=3Dm
> >> CONFIG_IP_SET_HASH_IPMARK=3Dm
> >> CONFIG_IP_SET_HASH_IPPORT=3Dm
> >> CONFIG_IP_SET_HASH_IPPORTIP=3Dm
> >> CONFIG_IP_SET_HASH_IPPORTNET=3Dm
> >> CONFIG_IP_SET_HASH_IPMAC=3Dm
> >> CONFIG_IP_SET_HASH_MAC=3Dm
> >> CONFIG_IP_SET_HASH_NETPORTNET=3Dm
> >> CONFIG_IP_SET_HASH_NET=3Dm
> >> CONFIG_IP_SET_HASH_NETNET=3Dm
> >> CONFIG_IP_SET_HASH_NETPORT=3Dm
> >> CONFIG_IP_SET_HASH_NETIFACE=3Dm
> >> CONFIG_IP_SET_LIST_SET=3Dm
> >> CONFIG_IP_VS=3Dm
> >> CONFIG_IP_VS_IPV6=3Dy
> >> # CONFIG_IP_VS_DEBUG is not set
> >> CONFIG_IP_VS_TAB_BITS=3D12
> >>
> >> #
> >> # IPVS transport protocol load balancing support
> >> #
> >> CONFIG_IP_VS_PROTO_TCP=3Dy
> >> CONFIG_IP_VS_PROTO_UDP=3Dy
> >> CONFIG_IP_VS_PROTO_AH_ESP=3Dy
> >> CONFIG_IP_VS_PROTO_ESP=3Dy
> >> CONFIG_IP_VS_PROTO_AH=3Dy
> >> CONFIG_IP_VS_PROTO_SCTP=3Dy
> >>
> >> #
> >> # IPVS scheduler
> >> #
> >> CONFIG_IP_VS_RR=3Dm
> >> CONFIG_IP_VS_WRR=3Dm
> >> CONFIG_IP_VS_LC=3Dm
> >> CONFIG_IP_VS_WLC=3Dm
> >> CONFIG_IP_VS_FO=3Dm
> >> CONFIG_IP_VS_OVF=3Dm
> >> CONFIG_IP_VS_LBLC=3Dm
> >> CONFIG_IP_VS_LBLCR=3Dm
> >> CONFIG_IP_VS_DH=3Dm
> >> CONFIG_IP_VS_SH=3Dm
> >> # CONFIG_IP_VS_MH is not set
> >> CONFIG_IP_VS_SED=3Dm
> >> CONFIG_IP_VS_NQ=3Dm
> >>
> >> #
> >> # IPVS SH scheduler
> >> #
> >> CONFIG_IP_VS_SH_TAB_BITS=3D8
> >>
> >> #
> >> # IPVS MH scheduler
> >> #
> >> CONFIG_IP_VS_MH_TAB_INDEX=3D12
> >>
> >> #
> >> # IPVS application helper
> >> #
> >> CONFIG_IP_VS_FTP=3Dm
> >> CONFIG_IP_VS_NFCT=3Dy
> >> CONFIG_IP_VS_PE_SIP=3Dm
> >>
> >> #
> >> # IP: Netfilter Configuration
> >> #
> >> CONFIG_NF_DEFRAG_IPV4=3Dm
> >> CONFIG_NF_SOCKET_IPV4=3Dm
> >> CONFIG_NF_TPROXY_IPV4=3Dm
> >> CONFIG_NF_TABLES_IPV4=3Dy
> >> CONFIG_NFT_REJECT_IPV4=3Dm
> >> CONFIG_NFT_DUP_IPV4=3Dm
> >> CONFIG_NFT_FIB_IPV4=3Dm
> >> CONFIG_NF_TABLES_ARP=3Dy
> >> CONFIG_NF_DUP_IPV4=3Dm
> >> CONFIG_NF_LOG_ARP=3Dm
> >> CONFIG_NF_LOG_IPV4=3Dm
> >> CONFIG_NF_REJECT_IPV4=3Dm
> >> CONFIG_NF_NAT_SNMP_BASIC=3Dm
> >> CONFIG_NF_NAT_PPTP=3Dm
> >> CONFIG_NF_NAT_H323=3Dm
> >> CONFIG_IP_NF_IPTABLES=3Dm
> >> CONFIG_IP_NF_MATCH_AH=3Dm
> >> CONFIG_IP_NF_MATCH_ECN=3Dm
> >> CONFIG_IP_NF_MATCH_RPFILTER=3Dm
> >> CONFIG_IP_NF_MATCH_TTL=3Dm
> >> CONFIG_IP_NF_FILTER=3Dm
> >> CONFIG_IP_NF_TARGET_REJECT=3Dm
> >> CONFIG_IP_NF_TARGET_SYNPROXY=3Dm
> >> CONFIG_IP_NF_NAT=3Dm
> >> CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
> >> CONFIG_IP_NF_TARGET_NETMAP=3Dm
> >> CONFIG_IP_NF_TARGET_REDIRECT=3Dm
> >> CONFIG_IP_NF_MANGLE=3Dm
> >> # CONFIG_IP_NF_TARGET_CLUSTERIP is not set
> >> CONFIG_IP_NF_TARGET_ECN=3Dm
> >> CONFIG_IP_NF_TARGET_TTL=3Dm
> >> CONFIG_IP_NF_RAW=3Dm
> >> CONFIG_IP_NF_SECURITY=3Dm
> >> CONFIG_IP_NF_ARPTABLES=3Dm
> >> CONFIG_IP_NF_ARPFILTER=3Dm
> >> CONFIG_IP_NF_ARP_MANGLE=3Dm
> >> # end of IP: Netfilter Configuration
> >>
> >> #
> >> # IPv6: Netfilter Configuration
> >> #
> >> CONFIG_NF_SOCKET_IPV6=3Dm
> >> CONFIG_NF_TPROXY_IPV6=3Dm
> >> CONFIG_NF_TABLES_IPV6=3Dy
> >> CONFIG_NFT_REJECT_IPV6=3Dm
> >> CONFIG_NFT_DUP_IPV6=3Dm
> >> CONFIG_NFT_FIB_IPV6=3Dm
> >> CONFIG_NF_DUP_IPV6=3Dm
> >> CONFIG_NF_REJECT_IPV6=3Dm
> >> CONFIG_NF_LOG_IPV6=3Dm
> >> CONFIG_IP6_NF_IPTABLES=3Dm
> >> CONFIG_IP6_NF_MATCH_AH=3Dm
> >> CONFIG_IP6_NF_MATCH_EUI64=3Dm
> >> CONFIG_IP6_NF_MATCH_FRAG=3Dm
> >> CONFIG_IP6_NF_MATCH_OPTS=3Dm
> >> CONFIG_IP6_NF_MATCH_HL=3Dm
> >> CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm
> >> CONFIG_IP6_NF_MATCH_MH=3Dm
> >> CONFIG_IP6_NF_MATCH_RPFILTER=3Dm
> >> CONFIG_IP6_NF_MATCH_RT=3Dm
> >> # CONFIG_IP6_NF_MATCH_SRH is not set
> >> # CONFIG_IP6_NF_TARGET_HL is not set
> >> CONFIG_IP6_NF_FILTER=3Dm
> >> CONFIG_IP6_NF_TARGET_REJECT=3Dm
> >> CONFIG_IP6_NF_TARGET_SYNPROXY=3Dm
> >> CONFIG_IP6_NF_MANGLE=3Dm
> >> CONFIG_IP6_NF_RAW=3Dm
> >> CONFIG_IP6_NF_SECURITY=3Dm
> >> CONFIG_IP6_NF_NAT=3Dm
> >> CONFIG_IP6_NF_TARGET_MASQUERADE=3Dm
> >> CONFIG_IP6_NF_TARGET_NPT=3Dm
> >> # end of IPv6: Netfilter Configuration
> >>
> >> CONFIG_NF_DEFRAG_IPV6=3Dm
> >> CONFIG_NF_TABLES_BRIDGE=3Dm
> >> # CONFIG_NFT_BRIDGE_META is not set
> >> CONFIG_NFT_BRIDGE_REJECT=3Dm
> >> CONFIG_NF_LOG_BRIDGE=3Dm
> >> # CONFIG_NF_CONNTRACK_BRIDGE is not set
> >> CONFIG_BRIDGE_NF_EBTABLES=3Dm
> >> CONFIG_BRIDGE_EBT_BROUTE=3Dm
> >> CONFIG_BRIDGE_EBT_T_FILTER=3Dm
> >> CONFIG_BRIDGE_EBT_T_NAT=3Dm
> >> CONFIG_BRIDGE_EBT_802_3=3Dm
> >> CONFIG_BRIDGE_EBT_AMONG=3Dm
> >> CONFIG_BRIDGE_EBT_ARP=3Dm
> >> CONFIG_BRIDGE_EBT_IP=3Dm
> >> CONFIG_BRIDGE_EBT_IP6=3Dm
> >> CONFIG_BRIDGE_EBT_LIMIT=3Dm
> >> CONFIG_BRIDGE_EBT_MARK=3Dm
> >> CONFIG_BRIDGE_EBT_PKTTYPE=3Dm
> >> CONFIG_BRIDGE_EBT_STP=3Dm
> >> CONFIG_BRIDGE_EBT_VLAN=3Dm
> >> CONFIG_BRIDGE_EBT_ARPREPLY=3Dm
> >> CONFIG_BRIDGE_EBT_DNAT=3Dm
> >> CONFIG_BRIDGE_EBT_MARK_T=3Dm
> >> CONFIG_BRIDGE_EBT_REDIRECT=3Dm
> >> CONFIG_BRIDGE_EBT_SNAT=3Dm
> >> CONFIG_BRIDGE_EBT_LOG=3Dm
> >> CONFIG_BRIDGE_EBT_NFLOG=3Dm
> >> # CONFIG_BPFILTER is not set
> >> # CONFIG_IP_DCCP is not set
> >> CONFIG_IP_SCTP=3Dm
> >> # CONFIG_SCTP_DBG_OBJCNT is not set
> >> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
> >> CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=3Dy
> >> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
> >> CONFIG_SCTP_COOKIE_HMAC_MD5=3Dy
> >> CONFIG_SCTP_COOKIE_HMAC_SHA1=3Dy
> >> CONFIG_INET_SCTP_DIAG=3Dm
> >> # CONFIG_RDS is not set
> >> CONFIG_TIPC=3Dm
> >> # CONFIG_TIPC_MEDIA_IB is not set
> >> CONFIG_TIPC_MEDIA_UDP=3Dy
> >> CONFIG_TIPC_CRYPTO=3Dy
> >> CONFIG_TIPC_DIAG=3Dm
> >> CONFIG_ATM=3Dm
> >> CONFIG_ATM_CLIP=3Dm
> >> # CONFIG_ATM_CLIP_NO_ICMP is not set
> >> CONFIG_ATM_LANE=3Dm
> >> # CONFIG_ATM_MPOA is not set
> >> CONFIG_ATM_BR2684=3Dm
> >> # CONFIG_ATM_BR2684_IPFILTER is not set
> >> CONFIG_L2TP=3Dm
> >> CONFIG_L2TP_DEBUGFS=3Dm
> >> CONFIG_L2TP_V3=3Dy
> >> CONFIG_L2TP_IP=3Dm
> >> CONFIG_L2TP_ETH=3Dm
> >> CONFIG_STP=3Dm
> >> CONFIG_GARP=3Dm
> >> CONFIG_MRP=3Dm
> >> CONFIG_BRIDGE=3Dm
> >> CONFIG_BRIDGE_IGMP_SNOOPING=3Dy
> >> CONFIG_BRIDGE_VLAN_FILTERING=3Dy
> >> # CONFIG_BRIDGE_MRP is not set
> >> CONFIG_HAVE_NET_DSA=3Dy
> >> # CONFIG_NET_DSA is not set
> >> CONFIG_VLAN_8021Q=3Dm
> >> CONFIG_VLAN_8021Q_GVRP=3Dy
> >> CONFIG_VLAN_8021Q_MVRP=3Dy
> >> # CONFIG_DECNET is not set
> >> CONFIG_LLC=3Dm
> >> # CONFIG_LLC2 is not set
> >> # CONFIG_ATALK is not set
> >> # CONFIG_X25 is not set
> >> # CONFIG_LAPB is not set
> >> # CONFIG_PHONET is not set
> >> CONFIG_6LOWPAN=3Dm
> >> # CONFIG_6LOWPAN_DEBUGFS is not set
> >> # CONFIG_6LOWPAN_NHC is not set
> >> CONFIG_IEEE802154=3Dm
> >> # CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
> >> CONFIG_IEEE802154_SOCKET=3Dm
> >> CONFIG_IEEE802154_6LOWPAN=3Dm
> >> CONFIG_MAC802154=3Dm
> >> CONFIG_NET_SCHED=3Dy
> >>
> >> #
> >> # Queueing/Scheduling
> >> #
> >> CONFIG_NET_SCH_CBQ=3Dm
> >> CONFIG_NET_SCH_HTB=3Dm
> >> CONFIG_NET_SCH_HFSC=3Dm
> >> CONFIG_NET_SCH_ATM=3Dm
> >> CONFIG_NET_SCH_PRIO=3Dm
> >> CONFIG_NET_SCH_MULTIQ=3Dm
> >> CONFIG_NET_SCH_RED=3Dm
> >> CONFIG_NET_SCH_SFB=3Dm
> >> CONFIG_NET_SCH_SFQ=3Dm
> >> CONFIG_NET_SCH_TEQL=3Dm
> >> CONFIG_NET_SCH_TBF=3Dm
> >> # CONFIG_NET_SCH_CBS is not set
> >> # CONFIG_NET_SCH_ETF is not set
> >> # CONFIG_NET_SCH_TAPRIO is not set
> >> CONFIG_NET_SCH_GRED=3Dm
> >> CONFIG_NET_SCH_DSMARK=3Dm
> >> CONFIG_NET_SCH_NETEM=3Dm
> >> CONFIG_NET_SCH_DRR=3Dm
> >> CONFIG_NET_SCH_MQPRIO=3Dm
> >> # CONFIG_NET_SCH_SKBPRIO is not set
> >> CONFIG_NET_SCH_CHOKE=3Dm
> >> CONFIG_NET_SCH_QFQ=3Dm
> >> CONFIG_NET_SCH_CODEL=3Dm
> >> CONFIG_NET_SCH_FQ_CODEL=3Dy
> >> # CONFIG_NET_SCH_CAKE is not set
> >> CONFIG_NET_SCH_FQ=3Dm
> >> CONFIG_NET_SCH_HHF=3Dm
> >> CONFIG_NET_SCH_PIE=3Dm
> >> # CONFIG_NET_SCH_FQ_PIE is not set
> >> CONFIG_NET_SCH_INGRESS=3Dm
> >> CONFIG_NET_SCH_PLUG=3Dm
> >> # CONFIG_NET_SCH_ETS is not set
> >> CONFIG_NET_SCH_DEFAULT=3Dy
> >> # CONFIG_DEFAULT_FQ is not set
> >> # CONFIG_DEFAULT_CODEL is not set
> >> CONFIG_DEFAULT_FQ_CODEL=3Dy
> >> # CONFIG_DEFAULT_SFQ is not set
> >> # CONFIG_DEFAULT_PFIFO_FAST is not set
> >> CONFIG_DEFAULT_NET_SCH=3D"fq_codel"
> >>
> >> #
> >> # Classification
> >> #
> >> CONFIG_NET_CLS=3Dy
> >> CONFIG_NET_CLS_BASIC=3Dm
> >> CONFIG_NET_CLS_TCINDEX=3Dm
> >> CONFIG_NET_CLS_ROUTE4=3Dm
> >> CONFIG_NET_CLS_FW=3Dm
> >> CONFIG_NET_CLS_U32=3Dm
> >> CONFIG_CLS_U32_PERF=3Dy
> >> CONFIG_CLS_U32_MARK=3Dy
> >> CONFIG_NET_CLS_RSVP=3Dm
> >> CONFIG_NET_CLS_RSVP6=3Dm
> >> CONFIG_NET_CLS_FLOW=3Dm
> >> CONFIG_NET_CLS_CGROUP=3Dy
> >> CONFIG_NET_CLS_BPF=3Dm
> >> CONFIG_NET_CLS_FLOWER=3Dm
> >> CONFIG_NET_CLS_MATCHALL=3Dm
> >> CONFIG_NET_EMATCH=3Dy
> >> CONFIG_NET_EMATCH_STACK=3D32
> >> CONFIG_NET_EMATCH_CMP=3Dm
> >> CONFIG_NET_EMATCH_NBYTE=3Dm
> >> CONFIG_NET_EMATCH_U32=3Dm
> >> CONFIG_NET_EMATCH_META=3Dm
> >> CONFIG_NET_EMATCH_TEXT=3Dm
> >> # CONFIG_NET_EMATCH_CANID is not set
> >> CONFIG_NET_EMATCH_IPSET=3Dm
> >> # CONFIG_NET_EMATCH_IPT is not set
> >> CONFIG_NET_CLS_ACT=3Dy
> >> CONFIG_NET_ACT_POLICE=3Dm
> >> CONFIG_NET_ACT_GACT=3Dm
> >> CONFIG_GACT_PROB=3Dy
> >> CONFIG_NET_ACT_MIRRED=3Dm
> >> CONFIG_NET_ACT_SAMPLE=3Dm
> >> # CONFIG_NET_ACT_IPT is not set
> >> CONFIG_NET_ACT_NAT=3Dm
> >> CONFIG_NET_ACT_PEDIT=3Dm
> >> CONFIG_NET_ACT_SIMP=3Dm
> >> CONFIG_NET_ACT_SKBEDIT=3Dm
> >> CONFIG_NET_ACT_CSUM=3Dm
> >> # CONFIG_NET_ACT_MPLS is not set
> >> CONFIG_NET_ACT_VLAN=3Dm
> >> CONFIG_NET_ACT_BPF=3Dm
> >> # CONFIG_NET_ACT_CONNMARK is not set
> >> # CONFIG_NET_ACT_CTINFO is not set
> >> CONFIG_NET_ACT_SKBMOD=3Dm
> >> # CONFIG_NET_ACT_IFE is not set
> >> CONFIG_NET_ACT_TUNNEL_KEY=3Dm
> >> # CONFIG_NET_ACT_GATE is not set
> >> # CONFIG_NET_TC_SKB_EXT is not set
> >> CONFIG_NET_SCH_FIFO=3Dy
> >> CONFIG_DCB=3Dy
> >> CONFIG_DNS_RESOLVER=3Dm
> >> # CONFIG_BATMAN_ADV is not set
> >> CONFIG_OPENVSWITCH=3Dm
> >> CONFIG_OPENVSWITCH_GRE=3Dm
> >> CONFIG_VSOCKETS=3Dm
> >> CONFIG_VSOCKETS_DIAG=3Dm
> >> CONFIG_VSOCKETS_LOOPBACK=3Dm
> >> CONFIG_VMWARE_VMCI_VSOCKETS=3Dm
> >> CONFIG_VIRTIO_VSOCKETS=3Dm
> >> CONFIG_VIRTIO_VSOCKETS_COMMON=3Dm
> >> CONFIG_HYPERV_VSOCKETS=3Dm
> >> CONFIG_NETLINK_DIAG=3Dm
> >> CONFIG_MPLS=3Dy
> >> CONFIG_NET_MPLS_GSO=3Dy
> >> CONFIG_MPLS_ROUTING=3Dm
> >> CONFIG_MPLS_IPTUNNEL=3Dm
> >> CONFIG_NET_NSH=3Dy
> >> # CONFIG_HSR is not set
> >> CONFIG_NET_SWITCHDEV=3Dy
> >> CONFIG_NET_L3_MASTER_DEV=3Dy
> >> # CONFIG_QRTR is not set
> >> # CONFIG_NET_NCSI is not set
> >> CONFIG_RPS=3Dy
> >> CONFIG_RFS_ACCEL=3Dy
> >> CONFIG_XPS=3Dy
> >> CONFIG_CGROUP_NET_PRIO=3Dy
> >> CONFIG_CGROUP_NET_CLASSID=3Dy
> >> CONFIG_NET_RX_BUSY_POLL=3Dy
> >> CONFIG_BQL=3Dy
> >> CONFIG_BPF_JIT=3Dy
> >> CONFIG_BPF_STREAM_PARSER=3Dy
> >> CONFIG_NET_FLOW_LIMIT=3Dy
> >>
> >> #
> >> # Network testing
> >> #
> >> CONFIG_NET_PKTGEN=3Dm
> >> CONFIG_NET_DROP_MONITOR=3Dy
> >> # end of Network testing
> >> # end of Networking options
> >>
> >> # CONFIG_HAMRADIO is not set
> >> CONFIG_CAN=3Dm
> >> CONFIG_CAN_RAW=3Dm
> >> CONFIG_CAN_BCM=3Dm
> >> CONFIG_CAN_GW=3Dm
> >> # CONFIG_CAN_J1939 is not set
> >>
> >> #
> >> # CAN Device Drivers
> >> #
> >> CONFIG_CAN_VCAN=3Dm
> >> # CONFIG_CAN_VXCAN is not set
> >> CONFIG_CAN_SLCAN=3Dm
> >> CONFIG_CAN_DEV=3Dm
> >> CONFIG_CAN_CALC_BITTIMING=3Dy
> >> # CONFIG_CAN_KVASER_PCIEFD is not set
> >> CONFIG_CAN_C_CAN=3Dm
> >> CONFIG_CAN_C_CAN_PLATFORM=3Dm
> >> CONFIG_CAN_C_CAN_PCI=3Dm
> >> CONFIG_CAN_CC770=3Dm
> >> # CONFIG_CAN_CC770_ISA is not set
> >> CONFIG_CAN_CC770_PLATFORM=3Dm
> >> # CONFIG_CAN_IFI_CANFD is not set
> >> # CONFIG_CAN_M_CAN is not set
> >> # CONFIG_CAN_PEAK_PCIEFD is not set
> >> CONFIG_CAN_SJA1000=3Dm
> >> CONFIG_CAN_EMS_PCI=3Dm
> >> # CONFIG_CAN_F81601 is not set
> >> CONFIG_CAN_KVASER_PCI=3Dm
> >> CONFIG_CAN_PEAK_PCI=3Dm
> >> CONFIG_CAN_PEAK_PCIEC=3Dy
> >> CONFIG_CAN_PLX_PCI=3Dm
> >> # CONFIG_CAN_SJA1000_ISA is not set
> >> CONFIG_CAN_SJA1000_PLATFORM=3Dm
> >> CONFIG_CAN_SOFTING=3Dm
> >>
> >> #
> >> # CAN SPI interfaces
> >> #
> >> # CONFIG_CAN_HI311X is not set
> >> # CONFIG_CAN_MCP251X is not set
> >> # end of CAN SPI interfaces
> >>
> >> #
> >> # CAN USB interfaces
> >> #
> >> # CONFIG_CAN_8DEV_USB is not set
> >> # CONFIG_CAN_EMS_USB is not set
> >> # CONFIG_CAN_ESD_USB2 is not set
> >> # CONFIG_CAN_GS_USB is not set
> >> # CONFIG_CAN_KVASER_USB is not set
> >> # CONFIG_CAN_MCBA_USB is not set
> >> # CONFIG_CAN_PEAK_USB is not set
> >> # CONFIG_CAN_UCAN is not set
> >> # end of CAN USB interfaces
> >>
> >> # CONFIG_CAN_DEBUG_DEVICES is not set
> >> # end of CAN Device Drivers
> >>
> >> CONFIG_BT=3Dm
> >> CONFIG_BT_BREDR=3Dy
> >> CONFIG_BT_RFCOMM=3Dm
> >> CONFIG_BT_RFCOMM_TTY=3Dy
> >> CONFIG_BT_BNEP=3Dm
> >> CONFIG_BT_BNEP_MC_FILTER=3Dy
> >> CONFIG_BT_BNEP_PROTO_FILTER=3Dy
> >> CONFIG_BT_HIDP=3Dm
> >> CONFIG_BT_HS=3Dy
> >> CONFIG_BT_LE=3Dy
> >> # CONFIG_BT_6LOWPAN is not set
> >> # CONFIG_BT_LEDS is not set
> >> # CONFIG_BT_MSFTEXT is not set
> >> CONFIG_BT_DEBUGFS=3Dy
> >> # CONFIG_BT_SELFTEST is not set
> >>
> >> #
> >> # Bluetooth device drivers
> >> #
> >> # CONFIG_BT_HCIBTUSB is not set
> >> # CONFIG_BT_HCIBTSDIO is not set
> >> CONFIG_BT_HCIUART=3Dm
> >> CONFIG_BT_HCIUART_H4=3Dy
> >> CONFIG_BT_HCIUART_BCSP=3Dy
> >> CONFIG_BT_HCIUART_ATH3K=3Dy
> >> # CONFIG_BT_HCIUART_INTEL is not set
> >> # CONFIG_BT_HCIUART_AG6XX is not set
> >> # CONFIG_BT_HCIBCM203X is not set
> >> # CONFIG_BT_HCIBPA10X is not set
> >> # CONFIG_BT_HCIBFUSB is not set
> >> CONFIG_BT_HCIVHCI=3Dm
> >> CONFIG_BT_MRVL=3Dm
> >> # CONFIG_BT_MRVL_SDIO is not set
> >> # CONFIG_BT_MTKSDIO is not set
> >> # end of Bluetooth device drivers
> >>
> >> # CONFIG_AF_RXRPC is not set
> >> # CONFIG_AF_KCM is not set
> >> CONFIG_STREAM_PARSER=3Dy
> >> CONFIG_FIB_RULES=3Dy
> >> CONFIG_WIRELESS=3Dy
> >> CONFIG_WEXT_CORE=3Dy
> >> CONFIG_WEXT_PROC=3Dy
> >> CONFIG_CFG80211=3Dm
> >> # CONFIG_NL80211_TESTMODE is not set
> >> # CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
> >> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=3Dy
> >> CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=3Dy
> >> CONFIG_CFG80211_DEFAULT_PS=3Dy
> >> # CONFIG_CFG80211_DEBUGFS is not set
> >> CONFIG_CFG80211_CRDA_SUPPORT=3Dy
> >> CONFIG_CFG80211_WEXT=3Dy
> >> CONFIG_MAC80211=3Dm
> >> CONFIG_MAC80211_HAS_RC=3Dy
> >> CONFIG_MAC80211_RC_MINSTREL=3Dy
> >> CONFIG_MAC80211_RC_DEFAULT_MINSTREL=3Dy
> >> CONFIG_MAC80211_RC_DEFAULT=3D"minstrel_ht"
> >> CONFIG_MAC80211_MESH=3Dy
> >> CONFIG_MAC80211_LEDS=3Dy
> >> CONFIG_MAC80211_DEBUGFS=3Dy
> >> # CONFIG_MAC80211_MESSAGE_TRACING is not set
> >> # CONFIG_MAC80211_DEBUG_MENU is not set
> >> CONFIG_MAC80211_STA_HASH_MAX_SIZE=3D0
> >> # CONFIG_WIMAX is not set
> >> CONFIG_RFKILL=3Dm
> >> CONFIG_RFKILL_LEDS=3Dy
> >> CONFIG_RFKILL_INPUT=3Dy
> >> # CONFIG_RFKILL_GPIO is not set
> >> CONFIG_NET_9P=3Dy
> >> CONFIG_NET_9P_VIRTIO=3Dy
> >> # CONFIG_NET_9P_XEN is not set
> >> # CONFIG_NET_9P_RDMA is not set
> >> # CONFIG_NET_9P_DEBUG is not set
> >> # CONFIG_CAIF is not set
> >> CONFIG_CEPH_LIB=3Dm
> >> # CONFIG_CEPH_LIB_PRETTYDEBUG is not set
> >> CONFIG_CEPH_LIB_USE_DNS_RESOLVER=3Dy
> >> # CONFIG_NFC is not set
> >> CONFIG_PSAMPLE=3Dm
> >> # CONFIG_NET_IFE is not set
> >> CONFIG_LWTUNNEL=3Dy
> >> CONFIG_LWTUNNEL_BPF=3Dy
> >> CONFIG_DST_CACHE=3Dy
> >> CONFIG_GRO_CELLS=3Dy
> >> CONFIG_SOCK_VALIDATE_XMIT=3Dy
> >> CONFIG_NET_SOCK_MSG=3Dy
> >> CONFIG_NET_DEVLINK=3Dy
> >> CONFIG_FAILOVER=3Dm
> >> CONFIG_ETHTOOL_NETLINK=3Dy
> >> CONFIG_HAVE_EBPF_JIT=3Dy
> >>
> >> #
> >> # Device Drivers
> >> #
> >> CONFIG_HAVE_EISA=3Dy
> >> # CONFIG_EISA is not set
> >> CONFIG_HAVE_PCI=3Dy
> >> CONFIG_PCI=3Dy
> >> CONFIG_PCI_DOMAINS=3Dy
> >> CONFIG_PCIEPORTBUS=3Dy
> >> CONFIG_HOTPLUG_PCI_PCIE=3Dy
> >> CONFIG_PCIEAER=3Dy
> >> CONFIG_PCIEAER_INJECT=3Dm
> >> CONFIG_PCIE_ECRC=3Dy
> >> CONFIG_PCIEASPM=3Dy
> >> CONFIG_PCIEASPM_DEFAULT=3Dy
> >> # CONFIG_PCIEASPM_POWERSAVE is not set
> >> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> >> # CONFIG_PCIEASPM_PERFORMANCE is not set
> >> CONFIG_PCIE_PME=3Dy
> >> CONFIG_PCIE_DPC=3Dy
> >> # CONFIG_PCIE_PTM is not set
> >> # CONFIG_PCIE_BW is not set
> >> # CONFIG_PCIE_EDR is not set
> >> CONFIG_PCI_MSI=3Dy
> >> CONFIG_PCI_MSI_IRQ_DOMAIN=3Dy
> >> CONFIG_PCI_QUIRKS=3Dy
> >> # CONFIG_PCI_DEBUG is not set
> >> # CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
> >> CONFIG_PCI_STUB=3Dy
> >> CONFIG_PCI_PF_STUB=3Dm
> >> # CONFIG_XEN_PCIDEV_FRONTEND is not set
> >> CONFIG_PCI_ATS=3Dy
> >> CONFIG_PCI_LOCKLESS_CONFIG=3Dy
> >> CONFIG_PCI_IOV=3Dy
> >> CONFIG_PCI_PRI=3Dy
> >> CONFIG_PCI_PASID=3Dy
> >> # CONFIG_PCI_P2PDMA is not set
> >> CONFIG_PCI_LABEL=3Dy
> >> CONFIG_PCI_HYPERV=3Dm
> >> CONFIG_HOTPLUG_PCI=3Dy
> >> CONFIG_HOTPLUG_PCI_ACPI=3Dy
> >> CONFIG_HOTPLUG_PCI_ACPI_IBM=3Dm
> >> # CONFIG_HOTPLUG_PCI_CPCI is not set
> >> CONFIG_HOTPLUG_PCI_SHPC=3Dy
> >>
> >> #
> >> # PCI controller drivers
> >> #
> >> CONFIG_VMD=3Dy
> >> CONFIG_PCI_HYPERV_INTERFACE=3Dm
> >>
> >> #
> >> # DesignWare PCI Core Support
> >> #
> >> # CONFIG_PCIE_DW_PLAT_HOST is not set
> >> # CONFIG_PCI_MESON is not set
> >> # end of DesignWare PCI Core Support
> >>
> >> #
> >> # Mobiveil PCIe Core Support
> >> #
> >> # end of Mobiveil PCIe Core Support
> >>
> >> #
> >> # Cadence PCIe controllers support
> >> #
> >> # end of Cadence PCIe controllers support
> >> # end of PCI controller drivers
> >>
> >> #
> >> # PCI Endpoint
> >> #
> >> # CONFIG_PCI_ENDPOINT is not set
> >> # end of PCI Endpoint
> >>
> >> #
> >> # PCI switch controller drivers
> >> #
> >> # CONFIG_PCI_SW_SWITCHTEC is not set
> >> # end of PCI switch controller drivers
> >>
> >> # CONFIG_PCCARD is not set
> >> # CONFIG_RAPIDIO is not set
> >>
> >> #
> >> # Generic Driver Options
> >> #
> >> # CONFIG_UEVENT_HELPER is not set
> >> CONFIG_DEVTMPFS=3Dy
> >> CONFIG_DEVTMPFS_MOUNT=3Dy
> >> CONFIG_STANDALONE=3Dy
> >> CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
> >>
> >> #
> >> # Firmware loader
> >> #
> >> CONFIG_FW_LOADER=3Dy
> >> CONFIG_FW_LOADER_PAGED_BUF=3Dy
> >> CONFIG_EXTRA_FIRMWARE=3D""
> >> CONFIG_FW_LOADER_USER_HELPER=3Dy
> >> # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> >> # CONFIG_FW_LOADER_COMPRESS is not set
> >> CONFIG_FW_CACHE=3Dy
> >> # end of Firmware loader
> >>
> >> CONFIG_ALLOW_DEV_COREDUMP=3Dy
> >> # CONFIG_DEBUG_DRIVER is not set
> >> # CONFIG_DEBUG_DEVRES is not set
> >> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> >> # CONFIG_PM_QOS_KUNIT_TEST is not set
> >> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> >> CONFIG_KUNIT_DRIVER_PE_TEST=3Dy
> >> CONFIG_SYS_HYPERVISOR=3Dy
> >> CONFIG_GENERIC_CPU_AUTOPROBE=3Dy
> >> CONFIG_GENERIC_CPU_VULNERABILITIES=3Dy
> >> CONFIG_REGMAP=3Dy
> >> CONFIG_REGMAP_I2C=3Dm
> >> CONFIG_REGMAP_SPI=3Dm
> >> CONFIG_DMA_SHARED_BUFFER=3Dy
> >> # CONFIG_DMA_FENCE_TRACE is not set
> >> # end of Generic Driver Options
> >>
> >> #
> >> # Bus devices
> >> #
> >> # CONFIG_MHI_BUS is not set
> >> # end of Bus devices
> >>
> >> CONFIG_CONNECTOR=3Dy
> >> CONFIG_PROC_EVENTS=3Dy
> >> # CONFIG_GNSS is not set
> >> # CONFIG_MTD is not set
> >> # CONFIG_OF is not set
> >> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=3Dy
> >> CONFIG_PARPORT=3Dm
> >> CONFIG_PARPORT_PC=3Dm
> >> CONFIG_PARPORT_SERIAL=3Dm
> >> # CONFIG_PARPORT_PC_FIFO is not set
> >> # CONFIG_PARPORT_PC_SUPERIO is not set
> >> # CONFIG_PARPORT_AX88796 is not set
> >> CONFIG_PARPORT_1284=3Dy
> >> CONFIG_PNP=3Dy
> >> # CONFIG_PNP_DEBUG_MESSAGES is not set
> >>
> >> #
> >> # Protocols
> >> #
> >> CONFIG_PNPACPI=3Dy
> >> CONFIG_BLK_DEV=3Dy
> >> CONFIG_BLK_DEV_NULL_BLK=3Dm
> >> CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=3Dy
> >> # CONFIG_BLK_DEV_FD is not set
> >> CONFIG_CDROM=3Dm
> >> # CONFIG_PARIDE is not set
> >> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> >> # CONFIG_ZRAM is not set
> >> # CONFIG_BLK_DEV_UMEM is not set
> >> CONFIG_BLK_DEV_LOOP=3Dm
> >> CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D0
> >> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> >> # CONFIG_BLK_DEV_DRBD is not set
> >> CONFIG_BLK_DEV_NBD=3Dm
> >> # CONFIG_BLK_DEV_SKD is not set
> >> # CONFIG_BLK_DEV_SX8 is not set
> >> CONFIG_BLK_DEV_RAM=3Dm
> >> CONFIG_BLK_DEV_RAM_COUNT=3D16
> >> CONFIG_BLK_DEV_RAM_SIZE=3D16384
> >> CONFIG_CDROM_PKTCDVD=3Dm
> >> CONFIG_CDROM_PKTCDVD_BUFFERS=3D8
> >> # CONFIG_CDROM_PKTCDVD_WCACHE is not set
> >> # CONFIG_ATA_OVER_ETH is not set
> >> CONFIG_XEN_BLKDEV_FRONTEND=3Dm
> >> CONFIG_VIRTIO_BLK=3Dy
> >> CONFIG_BLK_DEV_RBD=3Dm
> >> # CONFIG_BLK_DEV_RSXX is not set
> >>
> >> #
> >> # NVME Support
> >> #
> >> CONFIG_NVME_CORE=3Dm
> >> CONFIG_BLK_DEV_NVME=3Dm
> >> CONFIG_NVME_MULTIPATH=3Dy
> >> # CONFIG_NVME_HWMON is not set
> >> CONFIG_NVME_FABRICS=3Dm
> >> # CONFIG_NVME_RDMA is not set
> >> CONFIG_NVME_FC=3Dm
> >> # CONFIG_NVME_TCP is not set
> >> CONFIG_NVME_TARGET=3Dm
> >> CONFIG_NVME_TARGET_LOOP=3Dm
> >> # CONFIG_NVME_TARGET_RDMA is not set
> >> CONFIG_NVME_TARGET_FC=3Dm
> >> CONFIG_NVME_TARGET_FCLOOP=3Dm
> >> # CONFIG_NVME_TARGET_TCP is not set
> >> # end of NVME Support
> >>
> >> #
> >> # Misc devices
> >> #
> >> CONFIG_SENSORS_LIS3LV02D=3Dm
> >> # CONFIG_AD525X_DPOT is not set
> >> # CONFIG_DUMMY_IRQ is not set
> >> # CONFIG_IBM_ASM is not set
> >> # CONFIG_PHANTOM is not set
> >> CONFIG_TIFM_CORE=3Dm
> >> CONFIG_TIFM_7XX1=3Dm
> >> # CONFIG_ICS932S401 is not set
> >> CONFIG_ENCLOSURE_SERVICES=3Dm
> >> CONFIG_SGI_XP=3Dm
> >> CONFIG_HP_ILO=3Dm
> >> CONFIG_SGI_GRU=3Dm
> >> # CONFIG_SGI_GRU_DEBUG is not set
> >> CONFIG_APDS9802ALS=3Dm
> >> CONFIG_ISL29003=3Dm
> >> CONFIG_ISL29020=3Dm
> >> CONFIG_SENSORS_TSL2550=3Dm
> >> CONFIG_SENSORS_BH1770=3Dm
> >> CONFIG_SENSORS_APDS990X=3Dm
> >> # CONFIG_HMC6352 is not set
> >> # CONFIG_DS1682 is not set
> >> CONFIG_VMWARE_BALLOON=3Dm
> >> # CONFIG_LATTICE_ECP3_CONFIG is not set
> >> # CONFIG_SRAM is not set
> >> # CONFIG_PCI_ENDPOINT_TEST is not set
> >> # CONFIG_XILINX_SDFEC is not set
> >> CONFIG_MISC_RTSX=3Dm
> >> CONFIG_PVPANIC=3Dy
> >> # CONFIG_C2PORT is not set
> >>
> >> #
> >> # EEPROM support
> >> #
> >> # CONFIG_EEPROM_AT24 is not set
> >> # CONFIG_EEPROM_AT25 is not set
> >> CONFIG_EEPROM_LEGACY=3Dm
> >> CONFIG_EEPROM_MAX6875=3Dm
> >> CONFIG_EEPROM_93CX6=3Dm
> >> # CONFIG_EEPROM_93XX46 is not set
> >> # CONFIG_EEPROM_IDT_89HPESX is not set
> >> # CONFIG_EEPROM_EE1004 is not set
> >> # end of EEPROM support
> >>
> >> CONFIG_CB710_CORE=3Dm
> >> # CONFIG_CB710_DEBUG is not set
> >> CONFIG_CB710_DEBUG_ASSUMPTIONS=3Dy
> >>
> >> #
> >> # Texas Instruments shared transport line discipline
> >> #
> >> # CONFIG_TI_ST is not set
> >> # end of Texas Instruments shared transport line discipline
> >>
> >> CONFIG_SENSORS_LIS3_I2C=3Dm
> >> CONFIG_ALTERA_STAPL=3Dm
> >> CONFIG_INTEL_MEI=3Dm
> >> CONFIG_INTEL_MEI_ME=3Dm
> >> # CONFIG_INTEL_MEI_TXE is not set
> >> # CONFIG_INTEL_MEI_HDCP is not set
> >> CONFIG_VMWARE_VMCI=3Dm
> >>
> >> #
> >> # Intel MIC & related support
> >> #
> >> # CONFIG_INTEL_MIC_BUS is not set
> >> # CONFIG_SCIF_BUS is not set
> >> # CONFIG_VOP_BUS is not set
> >> # end of Intel MIC & related support
> >>
> >> # CONFIG_GENWQE is not set
> >> # CONFIG_ECHO is not set
> >> # CONFIG_MISC_ALCOR_PCI is not set
> >> CONFIG_MISC_RTSX_PCI=3Dm
> >> # CONFIG_MISC_RTSX_USB is not set
> >> # CONFIG_HABANA_AI is not set
> >> # CONFIG_UACCE is not set
> >> # end of Misc devices
> >>
> >> CONFIG_HAVE_IDE=3Dy
> >> # CONFIG_IDE is not set
> >>
> >> #
> >> # SCSI device support
> >> #
> >> CONFIG_SCSI_MOD=3Dy
> >> CONFIG_RAID_ATTRS=3Dm
> >> CONFIG_SCSI=3Dy
> >> CONFIG_SCSI_DMA=3Dy
> >> CONFIG_SCSI_NETLINK=3Dy
> >> CONFIG_SCSI_PROC_FS=3Dy
> >>
> >> #
> >> # SCSI support type (disk, tape, CD-ROM)
> >> #
> >> CONFIG_BLK_DEV_SD=3Dm
> >> CONFIG_CHR_DEV_ST=3Dm
> >> CONFIG_BLK_DEV_SR=3Dm
> >> CONFIG_CHR_DEV_SG=3Dm
> >> CONFIG_CHR_DEV_SCH=3Dm
> >> CONFIG_SCSI_ENCLOSURE=3Dm
> >> CONFIG_SCSI_CONSTANTS=3Dy
> >> CONFIG_SCSI_LOGGING=3Dy
> >> CONFIG_SCSI_SCAN_ASYNC=3Dy
> >>
> >> #
> >> # SCSI Transports
> >> #
> >> CONFIG_SCSI_SPI_ATTRS=3Dm
> >> CONFIG_SCSI_FC_ATTRS=3Dm
> >> CONFIG_SCSI_ISCSI_ATTRS=3Dm
> >> CONFIG_SCSI_SAS_ATTRS=3Dm
> >> CONFIG_SCSI_SAS_LIBSAS=3Dm
> >> # CONFIG_SCSI_SAS_ATA is not set
> >> CONFIG_SCSI_SAS_HOST_SMP=3Dy
> >> CONFIG_SCSI_SRP_ATTRS=3Dm
> >> # end of SCSI Transports
> >>
> >> CONFIG_SCSI_LOWLEVEL=3Dy
> >> # CONFIG_ISCSI_TCP is not set
> >> # CONFIG_ISCSI_BOOT_SYSFS is not set
> >> # CONFIG_SCSI_CXGB3_ISCSI is not set
> >> # CONFIG_SCSI_CXGB4_ISCSI is not set
> >> # CONFIG_SCSI_BNX2_ISCSI is not set
> >> # CONFIG_BE2ISCSI is not set
> >> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> >> # CONFIG_SCSI_HPSA is not set
> >> # CONFIG_SCSI_3W_9XXX is not set
> >> # CONFIG_SCSI_3W_SAS is not set
> >> # CONFIG_SCSI_ACARD is not set
> >> # CONFIG_SCSI_AACRAID is not set
> >> # CONFIG_SCSI_AIC7XXX is not set
> >> # CONFIG_SCSI_AIC79XX is not set
> >> # CONFIG_SCSI_AIC94XX is not set
> >> # CONFIG_SCSI_MVSAS is not set
> >> # CONFIG_SCSI_MVUMI is not set
> >> # CONFIG_SCSI_DPT_I2O is not set
> >> # CONFIG_SCSI_ADVANSYS is not set
> >> # CONFIG_SCSI_ARCMSR is not set
> >> # CONFIG_SCSI_ESAS2R is not set
> >> # CONFIG_MEGARAID_NEWGEN is not set
> >> # CONFIG_MEGARAID_LEGACY is not set
> >> # CONFIG_MEGARAID_SAS is not set
> >> CONFIG_SCSI_MPT3SAS=3Dm
> >> CONFIG_SCSI_MPT2SAS_MAX_SGE=3D128
> >> CONFIG_SCSI_MPT3SAS_MAX_SGE=3D128
> >> # CONFIG_SCSI_MPT2SAS is not set
> >> # CONFIG_SCSI_SMARTPQI is not set
> >> # CONFIG_SCSI_UFSHCD is not set
> >> # CONFIG_SCSI_HPTIOP is not set
> >> # CONFIG_SCSI_BUSLOGIC is not set
> >> # CONFIG_SCSI_MYRB is not set
> >> # CONFIG_SCSI_MYRS is not set
> >> # CONFIG_VMWARE_PVSCSI is not set
> >> # CONFIG_XEN_SCSI_FRONTEND is not set
> >> CONFIG_HYPERV_STORAGE=3Dm
> >> # CONFIG_LIBFC is not set
> >> # CONFIG_SCSI_SNIC is not set
> >> # CONFIG_SCSI_DMX3191D is not set
> >> # CONFIG_SCSI_FDOMAIN_PCI is not set
> >> # CONFIG_SCSI_GDTH is not set
> >> # CONFIG_SCSI_ISCI is not set
> >> # CONFIG_SCSI_IPS is not set
> >> # CONFIG_SCSI_INITIO is not set
> >> # CONFIG_SCSI_INIA100 is not set
> >> # CONFIG_SCSI_PPA is not set
> >> # CONFIG_SCSI_IMM is not set
> >> # CONFIG_SCSI_STEX is not set
> >> # CONFIG_SCSI_SYM53C8XX_2 is not set
> >> # CONFIG_SCSI_IPR is not set
> >> # CONFIG_SCSI_QLOGIC_1280 is not set
> >> # CONFIG_SCSI_QLA_FC is not set
> >> # CONFIG_SCSI_QLA_ISCSI is not set
> >> # CONFIG_SCSI_LPFC is not set
> >> # CONFIG_SCSI_DC395x is not set
> >> # CONFIG_SCSI_AM53C974 is not set
> >> # CONFIG_SCSI_WD719X is not set
> >> CONFIG_SCSI_DEBUG=3Dm
> >> # CONFIG_SCSI_PMCRAID is not set
> >> # CONFIG_SCSI_PM8001 is not set
> >> # CONFIG_SCSI_BFA_FC is not set
> >> # CONFIG_SCSI_VIRTIO is not set
> >> # CONFIG_SCSI_CHELSIO_FCOE is not set
> >> CONFIG_SCSI_DH=3Dy
> >> CONFIG_SCSI_DH_RDAC=3Dy
> >> CONFIG_SCSI_DH_HP_SW=3Dy
> >> CONFIG_SCSI_DH_EMC=3Dy
> >> CONFIG_SCSI_DH_ALUA=3Dy
> >> # end of SCSI device support
> >>
> >> CONFIG_ATA=3Dm
> >> CONFIG_SATA_HOST=3Dy
> >> CONFIG_PATA_TIMINGS=3Dy
> >> CONFIG_ATA_VERBOSE_ERROR=3Dy
> >> CONFIG_ATA_FORCE=3Dy
> >> CONFIG_ATA_ACPI=3Dy
> >> # CONFIG_SATA_ZPODD is not set
> >> CONFIG_SATA_PMP=3Dy
> >>
> >> #
> >> # Controllers with non-SFF native interface
> >> #
> >> CONFIG_SATA_AHCI=3Dm
> >> CONFIG_SATA_MOBILE_LPM_POLICY=3D0
> >> CONFIG_SATA_AHCI_PLATFORM=3Dm
> >> # CONFIG_SATA_INIC162X is not set
> >> # CONFIG_SATA_ACARD_AHCI is not set
> >> # CONFIG_SATA_SIL24 is not set
> >> CONFIG_ATA_SFF=3Dy
> >>
> >> #
> >> # SFF controllers with custom DMA interface
> >> #
> >> # CONFIG_PDC_ADMA is not set
> >> # CONFIG_SATA_QSTOR is not set
> >> # CONFIG_SATA_SX4 is not set
> >> CONFIG_ATA_BMDMA=3Dy
> >>
> >> #
> >> # SATA SFF controllers with BMDMA
> >> #
> >> CONFIG_ATA_PIIX=3Dm
> >> # CONFIG_SATA_DWC is not set
> >> # CONFIG_SATA_MV is not set
> >> # CONFIG_SATA_NV is not set
> >> # CONFIG_SATA_PROMISE is not set
> >> # CONFIG_SATA_SIL is not set
> >> # CONFIG_SATA_SIS is not set
> >> # CONFIG_SATA_SVW is not set
> >> # CONFIG_SATA_ULI is not set
> >> # CONFIG_SATA_VIA is not set
> >> # CONFIG_SATA_VITESSE is not set
> >>
> >> #
> >> # PATA SFF controllers with BMDMA
> >> #
> >> # CONFIG_PATA_ALI is not set
> >> # CONFIG_PATA_AMD is not set
> >> # CONFIG_PATA_ARTOP is not set
> >> # CONFIG_PATA_ATIIXP is not set
> >> # CONFIG_PATA_ATP867X is not set
> >> # CONFIG_PATA_CMD64X is not set
> >> # CONFIG_PATA_CYPRESS is not set
> >> # CONFIG_PATA_EFAR is not set
> >> # CONFIG_PATA_HPT366 is not set
> >> # CONFIG_PATA_HPT37X is not set
> >> # CONFIG_PATA_HPT3X2N is not set
> >> # CONFIG_PATA_HPT3X3 is not set
> >> # CONFIG_PATA_IT8213 is not set
> >> # CONFIG_PATA_IT821X is not set
> >> # CONFIG_PATA_JMICRON is not set
> >> # CONFIG_PATA_MARVELL is not set
> >> # CONFIG_PATA_NETCELL is not set
> >> # CONFIG_PATA_NINJA32 is not set
> >> # CONFIG_PATA_NS87415 is not set
> >> # CONFIG_PATA_OLDPIIX is not set
> >> # CONFIG_PATA_OPTIDMA is not set
> >> # CONFIG_PATA_PDC2027X is not set
> >> # CONFIG_PATA_PDC_OLD is not set
> >> # CONFIG_PATA_RADISYS is not set
> >> # CONFIG_PATA_RDC is not set
> >> # CONFIG_PATA_SCH is not set
> >> # CONFIG_PATA_SERVERWORKS is not set
> >> # CONFIG_PATA_SIL680 is not set
> >> # CONFIG_PATA_SIS is not set
> >> # CONFIG_PATA_TOSHIBA is not set
> >> # CONFIG_PATA_TRIFLEX is not set
> >> # CONFIG_PATA_VIA is not set
> >> # CONFIG_PATA_WINBOND is not set
> >>
> >> #
> >> # PIO-only SFF controllers
> >> #
> >> # CONFIG_PATA_CMD640_PCI is not set
> >> # CONFIG_PATA_MPIIX is not set
> >> # CONFIG_PATA_NS87410 is not set
> >> # CONFIG_PATA_OPTI is not set
> >> # CONFIG_PATA_RZ1000 is not set
> >>
> >> #
> >> # Generic fallback / legacy drivers
> >> #
> >> # CONFIG_PATA_ACPI is not set
> >> CONFIG_ATA_GENERIC=3Dm
> >> # CONFIG_PATA_LEGACY is not set
> >> CONFIG_MD=3Dy
> >> CONFIG_BLK_DEV_MD=3Dy
> >> CONFIG_MD_AUTODETECT=3Dy
> >> CONFIG_MD_LINEAR=3Dm
> >> CONFIG_MD_RAID0=3Dm
> >> CONFIG_MD_RAID1=3Dm
> >> CONFIG_MD_RAID10=3Dm
> >> CONFIG_MD_RAID456=3Dm
> >> CONFIG_MD_MULTIPATH=3Dm
> >> CONFIG_MD_FAULTY=3Dm
> >> CONFIG_MD_CLUSTER=3Dm
> >> # CONFIG_BCACHE is not set
> >> CONFIG_BLK_DEV_DM_BUILTIN=3Dy
> >> CONFIG_BLK_DEV_DM=3Dm
> >> CONFIG_DM_DEBUG=3Dy
> >> CONFIG_DM_BUFIO=3Dm
> >> # CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
> >> CONFIG_DM_BIO_PRISON=3Dm
> >> CONFIG_DM_PERSISTENT_DATA=3Dm
> >> # CONFIG_DM_UNSTRIPED is not set
> >> CONFIG_DM_CRYPT=3Dm
> >> CONFIG_DM_SNAPSHOT=3Dm
> >> CONFIG_DM_THIN_PROVISIONING=3Dm
> >> CONFIG_DM_CACHE=3Dm
> >> CONFIG_DM_CACHE_SMQ=3Dm
> >> CONFIG_DM_WRITECACHE=3Dm
> >> # CONFIG_DM_EBS is not set
> >> CONFIG_DM_ERA=3Dm
> >> # CONFIG_DM_CLONE is not set
> >> CONFIG_DM_MIRROR=3Dm
> >> CONFIG_DM_LOG_USERSPACE=3Dm
> >> CONFIG_DM_RAID=3Dm
> >> CONFIG_DM_ZERO=3Dm
> >> CONFIG_DM_MULTIPATH=3Dm
> >> CONFIG_DM_MULTIPATH_QL=3Dm
> >> CONFIG_DM_MULTIPATH_ST=3Dm
> >> # CONFIG_DM_MULTIPATH_HST is not set
> >> CONFIG_DM_DELAY=3Dm
> >> # CONFIG_DM_DUST is not set
> >> CONFIG_DM_UEVENT=3Dy
> >> CONFIG_DM_FLAKEY=3Dm
> >> CONFIG_DM_VERITY=3Dm
> >> # CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
> >> # CONFIG_DM_VERITY_FEC is not set
> >> CONFIG_DM_SWITCH=3Dm
> >> CONFIG_DM_LOG_WRITES=3Dm
> >> CONFIG_DM_INTEGRITY=3Dm
> >> # CONFIG_DM_ZONED is not set
> >> CONFIG_TARGET_CORE=3Dm
> >> CONFIG_TCM_IBLOCK=3Dm
> >> CONFIG_TCM_FILEIO=3Dm
> >> CONFIG_TCM_PSCSI=3Dm
> >> CONFIG_TCM_USER2=3Dm
> >> CONFIG_LOOPBACK_TARGET=3Dm
> >> CONFIG_ISCSI_TARGET=3Dm
> >> # CONFIG_SBP_TARGET is not set
> >> # CONFIG_FUSION is not set
> >>
> >> #
> >> # IEEE 1394 (FireWire) support
> >> #
> >> CONFIG_FIREWIRE=3Dm
> >> CONFIG_FIREWIRE_OHCI=3Dm
> >> CONFIG_FIREWIRE_SBP2=3Dm
> >> CONFIG_FIREWIRE_NET=3Dm
> >> # CONFIG_FIREWIRE_NOSY is not set
> >> # end of IEEE 1394 (FireWire) support
> >>
> >> CONFIG_MACINTOSH_DRIVERS=3Dy
> >> CONFIG_MAC_EMUMOUSEBTN=3Dy
> >> CONFIG_NETDEVICES=3Dy
> >> CONFIG_MII=3Dy
> >> CONFIG_NET_CORE=3Dy
> >> # CONFIG_BONDING is not set
> >> # CONFIG_DUMMY is not set
> >> # CONFIG_WIREGUARD is not set
> >> # CONFIG_EQUALIZER is not set
> >> # CONFIG_NET_FC is not set
> >> # CONFIG_IFB is not set
> >> # CONFIG_NET_TEAM is not set
> >> # CONFIG_MACVLAN is not set
> >> # CONFIG_IPVLAN is not set
> >> # CONFIG_VXLAN is not set
> >> # CONFIG_GENEVE is not set
> >> # CONFIG_BAREUDP is not set
> >> # CONFIG_GTP is not set
> >> # CONFIG_MACSEC is not set
> >> # CONFIG_NETCONSOLE is not set
> >> # CONFIG_TUN is not set
> >> # CONFIG_TUN_VNET_CROSS_LE is not set
> >> # CONFIG_VETH is not set
> >> CONFIG_VIRTIO_NET=3Dm
> >> # CONFIG_NLMON is not set
> >> # CONFIG_NET_VRF is not set
> >> # CONFIG_VSOCKMON is not set
> >> # CONFIG_ARCNET is not set
> >> CONFIG_ATM_DRIVERS=3Dy
> >> # CONFIG_ATM_DUMMY is not set
> >> # CONFIG_ATM_TCP is not set
> >> # CONFIG_ATM_LANAI is not set
> >> # CONFIG_ATM_ENI is not set
> >> # CONFIG_ATM_FIRESTREAM is not set
> >> # CONFIG_ATM_ZATM is not set
> >> # CONFIG_ATM_NICSTAR is not set
> >> # CONFIG_ATM_IDT77252 is not set
> >> # CONFIG_ATM_AMBASSADOR is not set
> >> # CONFIG_ATM_HORIZON is not set
> >> # CONFIG_ATM_IA is not set
> >> # CONFIG_ATM_FORE200E is not set
> >> # CONFIG_ATM_HE is not set
> >> # CONFIG_ATM_SOLOS is not set
> >>
> >> #
> >> # Distributed Switch Architecture drivers
> >> #
> >> # end of Distributed Switch Architecture drivers
> >>
> >> CONFIG_ETHERNET=3Dy
> >> CONFIG_MDIO=3Dy
> >> CONFIG_NET_VENDOR_3COM=3Dy
> >> # CONFIG_VORTEX is not set
> >> # CONFIG_TYPHOON is not set
> >> CONFIG_NET_VENDOR_ADAPTEC=3Dy
> >> # CONFIG_ADAPTEC_STARFIRE is not set
> >> CONFIG_NET_VENDOR_AGERE=3Dy
> >> # CONFIG_ET131X is not set
> >> CONFIG_NET_VENDOR_ALACRITECH=3Dy
> >> # CONFIG_SLICOSS is not set
> >> CONFIG_NET_VENDOR_ALTEON=3Dy
> >> # CONFIG_ACENIC is not set
> >> # CONFIG_ALTERA_TSE is not set
> >> CONFIG_NET_VENDOR_AMAZON=3Dy
> >> # CONFIG_ENA_ETHERNET is not set
> >> CONFIG_NET_VENDOR_AMD=3Dy
> >> # CONFIG_AMD8111_ETH is not set
> >> # CONFIG_PCNET32 is not set
> >> # CONFIG_AMD_XGBE is not set
> >> CONFIG_NET_VENDOR_AQUANTIA=3Dy
> >> # CONFIG_AQTION is not set
> >> CONFIG_NET_VENDOR_ARC=3Dy
> >> CONFIG_NET_VENDOR_ATHEROS=3Dy
> >> # CONFIG_ATL2 is not set
> >> # CONFIG_ATL1 is not set
> >> # CONFIG_ATL1E is not set
> >> # CONFIG_ATL1C is not set
> >> # CONFIG_ALX is not set
> >> # CONFIG_NET_VENDOR_AURORA is not set
> >> CONFIG_NET_VENDOR_BROADCOM=3Dy
> >> # CONFIG_B44 is not set
> >> # CONFIG_BCMGENET is not set
> >> # CONFIG_BNX2 is not set
> >> # CONFIG_CNIC is not set
> >> CONFIG_TIGON3=3Dy
> >> CONFIG_TIGON3_HWMON=3Dy
> >> # CONFIG_BNX2X is not set
> >> # CONFIG_SYSTEMPORT is not set
> >> # CONFIG_BNXT is not set
> >> CONFIG_NET_VENDOR_BROCADE=3Dy
> >> # CONFIG_BNA is not set
> >> CONFIG_NET_VENDOR_CADENCE=3Dy
> >> # CONFIG_MACB is not set
> >> CONFIG_NET_VENDOR_CAVIUM=3Dy
> >> # CONFIG_THUNDER_NIC_PF is not set
> >> # CONFIG_THUNDER_NIC_VF is not set
> >> # CONFIG_THUNDER_NIC_BGX is not set
> >> # CONFIG_THUNDER_NIC_RGX is not set
> >> CONFIG_CAVIUM_PTP=3Dy
> >> # CONFIG_LIQUIDIO is not set
> >> # CONFIG_LIQUIDIO_VF is not set
> >> CONFIG_NET_VENDOR_CHELSIO=3Dy
> >> # CONFIG_CHELSIO_T1 is not set
> >> # CONFIG_CHELSIO_T3 is not set
> >> # CONFIG_CHELSIO_T4 is not set
> >> # CONFIG_CHELSIO_T4VF is not set
> >> CONFIG_NET_VENDOR_CISCO=3Dy
> >> # CONFIG_ENIC is not set
> >> CONFIG_NET_VENDOR_CORTINA=3Dy
> >> # CONFIG_CX_ECAT is not set
> >> # CONFIG_DNET is not set
> >> CONFIG_NET_VENDOR_DEC=3Dy
> >> # CONFIG_NET_TULIP is not set
> >> CONFIG_NET_VENDOR_DLINK=3Dy
> >> # CONFIG_DL2K is not set
> >> # CONFIG_SUNDANCE is not set
> >> CONFIG_NET_VENDOR_EMULEX=3Dy
> >> # CONFIG_BE2NET is not set
> >> CONFIG_NET_VENDOR_EZCHIP=3Dy
> >> CONFIG_NET_VENDOR_GOOGLE=3Dy
> >> # CONFIG_GVE is not set
> >> CONFIG_NET_VENDOR_HUAWEI=3Dy
> >> # CONFIG_HINIC is not set
> >> CONFIG_NET_VENDOR_I825XX=3Dy
> >> CONFIG_NET_VENDOR_INTEL=3Dy
> >> # CONFIG_E100 is not set
> >> CONFIG_E1000=3Dy
> >> CONFIG_E1000E=3Dy
> >> CONFIG_E1000E_HWTS=3Dy
> >> CONFIG_IGB=3Dy
> >> CONFIG_IGB_HWMON=3Dy
> >> # CONFIG_IGBVF is not set
> >> # CONFIG_IXGB is not set
> >> CONFIG_IXGBE=3Dy
> >> CONFIG_IXGBE_HWMON=3Dy
> >> # CONFIG_IXGBE_DCB is not set
> >> CONFIG_IXGBE_IPSEC=3Dy
> >> # CONFIG_IXGBEVF is not set
> >> CONFIG_I40E=3Dy
> >> # CONFIG_I40E_DCB is not set
> >> # CONFIG_I40EVF is not set
> >> # CONFIG_ICE is not set
> >> # CONFIG_FM10K is not set
> >> # CONFIG_IGC is not set
> >> # CONFIG_JME is not set
> >> CONFIG_NET_VENDOR_MARVELL=3Dy
> >> # CONFIG_MVMDIO is not set
> >> CONFIG_SKGE=3Dy
> >> # CONFIG_SKGE_DEBUG is not set
> >> # CONFIG_SKGE_GENESIS is not set
> >> # CONFIG_SKY2 is not set
> >> CONFIG_NET_VENDOR_MELLANOX=3Dy
> >> # CONFIG_MLX4_EN is not set
> >> # CONFIG_MLX5_CORE is not set
> >> # CONFIG_MLXSW_CORE is not set
> >> # CONFIG_MLXFW is not set
> >> CONFIG_NET_VENDOR_MICREL=3Dy
> >> # CONFIG_KS8842 is not set
> >> # CONFIG_KS8851 is not set
> >> # CONFIG_KS8851_MLL is not set
> >> # CONFIG_KSZ884X_PCI is not set
> >> CONFIG_NET_VENDOR_MICROCHIP=3Dy
> >> # CONFIG_ENC28J60 is not set
> >> # CONFIG_ENCX24J600 is not set
> >> # CONFIG_LAN743X is not set
> >> CONFIG_NET_VENDOR_MICROSEMI=3Dy
> >> # CONFIG_MSCC_OCELOT_SWITCH is not set
> >> CONFIG_NET_VENDOR_MYRI=3Dy
> >> # CONFIG_MYRI10GE is not set
> >> # CONFIG_FEALNX is not set
> >> CONFIG_NET_VENDOR_NATSEMI=3Dy
> >> # CONFIG_NATSEMI is not set
> >> # CONFIG_NS83820 is not set
> >> CONFIG_NET_VENDOR_NETERION=3Dy
> >> # CONFIG_S2IO is not set
> >> # CONFIG_VXGE is not set
> >> CONFIG_NET_VENDOR_NETRONOME=3Dy
> >> # CONFIG_NFP is not set
> >> CONFIG_NET_VENDOR_NI=3Dy
> >> # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
> >> CONFIG_NET_VENDOR_8390=3Dy
> >> # CONFIG_NE2K_PCI is not set
> >> CONFIG_NET_VENDOR_NVIDIA=3Dy
> >> # CONFIG_FORCEDETH is not set
> >> CONFIG_NET_VENDOR_OKI=3Dy
> >> # CONFIG_ETHOC is not set
> >> CONFIG_NET_VENDOR_PACKET_ENGINES=3Dy
> >> # CONFIG_HAMACHI is not set
> >> CONFIG_YELLOWFIN=3Dm
> >> CONFIG_NET_VENDOR_PENSANDO=3Dy
> >> # CONFIG_IONIC is not set
> >> CONFIG_NET_VENDOR_QLOGIC=3Dy
> >> # CONFIG_QLA3XXX is not set
> >> # CONFIG_QLCNIC is not set
> >> # CONFIG_NETXEN_NIC is not set
> >> # CONFIG_QED is not set
> >> CONFIG_NET_VENDOR_QUALCOMM=3Dy
> >> # CONFIG_QCOM_EMAC is not set
> >> # CONFIG_RMNET is not set
> >> CONFIG_NET_VENDOR_RDC=3Dy
> >> # CONFIG_R6040 is not set
> >> CONFIG_NET_VENDOR_REALTEK=3Dy
> >> # CONFIG_ATP is not set
> >> CONFIG_8139CP=3Dy
> >> CONFIG_8139TOO=3Dy
> >> CONFIG_8139TOO_PIO=3Dy
> >> # CONFIG_8139TOO_TUNE_TWISTER is not set
> >> # CONFIG_8139TOO_8129 is not set
> >> # CONFIG_8139_OLD_RX_RESET is not set
> >> CONFIG_R8169=3Dy
> >> CONFIG_NET_VENDOR_RENESAS=3Dy
> >> CONFIG_NET_VENDOR_ROCKER=3Dy
> >> # CONFIG_ROCKER is not set
> >> CONFIG_NET_VENDOR_SAMSUNG=3Dy
> >> # CONFIG_SXGBE_ETH is not set
> >> CONFIG_NET_VENDOR_SEEQ=3Dy
> >> CONFIG_NET_VENDOR_SOLARFLARE=3Dy
> >> # CONFIG_SFC is not set
> >> # CONFIG_SFC_FALCON is not set
> >> CONFIG_NET_VENDOR_SILAN=3Dy
> >> # CONFIG_SC92031 is not set
> >> CONFIG_NET_VENDOR_SIS=3Dy
> >> # CONFIG_SIS900 is not set
> >> # CONFIG_SIS190 is not set
> >> CONFIG_NET_VENDOR_SMSC=3Dy
> >> # CONFIG_EPIC100 is not set
> >> # CONFIG_SMSC911X is not set
> >> # CONFIG_SMSC9420 is not set
> >> CONFIG_NET_VENDOR_SOCIONEXT=3Dy
> >> CONFIG_NET_VENDOR_STMICRO=3Dy
> >> # CONFIG_STMMAC_ETH is not set
> >> CONFIG_NET_VENDOR_SUN=3Dy
> >> # CONFIG_HAPPYMEAL is not set
> >> # CONFIG_SUNGEM is not set
> >> # CONFIG_CASSINI is not set
> >> # CONFIG_NIU is not set
> >> CONFIG_NET_VENDOR_SYNOPSYS=3Dy
> >> # CONFIG_DWC_XLGMAC is not set
> >> CONFIG_NET_VENDOR_TEHUTI=3Dy
> >> # CONFIG_TEHUTI is not set
> >> CONFIG_NET_VENDOR_TI=3Dy
> >> # CONFIG_TI_CPSW_PHY_SEL is not set
> >> # CONFIG_TLAN is not set
> >> CONFIG_NET_VENDOR_VIA=3Dy
> >> # CONFIG_VIA_RHINE is not set
> >> # CONFIG_VIA_VELOCITY is not set
> >> CONFIG_NET_VENDOR_WIZNET=3Dy
> >> # CONFIG_WIZNET_W5100 is not set
> >> # CONFIG_WIZNET_W5300 is not set
> >> CONFIG_NET_VENDOR_XILINX=3Dy
> >> # CONFIG_XILINX_AXI_EMAC is not set
> >> # CONFIG_XILINX_LL_TEMAC is not set
> >> # CONFIG_FDDI is not set
> >> # CONFIG_HIPPI is not set
> >> # CONFIG_NET_SB1000 is not set
> >> CONFIG_MDIO_DEVICE=3Dy
> >> CONFIG_MDIO_BUS=3Dy
> >> # CONFIG_MDIO_BCM_UNIMAC is not set
> >> # CONFIG_MDIO_BITBANG is not set
> >> # CONFIG_MDIO_MSCC_MIIM is not set
> >> # CONFIG_MDIO_MVUSB is not set
> >> # CONFIG_MDIO_THUNDER is not set
> >> # CONFIG_MDIO_XPCS is not set
> >> CONFIG_PHYLIB=3Dy
> >> # CONFIG_LED_TRIGGER_PHY is not set
> >>
> >> #
> >> # MII PHY device drivers
> >> #
> >> # CONFIG_ADIN_PHY is not set
> >> # CONFIG_AMD_PHY is not set
> >> # CONFIG_AQUANTIA_PHY is not set
> >> # CONFIG_AX88796B_PHY is not set
> >> # CONFIG_BCM7XXX_PHY is not set
> >> # CONFIG_BCM87XX_PHY is not set
> >> # CONFIG_BROADCOM_PHY is not set
> >> # CONFIG_BCM54140_PHY is not set
> >> # CONFIG_BCM84881_PHY is not set
> >> # CONFIG_CICADA_PHY is not set
> >> # CONFIG_CORTINA_PHY is not set
> >> # CONFIG_DAVICOM_PHY is not set
> >> # CONFIG_DP83822_PHY is not set
> >> # CONFIG_DP83TC811_PHY is not set
> >> # CONFIG_DP83848_PHY is not set
> >> # CONFIG_DP83867_PHY is not set
> >> # CONFIG_DP83869_PHY is not set
> >> # CONFIG_FIXED_PHY is not set
> >> # CONFIG_ICPLUS_PHY is not set
> >> # CONFIG_INTEL_XWAY_PHY is not set
> >> # CONFIG_LSI_ET1011C_PHY is not set
> >> # CONFIG_LXT_PHY is not set
> >> # CONFIG_MARVELL_PHY is not set
> >> # CONFIG_MARVELL_10G_PHY is not set
> >> # CONFIG_MICREL_PHY is not set
> >> # CONFIG_MICROCHIP_PHY is not set
> >> # CONFIG_MICROCHIP_T1_PHY is not set
> >> # CONFIG_MICROSEMI_PHY is not set
> >> # CONFIG_NATIONAL_PHY is not set
> >> # CONFIG_NXP_TJA11XX_PHY is not set
> >> # CONFIG_QSEMI_PHY is not set
> >> CONFIG_REALTEK_PHY=3Dy
> >> # CONFIG_RENESAS_PHY is not set
> >> # CONFIG_ROCKCHIP_PHY is not set
> >> # CONFIG_SMSC_PHY is not set
> >> # CONFIG_STE10XP is not set
> >> # CONFIG_TERANETICS_PHY is not set
> >> # CONFIG_VITESSE_PHY is not set
> >> # CONFIG_XILINX_GMII2RGMII is not set
> >> # CONFIG_MICREL_KS8995MA is not set
> >> # CONFIG_PLIP is not set
> >> # CONFIG_PPP is not set
> >> # CONFIG_SLIP is not set
> >> CONFIG_USB_NET_DRIVERS=3Dy
> >> CONFIG_USB_CATC=3Dy
> >> CONFIG_USB_KAWETH=3Dy
> >> CONFIG_USB_PEGASUS=3Dy
> >> CONFIG_USB_RTL8150=3Dy
> >> # CONFIG_USB_RTL8152 is not set
> >> # CONFIG_USB_LAN78XX is not set
> >> CONFIG_USB_USBNET=3Dy
> >> CONFIG_USB_NET_AX8817X=3Dy
> >> CONFIG_USB_NET_AX88179_178A=3Dy
> >> CONFIG_USB_NET_CDCETHER=3Dy
> >> CONFIG_USB_NET_CDC_EEM=3Dy
> >> CONFIG_USB_NET_CDC_NCM=3Dy
> >> # CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
> >> # CONFIG_USB_NET_CDC_MBIM is not set
> >> CONFIG_USB_NET_DM9601=3Dy
> >> # CONFIG_USB_NET_SR9700 is not set
> >> # CONFIG_USB_NET_SR9800 is not set
> >> CONFIG_USB_NET_SMSC75XX=3Dy
> >> CONFIG_USB_NET_SMSC95XX=3Dy
> >> CONFIG_USB_NET_GL620A=3Dy
> >> CONFIG_USB_NET_NET1080=3Dy
> >> CONFIG_USB_NET_PLUSB=3Dy
> >> CONFIG_USB_NET_MCS7830=3Dy
> >> CONFIG_USB_NET_RNDIS_HOST=3Dy
> >> CONFIG_USB_NET_CDC_SUBSET_ENABLE=3Dy
> >> CONFIG_USB_NET_CDC_SUBSET=3Dy
> >> # CONFIG_USB_ALI_M5632 is not set
> >> # CONFIG_USB_AN2720 is not set
> >> CONFIG_USB_BELKIN=3Dy
> >> CONFIG_USB_ARMLINUX=3Dy
> >> # CONFIG_USB_EPSON2888 is not set
> >> # CONFIG_USB_KC2190 is not set
> >> CONFIG_USB_NET_ZAURUS=3Dy
> >> # CONFIG_USB_NET_CX82310_ETH is not set
> >> # CONFIG_USB_NET_KALMIA is not set
> >> # CONFIG_USB_NET_QMI_WWAN is not set
> >> # CONFIG_USB_HSO is not set
> >> CONFIG_USB_NET_INT51X1=3Dy
> >> CONFIG_USB_IPHETH=3Dy
> >> CONFIG_USB_SIERRA_NET=3Dy
> >> # CONFIG_USB_VL600 is not set
> >> # CONFIG_USB_NET_CH9200 is not set
> >> # CONFIG_USB_NET_AQC111 is not set
> >> CONFIG_WLAN=3Dy
> >> CONFIG_WLAN_VENDOR_ADMTEK=3Dy
> >> # CONFIG_ADM8211 is not set
> >> CONFIG_WLAN_VENDOR_ATH=3Dy
> >> # CONFIG_ATH_DEBUG is not set
> >> # CONFIG_ATH5K is not set
> >> # CONFIG_ATH5K_PCI is not set
> >> # CONFIG_ATH9K is not set
> >> # CONFIG_ATH9K_HTC is not set
> >> # CONFIG_CARL9170 is not set
> >> # CONFIG_ATH6KL is not set
> >> # CONFIG_AR5523 is not set
> >> # CONFIG_WIL6210 is not set
> >> # CONFIG_ATH10K is not set
> >> # CONFIG_WCN36XX is not set
> >> CONFIG_WLAN_VENDOR_ATMEL=3Dy
> >> # CONFIG_ATMEL is not set
> >> # CONFIG_AT76C50X_USB is not set
> >> CONFIG_WLAN_VENDOR_BROADCOM=3Dy
> >> # CONFIG_B43 is not set
> >> # CONFIG_B43LEGACY is not set
> >> # CONFIG_BRCMSMAC is not set
> >> # CONFIG_BRCMFMAC is not set
> >> CONFIG_WLAN_VENDOR_CISCO=3Dy
> >> # CONFIG_AIRO is not set
> >> CONFIG_WLAN_VENDOR_INTEL=3Dy
> >> # CONFIG_IPW2100 is not set
> >> # CONFIG_IPW2200 is not set
> >> # CONFIG_IWL4965 is not set
> >> # CONFIG_IWL3945 is not set
> >> # CONFIG_IWLWIFI is not set
> >> CONFIG_WLAN_VENDOR_INTERSIL=3Dy
> >> # CONFIG_HOSTAP is not set
> >> # CONFIG_HERMES is not set
> >> # CONFIG_P54_COMMON is not set
> >> # CONFIG_PRISM54 is not set
> >> CONFIG_WLAN_VENDOR_MARVELL=3Dy
> >> # CONFIG_LIBERTAS is not set
> >> # CONFIG_LIBERTAS_THINFIRM is not set
> >> # CONFIG_MWIFIEX is not set
> >> # CONFIG_MWL8K is not set
> >> CONFIG_WLAN_VENDOR_MEDIATEK=3Dy
> >> # CONFIG_MT7601U is not set
> >> # CONFIG_MT76x0U is not set
> >> # CONFIG_MT76x0E is not set
> >> # CONFIG_MT76x2E is not set
> >> # CONFIG_MT76x2U is not set
> >> # CONFIG_MT7603E is not set
> >> # CONFIG_MT7615E is not set
> >> # CONFIG_MT7663U is not set
> >> # CONFIG_MT7915E is not set
> >> CONFIG_WLAN_VENDOR_RALINK=3Dy
> >> # CONFIG_RT2X00 is not set
> >> CONFIG_WLAN_VENDOR_REALTEK=3Dy
> >> # CONFIG_RTL8180 is not set
> >> # CONFIG_RTL8187 is not set
> >> CONFIG_RTL_CARDS=3Dm
> >> # CONFIG_RTL8192CE is not set
> >> # CONFIG_RTL8192SE is not set
> >> # CONFIG_RTL8192DE is not set
> >> # CONFIG_RTL8723AE is not set
> >> # CONFIG_RTL8723BE is not set
> >> # CONFIG_RTL8188EE is not set
> >> # CONFIG_RTL8192EE is not set
> >> # CONFIG_RTL8821AE is not set
> >> # CONFIG_RTL8192CU is not set
> >> # CONFIG_RTL8XXXU is not set
> >> # CONFIG_RTW88 is not set
> >> CONFIG_WLAN_VENDOR_RSI=3Dy
> >> # CONFIG_RSI_91X is not set
> >> CONFIG_WLAN_VENDOR_ST=3Dy
> >> # CONFIG_CW1200 is not set
> >> CONFIG_WLAN_VENDOR_TI=3Dy
> >> # CONFIG_WL1251 is not set
> >> # CONFIG_WL12XX is not set
> >> # CONFIG_WL18XX is not set
> >> # CONFIG_WLCORE is not set
> >> CONFIG_WLAN_VENDOR_ZYDAS=3Dy
> >> # CONFIG_USB_ZD1201 is not set
> >> # CONFIG_ZD1211RW is not set
> >> CONFIG_WLAN_VENDOR_QUANTENNA=3Dy
> >> # CONFIG_QTNFMAC_PCIE is not set
> >> CONFIG_MAC80211_HWSIM=3Dm
> >> # CONFIG_USB_NET_RNDIS_WLAN is not set
> >> # CONFIG_VIRT_WIFI is not set
> >>
> >> #
> >> # Enable WiMAX (Networking options) to see the WiMAX drivers
> >> #
> >> # CONFIG_WAN is not set
> >> CONFIG_IEEE802154_DRIVERS=3Dm
> >> # CONFIG_IEEE802154_FAKELB is not set
> >> # CONFIG_IEEE802154_AT86RF230 is not set
> >> # CONFIG_IEEE802154_MRF24J40 is not set
> >> # CONFIG_IEEE802154_CC2520 is not set
> >> # CONFIG_IEEE802154_ATUSB is not set
> >> # CONFIG_IEEE802154_ADF7242 is not set
> >> # CONFIG_IEEE802154_CA8210 is not set
> >> # CONFIG_IEEE802154_MCR20A is not set
> >> # CONFIG_IEEE802154_HWSIM is not set
> >> CONFIG_XEN_NETDEV_FRONTEND=3Dy
> >> # CONFIG_VMXNET3 is not set
> >> # CONFIG_FUJITSU_ES is not set
> >> # CONFIG_HYPERV_NET is not set
> >> CONFIG_NETDEVSIM=3Dm
> >> CONFIG_NET_FAILOVER=3Dm
> >> # CONFIG_ISDN is not set
> >> CONFIG_NVM=3Dy
> >> # CONFIG_NVM_PBLK is not set
> >>
> >> #
> >> # Input device support
> >> #
> >> CONFIG_INPUT=3Dy
> >> CONFIG_INPUT_LEDS=3Dy
> >> CONFIG_INPUT_FF_MEMLESS=3Dm
> >> CONFIG_INPUT_POLLDEV=3Dm
> >> CONFIG_INPUT_SPARSEKMAP=3Dm
> >> # CONFIG_INPUT_MATRIXKMAP is not set
> >>
> >> #
> >> # Userland interfaces
> >> #
> >> CONFIG_INPUT_MOUSEDEV=3Dy
> >> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> >> CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> >> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
> >> CONFIG_INPUT_JOYDEV=3Dm
> >> CONFIG_INPUT_EVDEV=3Dy
> >> # CONFIG_INPUT_EVBUG is not set
> >>
> >> #
> >> # Input Device Drivers
> >> #
> >> CONFIG_INPUT_KEYBOARD=3Dy
> >> # CONFIG_KEYBOARD_ADP5588 is not set
> >> # CONFIG_KEYBOARD_ADP5589 is not set
> >> # CONFIG_KEYBOARD_APPLESPI is not set
> >> CONFIG_KEYBOARD_ATKBD=3Dy
> >> # CONFIG_KEYBOARD_QT1050 is not set
> >> # CONFIG_KEYBOARD_QT1070 is not set
> >> # CONFIG_KEYBOARD_QT2160 is not set
> >> # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> >> # CONFIG_KEYBOARD_LKKBD is not set
> >> # CONFIG_KEYBOARD_GPIO is not set
> >> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> >> # CONFIG_KEYBOARD_TCA6416 is not set
> >> # CONFIG_KEYBOARD_TCA8418 is not set
> >> # CONFIG_KEYBOARD_MATRIX is not set
> >> # CONFIG_KEYBOARD_LM8323 is not set
> >> # CONFIG_KEYBOARD_LM8333 is not set
> >> # CONFIG_KEYBOARD_MAX7359 is not set
> >> # CONFIG_KEYBOARD_MCS is not set
> >> # CONFIG_KEYBOARD_MPR121 is not set
> >> # CONFIG_KEYBOARD_NEWTON is not set
> >> # CONFIG_KEYBOARD_OPENCORES is not set
> >> # CONFIG_KEYBOARD_SAMSUNG is not set
> >> # CONFIG_KEYBOARD_STOWAWAY is not set
> >> # CONFIG_KEYBOARD_SUNKBD is not set
> >> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> >> # CONFIG_KEYBOARD_XTKBD is not set
> >> CONFIG_INPUT_MOUSE=3Dy
> >> CONFIG_MOUSE_PS2=3Dy
> >> CONFIG_MOUSE_PS2_ALPS=3Dy
> >> CONFIG_MOUSE_PS2_BYD=3Dy
> >> CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy
> >> CONFIG_MOUSE_PS2_SYNAPTICS=3Dy
> >> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=3Dy
> >> CONFIG_MOUSE_PS2_CYPRESS=3Dy
> >> CONFIG_MOUSE_PS2_LIFEBOOK=3Dy
> >> CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
> >> CONFIG_MOUSE_PS2_ELANTECH=3Dy
> >> CONFIG_MOUSE_PS2_ELANTECH_SMBUS=3Dy
> >> CONFIG_MOUSE_PS2_SENTELIC=3Dy
> >> # CONFIG_MOUSE_PS2_TOUCHKIT is not set
> >> CONFIG_MOUSE_PS2_FOCALTECH=3Dy
> >> CONFIG_MOUSE_PS2_VMMOUSE=3Dy
> >> CONFIG_MOUSE_PS2_SMBUS=3Dy
> >> CONFIG_MOUSE_SERIAL=3Dm
> >> # CONFIG_MOUSE_APPLETOUCH is not set
> >> # CONFIG_MOUSE_BCM5974 is not set
> >> CONFIG_MOUSE_CYAPA=3Dm
> >> CONFIG_MOUSE_ELAN_I2C=3Dm
> >> CONFIG_MOUSE_ELAN_I2C_I2C=3Dy
> >> CONFIG_MOUSE_ELAN_I2C_SMBUS=3Dy
> >> CONFIG_MOUSE_VSXXXAA=3Dm
> >> # CONFIG_MOUSE_GPIO is not set
> >> CONFIG_MOUSE_SYNAPTICS_I2C=3Dm
> >> # CONFIG_MOUSE_SYNAPTICS_USB is not set
> >> # CONFIG_INPUT_JOYSTICK is not set
> >> # CONFIG_INPUT_TABLET is not set
> >> # CONFIG_INPUT_TOUCHSCREEN is not set
> >> # CONFIG_INPUT_MISC is not set
> >> CONFIG_RMI4_CORE=3Dm
> >> CONFIG_RMI4_I2C=3Dm
> >> CONFIG_RMI4_SPI=3Dm
> >> CONFIG_RMI4_SMB=3Dm
> >> CONFIG_RMI4_F03=3Dy
> >> CONFIG_RMI4_F03_SERIO=3Dm
> >> CONFIG_RMI4_2D_SENSOR=3Dy
> >> CONFIG_RMI4_F11=3Dy
> >> CONFIG_RMI4_F12=3Dy
> >> CONFIG_RMI4_F30=3Dy
> >> CONFIG_RMI4_F34=3Dy
> >> CONFIG_RMI4_F55=3Dy
> >>
> >> #
> >> # Hardware I/O ports
> >> #
> >> CONFIG_SERIO=3Dy
> >> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=3Dy
> >> CONFIG_SERIO_I8042=3Dy
> >> CONFIG_SERIO_SERPORT=3Dy
> >> # CONFIG_SERIO_CT82C710 is not set
> >> # CONFIG_SERIO_PARKBD is not set
> >> # CONFIG_SERIO_PCIPS2 is not set
> >> CONFIG_SERIO_LIBPS2=3Dy
> >> CONFIG_SERIO_RAW=3Dm
> >> CONFIG_SERIO_ALTERA_PS2=3Dm
> >> # CONFIG_SERIO_PS2MULT is not set
> >> CONFIG_SERIO_ARC_PS2=3Dm
> >> CONFIG_HYPERV_KEYBOARD=3Dm
> >> # CONFIG_SERIO_GPIO_PS2 is not set
> >> # CONFIG_USERIO is not set
> >> # CONFIG_GAMEPORT is not set
> >> # end of Hardware I/O ports
> >> # end of Input device support
> >>
> >> #
> >> # Character devices
> >> #
> >> CONFIG_TTY=3Dy
> >> CONFIG_VT=3Dy
> >> CONFIG_CONSOLE_TRANSLATIONS=3Dy
> >> CONFIG_VT_CONSOLE=3Dy
> >> CONFIG_VT_CONSOLE_SLEEP=3Dy
> >> CONFIG_HW_CONSOLE=3Dy
> >> CONFIG_VT_HW_CONSOLE_BINDING=3Dy
> >> CONFIG_UNIX98_PTYS=3Dy
> >> # CONFIG_LEGACY_PTYS is not set
> >> CONFIG_LDISC_AUTOLOAD=3Dy
> >>
> >> #
> >> # Serial drivers
> >> #
> >> CONFIG_SERIAL_EARLYCON=3Dy
> >> CONFIG_SERIAL_8250=3Dy
> >> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> >> CONFIG_SERIAL_8250_PNP=3Dy
> >> # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> >> # CONFIG_SERIAL_8250_FINTEK is not set
> >> CONFIG_SERIAL_8250_CONSOLE=3Dy
> >> CONFIG_SERIAL_8250_DMA=3Dy
> >> CONFIG_SERIAL_8250_PCI=3Dy
> >> CONFIG_SERIAL_8250_EXAR=3Dy
> >> CONFIG_SERIAL_8250_NR_UARTS=3D64
> >> CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
> >> CONFIG_SERIAL_8250_EXTENDED=3Dy
> >> CONFIG_SERIAL_8250_MANY_PORTS=3Dy
> >> CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
> >> # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> >> CONFIG_SERIAL_8250_RSA=3Dy
> >> CONFIG_SERIAL_8250_DWLIB=3Dy
> >> CONFIG_SERIAL_8250_DW=3Dy
> >> # CONFIG_SERIAL_8250_RT288X is not set
> >> CONFIG_SERIAL_8250_LPSS=3Dy
> >> CONFIG_SERIAL_8250_MID=3Dy
> >>
> >> #
> >> # Non-8250 serial port support
> >> #
> >> # CONFIG_SERIAL_MAX3100 is not set
> >> # CONFIG_SERIAL_MAX310X is not set
> >> # CONFIG_SERIAL_UARTLITE is not set
> >> CONFIG_SERIAL_CORE=3Dy
> >> CONFIG_SERIAL_CORE_CONSOLE=3Dy
> >> CONFIG_SERIAL_JSM=3Dm
> >> # CONFIG_SERIAL_LANTIQ is not set
> >> # CONFIG_SERIAL_SCCNXP is not set
> >> # CONFIG_SERIAL_SC16IS7XX is not set
> >> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> >> # CONFIG_SERIAL_ALTERA_UART is not set
> >> # CONFIG_SERIAL_IFX6X60 is not set
> >> CONFIG_SERIAL_ARC=3Dm
> >> CONFIG_SERIAL_ARC_NR_PORTS=3D1
> >> # CONFIG_SERIAL_RP2 is not set
> >> # CONFIG_SERIAL_FSL_LPUART is not set
> >> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> >> # CONFIG_SERIAL_SPRD is not set
> >> # end of Serial drivers
> >>
> >> CONFIG_SERIAL_MCTRL_GPIO=3Dy
> >> CONFIG_SERIAL_NONSTANDARD=3Dy
> >> # CONFIG_ROCKETPORT is not set
> >> CONFIG_CYCLADES=3Dm
> >> # CONFIG_CYZ_INTR is not set
> >> # CONFIG_MOXA_INTELLIO is not set
> >> # CONFIG_MOXA_SMARTIO is not set
> >> CONFIG_SYNCLINK=3Dm
> >> CONFIG_SYNCLINKMP=3Dm
> >> CONFIG_SYNCLINK_GT=3Dm
> >> # CONFIG_ISI is not set
> >> CONFIG_N_HDLC=3Dm
> >> CONFIG_N_GSM=3Dm
> >> CONFIG_NOZOMI=3Dm
> >> # CONFIG_NULL_TTY is not set
> >> # CONFIG_TRACE_SINK is not set
> >> CONFIG_HVC_DRIVER=3Dy
> >> CONFIG_HVC_IRQ=3Dy
> >> CONFIG_HVC_XEN=3Dy
> >> CONFIG_HVC_XEN_FRONTEND=3Dy
> >> # CONFIG_SERIAL_DEV_BUS is not set
> >> CONFIG_PRINTER=3Dm
> >> # CONFIG_LP_CONSOLE is not set
> >> CONFIG_PPDEV=3Dm
> >> CONFIG_VIRTIO_CONSOLE=3Dy
> >> CONFIG_IPMI_HANDLER=3Dm
> >> CONFIG_IPMI_DMI_DECODE=3Dy
> >> CONFIG_IPMI_PLAT_DATA=3Dy
> >> CONFIG_IPMI_PANIC_EVENT=3Dy
> >> CONFIG_IPMI_PANIC_STRING=3Dy
> >> CONFIG_IPMI_DEVICE_INTERFACE=3Dm
> >> CONFIG_IPMI_SI=3Dm
> >> CONFIG_IPMI_SSIF=3Dm
> >> CONFIG_IPMI_WATCHDOG=3Dm
> >> CONFIG_IPMI_POWEROFF=3Dm
> >> CONFIG_HW_RANDOM=3Dy
> >> CONFIG_HW_RANDOM_TIMERIOMEM=3Dm
> >> CONFIG_HW_RANDOM_INTEL=3Dm
> >> CONFIG_HW_RANDOM_AMD=3Dm
> >> CONFIG_HW_RANDOM_VIA=3Dm
> >> CONFIG_HW_RANDOM_VIRTIO=3Dy
> >> # CONFIG_APPLICOM is not set
> >> # CONFIG_MWAVE is not set
> >> CONFIG_DEVMEM=3Dy
> >> # CONFIG_DEVKMEM is not set
> >> CONFIG_NVRAM=3Dy
> >> CONFIG_RAW_DRIVER=3Dy
> >> CONFIG_MAX_RAW_DEVS=3D8192
> >> CONFIG_DEVPORT=3Dy
> >> CONFIG_HPET=3Dy
> >> CONFIG_HPET_MMAP=3Dy
> >> # CONFIG_HPET_MMAP_DEFAULT is not set
> >> CONFIG_HANGCHECK_TIMER=3Dm
> >> CONFIG_UV_MMTIMER=3Dm
> >> CONFIG_TCG_TPM=3Dy
> >> CONFIG_HW_RANDOM_TPM=3Dy
> >> CONFIG_TCG_TIS_CORE=3Dy
> >> CONFIG_TCG_TIS=3Dy
> >> # CONFIG_TCG_TIS_SPI is not set
> >> CONFIG_TCG_TIS_I2C_ATMEL=3Dm
> >> CONFIG_TCG_TIS_I2C_INFINEON=3Dm
> >> CONFIG_TCG_TIS_I2C_NUVOTON=3Dm
> >> CONFIG_TCG_NSC=3Dm
> >> CONFIG_TCG_ATMEL=3Dm
> >> CONFIG_TCG_INFINEON=3Dm
> >> # CONFIG_TCG_XEN is not set
> >> CONFIG_TCG_CRB=3Dy
> >> # CONFIG_TCG_VTPM_PROXY is not set
> >> CONFIG_TCG_TIS_ST33ZP24=3Dm
> >> CONFIG_TCG_TIS_ST33ZP24_I2C=3Dm
> >> # CONFIG_TCG_TIS_ST33ZP24_SPI is not set
> >> CONFIG_TELCLOCK=3Dm
> >> # CONFIG_XILLYBUS is not set
> >> # end of Character devices
> >>
> >> # CONFIG_RANDOM_TRUST_CPU is not set
> >> # CONFIG_RANDOM_TRUST_BOOTLOADER is not set
> >>
> >> #
> >> # I2C support
> >> #
> >> CONFIG_I2C=3Dy
> >> CONFIG_ACPI_I2C_OPREGION=3Dy
> >> CONFIG_I2C_BOARDINFO=3Dy
> >> CONFIG_I2C_COMPAT=3Dy
> >> CONFIG_I2C_CHARDEV=3Dm
> >> CONFIG_I2C_MUX=3Dm
> >>
> >> #
> >> # Multiplexer I2C Chip support
> >> #
> >> # CONFIG_I2C_MUX_GPIO is not set
> >> # CONFIG_I2C_MUX_LTC4306 is not set
> >> # CONFIG_I2C_MUX_PCA9541 is not set
> >> # CONFIG_I2C_MUX_PCA954x is not set
> >> # CONFIG_I2C_MUX_REG is not set
> >> CONFIG_I2C_MUX_MLXCPLD=3Dm
> >> # end of Multiplexer I2C Chip support
> >>
> >> CONFIG_I2C_HELPER_AUTO=3Dy
> >> CONFIG_I2C_SMBUS=3Dy
> >> CONFIG_I2C_ALGOBIT=3Dy
> >> CONFIG_I2C_ALGOPCA=3Dm
> >>
> >> #
> >> # I2C Hardware Bus support
> >> #
> >>
> >> #
> >> # PC SMBus host controller drivers
> >> #
> >> # CONFIG_I2C_ALI1535 is not set
> >> # CONFIG_I2C_ALI1563 is not set
> >> # CONFIG_I2C_ALI15X3 is not set
> >> CONFIG_I2C_AMD756=3Dm
> >> CONFIG_I2C_AMD756_S4882=3Dm
> >> CONFIG_I2C_AMD8111=3Dm
> >> # CONFIG_I2C_AMD_MP2 is not set
> >> CONFIG_I2C_I801=3Dy
> >> CONFIG_I2C_ISCH=3Dm
> >> CONFIG_I2C_ISMT=3Dm
> >> CONFIG_I2C_PIIX4=3Dm
> >> CONFIG_I2C_NFORCE2=3Dm
> >> CONFIG_I2C_NFORCE2_S4985=3Dm
> >> # CONFIG_I2C_NVIDIA_GPU is not set
> >> # CONFIG_I2C_SIS5595 is not set
> >> # CONFIG_I2C_SIS630 is not set
> >> CONFIG_I2C_SIS96X=3Dm
> >> CONFIG_I2C_VIA=3Dm
> >> CONFIG_I2C_VIAPRO=3Dm
> >>
> >> #
> >> # ACPI drivers
> >> #
> >> CONFIG_I2C_SCMI=3Dm
> >>
> >> #
> >> # I2C system bus drivers (mostly embedded / system-on-chip)
> >> #
> >> # CONFIG_I2C_CBUS_GPIO is not set
> >> CONFIG_I2C_DESIGNWARE_CORE=3Dm
> >> # CONFIG_I2C_DESIGNWARE_SLAVE is not set
> >> CONFIG_I2C_DESIGNWARE_PLATFORM=3Dm
> >> CONFIG_I2C_DESIGNWARE_BAYTRAIL=3Dy
> >> # CONFIG_I2C_DESIGNWARE_PCI is not set
> >> # CONFIG_I2C_EMEV2 is not set
> >> # CONFIG_I2C_GPIO is not set
> >> # CONFIG_I2C_OCORES is not set
> >> CONFIG_I2C_PCA_PLATFORM=3Dm
> >> CONFIG_I2C_SIMTEC=3Dm
> >> # CONFIG_I2C_XILINX is not set
> >>
> >> #
> >> # External I2C/SMBus adapter drivers
> >> #
> >> # CONFIG_I2C_DIOLAN_U2C is not set
> >> CONFIG_I2C_PARPORT=3Dm
> >> # CONFIG_I2C_ROBOTFUZZ_OSIF is not set
> >> # CONFIG_I2C_TAOS_EVM is not set
> >> # CONFIG_I2C_TINY_USB is not set
> >>
> >> #
> >> # Other I2C/SMBus bus drivers
> >> #
> >> CONFIG_I2C_MLXCPLD=3Dm
> >> # end of I2C Hardware Bus support
> >>
> >> CONFIG_I2C_STUB=3Dm
> >> # CONFIG_I2C_SLAVE is not set
> >> # CONFIG_I2C_DEBUG_CORE is not set
> >> # CONFIG_I2C_DEBUG_ALGO is not set
> >> # CONFIG_I2C_DEBUG_BUS is not set
> >> # end of I2C support
> >>
> >> # CONFIG_I3C is not set
> >> CONFIG_SPI=3Dy
> >> # CONFIG_SPI_DEBUG is not set
> >> CONFIG_SPI_MASTER=3Dy
> >> # CONFIG_SPI_MEM is not set
> >>
> >> #
> >> # SPI Master Controller Drivers
> >> #
> >> # CONFIG_SPI_ALTERA is not set
> >> # CONFIG_SPI_AXI_SPI_ENGINE is not set
> >> # CONFIG_SPI_BITBANG is not set
> >> # CONFIG_SPI_BUTTERFLY is not set
> >> # CONFIG_SPI_CADENCE is not set
> >> # CONFIG_SPI_DESIGNWARE is not set
> >> # CONFIG_SPI_NXP_FLEXSPI is not set
> >> # CONFIG_SPI_GPIO is not set
> >> # CONFIG_SPI_LM70_LLP is not set
> >> # CONFIG_SPI_OC_TINY is not set
> >> # CONFIG_SPI_PXA2XX is not set
> >> # CONFIG_SPI_ROCKCHIP is not set
> >> # CONFIG_SPI_SC18IS602 is not set
> >> # CONFIG_SPI_SIFIVE is not set
> >> # CONFIG_SPI_MXIC is not set
> >> # CONFIG_SPI_XCOMM is not set
> >> # CONFIG_SPI_XILINX is not set
> >> # CONFIG_SPI_ZYNQMP_GQSPI is not set
> >> # CONFIG_SPI_AMD is not set
> >>
> >> #
> >> # SPI Multiplexer support
> >> #
> >> # CONFIG_SPI_MUX is not set
> >>
> >> #
> >> # SPI Protocol Masters
> >> #
> >> # CONFIG_SPI_SPIDEV is not set
> >> # CONFIG_SPI_LOOPBACK_TEST is not set
> >> # CONFIG_SPI_TLE62X0 is not set
> >> # CONFIG_SPI_SLAVE is not set
> >> # CONFIG_SPMI is not set
> >> # CONFIG_HSI is not set
> >> CONFIG_PPS=3Dy
> >> # CONFIG_PPS_DEBUG is not set
> >>
> >> #
> >> # PPS clients support
> >> #
> >> # CONFIG_PPS_CLIENT_KTIMER is not set
> >> CONFIG_PPS_CLIENT_LDISC=3Dm
> >> CONFIG_PPS_CLIENT_PARPORT=3Dm
> >> CONFIG_PPS_CLIENT_GPIO=3Dm
> >>
> >> #
> >> # PPS generators support
> >> #
> >>
> >> #
> >> # PTP clock support
> >> #
> >> CONFIG_PTP_1588_CLOCK=3Dy
> >> # CONFIG_DP83640_PHY is not set
> >> # CONFIG_PTP_1588_CLOCK_INES is not set
> >> CONFIG_PTP_1588_CLOCK_KVM=3Dm
> >> # CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
> >> # CONFIG_PTP_1588_CLOCK_IDTCM is not set
> >> # CONFIG_PTP_1588_CLOCK_VMW is not set
> >> # end of PTP clock support
> >>
> >> CONFIG_PINCTRL=3Dy
> >> CONFIG_PINMUX=3Dy
> >> CONFIG_PINCONF=3Dy
> >> CONFIG_GENERIC_PINCONF=3Dy
> >> # CONFIG_DEBUG_PINCTRL is not set
> >> CONFIG_PINCTRL_AMD=3Dm
> >> # CONFIG_PINCTRL_MCP23S08 is not set
> >> # CONFIG_PINCTRL_SX150X is not set
> >> CONFIG_PINCTRL_BAYTRAIL=3Dy
> >> # CONFIG_PINCTRL_CHERRYVIEW is not set
> >> # CONFIG_PINCTRL_LYNXPOINT is not set
> >> CONFIG_PINCTRL_INTEL=3Dm
> >> CONFIG_PINCTRL_BROXTON=3Dm
> >> CONFIG_PINCTRL_CANNONLAKE=3Dm
> >> CONFIG_PINCTRL_CEDARFORK=3Dm
> >> CONFIG_PINCTRL_DENVERTON=3Dm
> >> CONFIG_PINCTRL_GEMINILAKE=3Dm
> >> # CONFIG_PINCTRL_ICELAKE is not set
> >> # CONFIG_PINCTRL_JASPERLAKE is not set
> >> CONFIG_PINCTRL_LEWISBURG=3Dm
> >> CONFIG_PINCTRL_SUNRISEPOINT=3Dm
> >> # CONFIG_PINCTRL_TIGERLAKE is not set
> >> CONFIG_GPIOLIB=3Dy
> >> CONFIG_GPIOLIB_FASTPATH_LIMIT=3D512
> >> CONFIG_GPIO_ACPI=3Dy
> >> CONFIG_GPIOLIB_IRQCHIP=3Dy
> >> # CONFIG_DEBUG_GPIO is not set
> >> CONFIG_GPIO_SYSFS=3Dy
> >> CONFIG_GPIO_GENERIC=3Dm
> >>
> >> #
> >> # Memory mapped GPIO drivers
> >> #
> >> CONFIG_GPIO_AMDPT=3Dm
> >> # CONFIG_GPIO_DWAPB is not set
> >> # CONFIG_GPIO_EXAR is not set
> >> # CONFIG_GPIO_GENERIC_PLATFORM is not set
> >> CONFIG_GPIO_ICH=3Dm
> >> # CONFIG_GPIO_MB86S7X is not set
> >> # CONFIG_GPIO_VX855 is not set
> >> # CONFIG_GPIO_XILINX is not set
> >> # CONFIG_GPIO_AMD_FCH is not set
> >> # end of Memory mapped GPIO drivers
> >>
> >> #
> >> # Port-mapped I/O GPIO drivers
> >> #
> >> # CONFIG_GPIO_F7188X is not set
> >> # CONFIG_GPIO_IT87 is not set
> >> # CONFIG_GPIO_SCH is not set
> >> # CONFIG_GPIO_SCH311X is not set
> >> # CONFIG_GPIO_WINBOND is not set
> >> # CONFIG_GPIO_WS16C48 is not set
> >> # end of Port-mapped I/O GPIO drivers
> >>
> >> #
> >> # I2C GPIO expanders
> >> #
> >> # CONFIG_GPIO_ADP5588 is not set
> >> # CONFIG_GPIO_MAX7300 is not set
> >> # CONFIG_GPIO_MAX732X is not set
> >> # CONFIG_GPIO_PCA953X is not set
> >> # CONFIG_GPIO_PCF857X is not set
> >> # CONFIG_GPIO_TPIC2810 is not set
> >> # end of I2C GPIO expanders
> >>
> >> #
> >> # MFD GPIO expanders
> >> #
> >> # end of MFD GPIO expanders
> >>
> >> #
> >> # PCI GPIO expanders
> >> #
> >> # CONFIG_GPIO_AMD8111 is not set
> >> # CONFIG_GPIO_BT8XX is not set
> >> # CONFIG_GPIO_ML_IOH is not set
> >> # CONFIG_GPIO_PCI_IDIO_16 is not set
> >> # CONFIG_GPIO_PCIE_IDIO_24 is not set
> >> # CONFIG_GPIO_RDC321X is not set
> >> # end of PCI GPIO expanders
> >>
> >> #
> >> # SPI GPIO expanders
> >> #
> >> # CONFIG_GPIO_MAX3191X is not set
> >> # CONFIG_GPIO_MAX7301 is not set
> >> # CONFIG_GPIO_MC33880 is not set
> >> # CONFIG_GPIO_PISOSR is not set
> >> # CONFIG_GPIO_XRA1403 is not set
> >> # end of SPI GPIO expanders
> >>
> >> #
> >> # USB GPIO expanders
> >> #
> >> # end of USB GPIO expanders
> >>
> >> # CONFIG_GPIO_AGGREGATOR is not set
> >> # CONFIG_GPIO_MOCKUP is not set
> >> # CONFIG_W1 is not set
> >> # CONFIG_POWER_AVS is not set
> >> CONFIG_POWER_RESET=3Dy
> >> # CONFIG_POWER_RESET_RESTART is not set
> >> CONFIG_POWER_SUPPLY=3Dy
> >> # CONFIG_POWER_SUPPLY_DEBUG is not set
> >> CONFIG_POWER_SUPPLY_HWMON=3Dy
> >> # CONFIG_PDA_POWER is not set
> >> # CONFIG_TEST_POWER is not set
> >> # CONFIG_CHARGER_ADP5061 is not set
> >> # CONFIG_BATTERY_CW2015 is not set
> >> # CONFIG_BATTERY_DS2780 is not set
> >> # CONFIG_BATTERY_DS2781 is not set
> >> # CONFIG_BATTERY_DS2782 is not set
> >> # CONFIG_BATTERY_SBS is not set
> >> # CONFIG_CHARGER_SBS is not set
> >> # CONFIG_MANAGER_SBS is not set
> >> # CONFIG_BATTERY_BQ27XXX is not set
> >> # CONFIG_BATTERY_MAX17040 is not set
> >> # CONFIG_BATTERY_MAX17042 is not set
> >> # CONFIG_CHARGER_MAX8903 is not set
> >> # CONFIG_CHARGER_LP8727 is not set
> >> # CONFIG_CHARGER_GPIO is not set
> >> # CONFIG_CHARGER_LT3651 is not set
> >> # CONFIG_CHARGER_BQ2415X is not set
> >> # CONFIG_CHARGER_BQ24257 is not set
> >> # CONFIG_CHARGER_BQ24735 is not set
> >> # CONFIG_CHARGER_BQ25890 is not set
> >> CONFIG_CHARGER_SMB347=3Dm
> >> # CONFIG_BATTERY_GAUGE_LTC2941 is not set
> >> # CONFIG_CHARGER_RT9455 is not set
> >> # CONFIG_CHARGER_BD99954 is not set
> >> CONFIG_HWMON=3Dy
> >> CONFIG_HWMON_VID=3Dm
> >> # CONFIG_HWMON_DEBUG_CHIP is not set
> >>
> >> #
> >> # Native drivers
> >> #
> >> CONFIG_SENSORS_ABITUGURU=3Dm
> >> CONFIG_SENSORS_ABITUGURU3=3Dm
> >> # CONFIG_SENSORS_AD7314 is not set
> >> CONFIG_SENSORS_AD7414=3Dm
> >> CONFIG_SENSORS_AD7418=3Dm
> >> CONFIG_SENSORS_ADM1021=3Dm
> >> CONFIG_SENSORS_ADM1025=3Dm
> >> CONFIG_SENSORS_ADM1026=3Dm
> >> CONFIG_SENSORS_ADM1029=3Dm
> >> CONFIG_SENSORS_ADM1031=3Dm
> >> # CONFIG_SENSORS_ADM1177 is not set
> >> CONFIG_SENSORS_ADM9240=3Dm
> >> CONFIG_SENSORS_ADT7X10=3Dm
> >> # CONFIG_SENSORS_ADT7310 is not set
> >> CONFIG_SENSORS_ADT7410=3Dm
> >> CONFIG_SENSORS_ADT7411=3Dm
> >> CONFIG_SENSORS_ADT7462=3Dm
> >> CONFIG_SENSORS_ADT7470=3Dm
> >> CONFIG_SENSORS_ADT7475=3Dm
> >> # CONFIG_SENSORS_AS370 is not set
> >> CONFIG_SENSORS_ASC7621=3Dm
> >> # CONFIG_SENSORS_AXI_FAN_CONTROL is not set
> >> CONFIG_SENSORS_K8TEMP=3Dm
> >> CONFIG_SENSORS_K10TEMP=3Dm
> >> CONFIG_SENSORS_FAM15H_POWER=3Dm
> >> # CONFIG_SENSORS_AMD_ENERGY is not set
> >> CONFIG_SENSORS_APPLESMC=3Dm
> >> CONFIG_SENSORS_ASB100=3Dm
> >> # CONFIG_SENSORS_ASPEED is not set
> >> CONFIG_SENSORS_ATXP1=3Dm
> >> # CONFIG_SENSORS_DRIVETEMP is not set
> >> CONFIG_SENSORS_DS620=3Dm
> >> CONFIG_SENSORS_DS1621=3Dm
> >> CONFIG_SENSORS_DELL_SMM=3Dm
> >> CONFIG_SENSORS_I5K_AMB=3Dm
> >> CONFIG_SENSORS_F71805F=3Dm
> >> CONFIG_SENSORS_F71882FG=3Dm
> >> CONFIG_SENSORS_F75375S=3Dm
> >> CONFIG_SENSORS_FSCHMD=3Dm
> >> # CONFIG_SENSORS_FTSTEUTATES is not set
> >> CONFIG_SENSORS_GL518SM=3Dm
> >> CONFIG_SENSORS_GL520SM=3Dm
> >> CONFIG_SENSORS_G760A=3Dm
> >> # CONFIG_SENSORS_G762 is not set
> >> # CONFIG_SENSORS_HIH6130 is not set
> >> CONFIG_SENSORS_IBMAEM=3Dm
> >> CONFIG_SENSORS_IBMPEX=3Dm
> >> CONFIG_SENSORS_I5500=3Dm
> >> CONFIG_SENSORS_CORETEMP=3Dm
> >> CONFIG_SENSORS_IT87=3Dm
> >> CONFIG_SENSORS_JC42=3Dm
> >> # CONFIG_SENSORS_POWR1220 is not set
> >> CONFIG_SENSORS_LINEAGE=3Dm
> >> # CONFIG_SENSORS_LTC2945 is not set
> >> # CONFIG_SENSORS_LTC2947_I2C is not set
> >> # CONFIG_SENSORS_LTC2947_SPI is not set
> >> # CONFIG_SENSORS_LTC2990 is not set
> >> CONFIG_SENSORS_LTC4151=3Dm
> >> CONFIG_SENSORS_LTC4215=3Dm
> >> # CONFIG_SENSORS_LTC4222 is not set
> >> CONFIG_SENSORS_LTC4245=3Dm
> >> # CONFIG_SENSORS_LTC4260 is not set
> >> CONFIG_SENSORS_LTC4261=3Dm
> >> # CONFIG_SENSORS_MAX1111 is not set
> >> CONFIG_SENSORS_MAX16065=3Dm
> >> CONFIG_SENSORS_MAX1619=3Dm
> >> CONFIG_SENSORS_MAX1668=3Dm
> >> CONFIG_SENSORS_MAX197=3Dm
> >> # CONFIG_SENSORS_MAX31722 is not set
> >> # CONFIG_SENSORS_MAX31730 is not set
> >> # CONFIG_SENSORS_MAX6621 is not set
> >> CONFIG_SENSORS_MAX6639=3Dm
> >> CONFIG_SENSORS_MAX6642=3Dm
> >> CONFIG_SENSORS_MAX6650=3Dm
> >> CONFIG_SENSORS_MAX6697=3Dm
> >> # CONFIG_SENSORS_MAX31790 is not set
> >> CONFIG_SENSORS_MCP3021=3Dm
> >> # CONFIG_SENSORS_MLXREG_FAN is not set
> >> # CONFIG_SENSORS_TC654 is not set
> >> # CONFIG_SENSORS_ADCXX is not set
> >> CONFIG_SENSORS_LM63=3Dm
> >> # CONFIG_SENSORS_LM70 is not set
> >> CONFIG_SENSORS_LM73=3Dm
> >> CONFIG_SENSORS_LM75=3Dm
> >> CONFIG_SENSORS_LM77=3Dm
> >> CONFIG_SENSORS_LM78=3Dm
> >> CONFIG_SENSORS_LM80=3Dm
> >> CONFIG_SENSORS_LM83=3Dm
> >> CONFIG_SENSORS_LM85=3Dm
> >> CONFIG_SENSORS_LM87=3Dm
> >> CONFIG_SENSORS_LM90=3Dm
> >> CONFIG_SENSORS_LM92=3Dm
> >> CONFIG_SENSORS_LM93=3Dm
> >> CONFIG_SENSORS_LM95234=3Dm
> >> CONFIG_SENSORS_LM95241=3Dm
> >> CONFIG_SENSORS_LM95245=3Dm
> >> CONFIG_SENSORS_PC87360=3Dm
> >> CONFIG_SENSORS_PC87427=3Dm
> >> CONFIG_SENSORS_NTC_THERMISTOR=3Dm
> >> # CONFIG_SENSORS_NCT6683 is not set
> >> CONFIG_SENSORS_NCT6775=3Dm
> >> # CONFIG_SENSORS_NCT7802 is not set
> >> # CONFIG_SENSORS_NCT7904 is not set
> >> # CONFIG_SENSORS_NPCM7XX is not set
> >> CONFIG_SENSORS_PCF8591=3Dm
> >> CONFIG_PMBUS=3Dm
> >> CONFIG_SENSORS_PMBUS=3Dm
> >> CONFIG_SENSORS_ADM1275=3Dm
> >> # CONFIG_SENSORS_BEL_PFE is not set
> >> # CONFIG_SENSORS_IBM_CFFPS is not set
> >> # CONFIG_SENSORS_INSPUR_IPSPS is not set
> >> # CONFIG_SENSORS_IR35221 is not set
> >> # CONFIG_SENSORS_IR38064 is not set
> >> # CONFIG_SENSORS_IRPS5401 is not set
> >> # CONFIG_SENSORS_ISL68137 is not set
> >> CONFIG_SENSORS_LM25066=3Dm
> >> CONFIG_SENSORS_LTC2978=3Dm
> >> # CONFIG_SENSORS_LTC3815 is not set
> >> CONFIG_SENSORS_MAX16064=3Dm
> >> # CONFIG_SENSORS_MAX16601 is not set
> >> # CONFIG_SENSORS_MAX20730 is not set
> >> # CONFIG_SENSORS_MAX20751 is not set
> >> # CONFIG_SENSORS_MAX31785 is not set
> >> CONFIG_SENSORS_MAX34440=3Dm
> >> CONFIG_SENSORS_MAX8688=3Dm
> >> # CONFIG_SENSORS_PXE1610 is not set
> >> # CONFIG_SENSORS_TPS40422 is not set
> >> # CONFIG_SENSORS_TPS53679 is not set
> >> CONFIG_SENSORS_UCD9000=3Dm
> >> CONFIG_SENSORS_UCD9200=3Dm
> >> # CONFIG_SENSORS_XDPE122 is not set
> >> CONFIG_SENSORS_ZL6100=3Dm
> >> CONFIG_SENSORS_SHT15=3Dm
> >> CONFIG_SENSORS_SHT21=3Dm
> >> # CONFIG_SENSORS_SHT3x is not set
> >> # CONFIG_SENSORS_SHTC1 is not set
> >> CONFIG_SENSORS_SIS5595=3Dm
> >> CONFIG_SENSORS_DME1737=3Dm
> >> CONFIG_SENSORS_EMC1403=3Dm
> >> # CONFIG_SENSORS_EMC2103 is not set
> >> CONFIG_SENSORS_EMC6W201=3Dm
> >> CONFIG_SENSORS_SMSC47M1=3Dm
> >> CONFIG_SENSORS_SMSC47M192=3Dm
> >> CONFIG_SENSORS_SMSC47B397=3Dm
> >> CONFIG_SENSORS_SCH56XX_COMMON=3Dm
> >> CONFIG_SENSORS_SCH5627=3Dm
> >> CONFIG_SENSORS_SCH5636=3Dm
> >> # CONFIG_SENSORS_STTS751 is not set
> >> # CONFIG_SENSORS_SMM665 is not set
> >> # CONFIG_SENSORS_ADC128D818 is not set
> >> CONFIG_SENSORS_ADS7828=3Dm
> >> # CONFIG_SENSORS_ADS7871 is not set
> >> CONFIG_SENSORS_AMC6821=3Dm
> >> CONFIG_SENSORS_INA209=3Dm
> >> CONFIG_SENSORS_INA2XX=3Dm
> >> # CONFIG_SENSORS_INA3221 is not set
> >> # CONFIG_SENSORS_TC74 is not set
> >> CONFIG_SENSORS_THMC50=3Dm
> >> CONFIG_SENSORS_TMP102=3Dm
> >> # CONFIG_SENSORS_TMP103 is not set
> >> # CONFIG_SENSORS_TMP108 is not set
> >> CONFIG_SENSORS_TMP401=3Dm
> >> CONFIG_SENSORS_TMP421=3Dm
> >> # CONFIG_SENSORS_TMP513 is not set
> >> CONFIG_SENSORS_VIA_CPUTEMP=3Dm
> >> CONFIG_SENSORS_VIA686A=3Dm
> >> CONFIG_SENSORS_VT1211=3Dm
> >> CONFIG_SENSORS_VT8231=3Dm
> >> # CONFIG_SENSORS_W83773G is not set
> >> CONFIG_SENSORS_W83781D=3Dm
> >> CONFIG_SENSORS_W83791D=3Dm
> >> CONFIG_SENSORS_W83792D=3Dm
> >> CONFIG_SENSORS_W83793=3Dm
> >> CONFIG_SENSORS_W83795=3Dm
> >> # CONFIG_SENSORS_W83795_FANCTRL is not set
> >> CONFIG_SENSORS_W83L785TS=3Dm
> >> CONFIG_SENSORS_W83L786NG=3Dm
> >> CONFIG_SENSORS_W83627HF=3Dm
> >> CONFIG_SENSORS_W83627EHF=3Dm
> >> # CONFIG_SENSORS_XGENE is not set
> >>
> >> #
> >> # ACPI drivers
> >> #
> >> CONFIG_SENSORS_ACPI_POWER=3Dm
> >> CONFIG_SENSORS_ATK0110=3Dm
> >> CONFIG_THERMAL=3Dy
> >> # CONFIG_THERMAL_STATISTICS is not set
> >> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=3D0
> >> CONFIG_THERMAL_HWMON=3Dy
> >> CONFIG_THERMAL_WRITABLE_TRIPS=3Dy
> >> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=3Dy
> >> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> >> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> >> CONFIG_THERMAL_GOV_FAIR_SHARE=3Dy
> >> CONFIG_THERMAL_GOV_STEP_WISE=3Dy
> >> CONFIG_THERMAL_GOV_BANG_BANG=3Dy
> >> CONFIG_THERMAL_GOV_USER_SPACE=3Dy
> >> # CONFIG_THERMAL_EMULATION is not set
> >>
> >> #
> >> # Intel thermal drivers
> >> #
> >> CONFIG_INTEL_POWERCLAMP=3Dm
> >> CONFIG_X86_PKG_TEMP_THERMAL=3Dm
> >> CONFIG_INTEL_SOC_DTS_IOSF_CORE=3Dm
> >> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
> >>
> >> #
> >> # ACPI INT340X thermal drivers
> >> #
> >> CONFIG_INT340X_THERMAL=3Dm
> >> CONFIG_ACPI_THERMAL_REL=3Dm
> >> # CONFIG_INT3406_THERMAL is not set
> >> CONFIG_PROC_THERMAL_MMIO_RAPL=3Dy
> >> # end of ACPI INT340X thermal drivers
> >>
> >> CONFIG_INTEL_PCH_THERMAL=3Dm
> >> # end of Intel thermal drivers
> >>
> >> CONFIG_WATCHDOG=3Dy
> >> CONFIG_WATCHDOG_CORE=3Dy
> >> # CONFIG_WATCHDOG_NOWAYOUT is not set
> >> CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=3Dy
> >> CONFIG_WATCHDOG_OPEN_TIMEOUT=3D0
> >> CONFIG_WATCHDOG_SYSFS=3Dy
> >>
> >> #
> >> # Watchdog Pretimeout Governors
> >> #
> >> # CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
> >>
> >> #
> >> # Watchdog Device Drivers
> >> #
> >> CONFIG_SOFT_WATCHDOG=3Dm
> >> CONFIG_WDAT_WDT=3Dm
> >> # CONFIG_XILINX_WATCHDOG is not set
> >> # CONFIG_ZIIRAVE_WATCHDOG is not set
> >> # CONFIG_MLX_WDT is not set
> >> # CONFIG_CADENCE_WATCHDOG is not set
> >> # CONFIG_DW_WATCHDOG is not set
> >> # CONFIG_MAX63XX_WATCHDOG is not set
> >> # CONFIG_ACQUIRE_WDT is not set
> >> # CONFIG_ADVANTECH_WDT is not set
> >> CONFIG_ALIM1535_WDT=3Dm
> >> CONFIG_ALIM7101_WDT=3Dm
> >> # CONFIG_EBC_C384_WDT is not set
> >> CONFIG_F71808E_WDT=3Dm
> >> CONFIG_SP5100_TCO=3Dm
> >> CONFIG_SBC_FITPC2_WATCHDOG=3Dm
> >> # CONFIG_EUROTECH_WDT is not set
> >> CONFIG_IB700_WDT=3Dm
> >> CONFIG_IBMASR=3Dm
> >> # CONFIG_WAFER_WDT is not set
> >> CONFIG_I6300ESB_WDT=3Dy
> >> CONFIG_IE6XX_WDT=3Dm
> >> CONFIG_ITCO_WDT=3Dy
> >> CONFIG_ITCO_VENDOR_SUPPORT=3Dy
> >> CONFIG_IT8712F_WDT=3Dm
> >> CONFIG_IT87_WDT=3Dm
> >> CONFIG_HP_WATCHDOG=3Dm
> >> CONFIG_HPWDT_NMI_DECODING=3Dy
> >> # CONFIG_SC1200_WDT is not set
> >> # CONFIG_PC87413_WDT is not set
> >> CONFIG_NV_TCO=3Dm
> >> # CONFIG_60XX_WDT is not set
> >> # CONFIG_CPU5_WDT is not set
> >> CONFIG_SMSC_SCH311X_WDT=3Dm
> >> # CONFIG_SMSC37B787_WDT is not set
> >> # CONFIG_TQMX86_WDT is not set
> >> CONFIG_VIA_WDT=3Dm
> >> CONFIG_W83627HF_WDT=3Dm
> >> CONFIG_W83877F_WDT=3Dm
> >> CONFIG_W83977F_WDT=3Dm
> >> CONFIG_MACHZ_WDT=3Dm
> >> # CONFIG_SBC_EPX_C3_WATCHDOG is not set
> >> CONFIG_INTEL_MEI_WDT=3Dm
> >> # CONFIG_NI903X_WDT is not set
> >> # CONFIG_NIC7018_WDT is not set
> >> # CONFIG_MEN_A21_WDT is not set
> >> CONFIG_XEN_WDT=3Dm
> >>
> >> #
> >> # PCI-based Watchdog Cards
> >> #
> >> CONFIG_PCIPCWATCHDOG=3Dm
> >> CONFIG_WDTPCI=3Dm
> >>
> >> #
> >> # USB-based Watchdog Cards
> >> #
> >> # CONFIG_USBPCWATCHDOG is not set
> >> CONFIG_SSB_POSSIBLE=3Dy
> >> # CONFIG_SSB is not set
> >> CONFIG_BCMA_POSSIBLE=3Dy
> >> CONFIG_BCMA=3Dm
> >> CONFIG_BCMA_HOST_PCI_POSSIBLE=3Dy
> >> CONFIG_BCMA_HOST_PCI=3Dy
> >> # CONFIG_BCMA_HOST_SOC is not set
> >> CONFIG_BCMA_DRIVER_PCI=3Dy
> >> CONFIG_BCMA_DRIVER_GMAC_CMN=3Dy
> >> CONFIG_BCMA_DRIVER_GPIO=3Dy
> >> # CONFIG_BCMA_DEBUG is not set
> >>
> >> #
> >> # Multifunction device drivers
> >> #
> >> CONFIG_MFD_CORE=3Dy
> >> # CONFIG_MFD_AS3711 is not set
> >> # CONFIG_PMIC_ADP5520 is not set
> >> # CONFIG_MFD_AAT2870_CORE is not set
> >> # CONFIG_MFD_BCM590XX is not set
> >> # CONFIG_MFD_BD9571MWV is not set
> >> # CONFIG_MFD_AXP20X_I2C is not set
> >> # CONFIG_MFD_MADERA is not set
> >> # CONFIG_PMIC_DA903X is not set
> >> # CONFIG_MFD_DA9052_SPI is not set
> >> # CONFIG_MFD_DA9052_I2C is not set
> >> # CONFIG_MFD_DA9055 is not set
> >> # CONFIG_MFD_DA9062 is not set
> >> # CONFIG_MFD_DA9063 is not set
> >> # CONFIG_MFD_DA9150 is not set
> >> # CONFIG_MFD_DLN2 is not set
> >> # CONFIG_MFD_MC13XXX_SPI is not set
> >> # CONFIG_MFD_MC13XXX_I2C is not set
> >> # CONFIG_MFD_MP2629 is not set
> >> # CONFIG_HTC_PASIC3 is not set
> >> # CONFIG_HTC_I2CPLD is not set
> >> # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> >> CONFIG_LPC_ICH=3Dy
> >> CONFIG_LPC_SCH=3Dm
> >> # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
> >> CONFIG_MFD_INTEL_LPSS=3Dy
> >> CONFIG_MFD_INTEL_LPSS_ACPI=3Dy
> >> CONFIG_MFD_INTEL_LPSS_PCI=3Dy
> >> # CONFIG_MFD_INTEL_PMC_BXT is not set
> >> # CONFIG_MFD_IQS62X is not set
> >> # CONFIG_MFD_JANZ_CMODIO is not set
> >> # CONFIG_MFD_KEMPLD is not set
> >> # CONFIG_MFD_88PM800 is not set
> >> # CONFIG_MFD_88PM805 is not set
> >> # CONFIG_MFD_88PM860X is not set
> >> # CONFIG_MFD_MAX14577 is not set
> >> # CONFIG_MFD_MAX77693 is not set
> >> # CONFIG_MFD_MAX77843 is not set
> >> # CONFIG_MFD_MAX8907 is not set
> >> # CONFIG_MFD_MAX8925 is not set
> >> # CONFIG_MFD_MAX8997 is not set
> >> # CONFIG_MFD_MAX8998 is not set
> >> # CONFIG_MFD_MT6360 is not set
> >> # CONFIG_MFD_MT6397 is not set
> >> # CONFIG_MFD_MENF21BMC is not set
> >> # CONFIG_EZX_PCAP is not set
> >> # CONFIG_MFD_VIPERBOARD is not set
> >> # CONFIG_MFD_RETU is not set
> >> # CONFIG_MFD_PCF50633 is not set
> >> # CONFIG_MFD_RDC321X is not set
> >> # CONFIG_MFD_RT5033 is not set
> >> # CONFIG_MFD_RC5T583 is not set
> >> # CONFIG_MFD_SEC_CORE is not set
> >> # CONFIG_MFD_SI476X_CORE is not set
> >> CONFIG_MFD_SM501=3Dm
> >> CONFIG_MFD_SM501_GPIO=3Dy
> >> # CONFIG_MFD_SKY81452 is not set
> >> # CONFIG_MFD_SMSC is not set
> >> # CONFIG_ABX500_CORE is not set
> >> # CONFIG_MFD_SYSCON is not set
> >> # CONFIG_MFD_TI_AM335X_TSCADC is not set
> >> # CONFIG_MFD_LP3943 is not set
> >> # CONFIG_MFD_LP8788 is not set
> >> # CONFIG_MFD_TI_LMU is not set
> >> # CONFIG_MFD_PALMAS is not set
> >> # CONFIG_TPS6105X is not set
> >> # CONFIG_TPS65010 is not set
> >> # CONFIG_TPS6507X is not set
> >> # CONFIG_MFD_TPS65086 is not set
> >> # CONFIG_MFD_TPS65090 is not set
> >> # CONFIG_MFD_TI_LP873X is not set
> >> # CONFIG_MFD_TPS6586X is not set
> >> # CONFIG_MFD_TPS65910 is not set
> >> # CONFIG_MFD_TPS65912_I2C is not set
> >> # CONFIG_MFD_TPS65912_SPI is not set
> >> # CONFIG_MFD_TPS80031 is not set
> >> # CONFIG_TWL4030_CORE is not set
> >> # CONFIG_TWL6040_CORE is not set
> >> # CONFIG_MFD_WL1273_CORE is not set
> >> # CONFIG_MFD_LM3533 is not set
> >> # CONFIG_MFD_TQMX86 is not set
> >> CONFIG_MFD_VX855=3Dm
> >> # CONFIG_MFD_ARIZONA_I2C is not set
> >> # CONFIG_MFD_ARIZONA_SPI is not set
> >> # CONFIG_MFD_WM8400 is not set
> >> # CONFIG_MFD_WM831X_I2C is not set
> >> # CONFIG_MFD_WM831X_SPI is not set
> >> # CONFIG_MFD_WM8350_I2C is not set
> >> # CONFIG_MFD_WM8994 is not set
> >> # end of Multifunction device drivers
> >>
> >> # CONFIG_REGULATOR is not set
> >> CONFIG_RC_CORE=3Dm
> >> CONFIG_RC_MAP=3Dm
> >> CONFIG_LIRC=3Dy
> >> CONFIG_RC_DECODERS=3Dy
> >> CONFIG_IR_NEC_DECODER=3Dm
> >> CONFIG_IR_RC5_DECODER=3Dm
> >> CONFIG_IR_RC6_DECODER=3Dm
> >> CONFIG_IR_JVC_DECODER=3Dm
> >> CONFIG_IR_SONY_DECODER=3Dm
> >> CONFIG_IR_SANYO_DECODER=3Dm
> >> # CONFIG_IR_SHARP_DECODER is not set
> >> CONFIG_IR_MCE_KBD_DECODER=3Dm
> >> # CONFIG_IR_XMP_DECODER is not set
> >> CONFIG_IR_IMON_DECODER=3Dm
> >> # CONFIG_IR_RCMM_DECODER is not set
> >> CONFIG_RC_DEVICES=3Dy
> >> # CONFIG_RC_ATI_REMOTE is not set
> >> CONFIG_IR_ENE=3Dm
> >> # CONFIG_IR_IMON is not set
> >> # CONFIG_IR_IMON_RAW is not set
> >> # CONFIG_IR_MCEUSB is not set
> >> CONFIG_IR_ITE_CIR=3Dm
> >> CONFIG_IR_FINTEK=3Dm
> >> CONFIG_IR_NUVOTON=3Dm
> >> # CONFIG_IR_REDRAT3 is not set
> >> # CONFIG_IR_STREAMZAP is not set
> >> CONFIG_IR_WINBOND_CIR=3Dm
> >> # CONFIG_IR_IGORPLUGUSB is not set
> >> # CONFIG_IR_IGUANA is not set
> >> # CONFIG_IR_TTUSBIR is not set
> >> # CONFIG_RC_LOOPBACK is not set
> >> CONFIG_IR_SERIAL=3Dm
> >> CONFIG_IR_SERIAL_TRANSMITTER=3Dy
> >> CONFIG_IR_SIR=3Dm
> >> # CONFIG_RC_XBOX_DVD is not set
> >> # CONFIG_MEDIA_CEC_SUPPORT is not set
> >> # CONFIG_MEDIA_SUPPORT is not set
> >>
> >> #
> >> # Graphics support
> >> #
> >> # CONFIG_AGP is not set
> >> CONFIG_INTEL_GTT=3Dm
> >> CONFIG_VGA_ARB=3Dy
> >> CONFIG_VGA_ARB_MAX_GPUS=3D64
> >> CONFIG_VGA_SWITCHEROO=3Dy
> >> CONFIG_DRM=3Dm
> >> CONFIG_DRM_MIPI_DSI=3Dy
> >> CONFIG_DRM_DP_AUX_CHARDEV=3Dy
> >> # CONFIG_DRM_DEBUG_SELFTEST is not set
> >> CONFIG_DRM_KMS_HELPER=3Dm
> >> CONFIG_DRM_KMS_FB_HELPER=3Dy
> >> CONFIG_DRM_FBDEV_EMULATION=3Dy
> >> CONFIG_DRM_FBDEV_OVERALLOC=3D100
> >> CONFIG_DRM_LOAD_EDID_FIRMWARE=3Dy
> >> # CONFIG_DRM_DP_CEC is not set
> >> CONFIG_DRM_TTM=3Dm
> >> CONFIG_DRM_TTM_DMA_PAGE_POOL=3Dy
> >> CONFIG_DRM_VRAM_HELPER=3Dm
> >> CONFIG_DRM_TTM_HELPER=3Dm
> >> CONFIG_DRM_GEM_SHMEM_HELPER=3Dy
> >>
> >> #
> >> # I2C encoder or helper chips
> >> #
> >> CONFIG_DRM_I2C_CH7006=3Dm
> >> CONFIG_DRM_I2C_SIL164=3Dm
> >> # CONFIG_DRM_I2C_NXP_TDA998X is not set
> >> # CONFIG_DRM_I2C_NXP_TDA9950 is not set
> >> # end of I2C encoder or helper chips
> >>
> >> #
> >> # ARM devices
> >> #
> >> # end of ARM devices
> >>
> >> # CONFIG_DRM_RADEON is not set
> >> # CONFIG_DRM_AMDGPU is not set
> >> # CONFIG_DRM_NOUVEAU is not set
> >> CONFIG_DRM_I915=3Dm
> >> CONFIG_DRM_I915_FORCE_PROBE=3D""
> >> CONFIG_DRM_I915_CAPTURE_ERROR=3Dy
> >> CONFIG_DRM_I915_COMPRESS_ERROR=3Dy
> >> CONFIG_DRM_I915_USERPTR=3Dy
> >> CONFIG_DRM_I915_GVT=3Dy
> >> CONFIG_DRM_I915_GVT_KVMGT=3Dm
> >> CONFIG_DRM_I915_FENCE_TIMEOUT=3D10000
> >> CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=3D250
> >> CONFIG_DRM_I915_HEARTBEAT_INTERVAL=3D2500
> >> CONFIG_DRM_I915_PREEMPT_TIMEOUT=3D640
> >> CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=3D8000
> >> CONFIG_DRM_I915_STOP_TIMEOUT=3D100
> >> CONFIG_DRM_I915_TIMESLICE_DURATION=3D1
> >> CONFIG_DRM_VGEM=3Dm
> >> # CONFIG_DRM_VKMS is not set
> >> CONFIG_DRM_VMWGFX=3Dm
> >> CONFIG_DRM_VMWGFX_FBCON=3Dy
> >> CONFIG_DRM_GMA500=3Dm
> >> CONFIG_DRM_GMA600=3Dy
> >> CONFIG_DRM_GMA3600=3Dy
> >> # CONFIG_DRM_UDL is not set
> >> CONFIG_DRM_AST=3Dm
> >> CONFIG_DRM_MGAG200=3Dm
> >> CONFIG_DRM_QXL=3Dm
> >> CONFIG_DRM_BOCHS=3Dm
> >> CONFIG_DRM_VIRTIO_GPU=3Dm
> >> CONFIG_DRM_PANEL=3Dy
> >>
> >> #
> >> # Display Panels
> >> #
> >> # CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
> >> # end of Display Panels
> >>
> >> CONFIG_DRM_BRIDGE=3Dy
> >> CONFIG_DRM_PANEL_BRIDGE=3Dy
> >>
> >> #
> >> # Display Interface Bridges
> >> #
> >> # CONFIG_DRM_ANALOGIX_ANX78XX is not set
> >> # end of Display Interface Bridges
> >>
> >> # CONFIG_DRM_ETNAVIV is not set
> >> CONFIG_DRM_CIRRUS_QEMU=3Dm
> >> # CONFIG_DRM_GM12U320 is not set
> >> # CONFIG_TINYDRM_HX8357D is not set
> >> # CONFIG_TINYDRM_ILI9225 is not set
> >> # CONFIG_TINYDRM_ILI9341 is not set
> >> # CONFIG_TINYDRM_ILI9486 is not set
> >> # CONFIG_TINYDRM_MI0283QT is not set
> >> # CONFIG_TINYDRM_REPAPER is not set
> >> # CONFIG_TINYDRM_ST7586 is not set
> >> # CONFIG_TINYDRM_ST7735R is not set
> >> # CONFIG_DRM_XEN is not set
> >> # CONFIG_DRM_VBOXVIDEO is not set
> >> # CONFIG_DRM_LEGACY is not set
> >> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=3Dy
> >>
> >> #
> >> # Frame buffer Devices
> >> #
> >> CONFIG_FB_CMDLINE=3Dy
> >> CONFIG_FB_NOTIFY=3Dy
> >> CONFIG_FB=3Dy
> >> # CONFIG_FIRMWARE_EDID is not set
> >> CONFIG_FB_BOOT_VESA_SUPPORT=3Dy
> >> CONFIG_FB_CFB_FILLRECT=3Dy
> >> CONFIG_FB_CFB_COPYAREA=3Dy
> >> CONFIG_FB_CFB_IMAGEBLIT=3Dy
> >> CONFIG_FB_SYS_FILLRECT=3Dm
> >> CONFIG_FB_SYS_COPYAREA=3Dm
> >> CONFIG_FB_SYS_IMAGEBLIT=3Dm
> >> # CONFIG_FB_FOREIGN_ENDIAN is not set
> >> CONFIG_FB_SYS_FOPS=3Dm
> >> CONFIG_FB_DEFERRED_IO=3Dy
> >> # CONFIG_FB_MODE_HELPERS is not set
> >> CONFIG_FB_TILEBLITTING=3Dy
> >>
> >> #
> >> # Frame buffer hardware drivers
> >> #
> >> # CONFIG_FB_CIRRUS is not set
> >> # CONFIG_FB_PM2 is not set
> >> # CONFIG_FB_CYBER2000 is not set
> >> # CONFIG_FB_ARC is not set
> >> # CONFIG_FB_ASILIANT is not set
> >> # CONFIG_FB_IMSTT is not set
> >> # CONFIG_FB_VGA16 is not set
> >> # CONFIG_FB_UVESA is not set
> >> CONFIG_FB_VESA=3Dy
> >> CONFIG_FB_EFI=3Dy
> >> # CONFIG_FB_N411 is not set
> >> # CONFIG_FB_HGA is not set
> >> # CONFIG_FB_OPENCORES is not set
> >> # CONFIG_FB_S1D13XXX is not set
> >> # CONFIG_FB_NVIDIA is not set
> >> # CONFIG_FB_RIVA is not set
> >> # CONFIG_FB_I740 is not set
> >> # CONFIG_FB_LE80578 is not set
> >> # CONFIG_FB_MATROX is not set
> >> # CONFIG_FB_RADEON is not set
> >> # CONFIG_FB_ATY128 is not set
> >> # CONFIG_FB_ATY is not set
> >> # CONFIG_FB_S3 is not set
> >> # CONFIG_FB_SAVAGE is not set
> >> # CONFIG_FB_SIS is not set
> >> # CONFIG_FB_VIA is not set
> >> # CONFIG_FB_NEOMAGIC is not set
> >> # CONFIG_FB_KYRO is not set
> >> # CONFIG_FB_3DFX is not set
> >> # CONFIG_FB_VOODOO1 is not set
> >> # CONFIG_FB_VT8623 is not set
> >> # CONFIG_FB_TRIDENT is not set
> >> # CONFIG_FB_ARK is not set
> >> # CONFIG_FB_PM3 is not set
> >> # CONFIG_FB_CARMINE is not set
> >> # CONFIG_FB_SM501 is not set
> >> # CONFIG_FB_SMSCUFX is not set
> >> # CONFIG_FB_UDL is not set
> >> # CONFIG_FB_IBM_GXT4500 is not set
> >> # CONFIG_FB_VIRTUAL is not set
> >> # CONFIG_XEN_FBDEV_FRONTEND is not set
> >> # CONFIG_FB_METRONOME is not set
> >> # CONFIG_FB_MB862XX is not set
> >> CONFIG_FB_HYPERV=3Dm
> >> # CONFIG_FB_SIMPLE is not set
> >> # CONFIG_FB_SM712 is not set
> >> # end of Frame buffer Devices
> >>
> >> #
> >> # Backlight & LCD device support
> >> #
> >> CONFIG_LCD_CLASS_DEVICE=3Dm
> >> # CONFIG_LCD_L4F00242T03 is not set
> >> # CONFIG_LCD_LMS283GF05 is not set
> >> # CONFIG_LCD_LTV350QV is not set
> >> # CONFIG_LCD_ILI922X is not set
> >> # CONFIG_LCD_ILI9320 is not set
> >> # CONFIG_LCD_TDO24M is not set
> >> # CONFIG_LCD_VGG2432A4 is not set
> >> CONFIG_LCD_PLATFORM=3Dm
> >> # CONFIG_LCD_AMS369FG06 is not set
> >> # CONFIG_LCD_LMS501KF03 is not set
> >> # CONFIG_LCD_HX8357 is not set
> >> # CONFIG_LCD_OTM3225A is not set
> >> CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
> >> # CONFIG_BACKLIGHT_GENERIC is not set
> >> # CONFIG_BACKLIGHT_PWM is not set
> >> CONFIG_BACKLIGHT_APPLE=3Dm
> >> # CONFIG_BACKLIGHT_QCOM_WLED is not set
> >> # CONFIG_BACKLIGHT_SAHARA is not set
> >> # CONFIG_BACKLIGHT_ADP8860 is not set
> >> # CONFIG_BACKLIGHT_ADP8870 is not set
> >> # CONFIG_BACKLIGHT_LM3630A is not set
> >> # CONFIG_BACKLIGHT_LM3639 is not set
> >> CONFIG_BACKLIGHT_LP855X=3Dm
> >> # CONFIG_BACKLIGHT_GPIO is not set
> >> # CONFIG_BACKLIGHT_LV5207LP is not set
> >> # CONFIG_BACKLIGHT_BD6107 is not set
> >> # CONFIG_BACKLIGHT_ARCXCNN is not set
> >> # end of Backlight & LCD device support
> >>
> >> CONFIG_HDMI=3Dy
> >>
> >> #
> >> # Console display driver support
> >> #
> >> CONFIG_VGA_CONSOLE=3Dy
> >> CONFIG_VGACON_SOFT_SCROLLBACK=3Dy
> >> CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=3D64
> >> # CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
> >> CONFIG_DUMMY_CONSOLE=3Dy
> >> CONFIG_DUMMY_CONSOLE_COLUMNS=3D80
> >> CONFIG_DUMMY_CONSOLE_ROWS=3D25
> >> CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> >> CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy
> >> CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
> >> # CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
> >> # end of Console display driver support
> >>
> >> CONFIG_LOGO=3Dy
> >> # CONFIG_LOGO_LINUX_MONO is not set
> >> # CONFIG_LOGO_LINUX_VGA16 is not set
> >> CONFIG_LOGO_LINUX_CLUT224=3Dy
> >> # end of Graphics support
> >>
> >> # CONFIG_SOUND is not set
> >>
> >> #
> >> # HID support
> >> #
> >> CONFIG_HID=3Dy
> >> CONFIG_HID_BATTERY_STRENGTH=3Dy
> >> CONFIG_HIDRAW=3Dy
> >> CONFIG_UHID=3Dm
> >> CONFIG_HID_GENERIC=3Dy
> >>
> >> #
> >> # Special HID drivers
> >> #
> >> CONFIG_HID_A4TECH=3Dm
> >> # CONFIG_HID_ACCUTOUCH is not set
> >> CONFIG_HID_ACRUX=3Dm
> >> # CONFIG_HID_ACRUX_FF is not set
> >> CONFIG_HID_APPLE=3Dm
> >> # CONFIG_HID_APPLEIR is not set
> >> CONFIG_HID_ASUS=3Dm
> >> CONFIG_HID_AUREAL=3Dm
> >> CONFIG_HID_BELKIN=3Dm
> >> # CONFIG_HID_BETOP_FF is not set
> >> # CONFIG_HID_BIGBEN_FF is not set
> >> CONFIG_HID_CHERRY=3Dm
> >> CONFIG_HID_CHICONY=3Dm
> >> # CONFIG_HID_CORSAIR is not set
> >> # CONFIG_HID_COUGAR is not set
> >> # CONFIG_HID_MACALLY is not set
> >> CONFIG_HID_CMEDIA=3Dm
> >> # CONFIG_HID_CP2112 is not set
> >> # CONFIG_HID_CREATIVE_SB0540 is not set
> >> CONFIG_HID_CYPRESS=3Dm
> >> CONFIG_HID_DRAGONRISE=3Dm
> >> # CONFIG_DRAGONRISE_FF is not set
> >> # CONFIG_HID_EMS_FF is not set
> >> # CONFIG_HID_ELAN is not set
> >> CONFIG_HID_ELECOM=3Dm
> >> # CONFIG_HID_ELO is not set
> >> CONFIG_HID_EZKEY=3Dm
> >> CONFIG_HID_GEMBIRD=3Dm
> >> CONFIG_HID_GFRM=3Dm
> >> # CONFIG_HID_GLORIOUS is not set
> >> # CONFIG_HID_HOLTEK is not set
> >> # CONFIG_HID_GT683R is not set
> >> CONFIG_HID_KEYTOUCH=3Dm
> >> CONFIG_HID_KYE=3Dm
> >> # CONFIG_HID_UCLOGIC is not set
> >> CONFIG_HID_WALTOP=3Dm
> >> # CONFIG_HID_VIEWSONIC is not set
> >> CONFIG_HID_GYRATION=3Dm
> >> CONFIG_HID_ICADE=3Dm
> >> CONFIG_HID_ITE=3Dm
> >> CONFIG_HID_JABRA=3Dm
> >> CONFIG_HID_TWINHAN=3Dm
> >> CONFIG_HID_KENSINGTON=3Dm
> >> CONFIG_HID_LCPOWER=3Dm
> >> CONFIG_HID_LED=3Dm
> >> CONFIG_HID_LENOVO=3Dm
> >> CONFIG_HID_LOGITECH=3Dm
> >> CONFIG_HID_LOGITECH_DJ=3Dm
> >> CONFIG_HID_LOGITECH_HIDPP=3Dm
> >> # CONFIG_LOGITECH_FF is not set
> >> # CONFIG_LOGIRUMBLEPAD2_FF is not set
> >> # CONFIG_LOGIG940_FF is not set
> >> # CONFIG_LOGIWHEELS_FF is not set
> >> CONFIG_HID_MAGICMOUSE=3Dy
> >> # CONFIG_HID_MALTRON is not set
> >> # CONFIG_HID_MAYFLASH is not set
> >> # CONFIG_HID_REDRAGON is not set
> >> CONFIG_HID_MICROSOFT=3Dm
> >> CONFIG_HID_MONTEREY=3Dm
> >> CONFIG_HID_MULTITOUCH=3Dm
> >> CONFIG_HID_NTI=3Dm
> >> # CONFIG_HID_NTRIG is not set
> >> CONFIG_HID_ORTEK=3Dm
> >> CONFIG_HID_PANTHERLORD=3Dm
> >> # CONFIG_PANTHERLORD_FF is not set
> >> # CONFIG_HID_PENMOUNT is not set
> >> CONFIG_HID_PETALYNX=3Dm
> >> CONFIG_HID_PICOLCD=3Dm
> >> CONFIG_HID_PICOLCD_FB=3Dy
> >> CONFIG_HID_PICOLCD_BACKLIGHT=3Dy
> >> CONFIG_HID_PICOLCD_LCD=3Dy
> >> CONFIG_HID_PICOLCD_LEDS=3Dy
> >> CONFIG_HID_PICOLCD_CIR=3Dy
> >> CONFIG_HID_PLANTRONICS=3Dm
> >> CONFIG_HID_PRIMAX=3Dm
> >> # CONFIG_HID_RETRODE is not set
> >> # CONFIG_HID_ROCCAT is not set
> >> CONFIG_HID_SAITEK=3Dm
> >> CONFIG_HID_SAMSUNG=3Dm
> >> # CONFIG_HID_SONY is not set
> >> CONFIG_HID_SPEEDLINK=3Dm
> >> # CONFIG_HID_STEAM is not set
> >> CONFIG_HID_STEELSERIES=3Dm
> >> CONFIG_HID_SUNPLUS=3Dm
> >> CONFIG_HID_RMI=3Dm
> >> CONFIG_HID_GREENASIA=3Dm
> >> # CONFIG_GREENASIA_FF is not set
> >> CONFIG_HID_HYPERV_MOUSE=3Dm
> >> CONFIG_HID_SMARTJOYPLUS=3Dm
> >> # CONFIG_SMARTJOYPLUS_FF is not set
> >> CONFIG_HID_TIVO=3Dm
> >> CONFIG_HID_TOPSEED=3Dm
> >> CONFIG_HID_THINGM=3Dm
> >> CONFIG_HID_THRUSTMASTER=3Dm
> >> # CONFIG_THRUSTMASTER_FF is not set
> >> # CONFIG_HID_UDRAW_PS3 is not set
> >> # CONFIG_HID_U2FZERO is not set
> >> # CONFIG_HID_WACOM is not set
> >> CONFIG_HID_WIIMOTE=3Dm
> >> CONFIG_HID_XINMO=3Dm
> >> CONFIG_HID_ZEROPLUS=3Dm
> >> # CONFIG_ZEROPLUS_FF is not set
> >> CONFIG_HID_ZYDACRON=3Dm
> >> CONFIG_HID_SENSOR_HUB=3Dy
> >> CONFIG_HID_SENSOR_CUSTOM_SENSOR=3Dm
> >> CONFIG_HID_ALPS=3Dm
> >> # CONFIG_HID_MCP2221 is not set
> >> # end of Special HID drivers
> >>
> >> #
> >> # USB HID support
> >> #
> >> CONFIG_USB_HID=3Dy
> >> # CONFIG_HID_PID is not set
> >> # CONFIG_USB_HIDDEV is not set
> >> # end of USB HID support
> >>
> >> #
> >> # I2C HID support
> >> #
> >> CONFIG_I2C_HID=3Dm
> >> # end of I2C HID support
> >>
> >> #
> >> # Intel ISH HID support
> >> #
> >> CONFIG_INTEL_ISH_HID=3Dm
> >> # CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
> >> # end of Intel ISH HID support
> >> # end of HID support
> >>
> >> CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
> >> CONFIG_USB_SUPPORT=3Dy
> >> CONFIG_USB_COMMON=3Dy
> >> # CONFIG_USB_LED_TRIG is not set
> >> # CONFIG_USB_ULPI_BUS is not set
> >> # CONFIG_USB_CONN_GPIO is not set
> >> CONFIG_USB_ARCH_HAS_HCD=3Dy
> >> CONFIG_USB=3Dy
> >> CONFIG_USB_PCI=3Dy
> >> CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy
> >>
> >> #
> >> # Miscellaneous USB options
> >> #
> >> CONFIG_USB_DEFAULT_PERSIST=3Dy
> >> # CONFIG_USB_DYNAMIC_MINORS is not set
> >> # CONFIG_USB_OTG is not set
> >> # CONFIG_USB_OTG_WHITELIST is not set
> >> CONFIG_USB_LEDS_TRIGGER_USBPORT=3Dy
> >> CONFIG_USB_AUTOSUSPEND_DELAY=3D2
> >> CONFIG_USB_MON=3Dy
> >>
> >> #
> >> # USB Host Controller Drivers
> >> #
> >> # CONFIG_USB_C67X00_HCD is not set
> >> CONFIG_USB_XHCI_HCD=3Dy
> >> # CONFIG_USB_XHCI_DBGCAP is not set
> >> CONFIG_USB_XHCI_PCI=3Dy
> >> # CONFIG_USB_XHCI_PCI_RENESAS is not set
> >> # CONFIG_USB_XHCI_PLATFORM is not set
> >> CONFIG_USB_EHCI_HCD=3Dy
> >> CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
> >> CONFIG_USB_EHCI_TT_NEWSCHED=3Dy
> >> CONFIG_USB_EHCI_PCI=3Dy
> >> # CONFIG_USB_EHCI_FSL is not set
> >> # CONFIG_USB_EHCI_HCD_PLATFORM is not set
> >> # CONFIG_USB_OXU210HP_HCD is not set
> >> # CONFIG_USB_ISP116X_HCD is not set
> >> # CONFIG_USB_FOTG210_HCD is not set
> >> # CONFIG_USB_MAX3421_HCD is not set
> >> CONFIG_USB_OHCI_HCD=3Dy
> >> CONFIG_USB_OHCI_HCD_PCI=3Dy
> >> # CONFIG_USB_OHCI_HCD_PLATFORM is not set
> >> CONFIG_USB_UHCI_HCD=3Dy
> >> # CONFIG_USB_SL811_HCD is not set
> >> # CONFIG_USB_R8A66597_HCD is not set
> >> # CONFIG_USB_HCD_BCMA is not set
> >> # CONFIG_USB_HCD_TEST_MODE is not set
> >>
> >> #
> >> # USB Device Class drivers
> >> #
> >> # CONFIG_USB_ACM is not set
> >> # CONFIG_USB_PRINTER is not set
> >> # CONFIG_USB_WDM is not set
> >> # CONFIG_USB_TMC is not set
> >>
> >> #
> >> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> >> #
> >>
> >> #
> >> # also be needed; see USB_STORAGE Help for more info
> >> #
> >> CONFIG_USB_STORAGE=3Dm
> >> # CONFIG_USB_STORAGE_DEBUG is not set
> >> # CONFIG_USB_STORAGE_REALTEK is not set
> >> # CONFIG_USB_STORAGE_DATAFAB is not set
> >> # CONFIG_USB_STORAGE_FREECOM is not set
> >> # CONFIG_USB_STORAGE_ISD200 is not set
> >> # CONFIG_USB_STORAGE_USBAT is not set
> >> # CONFIG_USB_STORAGE_SDDR09 is not set
> >> # CONFIG_USB_STORAGE_SDDR55 is not set
> >> # CONFIG_USB_STORAGE_JUMPSHOT is not set
> >> # CONFIG_USB_STORAGE_ALAUDA is not set
> >> # CONFIG_USB_STORAGE_ONETOUCH is not set
> >> # CONFIG_USB_STORAGE_KARMA is not set
> >> # CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
> >> # CONFIG_USB_STORAGE_ENE_UB6250 is not set
> >> # CONFIG_USB_UAS is not set
> >>
> >> #
> >> # USB Imaging devices
> >> #
> >> # CONFIG_USB_MDC800 is not set
> >> # CONFIG_USB_MICROTEK is not set
> >> # CONFIG_USBIP_CORE is not set
> >> # CONFIG_USB_CDNS3 is not set
> >> # CONFIG_USB_MUSB_HDRC is not set
> >> # CONFIG_USB_DWC3 is not set
> >> # CONFIG_USB_DWC2 is not set
> >> # CONFIG_USB_CHIPIDEA is not set
> >> # CONFIG_USB_ISP1760 is not set
> >>
> >> #
> >> # USB port drivers
> >> #
> >> # CONFIG_USB_USS720 is not set
> >> CONFIG_USB_SERIAL=3Dm
> >> CONFIG_USB_SERIAL_GENERIC=3Dy
> >> # CONFIG_USB_SERIAL_SIMPLE is not set
> >> # CONFIG_USB_SERIAL_AIRCABLE is not set
> >> # CONFIG_USB_SERIAL_ARK3116 is not set
> >> # CONFIG_USB_SERIAL_BELKIN is not set
> >> # CONFIG_USB_SERIAL_CH341 is not set
> >> # CONFIG_USB_SERIAL_WHITEHEAT is not set
> >> # CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
> >> # CONFIG_USB_SERIAL_CP210X is not set
> >> # CONFIG_USB_SERIAL_CYPRESS_M8 is not set
> >> # CONFIG_USB_SERIAL_EMPEG is not set
> >> # CONFIG_USB_SERIAL_FTDI_SIO is not set
> >> # CONFIG_USB_SERIAL_VISOR is not set
> >> # CONFIG_USB_SERIAL_IPAQ is not set
> >> # CONFIG_USB_SERIAL_IR is not set
> >> # CONFIG_USB_SERIAL_EDGEPORT is not set
> >> # CONFIG_USB_SERIAL_EDGEPORT_TI is not set
> >> # CONFIG_USB_SERIAL_F81232 is not set
> >> # CONFIG_USB_SERIAL_F8153X is not set
> >> # CONFIG_USB_SERIAL_GARMIN is not set
> >> # CONFIG_USB_SERIAL_IPW is not set
> >> # CONFIG_USB_SERIAL_IUU is not set
> >> # CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
> >> # CONFIG_USB_SERIAL_KEYSPAN is not set
> >> # CONFIG_USB_SERIAL_KLSI is not set
> >> # CONFIG_USB_SERIAL_KOBIL_SCT is not set
> >> # CONFIG_USB_SERIAL_MCT_U232 is not set
> >> # CONFIG_USB_SERIAL_METRO is not set
> >> # CONFIG_USB_SERIAL_MOS7720 is not set
> >> # CONFIG_USB_SERIAL_MOS7840 is not set
> >> # CONFIG_USB_SERIAL_MXUPORT is not set
> >> # CONFIG_USB_SERIAL_NAVMAN is not set
> >> # CONFIG_USB_SERIAL_PL2303 is not set
> >> # CONFIG_USB_SERIAL_OTI6858 is not set
> >> # CONFIG_USB_SERIAL_QCAUX is not set
> >> # CONFIG_USB_SERIAL_QUALCOMM is not set
> >> # CONFIG_USB_SERIAL_SPCP8X5 is not set
> >> # CONFIG_USB_SERIAL_SAFE is not set
> >> # CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
> >> # CONFIG_USB_SERIAL_SYMBOL is not set
> >> # CONFIG_USB_SERIAL_TI is not set
> >> # CONFIG_USB_SERIAL_CYBERJACK is not set
> >> # CONFIG_USB_SERIAL_XIRCOM is not set
> >> # CONFIG_USB_SERIAL_OPTION is not set
> >> # CONFIG_USB_SERIAL_OMNINET is not set
> >> # CONFIG_USB_SERIAL_OPTICON is not set
> >> # CONFIG_USB_SERIAL_XSENS_MT is not set
> >> # CONFIG_USB_SERIAL_WISHBONE is not set
> >> # CONFIG_USB_SERIAL_SSU100 is not set
> >> # CONFIG_USB_SERIAL_QT2 is not set
> >> # CONFIG_USB_SERIAL_UPD78F0730 is not set
> >> CONFIG_USB_SERIAL_DEBUG=3Dm
> >>
> >> #
> >> # USB Miscellaneous drivers
> >> #
> >> # CONFIG_USB_EMI62 is not set
> >> # CONFIG_USB_EMI26 is not set
> >> # CONFIG_USB_ADUTUX is not set
> >> # CONFIG_USB_SEVSEG is not set
> >> # CONFIG_USB_LEGOTOWER is not set
> >> # CONFIG_USB_LCD is not set
> >> # CONFIG_USB_CYPRESS_CY7C63 is not set
> >> # CONFIG_USB_CYTHERM is not set
> >> # CONFIG_USB_IDMOUSE is not set
> >> # CONFIG_USB_FTDI_ELAN is not set
> >> # CONFIG_USB_APPLEDISPLAY is not set
> >> # CONFIG_APPLE_MFI_FASTCHARGE is not set
> >> # CONFIG_USB_SISUSBVGA is not set
> >> # CONFIG_USB_LD is not set
> >> # CONFIG_USB_TRANCEVIBRATOR is not set
> >> # CONFIG_USB_IOWARRIOR is not set
> >> # CONFIG_USB_TEST is not set
> >> # CONFIG_USB_EHSET_TEST_FIXTURE is not set
> >> # CONFIG_USB_ISIGHTFW is not set
> >> # CONFIG_USB_YUREX is not set
> >> # CONFIG_USB_EZUSB_FX2 is not set
> >> # CONFIG_USB_HUB_USB251XB is not set
> >> # CONFIG_USB_HSIC_USB3503 is not set
> >> # CONFIG_USB_HSIC_USB4604 is not set
> >> # CONFIG_USB_LINK_LAYER_TEST is not set
> >> # CONFIG_USB_CHAOSKEY is not set
> >> # CONFIG_USB_ATM is not set
> >>
> >> #
> >> # USB Physical Layer drivers
> >> #
> >> # CONFIG_NOP_USB_XCEIV is not set
> >> # CONFIG_USB_GPIO_VBUS is not set
> >> # CONFIG_USB_ISP1301 is not set
> >> # end of USB Physical Layer drivers
> >>
> >> # CONFIG_USB_GADGET is not set
> >> CONFIG_TYPEC=3Dy
> >> # CONFIG_TYPEC_TCPM is not set
> >> CONFIG_TYPEC_UCSI=3Dy
> >> # CONFIG_UCSI_CCG is not set
> >> CONFIG_UCSI_ACPI=3Dy
> >> # CONFIG_TYPEC_TPS6598X is not set
> >>
> >> #
> >> # USB Type-C Multiplexer/DeMultiplexer Switch support
> >> #
> >> # CONFIG_TYPEC_MUX_PI3USB30532 is not set
> >> # end of USB Type-C Multiplexer/DeMultiplexer Switch support
> >>
> >> #
> >> # USB Type-C Alternate Mode drivers
> >> #
> >> # CONFIG_TYPEC_DP_ALTMODE is not set
> >> # end of USB Type-C Alternate Mode drivers
> >>
> >> # CONFIG_USB_ROLE_SWITCH is not set
> >> CONFIG_MMC=3Dm
> >> CONFIG_MMC_BLOCK=3Dm
> >> CONFIG_MMC_BLOCK_MINORS=3D8
> >> CONFIG_SDIO_UART=3Dm
> >> # CONFIG_MMC_TEST is not set
> >>
> >> #
> >> # MMC/SD/SDIO Host Controller Drivers
> >> #
> >> # CONFIG_MMC_DEBUG is not set
> >> CONFIG_MMC_SDHCI=3Dm
> >> CONFIG_MMC_SDHCI_IO_ACCESSORS=3Dy
> >> CONFIG_MMC_SDHCI_PCI=3Dm
> >> CONFIG_MMC_RICOH_MMC=3Dy
> >> CONFIG_MMC_SDHCI_ACPI=3Dm
> >> CONFIG_MMC_SDHCI_PLTFM=3Dm
> >> # CONFIG_MMC_SDHCI_F_SDH30 is not set
> >> # CONFIG_MMC_WBSD is not set
> >> # CONFIG_MMC_TIFM_SD is not set
> >> # CONFIG_MMC_SPI is not set
> >> # CONFIG_MMC_CB710 is not set
> >> # CONFIG_MMC_VIA_SDMMC is not set
> >> # CONFIG_MMC_VUB300 is not set
> >> # CONFIG_MMC_USHC is not set
> >> # CONFIG_MMC_USDHI6ROL0 is not set
> >> # CONFIG_MMC_REALTEK_PCI is not set
> >> CONFIG_MMC_CQHCI=3Dm
> >> # CONFIG_MMC_HSQ is not set
> >> # CONFIG_MMC_TOSHIBA_PCI is not set
> >> # CONFIG_MMC_MTK is not set
> >> # CONFIG_MMC_SDHCI_XENON is not set
> >> # CONFIG_MEMSTICK is not set
> >> CONFIG_NEW_LEDS=3Dy
> >> CONFIG_LEDS_CLASS=3Dy
> >> # CONFIG_LEDS_CLASS_FLASH is not set
> >> # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
> >>
> >> #
> >> # LED drivers
> >> #
> >> # CONFIG_LEDS_APU is not set
> >> CONFIG_LEDS_LM3530=3Dm
> >> # CONFIG_LEDS_LM3532 is not set
> >> # CONFIG_LEDS_LM3642 is not set
> >> # CONFIG_LEDS_PCA9532 is not set
> >> # CONFIG_LEDS_GPIO is not set
> >> CONFIG_LEDS_LP3944=3Dm
> >> # CONFIG_LEDS_LP3952 is not set
> >> CONFIG_LEDS_LP55XX_COMMON=3Dm
> >> CONFIG_LEDS_LP5521=3Dm
> >> CONFIG_LEDS_LP5523=3Dm
> >> CONFIG_LEDS_LP5562=3Dm
> >> # CONFIG_LEDS_LP8501 is not set
> >> CONFIG_LEDS_CLEVO_MAIL=3Dm
> >> # CONFIG_LEDS_PCA955X is not set
> >> # CONFIG_LEDS_PCA963X is not set
> >> # CONFIG_LEDS_DAC124S085 is not set
> >> # CONFIG_LEDS_PWM is not set
> >> # CONFIG_LEDS_BD2802 is not set
> >> CONFIG_LEDS_INTEL_SS4200=3Dm
> >> # CONFIG_LEDS_TCA6507 is not set
> >> # CONFIG_LEDS_TLC591XX is not set
> >> # CONFIG_LEDS_LM355x is not set
> >>
> >> #
> >> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HI=
D_THINGM)
> >> #
> >> CONFIG_LEDS_BLINKM=3Dm
> >> CONFIG_LEDS_MLXCPLD=3Dm
> >> # CONFIG_LEDS_MLXREG is not set
> >> # CONFIG_LEDS_USER is not set
> >> # CONFIG_LEDS_NIC78BX is not set
> >> # CONFIG_LEDS_TI_LMU_COMMON is not set
> >>
> >> #
> >> # LED Triggers
> >> #
> >> CONFIG_LEDS_TRIGGERS=3Dy
> >> CONFIG_LEDS_TRIGGER_TIMER=3Dm
> >> CONFIG_LEDS_TRIGGER_ONESHOT=3Dm
> >> # CONFIG_LEDS_TRIGGER_DISK is not set
> >> CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dm
> >> CONFIG_LEDS_TRIGGER_BACKLIGHT=3Dm
> >> # CONFIG_LEDS_TRIGGER_CPU is not set
> >> # CONFIG_LEDS_TRIGGER_ACTIVITY is not set
> >> CONFIG_LEDS_TRIGGER_GPIO=3Dm
> >> CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dm
> >>
> >> #
> >> # iptables trigger is under Netfilter config (LED target)
> >> #
> >> CONFIG_LEDS_TRIGGER_TRANSIENT=3Dm
> >> CONFIG_LEDS_TRIGGER_CAMERA=3Dm
> >> # CONFIG_LEDS_TRIGGER_PANIC is not set
> >> # CONFIG_LEDS_TRIGGER_NETDEV is not set
> >> # CONFIG_LEDS_TRIGGER_PATTERN is not set
> >> CONFIG_LEDS_TRIGGER_AUDIO=3Dm
> >> # CONFIG_ACCESSIBILITY is not set
> >> CONFIG_INFINIBAND=3Dm
> >> CONFIG_INFINIBAND_USER_MAD=3Dm
> >> CONFIG_INFINIBAND_USER_ACCESS=3Dm
> >> # CONFIG_INFINIBAND_EXP_LEGACY_VERBS_NEW_UAPI is not set
> >> CONFIG_INFINIBAND_USER_MEM=3Dy
> >> CONFIG_INFINIBAND_ON_DEMAND_PAGING=3Dy
> >> CONFIG_INFINIBAND_ADDR_TRANS=3Dy
> >> CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=3Dy
> >> # CONFIG_INFINIBAND_MTHCA is not set
> >> # CONFIG_INFINIBAND_EFA is not set
> >> # CONFIG_INFINIBAND_I40IW is not set
> >> # CONFIG_MLX4_INFINIBAND is not set
> >> # CONFIG_INFINIBAND_OCRDMA is not set
> >> # CONFIG_INFINIBAND_USNIC is not set
> >> # CONFIG_INFINIBAND_BNXT_RE is not set
> >> # CONFIG_INFINIBAND_RDMAVT is not set
> >> CONFIG_RDMA_RXE=3Dm
> >> CONFIG_RDMA_SIW=3Dm
> >> CONFIG_INFINIBAND_IPOIB=3Dm
> >> # CONFIG_INFINIBAND_IPOIB_CM is not set
> >> CONFIG_INFINIBAND_IPOIB_DEBUG=3Dy
> >> # CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
> >> CONFIG_INFINIBAND_SRP=3Dm
> >> CONFIG_INFINIBAND_SRPT=3Dm
> >> # CONFIG_INFINIBAND_ISER is not set
> >> # CONFIG_INFINIBAND_ISERT is not set
> >> # CONFIG_INFINIBAND_RTRS_CLIENT is not set
> >> # CONFIG_INFINIBAND_RTRS_SERVER is not set
> >> # CONFIG_INFINIBAND_OPA_VNIC is not set
> >> CONFIG_EDAC_ATOMIC_SCRUB=3Dy
> >> CONFIG_EDAC_SUPPORT=3Dy
> >> CONFIG_EDAC=3Dy
> >> CONFIG_EDAC_LEGACY_SYSFS=3Dy
> >> # CONFIG_EDAC_DEBUG is not set
> >> CONFIG_EDAC_DECODE_MCE=3Dm
> >> CONFIG_EDAC_GHES=3Dy
> >> CONFIG_EDAC_AMD64=3Dm
> >> # CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
> >> CONFIG_EDAC_E752X=3Dm
> >> CONFIG_EDAC_I82975X=3Dm
> >> CONFIG_EDAC_I3000=3Dm
> >> CONFIG_EDAC_I3200=3Dm
> >> CONFIG_EDAC_IE31200=3Dm
> >> CONFIG_EDAC_X38=3Dm
> >> CONFIG_EDAC_I5400=3Dm
> >> CONFIG_EDAC_I7CORE=3Dm
> >> CONFIG_EDAC_I5000=3Dm
> >> CONFIG_EDAC_I5100=3Dm
> >> CONFIG_EDAC_I7300=3Dm
> >> CONFIG_EDAC_SBRIDGE=3Dm
> >> CONFIG_EDAC_SKX=3Dm
> >> # CONFIG_EDAC_I10NM is not set
> >> CONFIG_EDAC_PND2=3Dm
> >> CONFIG_RTC_LIB=3Dy
> >> CONFIG_RTC_MC146818_LIB=3Dy
> >> CONFIG_RTC_CLASS=3Dy
> >> CONFIG_RTC_HCTOSYS=3Dy
> >> CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
> >> # CONFIG_RTC_SYSTOHC is not set
> >> # CONFIG_RTC_DEBUG is not set
> >> CONFIG_RTC_NVMEM=3Dy
> >>
> >> #
> >> # RTC interfaces
> >> #
> >> CONFIG_RTC_INTF_SYSFS=3Dy
> >> CONFIG_RTC_INTF_PROC=3Dy
> >> CONFIG_RTC_INTF_DEV=3Dy
> >> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> >> # CONFIG_RTC_DRV_TEST is not set
> >>
> >> #
> >> # I2C RTC drivers
> >> #
> >> # CONFIG_RTC_DRV_ABB5ZES3 is not set
> >> # CONFIG_RTC_DRV_ABEOZ9 is not set
> >> # CONFIG_RTC_DRV_ABX80X is not set
> >> CONFIG_RTC_DRV_DS1307=3Dm
> >> # CONFIG_RTC_DRV_DS1307_CENTURY is not set
> >> CONFIG_RTC_DRV_DS1374=3Dm
> >> # CONFIG_RTC_DRV_DS1374_WDT is not set
> >> CONFIG_RTC_DRV_DS1672=3Dm
> >> CONFIG_RTC_DRV_MAX6900=3Dm
> >> CONFIG_RTC_DRV_RS5C372=3Dm
> >> CONFIG_RTC_DRV_ISL1208=3Dm
> >> CONFIG_RTC_DRV_ISL12022=3Dm
> >> CONFIG_RTC_DRV_X1205=3Dm
> >> CONFIG_RTC_DRV_PCF8523=3Dm
> >> # CONFIG_RTC_DRV_PCF85063 is not set
> >> # CONFIG_RTC_DRV_PCF85363 is not set
> >> CONFIG_RTC_DRV_PCF8563=3Dm
> >> CONFIG_RTC_DRV_PCF8583=3Dm
> >> CONFIG_RTC_DRV_M41T80=3Dm
> >> CONFIG_RTC_DRV_M41T80_WDT=3Dy
> >> CONFIG_RTC_DRV_BQ32K=3Dm
> >> # CONFIG_RTC_DRV_S35390A is not set
> >> CONFIG_RTC_DRV_FM3130=3Dm
> >> # CONFIG_RTC_DRV_RX8010 is not set
> >> CONFIG_RTC_DRV_RX8581=3Dm
> >> CONFIG_RTC_DRV_RX8025=3Dm
> >> CONFIG_RTC_DRV_EM3027=3Dm
> >> # CONFIG_RTC_DRV_RV3028 is not set
> >> # CONFIG_RTC_DRV_RV8803 is not set
> >> # CONFIG_RTC_DRV_SD3078 is not set
> >>
> >> #
> >> # SPI RTC drivers
> >> #
> >> # CONFIG_RTC_DRV_M41T93 is not set
> >> # CONFIG_RTC_DRV_M41T94 is not set
> >> # CONFIG_RTC_DRV_DS1302 is not set
> >> # CONFIG_RTC_DRV_DS1305 is not set
> >> # CONFIG_RTC_DRV_DS1343 is not set
> >> # CONFIG_RTC_DRV_DS1347 is not set
> >> # CONFIG_RTC_DRV_DS1390 is not set
> >> # CONFIG_RTC_DRV_MAX6916 is not set
> >> # CONFIG_RTC_DRV_R9701 is not set
> >> CONFIG_RTC_DRV_RX4581=3Dm
> >> # CONFIG_RTC_DRV_RX6110 is not set
> >> # CONFIG_RTC_DRV_RS5C348 is not set
> >> # CONFIG_RTC_DRV_MAX6902 is not set
> >> # CONFIG_RTC_DRV_PCF2123 is not set
> >> # CONFIG_RTC_DRV_MCP795 is not set
> >> CONFIG_RTC_I2C_AND_SPI=3Dy
> >>
> >> #
> >> # SPI and I2C RTC drivers
> >> #
> >> CONFIG_RTC_DRV_DS3232=3Dm
> >> CONFIG_RTC_DRV_DS3232_HWMON=3Dy
> >> # CONFIG_RTC_DRV_PCF2127 is not set
> >> CONFIG_RTC_DRV_RV3029C2=3Dm
> >> # CONFIG_RTC_DRV_RV3029_HWMON is not set
> >>
> >> #
> >> # Platform RTC drivers
> >> #
> >> CONFIG_RTC_DRV_CMOS=3Dy
> >> CONFIG_RTC_DRV_DS1286=3Dm
> >> CONFIG_RTC_DRV_DS1511=3Dm
> >> CONFIG_RTC_DRV_DS1553=3Dm
> >> # CONFIG_RTC_DRV_DS1685_FAMILY is not set
> >> CONFIG_RTC_DRV_DS1742=3Dm
> >> CONFIG_RTC_DRV_DS2404=3Dm
> >> CONFIG_RTC_DRV_STK17TA8=3Dm
> >> # CONFIG_RTC_DRV_M48T86 is not set
> >> CONFIG_RTC_DRV_M48T35=3Dm
> >> CONFIG_RTC_DRV_M48T59=3Dm
> >> CONFIG_RTC_DRV_MSM6242=3Dm
> >> CONFIG_RTC_DRV_BQ4802=3Dm
> >> CONFIG_RTC_DRV_RP5C01=3Dm
> >> CONFIG_RTC_DRV_V3020=3Dm
> >>
> >> #
> >> # on-CPU RTC drivers
> >> #
> >> # CONFIG_RTC_DRV_FTRTC010 is not set
> >>
> >> #
> >> # HID Sensor RTC drivers
> >> #
> >> CONFIG_DMADEVICES=3Dy
> >> # CONFIG_DMADEVICES_DEBUG is not set
> >>
> >> #
> >> # DMA Devices
> >> #
> >> CONFIG_DMA_ENGINE=3Dy
> >> CONFIG_DMA_VIRTUAL_CHANNELS=3Dy
> >> CONFIG_DMA_ACPI=3Dy
> >> # CONFIG_ALTERA_MSGDMA is not set
> >> CONFIG_INTEL_IDMA64=3Dm
> >> # CONFIG_INTEL_IDXD is not set
> >> CONFIG_INTEL_IOATDMA=3Dm
> >> # CONFIG_PLX_DMA is not set
> >> # CONFIG_QCOM_HIDMA_MGMT is not set
> >> # CONFIG_QCOM_HIDMA is not set
> >> CONFIG_DW_DMAC_CORE=3Dy
> >> CONFIG_DW_DMAC=3Dm
> >> CONFIG_DW_DMAC_PCI=3Dy
> >> # CONFIG_DW_EDMA is not set
> >> # CONFIG_DW_EDMA_PCIE is not set
> >> CONFIG_HSU_DMA=3Dy
> >> # CONFIG_SF_PDMA is not set
> >>
> >> #
> >> # DMA Clients
> >> #
> >> CONFIG_ASYNC_TX_DMA=3Dy
> >> CONFIG_DMATEST=3Dm
> >> CONFIG_DMA_ENGINE_RAID=3Dy
> >>
> >> #
> >> # DMABUF options
> >> #
> >> CONFIG_SYNC_FILE=3Dy
> >> # CONFIG_SW_SYNC is not set
> >> # CONFIG_UDMABUF is not set
> >> # CONFIG_DMABUF_MOVE_NOTIFY is not set
> >> # CONFIG_DMABUF_SELFTESTS is not set
> >> # CONFIG_DMABUF_HEAPS is not set
> >> # end of DMABUF options
> >>
> >> CONFIG_DCA=3Dm
> >> # CONFIG_AUXDISPLAY is not set
> >> # CONFIG_PANEL is not set
> >> CONFIG_UIO=3Dm
> >> CONFIG_UIO_CIF=3Dm
> >> CONFIG_UIO_PDRV_GENIRQ=3Dm
> >> # CONFIG_UIO_DMEM_GENIRQ is not set
> >> CONFIG_UIO_AEC=3Dm
> >> CONFIG_UIO_SERCOS3=3Dm
> >> CONFIG_UIO_PCI_GENERIC=3Dm
> >> # CONFIG_UIO_NETX is not set
> >> # CONFIG_UIO_PRUSS is not set
> >> # CONFIG_UIO_MF624 is not set
> >> CONFIG_UIO_HV_GENERIC=3Dm
> >> CONFIG_VFIO_IOMMU_TYPE1=3Dm
> >> CONFIG_VFIO_VIRQFD=3Dm
> >> CONFIG_VFIO=3Dm
> >> CONFIG_VFIO_NOIOMMU=3Dy
> >> CONFIG_VFIO_PCI=3Dm
> >> # CONFIG_VFIO_PCI_VGA is not set
> >> CONFIG_VFIO_PCI_MMAP=3Dy
> >> CONFIG_VFIO_PCI_INTX=3Dy
> >> # CONFIG_VFIO_PCI_IGD is not set
> >> CONFIG_VFIO_MDEV=3Dm
> >> CONFIG_VFIO_MDEV_DEVICE=3Dm
> >> CONFIG_IRQ_BYPASS_MANAGER=3Dm
> >> # CONFIG_VIRT_DRIVERS is not set
> >> CONFIG_VIRTIO=3Dy
> >> CONFIG_VIRTIO_MENU=3Dy
> >> CONFIG_VIRTIO_PCI=3Dy
> >> CONFIG_VIRTIO_PCI_LEGACY=3Dy
> >> # CONFIG_VIRTIO_PMEM is not set
> >> CONFIG_VIRTIO_BALLOON=3Dy
> >> CONFIG_VIRTIO_MEM=3Dm
> >> CONFIG_VIRTIO_INPUT=3Dm
> >> # CONFIG_VIRTIO_MMIO is not set
> >> # CONFIG_VDPA is not set
> >> CONFIG_VHOST_IOTLB=3Dm
> >> CONFIG_VHOST=3Dm
> >> CONFIG_VHOST_MENU=3Dy
> >> CONFIG_VHOST_NET=3Dm
> >> # CONFIG_VHOST_SCSI is not set
> >> CONFIG_VHOST_VSOCK=3Dm
> >> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
> >>
> >> #
> >> # Microsoft Hyper-V guest support
> >> #
> >> CONFIG_HYPERV=3Dm
> >> CONFIG_HYPERV_TIMER=3Dy
> >> CONFIG_HYPERV_UTILS=3Dm
> >> CONFIG_HYPERV_BALLOON=3Dm
> >> # end of Microsoft Hyper-V guest support
> >>
> >> #
> >> # Xen driver support
> >> #
> >> # CONFIG_XEN_BALLOON is not set
> >> CONFIG_XEN_DEV_EVTCHN=3Dm
> >> # CONFIG_XEN_BACKEND is not set
> >> CONFIG_XENFS=3Dm
> >> CONFIG_XEN_COMPAT_XENFS=3Dy
> >> CONFIG_XEN_SYS_HYPERVISOR=3Dy
> >> CONFIG_XEN_XENBUS_FRONTEND=3Dy
> >> # CONFIG_XEN_GNTDEV is not set
> >> # CONFIG_XEN_GRANT_DEV_ALLOC is not set
> >> # CONFIG_XEN_GRANT_DMA_ALLOC is not set
> >> CONFIG_SWIOTLB_XEN=3Dy
> >> # CONFIG_XEN_PVCALLS_FRONTEND is not set
> >> CONFIG_XEN_PRIVCMD=3Dm
> >> CONFIG_XEN_EFI=3Dy
> >> CONFIG_XEN_AUTO_XLATE=3Dy
> >> CONFIG_XEN_ACPI=3Dy
> >> # end of Xen driver support
> >>
> >> # CONFIG_GREYBUS is not set
> >> # CONFIG_STAGING is not set
> >> CONFIG_X86_PLATFORM_DEVICES=3Dy
> >> CONFIG_ACPI_WMI=3Dm
> >> CONFIG_WMI_BMOF=3Dm
> >> # CONFIG_ALIENWARE_WMI is not set
> >> # CONFIG_HUAWEI_WMI is not set
> >> # CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
> >> CONFIG_INTEL_WMI_THUNDERBOLT=3Dm
> >> CONFIG_MXM_WMI=3Dm
> >> # CONFIG_PEAQ_WMI is not set
> >> # CONFIG_XIAOMI_WMI is not set
> >> CONFIG_ACERHDF=3Dm
> >> # CONFIG_ACER_WIRELESS is not set
> >> CONFIG_ACER_WMI=3Dm
> >> CONFIG_APPLE_GMUX=3Dm
> >> CONFIG_ASUS_LAPTOP=3Dm
> >> # CONFIG_ASUS_WIRELESS is not set
> >> CONFIG_ASUS_WMI=3Dm
> >> CONFIG_ASUS_NB_WMI=3Dm
> >> CONFIG_EEEPC_LAPTOP=3Dm
> >> CONFIG_EEEPC_WMI=3Dm
> >> CONFIG_DCDBAS=3Dm
> >> CONFIG_DELL_SMBIOS=3Dm
> >> CONFIG_DELL_SMBIOS_WMI=3Dy
> >> # CONFIG_DELL_SMBIOS_SMM is not set
> >> CONFIG_DELL_LAPTOP=3Dm
> >> CONFIG_DELL_RBTN=3Dm
> >> CONFIG_DELL_RBU=3Dm
> >> CONFIG_DELL_SMO8800=3Dm
> >> CONFIG_DELL_WMI=3Dm
> >> CONFIG_DELL_WMI_DESCRIPTOR=3Dm
> >> CONFIG_DELL_WMI_AIO=3Dm
> >> CONFIG_DELL_WMI_LED=3Dm
> >> CONFIG_AMILO_RFKILL=3Dm
> >> CONFIG_FUJITSU_LAPTOP=3Dm
> >> CONFIG_FUJITSU_TABLET=3Dm
> >> # CONFIG_GPD_POCKET_FAN is not set
> >> CONFIG_HP_ACCEL=3Dm
> >> CONFIG_HP_WIRELESS=3Dm
> >> CONFIG_HP_WMI=3Dm
> >> # CONFIG_IBM_RTL is not set
> >> CONFIG_IDEAPAD_LAPTOP=3Dm
> >> CONFIG_SENSORS_HDAPS=3Dm
> >> CONFIG_THINKPAD_ACPI=3Dm
> >> # CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
> >> # CONFIG_THINKPAD_ACPI_DEBUG is not set
> >> # CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
> >> CONFIG_THINKPAD_ACPI_VIDEO=3Dy
> >> CONFIG_THINKPAD_ACPI_HOTKEY_POLL=3Dy
> >> # CONFIG_INTEL_ATOMISP2_PM is not set
> >> CONFIG_INTEL_HID_EVENT=3Dm
> >> # CONFIG_INTEL_INT0002_VGPIO is not set
> >> # CONFIG_INTEL_MENLOW is not set
> >> CONFIG_INTEL_OAKTRAIL=3Dm
> >> CONFIG_INTEL_VBTN=3Dm
> >> # CONFIG_SURFACE3_WMI is not set
> >> # CONFIG_SURFACE_3_POWER_OPREGION is not set
> >> # CONFIG_SURFACE_PRO3_BUTTON is not set
> >> CONFIG_MSI_LAPTOP=3Dm
> >> CONFIG_MSI_WMI=3Dm
> >> # CONFIG_PCENGINES_APU2 is not set
> >> CONFIG_SAMSUNG_LAPTOP=3Dm
> >> CONFIG_SAMSUNG_Q10=3Dm
> >> CONFIG_TOSHIBA_BT_RFKILL=3Dm
> >> # CONFIG_TOSHIBA_HAPS is not set
> >> # CONFIG_TOSHIBA_WMI is not set
> >> CONFIG_ACPI_CMPC=3Dm
> >> CONFIG_COMPAL_LAPTOP=3Dm
> >> # CONFIG_LG_LAPTOP is not set
> >> CONFIG_PANASONIC_LAPTOP=3Dm
> >> CONFIG_SONY_LAPTOP=3Dm
> >> CONFIG_SONYPI_COMPAT=3Dy
> >> # CONFIG_SYSTEM76_ACPI is not set
> >> CONFIG_TOPSTAR_LAPTOP=3Dm
> >> # CONFIG_I2C_MULTI_INSTANTIATE is not set
> >> CONFIG_MLX_PLATFORM=3Dm
> >> CONFIG_INTEL_IPS=3Dm
> >> CONFIG_INTEL_RST=3Dm
> >> # CONFIG_INTEL_SMARTCONNECT is not set
> >>
> >> #
> >> # Intel Speed Select Technology interface support
> >> #
> >> # CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
> >> # end of Intel Speed Select Technology interface support
> >>
> >> CONFIG_INTEL_TURBO_MAX_3=3Dy
> >> # CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
> >> CONFIG_INTEL_PMC_CORE=3Dm
> >> # CONFIG_INTEL_PUNIT_IPC is not set
> >> # CONFIG_INTEL_SCU_PCI is not set
> >> # CONFIG_INTEL_SCU_PLATFORM is not set
> >> CONFIG_PMC_ATOM=3Dy
> >> # CONFIG_MFD_CROS_EC is not set
> >> # CONFIG_CHROME_PLATFORMS is not set
> >> CONFIG_MELLANOX_PLATFORM=3Dy
> >> CONFIG_MLXREG_HOTPLUG=3Dm
> >> # CONFIG_MLXREG_IO is not set
> >> CONFIG_HAVE_CLK=3Dy
> >> CONFIG_CLKDEV_LOOKUP=3Dy
> >> CONFIG_HAVE_CLK_PREPARE=3Dy
> >> CONFIG_COMMON_CLK=3Dy
> >> # CONFIG_COMMON_CLK_MAX9485 is not set
> >> # CONFIG_COMMON_CLK_SI5341 is not set
> >> # CONFIG_COMMON_CLK_SI5351 is not set
> >> # CONFIG_COMMON_CLK_SI544 is not set
> >> # CONFIG_COMMON_CLK_CDCE706 is not set
> >> # CONFIG_COMMON_CLK_CS2000_CP is not set
> >> # CONFIG_COMMON_CLK_PWM is not set
> >> CONFIG_HWSPINLOCK=3Dy
> >>
> >> #
> >> # Clock Source drivers
> >> #
> >> CONFIG_CLKEVT_I8253=3Dy
> >> CONFIG_I8253_LOCK=3Dy
> >> CONFIG_CLKBLD_I8253=3Dy
> >> # end of Clock Source drivers
> >>
> >> CONFIG_MAILBOX=3Dy
> >> CONFIG_PCC=3Dy
> >> # CONFIG_ALTERA_MBOX is not set
> >> CONFIG_IOMMU_IOVA=3Dy
> >> CONFIG_IOASID=3Dy
> >> CONFIG_IOMMU_API=3Dy
> >> CONFIG_IOMMU_SUPPORT=3Dy
> >>
> >> #
> >> # Generic IOMMU Pagetable Support
> >> #
> >> # end of Generic IOMMU Pagetable Support
> >>
> >> # CONFIG_IOMMU_DEBUGFS is not set
> >> # CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
> >> CONFIG_IOMMU_DMA=3Dy
> >> CONFIG_AMD_IOMMU=3Dy
> >> CONFIG_AMD_IOMMU_V2=3Dm
> >> CONFIG_DMAR_TABLE=3Dy
> >> CONFIG_INTEL_IOMMU=3Dy
> >> # CONFIG_INTEL_IOMMU_SVM is not set
> >> # CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
> >> CONFIG_INTEL_IOMMU_FLOPPY_WA=3Dy
> >> # CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
> >> CONFIG_IRQ_REMAP=3Dy
> >> CONFIG_HYPERV_IOMMU=3Dy
> >>
> >> #
> >> # Remoteproc drivers
> >> #
> >> # CONFIG_REMOTEPROC is not set
> >> # end of Remoteproc drivers
> >>
> >> #
> >> # Rpmsg drivers
> >> #
> >> # CONFIG_RPMSG_QCOM_GLINK_RPM is not set
> >> # CONFIG_RPMSG_VIRTIO is not set
> >> # end of Rpmsg drivers
> >>
> >> # CONFIG_SOUNDWIRE is not set
> >>
> >> #
> >> # SOC (System On Chip) specific Drivers
> >> #
> >>
> >> #
> >> # Amlogic SoC drivers
> >> #
> >> # end of Amlogic SoC drivers
> >>
> >> #
> >> # Aspeed SoC drivers
> >> #
> >> # end of Aspeed SoC drivers
> >>
> >> #
> >> # Broadcom SoC drivers
> >> #
> >> # end of Broadcom SoC drivers
> >>
> >> #
> >> # NXP/Freescale QorIQ SoC drivers
> >> #
> >> # end of NXP/Freescale QorIQ SoC drivers
> >>
> >> #
> >> # i.MX SoC drivers
> >> #
> >> # end of i.MX SoC drivers
> >>
> >> #
> >> # Qualcomm SoC drivers
> >> #
> >> # end of Qualcomm SoC drivers
> >>
> >> # CONFIG_SOC_TI is not set
> >>
> >> #
> >> # Xilinx SoC drivers
> >> #
> >> # CONFIG_XILINX_VCU is not set
> >> # end of Xilinx SoC drivers
> >> # end of SOC (System On Chip) specific Drivers
> >>
> >> # CONFIG_PM_DEVFREQ is not set
> >> # CONFIG_EXTCON is not set
> >> # CONFIG_MEMORY is not set
> >> # CONFIG_IIO is not set
> >> CONFIG_NTB=3Dm
> >> # CONFIG_NTB_MSI is not set
> >> # CONFIG_NTB_AMD is not set
> >> # CONFIG_NTB_IDT is not set
> >> # CONFIG_NTB_INTEL is not set
> >> # CONFIG_NTB_SWITCHTEC is not set
> >> # CONFIG_NTB_PINGPONG is not set
> >> # CONFIG_NTB_TOOL is not set
> >> # CONFIG_NTB_PERF is not set
> >> # CONFIG_NTB_TRANSPORT is not set
> >> # CONFIG_VME_BUS is not set
> >> CONFIG_PWM=3Dy
> >> CONFIG_PWM_SYSFS=3Dy
> >> # CONFIG_PWM_DEBUG is not set
> >> CONFIG_PWM_LPSS=3Dm
> >> CONFIG_PWM_LPSS_PCI=3Dm
> >> CONFIG_PWM_LPSS_PLATFORM=3Dm
> >> # CONFIG_PWM_PCA9685 is not set
> >>
> >> #
> >> # IRQ chip support
> >> #
> >> # end of IRQ chip support
> >>
> >> # CONFIG_IPACK_BUS is not set
> >> # CONFIG_RESET_CONTROLLER is not set
> >>
> >> #
> >> # PHY Subsystem
> >> #
> >> # CONFIG_GENERIC_PHY is not set
> >> # CONFIG_BCM_KONA_USB2_PHY is not set
> >> # CONFIG_PHY_PXA_28NM_HSIC is not set
> >> # CONFIG_PHY_PXA_28NM_USB2 is not set
> >> # CONFIG_PHY_INTEL_EMMC is not set
> >> # end of PHY Subsystem
> >>
> >> CONFIG_POWERCAP=3Dy
> >> CONFIG_INTEL_RAPL_CORE=3Dm
> >> CONFIG_INTEL_RAPL=3Dm
> >> # CONFIG_IDLE_INJECT is not set
> >> # CONFIG_MCB is not set
> >>
> >> #
> >> # Performance monitor support
> >> #
> >> # end of Performance monitor support
> >>
> >> CONFIG_RAS=3Dy
> >> # CONFIG_RAS_CEC is not set
> >> # CONFIG_USB4 is not set
> >>
> >> #
> >> # Android
> >> #
> >> # CONFIG_ANDROID is not set
> >> # end of Android
> >>
> >> CONFIG_LIBNVDIMM=3Dm
> >> CONFIG_BLK_DEV_PMEM=3Dm
> >> CONFIG_ND_BLK=3Dm
> >> CONFIG_ND_CLAIM=3Dy
> >> CONFIG_ND_BTT=3Dm
> >> CONFIG_BTT=3Dy
> >> CONFIG_ND_PFN=3Dm
> >> CONFIG_NVDIMM_PFN=3Dy
> >> CONFIG_NVDIMM_DAX=3Dy
> >> CONFIG_NVDIMM_KEYS=3Dy
> >> CONFIG_DAX_DRIVER=3Dy
> >> CONFIG_DAX=3Dy
> >> CONFIG_DEV_DAX=3Dm
> >> CONFIG_DEV_DAX_PMEM=3Dm
> >> CONFIG_DEV_DAX_KMEM=3Dm
> >> CONFIG_DEV_DAX_PMEM_COMPAT=3Dm
> >> CONFIG_NVMEM=3Dy
> >> CONFIG_NVMEM_SYSFS=3Dy
> >>
> >> #
> >> # HW tracing support
> >> #
> >> CONFIG_STM=3Dm
> >> # CONFIG_STM_PROTO_BASIC is not set
> >> # CONFIG_STM_PROTO_SYS_T is not set
> >> CONFIG_STM_DUMMY=3Dm
> >> CONFIG_STM_SOURCE_CONSOLE=3Dm
> >> CONFIG_STM_SOURCE_HEARTBEAT=3Dm
> >> CONFIG_STM_SOURCE_FTRACE=3Dm
> >> CONFIG_INTEL_TH=3Dm
> >> CONFIG_INTEL_TH_PCI=3Dm
> >> CONFIG_INTEL_TH_ACPI=3Dm
> >> CONFIG_INTEL_TH_GTH=3Dm
> >> CONFIG_INTEL_TH_STH=3Dm
> >> CONFIG_INTEL_TH_MSU=3Dm
> >> CONFIG_INTEL_TH_PTI=3Dm
> >> # CONFIG_INTEL_TH_DEBUG is not set
> >> # end of HW tracing support
> >>
> >> # CONFIG_FPGA is not set
> >> # CONFIG_TEE is not set
> >> # CONFIG_UNISYS_VISORBUS is not set
> >> # CONFIG_SIOX is not set
> >> # CONFIG_SLIMBUS is not set
> >> # CONFIG_INTERCONNECT is not set
> >> # CONFIG_COUNTER is not set
> >> # CONFIG_MOST is not set
> >> # end of Device Drivers
> >>
> >> #
> >> # File systems
> >> #
> >> CONFIG_DCACHE_WORD_ACCESS=3Dy
> >> # CONFIG_VALIDATE_FS_PARSER is not set
> >> CONFIG_FS_IOMAP=3Dy
> >> # CONFIG_EXT2_FS is not set
> >> # CONFIG_EXT3_FS is not set
> >> CONFIG_EXT4_FS=3Dy
> >> CONFIG_EXT4_USE_FOR_EXT2=3Dy
> >> CONFIG_EXT4_FS_POSIX_ACL=3Dy
> >> CONFIG_EXT4_FS_SECURITY=3Dy
> >> # CONFIG_EXT4_DEBUG is not set
> >> CONFIG_EXT4_KUNIT_TESTS=3Dm
> >> CONFIG_JBD2=3Dy
> >> # CONFIG_JBD2_DEBUG is not set
> >> CONFIG_FS_MBCACHE=3Dy
> >> # CONFIG_REISERFS_FS is not set
> >> # CONFIG_JFS_FS is not set
> >> CONFIG_XFS_FS=3Dm
> >> CONFIG_XFS_QUOTA=3Dy
> >> CONFIG_XFS_POSIX_ACL=3Dy
> >> CONFIG_XFS_RT=3Dy
> >> CONFIG_XFS_ONLINE_SCRUB=3Dy
> >> CONFIG_XFS_ONLINE_REPAIR=3Dy
> >> CONFIG_XFS_DEBUG=3Dy
> >> CONFIG_XFS_ASSERT_FATAL=3Dy
> >> CONFIG_GFS2_FS=3Dm
> >> CONFIG_GFS2_FS_LOCKING_DLM=3Dy
> >> CONFIG_OCFS2_FS=3Dm
> >> CONFIG_OCFS2_FS_O2CB=3Dm
> >> CONFIG_OCFS2_FS_USERSPACE_CLUSTER=3Dm
> >> CONFIG_OCFS2_FS_STATS=3Dy
> >> CONFIG_OCFS2_DEBUG_MASKLOG=3Dy
> >> # CONFIG_OCFS2_DEBUG_FS is not set
> >> CONFIG_BTRFS_FS=3Dm
> >> CONFIG_BTRFS_FS_POSIX_ACL=3Dy
> >> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> >> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> >> # CONFIG_BTRFS_DEBUG is not set
> >> # CONFIG_BTRFS_ASSERT is not set
> >> # CONFIG_BTRFS_FS_REF_VERIFY is not set
> >> # CONFIG_NILFS2_FS is not set
> >> CONFIG_F2FS_FS=3Dm
> >> CONFIG_F2FS_STAT_FS=3Dy
> >> CONFIG_F2FS_FS_XATTR=3Dy
> >> CONFIG_F2FS_FS_POSIX_ACL=3Dy
> >> CONFIG_F2FS_FS_SECURITY=3Dy
> >> # CONFIG_F2FS_CHECK_FS is not set
> >> # CONFIG_F2FS_IO_TRACE is not set
> >> # CONFIG_F2FS_FAULT_INJECTION is not set
> >> # CONFIG_F2FS_FS_COMPRESSION is not set
> >> # CONFIG_ZONEFS_FS is not set
> >> CONFIG_FS_DAX=3Dy
> >> CONFIG_FS_DAX_PMD=3Dy
> >> CONFIG_FS_POSIX_ACL=3Dy
> >> CONFIG_EXPORTFS=3Dy
> >> CONFIG_EXPORTFS_BLOCK_OPS=3Dy
> >> CONFIG_FILE_LOCKING=3Dy
> >> CONFIG_MANDATORY_FILE_LOCKING=3Dy
> >> CONFIG_FS_ENCRYPTION=3Dy
> >> CONFIG_FS_ENCRYPTION_ALGS=3Dy
> >> # CONFIG_FS_VERITY is not set
> >> CONFIG_FSNOTIFY=3Dy
> >> CONFIG_DNOTIFY=3Dy
> >> CONFIG_INOTIFY_USER=3Dy
> >> CONFIG_FANOTIFY=3Dy
> >> CONFIG_FANOTIFY_ACCESS_PERMISSIONS=3Dy
> >> CONFIG_QUOTA=3Dy
> >> CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
> >> CONFIG_PRINT_QUOTA_WARNING=3Dy
> >> # CONFIG_QUOTA_DEBUG is not set
> >> CONFIG_QUOTA_TREE=3Dy
> >> # CONFIG_QFMT_V1 is not set
> >> CONFIG_QFMT_V2=3Dy
> >> CONFIG_QUOTACTL=3Dy
> >> CONFIG_QUOTACTL_COMPAT=3Dy
> >> CONFIG_AUTOFS4_FS=3Dy
> >> CONFIG_AUTOFS_FS=3Dy
> >> CONFIG_FUSE_FS=3Dm
> >> CONFIG_CUSE=3Dm
> >> # CONFIG_VIRTIO_FS is not set
> >> CONFIG_OVERLAY_FS=3Dm
> >> # CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
> >> # CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
> >> # CONFIG_OVERLAY_FS_INDEX is not set
> >> # CONFIG_OVERLAY_FS_XINO_AUTO is not set
> >> # CONFIG_OVERLAY_FS_METACOPY is not set
> >>
> >> #
> >> # Caches
> >> #
> >> CONFIG_FSCACHE=3Dm
> >> CONFIG_FSCACHE_STATS=3Dy
> >> # CONFIG_FSCACHE_HISTOGRAM is not set
> >> # CONFIG_FSCACHE_DEBUG is not set
> >> # CONFIG_FSCACHE_OBJECT_LIST is not set
> >> CONFIG_CACHEFILES=3Dm
> >> # CONFIG_CACHEFILES_DEBUG is not set
> >> # CONFIG_CACHEFILES_HISTOGRAM is not set
> >> # end of Caches
> >>
> >> #
> >> # CD-ROM/DVD Filesystems
> >> #
> >> CONFIG_ISO9660_FS=3Dm
> >> CONFIG_JOLIET=3Dy
> >> CONFIG_ZISOFS=3Dy
> >> CONFIG_UDF_FS=3Dm
> >> # end of CD-ROM/DVD Filesystems
> >>
> >> #
> >> # DOS/FAT/EXFAT/NT Filesystems
> >> #
> >> CONFIG_FAT_FS=3Dm
> >> CONFIG_MSDOS_FS=3Dm
> >> CONFIG_VFAT_FS=3Dm
> >> CONFIG_FAT_DEFAULT_CODEPAGE=3D437
> >> CONFIG_FAT_DEFAULT_IOCHARSET=3D"ascii"
> >> # CONFIG_FAT_DEFAULT_UTF8 is not set
> >> # CONFIG_EXFAT_FS is not set
> >> # CONFIG_NTFS_FS is not set
> >> # end of DOS/FAT/EXFAT/NT Filesystems
> >>
> >> #
> >> # Pseudo filesystems
> >> #
> >> CONFIG_PROC_FS=3Dy
> >> CONFIG_PROC_KCORE=3Dy
> >> CONFIG_PROC_VMCORE=3Dy
> >> CONFIG_PROC_VMCORE_DEVICE_DUMP=3Dy
> >> CONFIG_PROC_SYSCTL=3Dy
> >> CONFIG_PROC_PAGE_MONITOR=3Dy
> >> CONFIG_PROC_CHILDREN=3Dy
> >> CONFIG_PROC_PID_ARCH_STATUS=3Dy
> >> CONFIG_PROC_CPU_RESCTRL=3Dy
> >> CONFIG_KERNFS=3Dy
> >> CONFIG_SYSFS=3Dy
> >> CONFIG_TMPFS=3Dy
> >> CONFIG_TMPFS_POSIX_ACL=3Dy
> >> CONFIG_TMPFS_XATTR=3Dy
> >> CONFIG_HUGETLBFS=3Dy
> >> CONFIG_HUGETLB_PAGE=3Dy
> >> CONFIG_MEMFD_CREATE=3Dy
> >> CONFIG_ARCH_HAS_GIGANTIC_PAGE=3Dy
> >> CONFIG_CONFIGFS_FS=3Dy
> >> CONFIG_EFIVAR_FS=3Dy
> >> # end of Pseudo filesystems
> >>
> >> CONFIG_MISC_FILESYSTEMS=3Dy
> >> # CONFIG_ORANGEFS_FS is not set
> >> # CONFIG_ADFS_FS is not set
> >> # CONFIG_AFFS_FS is not set
> >> # CONFIG_ECRYPT_FS is not set
> >> # CONFIG_HFS_FS is not set
> >> # CONFIG_HFSPLUS_FS is not set
> >> # CONFIG_BEFS_FS is not set
> >> # CONFIG_BFS_FS is not set
> >> # CONFIG_EFS_FS is not set
> >> CONFIG_CRAMFS=3Dm
> >> CONFIG_CRAMFS_BLOCKDEV=3Dy
> >> CONFIG_SQUASHFS=3Dm
> >> # CONFIG_SQUASHFS_FILE_CACHE is not set
> >> CONFIG_SQUASHFS_FILE_DIRECT=3Dy
> >> # CONFIG_SQUASHFS_DECOMP_SINGLE is not set
> >> # CONFIG_SQUASHFS_DECOMP_MULTI is not set
> >> CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=3Dy
> >> CONFIG_SQUASHFS_XATTR=3Dy
> >> CONFIG_SQUASHFS_ZLIB=3Dy
> >> # CONFIG_SQUASHFS_LZ4 is not set
> >> CONFIG_SQUASHFS_LZO=3Dy
> >> CONFIG_SQUASHFS_XZ=3Dy
> >> # CONFIG_SQUASHFS_ZSTD is not set
> >> # CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
> >> # CONFIG_SQUASHFS_EMBEDDED is not set
> >> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3D3
> >> # CONFIG_VXFS_FS is not set
> >> CONFIG_MINIX_FS=3Dm
> >> # CONFIG_OMFS_FS is not set
> >> # CONFIG_HPFS_FS is not set
> >> # CONFIG_QNX4FS_FS is not set
> >> # CONFIG_QNX6FS_FS is not set
> >> # CONFIG_ROMFS_FS is not set
> >> CONFIG_PSTORE=3Dy
> >> CONFIG_PSTORE_DEFLATE_COMPRESS=3Dy
> >> # CONFIG_PSTORE_LZO_COMPRESS is not set
> >> # CONFIG_PSTORE_LZ4_COMPRESS is not set
> >> # CONFIG_PSTORE_LZ4HC_COMPRESS is not set
> >> # CONFIG_PSTORE_842_COMPRESS is not set
> >> # CONFIG_PSTORE_ZSTD_COMPRESS is not set
> >> CONFIG_PSTORE_COMPRESS=3Dy
> >> CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=3Dy
> >> CONFIG_PSTORE_COMPRESS_DEFAULT=3D"deflate"
> >> # CONFIG_PSTORE_CONSOLE is not set
> >> # CONFIG_PSTORE_PMSG is not set
> >> # CONFIG_PSTORE_FTRACE is not set
> >> CONFIG_PSTORE_RAM=3Dm
> >> # CONFIG_PSTORE_BLK is not set
> >> # CONFIG_SYSV_FS is not set
> >> # CONFIG_UFS_FS is not set
> >> # CONFIG_EROFS_FS is not set
> >> CONFIG_NETWORK_FILESYSTEMS=3Dy
> >> CONFIG_NFS_FS=3Dy
> >> # CONFIG_NFS_V2 is not set
> >> CONFIG_NFS_V3=3Dy
> >> CONFIG_NFS_V3_ACL=3Dy
> >> CONFIG_NFS_V4=3Dm
> >> # CONFIG_NFS_SWAP is not set
> >> CONFIG_NFS_V4_1=3Dy
> >> CONFIG_NFS_V4_2=3Dy
> >> CONFIG_PNFS_FILE_LAYOUT=3Dm
> >> CONFIG_PNFS_BLOCK=3Dm
> >> CONFIG_PNFS_FLEXFILE_LAYOUT=3Dm
> >> CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN=3D"kernel.org"
> >> # CONFIG_NFS_V4_1_MIGRATION is not set
> >> CONFIG_NFS_V4_SECURITY_LABEL=3Dy
> >> CONFIG_ROOT_NFS=3Dy
> >> # CONFIG_NFS_USE_LEGACY_DNS is not set
> >> CONFIG_NFS_USE_KERNEL_DNS=3Dy
> >> CONFIG_NFS_DEBUG=3Dy
> >> CONFIG_NFS_DISABLE_UDP_SUPPORT=3Dy
> >> CONFIG_NFSD=3Dm
> >> CONFIG_NFSD_V2_ACL=3Dy
> >> CONFIG_NFSD_V3=3Dy
> >> CONFIG_NFSD_V3_ACL=3Dy
> >> CONFIG_NFSD_V4=3Dy
> >> CONFIG_NFSD_PNFS=3Dy
> >> # CONFIG_NFSD_BLOCKLAYOUT is not set
> >> CONFIG_NFSD_SCSILAYOUT=3Dy
> >> # CONFIG_NFSD_FLEXFILELAYOUT is not set
> >> # CONFIG_NFSD_V4_2_INTER_SSC is not set
> >> CONFIG_NFSD_V4_SECURITY_LABEL=3Dy
> >> CONFIG_GRACE_PERIOD=3Dy
> >> CONFIG_LOCKD=3Dy
> >> CONFIG_LOCKD_V4=3Dy
> >> CONFIG_NFS_ACL_SUPPORT=3Dy
> >> CONFIG_NFS_COMMON=3Dy
> >> CONFIG_SUNRPC=3Dy
> >> CONFIG_SUNRPC_GSS=3Dm
> >> CONFIG_SUNRPC_BACKCHANNEL=3Dy
> >> CONFIG_RPCSEC_GSS_KRB5=3Dm
> >> # CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
> >> CONFIG_SUNRPC_DEBUG=3Dy
> >> CONFIG_SUNRPC_XPRT_RDMA=3Dm
> >> CONFIG_CEPH_FS=3Dm
> >> # CONFIG_CEPH_FSCACHE is not set
> >> CONFIG_CEPH_FS_POSIX_ACL=3Dy
> >> # CONFIG_CEPH_FS_SECURITY_LABEL is not set
> >> CONFIG_CIFS=3Dm
> >> # CONFIG_CIFS_STATS2 is not set
> >> CONFIG_CIFS_ALLOW_INSECURE_LEGACY=3Dy
> >> CONFIG_CIFS_WEAK_PW_HASH=3Dy
> >> CONFIG_CIFS_UPCALL=3Dy
> >> CONFIG_CIFS_XATTR=3Dy
> >> CONFIG_CIFS_POSIX=3Dy
> >> CONFIG_CIFS_DEBUG=3Dy
> >> # CONFIG_CIFS_DEBUG2 is not set
> >> # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> >> CONFIG_CIFS_DFS_UPCALL=3Dy
> >> # CONFIG_CIFS_SMB_DIRECT is not set
> >> # CONFIG_CIFS_FSCACHE is not set
> >> # CONFIG_CODA_FS is not set
> >> # CONFIG_AFS_FS is not set
> >> CONFIG_9P_FS=3Dy
> >> CONFIG_9P_FS_POSIX_ACL=3Dy
> >> # CONFIG_9P_FS_SECURITY is not set
> >> CONFIG_NLS=3Dy
> >> CONFIG_NLS_DEFAULT=3D"utf8"
> >> CONFIG_NLS_CODEPAGE_437=3Dy
> >> CONFIG_NLS_CODEPAGE_737=3Dm
> >> CONFIG_NLS_CODEPAGE_775=3Dm
> >> CONFIG_NLS_CODEPAGE_850=3Dm
> >> CONFIG_NLS_CODEPAGE_852=3Dm
> >> CONFIG_NLS_CODEPAGE_855=3Dm
> >> CONFIG_NLS_CODEPAGE_857=3Dm
> >> CONFIG_NLS_CODEPAGE_860=3Dm
> >> CONFIG_NLS_CODEPAGE_861=3Dm
> >> CONFIG_NLS_CODEPAGE_862=3Dm
> >> CONFIG_NLS_CODEPAGE_863=3Dm
> >> CONFIG_NLS_CODEPAGE_864=3Dm
> >> CONFIG_NLS_CODEPAGE_865=3Dm
> >> CONFIG_NLS_CODEPAGE_866=3Dm
> >> CONFIG_NLS_CODEPAGE_869=3Dm
> >> CONFIG_NLS_CODEPAGE_936=3Dm
> >> CONFIG_NLS_CODEPAGE_950=3Dm
> >> CONFIG_NLS_CODEPAGE_932=3Dm
> >> CONFIG_NLS_CODEPAGE_949=3Dm
> >> CONFIG_NLS_CODEPAGE_874=3Dm
> >> CONFIG_NLS_ISO8859_8=3Dm
> >> CONFIG_NLS_CODEPAGE_1250=3Dm
> >> CONFIG_NLS_CODEPAGE_1251=3Dm
> >> CONFIG_NLS_ASCII=3Dy
> >> CONFIG_NLS_ISO8859_1=3Dm
> >> CONFIG_NLS_ISO8859_2=3Dm
> >> CONFIG_NLS_ISO8859_3=3Dm
> >> CONFIG_NLS_ISO8859_4=3Dm
> >> CONFIG_NLS_ISO8859_5=3Dm
> >> CONFIG_NLS_ISO8859_6=3Dm
> >> CONFIG_NLS_ISO8859_7=3Dm
> >> CONFIG_NLS_ISO8859_9=3Dm
> >> CONFIG_NLS_ISO8859_13=3Dm
> >> CONFIG_NLS_ISO8859_14=3Dm
> >> CONFIG_NLS_ISO8859_15=3Dm
> >> CONFIG_NLS_KOI8_R=3Dm
> >> CONFIG_NLS_KOI8_U=3Dm
> >> CONFIG_NLS_MAC_ROMAN=3Dm
> >> CONFIG_NLS_MAC_CELTIC=3Dm
> >> CONFIG_NLS_MAC_CENTEURO=3Dm
> >> CONFIG_NLS_MAC_CROATIAN=3Dm
> >> CONFIG_NLS_MAC_CYRILLIC=3Dm
> >> CONFIG_NLS_MAC_GAELIC=3Dm
> >> CONFIG_NLS_MAC_GREEK=3Dm
> >> CONFIG_NLS_MAC_ICELAND=3Dm
> >> CONFIG_NLS_MAC_INUIT=3Dm
> >> CONFIG_NLS_MAC_ROMANIAN=3Dm
> >> CONFIG_NLS_MAC_TURKISH=3Dm
> >> CONFIG_NLS_UTF8=3Dm
> >> CONFIG_DLM=3Dm
> >> CONFIG_DLM_DEBUG=3Dy
> >> # CONFIG_UNICODE is not set
> >> CONFIG_IO_WQ=3Dy
> >> # end of File systems
> >>
> >> #
> >> # Security options
> >> #
> >> CONFIG_KEYS=3Dy
> >> # CONFIG_KEYS_REQUEST_CACHE is not set
> >> CONFIG_PERSISTENT_KEYRINGS=3Dy
> >> CONFIG_TRUSTED_KEYS=3Dy
> >> CONFIG_ENCRYPTED_KEYS=3Dy
> >> # CONFIG_KEY_DH_OPERATIONS is not set
> >> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> >> CONFIG_SECURITY=3Dy
> >> CONFIG_SECURITY_WRITABLE_HOOKS=3Dy
> >> CONFIG_SECURITYFS=3Dy
> >> CONFIG_SECURITY_NETWORK=3Dy
> >> CONFIG_PAGE_TABLE_ISOLATION=3Dy
> >> # CONFIG_SECURITY_INFINIBAND is not set
> >> CONFIG_SECURITY_NETWORK_XFRM=3Dy
> >> CONFIG_SECURITY_PATH=3Dy
> >> CONFIG_INTEL_TXT=3Dy
> >> CONFIG_LSM_MMAP_MIN_ADDR=3D65535
> >> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=3Dy
> >> CONFIG_HARDENED_USERCOPY=3Dy
> >> CONFIG_HARDENED_USERCOPY_FALLBACK=3Dy
> >> CONFIG_FORTIFY_SOURCE=3Dy
> >> # CONFIG_STATIC_USERMODEHELPER is not set
> >> CONFIG_SECURITY_SELINUX=3Dy
> >> CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy
> >> CONFIG_SECURITY_SELINUX_DISABLE=3Dy
> >> CONFIG_SECURITY_SELINUX_DEVELOP=3Dy
> >> CONFIG_SECURITY_SELINUX_AVC_STATS=3Dy
> >> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=3D1
> >> CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=3D9
> >> CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=3D256
> >> # CONFIG_SECURITY_SMACK is not set
> >> # CONFIG_SECURITY_TOMOYO is not set
> >> CONFIG_SECURITY_APPARMOR=3Dy
> >> CONFIG_SECURITY_APPARMOR_HASH=3Dy
> >> CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=3Dy
> >> # CONFIG_SECURITY_APPARMOR_DEBUG is not set
> >> # CONFIG_SECURITY_APPARMOR_KUNIT_TEST is not set
> >> # CONFIG_SECURITY_LOADPIN is not set
> >> CONFIG_SECURITY_YAMA=3Dy
> >> # CONFIG_SECURITY_SAFESETID is not set
> >> # CONFIG_SECURITY_LOCKDOWN_LSM is not set
> >> CONFIG_INTEGRITY=3Dy
> >> CONFIG_INTEGRITY_SIGNATURE=3Dy
> >> CONFIG_INTEGRITY_ASYMMETRIC_KEYS=3Dy
> >> CONFIG_INTEGRITY_TRUSTED_KEYRING=3Dy
> >> # CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
> >> CONFIG_INTEGRITY_AUDIT=3Dy
> >> CONFIG_IMA=3Dy
> >> CONFIG_IMA_MEASURE_PCR_IDX=3D10
> >> CONFIG_IMA_LSM_RULES=3Dy
> >> # CONFIG_IMA_TEMPLATE is not set
> >> CONFIG_IMA_NG_TEMPLATE=3Dy
> >> # CONFIG_IMA_SIG_TEMPLATE is not set
> >> CONFIG_IMA_DEFAULT_TEMPLATE=3D"ima-ng"
> >> CONFIG_IMA_DEFAULT_HASH_SHA1=3Dy
> >> # CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
> >> # CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
> >> CONFIG_IMA_DEFAULT_HASH=3D"sha1"
> >> # CONFIG_IMA_WRITE_POLICY is not set
> >> # CONFIG_IMA_READ_POLICY is not set
> >> CONFIG_IMA_APPRAISE=3Dy
> >> # CONFIG_IMA_ARCH_POLICY is not set
> >> # CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
> >> CONFIG_IMA_APPRAISE_BOOTPARAM=3Dy
> >> # CONFIG_IMA_APPRAISE_MODSIG is not set
> >> CONFIG_IMA_TRUSTED_KEYRING=3Dy
> >> # CONFIG_IMA_BLACKLIST_KEYRING is not set
> >> # CONFIG_IMA_LOAD_X509 is not set
> >> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=3Dy
> >> CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=3Dy
> >> # CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
> >> CONFIG_EVM=3Dy
> >> CONFIG_EVM_ATTR_FSUUID=3Dy
> >> # CONFIG_EVM_ADD_XATTRS is not set
> >> # CONFIG_EVM_LOAD_X509 is not set
> >> CONFIG_DEFAULT_SECURITY_SELINUX=3Dy
> >> # CONFIG_DEFAULT_SECURITY_APPARMOR is not set
> >> # CONFIG_DEFAULT_SECURITY_DAC is not set
> >> CONFIG_LSM=3D"lockdown,yama,loadpin,safesetid,integrity,selinux,smack,=
tomoyo,apparmor,bpf"
> >>
> >> #
> >> # Kernel hardening options
> >> #
> >>
> >> #
> >> # Memory initialization
> >> #
> >> CONFIG_INIT_STACK_NONE=3Dy
> >> # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> >> # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> >> # end of Memory initialization
> >> # end of Kernel hardening options
> >> # end of Security options
> >>
> >> CONFIG_XOR_BLOCKS=3Dm
> >> CONFIG_ASYNC_CORE=3Dm
> >> CONFIG_ASYNC_MEMCPY=3Dm
> >> CONFIG_ASYNC_XOR=3Dm
> >> CONFIG_ASYNC_PQ=3Dm
> >> CONFIG_ASYNC_RAID6_RECOV=3Dm
> >> CONFIG_CRYPTO=3Dy
> >>
> >> #
> >> # Crypto core or helper
> >> #
> >> CONFIG_CRYPTO_ALGAPI=3Dy
> >> CONFIG_CRYPTO_ALGAPI2=3Dy
> >> CONFIG_CRYPTO_AEAD=3Dy
> >> CONFIG_CRYPTO_AEAD2=3Dy
> >> CONFIG_CRYPTO_SKCIPHER=3Dy
> >> CONFIG_CRYPTO_SKCIPHER2=3Dy
> >> CONFIG_CRYPTO_HASH=3Dy
> >> CONFIG_CRYPTO_HASH2=3Dy
> >> CONFIG_CRYPTO_RNG=3Dy
> >> CONFIG_CRYPTO_RNG2=3Dy
> >> CONFIG_CRYPTO_RNG_DEFAULT=3Dy
> >> CONFIG_CRYPTO_AKCIPHER2=3Dy
> >> CONFIG_CRYPTO_AKCIPHER=3Dy
> >> CONFIG_CRYPTO_KPP2=3Dy
> >> CONFIG_CRYPTO_KPP=3Dm
> >> CONFIG_CRYPTO_ACOMP2=3Dy
> >> CONFIG_CRYPTO_MANAGER=3Dy
> >> CONFIG_CRYPTO_MANAGER2=3Dy
> >> CONFIG_CRYPTO_USER=3Dm
> >> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dy
> >> CONFIG_CRYPTO_GF128MUL=3Dy
> >> CONFIG_CRYPTO_NULL=3Dy
> >> CONFIG_CRYPTO_NULL2=3Dy
> >> CONFIG_CRYPTO_PCRYPT=3Dm
> >> CONFIG_CRYPTO_CRYPTD=3Dy
> >> CONFIG_CRYPTO_AUTHENC=3Dm
> >> CONFIG_CRYPTO_TEST=3Dm
> >> CONFIG_CRYPTO_SIMD=3Dy
> >> CONFIG_CRYPTO_GLUE_HELPER_X86=3Dy
> >>
> >> #
> >> # Public-key cryptography
> >> #
> >> CONFIG_CRYPTO_RSA=3Dy
> >> CONFIG_CRYPTO_DH=3Dm
> >> CONFIG_CRYPTO_ECC=3Dm
> >> CONFIG_CRYPTO_ECDH=3Dm
> >> # CONFIG_CRYPTO_ECRDSA is not set
> >> # CONFIG_CRYPTO_CURVE25519 is not set
> >> # CONFIG_CRYPTO_CURVE25519_X86 is not set
> >>
> >> #
> >> # Authenticated Encryption with Associated Data
> >> #
> >> CONFIG_CRYPTO_CCM=3Dm
> >> CONFIG_CRYPTO_GCM=3Dy
> >> CONFIG_CRYPTO_CHACHA20POLY1305=3Dm
> >> # CONFIG_CRYPTO_AEGIS128 is not set
> >> # CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
> >> CONFIG_CRYPTO_SEQIV=3Dy
> >> CONFIG_CRYPTO_ECHAINIV=3Dm
> >>
> >> #
> >> # Block modes
> >> #
> >> CONFIG_CRYPTO_CBC=3Dy
> >> CONFIG_CRYPTO_CFB=3Dy
> >> CONFIG_CRYPTO_CTR=3Dy
> >> CONFIG_CRYPTO_CTS=3Dy
> >> CONFIG_CRYPTO_ECB=3Dy
> >> CONFIG_CRYPTO_LRW=3Dm
> >> # CONFIG_CRYPTO_OFB is not set
> >> CONFIG_CRYPTO_PCBC=3Dm
> >> CONFIG_CRYPTO_XTS=3Dy
> >> # CONFIG_CRYPTO_KEYWRAP is not set
> >> # CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
> >> # CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
> >> # CONFIG_CRYPTO_ADIANTUM is not set
> >> CONFIG_CRYPTO_ESSIV=3Dm
> >>
> >> #
> >> # Hash modes
> >> #
> >> CONFIG_CRYPTO_CMAC=3Dm
> >> CONFIG_CRYPTO_HMAC=3Dy
> >> CONFIG_CRYPTO_XCBC=3Dm
> >> CONFIG_CRYPTO_VMAC=3Dm
> >>
> >> #
> >> # Digest
> >> #
> >> CONFIG_CRYPTO_CRC32C=3Dy
> >> CONFIG_CRYPTO_CRC32C_INTEL=3Dm
> >> CONFIG_CRYPTO_CRC32=3Dm
> >> CONFIG_CRYPTO_CRC32_PCLMUL=3Dm
> >> CONFIG_CRYPTO_XXHASH=3Dm
> >> CONFIG_CRYPTO_BLAKE2B=3Dm
> >> # CONFIG_CRYPTO_BLAKE2S is not set
> >> # CONFIG_CRYPTO_BLAKE2S_X86 is not set
> >> CONFIG_CRYPTO_CRCT10DIF=3Dy
> >> CONFIG_CRYPTO_CRCT10DIF_PCLMUL=3Dm
> >> CONFIG_CRYPTO_GHASH=3Dy
> >> CONFIG_CRYPTO_POLY1305=3Dm
> >> CONFIG_CRYPTO_POLY1305_X86_64=3Dm
> >> CONFIG_CRYPTO_MD4=3Dm
> >> CONFIG_CRYPTO_MD5=3Dy
> >> CONFIG_CRYPTO_MICHAEL_MIC=3Dm
> >> CONFIG_CRYPTO_RMD128=3Dm
> >> CONFIG_CRYPTO_RMD160=3Dm
> >> CONFIG_CRYPTO_RMD256=3Dm
> >> CONFIG_CRYPTO_RMD320=3Dm
> >> CONFIG_CRYPTO_SHA1=3Dy
> >> CONFIG_CRYPTO_SHA1_SSSE3=3Dy
> >> CONFIG_CRYPTO_SHA256_SSSE3=3Dy
> >> CONFIG_CRYPTO_SHA512_SSSE3=3Dm
> >> CONFIG_CRYPTO_SHA256=3Dy
> >> CONFIG_CRYPTO_SHA512=3Dy
> >> CONFIG_CRYPTO_SHA3=3Dm
> >> # CONFIG_CRYPTO_SM3 is not set
> >> # CONFIG_CRYPTO_STREEBOG is not set
> >> CONFIG_CRYPTO_TGR192=3Dm
> >> CONFIG_CRYPTO_WP512=3Dm
> >> CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=3Dm
> >>
> >> #
> >> # Ciphers
> >> #
> >> CONFIG_CRYPTO_AES=3Dy
> >> # CONFIG_CRYPTO_AES_TI is not set
> >> CONFIG_CRYPTO_AES_NI_INTEL=3Dy
> >> CONFIG_CRYPTO_ANUBIS=3Dm
> >> CONFIG_CRYPTO_ARC4=3Dm
> >> CONFIG_CRYPTO_BLOWFISH=3Dm
> >> CONFIG_CRYPTO_BLOWFISH_COMMON=3Dm
> >> CONFIG_CRYPTO_BLOWFISH_X86_64=3Dm
> >> CONFIG_CRYPTO_CAMELLIA=3Dm
> >> CONFIG_CRYPTO_CAMELLIA_X86_64=3Dm
> >> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=3Dm
> >> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=3Dm
> >> CONFIG_CRYPTO_CAST_COMMON=3Dm
> >> CONFIG_CRYPTO_CAST5=3Dm
> >> CONFIG_CRYPTO_CAST5_AVX_X86_64=3Dm
> >> CONFIG_CRYPTO_CAST6=3Dm
> >> CONFIG_CRYPTO_CAST6_AVX_X86_64=3Dm
> >> CONFIG_CRYPTO_DES=3Dm
> >> CONFIG_CRYPTO_DES3_EDE_X86_64=3Dm
> >> CONFIG_CRYPTO_FCRYPT=3Dm
> >> CONFIG_CRYPTO_KHAZAD=3Dm
> >> CONFIG_CRYPTO_SALSA20=3Dm
> >> CONFIG_CRYPTO_CHACHA20=3Dm
> >> CONFIG_CRYPTO_CHACHA20_X86_64=3Dm
> >> CONFIG_CRYPTO_SEED=3Dm
> >> CONFIG_CRYPTO_SERPENT=3Dm
> >> CONFIG_CRYPTO_SERPENT_SSE2_X86_64=3Dm
> >> CONFIG_CRYPTO_SERPENT_AVX_X86_64=3Dm
> >> CONFIG_CRYPTO_SERPENT_AVX2_X86_64=3Dm
> >> # CONFIG_CRYPTO_SM4 is not set
> >> CONFIG_CRYPTO_TEA=3Dm
> >> CONFIG_CRYPTO_TWOFISH=3Dm
> >> CONFIG_CRYPTO_TWOFISH_COMMON=3Dm
> >> CONFIG_CRYPTO_TWOFISH_X86_64=3Dm
> >> CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=3Dm
> >> CONFIG_CRYPTO_TWOFISH_AVX_X86_64=3Dm
> >>
> >> #
> >> # Compression
> >> #
> >> CONFIG_CRYPTO_DEFLATE=3Dy
> >> CONFIG_CRYPTO_LZO=3Dy
> >> # CONFIG_CRYPTO_842 is not set
> >> # CONFIG_CRYPTO_LZ4 is not set
> >> # CONFIG_CRYPTO_LZ4HC is not set
> >> # CONFIG_CRYPTO_ZSTD is not set
> >>
> >> #
> >> # Random Number Generation
> >> #
> >> CONFIG_CRYPTO_ANSI_CPRNG=3Dm
> >> CONFIG_CRYPTO_DRBG_MENU=3Dy
> >> CONFIG_CRYPTO_DRBG_HMAC=3Dy
> >> CONFIG_CRYPTO_DRBG_HASH=3Dy
> >> CONFIG_CRYPTO_DRBG_CTR=3Dy
> >> CONFIG_CRYPTO_DRBG=3Dy
> >> CONFIG_CRYPTO_JITTERENTROPY=3Dy
> >> CONFIG_CRYPTO_USER_API=3Dy
> >> CONFIG_CRYPTO_USER_API_HASH=3Dy
> >> CONFIG_CRYPTO_USER_API_SKCIPHER=3Dy
> >> CONFIG_CRYPTO_USER_API_RNG=3Dy
> >> CONFIG_CRYPTO_USER_API_AEAD=3Dy
> >> # CONFIG_CRYPTO_STATS is not set
> >> CONFIG_CRYPTO_HASH_INFO=3Dy
> >>
> >> #
> >> # Crypto library routines
> >> #
> >> CONFIG_CRYPTO_LIB_AES=3Dy
> >> CONFIG_CRYPTO_LIB_ARC4=3Dm
> >> # CONFIG_CRYPTO_LIB_BLAKE2S is not set
> >> CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=3Dm
> >> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=3Dm
> >> # CONFIG_CRYPTO_LIB_CHACHA is not set
> >> # CONFIG_CRYPTO_LIB_CURVE25519 is not set
> >> CONFIG_CRYPTO_LIB_DES=3Dm
> >> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=3D11
> >> CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=3Dm
> >> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=3Dm
> >> # CONFIG_CRYPTO_LIB_POLY1305 is not set
> >> # CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
> >> CONFIG_CRYPTO_LIB_SHA256=3Dy
> >> CONFIG_CRYPTO_HW=3Dy
> >> CONFIG_CRYPTO_DEV_PADLOCK=3Dm
> >> CONFIG_CRYPTO_DEV_PADLOCK_AES=3Dm
> >> CONFIG_CRYPTO_DEV_PADLOCK_SHA=3Dm
> >> # CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
> >> # CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
> >> CONFIG_CRYPTO_DEV_CCP=3Dy
> >> CONFIG_CRYPTO_DEV_CCP_DD=3Dy
> >> CONFIG_CRYPTO_DEV_SP_CCP=3Dy
> >> CONFIG_CRYPTO_DEV_CCP_CRYPTO=3Dm
> >> CONFIG_CRYPTO_DEV_SP_PSP=3Dy
> >> # CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
> >> CONFIG_CRYPTO_DEV_QAT=3Dm
> >> CONFIG_CRYPTO_DEV_QAT_DH895xCC=3Dm
> >> CONFIG_CRYPTO_DEV_QAT_C3XXX=3Dm
> >> CONFIG_CRYPTO_DEV_QAT_C62X=3Dm
> >> CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=3Dm
> >> CONFIG_CRYPTO_DEV_QAT_C3XXXVF=3Dm
> >> CONFIG_CRYPTO_DEV_QAT_C62XVF=3Dm
> >> CONFIG_CRYPTO_DEV_NITROX=3Dm
> >> CONFIG_CRYPTO_DEV_NITROX_CNN55XX=3Dm
> >> # CONFIG_CRYPTO_DEV_VIRTIO is not set
> >> # CONFIG_CRYPTO_DEV_SAFEXCEL is not set
> >> # CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
> >> CONFIG_ASYMMETRIC_KEY_TYPE=3Dy
> >> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dy
> >> # CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
> >> CONFIG_X509_CERTIFICATE_PARSER=3Dy
> >> # CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
> >> CONFIG_PKCS7_MESSAGE_PARSER=3Dy
> >> # CONFIG_PKCS7_TEST_KEY is not set
> >> CONFIG_SIGNED_PE_FILE_VERIFICATION=3Dy
> >>
> >> #
> >> # Certificates for signature checking
> >> #
> >> CONFIG_MODULE_SIG_KEY=3D"certs/signing_key.pem"
> >> CONFIG_SYSTEM_TRUSTED_KEYRING=3Dy
> >> CONFIG_SYSTEM_TRUSTED_KEYS=3D""
> >> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> >> # CONFIG_SECONDARY_TRUSTED_KEYRING is not set
> >> CONFIG_SYSTEM_BLACKLIST_KEYRING=3Dy
> >> CONFIG_SYSTEM_BLACKLIST_HASH_LIST=3D""
> >> # end of Certificates for signature checking
> >>
> >> CONFIG_BINARY_PRINTF=3Dy
> >>
> >> #
> >> # Library routines
> >> #
> >> CONFIG_RAID6_PQ=3Dm
> >> CONFIG_RAID6_PQ_BENCHMARK=3Dy
> >> # CONFIG_PACKING is not set
> >> CONFIG_BITREVERSE=3Dy
> >> CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy
> >> CONFIG_GENERIC_STRNLEN_USER=3Dy
> >> CONFIG_GENERIC_NET_UTILS=3Dy
> >> CONFIG_GENERIC_FIND_FIRST_BIT=3Dy
> >> CONFIG_CORDIC=3Dm
> >> # CONFIG_PRIME_NUMBERS is not set
> >> CONFIG_RATIONAL=3Dy
> >> CONFIG_GENERIC_PCI_IOMAP=3Dy
> >> CONFIG_GENERIC_IOMAP=3Dy
> >> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=3Dy
> >> CONFIG_ARCH_HAS_FAST_MULTIPLIER=3Dy
> >> CONFIG_ARCH_USE_SYM_ANNOTATIONS=3Dy
> >> CONFIG_CRC_CCITT=3Dy
> >> CONFIG_CRC16=3Dy
> >> CONFIG_CRC_T10DIF=3Dy
> >> CONFIG_CRC_ITU_T=3Dm
> >> CONFIG_CRC32=3Dy
> >> # CONFIG_CRC32_SELFTEST is not set
> >> CONFIG_CRC32_SLICEBY8=3Dy
> >> # CONFIG_CRC32_SLICEBY4 is not set
> >> # CONFIG_CRC32_SARWATE is not set
> >> # CONFIG_CRC32_BIT is not set
> >> # CONFIG_CRC64 is not set
> >> # CONFIG_CRC4 is not set
> >> CONFIG_CRC7=3Dm
> >> CONFIG_LIBCRC32C=3Dm
> >> CONFIG_CRC8=3Dm
> >> CONFIG_XXHASH=3Dy
> >> # CONFIG_RANDOM32_SELFTEST is not set
> >> CONFIG_ZLIB_INFLATE=3Dy
> >> CONFIG_ZLIB_DEFLATE=3Dy
> >> CONFIG_LZO_COMPRESS=3Dy
> >> CONFIG_LZO_DECOMPRESS=3Dy
> >> CONFIG_LZ4_DECOMPRESS=3Dy
> >> CONFIG_ZSTD_COMPRESS=3Dm
> >> CONFIG_ZSTD_DECOMPRESS=3Dm
> >> CONFIG_XZ_DEC=3Dy
> >> CONFIG_XZ_DEC_X86=3Dy
> >> CONFIG_XZ_DEC_POWERPC=3Dy
> >> CONFIG_XZ_DEC_IA64=3Dy
> >> CONFIG_XZ_DEC_ARM=3Dy
> >> CONFIG_XZ_DEC_ARMTHUMB=3Dy
> >> CONFIG_XZ_DEC_SPARC=3Dy
> >> CONFIG_XZ_DEC_BCJ=3Dy
> >> # CONFIG_XZ_DEC_TEST is not set
> >> CONFIG_DECOMPRESS_GZIP=3Dy
> >> CONFIG_DECOMPRESS_BZIP2=3Dy
> >> CONFIG_DECOMPRESS_LZMA=3Dy
> >> CONFIG_DECOMPRESS_XZ=3Dy
> >> CONFIG_DECOMPRESS_LZO=3Dy
> >> CONFIG_DECOMPRESS_LZ4=3Dy
> >> CONFIG_GENERIC_ALLOCATOR=3Dy
> >> CONFIG_REED_SOLOMON=3Dm
> >> CONFIG_REED_SOLOMON_ENC8=3Dy
> >> CONFIG_REED_SOLOMON_DEC8=3Dy
> >> CONFIG_TEXTSEARCH=3Dy
> >> CONFIG_TEXTSEARCH_KMP=3Dm
> >> CONFIG_TEXTSEARCH_BM=3Dm
> >> CONFIG_TEXTSEARCH_FSM=3Dm
> >> CONFIG_INTERVAL_TREE=3Dy
> >> CONFIG_XARRAY_MULTI=3Dy
> >> CONFIG_ASSOCIATIVE_ARRAY=3Dy
> >> CONFIG_HAS_IOMEM=3Dy
> >> CONFIG_HAS_IOPORT_MAP=3Dy
> >> CONFIG_HAS_DMA=3Dy
> >> CONFIG_NEED_SG_DMA_LENGTH=3Dy
> >> CONFIG_NEED_DMA_MAP_STATE=3Dy
> >> CONFIG_ARCH_DMA_ADDR_T_64BIT=3Dy
> >> CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=3Dy
> >> CONFIG_DMA_VIRT_OPS=3Dy
> >> CONFIG_SWIOTLB=3Dy
> >> CONFIG_DMA_COHERENT_POOL=3Dy
> >> CONFIG_DMA_CMA=3Dy
> >>
> >> #
> >> # Default contiguous memory area size:
> >> #
> >> CONFIG_CMA_SIZE_MBYTES=3D200
> >> CONFIG_CMA_SIZE_SEL_MBYTES=3Dy
> >> # CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
> >> # CONFIG_CMA_SIZE_SEL_MIN is not set
> >> # CONFIG_CMA_SIZE_SEL_MAX is not set
> >> CONFIG_CMA_ALIGNMENT=3D8
> >> # CONFIG_DMA_API_DEBUG is not set
> >> CONFIG_SGL_ALLOC=3Dy
> >> CONFIG_CHECK_SIGNATURE=3Dy
> >> CONFIG_CPUMASK_OFFSTACK=3Dy
> >> CONFIG_CPU_RMAP=3Dy
> >> CONFIG_DQL=3Dy
> >> CONFIG_GLOB=3Dy
> >> # CONFIG_GLOB_SELFTEST is not set
> >> CONFIG_NLATTR=3Dy
> >> CONFIG_CLZ_TAB=3Dy
> >> CONFIG_IRQ_POLL=3Dy
> >> CONFIG_MPILIB=3Dy
> >> CONFIG_SIGNATURE=3Dy
> >> CONFIG_DIMLIB=3Dy
> >> CONFIG_OID_REGISTRY=3Dy
> >> CONFIG_UCS2_STRING=3Dy
> >> CONFIG_HAVE_GENERIC_VDSO=3Dy
> >> CONFIG_GENERIC_GETTIMEOFDAY=3Dy
> >> CONFIG_GENERIC_VDSO_TIME_NS=3Dy
> >> CONFIG_FONT_SUPPORT=3Dy
> >> # CONFIG_FONTS is not set
> >> CONFIG_FONT_8x8=3Dy
> >> CONFIG_FONT_8x16=3Dy
> >> CONFIG_SG_POOL=3Dy
> >> CONFIG_ARCH_HAS_PMEM_API=3Dy
> >> CONFIG_MEMREGION=3Dy
> >> CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=3Dy
> >> CONFIG_ARCH_HAS_UACCESS_MCSAFE=3Dy
> >> CONFIG_ARCH_STACKWALK=3Dy
> >> CONFIG_SBITMAP=3Dy
> >> # CONFIG_STRING_SELFTEST is not set
> >> # end of Library routines
> >>
> >> #
> >> # Kernel hacking
> >> #
> >>
> >> #
> >> # printk and dmesg options
> >> #
> >> CONFIG_PRINTK_TIME=3Dy
> >> # CONFIG_PRINTK_CALLER is not set
> >> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=3D7
> >> CONFIG_CONSOLE_LOGLEVEL_QUIET=3D4
> >> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3D4
> >> CONFIG_BOOT_PRINTK_DELAY=3Dy
> >> CONFIG_DYNAMIC_DEBUG=3Dy
> >> CONFIG_DYNAMIC_DEBUG_CORE=3Dy
> >> CONFIG_SYMBOLIC_ERRNAME=3Dy
> >> CONFIG_DEBUG_BUGVERBOSE=3Dy
> >> # end of printk and dmesg options
> >>
> >> #
> >> # Compile-time checks and compiler options
> >> #
> >> CONFIG_DEBUG_INFO=3Dy
> >> CONFIG_DEBUG_INFO_REDUCED=3Dy
> >> # CONFIG_DEBUG_INFO_COMPRESSED is not set
> >> # CONFIG_DEBUG_INFO_SPLIT is not set
> >> CONFIG_DEBUG_INFO_DWARF4=3Dy
> >> # CONFIG_GDB_SCRIPTS is not set
> >> CONFIG_ENABLE_MUST_CHECK=3Dy
> >> CONFIG_FRAME_WARN=3D2048
> >> CONFIG_STRIP_ASM_SYMS=3Dy
> >> # CONFIG_READABLE_ASM is not set
> >> # CONFIG_HEADERS_INSTALL is not set
> >> CONFIG_DEBUG_SECTION_MISMATCH=3Dy
> >> CONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy
> >> CONFIG_STACK_VALIDATION=3Dy
> >> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> >> # end of Compile-time checks and compiler options
> >>
> >> #
> >> # Generic Kernel Debugging Instruments
> >> #
> >> CONFIG_MAGIC_SYSRQ=3Dy
> >> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=3D0x1
> >> CONFIG_MAGIC_SYSRQ_SERIAL=3Dy
> >> CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=3D""
> >> CONFIG_DEBUG_FS=3Dy
> >> CONFIG_HAVE_ARCH_KGDB=3Dy
> >> # CONFIG_KGDB is not set
> >> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=3Dy
> >> # CONFIG_UBSAN is not set
> >> # end of Generic Kernel Debugging Instruments
> >>
> >> CONFIG_DEBUG_KERNEL=3Dy
> >> CONFIG_DEBUG_MISC=3Dy
> >>
> >> #
> >> # Memory Debugging
> >> #
> >> # CONFIG_PAGE_EXTENSION is not set
> >> # CONFIG_DEBUG_PAGEALLOC is not set
> >> # CONFIG_PAGE_OWNER is not set
> >> # CONFIG_PAGE_POISONING is not set
> >> # CONFIG_DEBUG_PAGE_REF is not set
> >> # CONFIG_DEBUG_RODATA_TEST is not set
> >> CONFIG_ARCH_HAS_DEBUG_WX=3Dy
> >> # CONFIG_DEBUG_WX is not set
> >> CONFIG_GENERIC_PTDUMP=3Dy
> >> # CONFIG_PTDUMP_DEBUGFS is not set
> >> # CONFIG_DEBUG_OBJECTS is not set
> >> # CONFIG_SLUB_DEBUG_ON is not set
> >> # CONFIG_SLUB_STATS is not set
> >> CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
> >> # CONFIG_DEBUG_KMEMLEAK is not set
> >> # CONFIG_DEBUG_STACK_USAGE is not set
> >> # CONFIG_SCHED_STACK_END_CHECK is not set
> >> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=3Dy
> >> # CONFIG_DEBUG_VM is not set
> >> # CONFIG_DEBUG_VM_PGTABLE is not set
> >> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy
> >> # CONFIG_DEBUG_VIRTUAL is not set
> >> CONFIG_DEBUG_MEMORY_INIT=3Dy
> >> # CONFIG_DEBUG_PER_CPU_MAPS is not set
> >> CONFIG_HAVE_ARCH_KASAN=3Dy
> >> CONFIG_HAVE_ARCH_KASAN_VMALLOC=3Dy
> >> CONFIG_CC_HAS_KASAN_GENERIC=3Dy
> >> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=3Dy
> >> # CONFIG_KASAN is not set
> >> CONFIG_KASAN_STACK=3D1
> >> # end of Memory Debugging
> >>
> >> CONFIG_DEBUG_SHIRQ=3Dy
> >>
> >> #
> >> # Debug Oops, Lockups and Hangs
> >> #
> >> CONFIG_PANIC_ON_OOPS=3Dy
> >> CONFIG_PANIC_ON_OOPS_VALUE=3D1
> >> CONFIG_PANIC_TIMEOUT=3D0
> >> CONFIG_LOCKUP_DETECTOR=3Dy
> >> CONFIG_SOFTLOCKUP_DETECTOR=3Dy
> >> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> >> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D0
> >> CONFIG_HARDLOCKUP_DETECTOR_PERF=3Dy
> >> CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=3Dy
> >> CONFIG_HARDLOCKUP_DETECTOR=3Dy
> >> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=3Dy
> >> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=3D1
> >> # CONFIG_DETECT_HUNG_TASK is not set
> >> # CONFIG_WQ_WATCHDOG is not set
> >> # CONFIG_TEST_LOCKUP is not set
> >> # end of Debug Oops, Lockups and Hangs
> >>
> >> #
> >> # Scheduler Debugging
> >> #
> >> CONFIG_SCHED_DEBUG=3Dy
> >> CONFIG_SCHED_INFO=3Dy
> >> CONFIG_SCHEDSTATS=3Dy
> >> # end of Scheduler Debugging
> >>
> >> # CONFIG_DEBUG_TIMEKEEPING is not set
> >>
> >> #
> >> # Lock Debugging (spinlocks, mutexes, etc...)
> >> #
> >> CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
> >> # CONFIG_PROVE_LOCKING is not set
> >> # CONFIG_LOCK_STAT is not set
> >> # CONFIG_DEBUG_RT_MUTEXES is not set
> >> # CONFIG_DEBUG_SPINLOCK is not set
> >> # CONFIG_DEBUG_MUTEXES is not set
> >> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> >> # CONFIG_DEBUG_RWSEMS is not set
> >> # CONFIG_DEBUG_LOCK_ALLOC is not set
> >> CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
> >> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> >> CONFIG_LOCK_TORTURE_TEST=3Dm
> >> # CONFIG_WW_MUTEX_SELFTEST is not set
> >> # end of Lock Debugging (spinlocks, mutexes, etc...)
> >>
> >> CONFIG_STACKTRACE=3Dy
> >> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> >> # CONFIG_DEBUG_KOBJECT is not set
> >>
> >> #
> >> # Debug kernel data structures
> >> #
> >> CONFIG_DEBUG_LIST=3Dy
> >> # CONFIG_DEBUG_PLIST is not set
> >> # CONFIG_DEBUG_SG is not set
> >> # CONFIG_DEBUG_NOTIFIERS is not set
> >> CONFIG_BUG_ON_DATA_CORRUPTION=3Dy
> >> # end of Debug kernel data structures
> >>
> >> # CONFIG_DEBUG_CREDENTIALS is not set
> >>
> >> #
> >> # RCU Debugging
> >> #
> >> CONFIG_TORTURE_TEST=3Dm
> >> CONFIG_RCU_PERF_TEST=3Dm
> >> CONFIG_RCU_TORTURE_TEST=3Dm
> >> CONFIG_RCU_CPU_STALL_TIMEOUT=3D60
> >> # CONFIG_RCU_TRACE is not set
> >> # CONFIG_RCU_EQS_DEBUG is not set
> >> # end of RCU Debugging
> >>
> >> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> >> # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> >> # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> >> CONFIG_LATENCYTOP=3Dy
> >> CONFIG_USER_STACKTRACE_SUPPORT=3Dy
> >> CONFIG_NOP_TRACER=3Dy
> >> CONFIG_HAVE_FUNCTION_TRACER=3Dy
> >> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
> >> CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
> >> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=3Dy
> >> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy
> >> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
> >> CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
> >> CONFIG_HAVE_FENTRY=3Dy
> >> CONFIG_HAVE_C_RECORDMCOUNT=3Dy
> >> CONFIG_TRACER_MAX_TRACE=3Dy
> >> CONFIG_TRACE_CLOCK=3Dy
> >> CONFIG_RING_BUFFER=3Dy
> >> CONFIG_EVENT_TRACING=3Dy
> >> CONFIG_CONTEXT_SWITCH_TRACER=3Dy
> >> CONFIG_RING_BUFFER_ALLOW_SWAP=3Dy
> >> CONFIG_TRACING=3Dy
> >> CONFIG_GENERIC_TRACER=3Dy
> >> CONFIG_TRACING_SUPPORT=3Dy
> >> CONFIG_FTRACE=3Dy
> >> # CONFIG_BOOTTIME_TRACING is not set
> >> CONFIG_FUNCTION_TRACER=3Dy
> >> CONFIG_FUNCTION_GRAPH_TRACER=3Dy
> >> CONFIG_DYNAMIC_FTRACE=3Dy
> >> CONFIG_DYNAMIC_FTRACE_WITH_REGS=3Dy
> >> CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy
> >> CONFIG_FUNCTION_PROFILER=3Dy
> >> CONFIG_STACK_TRACER=3Dy
> >> # CONFIG_IRQSOFF_TRACER is not set
> >> CONFIG_SCHED_TRACER=3Dy
> >> CONFIG_HWLAT_TRACER=3Dy
> >> # CONFIG_MMIOTRACE is not set
> >> CONFIG_FTRACE_SYSCALLS=3Dy
> >> CONFIG_TRACER_SNAPSHOT=3Dy
> >> # CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
> >> CONFIG_BRANCH_PROFILE_NONE=3Dy
> >> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> >> CONFIG_BLK_DEV_IO_TRACE=3Dy
> >> CONFIG_KPROBE_EVENTS=3Dy
> >> # CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
> >> CONFIG_UPROBE_EVENTS=3Dy
> >> CONFIG_BPF_EVENTS=3Dy
> >> CONFIG_DYNAMIC_EVENTS=3Dy
> >> CONFIG_PROBE_EVENTS=3Dy
> >> # CONFIG_BPF_KPROBE_OVERRIDE is not set
> >> CONFIG_FTRACE_MCOUNT_RECORD=3Dy
> >> CONFIG_TRACING_MAP=3Dy
> >> CONFIG_SYNTH_EVENTS=3Dy
> >> CONFIG_HIST_TRIGGERS=3Dy
> >> # CONFIG_TRACE_EVENT_INJECT is not set
> >> # CONFIG_TRACEPOINT_BENCHMARK is not set
> >> CONFIG_RING_BUFFER_BENCHMARK=3Dm
> >> # CONFIG_TRACE_EVAL_MAP_FILE is not set
> >> # CONFIG_FTRACE_STARTUP_TEST is not set
> >> # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> >> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> >> # CONFIG_SYNTH_EVENT_GEN_TEST is not set
> >> # CONFIG_KPROBE_EVENT_GEN_TEST is not set
> >> # CONFIG_HIST_TRIGGERS_DEBUG is not set
> >> CONFIG_PROVIDE_OHCI1394_DMA_INIT=3Dy
> >> # CONFIG_SAMPLES is not set
> >> CONFIG_HAVE_ARCH_KCSAN=3Dy
> >> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=3Dy
> >> CONFIG_STRICT_DEVMEM=3Dy
> >> # CONFIG_IO_STRICT_DEVMEM is not set
> >>
> >> #
> >> # x86 Debugging
> >> #
> >> CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
> >> CONFIG_EARLY_PRINTK_USB=3Dy
> >> CONFIG_X86_VERBOSE_BOOTUP=3Dy
> >> CONFIG_EARLY_PRINTK=3Dy
> >> CONFIG_EARLY_PRINTK_DBGP=3Dy
> >> CONFIG_EARLY_PRINTK_USB_XDBC=3Dy
> >> # CONFIG_EFI_PGT_DUMP is not set
> >> # CONFIG_DEBUG_TLBFLUSH is not set
> >> CONFIG_HAVE_MMIOTRACE_SUPPORT=3Dy
> >> CONFIG_X86_DECODER_SELFTEST=3Dy
> >> CONFIG_IO_DELAY_0X80=3Dy
> >> # CONFIG_IO_DELAY_0XED is not set
> >> # CONFIG_IO_DELAY_UDELAY is not set
> >> # CONFIG_IO_DELAY_NONE is not set
> >> CONFIG_DEBUG_BOOT_PARAMS=3Dy
> >> # CONFIG_CPA_DEBUG is not set
> >> # CONFIG_DEBUG_ENTRY is not set
> >> # CONFIG_DEBUG_NMI_SELFTEST is not set
> >> # CONFIG_X86_DEBUG_FPU is not set
> >> # CONFIG_PUNIT_ATOM_DEBUG is not set
> >> CONFIG_UNWINDER_ORC=3Dy
> >> # CONFIG_UNWINDER_FRAME_POINTER is not set
> >> # end of x86 Debugging
> >>
> >> #
> >> # Kernel Testing and Coverage
> >> #
> >> CONFIG_KUNIT=3Dy
> >> # CONFIG_KUNIT_DEBUGFS is not set
> >> CONFIG_KUNIT_TEST=3Dm
> >> CONFIG_KUNIT_EXAMPLE_TEST=3Dm
> >> # CONFIG_KUNIT_ALL_TESTS is not set
> >> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> >> CONFIG_FUNCTION_ERROR_INJECTION=3Dy
> >> CONFIG_FAULT_INJECTION=3Dy
> >> # CONFIG_FAILSLAB is not set
> >> # CONFIG_FAIL_PAGE_ALLOC is not set
> >> CONFIG_FAIL_MAKE_REQUEST=3Dy
> >> # CONFIG_FAIL_IO_TIMEOUT is not set
> >> # CONFIG_FAIL_FUTEX is not set
> >> CONFIG_FAULT_INJECTION_DEBUG_FS=3Dy
> >> # CONFIG_FAIL_FUNCTION is not set
> >> # CONFIG_FAIL_MMC_REQUEST is not set
> >> CONFIG_ARCH_HAS_KCOV=3Dy
> >> CONFIG_CC_HAS_SANCOV_TRACE_PC=3Dy
> >> # CONFIG_KCOV is not set
> >> CONFIG_RUNTIME_TESTING_MENU=3Dy
> >> # CONFIG_LKDTM is not set
> >> # CONFIG_TEST_LIST_SORT is not set
> >> # CONFIG_TEST_MIN_HEAP is not set
> >> # CONFIG_TEST_SORT is not set
> >> # CONFIG_KPROBES_SANITY_TEST is not set
> >> # CONFIG_BACKTRACE_SELF_TEST is not set
> >> # CONFIG_RBTREE_TEST is not set
> >> # CONFIG_REED_SOLOMON_TEST is not set
> >> # CONFIG_INTERVAL_TREE_TEST is not set
> >> # CONFIG_PERCPU_TEST is not set
> >> CONFIG_ATOMIC64_SELFTEST=3Dy
> >> # CONFIG_ASYNC_RAID6_TEST is not set
> >> # CONFIG_TEST_HEXDUMP is not set
> >> # CONFIG_TEST_STRING_HELPERS is not set
> >> # CONFIG_TEST_STRSCPY is not set
> >> # CONFIG_TEST_KSTRTOX is not set
> >> # CONFIG_TEST_PRINTF is not set
> >> # CONFIG_TEST_BITMAP is not set
> >> # CONFIG_TEST_BITFIELD is not set
> >> # CONFIG_TEST_UUID is not set
> >> # CONFIG_TEST_XARRAY is not set
> >> # CONFIG_TEST_OVERFLOW is not set
> >> # CONFIG_TEST_RHASHTABLE is not set
> >> # CONFIG_TEST_HASH is not set
> >> # CONFIG_TEST_IDA is not set
> >> # CONFIG_TEST_LKM is not set
> >> # CONFIG_TEST_BITOPS is not set
> >> # CONFIG_TEST_VMALLOC is not set
> >> # CONFIG_TEST_USER_COPY is not set
> >> CONFIG_TEST_BPF=3Dm
> >> # CONFIG_TEST_BLACKHOLE_DEV is not set
> >> # CONFIG_FIND_BIT_BENCHMARK is not set
> >> # CONFIG_TEST_FIRMWARE is not set
> >> # CONFIG_TEST_SYSCTL is not set
> >> CONFIG_SYSCTL_KUNIT_TEST=3Dm
> >> CONFIG_LIST_KUNIT_TEST=3Dm
> >> # CONFIG_LINEAR_RANGES_TEST is not set
> >> # CONFIG_TEST_UDELAY is not set
> >> # CONFIG_TEST_STATIC_KEYS is not set
> >> # CONFIG_TEST_KMOD is not set
> >> # CONFIG_TEST_MEMCAT_P is not set
> >> # CONFIG_TEST_LIVEPATCH is not set
> >> # CONFIG_TEST_STACKINIT is not set
> >> # CONFIG_TEST_MEMINIT is not set
> >> # CONFIG_TEST_HMM is not set
> >> # CONFIG_MEMTEST is not set
> >> # CONFIG_HYPERV_TESTING is not set
> >> # end of Kernel Testing and Coverage
> >> # end of Kernel hacking
> >=20
> >> #!/bin/sh
> >>
> >> export_top_env()
> >> {
> >> 	export suite=3D'perf-sanity-tests'
> >> 	export testcase=3D'perf-sanity-tests'
> >> 	export category=3D'functional'
> >> 	export need_memory=3D'2G'
> >> 	export job_origin=3D'/lkp-src/allot/cyclic:p2:linux-devel:devel-hourl=
y/lkp-hsw-d02/perf-sanity-tests.yaml'
> >> 	export queue_cmdline_keys=3D'branch
> >> commit
> >> queue_at_least_once'
> >> 	export queue=3D'validate'
> >> 	export testbox=3D'lkp-hsw-d02'
> >> 	export tbox_group=3D'lkp-hsw-d02'
> >> 	export kconfig=3D'x86_64-rhel-8.3'
> >> 	export submit_id=3D'5f0e9d59132bb218d681052c'
> >> 	export job_file=3D'/lkp/jobs/scheduled/lkp-hsw-d02/perf-sanity-tests-=
gcc-ucode=3D0x28-debian-10.4-x86_64-20200603.cgz-8edd7f41336b4462f69b011deb=
7cf37a2c3f8516-20200715-6358-1q0w4dq-1.yaml'
> >> 	export id=3D'd67a94394a99e7bad464df8cdcccb5932b62e70b'
> >> 	export queuer_version=3D'/lkp-src'
> >> 	export model=3D'Haswell'
> >> 	export nr_node=3D1
> >> 	export nr_cpu=3D8
> >> 	export memory=3D'6G'
> >> 	export ssd_partitions=3D
> >> 	export swap_partitions=3D'LABEL=3DSWAP'
> >> 	export rootfs_partition=3D'LABEL=3DLKP-ROOTFS'
> >> 	export brand=3D'Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz'
> >> 	export LKP_SERVER=3D'10.239.97.5'
> >> 	export avoid_nfs=3D1
> >> 	export result_service=3D'tmpfs'
> >> 	export need_linux_perf=3Dtrue
> >> 	export commit=3D'8edd7f41336b4462f69b011deb7cf37a2c3f8516'
> >> 	export ucode=3D'0x28'
> >> 	export need_kconfig_hw=3D'CONFIG_E1000E=3Dy
> >> CONFIG_SATA_AHCI'
> >> 	export enqueue_time=3D'2020-07-15 14:08:25 +0800'
> >> 	export _id=3D'5f0e9d59132bb218d681052c'
> >> 	export _rt=3D'/result/perf-sanity-tests/gcc-ucode=3D0x28/lkp-hsw-d02/=
debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8edd7f41336b4462f69b0=
11deb7cf37a2c3f8516'
> >> 	export user=3D'lkp'
> >> 	export compiler=3D'gcc-9'
> >> 	export head_commit=3D'b133dfd9c7f8e13a45a57e21fda38f146badb9c1'
> >> 	export base_commit=3D'11ba468877bb23f28956a35e896356252d63c983'
> >> 	export branch=3D'linux-review/Alexey-Budankov/perf-support-enable-and=
-disable-commands-in-stat-and-record-modes/20200714-171347'
> >> 	export rootfs=3D'debian-10.4-x86_64-20200603.cgz'
> >> 	export result_root=3D'/result/perf-sanity-tests/gcc-ucode=3D0x28/lkp-=
hsw-d02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8edd7f41336b4=
462f69b011deb7cf37a2c3f8516/3'
> >> 	export scheduler_version=3D'/lkp/lkp/.src-20200715-141122'
> >> 	export arch=3D'x86_64'
> >> 	export max_uptime=3D3600
> >> 	export initrd=3D'/osimage/debian/debian-10.4-x86_64-20200603.cgz'
> >> 	export bootloader_append=3D'root=3D/dev/ram0
> >> user=3Dlkp
> >> job=3D/lkp/jobs/scheduled/lkp-hsw-d02/perf-sanity-tests-gcc-ucode=3D0x=
28-debian-10.4-x86_64-20200603.cgz-8edd7f41336b4462f69b011deb7cf37a2c3f8516=
-20200715-6358-1q0w4dq-1.yaml
> >> ARCH=3Dx86_64
> >> kconfig=3Dx86_64-rhel-8.3
> >> branch=3Dlinux-review/Alexey-Budankov/perf-support-enable-and-disable-=
commands-in-stat-and-record-modes/20200714-171347
> >> commit=3D8edd7f41336b4462f69b011deb7cf37a2c3f8516
> >> BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/8edd7f41336b4462f69b011d=
eb7cf37a2c3f8516/vmlinuz-5.8.0-rc3-00047-g8edd7f41336b4
> >> max_uptime=3D3600
> >> RESULT_ROOT=3D/result/perf-sanity-tests/gcc-ucode=3D0x28/lkp-hsw-d02/d=
ebian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8edd7f41336b4462f69b01=
1deb7cf37a2c3f8516/3
> >> LKP_SERVER=3D10.239.97.5
> >> nokaslr
> >> selinux=3D0
> >> debug
> >> apic=3Ddebug
> >> sysrq_always_enabled
> >> rcupdate.rcu_cpu_stall_timeout=3D100
> >> net.ifnames=3D0
> >> printk.devkmsg=3Don
> >> panic=3D-1
> >> softlockup_panic=3D1
> >> nmi_watchdog=3Dpanic
> >> oops=3Dpanic
> >> load_ramdisk=3D2
> >> prompt_ramdisk=3D0
> >> drbd.minor_count=3D8
> >> systemd.log_level=3Derr
> >> ignore_loglevel
> >> console=3Dtty0
> >> earlyprintk=3DttyS0,115200
> >> console=3DttyS0,115200
> >> vga=3Dnormal
> >> rw'
> >> 	export modules_initrd=3D'/pkg/linux/x86_64-rhel-8.3/gcc-9/8edd7f41336=
b4462f69b011deb7cf37a2c3f8516/modules.cgz'
> >> 	export bm_initrd=3D'/osimage/deps/debian-10.4-x86_64-20200603.cgz/run=
-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20=
200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200=
608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf-sanity-tests_202=
00709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
> >> 	export linux_perf_initrd=3D'/pkg/linux/x86_64-rhel-8.3/gcc-9/8edd7f41=
336b4462f69b011deb7cf37a2c3f8516/linux-perf.cgz'
> >> 	export ucode_initrd=3D'/osimage/ucode/intel-ucode-20200610.cgz'
> >> 	export lkp_initrd=3D'/osimage/user/lkp/lkp-x86_64.cgz'
> >> 	export site=3D'inn'
> >> 	export LKP_CGI_PORT=3D80
> >> 	export LKP_CIFS_PORT=3D139
> >> 	export last_kernel=3D'5.8.0-rc5-05797-gb133dfd9c7f8e'
> >> 	export repeat_to=3D4
> >> 	export schedule_notify_address=3D
> >> 	export queue_at_least_once=3D1
> >> 	export kernel=3D'/pkg/linux/x86_64-rhel-8.3/gcc-9/8edd7f41336b4462f69=
b011deb7cf37a2c3f8516/vmlinuz-5.8.0-rc3-00047-g8edd7f41336b4'
> >> 	export dequeue_time=3D'2020-07-15 14:13:05 +0800'
> >> 	export job_initrd=3D'/lkp/jobs/scheduled/lkp-hsw-d02/perf-sanity-test=
s-gcc-ucode=3D0x28-debian-10.4-x86_64-20200603.cgz-8edd7f41336b4462f69b011d=
eb7cf37a2c3f8516-20200715-6358-1q0w4dq-1.cgz'
> >>
> >> 	[ -n "$LKP_SRC" ] ||
> >> 	export LKP_SRC=3D/lkp/${user:-lkp}/src
> >> }
> >>
> >> run_job()
> >> {
> >> 	echo $$ > $TMP/run-job.pid
> >>
> >> 	. $LKP_SRC/lib/http.sh
> >> 	. $LKP_SRC/lib/job.sh
> >> 	. $LKP_SRC/lib/env.sh
> >>
> >> 	export_top_env
> >>
> >> 	run_monitor $LKP_SRC/monitors/wrapper kmsg
> >> 	run_monitor $LKP_SRC/monitors/wrapper heartbeat
> >> 	run_monitor $LKP_SRC/monitors/wrapper meminfo
> >> 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
> >> 	run_monitor $LKP_SRC/monitors/plain/watchdog
> >>
> >> 	run_test perf_compiler=3D'gcc' $LKP_SRC/tests/wrapper perf-sanity-tes=
ts
> >> }
> >>
> >> extract_stats()
> >> {
> >> 	export stats_part_begin=3D
> >> 	export stats_part_end=3D
> >>
> >> 	$LKP_SRC/stats/wrapper perf-sanity-tests
> >> 	$LKP_SRC/stats/wrapper kmsg
> >> 	$LKP_SRC/stats/wrapper meminfo
> >>
> >> 	$LKP_SRC/stats/wrapper time perf-sanity-tests.time
> >> 	$LKP_SRC/stats/wrapper dmesg
> >> 	$LKP_SRC/stats/wrapper kmsg
> >> 	$LKP_SRC/stats/wrapper last_state
> >> 	$LKP_SRC/stats/wrapper stderr
> >> 	$LKP_SRC/stats/wrapper time
> >> }
> >>
> >> "$@"
> >=20
> >> 2020-07-15 06:37:26 make ARCH=3D -C /usr/src/perf_selftests-x86_64-rhe=
l-8.3-8edd7f41336b4462f69b011deb7cf37a2c3f8516/tools/perf
> >> make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-8edd=
7f41336b4462f69b011deb7cf37a2c3f8516/tools/perf'
> >>   BUILD:   Doing 'make =1B[33m-j8=1B[m' parallel build
> >>   HOSTCC   fixdep.o
> >>   HOSTLD   fixdep-in.o
> >>   LINK     fixdep
> >> diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_=
event.h
> >> diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/=
cpufeatures.h
> >> diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/ms=
r-index.h
> >> diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
> >>
> >> Auto-detecting system features:
> >> ...                         dwarf: [ =1B[32mon=1B[m  ]
> >> ...            dwarf_getlocations: [ =1B[32mon=1B[m  ]
> >> ...                         glibc: [ =1B[32mon=1B[m  ]
> >> ...                          gtk2: [ =1B[32mon=1B[m  ]
> >> ...                        libbfd: [ =1B[32mon=1B[m  ]
> >> ...                        libcap: [ =1B[32mon=1B[m  ]
> >> ...                        libelf: [ =1B[32mon=1B[m  ]
> >> ...                       libnuma: [ =1B[32mon=1B[m  ]
> >> ...        numa_num_possible_cpus: [ =1B[32mon=1B[m  ]
> >> ...                       libperl: [ =1B[32mon=1B[m  ]
> >> ...                     libpython: [ =1B[32mon=1B[m  ]
> >> ...                     libcrypto: [ =1B[32mon=1B[m  ]
> >> ...                     libunwind: [ =1B[32mon=1B[m  ]
> >> ...            libdw-dwarf-unwind: [ =1B[32mon=1B[m  ]
> >> ...                          zlib: [ =1B[32mon=1B[m  ]
> >> ...                          lzma: [ =1B[32mon=1B[m  ]
> >> ...                     get_cpuid: [ =1B[32mon=1B[m  ]
> >> ...                           bpf: [ =1B[32mon=1B[m  ]
> >> ...                        libaio: [ =1B[32mon=1B[m  ]
> >> ...                       libzstd: [ =1B[32mon=1B[m  ]
> >> ...        disassembler-four-args: [ =1B[32mon=1B[m  ]
> >>
> >>   GEN      common-cmds.h
> >>   CC       exec-cmd.o
> >>   CC       fd/array.o
> >>   CC       fs/fs.o
> >>   GEN      bpf_helper_defs.h
> >>   CC       event-parse.o
> >>   CC       core.o
> >>   LD       fd/libapi-in.o
> >>   CC       fs/tracing_path.o
> >>   MKDIR    staticobjs/
> >>   CC       staticobjs/libbpf.o
> >>   CC       fs/cgroup.o
> >>   MKDIR    staticobjs/
> >>   CC       help.o
> >>   CC       cpumap.o
> >>   CC       cpu.o
> >>   CC       staticobjs/bpf.o
> >>   LD       fs/libapi-in.o
> >>   CC       debug.o
> >>   CC       staticobjs/nlattr.o
> >>   CC       str_error_r.o
> >>   CC       staticobjs/btf.o
> >>   CC       staticobjs/libbpf_errno.o
> >>   LD       libapi-in.o
> >>   CC       staticobjs/str_error.o
> >>   AR       libapi.a
> >>   CC       staticobjs/netlink.o
> >>   CC       pager.o
> >>   CC       threadmap.o
> >>   CC       staticobjs/bpf_prog_linfo.o
> >>   CC       event-plugin.o
> >>   CC       parse-options.o
> >>   CC       evsel.o
> >>   CC       run-command.o
> >>   CC       staticobjs/libbpf_probes.o
> >>   CC       trace-seq.o
> >>   CC       evlist.o
> >>   CC       staticobjs/xsk.o
> >>   CC       parse-filter.o
> >>   CC       sigchain.o
> >>   CC       parse-utils.o
> >>   CC       kbuffer-parse.o
> >>   CC       staticobjs/hashmap.o
> >>   CC       staticobjs/btf_dump.o
> >>   CC       subcmd-config.o
> >>   CC       tep_strerror.o
> >>   CC       event-parse-api.o
> >>   CC       staticobjs/ringbuf.o
> >>   CC       mmap.o
> >>   CC       zalloc.o
> >>   LD       libsubcmd-in.o
> >>   AR       libsubcmd.a
> >>   CC       xyarray.o
> >>   LD       libtraceevent-in.o
> >>   LD       staticobjs/libbpf-in.o
> >>   LINK     libtraceevent.a
> >>   CC       lib.o
> >>   LINK     libbpf.a
> >>   HOSTCC   pmu-events/json.o
> >>   HOSTCC   pmu-events/jsmn.o
> >>   CC       jvmti/libjvmti.o
> >>   CC       plugin_jbd2.o
> >>   CC       ui/gtk/browser.o
> >>   LD       libperf-in.o
> >>   CC       ui/gtk/hists.o
> >>   CC       ui/gtk/setup.o
> >>   AR       libperf.a
> >>   HOSTCC   pmu-events/jevents.o
> >>   LD       plugin_jbd2-in.o
> >>   GEN      perf-archive
> >>   CC       plugin_hrtimer.o
> >>   CC       plugin_kmem.o
> >>   HOSTLD   pmu-events/jevents-in.o
> >>   LD       plugin_hrtimer-in.o
> >>   GEN      perf-with-kcore
> >>   CC       ui/gtk/util.o
> >>   CC       jvmti/jvmti_agent.o
> >>   LD       plugin_kmem-in.o
> >>   CC       plugin_kvm.o
> >>   LINK     pmu-events/jevents
> >>   LD       plugin_kvm-in.o
> >>   CC       plugin_mac80211.o
> >>   CC       plugin_sched_switch.o
> >>   LD       plugin_mac80211-in.o
> >>   LD       plugin_sched_switch-in.o
> >>   GEN      pmu-events/pmu-events.c
> >>   CC       plugin_function.o
> >>   CC       ui/gtk/helpline.o
> >>   CC       plugin_xen.o
> >>   CC       jvmti/libstring.o
> >>   LD       plugin_function-in.o
> >>   CC       ui/gtk/progress.o
> >>   LD       plugin_xen-in.o
> >>   CC       plugin_scsi.o
> >>   CC       jvmti/libctype.o
> >>   CC       pmu-events/pmu-events.o
> >>   LD       plugin_scsi-in.o
> >>   CC       plugin_cfg80211.o
> >>   LD       jvmti/jvmti-in.o
> >>   LINK     libperf-jvmti.so
> >>   CC       ui/gtk/annotate.o
> >>   LD       plugin_cfg80211-in.o
> >>   LINK     plugin_jbd2.so
> >>   LINK     plugin_hrtimer.so
> >>   LINK     plugin_kmem.so
> >>   CC       ui/gtk/zalloc.o
> >>   LINK     plugin_kvm.so
> >>   LINK     plugin_mac80211.so
> >>   LINK     plugin_sched_switch.so
> >>   LINK     plugin_function.so
> >>   LINK     plugin_xen.so
> >>   LINK     plugin_scsi.so
> >>   LINK     plugin_cfg80211.so
> >>   CC       builtin-bench.o
> >>   CC       builtin-annotate.o
> >>   CC       builtin-config.o
> >>   GEN      libtraceevent-dynamic-list
> >>   CC       builtin-diff.o
> >>   CC       builtin-evlist.o
> >>   CC       builtin-ftrace.o
> >>   CC       builtin-help.o
> >>   CC       builtin-sched.o
> >>   CC       builtin-buildid-list.o
> >>   LD       pmu-events/pmu-events-in.o
> >>   GEN      python/perf.so
> >>   CC       builtin-buildid-cache.o
> >>   LD       ui/gtk/gtk-in.o
> >>   CC       builtin-kallsyms.o
> >>   LD       gtk-in.o
> >>   CC       builtin-list.o
> >>   LINK     libperf-gtk.so
> >>   CC       builtin-record.o
> >>   CC       builtin-report.o
> >>   CC       builtin-stat.o
> >>   CC       builtin-timechart.o
> >>   CC       builtin-top.o
> >>   CC       builtin-script.o
> >>   CC       builtin-kmem.o
> >>   CC       builtin-lock.o
> >>   CC       builtin-kvm.o
> >>   CC       builtin-inject.o
> >>   CC       builtin-mem.o
> >>   CC       builtin-data.o
> >>   CC       builtin-version.o
> >>   CC       builtin-c2c.o
> >>   CC       builtin-trace.o
> >>   CC       builtin-probe.o
> >>   CC       bench/sched-messaging.o
> >>   CC       tests/builtin-test.o
> >>   CC       tests/parse-events.o
> >>   CC       bench/sched-pipe.o
> >>   CC       tests/dso-data.o
> >>   CC       bench/mem-functions.o
> >>   CC       tests/attr.o
> >>   CC       tests/vmlinux-kallsyms.o
> >>   CC       bench/futex-hash.o
> >>   CC       bench/futex-wake.o
> >>   CC       tests/openat-syscall.o
> >>   CC       tests/openat-syscall-all-cpus.o
> >>   CC       bench/futex-wake-parallel.o
> >>   CC       bench/futex-requeue.o
> >>   CC       bench/futex-lock-pi.o
> >>   CC       tests/openat-syscall-tp-fields.o
> >>   CC       util/annotate.o
> >>   CC       bench/epoll-wait.o
> >>   CC       util/block-info.o
> >>   CC       tests/mmap-basic.o
> >>   CC       bench/epoll-ctl.o
> >>   CC       tests/perf-record.o
> >>   CC       tests/evsel-roundtrip-name.o
> >>   CC       tests/evsel-tp-sched.o
> >>   CC       bench/synthesize.o
> >>   CC       util/block-range.o
> >>   CC       tests/fdarray.o
> >>   CC       tests/pmu.o
> >>   CC       tests/pmu-events.o
> >>   CC       tests/hists_common.o
> >>   CC       util/build-id.o
> >>   CC       tests/hists_link.o
> >>   CC       bench/kallsyms-parse.o
> >>   CC       tests/hists_filter.o
> >>   CC       bench/mem-memcpy-x86-64-lib.o
> >>   CC       bench/mem-memcpy-x86-64-asm.o
> >>   CC       tests/hists_output.o
> >>   CC       bench/mem-memset-x86-64-asm.o
> >>   CC       tests/hists_cumulate.o
> >>   CC       bench/numa.o
> >>   CC       util/cacheline.o
> >>   CC       arch/common.o
> >>   CC       arch/x86/util/header.o
> >>   CC       arch/x86/tests/regs_load.o
> >>   CC       arch/x86/tests/dwarf-unwind.o
> >>   CC       tests/python-use.o
> >>   CC       arch/x86/tests/arch-tests.o
> >>   CC       tests/bp_signal.o
> >>   CC       arch/x86/tests/rdpmc.o
> >>   CC       arch/x86/tests/perf-time-to-tsc.o
> >>   CC       arch/x86/util/tsc.o
> >>   CC       arch/x86/util/pmu.o
> >>   CC       arch/x86/util/kvm-stat.o
> >>   CC       arch/x86/tests/insn-x86.o
> >>   CC       tests/bp_signal_overflow.o
> >>   CC       arch/x86/tests/intel-pt-pkt-decoder-test.o
> >>   CC       arch/x86/util/perf_regs.o
> >>   CC       util/config.o
> >>   CC       arch/x86/tests/bp-modify.o
> >>   CC       util/copyfile.o
> >>   CC       ui/setup.o
> >>   CC       tests/bp_account.o
> >>   CC       arch/x86/util/group.o
> >>   CC       arch/x86/util/machine.o
> >>   LD       arch/x86/tests/perf-in.o
> >>   LD       bench/perf-in.o
> >>   CC       arch/x86/util/event.o
> >>   CC       ui/helpline.o
> >>   CC       ui/progress.o
> >>   CC       util/ctype.o
> >>   CC       tests/wp.o
> >>   CC       tests/task-exit.o
> >>   CC       util/db-export.o
> >>   CC       ui/util.o
> >>   CC       ui/hist.o
> >>   CC       arch/x86/util/dwarf-regs.o
> >>   CC       arch/x86/util/unwind-libunwind.o
> >>   CC       tests/sw-clock.o
> >>   CC       tests/mmap-thread-lookup.o
> >>   CC       tests/thread-maps-share.o
> >>   CC       util/env.o
> >>   CC       arch/x86/util/auxtrace.o
> >>   CC       tests/switch-tracking.o
> >>   CC       tests/keep-tracking.o
> >>   CC       arch/x86/util/archinsn.o
> >>   CC       util/event.o
> >>   CC       util/evlist.o
> >>   CC       util/sideband_evlist.o
> >>   CC       arch/x86/util/intel-pt.o
> >>   CC       tests/code-reading.o
> >>   CC       tests/sample-parsing.o
> >>   CC       tests/parse-no-sample-id-all.o
> >>   CC       tests/kmod-path.o
> >>   CC       tests/thread-map.o
> >>   CC       util/evsel.o
> >>   CC       util/evsel_fprintf.o
> >>   CC       arch/x86/util/intel-bts.o
> >>   CC       util/perf_event_attr_fprintf.o
> >>   CC       tests/llvm.o
> >>   CC       util/evswitch.o
> >>   CC       util/find_bit.o
> >>   CC       ui/stdio/hist.o
> >>   CC       tests/bpf.o
> >>   LD       arch/x86/util/perf-in.o
> >>   CC       util/get_current_dir_name.o
> >>   CC       tests/topology.o
> >>   LD       arch/x86/perf-in.o
> >>   CC       util/kallsyms.o
> >>   LD       arch/perf-in.o
> >>   CC       util/levenshtein.o
> >>   CC       util/llvm-utils.o
> >>   CC       tests/mem.o
> >>   CC       ui/browser.o
> >>   CC       util/mmap.o
> >>   CC       util/memswap.o
> >>   BISON    util/parse-events-bison.c
> >>   CC       tests/cpumap.o
> >>   CC       util/perf_regs.o
> >>   CC       ui/browsers/annotate.o
> >>   CC       scripts/perl/Perf-Trace-Util/Context.o
> >>   CC       trace/beauty/clone.o
> >>   CC       tests/stat.o
> >>   CC       util/path.o
> >>   CC       tests/event_update.o
> >>   CC       ui/tui/setup.o
> >>   CC       trace/beauty/fcntl.o
> >>   CC       util/print_binary.o
> >>   CC       util/rlimit.o
> >>   CC       tests/event-times.o
> >>   CC       ui/tui/util.o
> >>   CC       trace/beauty/flock.o
> >>   CC       util/argv_split.o
> >>   CC       util/rbtree.o
> >>   CC       tests/expr.o
> >>   CC       trace/beauty/fsmount.o
> >>   CC       ui/tui/helpline.o
> >>   CC       trace/beauty/fspick.o
> >>   CC       ui/tui/progress.o
> >>   CC       perf.o
> >>   CC       tests/backward-ring-buffer.o
> >>   LD       scripts/perl/Perf-Trace-Util/perf-in.o
> >>   CC       ui/browsers/hists.o
> >>   CC       scripts/python/Perf-Trace-Util/Context.o
> >>   CC       trace/beauty/ioctl.o
> >>   CC       trace/beauty/kcmp.o
> >>   CC       util/libstring.o
> >>   LD       ui/tui/perf-in.o
> >>   CC       util/bitmap.o
> >>   CC       trace/beauty/mount_flags.o
> >>   CC       trace/beauty/move_mount.o
> >>   CC       ui/browsers/map.o
> >>   CC       tests/sdt.o
> >>   LD       scripts/python/Perf-Trace-Util/perf-in.o
> >>   CC       util/hweight.o
> >>   LD       scripts/perf-in.o
> >>   CC       util/smt.o
> >>   CC       trace/beauty/pkey_alloc.o
> >>   CC       util/strbuf.o
> >>   CC       trace/beauty/arch_prctl.o
> >>   CC       ui/browsers/scripts.o
> >>   CC       trace/beauty/prctl.o
> >>   CC       trace/beauty/renameat.o
> >>   CC       util/string.o
> >>   CC       tests/is_printable_array.o
> >>   CC       ui/browsers/header.o
> >>   CC       tests/bitmap.o
> >>   CC       util/strlist.o
> >>   CC       trace/beauty/sockaddr.o
> >>   CC       ui/browsers/res_sample.o
> >>   CC       util/strfilter.o
> >>   CC       tests/perf-hooks.o
> >>   CC       tests/clang.o
> >>   CC       util/top.o
> >>   CC       tests/unit_number__scnprintf.o
> >>   CC       util/usage.o
> >>   CC       util/dso.o
> >>   CC       trace/beauty/socket.o
> >>   CC       tests/mem2node.o
> >>   CC       util/dsos.o
> >>   CC       trace/beauty/statx.o
> >>   CC       util/symbol.o
> >>   CC       tests/maps.o
> >>   CC       util/symbol_fprintf.o
> >>   CC       trace/beauty/sync_file_range.o
> >>   CC       util/color.o
> >>   CC       tests/time-utils-test.o
> >>   CC       trace/beauty/tracepoints/x86_irq_vectors.o
> >>   CC       util/color_config.o
> >>   CC       trace/beauty/tracepoints/x86_msr.o
> >>   CC       util/metricgroup.o
> >>   LD       trace/beauty/tracepoints/perf-in.o
> >>   CC       util/header.o
> >>   LD       trace/beauty/perf-in.o
> >>   CC       util/callchain.o
> >>   CC       tests/genelf.o
> >>   CC       tests/api-io.o
> >>   CC       util/values.o
> >>   CC       tests/demangle-java-test.o
> >>   CC       tests/pfm.o
> >>   CC       util/debug.o
> >>   CC       tests/dwarf-unwind.o
> >>   CC       util/fncache.o
> >>   CC       tests/llvm-src-base.o
> >>   CC       tests/llvm-src-kbuild.o
> >>   CC       tests/llvm-src-prologue.o
> >>   CC       util/machine.o
> >>   CC       util/map.o
> >>   CC       tests/llvm-src-relocation.o
> >>   CC       util/pstack.o
> >>   CC       util/session.o
> >>   LD       tests/perf-in.o
> >>   CC       util/sample-raw.o
> >>   CC       util/s390-sample-raw.o
> >>   CC       util/syscalltbl.o
> >>   CC       util/ordered-events.o
> >>   CC       util/namespaces.o
> >>   CC       util/comm.o
> >>   CC       util/thread.o
> >>   CC       util/thread_map.o
> >>   CC       util/trace-event-parse.o
> >>   CC       util/parse-events-bison.o
> >>   BISON    util/pmu-bison.c
> >>   CC       util/trace-event-read.o
> >>   CC       util/trace-event-info.o
> >>   CC       util/trace-event-scripting.o
> >>   CC       util/trace-event.o
> >>   CC       util/svghelper.o
> >>   CC       util/sort.o
> >>   CC       util/hist.o
> >>   CC       util/util.o
> >>   CC       util/cpumap.o
> >>   CC       util/affinity.o
> >>   CC       util/cputopo.o
> >>   CC       util/cgroup.o
> >>   CC       util/target.o
> >>   CC       util/rblist.o
> >>   CC       util/intlist.o
> >>   LD       ui/browsers/perf-in.o
> >>   LD       ui/perf-in.o
> >>   CC       util/vdso.o
> >>   CC       util/counts.o
> >>   CC       util/stat.o
> >>   CC       util/stat-shadow.o
> >>   CC       util/stat-display.o
> >>   CC       util/perf_api_probe.o
> >>   CC       util/record.o
> >>   CC       util/srcline.o
> >>   CC       util/srccode.o
> >>   CC       util/synthetic-events.o
> >>   CC       util/data.o
> >>   CC       util/tsc.o
> >>   CC       util/cloexec.o
> >>   CC       util/call-path.o
> >>   CC       util/thread-stack.o
> >>   CC       util/rwsem.o
> >>   CC       util/spark.o
> >>   CC       util/auxtrace.o
> >>   CC       util/intel-pt-decoder/intel-pt-pkt-decoder.o
> >>   CC       util/arm-spe-decoder/arm-spe-pkt-decoder.o
> >>   CC       util/arm-spe-decoder/arm-spe-decoder.o
> >>   GEN      util/intel-pt-decoder/inat-tables.c
> >>   CC       util/scripting-engines/trace-event-perl.o
> >>   CC       util/scripting-engines/trace-event-python.o
> >>   LD       util/arm-spe-decoder/perf-in.o
> >>   CC       util/intel-pt.o
> >>   CC       util/intel-pt-decoder/intel-pt-log.o
> >>   CC       util/intel-pt-decoder/intel-pt-decoder.o
> >>   CC       util/intel-pt-decoder/intel-pt-insn-decoder.o
> >>   CC       util/intel-bts.o
> >>   CC       util/arm-spe.o
> >>   CC       util/s390-cpumsf.o
> >>   CC       util/parse-branch-options.o
> >>   CC       util/dump-insn.o
> >>   CC       util/parse-regs-options.o
> >>   CC       util/term.o
> >>   CC       util/help-unknown-cmd.o
> >>   LD       util/scripting-engines/perf-in.o
> >>   CC       util/mem-events.o
> >>   CC       util/vsprintf.o
> >>   CC       util/units.o
> >>   LD       util/intel-pt-decoder/perf-in.o
> >>   CC       util/time-utils.o
> >>   BISON    util/expr-bison.c
> >>   CC       util/branch.o
> >>   CC       util/mem2node.o
> >>   CC       util/bpf-loader.o
> >>   CC       util/bpf_map.o
> >>   CC       util/bpf-prologue.o
> >>   CC       util/symbol-elf.o
> >>   CC       util/probe-file.o
> >>   CC       util/probe-event.o
> >>   CC       util/probe-finder.o
> >>   CC       util/dwarf-aux.o
> >>   CC       util/dwarf-regs.o
> >>   CC       util/unwind-libunwind-local.o
> >>   CC       util/unwind-libunwind.o
> >>   CC       util/data-convert-bt.o
> >>   CC       util/zlib.o
> >>   CC       util/lzma.o
> >>   CC       util/zstd.o
> >>   CC       util/cap.o
> >>   CC       util/demangle-java.o
> >>   CC       util/demangle-rust.o
> >>   CC       util/jitdump.o
> >>   CC       util/genelf.o
> >>   CC       util/genelf_debug.o
> >>   CC       util/perf-hooks.o
> >>   CC       util/bpf-event.o
> >>   FLEX     util/parse-events-flex.c
> >>   CC       util/pmu-bison.o
> >>   FLEX     util/pmu-flex.c
> >>   FLEX     util/expr-flex.c
> >>   CC       util/expr-bison.o
> >>   CC       util/parse-events.o
> >>   CC       util/parse-events-flex.o
> >>   CC       util/pmu.o
> >>   CC       util/pmu-flex.o
> >>   CC       util/expr.o
> >>   CC       util/expr-flex.o
> >>   LD       util/perf-in.o
> >>   LD       perf-in.o
> >>   LINK     perf
> >> make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf'
> >> 2020-07-15 06:37:48 cd /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f4=
1336b4462f69b011deb7cf37a2c3f8516/tools/perf
> >> 2020-07-15 06:37:48 mkdir -p /pkg
> >> 2020-07-15 06:37:48 mkdir -p /kbuild/obj/consumer/x86_64-rhel-8.3
> >> ignored_by_lkp: BPF filter
> >> ignored_by_lkp: LLVM search and compile
> >> ignored_by_lkp: vmlinux symtab matches kallsyms
> >> ignored_by_lkp: Add vfs_getname probe to get syscall args filenames
> >> ignored_by_lkp: Use vfs_getname probe to get syscall args filenames
> >> ignored_by_lkp: Check open filename arg using perf trace + vfs_getname
> >> ignored_by_lkp: builtin clang support
> >> 2020-07-15 06:37:49 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 2
> >>  2: Detect openat syscall event                           : Ok
> >> 2020-07-15 06:37:49 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 3
> >>  3: Detect openat syscall event on all cpus               : Ok
> >> 2020-07-15 06:37:49 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 4
> >>  4: Read samples using the mmap interface                 : Ok
> >> 2020-07-15 06:37:49 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 5
> >>  5: Test data source output                               : Ok
> >> 2020-07-15 06:37:49 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 6
> >>  6: Parse event definition strings                        : Ok
> >> 2020-07-15 06:37:49 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 7
> >>  7: Simple expression parser                              : Ok
> >> 2020-07-15 06:37:49 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 8
> >>  8: PERF_RECORD_* events & perf_sample fields             : Ok
> >> 2020-07-15 06:37:51 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 9
> >>  9: Parse perf pmu format                                 : Ok
> >> 2020-07-15 06:37:51 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 10
> >> 10: PMU events                                            :
> >> 10.1: PMU event table sanity                              : Ok
> >> 10.2: PMU event map aliases                               : Ok
> >> 10.3: Parsing of PMU event table metrics                  : Ok
> >> 2020-07-15 06:37:51 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 11
> >> 11: DSO data read                                         : Ok
> >> 2020-07-15 06:37:51 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 12
> >> 12: DSO data cache                                        : Ok
> >> 2020-07-15 06:37:51 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 13
> >> 13: DSO data reopen                                       : Ok
> >> 2020-07-15 06:37:51 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 14
> >> 14: Roundtrip evsel->name                                 : Ok
> >> 2020-07-15 06:37:51 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 15
> >> 15: Parse sched tracepoints fields                        : Ok
> >> 2020-07-15 06:37:51 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 16
> >> 16: syscalls:sys_enter_openat event fields                : Ok
> >> 2020-07-15 06:37:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 17
> >> 17: Setup struct perf_event_attr                          : Ok
> >> 2020-07-15 06:37:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 18
> >> 18: Match and link multiple hists                         : Ok
> >> 2020-07-15 06:37:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 19
> >> 19: 'import perf' in python                               : Ok
> >> 2020-07-15 06:37:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 20
> >> 20: Breakpoint overflow signal handler                    : Ok
> >> 2020-07-15 06:37:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 21
> >> 21: Breakpoint overflow sampling                          : Ok
> >> 2020-07-15 06:37:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 22
> >> 22: Breakpoint accounting                                 : Ok
> >> 2020-07-15 06:37:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 23
> >> 23: Watchpoint                                            :
> >> 23.1: Read Only Watchpoint                                : Skip
> >> 23.2: Write Only Watchpoint                               : Ok
> >> 23.3: Read / Write Watchpoint                             : Ok
> >> 23.4: Modify Watchpoint                                   : Ok
> >> 2020-07-15 06:37:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 24
> >> 24: Number of exit events of a simple workload            : Ok
> >> 2020-07-15 06:37:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 25
> >> 25: Software clock events period values                   : Ok
> >> 2020-07-15 06:37:58 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 26
> >> 26: Object code reading                                   : Ok
> >> 2020-07-15 06:37:58 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 27
> >> 27: Sample parsing                                        : Ok
> >> 2020-07-15 06:37:58 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 28
> >> 28: Use a dummy software event to keep tracking           : Ok
> >> 2020-07-15 06:37:58 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 29
> >> 29: Parse with no sample_id_all bit set                   : Ok
> >> 2020-07-15 06:37:58 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 30
> >> 30: Filter hist entries                                   : Ok
> >> 2020-07-15 06:37:58 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 31
> >> 31: Lookup mmap thread                                    : Ok
> >> 2020-07-15 06:37:58 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 32
> >> 32: Share thread maps                                     : Ok
> >> 2020-07-15 06:37:58 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 33
> >> 33: Sort output of hist entries                           : Ok
> >> 2020-07-15 06:37:58 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 34
> >> 34: Cumulate child hist entries                           : Ok
> >> 2020-07-15 06:37:58 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 35
> >> 35: Track with sched_switch                               : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 36
> >> 36: Filter fds with revents mask in a fdarray             : FAILED!
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 37
> >> 37: Add fd to a fdarray, making it autogrow               : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 38
> >> 38: kmod_path__parse                                      : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 39
> >> 39: Thread map                                            : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 41
> >> 41: Session topology                                      : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 43
> >> 43: Synthesize thread map                                 : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 44
> >> 44: Remove thread map                                     : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 45
> >> 45: Synthesize cpu map                                    : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 46
> >> 46: Synthesize stat config                                : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 47
> >> 47: Synthesize stat                                       : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 48
> >> 48: Synthesize stat round                                 : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 49
> >> 49: Synthesize attr update                                : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 50
> >> 50: Event times                                           : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 51
> >> 51: Read backward ring buffer                             : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 52
> >> 52: Print cpu map                                         : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 53
> >> 53: Merge cpu map                                         : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 54
> >> 54: Probe SDT events                                      : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 55
> >> 55: is_printable_array                                    : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 56
> >> 56: Print bitmap                                          : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 57
> >> 57: perf hooks                                            : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 59
> >> 59: unit_number__scnprintf                                : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 60
> >> 60: mem2node                                              : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 61
> >> 61: time utils                                            : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 62
> >> 62: Test jit_write_elf                                    : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 63
> >> 63: Test libpfm4 support                                  : Skip (not =
compiled in)
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 64
> >> 64: Test api io                                           : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 65
> >> 65: maps__merge_in                                        : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 66
> >> 66: Demangle Java                                         : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 67
> >> 67: x86 rdpmc                                             : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 68
> >> 68: Convert perf time to TSC                              : Ok
> >> 2020-07-15 06:37:59 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 69
> >> 69: DWARF unwind                                          : Ok
> >> 2020-07-15 06:38:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 70
> >> 70: x86 instruction decoder - new instructions            : Ok
> >> 2020-07-15 06:38:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 71
> >> 71: Intel PT packet decoder                               : Ok
> >> 2020-07-15 06:38:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 72
> >> 72: x86 bp modify                                         : Ok
> >> 2020-07-15 06:38:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 73
> >> 73: probe libc's inet_pton & backtrace it with ping       : Ok
> >> 2020-07-15 06:38:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7=
f41336b4462f69b011deb7cf37a2c3f8516/tools/perf/perf test 75
> >> 75: Zstd perf.data compression/decompression              : Ok
> >=20
> >> ---
> >>
> >> #! jobs/perf-sanity-tests.yaml
> >> suite: perf-sanity-tests
> >> testcase: perf-sanity-tests
> >> category: functional
> >> need_memory: 2G
> >> perf-sanity-tests:
> >>   perf_compiler: gcc
> >> job_origin: "/lkp-src/allot/cyclic:p2:linux-devel:devel-hourly/lkp-hsw=
-d02/perf-sanity-tests.yaml"
> >>
> >> #! queue options
> >> queue_cmdline_keys:
> >> - branch
> >> - commit
> >> queue: bisect
> >> testbox: lkp-hsw-d02
> >> tbox_group: lkp-hsw-d02
> >> kconfig: x86_64-rhel-8.3
> >> submit_id: 5f0e88a7132bb21574df4fd8
> >> job_file: "/lkp/jobs/scheduled/lkp-hsw-d02/perf-sanity-tests-gcc-ucode=
=3D0x28-debian-10.4-x86_64-20200603.cgz-8edd7f41336b4462f69b011deb7cf37a2c3=
f8516-20200715-5492-1fccmx1-0.yaml"
> >> id: 2d2f423953a299e0f9bb15b8e7860794fa16457e
> >> queuer_version: "/lkp-src"
> >>
> >> #! hosts/lkp-hsw-d02
> >> model: Haswell
> >> nr_node: 1
> >> nr_cpu: 8
> >> memory: 6G
> >> ssd_partitions:=20
> >> swap_partitions: LABEL=3DSWAP
> >> rootfs_partition: LABEL=3DLKP-ROOTFS
> >> brand: Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz
> >> LKP_SERVER: 10.239.97.5
> >> avoid_nfs: 1
> >> result_service: tmpfs
> >>
> >> #! include/category/functional
> >> kmsg:=20
> >> heartbeat:=20
> >> meminfo:=20
> >>
> >> #! include/perf-sanity-tests
> >> need_linux_perf: true
> >>
> >> #! include/queue/cyclic
> >> commit: 8edd7f41336b4462f69b011deb7cf37a2c3f8516
> >>
> >> #! include/testbox/lkp-hsw-d02
> >> ucode: '0x28'
> >> need_kconfig_hw:
> >> - CONFIG_E1000E=3Dy
> >> - CONFIG_SATA_AHCI
> >> enqueue_time: 2020-07-15 12:40:07.475089355 +08:00
> >> _id: 5f0e88a7132bb21574df4fd8
> >> _rt: "/result/perf-sanity-tests/gcc-ucode=3D0x28/lkp-hsw-d02/debian-10=
=2E4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8edd7f41336b4462f69b011deb7c=
f37a2c3f8516"
> >>
> >> #! schedule options
> >> user: lkp
> >> compiler: gcc-9
> >> head_commit: b133dfd9c7f8e13a45a57e21fda38f146badb9c1
> >> base_commit: 11ba468877bb23f28956a35e896356252d63c983
> >> branch: linux-devel/devel-hourly-2020071501
> >> rootfs: debian-10.4-x86_64-20200603.cgz
> >> result_root: "/result/perf-sanity-tests/gcc-ucode=3D0x28/lkp-hsw-d02/d=
ebian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8edd7f41336b4462f69b01=
1deb7cf37a2c3f8516/0"
> >> scheduler_version: "/lkp/lkp/.src-20200714-142103"
> >> arch: x86_64
> >> max_uptime: 3600
> >> initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
> >> bootloader_append:
> >> - root=3D/dev/ram0
> >> - user=3Dlkp
> >> - job=3D/lkp/jobs/scheduled/lkp-hsw-d02/perf-sanity-tests-gcc-ucode=3D=
0x28-debian-10.4-x86_64-20200603.cgz-8edd7f41336b4462f69b011deb7cf37a2c3f85=
16-20200715-5492-1fccmx1-0.yaml
> >> - ARCH=3Dx86_64
> >> - kconfig=3Dx86_64-rhel-8.3
> >> - branch=3Dlinux-devel/devel-hourly-2020071501
> >> - commit=3D8edd7f41336b4462f69b011deb7cf37a2c3f8516
> >> - BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/8edd7f41336b4462f69b01=
1deb7cf37a2c3f8516/vmlinuz-5.8.0-rc3-00047-g8edd7f41336b4
> >> - max_uptime=3D3600
> >> - RESULT_ROOT=3D/result/perf-sanity-tests/gcc-ucode=3D0x28/lkp-hsw-d02=
/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8edd7f41336b4462f69b=
011deb7cf37a2c3f8516/0
> >> - LKP_SERVER=3D10.239.97.5
> >> - nokaslr
> >> - selinux=3D0
> >> - debug
> >> - apic=3Ddebug
> >> - sysrq_always_enabled
> >> - rcupdate.rcu_cpu_stall_timeout=3D100
> >> - net.ifnames=3D0
> >> - printk.devkmsg=3Don
> >> - panic=3D-1
> >> - softlockup_panic=3D1
> >> - nmi_watchdog=3Dpanic
> >> - oops=3Dpanic
> >> - load_ramdisk=3D2
> >> - prompt_ramdisk=3D0
> >> - drbd.minor_count=3D8
> >> - systemd.log_level=3Derr
> >> - ignore_loglevel
> >> - console=3Dtty0
> >> - earlyprintk=3DttyS0,115200
> >> - console=3DttyS0,115200
> >> - vga=3Dnormal
> >> - rw
> >> modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/8edd7f41336b4462f69b=
011deb7cf37a2c3f8516/modules.cgz"
> >> bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig=
_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cg=
z,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/=
osimage/deps/debian-10.4-x86_64-20200603.cgz/perf-sanity-tests_20200709.cgz=
,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
> >> linux_perf_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/8edd7f41336b4462f=
69b011deb7cf37a2c3f8516/linux-perf.cgz"
> >> ucode_initrd: "/osimage/ucode/intel-ucode-20200610.cgz"
> >> lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
> >> site: inn
> >>
> >> #! /lkp/lkp/.src-20200714-142103/include/site/inn
> >> LKP_CGI_PORT: 80
> >> LKP_CIFS_PORT: 139
> >> oom-killer:=20
> >> watchdog:=20
> >>
> >> #! runtime status
> >> last_kernel: 5.8.0-rc5-05797-gb133dfd9c7f8e
> >> schedule_notify_address:=20
> >>
> >> #! user overrides
> >> kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/8edd7f41336b4462f69b011deb7c=
f37a2c3f8516/vmlinuz-5.8.0-rc3-00047-g8edd7f41336b4"
> >> dequeue_time: 2020-07-15 13:04:25.424323872 +08:00
> >> job_state: finished
> >> loadavg: 2.71 0.85 0.30 1/175 8234
> >> start_time: '1594790924'
> >> end_time: '1594790960'
> >> version: "/lkp/lkp/.src-20200714-142136:081aa00e:38eefe79c"
> >=20
> >> make ARCH=3D -C /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b44=
62f69b011deb7cf37a2c3f8516/tools/perf
> >> cd /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011deb7=
cf37a2c3f8516/tools/perf
> >> mkdir -p /pkg
> >> mkdir -p /kbuild/obj/consumer/x86_64-rhel-8.3
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 2
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 3
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 4
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 5
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 6
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 7
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 8
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 9
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 10
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 11
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 12
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 13
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 14
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 15
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 16
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 17
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 18
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 19
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 20
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 21
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 22
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 23
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 24
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 25
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 26
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 27
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 28
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 29
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 30
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 31
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 32
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 33
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 34
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 35
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 36
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 37
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 38
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 39
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 41
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 43
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 44
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 45
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 46
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 47
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 48
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 49
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 50
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 51
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 52
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 53
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 54
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 55
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 56
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 57
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 59
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 60
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 61
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 62
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 63
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 64
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 65
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 66
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 67
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 68
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 69
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 70
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 71
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 72
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 73
> >> sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8edd7f41336b4462f69b011de=
b7cf37a2c3f8516/tools/perf/perf test 75
> >=20
> >=20

--=20

- Arnaldo
