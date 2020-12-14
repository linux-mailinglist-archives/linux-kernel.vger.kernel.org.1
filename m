Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB2E2DA1C4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503243AbgLNUi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503244AbgLNU0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:26:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8B5C061282
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:25:38 -0800 (PST)
Date:   Mon, 14 Dec 2020 20:22:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607977536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5RRM15s/hbWr8eumhQ55fVjVksR6eCvgsCMdQx100ck=;
        b=J/8LXpVhCvGILUHiTPo5qF1/DzI0DNvFjJe751FojM9OP5IU0Y1Fpc1Eo54Glry4pAWZBR
        4CKBXY5mhHMhWyRhJK5JNVsS2OQreZSPh2703sBWMR5E1IPsJTg31HuKTRb/vZ5NQfry3T
        kjMGqTomqoidspBUZ6p4S60KIqiBjNrKgaADx2RyZPuwx9AWZ3UjR3E+ugMwfRh802NUBl
        KEgDYcRsijvxmmfXX/qGVw4EFJ/7qoFGfomFLMxg9YDYvfp+Vm1vCyvkHN6IvnG4P8OIzs
        xtivkXqil57D+rTkXkmCfMFg6qTu3jMz1M2LA/JUVvziX6DHhS3/0MKc9o2E7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607977536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5RRM15s/hbWr8eumhQ55fVjVksR6eCvgsCMdQx100ck=;
        b=uctFFYeMkqMvfbSjja4YW7ooRQ6jJpyYiA5NqHlZALo1UqLW0JGuClEltMwQb1NXK9lum8
        hSyXHZcd/iYStrAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/mm for v5.11-rc1
References: <160797732939.10793.9152151866806316627.tglx@nanos>
Message-ID: <160797734275.10793.2956447277890639251.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/mm branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-mm-2020-12-14

up to:  68061c02bb29: ARM: highmem: Fix cache_is_vivt() reference


The new preemtible kmap_local() implementation:

  - Consolidate all kmap_atomic() internals into a generic implementation
    which builds the base for the kmap_local() API and make the
    kmap_atomic() interface wrappers which handle the disabling/enabling of
    preemption and pagefaults.

  - Switch the storage from per-CPU to per task and provide scheduler
    support for clearing mapping when scheduling out and restoring them
    when scheduling back in.

  - Merge the migrate_disable/enable() code, which is also part of the
    scheduler pull request. This was required to make the kmap_local()
    interface available which does not disable preemption when a mapping
    is established. It has to disable migration instead to guarantee that
    the virtual address of the mapped slot is the same accross preemption.

  - Provide better debug facilities: guard pages and enforced utilization
    of the mapping mechanics on 64bit systems when the architecture allows
    it.

  - Provide the new kmap_local() API which can now be used to cleanup the
    kmap_atomic() usage sites all over the place. Most of the usage sites
    do not require the implicit disabling of preemption and pagefaults so
    the penalty on 64bit and 32bit non-highmem systems is removed and quite
    some of the code can be simplified. A wholesale conversion is not
    possible because some usage depends on the implicit side effects and
    some need to be cleaned up because they work around these side effects.

    The migrate disable side effect is only effective on highmem systems
    and when enforced debugging is enabled. On 64bit and 32bit non-highmem
    systems the overhead is completely avoided.


Thanks,

	tglx

------------------>
Arnd Bergmann (1):
      ARM: highmem: Fix cache_is_vivt() reference

Barry Song (1):
      Documentation: scheduler: fix information on arch SD flags, sched_domain and sched_debug

Daniel Jordan (1):
      cpuset: fix race between hotplug work and later CPU offline

Dietmar Eggemann (3):
      sched/cpupri: Remove pri_to_cpu[CPUPRI_IDLE]
      sched/cpupri: Remove pri_to_cpu[1]
      sched/uclamp: Allow to reset a task uclamp constraint value

Hui Su (1):
      sched/fair: Remove superfluous lock section in do_sched_cfs_slack_timer()

Ionela Voinescu (3):
      sched/topology,schedutil: Wrap sched domains rebuild
      arm64: Rebuild sched domains on invariance status changes
      sched/topology: Condition EAS enablement on FIE support

Julia Lawall (1):
      sched/fair: Check for idle core in wake_affine

Mathieu Desnoyers (3):
      sched: fix exit_mm vs membarrier (v4)
      sched: membarrier: cover kthread_use_mm (v4)
      sched: membarrier: document memory ordering scenarios

Peng Liu (2):
      sched/deadline: Optimize sched_dl_global_validate()
      sched/deadline: Fix sched_dl_global_validate()

Peng Wang (1):
      sched/fair: Reorder throttle_cfs_rq() path

Peter Zijlstra (18):
      sched/cpupri: Remap CPUPRI_NORMAL to MAX_RT_PRIO-1
      sched/cpupri: Add CPUPRI_HIGHER
      sched/fair: Exclude the current CPU from find_new_ilb()
      sched: Remove relyance on STRUCT_ALIGNMENT
      stop_machine: Add function and caller debug info
      sched: Fix balance_callback()
      sched/hotplug: Ensure only per-cpu kthreads run during hotplug
      workqueue: Manually break affinity on hotplug
      sched: Fix hotplug vs CPU bandwidth control
      sched: Massage set_cpus_allowed()
      sched: Add migrate_disable()
      sched: Fix migrate_disable() vs set_cpus_allowed_ptr()
      sched,rt: Use cpumask_any*_distribute()
      sched,rt: Use the full cpumask for balancing
      sched, lockdep: Annotate ->pi_lock recursion
      sched: Fix migrate_disable() vs rt/dl balancing
      sched/proc: Print accurate cpumask vs migrate_disable()
      sched: Fix migration_cpu_stop() WARN

Tal Zussman (1):
      sched/core: Fix typos in comments

Thomas Gleixner (37):
      sched: Reenable interrupts in do_sched_yield()
      mm/highmem: Un-EXPORT __kmap_atomic_idx()
      highmem: Remove unused functions
      fs: Remove asm/kmap_types.h includes
      sh/highmem: Remove all traces of unused cruft
      asm-generic: Provide kmap_size.h
      highmem: Provide generic variant of kmap_atomic*
      highmem: Make DEBUG_HIGHMEM functional
      x86/mm/highmem: Use generic kmap atomic implementation
      arc/mm/highmem: Use generic kmap atomic implementation
      ARM: highmem: Switch to generic kmap atomic
      csky/mm/highmem: Switch to generic kmap atomic
      microblaze/mm/highmem: Switch to generic kmap atomic
      mips/mm/highmem: Switch to generic kmap atomic
      nds32/mm/highmem: Switch to generic kmap atomic
      powerpc/mm/highmem: Switch to generic kmap atomic
      sparc/mm/highmem: Switch to generic kmap atomic
      xtensa/mm/highmem: Switch to generic kmap atomic
      highmem: Get rid of kmap_types.h
      mm/highmem: Remove the old kmap_atomic cruft
      io-mapping: Cleanup atomic iomap
      Documentation/io-mapping: Remove outdated blurb
      highmem: High implementation details and document API
      sched/core: Wait for tasks being pushed away on hotplug
      sched/hotplug: Consolidate task migration on CPU unplug
      sched/core: Make migrate disable and CPU hotplug cooperative
      mm/highmem: Take kmap_high_get() properly into account
      xtensa/mm/highmem: Make generic kmap_atomic() work correctly
      microblaze/mm/highmem: Add dropped #ifdef back
      sched: Make migrate_disable/enable() independent of RT
      mm/highmem: Provide and use CONFIG_DEBUG_KMAP_LOCAL
      mm/highmem: Provide CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
      x86: Support kmap_local() forced debugging
      sched: highmem: Store local kmaps in task struct
      mm/highmem: Provide kmap_local*
      io-mapping: Provide iomap_local variant
      x86/crashdump/32: Simplify copy_oldmem_page()

Valentin Schneider (7):
      sched: Deny self-issued __set_cpus_allowed_ptr() when migrate_disable()
      sched: Comment affine_move_task()
      sched: Add WF_TTWU, WF_EXEC wakeup flags
      sched: Remove select_task_rq()'s sd_flag parameter
      sched/fair: Dissociate wakeup decisions from SD flag value
      sched/core: Add missing completion for affine_move_task() waiters
      sched/topology: Warn when NUMA diameter > 2

jun qian (1):
      sched/fair: Improve the accuracy of sched_stat_wait statistics


 Documentation/driver-api/io-mapping.rst   |   96 ++-
 Documentation/scheduler/sched-domains.rst |   26 +-
 arch/alpha/include/asm/kmap_types.h       |   15 -
 arch/arc/Kconfig                          |    1 +
 arch/arc/include/asm/highmem.h            |   26 +-
 arch/arc/include/asm/kmap_types.h         |   14 -
 arch/arc/mm/highmem.c                     |   54 +-
 arch/arm/Kconfig                          |    1 +
 arch/arm/include/asm/fixmap.h             |    4 +-
 arch/arm/include/asm/highmem.h            |   34 +-
 arch/arm/include/asm/kmap_types.h         |   10 -
 arch/arm/mm/Makefile                      |    1 -
 arch/arm/mm/highmem.c                     |  121 ----
 arch/arm64/kernel/topology.c              |   10 +
 arch/csky/Kconfig                         |    1 +
 arch/csky/include/asm/fixmap.h            |    4 +-
 arch/csky/include/asm/highmem.h           |    6 +-
 arch/csky/mm/highmem.c                    |   75 +-
 arch/ia64/include/asm/kmap_types.h        |   13 -
 arch/microblaze/Kconfig                   |    1 +
 arch/microblaze/include/asm/fixmap.h      |    4 +-
 arch/microblaze/include/asm/highmem.h     |    6 +-
 arch/microblaze/mm/Makefile               |    1 -
 arch/microblaze/mm/highmem.c              |   78 --
 arch/microblaze/mm/init.c                 |    5 -
 arch/mips/Kconfig                         |    1 +
 arch/mips/include/asm/fixmap.h            |    4 +-
 arch/mips/include/asm/highmem.h           |    6 +-
 arch/mips/include/asm/kmap_types.h        |   13 -
 arch/mips/mm/highmem.c                    |   77 --
 arch/mips/mm/init.c                       |    4 -
 arch/nds32/Kconfig.cpu                    |    1 +
 arch/nds32/include/asm/fixmap.h           |    4 +-
 arch/nds32/include/asm/highmem.h          |   22 +-
 arch/nds32/mm/Makefile                    |    1 -
 arch/nds32/mm/highmem.c                   |   48 --
 arch/openrisc/mm/init.c                   |    1 -
 arch/openrisc/mm/ioremap.c                |    1 -
 arch/parisc/include/asm/kmap_types.h      |   13 -
 arch/powerpc/Kconfig                      |    1 +
 arch/powerpc/include/asm/fixmap.h         |    4 +-
 arch/powerpc/include/asm/highmem.h        |    7 +-
 arch/powerpc/include/asm/kmap_types.h     |   13 -
 arch/powerpc/mm/Makefile                  |    1 -
 arch/powerpc/mm/highmem.c                 |   67 --
 arch/powerpc/mm/mem.c                     |    7 -
 arch/sh/include/asm/fixmap.h              |    8 -
 arch/sh/include/asm/kmap_types.h          |   15 -
 arch/sh/mm/init.c                         |    8 -
 arch/sparc/Kconfig                        |    1 +
 arch/sparc/include/asm/highmem.h          |    8 +-
 arch/sparc/include/asm/kmap_types.h       |   11 -
 arch/sparc/include/asm/vaddrs.h           |    4 +-
 arch/sparc/mm/Makefile                    |    3 -
 arch/sparc/mm/highmem.c                   |  115 ---
 arch/sparc/mm/srmmu.c                     |    2 -
 arch/um/include/asm/fixmap.h              |    1 -
 arch/um/include/asm/kmap_types.h          |   13 -
 arch/x86/Kconfig                          |    4 +-
 arch/x86/include/asm/fixmap.h             |   15 +-
 arch/x86/include/asm/highmem.h            |   13 +-
 arch/x86/include/asm/iomap.h              |   13 +-
 arch/x86/include/asm/kmap_types.h         |   13 -
 arch/x86/include/asm/paravirt_types.h     |    1 -
 arch/x86/include/asm/pgtable_64_types.h   |    6 +-
 arch/x86/kernel/crash_dump_32.c           |   48 +-
 arch/x86/mm/highmem_32.c                  |   59 --
 arch/x86/mm/init_32.c                     |   15 -
 arch/x86/mm/iomap_32.c                    |   57 +-
 arch/xtensa/Kconfig                       |    1 +
 arch/xtensa/include/asm/fixmap.h          |   59 +-
 arch/xtensa/include/asm/highmem.h         |   15 +-
 arch/xtensa/mm/highmem.c                  |   62 +-
 arch/xtensa/mm/init.c                     |    4 +-
 arch/xtensa/mm/mmu.c                      |    3 +-
 fs/aio.c                                  |    1 -
 fs/btrfs/ctree.h                          |    1 -
 fs/proc/array.c                           |    4 +-
 include/asm-generic/Kbuild                |    2 +-
 include/asm-generic/kmap_size.h           |   12 +
 include/asm-generic/kmap_types.h          |   11 -
 include/linux/cpuhotplug.h                |    1 +
 include/linux/cpumask.h                   |    6 +
 include/linux/highmem-internal.h          |  232 ++++++
 include/linux/highmem.h                   |  294 +++-----
 include/linux/io-mapping.h                |   38 +-
 include/linux/kernel.h                    |   21 +-
 include/linux/preempt.h                   |   83 ++-
 include/linux/sched.h                     |   14 +
 include/linux/sched/hotplug.h             |    2 +
 include/linux/sched/mm.h                  |    5 +
 include/linux/sched/topology.h            |    8 +
 include/linux/stop_machine.h              |    5 +
 include/uapi/linux/sched/types.h          |    2 +
 kernel/cgroup/cpuset.c                    |   33 +-
 kernel/cpu.c                              |    9 +-
 kernel/entry/common.c                     |    2 +
 kernel/exit.c                             |   16 +-
 kernel/fork.c                             |    1 +
 kernel/kthread.c                          |   21 +
 kernel/sched/core.c                       | 1101 +++++++++++++++++++++++------
 kernel/sched/cpudeadline.c                |    4 +-
 kernel/sched/cpufreq_schedutil.c          |    9 +-
 kernel/sched/cpupri.c                     |   52 +-
 kernel/sched/cpupri.h                     |    8 +-
 kernel/sched/deadline.c                   |  101 ++-
 kernel/sched/fair.c                       |   70 +-
 kernel/sched/idle.c                       |    7 +-
 kernel/sched/membarrier.c                 |  147 +++-
 kernel/sched/rt.c                         |   99 ++-
 kernel/sched/sched.h                      |  150 +++-
 kernel/sched/stop_task.c                  |    5 +-
 kernel/sched/topology.c                   |   61 +-
 kernel/stop_machine.c                     |   27 +-
 kernel/workqueue.c                        |    4 +
 lib/Kconfig.debug                         |   22 +
 lib/cpumask.c                             |   18 +
 lib/dump_stack.c                          |    2 +
 lib/smp_processor_id.c                    |    5 +
 mm/Kconfig                                |    3 +
 mm/highmem.c                              |  272 ++++++-
 121 files changed, 2603 insertions(+), 1868 deletions(-)
 delete mode 100644 arch/alpha/include/asm/kmap_types.h
 delete mode 100644 arch/arc/include/asm/kmap_types.h
 delete mode 100644 arch/arm/include/asm/kmap_types.h
 delete mode 100644 arch/arm/mm/highmem.c
 delete mode 100644 arch/ia64/include/asm/kmap_types.h
 delete mode 100644 arch/microblaze/mm/highmem.c
 delete mode 100644 arch/mips/include/asm/kmap_types.h
 delete mode 100644 arch/nds32/mm/highmem.c
 delete mode 100644 arch/parisc/include/asm/kmap_types.h
 delete mode 100644 arch/powerpc/include/asm/kmap_types.h
 delete mode 100644 arch/powerpc/mm/highmem.c
 delete mode 100644 arch/sh/include/asm/kmap_types.h
 delete mode 100644 arch/sparc/include/asm/kmap_types.h
 delete mode 100644 arch/sparc/mm/highmem.c
 delete mode 100644 arch/um/include/asm/kmap_types.h
 delete mode 100644 arch/x86/include/asm/kmap_types.h
 create mode 100644 include/asm-generic/kmap_size.h
 delete mode 100644 include/asm-generic/kmap_types.h
 create mode 100644 include/linux/highmem-internal.h

diff --git a/Documentation/driver-api/io-mapping.rst b/Documentation/driver-api/io-mapping.rst
index a966239f04e4..a0cfb15988df 100644
--- a/Documentation/driver-api/io-mapping.rst
+++ b/Documentation/driver-api/io-mapping.rst
@@ -20,78 +20,72 @@ A mapping object is created during driver initialization using::
 mappable, while 'size' indicates how large a mapping region to
 enable. Both are in bytes.
 
-This _wc variant provides a mapping which may only be used
-with the io_mapping_map_atomic_wc or io_mapping_map_wc.
+This _wc variant provides a mapping which may only be used with
+io_mapping_map_atomic_wc(), io_mapping_map_local_wc() or
+io_mapping_map_wc().
 
-With this mapping object, individual pages can be mapped either atomically
-or not, depending on the necessary scheduling environment. Of course, atomic
-maps are more efficient::
+With this mapping object, individual pages can be mapped either temporarily
+or long term, depending on the requirements. Of course, temporary maps are
+more efficient. They come in two flavours::
+
+	void *io_mapping_map_local_wc(struct io_mapping *mapping,
+				      unsigned long offset)
 
 	void *io_mapping_map_atomic_wc(struct io_mapping *mapping,
 				       unsigned long offset)
 
-'offset' is the offset within the defined mapping region.
-Accessing addresses beyond the region specified in the
-creation function yields undefined results. Using an offset
-which is not page aligned yields an undefined result. The
-return value points to a single page in CPU address space.
+'offset' is the offset within the defined mapping region.  Accessing
+addresses beyond the region specified in the creation function yields
+undefined results. Using an offset which is not page aligned yields an
+undefined result. The return value points to a single page in CPU address
+space.
 
-This _wc variant returns a write-combining map to the
-page and may only be used with mappings created by
-io_mapping_create_wc
+This _wc variant returns a write-combining map to the page and may only be
+used with mappings created by io_mapping_create_wc()
 
-Note that the task may not sleep while holding this page
-mapped.
+Temporary mappings are only valid in the context of the caller. The mapping
+is not guaranteed to be globaly visible.
 
-::
+io_mapping_map_local_wc() has a side effect on X86 32bit as it disables
+migration to make the mapping code work. No caller can rely on this side
+effect.
 
-	void io_mapping_unmap_atomic(void *vaddr)
+io_mapping_map_atomic_wc() has the side effect of disabling preemption and
+pagefaults. Don't use in new code. Use io_mapping_map_local_wc() instead.
+
+Nested mappings need to be undone in reverse order because the mapping
+code uses a stack for keeping track of them::
 
-'vaddr' must be the value returned by the last
-io_mapping_map_atomic_wc call. This unmaps the specified
-page and allows the task to sleep once again.
+ addr1 = io_mapping_map_local_wc(map1, offset1);
+ addr2 = io_mapping_map_local_wc(map2, offset2);
+ ...
+ io_mapping_unmap_local(addr2);
+ io_mapping_unmap_local(addr1);
+
+The mappings are released with::
+
+	void io_mapping_unmap_local(void *vaddr)
+	void io_mapping_unmap_atomic(void *vaddr)
 
-If you need to sleep while holding the lock, you can use the non-atomic
-variant, although they may be significantly slower.
+'vaddr' must be the value returned by the last io_mapping_map_local_wc() or
+io_mapping_map_atomic_wc() call. This unmaps the specified mapping and
+undoes the side effects of the mapping functions.
 
-::
+If you need to sleep while holding a mapping, you can use the regular
+variant, although this may be significantly slower::
 
 	void *io_mapping_map_wc(struct io_mapping *mapping,
 				unsigned long offset)
 
-This works like io_mapping_map_atomic_wc except it allows
-the task to sleep while holding the page mapped.
+This works like io_mapping_map_atomic/local_wc() except it has no side
+effects and the pointer is globaly visible.
 
-
-::
+The mappings are released with::
 
 	void io_mapping_unmap(void *vaddr)
 
-This works like io_mapping_unmap_atomic, except it is used
-for pages mapped with io_mapping_map_wc.
+Use for pages mapped with io_mapping_map_wc().
 
 At driver close time, the io_mapping object must be freed::
 
 	void io_mapping_free(struct io_mapping *mapping)
-
-Current Implementation
-======================
-
-The initial implementation of these functions uses existing mapping
-mechanisms and so provides only an abstraction layer and no new
-functionality.
-
-On 64-bit processors, io_mapping_create_wc calls ioremap_wc for the whole
-range, creating a permanent kernel-visible mapping to the resource. The
-map_atomic and map functions add the requested offset to the base of the
-virtual address returned by ioremap_wc.
-
-On 32-bit processors with HIGHMEM defined, io_mapping_map_atomic_wc uses
-kmap_atomic_pfn to map the specified page in an atomic fashion;
-kmap_atomic_pfn isn't really supposed to be used with device pages, but it
-provides an efficient mapping for this usage.
-
-On 32-bit processors without HIGHMEM defined, io_mapping_map_atomic_wc and
-io_mapping_map_wc both use ioremap_wc, a terribly inefficient function which
-performs an IPI to inform all processors about the new mapping. This results
-in a significant performance penalty.
diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/scheduler/sched-domains.rst
index 5c4b7f4f0062..8582fa5e9170 100644
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -65,21 +65,17 @@ of the SMP domain will span the entire machine, with each group having the
 cpumask of a node. Or, you could do multi-level NUMA or Opteron, for example,
 might have just one domain covering its one NUMA level.
 
-The implementor should read comments in include/linux/sched.h:
-struct sched_domain fields, SD_FLAG_*, SD_*_INIT to get an idea of
-the specifics and what to tune.
+The implementor should read comments in include/linux/sched/sd_flags.h:
+SD_* to get an idea of the specifics and what to tune for the SD flags
+of a sched_domain.
 
-Architectures may retain the regular override the default SD_*_INIT flags
-while using the generic domain builder in kernel/sched/core.c if they wish to
-retain the traditional SMT->SMP->NUMA topology (or some subset of that). This
-can be done by #define'ing ARCH_HASH_SCHED_TUNE.
-
-Alternatively, the architecture may completely override the generic domain
-builder by #define'ing ARCH_HASH_SCHED_DOMAIN, and exporting your
-arch_init_sched_domains function. This function will attach domains to all
-CPUs using cpu_attach_domain.
+Architectures may override the generic domain builder and the default SD flags
+for a given topology level by creating a sched_domain_topology_level array and
+calling set_sched_topology() with this array as the parameter.
 
 The sched-domains debugging infrastructure can be enabled by enabling
-CONFIG_SCHED_DEBUG. This enables an error checking parse of the sched domains
-which should catch most possible errors (described above). It also prints out
-the domain structure in a visual format.
+CONFIG_SCHED_DEBUG and adding 'sched_debug' to your cmdline. If you forgot to
+tweak your cmdline, you can also flip the /sys/kernel/debug/sched_debug
+knob. This enables an error checking parse of the sched domains which should
+catch most possible errors (described above). It also prints out the domain
+structure in a visual format.
diff --git a/arch/alpha/include/asm/kmap_types.h b/arch/alpha/include/asm/kmap_types.h
deleted file mode 100644
index 651714b45729..000000000000
--- a/arch/alpha/include/asm/kmap_types.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-/* Dummy header just to define km_type. */
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define  __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 0a89cc9def65..d8804001d550 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -507,6 +507,7 @@ config LINUX_RAM_BASE
 config HIGHMEM
 	bool "High Memory Support"
 	select ARCH_DISCONTIGMEM_ENABLE
+	select KMAP_LOCAL
 	help
 	  With ARC 2G:2G address split, only upper 2G is directly addressable by
 	  kernel. Enable this to potentially allow access to rest of 2G and PAE
diff --git a/arch/arc/include/asm/highmem.h b/arch/arc/include/asm/highmem.h
index 6e5eafb3afdd..a6b8e2c352c4 100644
--- a/arch/arc/include/asm/highmem.h
+++ b/arch/arc/include/asm/highmem.h
@@ -9,17 +9,29 @@
 #ifdef CONFIG_HIGHMEM
 
 #include <uapi/asm/page.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
+
+#define FIXMAP_SIZE		PGDIR_SIZE
+#define PKMAP_SIZE		PGDIR_SIZE
 
 /* start after vmalloc area */
 #define FIXMAP_BASE		(PAGE_OFFSET - FIXMAP_SIZE - PKMAP_SIZE)
-#define FIXMAP_SIZE		PGDIR_SIZE	/* only 1 PGD worth */
-#define KM_TYPE_NR		((FIXMAP_SIZE >> PAGE_SHIFT)/NR_CPUS)
-#define FIXMAP_ADDR(nr)		(FIXMAP_BASE + ((nr) << PAGE_SHIFT))
+
+#define FIX_KMAP_SLOTS		(KM_MAX_IDX * NR_CPUS)
+#define FIX_KMAP_BEGIN		(0UL)
+#define FIX_KMAP_END		((FIX_KMAP_BEGIN + FIX_KMAP_SLOTS) - 1)
+
+#define FIXADDR_TOP		(FIXMAP_BASE + (FIX_KMAP_END << PAGE_SHIFT))
+
+/*
+ * This should be converted to the asm-generic version, but of course this
+ * is needlessly different from all other architectures. Sigh - tglx
+ */
+#define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
+#define __virt_to_fix(x)	(((FIXADDR_TOP - ((x) & PAGE_MASK))) >> PAGE_SHIFT)
 
 /* start after fixmap area */
 #define PKMAP_BASE		(FIXMAP_BASE + FIXMAP_SIZE)
-#define PKMAP_SIZE		PGDIR_SIZE
 #define LAST_PKMAP		(PKMAP_SIZE >> PAGE_SHIFT)
 #define LAST_PKMAP_MASK		(LAST_PKMAP - 1)
 #define PKMAP_ADDR(nr)		(PKMAP_BASE + ((nr) << PAGE_SHIFT))
@@ -29,11 +41,13 @@
 
 extern void kmap_init(void);
 
+#define arch_kmap_local_post_unmap(vaddr)			\
+	local_flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE)
+
 static inline void flush_cache_kmaps(void)
 {
 	flush_cache_all();
 }
-
 #endif
 
 #endif
diff --git a/arch/arc/include/asm/kmap_types.h b/arch/arc/include/asm/kmap_types.h
deleted file mode 100644
index fecf7851ec32..000000000000
--- a/arch/arc/include/asm/kmap_types.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2015 Synopsys, Inc. (www.synopsys.com)
- */
-
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-/*
- * We primarily need to define KM_TYPE_NR here but that in turn
- * is a function of PGDIR_SIZE etc.
- * To avoid circular deps issue, put everything in asm/highmem.h
- */
-#endif
diff --git a/arch/arc/mm/highmem.c b/arch/arc/mm/highmem.c
index 1b9f473c6369..c79912a6b196 100644
--- a/arch/arc/mm/highmem.c
+++ b/arch/arc/mm/highmem.c
@@ -36,9 +36,8 @@
  *   This means each only has 1 PGDIR_SIZE worth of kvaddr mappings, which means
  *   2M of kvaddr space for typical config (8K page and 11:8:13 traversal split)
  *
- * - fixmap anyhow needs a limited number of mappings. So 2M kvaddr == 256 PTE
- *   slots across NR_CPUS would be more than sufficient (generic code defines
- *   KM_TYPE_NR as 20).
+ * - The fixed KMAP slots for kmap_local/atomic() require KM_MAX_IDX slots per
+ *   CPU. So the number of CPUs sharing a single PTE page is limited.
  *
  * - pkmap being preemptible, in theory could do with more than 256 concurrent
  *   mappings. However, generic pkmap code: map_new_virtual(), doesn't traverse
@@ -47,48 +46,6 @@
  */
 
 extern pte_t * pkmap_page_table;
-static pte_t * fixmap_page_table;
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	int idx, cpu_idx;
-	unsigned long vaddr;
-
-	cpu_idx = kmap_atomic_idx_push();
-	idx = cpu_idx + KM_TYPE_NR * smp_processor_id();
-	vaddr = FIXMAP_ADDR(idx);
-
-	set_pte_at(&init_mm, vaddr, fixmap_page_table + idx,
-		   mk_pte(page, prot));
-
-	return (void *)vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kv)
-{
-	unsigned long kvaddr = (unsigned long)kv;
-
-	if (kvaddr >= FIXMAP_BASE && kvaddr < (FIXMAP_BASE + FIXMAP_SIZE)) {
-
-		/*
-		 * Because preemption is disabled, this vaddr can be associated
-		 * with the current allocated index.
-		 * But in case of multiple live kmap_atomic(), it still relies on
-		 * callers to unmap in right order.
-		 */
-		int cpu_idx = kmap_atomic_idx();
-		int idx = cpu_idx + KM_TYPE_NR * smp_processor_id();
-
-		WARN_ON(kvaddr != FIXMAP_ADDR(idx));
-
-		pte_clear(&init_mm, kvaddr, fixmap_page_table + idx);
-		local_flush_tlb_kernel_range(kvaddr, kvaddr + PAGE_SIZE);
-
-		kmap_atomic_idx_pop();
-	}
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
 
 static noinline pte_t * __init alloc_kmap_pgtable(unsigned long kvaddr)
 {
@@ -108,10 +65,9 @@ void __init kmap_init(void)
 {
 	/* Due to recursive include hell, we can't do this in processor.h */
 	BUILD_BUG_ON(PAGE_OFFSET < (VMALLOC_END + FIXMAP_SIZE + PKMAP_SIZE));
+	BUILD_BUG_ON(LAST_PKMAP > PTRS_PER_PTE);
+	BUILD_BUG_ON(FIX_KMAP_SLOTS > PTRS_PER_PTE);
 
-	BUILD_BUG_ON(KM_TYPE_NR > PTRS_PER_PTE);
 	pkmap_page_table = alloc_kmap_pgtable(PKMAP_BASE);
-
-	BUILD_BUG_ON(LAST_PKMAP > PTRS_PER_PTE);
-	fixmap_page_table = alloc_kmap_pgtable(FIXMAP_BASE);
+	alloc_kmap_pgtable(FIXMAP_BASE);
 }
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fe2f17eb2b50..46f890083607 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1498,6 +1498,7 @@ config HAVE_ARCH_PFN_VALID
 config HIGHMEM
 	bool "High Memory Support"
 	depends on MMU
+	select KMAP_LOCAL
 	help
 	  The address space of ARM processors is only 4 Gigabytes large
 	  and it has to accommodate user address space, kernel address
diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
index fc56fc3e1931..c279a8a463a2 100644
--- a/arch/arm/include/asm/fixmap.h
+++ b/arch/arm/include/asm/fixmap.h
@@ -7,14 +7,14 @@
 #define FIXADDR_TOP		(FIXADDR_END - PAGE_SIZE)
 
 #include <linux/pgtable.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 
 enum fixed_addresses {
 	FIX_EARLYCON_MEM_BASE,
 	__end_of_permanent_fixed_addresses,
 
 	FIX_KMAP_BEGIN = __end_of_permanent_fixed_addresses,
-	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR * NR_CPUS) - 1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
 
 	/* Support writing RO kernel text via kprobes, jump labels, etc. */
 	FIX_TEXT_POKE0,
diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
index 31811be38d78..b4b66220952d 100644
--- a/arch/arm/include/asm/highmem.h
+++ b/arch/arm/include/asm/highmem.h
@@ -2,7 +2,8 @@
 #ifndef _ASM_HIGHMEM_H
 #define _ASM_HIGHMEM_H
 
-#include <asm/kmap_types.h>
+#include <asm/cachetype.h>
+#include <asm/fixmap.h>
 
 #define PKMAP_BASE		(PAGE_OFFSET - PMD_SIZE)
 #define LAST_PKMAP		PTRS_PER_PTE
@@ -46,19 +47,32 @@ extern pte_t *pkmap_page_table;
 
 #ifdef ARCH_NEEDS_KMAP_HIGH_GET
 extern void *kmap_high_get(struct page *page);
-#else
+
+static inline void *arch_kmap_local_high_get(struct page *page)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !cache_is_vivt())
+		return NULL;
+	return kmap_high_get(page);
+}
+#define arch_kmap_local_high_get arch_kmap_local_high_get
+
+#else /* ARCH_NEEDS_KMAP_HIGH_GET */
 static inline void *kmap_high_get(struct page *page)
 {
 	return NULL;
 }
-#endif
+#endif /* !ARCH_NEEDS_KMAP_HIGH_GET */
 
-/*
- * The following functions are already defined by <linux/highmem.h>
- * when CONFIG_HIGHMEM is not set.
- */
-#ifdef CONFIG_HIGHMEM
-extern void *kmap_atomic_pfn(unsigned long pfn);
-#endif
+#define arch_kmap_local_post_map(vaddr, pteval)				\
+	local_flush_tlb_kernel_page(vaddr)
+
+#define arch_kmap_local_pre_unmap(vaddr)				\
+do {									\
+	if (cache_is_vivt())						\
+		__cpuc_flush_dcache_area((void *)vaddr, PAGE_SIZE);	\
+} while (0)
+
+#define arch_kmap_local_post_unmap(vaddr)				\
+	local_flush_tlb_kernel_page(vaddr)
 
 #endif
diff --git a/arch/arm/include/asm/kmap_types.h b/arch/arm/include/asm/kmap_types.h
deleted file mode 100644
index 5590940ee43d..000000000000
--- a/arch/arm/include/asm/kmap_types.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ARM_KMAP_TYPES_H
-#define __ARM_KMAP_TYPES_H
-
-/*
- * This is the "bare minimum".  AIO seems to require this.
- */
-#define KM_TYPE_NR 16
-
-#endif
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 7cb1699fbfc4..c4ce477c5261 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_MODULES)		+= proc-syms.o
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
 
 obj-$(CONFIG_ALIGNMENT_TRAP)	+= alignment.o
-obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_ARM_PV_FIXUP)	+= pv-fixup-asm.o
 
diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
deleted file mode 100644
index 187fab227b50..000000000000
--- a/arch/arm/mm/highmem.c
+++ /dev/null
@@ -1,121 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * arch/arm/mm/highmem.c -- ARM highmem support
- *
- * Author:	Nicolas Pitre
- * Created:	september 8, 2008
- * Copyright:	Marvell Semiconductors Inc.
- */
-
-#include <linux/module.h>
-#include <linux/highmem.h>
-#include <linux/interrupt.h>
-#include <asm/fixmap.h>
-#include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
-#include "mm.h"
-
-static inline void set_fixmap_pte(int idx, pte_t pte)
-{
-	unsigned long vaddr = __fix_to_virt(idx);
-	pte_t *ptep = virt_to_kpte(vaddr);
-
-	set_pte_ext(ptep, pte, 0);
-	local_flush_tlb_kernel_page(vaddr);
-}
-
-static inline pte_t get_fixmap_pte(unsigned long vaddr)
-{
-	pte_t *ptep = virt_to_kpte(vaddr);
-
-	return *ptep;
-}
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned int idx;
-	unsigned long vaddr;
-	void *kmap;
-	int type;
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-	/*
-	 * There is no cache coherency issue when non VIVT, so force the
-	 * dedicated kmap usage for better debugging purposes in that case.
-	 */
-	if (!cache_is_vivt())
-		kmap = NULL;
-	else
-#endif
-		kmap = kmap_high_get(page);
-	if (kmap)
-		return kmap;
-
-	type = kmap_atomic_idx_push();
-
-	idx = FIX_KMAP_BEGIN + type + KM_TYPE_NR * smp_processor_id();
-	vaddr = __fix_to_virt(idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
-	/*
-	 * With debugging enabled, kunmap_atomic forces that entry to 0.
-	 * Make sure it was indeed properly unmapped.
-	 */
-	BUG_ON(!pte_none(get_fixmap_pte(vaddr)));
-#endif
-	/*
-	 * When debugging is off, kunmap_atomic leaves the previous mapping
-	 * in place, so the contained TLB flush ensures the TLB is updated
-	 * with the new mapping.
-	 */
-	set_fixmap_pte(idx, mk_pte(page, prot));
-
-	return (void *)vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	int idx, type;
-
-	if (kvaddr >= (void *)FIXADDR_START) {
-		type = kmap_atomic_idx();
-		idx = FIX_KMAP_BEGIN + type + KM_TYPE_NR * smp_processor_id();
-
-		if (cache_is_vivt())
-			__cpuc_flush_dcache_area((void *)vaddr, PAGE_SIZE);
-#ifdef CONFIG_DEBUG_HIGHMEM
-		BUG_ON(vaddr != __fix_to_virt(idx));
-		set_fixmap_pte(idx, __pte(0));
-#else
-		(void) idx;  /* to kill a warning */
-#endif
-		kmap_atomic_idx_pop();
-	} else if (vaddr >= PKMAP_ADDR(0) && vaddr < PKMAP_ADDR(LAST_PKMAP)) {
-		/* this address was obtained through kmap_high_get() */
-		kunmap_high(pte_page(pkmap_page_table[PKMAP_NR(vaddr)]));
-	}
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
-
-void *kmap_atomic_pfn(unsigned long pfn)
-{
-	unsigned long vaddr;
-	int idx, type;
-	struct page *page = pfn_to_page(pfn);
-
-	preempt_disable();
-	pagefault_disable();
-	if (!PageHighMem(page))
-		return page_address(page);
-
-	type = kmap_atomic_idx_push();
-	idx = FIX_KMAP_BEGIN + type + KM_TYPE_NR * smp_processor_id();
-	vaddr = __fix_to_virt(idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(get_fixmap_pte(vaddr)));
-#endif
-	set_fixmap_pte(idx, pfn_pte(pfn, kmap_prot));
-
-	return (void *)vaddr;
-}
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 543c67cae02f..2a9b69fdabc9 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -213,6 +213,7 @@ static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
 
 static int __init init_amu_fie(void)
 {
+	bool invariance_status = topology_scale_freq_invariant();
 	cpumask_var_t valid_cpus;
 	bool have_policy = false;
 	int ret = 0;
@@ -255,6 +256,15 @@ static int __init init_amu_fie(void)
 	if (!topology_scale_freq_invariant())
 		static_branch_disable(&amu_fie_key);
 
+	/*
+	 * Task scheduler behavior depends on frequency invariance support,
+	 * either cpufreq or counter driven. If the support status changes as
+	 * a result of counter initialisation and use, retrigger the build of
+	 * scheduling domains to ensure the information is propagated properly.
+	 */
+	if (invariance_status != topology_scale_freq_invariant())
+		rebuild_sched_domains_energy();
+
 free_valid_mask:
 	free_cpumask_var(valid_cpus);
 
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 268fad5f51cf..7a86481a22ff 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -286,6 +286,7 @@ config NR_CPUS
 config HIGHMEM
 	bool "High Memory Support"
 	depends on !CPU_CK610
+	select KMAP_LOCAL
 	default y
 
 config FORCE_MAX_ZONEORDER
diff --git a/arch/csky/include/asm/fixmap.h b/arch/csky/include/asm/fixmap.h
index 81f9477d5330..4b589cc20900 100644
--- a/arch/csky/include/asm/fixmap.h
+++ b/arch/csky/include/asm/fixmap.h
@@ -8,7 +8,7 @@
 #include <asm/memory.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #endif
 
 enum fixed_addresses {
@@ -17,7 +17,7 @@ enum fixed_addresses {
 #endif
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,
-	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR * NR_CPUS) - 1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
 #endif
 	__end_of_fixed_addresses
 };
diff --git a/arch/csky/include/asm/highmem.h b/arch/csky/include/asm/highmem.h
index 14645e3d5cd5..1f4ed3f4c0d9 100644
--- a/arch/csky/include/asm/highmem.h
+++ b/arch/csky/include/asm/highmem.h
@@ -9,7 +9,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/uaccess.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #include <asm/cache.h>
 
 /* undef for production */
@@ -32,10 +32,12 @@ extern pte_t *pkmap_page_table;
 
 #define ARCH_HAS_KMAP_FLUSH_TLB
 extern void kmap_flush_tlb(unsigned long addr);
-extern void *kmap_atomic_pfn(unsigned long pfn);
 
 #define flush_cache_kmaps() do {} while (0)
 
+#define arch_kmap_local_post_map(vaddr, pteval)	kmap_flush_tlb(vaddr)
+#define arch_kmap_local_post_unmap(vaddr)	kmap_flush_tlb(vaddr)
+
 extern void kmap_init(void);
 
 #endif /* __KERNEL__ */
diff --git a/arch/csky/mm/highmem.c b/arch/csky/mm/highmem.c
index 89c10800a002..4161df3c6c15 100644
--- a/arch/csky/mm/highmem.c
+++ b/arch/csky/mm/highmem.c
@@ -9,8 +9,6 @@
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 
-static pte_t *kmap_pte;
-
 unsigned long highstart_pfn, highend_pfn;
 
 void kmap_flush_tlb(unsigned long addr)
@@ -19,67 +17,7 @@ void kmap_flush_tlb(unsigned long addr)
 }
 EXPORT_SYMBOL(kmap_flush_tlb);
 
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(*(kmap_pte - idx)));
-#endif
-	set_pte(kmap_pte-idx, mk_pte(page, prot));
-	flush_tlb_one((unsigned long)vaddr);
-
-	return (void *)vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	int idx;
-
-	if (vaddr < FIXADDR_START)
-		return;
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-	idx = KM_TYPE_NR*smp_processor_id() + kmap_atomic_idx();
-
-	BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-
-	pte_clear(&init_mm, vaddr, kmap_pte - idx);
-	flush_tlb_one(vaddr);
-#else
-	(void) idx; /* to kill a warning */
-#endif
-	kmap_atomic_idx_pop();
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
-
-/*
- * This is the same as kmap_atomic() but can map memory that doesn't
- * have a struct page associated with it.
- */
-void *kmap_atomic_pfn(unsigned long pfn)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	pagefault_disable();
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	set_pte(kmap_pte-idx, pfn_pte(pfn, PAGE_KERNEL));
-	flush_tlb_one(vaddr);
-
-	return (void *) vaddr;
-}
-
-static void __init kmap_pages_init(void)
+void __init kmap_init(void)
 {
 	unsigned long vaddr;
 	pgd_t *pgd;
@@ -96,14 +34,3 @@ static void __init kmap_pages_init(void)
 	pte = pte_offset_kernel(pmd, vaddr);
 	pkmap_page_table = pte;
 }
-
-void __init kmap_init(void)
-{
-	unsigned long vaddr;
-
-	kmap_pages_init();
-
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN);
-
-	kmap_pte = pte_offset_kernel((pmd_t *)pgd_offset_k(vaddr), vaddr);
-}
diff --git a/arch/ia64/include/asm/kmap_types.h b/arch/ia64/include/asm/kmap_types.h
deleted file mode 100644
index 5c268cf7c2bd..000000000000
--- a/arch/ia64/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_IA64_KMAP_TYPES_H
-#define _ASM_IA64_KMAP_TYPES_H
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define  __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif /* _ASM_IA64_KMAP_TYPES_H */
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 33925ffed68f..7f6ca0ab4f81 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -155,6 +155,7 @@ config XILINX_UNCACHED_SHADOW
 config HIGHMEM
 	bool "High memory support"
 	depends on MMU
+	select KMAP_LOCAL
 	help
 	  The address space of Microblaze processors is only 4 Gigabytes large
 	  and it has to accommodate user address space, kernel address
diff --git a/arch/microblaze/include/asm/fixmap.h b/arch/microblaze/include/asm/fixmap.h
index 0379ce5229e3..e6e9288bff76 100644
--- a/arch/microblaze/include/asm/fixmap.h
+++ b/arch/microblaze/include/asm/fixmap.h
@@ -20,7 +20,7 @@
 #include <asm/page.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #endif
 
 #define FIXADDR_TOP	((unsigned long)(-PAGE_SIZE))
@@ -47,7 +47,7 @@ enum fixed_addresses {
 	FIX_HOLE,
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
-	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR * num_possible_cpus()) - 1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * num_possible_cpus()) - 1,
 #endif
 	__end_of_fixed_addresses
 };
diff --git a/arch/microblaze/include/asm/highmem.h b/arch/microblaze/include/asm/highmem.h
index 284ca8fb54c1..4418633fb163 100644
--- a/arch/microblaze/include/asm/highmem.h
+++ b/arch/microblaze/include/asm/highmem.h
@@ -25,7 +25,6 @@
 #include <linux/uaccess.h>
 #include <asm/fixmap.h>
 
-extern pte_t *kmap_pte;
 extern pte_t *pkmap_page_table;
 
 /*
@@ -52,6 +51,11 @@ extern pte_t *pkmap_page_table;
 
 #define flush_cache_kmaps()	{ flush_icache(); flush_dcache(); }
 
+#define arch_kmap_local_post_map(vaddr, pteval)	\
+	local_flush_tlb_page(NULL, vaddr);
+#define arch_kmap_local_post_unmap(vaddr)	\
+	local_flush_tlb_page(NULL, vaddr);
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_HIGHMEM_H */
diff --git a/arch/microblaze/mm/Makefile b/arch/microblaze/mm/Makefile
index 1b16875cea70..8ced71100047 100644
--- a/arch/microblaze/mm/Makefile
+++ b/arch/microblaze/mm/Makefile
@@ -6,4 +6,3 @@
 obj-y := consistent.o init.o
 
 obj-$(CONFIG_MMU) += pgtable.o mmu_context.o fault.o
-obj-$(CONFIG_HIGHMEM) += highmem.o
diff --git a/arch/microblaze/mm/highmem.c b/arch/microblaze/mm/highmem.c
deleted file mode 100644
index 92e0890416c9..000000000000
--- a/arch/microblaze/mm/highmem.c
+++ /dev/null
@@ -1,78 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * highmem.c: virtual kernel memory mappings for high memory
- *
- * PowerPC version, stolen from the i386 version.
- *
- * Used in CONFIG_HIGHMEM systems for memory pages which
- * are not addressable by direct kernel virtual addresses.
- *
- * Copyright (C) 1999 Gerhard Wichert, Siemens AG
- *		      Gerhard.Wichert@pdb.siemens.de
- *
- *
- * Redesigned the x86 32-bit VM architecture to deal with
- * up to 16 Terrabyte physical memory. With current x86 CPUs
- * we now support up to 64 Gigabytes physical RAM.
- *
- * Copyright (C) 1999 Ingo Molnar <mingo@redhat.com>
- *
- * Reworked for PowerPC by various contributors. Moved from
- * highmem.h by Benjamin Herrenschmidt (c) 2009 IBM Corp.
- */
-
-#include <linux/export.h>
-#include <linux/highmem.h>
-
-/*
- * The use of kmap_atomic/kunmap_atomic is discouraged - kmap/kunmap
- * gives a more generic (and caching) interface. But kmap_atomic can
- * be used in IRQ contexts, so in some (very limited) cases we need
- * it.
- */
-#include <asm/tlbflush.h>
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-
-	unsigned long vaddr;
-	int idx, type;
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(*(kmap_pte-idx)));
-#endif
-	set_pte_at(&init_mm, vaddr, kmap_pte-idx, mk_pte(page, prot));
-	local_flush_tlb_page(NULL, vaddr);
-
-	return (void *) vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	int type;
-	unsigned int idx;
-
-	if (vaddr < __fix_to_virt(FIX_KMAP_END))
-		return;
-
-	type = kmap_atomic_idx();
-
-	idx = type + KM_TYPE_NR * smp_processor_id();
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-#endif
-	/*
-	 * force other mappings to Oops if they'll try to access
-	 * this pte without first remap it
-	 */
-	pte_clear(&init_mm, vaddr, kmap_pte-idx);
-	local_flush_tlb_page(NULL, vaddr);
-
-	kmap_atomic_idx_pop();
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 45da639bd22c..a444778e59de 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -50,16 +50,11 @@ EXPORT_SYMBOL(min_low_pfn);
 EXPORT_SYMBOL(max_low_pfn);
 
 #ifdef CONFIG_HIGHMEM
-pte_t *kmap_pte;
-EXPORT_SYMBOL(kmap_pte);
-
 static void __init highmem_init(void)
 {
 	pr_debug("%x\n", (u32)PKMAP_BASE);
 	map_page(PKMAP_BASE, 0, 0);	/* XXX gross */
 	pkmap_page_table = virt_to_kpte(PKMAP_BASE);
-
-	kmap_pte = virt_to_kpte(__fix_to_virt(FIX_KMAP_BEGIN));
 }
 
 static void highmem_setup(void)
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2000bb2b0220..6b762bebff33 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2719,6 +2719,7 @@ config WAR_MIPS34K_MISSED_ITLB
 config HIGHMEM
 	bool "High Memory Support"
 	depends on 32BIT && CPU_SUPPORTS_HIGHMEM && SYS_SUPPORTS_HIGHMEM && !CPU_MIPS32_3_5_EVA
+	select KMAP_LOCAL
 
 config CPU_SUPPORTS_HIGHMEM
 	bool
diff --git a/arch/mips/include/asm/fixmap.h b/arch/mips/include/asm/fixmap.h
index 743535be7528..beea14761cef 100644
--- a/arch/mips/include/asm/fixmap.h
+++ b/arch/mips/include/asm/fixmap.h
@@ -17,7 +17,7 @@
 #include <spaces.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #endif
 
 /*
@@ -52,7 +52,7 @@ enum fixed_addresses {
 #ifdef CONFIG_HIGHMEM
 	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_BEGIN = FIX_CMAP_END + 1,
-	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
 #endif
 	__end_of_fixed_addresses
 };
diff --git a/arch/mips/include/asm/highmem.h b/arch/mips/include/asm/highmem.h
index f1f788b57166..19edf8e69971 100644
--- a/arch/mips/include/asm/highmem.h
+++ b/arch/mips/include/asm/highmem.h
@@ -24,7 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/uaccess.h>
 #include <asm/cpu-features.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 
 /* declarations for highmem.c */
 extern unsigned long highstart_pfn, highend_pfn;
@@ -48,11 +48,11 @@ extern pte_t *pkmap_page_table;
 
 #define ARCH_HAS_KMAP_FLUSH_TLB
 extern void kmap_flush_tlb(unsigned long addr);
-extern void *kmap_atomic_pfn(unsigned long pfn);
 
 #define flush_cache_kmaps()	BUG_ON(cpu_has_dc_aliases)
 
-extern void kmap_init(void);
+#define arch_kmap_local_post_map(vaddr, pteval)	local_flush_tlb_one(vaddr)
+#define arch_kmap_local_post_unmap(vaddr)	local_flush_tlb_one(vaddr)
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/mips/include/asm/kmap_types.h b/arch/mips/include/asm/kmap_types.h
deleted file mode 100644
index 16665dc2431b..000000000000
--- a/arch/mips/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define	 __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif
diff --git a/arch/mips/mm/highmem.c b/arch/mips/mm/highmem.c
index 5fec7f45d79a..57e2f08f00d0 100644
--- a/arch/mips/mm/highmem.c
+++ b/arch/mips/mm/highmem.c
@@ -8,8 +8,6 @@
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
 
-static pte_t *kmap_pte;
-
 unsigned long highstart_pfn, highend_pfn;
 
 void kmap_flush_tlb(unsigned long addr)
@@ -17,78 +15,3 @@ void kmap_flush_tlb(unsigned long addr)
 	flush_tlb_one(addr);
 }
 EXPORT_SYMBOL(kmap_flush_tlb);
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(*(kmap_pte - idx)));
-#endif
-	set_pte(kmap_pte-idx, mk_pte(page, prot));
-	local_flush_tlb_one((unsigned long)vaddr);
-
-	return (void*) vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	int type __maybe_unused;
-
-	if (vaddr < FIXADDR_START)
-		return;
-
-	type = kmap_atomic_idx();
-#ifdef CONFIG_DEBUG_HIGHMEM
-	{
-		int idx = type + KM_TYPE_NR * smp_processor_id();
-
-		BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-
-		/*
-		 * force other mappings to Oops if they'll try to access
-		 * this pte without first remap it
-		 */
-		pte_clear(&init_mm, vaddr, kmap_pte-idx);
-		local_flush_tlb_one(vaddr);
-	}
-#endif
-	kmap_atomic_idx_pop();
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
-
-/*
- * This is the same as kmap_atomic() but can map memory that doesn't
- * have a struct page associated with it.
- */
-void *kmap_atomic_pfn(unsigned long pfn)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	preempt_disable();
-	pagefault_disable();
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	set_pte(kmap_pte-idx, pfn_pte(pfn, PAGE_KERNEL));
-	flush_tlb_one(vaddr);
-
-	return (void*) vaddr;
-}
-
-void __init kmap_init(void)
-{
-	unsigned long kmap_vstart;
-
-	/* cache the first kmap pte */
-	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
-	kmap_pte = virt_to_kpte(kmap_vstart);
-}
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 07e84a774938..bc80893e5c0f 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -36,7 +36,6 @@
 #include <asm/cachectl.h>
 #include <asm/cpu.h>
 #include <asm/dma.h>
-#include <asm/kmap_types.h>
 #include <asm/maar.h>
 #include <asm/mmu_context.h>
 #include <asm/sections.h>
@@ -402,9 +401,6 @@ void __init paging_init(void)
 
 	pagetable_init();
 
-#ifdef CONFIG_HIGHMEM
-	kmap_init();
-#endif
 #ifdef CONFIG_ZONE_DMA
 	max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;
 #endif
diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
index f88a12fdf0f3..c10759952485 100644
--- a/arch/nds32/Kconfig.cpu
+++ b/arch/nds32/Kconfig.cpu
@@ -157,6 +157,7 @@ config HW_SUPPORT_UNALIGNMENT_ACCESS
 config HIGHMEM
 	bool "High Memory Support"
 	depends on MMU && !CPU_CACHE_ALIASING
+	select KMAP_LOCAL
 	help
 	  The address space of Andes processors is only 4 Gigabytes large
 	  and it has to accommodate user address space, kernel address
diff --git a/arch/nds32/include/asm/fixmap.h b/arch/nds32/include/asm/fixmap.h
index 5a4bf11e5800..2fa09a2de428 100644
--- a/arch/nds32/include/asm/fixmap.h
+++ b/arch/nds32/include/asm/fixmap.h
@@ -6,7 +6,7 @@
 
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #endif
 
 enum fixed_addresses {
@@ -14,7 +14,7 @@ enum fixed_addresses {
 	FIX_KMAP_RESERVED,
 	FIX_KMAP_BEGIN,
 #ifdef CONFIG_HIGHMEM
-	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR * NR_CPUS),
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
 #endif
 	FIX_EARLYCON_MEM_BASE,
 	__end_of_fixed_addresses
diff --git a/arch/nds32/include/asm/highmem.h b/arch/nds32/include/asm/highmem.h
index fe986d0e6e3f..16159a8716f2 100644
--- a/arch/nds32/include/asm/highmem.h
+++ b/arch/nds32/include/asm/highmem.h
@@ -5,7 +5,6 @@
 #define _ASM_HIGHMEM_H
 
 #include <asm/proc-fns.h>
-#include <asm/kmap_types.h>
 #include <asm/fixmap.h>
 
 /*
@@ -45,11 +44,22 @@ extern pte_t *pkmap_page_table;
 extern void kmap_init(void);
 
 /*
- * The following functions are already defined by <linux/highmem.h>
- * when CONFIG_HIGHMEM is not set.
+ * FIXME: The below looks broken vs. a kmap_atomic() in task context which
+ * is interupted and another kmap_atomic() happens in interrupt context.
+ * But what do I know about nds32. -- tglx
  */
-#ifdef CONFIG_HIGHMEM
-extern void *kmap_atomic_pfn(unsigned long pfn);
-#endif
+#define arch_kmap_local_post_map(vaddr, pteval)			\
+	do {							\
+		__nds32__tlbop_inv(vaddr);			\
+		__nds32__mtsr_dsb(vaddr, NDS32_SR_TLB_VPN);	\
+		__nds32__tlbop_rwr(pteval);			\
+		__nds32__isb();					\
+	} while (0)
+
+#define arch_kmap_local_pre_unmap(vaddr)			\
+	do {							\
+		__nds32__tlbop_inv(vaddr);			\
+		__nds32__isb();					\
+	} while (0)
 
 #endif
diff --git a/arch/nds32/mm/Makefile b/arch/nds32/mm/Makefile
index 897ecaf5cf54..14fb2e8eb036 100644
--- a/arch/nds32/mm/Makefile
+++ b/arch/nds32/mm/Makefile
@@ -3,7 +3,6 @@ obj-y				:= extable.o tlb.o fault.o init.o mmap.o \
                                    mm-nds32.o cacheflush.o proc.o
 
 obj-$(CONFIG_ALIGNMENT_TRAP)	+= alignment.o
-obj-$(CONFIG_HIGHMEM)           += highmem.o
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_proc.o     = $(CC_FLAGS_FTRACE)
diff --git a/arch/nds32/mm/highmem.c b/arch/nds32/mm/highmem.c
deleted file mode 100644
index 4284cd59e21a..000000000000
--- a/arch/nds32/mm/highmem.c
+++ /dev/null
@@ -1,48 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2005-2017 Andes Technology Corporation
-
-#include <linux/export.h>
-#include <linux/highmem.h>
-#include <linux/sched.h>
-#include <linux/smp.h>
-#include <linux/interrupt.h>
-#include <linux/memblock.h>
-#include <asm/fixmap.h>
-#include <asm/tlbflush.h>
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned int idx;
-	unsigned long vaddr, pte;
-	int type;
-	pte_t *ptep;
-
-	type = kmap_atomic_idx_push();
-
-	idx = type + KM_TYPE_NR * smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	pte = (page_to_pfn(page) << PAGE_SHIFT) | prot;
-	ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
-	set_pte(ptep, pte);
-
-	__nds32__tlbop_inv(vaddr);
-	__nds32__mtsr_dsb(vaddr, NDS32_SR_TLB_VPN);
-	__nds32__tlbop_rwr(pte);
-	__nds32__isb();
-	return (void *)vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	if (kvaddr >= (void *)FIXADDR_START) {
-		unsigned long vaddr = (unsigned long)kvaddr;
-		pte_t *ptep;
-		kmap_atomic_idx_pop();
-		__nds32__tlbop_inv(vaddr);
-		__nds32__isb();
-		ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
-		set_pte(ptep, 0);
-	}
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index 8348feaaf46e..bf9b2310fc93 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -33,7 +33,6 @@
 #include <asm/io.h>
 #include <asm/tlb.h>
 #include <asm/mmu_context.h>
-#include <asm/kmap_types.h>
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index a978590d802d..5aed97a18bac 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -15,7 +15,6 @@
 #include <linux/io.h>
 #include <linux/pgtable.h>
 #include <asm/pgalloc.h>
-#include <asm/kmap_types.h>
 #include <asm/fixmap.h>
 #include <asm/bug.h>
 #include <linux/sched.h>
diff --git a/arch/parisc/include/asm/kmap_types.h b/arch/parisc/include/asm/kmap_types.h
deleted file mode 100644
index 3e70b5cd1123..000000000000
--- a/arch/parisc/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define  __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e9f13fe08492..d4cfddc0fb4c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -409,6 +409,7 @@ menu "Kernel options"
 config HIGHMEM
 	bool "High memory support"
 	depends on PPC32
+	select KMAP_LOCAL
 
 source "kernel/Kconfig.hz"
 
diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
index 6bfc87915d5d..8d03c16a3663 100644
--- a/arch/powerpc/include/asm/fixmap.h
+++ b/arch/powerpc/include/asm/fixmap.h
@@ -20,7 +20,7 @@
 #include <asm/page.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #endif
 
 #ifdef CONFIG_KASAN
@@ -55,7 +55,7 @@ enum fixed_addresses {
 	FIX_EARLY_DEBUG_BASE = FIX_EARLY_DEBUG_TOP+(ALIGN(SZ_128K, PAGE_SIZE)/PAGE_SIZE)-1,
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
-	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
 #endif
 #ifdef CONFIG_PPC_8xx
 	/* For IMMR we need an aligned 512K area */
diff --git a/arch/powerpc/include/asm/highmem.h b/arch/powerpc/include/asm/highmem.h
index 104026f7d6bc..80a5ae771c65 100644
--- a/arch/powerpc/include/asm/highmem.h
+++ b/arch/powerpc/include/asm/highmem.h
@@ -24,12 +24,10 @@
 #ifdef __KERNEL__
 
 #include <linux/interrupt.h>
-#include <asm/kmap_types.h>
 #include <asm/cacheflush.h>
 #include <asm/page.h>
 #include <asm/fixmap.h>
 
-extern pte_t *kmap_pte;
 extern pte_t *pkmap_page_table;
 
 /*
@@ -60,6 +58,11 @@ extern pte_t *pkmap_page_table;
 
 #define flush_cache_kmaps()	flush_cache_all()
 
+#define arch_kmap_local_post_map(vaddr, pteval)	\
+	local_flush_tlb_page(NULL, vaddr)
+#define arch_kmap_local_post_unmap(vaddr)	\
+	local_flush_tlb_page(NULL, vaddr)
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_HIGHMEM_H */
diff --git a/arch/powerpc/include/asm/kmap_types.h b/arch/powerpc/include/asm/kmap_types.h
deleted file mode 100644
index c8fa182d48c8..000000000000
--- a/arch/powerpc/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _ASM_POWERPC_KMAP_TYPES_H
-#define _ASM_POWERPC_KMAP_TYPES_H
-
-#ifdef __KERNEL__
-
-/*
- */
-
-#define KM_TYPE_NR 16
-
-#endif	/* __KERNEL__ */
-#endif	/* _ASM_POWERPC_KMAP_TYPES_H */
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 5e147986400d..1c552b53aa63 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -16,7 +16,6 @@ obj-$(CONFIG_NEED_MULTIPLE_NODES) += numa.o
 obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
-obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_PPC_COPRO_BASE)	+= copro_fault.o
 obj-$(CONFIG_PPC_PTDUMP)	+= ptdump/
 obj-$(CONFIG_KASAN)		+= kasan/
diff --git a/arch/powerpc/mm/highmem.c b/arch/powerpc/mm/highmem.c
deleted file mode 100644
index 624b4438aff9..000000000000
--- a/arch/powerpc/mm/highmem.c
+++ /dev/null
@@ -1,67 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * highmem.c: virtual kernel memory mappings for high memory
- *
- * PowerPC version, stolen from the i386 version.
- *
- * Used in CONFIG_HIGHMEM systems for memory pages which
- * are not addressable by direct kernel virtual addresses.
- *
- * Copyright (C) 1999 Gerhard Wichert, Siemens AG
- *		      Gerhard.Wichert@pdb.siemens.de
- *
- *
- * Redesigned the x86 32-bit VM architecture to deal with
- * up to 16 Terrabyte physical memory. With current x86 CPUs
- * we now support up to 64 Gigabytes physical RAM.
- *
- * Copyright (C) 1999 Ingo Molnar <mingo@redhat.com>
- *
- * Reworked for PowerPC by various contributors. Moved from
- * highmem.h by Benjamin Herrenschmidt (c) 2009 IBM Corp.
- */
-
-#include <linux/highmem.h>
-#include <linux/module.h>
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	WARN_ON(IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !pte_none(*(kmap_pte - idx)));
-	__set_pte_at(&init_mm, vaddr, kmap_pte-idx, mk_pte(page, prot), 1);
-	local_flush_tlb_page(NULL, vaddr);
-
-	return (void*) vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-
-	if (vaddr < __fix_to_virt(FIX_KMAP_END))
-		return;
-
-	if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM)) {
-		int type = kmap_atomic_idx();
-		unsigned int idx;
-
-		idx = type + KM_TYPE_NR * smp_processor_id();
-		WARN_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-
-		/*
-		 * force other mappings to Oops if they'll try to access
-		 * this pte without first remap it
-		 */
-		pte_clear(&init_mm, vaddr, kmap_pte-idx);
-		local_flush_tlb_page(NULL, vaddr);
-	}
-
-	kmap_atomic_idx_pop();
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 01ec2a252f09..375a9894063b 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -61,11 +61,6 @@
 unsigned long long memory_limit;
 bool init_mem_is_free;
 
-#ifdef CONFIG_HIGHMEM
-pte_t *kmap_pte;
-EXPORT_SYMBOL(kmap_pte);
-#endif
-
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
 {
@@ -235,8 +230,6 @@ void __init paging_init(void)
 
 	map_kernel_page(PKMAP_BASE, 0, __pgprot(0));	/* XXX gross */
 	pkmap_page_table = virt_to_kpte(PKMAP_BASE);
-
-	kmap_pte = virt_to_kpte(__fix_to_virt(FIX_KMAP_BEGIN));
 #endif /* CONFIG_HIGHMEM */
 
 	printk(KERN_DEBUG "Top of RAM: 0x%llx, Total RAM: 0x%llx\n",
diff --git a/arch/sh/include/asm/fixmap.h b/arch/sh/include/asm/fixmap.h
index f38adc189b83..b07fbc7f7bc6 100644
--- a/arch/sh/include/asm/fixmap.h
+++ b/arch/sh/include/asm/fixmap.h
@@ -13,9 +13,6 @@
 #include <linux/kernel.h>
 #include <linux/threads.h>
 #include <asm/page.h>
-#ifdef CONFIG_HIGHMEM
-#include <asm/kmap_types.h>
-#endif
 
 /*
  * Here we define all the compile-time 'special' virtual
@@ -53,11 +50,6 @@ enum fixed_addresses {
 	FIX_CMAP_BEGIN,
 	FIX_CMAP_END = FIX_CMAP_BEGIN + (FIX_N_COLOURS * NR_CPUS) - 1,
 
-#ifdef CONFIG_HIGHMEM
-	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
-	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_TYPE_NR * NR_CPUS) - 1,
-#endif
-
 #ifdef CONFIG_IOREMAP_FIXED
 	/*
 	 * FIX_IOREMAP entries are useful for mapping physical address
diff --git a/arch/sh/include/asm/kmap_types.h b/arch/sh/include/asm/kmap_types.h
deleted file mode 100644
index b78107f923dd..000000000000
--- a/arch/sh/include/asm/kmap_types.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __SH_KMAP_TYPES_H
-#define __SH_KMAP_TYPES_H
-
-/* Dummy header just to define km_type. */
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define  __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 3348e0c4d769..0db6919af8d3 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -362,9 +362,6 @@ void __init mem_init(void)
 	mem_init_print_info(NULL);
 	pr_info("virtual kernel memory layout:\n"
 		"    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-#ifdef CONFIG_HIGHMEM
-		"    pkmap   : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-#endif
 		"    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
 		"    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB) (cached)\n"
 #ifdef CONFIG_UNCACHED_MAPPING
@@ -376,11 +373,6 @@ void __init mem_init(void)
 		FIXADDR_START, FIXADDR_TOP,
 		(FIXADDR_TOP - FIXADDR_START) >> 10,
 
-#ifdef CONFIG_HIGHMEM
-		PKMAP_BASE, PKMAP_BASE+LAST_PKMAP*PAGE_SIZE,
-		(LAST_PKMAP*PAGE_SIZE) >> 10,
-#endif
-
 		(unsigned long)VMALLOC_START, VMALLOC_END,
 		(VMALLOC_END - VMALLOC_START) >> 20,
 
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a6ca135442f9..e841708cb830 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -139,6 +139,7 @@ config MMU
 config HIGHMEM
 	bool
 	default y if SPARC32
+	select KMAP_LOCAL
 
 config ZONE_DMA
 	bool
diff --git a/arch/sparc/include/asm/highmem.h b/arch/sparc/include/asm/highmem.h
index 6c35f0d27ee1..875116209ec1 100644
--- a/arch/sparc/include/asm/highmem.h
+++ b/arch/sparc/include/asm/highmem.h
@@ -24,7 +24,6 @@
 #include <linux/interrupt.h>
 #include <linux/pgtable.h>
 #include <asm/vaddrs.h>
-#include <asm/kmap_types.h>
 #include <asm/pgtsrmmu.h>
 
 /* declarations for highmem.c */
@@ -33,8 +32,6 @@ extern unsigned long highstart_pfn, highend_pfn;
 #define kmap_prot __pgprot(SRMMU_ET_PTE | SRMMU_PRIV | SRMMU_CACHE)
 extern pte_t *pkmap_page_table;
 
-void kmap_init(void) __init;
-
 /*
  * Right now we initialize only a single pte table. It can be extended
  * easily, subsequent pte tables have to be allocated in one physical
@@ -53,6 +50,11 @@ void kmap_init(void) __init;
 
 #define flush_cache_kmaps()	flush_cache_all()
 
+/* FIXME: Use __flush_tlb_one(vaddr) instead of flush_cache_all() -- Anton */
+#define arch_kmap_local_post_map(vaddr, pteval)	flush_cache_all()
+#define arch_kmap_local_post_unmap(vaddr)	flush_cache_all()
+
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_HIGHMEM_H */
diff --git a/arch/sparc/include/asm/kmap_types.h b/arch/sparc/include/asm/kmap_types.h
deleted file mode 100644
index 55a99b6bd91e..000000000000
--- a/arch/sparc/include/asm/kmap_types.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-/* Dummy header just to define km_type.  None of this
- * is actually used on sparc.  -DaveM
- */
-
-#include <asm-generic/kmap_types.h>
-
-#endif
diff --git a/arch/sparc/include/asm/vaddrs.h b/arch/sparc/include/asm/vaddrs.h
index 84d054b07a6f..4fec0341e2a8 100644
--- a/arch/sparc/include/asm/vaddrs.h
+++ b/arch/sparc/include/asm/vaddrs.h
@@ -32,13 +32,13 @@
 #define SRMMU_NOCACHE_ALCRATIO	64	/* 256 pages per 64MB of system RAM */
 
 #ifndef __ASSEMBLY__
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 
 enum fixed_addresses {
 	FIX_HOLE,
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,
-	FIX_KMAP_END = (KM_TYPE_NR * NR_CPUS),
+	FIX_KMAP_END = (KM_MAX_IDX * NR_CPUS),
 #endif
 	__end_of_fixed_addresses
 };
diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
index b078205b70e0..68db1f859b02 100644
--- a/arch/sparc/mm/Makefile
+++ b/arch/sparc/mm/Makefile
@@ -15,6 +15,3 @@ obj-$(CONFIG_SPARC32)   += leon_mm.o
 
 # Only used by sparc64
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
-
-# Only used by sparc32
-obj-$(CONFIG_HIGHMEM)   += highmem.o
diff --git a/arch/sparc/mm/highmem.c b/arch/sparc/mm/highmem.c
deleted file mode 100644
index 8f2a2afb048a..000000000000
--- a/arch/sparc/mm/highmem.c
+++ /dev/null
@@ -1,115 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  highmem.c: virtual kernel memory mappings for high memory
- *
- *  Provides kernel-static versions of atomic kmap functions originally
- *  found as inlines in include/asm-sparc/highmem.h.  These became
- *  needed as kmap_atomic() and kunmap_atomic() started getting
- *  called from within modules.
- *  -- Tomas Szepe <szepe@pinerecords.com>, September 2002
- *
- *  But kmap_atomic() and kunmap_atomic() cannot be inlined in
- *  modules because they are loaded with btfixup-ped functions.
- */
-
-/*
- * The use of kmap_atomic/kunmap_atomic is discouraged - kmap/kunmap
- * gives a more generic (and caching) interface. But kmap_atomic can
- * be used in IRQ contexts, so in some (very limited) cases we need it.
- *
- * XXX This is an old text. Actually, it's good to use atomic kmaps,
- * provided you remember that they are atomic and not try to sleep
- * with a kmap taken, much like a spinlock. Non-atomic kmaps are
- * shared by CPUs, and so precious, and establishing them requires IPI.
- * Atomic kmaps are lightweight and we may have NCPUS more of them.
- */
-#include <linux/highmem.h>
-#include <linux/export.h>
-#include <linux/mm.h>
-
-#include <asm/cacheflush.h>
-#include <asm/tlbflush.h>
-#include <asm/vaddrs.h>
-
-static pte_t *kmap_pte;
-
-void __init kmap_init(void)
-{
-	unsigned long address = __fix_to_virt(FIX_KMAP_BEGIN);
-
-        /* cache the first kmap pte */
-        kmap_pte = virt_to_kpte(address);
-}
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned long vaddr;
-	long idx, type;
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-
-/* XXX Fix - Anton */
-#if 0
-	__flush_cache_one(vaddr);
-#else
-	flush_cache_all();
-#endif
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(*(kmap_pte-idx)));
-#endif
-	set_pte(kmap_pte-idx, mk_pte(page, prot));
-/* XXX Fix - Anton */
-#if 0
-	__flush_tlb_one(vaddr);
-#else
-	flush_tlb_all();
-#endif
-
-	return (void*) vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	int type;
-
-	if (vaddr < FIXADDR_START)
-		return;
-
-	type = kmap_atomic_idx();
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-	{
-		unsigned long idx;
-
-		idx = type + KM_TYPE_NR * smp_processor_id();
-		BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN+idx));
-
-		/* XXX Fix - Anton */
-#if 0
-		__flush_cache_one(vaddr);
-#else
-		flush_cache_all();
-#endif
-
-		/*
-		 * force other mappings to Oops if they'll try to access
-		 * this pte without first remap it
-		 */
-		pte_clear(&init_mm, vaddr, kmap_pte-idx);
-		/* XXX Fix - Anton */
-#if 0
-		__flush_tlb_one(vaddr);
-#else
-		flush_tlb_all();
-#endif
-	}
-#endif
-
-	kmap_atomic_idx_pop();
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 0070f8b9a753..a03caa5f6628 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -971,8 +971,6 @@ void __init srmmu_paging_init(void)
 
 	sparc_context_init(num_contexts);
 
-	kmap_init();
-
 	{
 		unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
 
diff --git a/arch/um/include/asm/fixmap.h b/arch/um/include/asm/fixmap.h
index 2c697a145ac1..2efac5827188 100644
--- a/arch/um/include/asm/fixmap.h
+++ b/arch/um/include/asm/fixmap.h
@@ -3,7 +3,6 @@
 #define __UM_FIXMAP_H
 
 #include <asm/processor.h>
-#include <asm/kmap_types.h>
 #include <asm/archparam.h>
 #include <asm/page.h>
 #include <linux/threads.h>
diff --git a/arch/um/include/asm/kmap_types.h b/arch/um/include/asm/kmap_types.h
deleted file mode 100644
index b0bd12de1d23..000000000000
--- a/arch/um/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- */
-
-#ifndef __UM_KMAP_TYPES_H
-#define __UM_KMAP_TYPES_H
-
-/* No more #include "asm/arch/kmap_types.h" ! */
-
-#define KM_TYPE_NR 14
-
-#endif
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f6946b81f74a..b5137cc5b7b4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -14,10 +14,11 @@ config X86_32
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select CLKSRC_I8253
 	select CLONE_BACKWARDS
+	select GENERIC_VDSO_32
 	select HAVE_DEBUG_STACKOVERFLOW
+	select KMAP_LOCAL
 	select MODULES_USE_ELF_REL
 	select OLD_SIGACTION
-	select GENERIC_VDSO_32
 
 config X86_64
 	def_bool y
@@ -92,6 +93,7 @@ config X86
 	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
+	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index 77217bd292bd..9f1a0a987e5e 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -14,13 +14,20 @@
 #ifndef _ASM_X86_FIXMAP_H
 #define _ASM_X86_FIXMAP_H
 
+#include <asm/kmap_size.h>
+
 /*
  * Exposed to assembly code for setting up initial page tables. Cannot be
  * calculated in assembly code (fixmap entries are an enum), but is sanity
  * checked in the actual fixmap C code to make sure that the fixmap is
  * covered fully.
  */
-#define FIXMAP_PMD_NUM	2
+#ifndef CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
+# define FIXMAP_PMD_NUM	2
+#else
+# define KM_PMDS	(KM_MAX_IDX * ((CONFIG_NR_CPUS + 511) / 512))
+# define FIXMAP_PMD_NUM (KM_PMDS + 2)
+#endif
 /* fixmap starts downwards from the 507th entry in level2_fixmap_pgt */
 #define FIXMAP_PMD_TOP	507
 
@@ -31,7 +38,6 @@
 #include <asm/pgtable_types.h>
 #ifdef CONFIG_X86_32
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
 #else
 #include <uapi/asm/vsyscall.h>
 #endif
@@ -92,9 +98,9 @@ enum fixed_addresses {
 	FIX_IO_APIC_BASE_0,
 	FIX_IO_APIC_BASE_END = FIX_IO_APIC_BASE_0 + MAX_IO_APICS - 1,
 #endif
-#ifdef CONFIG_X86_32
+#ifdef CONFIG_KMAP_LOCAL
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
-	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
 #ifdef CONFIG_PCI_MMCONFIG
 	FIX_PCIE_MCFG,
 #endif
@@ -151,7 +157,6 @@ extern void reserve_top_address(unsigned long reserve);
 
 extern int fixmaps_set;
 
-extern pte_t *kmap_pte;
 extern pte_t *pkmap_page_table;
 
 void __native_set_fixmap(enum fixed_addresses idx, pte_t pte);
diff --git a/arch/x86/include/asm/highmem.h b/arch/x86/include/asm/highmem.h
index 0f420b24e0fc..032e020853aa 100644
--- a/arch/x86/include/asm/highmem.h
+++ b/arch/x86/include/asm/highmem.h
@@ -23,7 +23,6 @@
 
 #include <linux/interrupt.h>
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
 #include <asm/fixmap.h>
@@ -58,11 +57,17 @@ extern unsigned long highstart_pfn, highend_pfn;
 #define PKMAP_NR(virt)  ((virt-PKMAP_BASE) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))
 
-void *kmap_atomic_pfn(unsigned long pfn);
-void *kmap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot);
-
 #define flush_cache_kmaps()	do { } while (0)
 
+#define	arch_kmap_local_post_map(vaddr, pteval)		\
+	arch_flush_lazy_mmu_mode()
+
+#define	arch_kmap_local_post_unmap(vaddr)		\
+	do {						\
+		flush_tlb_one_kernel((vaddr));		\
+		arch_flush_lazy_mmu_mode();		\
+	} while (0)
+
 extern void add_highpages_with_active_regions(int nid, unsigned long start_pfn,
 					unsigned long end_pfn);
 
diff --git a/arch/x86/include/asm/iomap.h b/arch/x86/include/asm/iomap.h
index bacf68c4d70e..e2de092fc38c 100644
--- a/arch/x86/include/asm/iomap.h
+++ b/arch/x86/include/asm/iomap.h
@@ -9,19 +9,14 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
+#include <linux/highmem.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-void __iomem *
-iomap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot);
+void __iomem *__iomap_local_pfn_prot(unsigned long pfn, pgprot_t prot);
 
-void
-iounmap_atomic(void __iomem *kvaddr);
+int iomap_create_wc(resource_size_t base, unsigned long size, pgprot_t *prot);
 
-int
-iomap_create_wc(resource_size_t base, unsigned long size, pgprot_t *prot);
-
-void
-iomap_free(resource_size_t base, unsigned long size);
+void iomap_free(resource_size_t base, unsigned long size);
 
 #endif /* _ASM_X86_IOMAP_H */
diff --git a/arch/x86/include/asm/kmap_types.h b/arch/x86/include/asm/kmap_types.h
deleted file mode 100644
index 04ab8266e347..000000000000
--- a/arch/x86/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_KMAP_TYPES_H
-#define _ASM_X86_KMAP_TYPES_H
-
-#if defined(CONFIG_X86_32) && defined(CONFIG_DEBUG_HIGHMEM)
-#define  __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif /* _ASM_X86_KMAP_TYPES_H */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 0fad9f61c76a..b6b02b7c19cc 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -41,7 +41,6 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/desc_defs.h>
-#include <asm/kmap_types.h>
 #include <asm/pgtable_types.h>
 #include <asm/nospec-branch.h>
 
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 52e5f5f2240d..91ac10654570 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -143,7 +143,11 @@ extern unsigned int ptrs_per_p4d;
 
 #define MODULES_VADDR		(__START_KERNEL_map + KERNEL_IMAGE_SIZE)
 /* The module sections ends with the start of the fixmap */
-#define MODULES_END		_AC(0xffffffffff000000, UL)
+#ifndef CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
+# define MODULES_END		_AC(0xffffffffff000000, UL)
+#else
+# define MODULES_END		_AC(0xfffffffffe000000, UL)
+#endif
 #define MODULES_LEN		(MODULES_END - MODULES_VADDR)
 
 #define ESPFIX_PGD_ENTRY	_AC(-2, UL)
diff --git a/arch/x86/kernel/crash_dump_32.c b/arch/x86/kernel/crash_dump_32.c
index 33ee47670b99..5fcac46aaf6b 100644
--- a/arch/x86/kernel/crash_dump_32.c
+++ b/arch/x86/kernel/crash_dump_32.c
@@ -13,8 +13,6 @@
 
 #include <linux/uaccess.h>
 
-static void *kdump_buf_page;
-
 static inline bool is_crashed_pfn_valid(unsigned long pfn)
 {
 #ifndef CONFIG_X86_PAE
@@ -41,15 +39,11 @@ static inline bool is_crashed_pfn_valid(unsigned long pfn)
  * @userbuf: if set, @buf is in user address space, use copy_to_user(),
  *	otherwise @buf is in kernel address space, use memcpy().
  *
- * Copy a page from "oldmem". For this page, there is no pte mapped
- * in the current kernel. We stitch up a pte, similar to kmap_atomic.
- *
- * Calling copy_to_user() in atomic context is not desirable. Hence first
- * copying the data to a pre-allocated kernel page and then copying to user
- * space in non-atomic context.
+ * Copy a page from "oldmem". For this page, there might be no pte mapped
+ * in the current kernel.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-                               size_t csize, unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
+			 unsigned long offset, int userbuf)
 {
 	void  *vaddr;
 
@@ -59,38 +53,16 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 	if (!is_crashed_pfn_valid(pfn))
 		return -EFAULT;
 
-	vaddr = kmap_atomic_pfn(pfn);
+	vaddr = kmap_local_pfn(pfn);
 
 	if (!userbuf) {
-		memcpy(buf, (vaddr + offset), csize);
-		kunmap_atomic(vaddr);
+		memcpy(buf, vaddr + offset, csize);
 	} else {
-		if (!kdump_buf_page) {
-			printk(KERN_WARNING "Kdump: Kdump buffer page not"
-				" allocated\n");
-			kunmap_atomic(vaddr);
-			return -EFAULT;
-		}
-		copy_page(kdump_buf_page, vaddr);
-		kunmap_atomic(vaddr);
-		if (copy_to_user(buf, (kdump_buf_page + offset), csize))
-			return -EFAULT;
+		if (copy_to_user(buf, vaddr + offset, csize))
+			csize = -EFAULT;
 	}
 
-	return csize;
-}
+	kunmap_local(vaddr);
 
-static int __init kdump_buf_page_init(void)
-{
-	int ret = 0;
-
-	kdump_buf_page = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!kdump_buf_page) {
-		printk(KERN_WARNING "Kdump: Failed to allocate kdump buffer"
-			 " page\n");
-		ret = -ENOMEM;
-	}
-
-	return ret;
+	return csize;
 }
-arch_initcall(kdump_buf_page_init);
diff --git a/arch/x86/mm/highmem_32.c b/arch/x86/mm/highmem_32.c
index 075fe51317b0..2c54b76d8f84 100644
--- a/arch/x86/mm/highmem_32.c
+++ b/arch/x86/mm/highmem_32.c
@@ -4,65 +4,6 @@
 #include <linux/swap.h> /* for totalram_pages */
 #include <linux/memblock.h>
 
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	BUG_ON(!pte_none(*(kmap_pte-idx)));
-	set_pte(kmap_pte-idx, mk_pte(page, prot));
-	arch_flush_lazy_mmu_mode();
-
-	return (void *)vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-/*
- * This is the same as kmap_atomic() but can map memory that doesn't
- * have a struct page associated with it.
- */
-void *kmap_atomic_pfn(unsigned long pfn)
-{
-	return kmap_atomic_prot_pfn(pfn, kmap_prot);
-}
-EXPORT_SYMBOL_GPL(kmap_atomic_pfn);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-
-	if (vaddr >= __fix_to_virt(FIX_KMAP_END) &&
-	    vaddr <= __fix_to_virt(FIX_KMAP_BEGIN)) {
-		int idx, type;
-
-		type = kmap_atomic_idx();
-		idx = type + KM_TYPE_NR * smp_processor_id();
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-		WARN_ON_ONCE(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-#endif
-		/*
-		 * Force other mappings to Oops if they'll try to access this
-		 * pte without first remap it.  Keeping stale mappings around
-		 * is a bad idea also, in case the page changes cacheability
-		 * attributes or becomes a protected page in a hypervisor.
-		 */
-		kpte_clear_flush(kmap_pte-idx, vaddr);
-		kmap_atomic_idx_pop();
-		arch_flush_lazy_mmu_mode();
-	}
-#ifdef CONFIG_DEBUG_HIGHMEM
-	else {
-		BUG_ON(vaddr < PAGE_OFFSET);
-		BUG_ON(vaddr >= (unsigned long)high_memory);
-	}
-#endif
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
-
 void __init set_highmem_pages_init(void)
 {
 	struct zone *zone;
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 7c055259de3a..da31c2635ee4 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -394,19 +394,6 @@ kernel_physical_mapping_init(unsigned long start,
 	return last_map_addr;
 }
 
-pte_t *kmap_pte;
-
-static void __init kmap_init(void)
-{
-	unsigned long kmap_vstart;
-
-	/*
-	 * Cache the first kmap pte:
-	 */
-	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
-	kmap_pte = virt_to_kpte(kmap_vstart);
-}
-
 #ifdef CONFIG_HIGHMEM
 static void __init permanent_kmaps_init(pgd_t *pgd_base)
 {
@@ -712,8 +699,6 @@ void __init paging_init(void)
 
 	__flush_tlb_all();
 
-	kmap_init();
-
 	/*
 	 * NOTE: at this point the bootmem allocator is fully available.
 	 */
diff --git a/arch/x86/mm/iomap_32.c b/arch/x86/mm/iomap_32.c
index f60398aeb644..9aaa756ddf21 100644
--- a/arch/x86/mm/iomap_32.c
+++ b/arch/x86/mm/iomap_32.c
@@ -44,28 +44,7 @@ void iomap_free(resource_size_t base, unsigned long size)
 }
 EXPORT_SYMBOL_GPL(iomap_free);
 
-void *kmap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	preempt_disable();
-	pagefault_disable();
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR * smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	set_pte(kmap_pte - idx, pfn_pte(pfn, prot));
-	arch_flush_lazy_mmu_mode();
-
-	return (void *)vaddr;
-}
-
-/*
- * Map 'pfn' using protections 'prot'
- */
-void __iomem *
-iomap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot)
+void __iomem *__iomap_local_pfn_prot(unsigned long pfn, pgprot_t prot)
 {
 	/*
 	 * For non-PAT systems, translate non-WB request to UC- just in
@@ -81,36 +60,6 @@ iomap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot)
 	/* Filter out unsupported __PAGE_KERNEL* bits: */
 	pgprot_val(prot) &= __default_kernel_pte_mask;
 
-	return (void __force __iomem *) kmap_atomic_prot_pfn(pfn, prot);
-}
-EXPORT_SYMBOL_GPL(iomap_atomic_prot_pfn);
-
-void
-iounmap_atomic(void __iomem *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-
-	if (vaddr >= __fix_to_virt(FIX_KMAP_END) &&
-	    vaddr <= __fix_to_virt(FIX_KMAP_BEGIN)) {
-		int idx, type;
-
-		type = kmap_atomic_idx();
-		idx = type + KM_TYPE_NR * smp_processor_id();
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-		WARN_ON_ONCE(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-#endif
-		/*
-		 * Force other mappings to Oops if they'll try to access this
-		 * pte without first remap it.  Keeping stale mappings around
-		 * is a bad idea also, in case the page changes cacheability
-		 * attributes or becomes a protected page in a hypervisor.
-		 */
-		kpte_clear_flush(kmap_pte-idx, vaddr);
-		kmap_atomic_idx_pop();
-	}
-
-	pagefault_enable();
-	preempt_enable();
+	return (void __force __iomem *)__kmap_local_pfn_prot(pfn, prot);
 }
-EXPORT_SYMBOL_GPL(iounmap_atomic);
+EXPORT_SYMBOL_GPL(__iomap_local_pfn_prot);
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index d0dfa50bd0bb..dc22ef3cf4be 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -666,6 +666,7 @@ endchoice
 config HIGHMEM
 	bool "High Memory Support"
 	depends on MMU
+	select KMAP_LOCAL
 	help
 	  Linux can use the full amount of RAM in the system by
 	  default. However, the default MMUv2 setup only maps the
diff --git a/arch/xtensa/include/asm/fixmap.h b/arch/xtensa/include/asm/fixmap.h
index a06ffb0c61c7..1c65dc1d3397 100644
--- a/arch/xtensa/include/asm/fixmap.h
+++ b/arch/xtensa/include/asm/fixmap.h
@@ -16,64 +16,23 @@
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
 #include <linux/pgtable.h>
-#include <asm/kmap_types.h>
-#endif
+#include <asm/kmap_size.h>
 
-/*
- * Here we define all the compile-time 'special' virtual
- * addresses. The point is to have a constant address at
- * compile time, but to set the physical address only
- * in the boot process. We allocate these special addresses
- * from the start of the consistent memory region upwards.
- * Also this lets us do fail-safe vmalloc(), we
- * can guarantee that these special addresses and
- * vmalloc()-ed addresses never overlap.
- *
- * these 'compile-time allocated' memory buffers are
- * fixed-size 4k pages. (or larger if used with an increment
- * higher than 1) use fixmap_set(idx,phys) to associate
- * physical memory with fixmap indices.
- */
+/* The map slots for temporary mappings via kmap_atomic/local(). */
 enum fixed_addresses {
-#ifdef CONFIG_HIGHMEM
-	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_BEGIN,
 	FIX_KMAP_END = FIX_KMAP_BEGIN +
-		(KM_TYPE_NR * NR_CPUS * DCACHE_N_COLORS) - 1,
-#endif
+		(KM_MAX_IDX * NR_CPUS * DCACHE_N_COLORS) - 1,
 	__end_of_fixed_addresses
 };
 
-#define FIXADDR_TOP     (XCHAL_KSEG_CACHED_VADDR - PAGE_SIZE)
+#define FIXADDR_END     (XCHAL_KSEG_CACHED_VADDR - PAGE_SIZE)
 #define FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
-#define FIXADDR_START	((FIXADDR_TOP - FIXADDR_SIZE) & PMD_MASK)
+/* Enforce that FIXADDR_START is PMD aligned to handle cache aliasing */
+#define FIXADDR_START	((FIXADDR_END - FIXADDR_SIZE) & PMD_MASK)
+#define FIXADDR_TOP	(FIXADDR_START + FIXADDR_SIZE - PAGE_SIZE)
 
-#define __fix_to_virt(x)	(FIXADDR_START + ((x) << PAGE_SHIFT))
-#define __virt_to_fix(x)	(((x) - FIXADDR_START) >> PAGE_SHIFT)
-
-#ifndef __ASSEMBLY__
-/*
- * 'index to address' translation. If anyone tries to use the idx
- * directly without translation, we catch the bug with a NULL-deference
- * kernel oops. Illegal ranges of incoming indices are caught too.
- */
-static __always_inline unsigned long fix_to_virt(const unsigned int idx)
-{
-	/* Check if this memory layout is broken because fixmap overlaps page
-	 * table.
-	 */
-	BUILD_BUG_ON(FIXADDR_START <
-		     TLBTEMP_BASE_1 + TLBTEMP_SIZE);
-	BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
-	return __fix_to_virt(idx);
-}
-
-static inline unsigned long virt_to_fix(const unsigned long vaddr)
-{
-	BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
-	return __virt_to_fix(vaddr);
-}
-
-#endif
+#include <asm-generic/fixmap.h>
 
+#endif /* CONFIG_HIGHMEM */
 #endif
diff --git a/arch/xtensa/include/asm/highmem.h b/arch/xtensa/include/asm/highmem.h
index eac503215f17..34b8b620e7f1 100644
--- a/arch/xtensa/include/asm/highmem.h
+++ b/arch/xtensa/include/asm/highmem.h
@@ -12,13 +12,13 @@
 #ifndef _XTENSA_HIGHMEM_H
 #define _XTENSA_HIGHMEM_H
 
+#ifdef CONFIG_HIGHMEM
 #include <linux/wait.h>
 #include <linux/pgtable.h>
 #include <asm/cacheflush.h>
 #include <asm/fixmap.h>
-#include <asm/kmap_types.h>
 
-#define PKMAP_BASE		((FIXADDR_START - \
+#define PKMAP_BASE		((FIXADDR_START -			\
 				  (LAST_PKMAP + 1) * PAGE_SIZE) & PMD_MASK)
 #define LAST_PKMAP		(PTRS_PER_PTE * DCACHE_N_COLORS)
 #define LAST_PKMAP_MASK		(LAST_PKMAP - 1)
@@ -59,6 +59,13 @@ static inline wait_queue_head_t *get_pkmap_wait_queue_head(unsigned int color)
 {
 	return pkmap_map_wait_arr + color;
 }
+
+enum fixed_addresses kmap_local_map_idx(int type, unsigned long pfn);
+#define arch_kmap_local_map_idx		kmap_local_map_idx
+
+enum fixed_addresses kmap_local_unmap_idx(int type, unsigned long addr);
+#define arch_kmap_local_unmap_idx	kmap_local_unmap_idx
+
 #endif
 
 extern pte_t *pkmap_page_table;
@@ -68,6 +75,10 @@ static inline void flush_cache_kmaps(void)
 	flush_cache_all();
 }
 
+#define arch_kmap_local_post_unmap(vaddr)	\
+	local_flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE)
+
 void kmap_init(void);
 
+#endif /* CONFIG_HIGHMEM */
 #endif
diff --git a/arch/xtensa/mm/highmem.c b/arch/xtensa/mm/highmem.c
index 673196fe862e..35c4f7d4a333 100644
--- a/arch/xtensa/mm/highmem.c
+++ b/arch/xtensa/mm/highmem.c
@@ -12,8 +12,6 @@
 #include <linux/highmem.h>
 #include <asm/tlbflush.h>
 
-static pte_t *kmap_pte;
-
 #if DCACHE_WAY_SIZE > PAGE_SIZE
 unsigned int last_pkmap_nr_arr[DCACHE_N_COLORS];
 wait_queue_head_t pkmap_map_wait_arr[DCACHE_N_COLORS];
@@ -25,67 +23,37 @@ static void __init kmap_waitqueues_init(void)
 	for (i = 0; i < ARRAY_SIZE(pkmap_map_wait_arr); ++i)
 		init_waitqueue_head(pkmap_map_wait_arr + i);
 }
-#else
-static inline void kmap_waitqueues_init(void)
-{
-}
-#endif
 
 static inline enum fixed_addresses kmap_idx(int type, unsigned long color)
 {
-	return (type + KM_TYPE_NR * smp_processor_id()) * DCACHE_N_COLORS +
-		color;
+	int idx = (type + KM_MAX_IDX * smp_processor_id()) * DCACHE_N_COLORS;
+
+	/*
+	 * The fixmap operates top down, so the color offset needs to be
+	 * reverse as well.
+	 */
+	return idx + DCACHE_N_COLORS - 1 - color;
 }
 
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
+enum fixed_addresses kmap_local_map_idx(int type, unsigned long pfn)
 {
-	enum fixed_addresses idx;
-	unsigned long vaddr;
-
-	idx = kmap_idx(kmap_atomic_idx_push(),
-		       DCACHE_ALIAS(page_to_phys(page)));
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(*(kmap_pte + idx)));
-#endif
-	set_pte(kmap_pte + idx, mk_pte(page, prot));
-
-	return (void *)vaddr;
+	return kmap_idx(type, DCACHE_ALIAS(pfn << PAGE_SHIFT));
 }
-EXPORT_SYMBOL(kmap_atomic_high_prot);
 
-void kunmap_atomic_high(void *kvaddr)
+enum fixed_addresses kmap_local_unmap_idx(int type, unsigned long addr)
 {
-	if (kvaddr >= (void *)FIXADDR_START &&
-	    kvaddr < (void *)FIXADDR_TOP) {
-		int idx = kmap_idx(kmap_atomic_idx(),
-				   DCACHE_ALIAS((unsigned long)kvaddr));
-
-		/*
-		 * Force other mappings to Oops if they'll try to access this
-		 * pte without first remap it.  Keeping stale mappings around
-		 * is a bad idea also, in case the page changes cacheability
-		 * attributes or becomes a protected page in a hypervisor.
-		 */
-		pte_clear(&init_mm, kvaddr, kmap_pte + idx);
-		local_flush_tlb_kernel_range((unsigned long)kvaddr,
-					     (unsigned long)kvaddr + PAGE_SIZE);
-
-		kmap_atomic_idx_pop();
-	}
+	return kmap_idx(type, DCACHE_ALIAS(addr));
 }
-EXPORT_SYMBOL(kunmap_atomic_high);
+
+#else
+static inline void kmap_waitqueues_init(void) { }
+#endif
 
 void __init kmap_init(void)
 {
-	unsigned long kmap_vstart;
-
 	/* Check if this memory layout is broken because PKMAP overlaps
 	 * page table.
 	 */
 	BUILD_BUG_ON(PKMAP_BASE < TLBTEMP_BASE_1 + TLBTEMP_SIZE);
-	/* cache the first kmap pte */
-	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
-	kmap_pte = virt_to_kpte(kmap_vstart);
 	kmap_waitqueues_init();
 }
diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
index c6fc83efee0c..0f85666bcbeb 100644
--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -147,8 +147,8 @@ void __init mem_init(void)
 #ifdef CONFIG_HIGHMEM
 		PKMAP_BASE, PKMAP_BASE + LAST_PKMAP * PAGE_SIZE,
 		(LAST_PKMAP*PAGE_SIZE) >> 10,
-		FIXADDR_START, FIXADDR_TOP,
-		(FIXADDR_TOP - FIXADDR_START) >> 10,
+		FIXADDR_START, FIXADDR_END,
+		(FIXADDR_END - FIXADDR_START) >> 10,
 #endif
 		PAGE_OFFSET, PAGE_OFFSET +
 		(max_low_pfn - min_low_pfn) * PAGE_SIZE,
diff --git a/arch/xtensa/mm/mmu.c b/arch/xtensa/mm/mmu.c
index fd2193df8a14..7e4d97dc8bd8 100644
--- a/arch/xtensa/mm/mmu.c
+++ b/arch/xtensa/mm/mmu.c
@@ -52,7 +52,8 @@ static void * __init init_pmd(unsigned long vaddr, unsigned long n_pages)
 
 static void __init fixedrange_init(void)
 {
-	init_pmd(__fix_to_virt(0), __end_of_fixed_addresses);
+	BUILD_BUG_ON(FIXADDR_START < TLBTEMP_BASE_1 + TLBTEMP_SIZE);
+	init_pmd(FIXADDR_START, __end_of_fixed_addresses);
 }
 #endif
 
diff --git a/fs/aio.c b/fs/aio.c
index c45c20d87538..0247daf55987 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -43,7 +43,6 @@
 #include <linux/mount.h>
 #include <linux/pseudo_fs.h>
 
-#include <asm/kmap_types.h>
 #include <linux/uaccess.h>
 #include <linux/nospec.h>
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0378933d163c..01947f603300 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -17,7 +17,6 @@
 #include <linux/wait.h>
 #include <linux/slab.h>
 #include <trace/events/btrfs.h>
-#include <asm/kmap_types.h>
 #include <asm/unaligned.h>
 #include <linux/pagemap.h>
 #include <linux/btrfs.h>
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 65ec2029fa80..7052441be967 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -382,9 +382,9 @@ static inline void task_context_switch_counts(struct seq_file *m,
 static void task_cpus_allowed(struct seq_file *m, struct task_struct *task)
 {
 	seq_printf(m, "Cpus_allowed:\t%*pb\n",
-		   cpumask_pr_args(task->cpus_ptr));
+		   cpumask_pr_args(&task->cpus_mask));
 	seq_printf(m, "Cpus_allowed_list:\t%*pbl\n",
-		   cpumask_pr_args(task->cpus_ptr));
+		   cpumask_pr_args(&task->cpus_mask));
 }
 
 static inline void task_core_dumping(struct seq_file *m, struct mm_struct *mm)
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index e78bbb9a07e9..4365b9aa3e3f 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -30,7 +30,7 @@ mandatory-y += irq.h
 mandatory-y += irq_regs.h
 mandatory-y += irq_work.h
 mandatory-y += kdebug.h
-mandatory-y += kmap_types.h
+mandatory-y += kmap_size.h
 mandatory-y += kprobes.h
 mandatory-y += linkage.h
 mandatory-y += local.h
diff --git a/include/asm-generic/kmap_size.h b/include/asm-generic/kmap_size.h
new file mode 100644
index 000000000000..6e36b2443ece
--- /dev/null
+++ b/include/asm-generic/kmap_size.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_KMAP_SIZE_H
+#define _ASM_GENERIC_KMAP_SIZE_H
+
+/* For debug this provides guard pages between the maps */
+#ifdef CONFIG_DEBUG_KMAP_LOCAL
+# define KM_MAX_IDX	33
+#else
+# define KM_MAX_IDX	16
+#endif
+
+#endif
diff --git a/include/asm-generic/kmap_types.h b/include/asm-generic/kmap_types.h
deleted file mode 100644
index 9f95b7b63d19..000000000000
--- a/include/asm-generic/kmap_types.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_GENERIC_KMAP_TYPES_H
-#define _ASM_GENERIC_KMAP_TYPES_H
-
-#ifdef __WITH_KM_FENCE
-# define KM_TYPE_NR 41
-#else
-# define KM_TYPE_NR 20
-#endif
-
-#endif
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index bc56287a1ed1..0042ef362511 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -152,6 +152,7 @@ enum cpuhp_state {
 	CPUHP_AP_ONLINE,
 	CPUHP_TEARDOWN_CPU,
 	CPUHP_AP_ONLINE_IDLE,
+	CPUHP_AP_SCHED_WAIT_EMPTY,
 	CPUHP_AP_SMPBOOT_THREADS,
 	CPUHP_AP_X86_VDSO_VMA_ONLINE,
 	CPUHP_AP_IRQ_AFFINITY_ONLINE,
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index f0d895d6ac39..383684e30f12 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -199,6 +199,11 @@ static inline int cpumask_any_and_distribute(const struct cpumask *src1p,
 	return cpumask_next_and(-1, src1p, src2p);
 }
 
+static inline int cpumask_any_distribute(const struct cpumask *srcp)
+{
+	return cpumask_first(srcp);
+}
+
 #define for_each_cpu(cpu, mask)			\
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
 #define for_each_cpu_not(cpu, mask)		\
@@ -252,6 +257,7 @@ int cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
 unsigned int cpumask_local_spread(unsigned int i, int node);
 int cpumask_any_and_distribute(const struct cpumask *src1p,
 			       const struct cpumask *src2p);
+int cpumask_any_distribute(const struct cpumask *srcp);
 
 /**
  * for_each_cpu - iterate over every cpu in a mask
diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
new file mode 100644
index 000000000000..1bbe96dc8be6
--- /dev/null
+++ b/include/linux/highmem-internal.h
@@ -0,0 +1,232 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_HIGHMEM_INTERNAL_H
+#define _LINUX_HIGHMEM_INTERNAL_H
+
+/*
+ * Outside of CONFIG_HIGHMEM to support X86 32bit iomap_atomic() cruft.
+ */
+#ifdef CONFIG_KMAP_LOCAL
+void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot);
+void *__kmap_local_page_prot(struct page *page, pgprot_t prot);
+void kunmap_local_indexed(void *vaddr);
+void kmap_local_fork(struct task_struct *tsk);
+void __kmap_local_sched_out(void);
+void __kmap_local_sched_in(void);
+static inline void kmap_assert_nomap(void)
+{
+	DEBUG_LOCKS_WARN_ON(current->kmap_ctrl.idx);
+}
+#else
+static inline void kmap_local_fork(struct task_struct *tsk) { }
+static inline void kmap_assert_nomap(void) { }
+#endif
+
+#ifdef CONFIG_HIGHMEM
+#include <asm/highmem.h>
+
+#ifndef ARCH_HAS_KMAP_FLUSH_TLB
+static inline void kmap_flush_tlb(unsigned long addr) { }
+#endif
+
+#ifndef kmap_prot
+#define kmap_prot PAGE_KERNEL
+#endif
+
+void *kmap_high(struct page *page);
+void kunmap_high(struct page *page);
+void __kmap_flush_unused(void);
+struct page *__kmap_to_page(void *addr);
+
+static inline void *kmap(struct page *page)
+{
+	void *addr;
+
+	might_sleep();
+	if (!PageHighMem(page))
+		addr = page_address(page);
+	else
+		addr = kmap_high(page);
+	kmap_flush_tlb((unsigned long)addr);
+	return addr;
+}
+
+static inline void kunmap(struct page *page)
+{
+	might_sleep();
+	if (!PageHighMem(page))
+		return;
+	kunmap_high(page);
+}
+
+static inline struct page *kmap_to_page(void *addr)
+{
+	return __kmap_to_page(addr);
+}
+
+static inline void kmap_flush_unused(void)
+{
+	__kmap_flush_unused();
+}
+
+static inline void *kmap_local_page(struct page *page)
+{
+	return __kmap_local_page_prot(page, kmap_prot);
+}
+
+static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
+{
+	return __kmap_local_page_prot(page, prot);
+}
+
+static inline void *kmap_local_pfn(unsigned long pfn)
+{
+	return __kmap_local_pfn_prot(pfn, kmap_prot);
+}
+
+static inline void __kunmap_local(void *vaddr)
+{
+	kunmap_local_indexed(vaddr);
+}
+
+static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
+{
+	preempt_disable();
+	pagefault_disable();
+	return __kmap_local_page_prot(page, prot);
+}
+
+static inline void *kmap_atomic(struct page *page)
+{
+	return kmap_atomic_prot(page, kmap_prot);
+}
+
+static inline void *kmap_atomic_pfn(unsigned long pfn)
+{
+	preempt_disable();
+	pagefault_disable();
+	return __kmap_local_pfn_prot(pfn, kmap_prot);
+}
+
+static inline void __kunmap_atomic(void *addr)
+{
+	kunmap_local_indexed(addr);
+	pagefault_enable();
+	preempt_enable();
+}
+
+unsigned int __nr_free_highpages(void);
+extern atomic_long_t _totalhigh_pages;
+
+static inline unsigned int nr_free_highpages(void)
+{
+	return __nr_free_highpages();
+}
+
+static inline unsigned long totalhigh_pages(void)
+{
+	return (unsigned long)atomic_long_read(&_totalhigh_pages);
+}
+
+static inline void totalhigh_pages_inc(void)
+{
+	atomic_long_inc(&_totalhigh_pages);
+}
+
+static inline void totalhigh_pages_add(long count)
+{
+	atomic_long_add(count, &_totalhigh_pages);
+}
+
+#else /* CONFIG_HIGHMEM */
+
+static inline struct page *kmap_to_page(void *addr)
+{
+	return virt_to_page(addr);
+}
+
+static inline void *kmap(struct page *page)
+{
+	might_sleep();
+	return page_address(page);
+}
+
+static inline void kunmap_high(struct page *page) { }
+static inline void kmap_flush_unused(void) { }
+
+static inline void kunmap(struct page *page)
+{
+#ifdef ARCH_HAS_FLUSH_ON_KUNMAP
+	kunmap_flush_on_unmap(page_address(page));
+#endif
+}
+
+static inline void *kmap_local_page(struct page *page)
+{
+	return page_address(page);
+}
+
+static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
+{
+	return kmap_local_page(page);
+}
+
+static inline void *kmap_local_pfn(unsigned long pfn)
+{
+	return kmap_local_page(pfn_to_page(pfn));
+}
+
+static inline void __kunmap_local(void *addr)
+{
+#ifdef ARCH_HAS_FLUSH_ON_KUNMAP
+	kunmap_flush_on_unmap(addr);
+#endif
+}
+
+static inline void *kmap_atomic(struct page *page)
+{
+	preempt_disable();
+	pagefault_disable();
+	return page_address(page);
+}
+
+static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
+{
+	return kmap_atomic(page);
+}
+
+static inline void *kmap_atomic_pfn(unsigned long pfn)
+{
+	return kmap_atomic(pfn_to_page(pfn));
+}
+
+static inline void __kunmap_atomic(void *addr)
+{
+#ifdef ARCH_HAS_FLUSH_ON_KUNMAP
+	kunmap_flush_on_unmap(addr);
+#endif
+	pagefault_enable();
+	preempt_enable();
+}
+
+static inline unsigned int nr_free_highpages(void) { return 0; }
+static inline unsigned long totalhigh_pages(void) { return 0UL; }
+
+#endif /* CONFIG_HIGHMEM */
+
+/*
+ * Prevent people trying to call kunmap_atomic() as if it were kunmap()
+ * kunmap_atomic() should get the return value of kmap_atomic, not the page.
+ */
+#define kunmap_atomic(__addr)					\
+do {								\
+	BUILD_BUG_ON(__same_type((__addr), struct page *));	\
+	__kunmap_atomic(__addr);				\
+} while (0)
+
+#define kunmap_local(__addr)					\
+do {								\
+	BUILD_BUG_ON(__same_type((__addr), struct page *));	\
+	__kunmap_local(__addr);					\
+} while (0)
+
+#endif
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 14e6202ce47f..f597830f26b4 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -11,217 +11,137 @@
 
 #include <asm/cacheflush.h>
 
-#ifndef ARCH_HAS_FLUSH_ANON_PAGE
-static inline void flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned long vmaddr)
-{
-}
-#endif
+#include "highmem-internal.h"
 
-#ifndef ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
-static inline void flush_kernel_dcache_page(struct page *page)
-{
-}
-static inline void flush_kernel_vmap_range(void *vaddr, int size)
-{
-}
-static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
-{
-}
-#endif
-
-#include <asm/kmap_types.h>
-
-#ifdef CONFIG_HIGHMEM
-extern void *kmap_atomic_high_prot(struct page *page, pgprot_t prot);
-extern void kunmap_atomic_high(void *kvaddr);
-#include <asm/highmem.h>
-
-#ifndef ARCH_HAS_KMAP_FLUSH_TLB
-static inline void kmap_flush_tlb(unsigned long addr) { }
-#endif
-
-#ifndef kmap_prot
-#define kmap_prot PAGE_KERNEL
-#endif
-
-void *kmap_high(struct page *page);
-static inline void *kmap(struct page *page)
-{
-	void *addr;
-
-	might_sleep();
-	if (!PageHighMem(page))
-		addr = page_address(page);
-	else
-		addr = kmap_high(page);
-	kmap_flush_tlb((unsigned long)addr);
-	return addr;
-}
-
-void kunmap_high(struct page *page);
-
-static inline void kunmap(struct page *page)
-{
-	might_sleep();
-	if (!PageHighMem(page))
-		return;
-	kunmap_high(page);
-}
-
-/*
- * kmap_atomic/kunmap_atomic is significantly faster than kmap/kunmap because
- * no global lock is needed and because the kmap code must perform a global TLB
- * invalidation when the kmap pool wraps.
+/**
+ * kmap - Map a page for long term usage
+ * @page:	Pointer to the page to be mapped
+ *
+ * Returns: The virtual address of the mapping
+ *
+ * Can only be invoked from preemptible task context because on 32bit
+ * systems with CONFIG_HIGHMEM enabled this function might sleep.
  *
- * However when holding an atomic kmap it is not legal to sleep, so atomic
- * kmaps are appropriate for short, tight code paths only.
+ * For systems with CONFIG_HIGHMEM=n and for pages in the low memory area
+ * this returns the virtual address of the direct kernel mapping.
  *
- * The use of kmap_atomic/kunmap_atomic is discouraged - kmap/kunmap
- * gives a more generic (and caching) interface. But kmap_atomic can
- * be used in IRQ contexts, so in some (very limited) cases we need
- * it.
+ * The returned virtual address is globally visible and valid up to the
+ * point where it is unmapped via kunmap(). The pointer can be handed to
+ * other contexts.
+ *
+ * For highmem pages on 32bit systems this can be slow as the mapping space
+ * is limited and protected by a global lock. In case that there is no
+ * mapping slot available the function blocks until a slot is released via
+ * kunmap().
  */
-static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
-{
-	preempt_disable();
-	pagefault_disable();
-	if (!PageHighMem(page))
-		return page_address(page);
-	return kmap_atomic_high_prot(page, prot);
-}
-#define kmap_atomic(page)	kmap_atomic_prot(page, kmap_prot)
-
-/* declarations for linux/mm/highmem.c */
-unsigned int nr_free_highpages(void);
-extern atomic_long_t _totalhigh_pages;
-static inline unsigned long totalhigh_pages(void)
-{
-	return (unsigned long)atomic_long_read(&_totalhigh_pages);
-}
-
-static inline void totalhigh_pages_inc(void)
-{
-	atomic_long_inc(&_totalhigh_pages);
-}
-
-static inline void totalhigh_pages_dec(void)
-{
-	atomic_long_dec(&_totalhigh_pages);
-}
-
-static inline void totalhigh_pages_add(long count)
-{
-	atomic_long_add(count, &_totalhigh_pages);
-}
-
-static inline void totalhigh_pages_set(long val)
-{
-	atomic_long_set(&_totalhigh_pages, val);
-}
-
-void kmap_flush_unused(void);
+static inline void *kmap(struct page *page);
 
-struct page *kmap_to_page(void *addr);
-
-#else /* CONFIG_HIGHMEM */
+/**
+ * kunmap - Unmap the virtual address mapped by kmap()
+ * @addr:	Virtual address to be unmapped
+ *
+ * Counterpart to kmap(). A NOOP for CONFIG_HIGHMEM=n and for mappings of
+ * pages in the low memory area.
+ */
+static inline void kunmap(struct page *page);
 
-static inline unsigned int nr_free_highpages(void) { return 0; }
+/**
+ * kmap_to_page - Get the page for a kmap'ed address
+ * @addr:	The address to look up
+ *
+ * Returns: The page which is mapped to @addr.
+ */
+static inline struct page *kmap_to_page(void *addr);
 
-static inline struct page *kmap_to_page(void *addr)
-{
-	return virt_to_page(addr);
-}
+/**
+ * kmap_flush_unused - Flush all unused kmap mappings in order to
+ *		       remove stray mappings
+ */
+static inline void kmap_flush_unused(void);
 
-static inline unsigned long totalhigh_pages(void) { return 0UL; }
+/**
+ * kmap_local_page - Map a page for temporary usage
+ * @page:	Pointer to the page to be mapped
+ *
+ * Returns: The virtual address of the mapping
+ *
+ * Can be invoked from any context.
+ *
+ * Requires careful handling when nesting multiple mappings because the map
+ * management is stack based. The unmap has to be in the reverse order of
+ * the map operation:
+ *
+ * addr1 = kmap_local_page(page1);
+ * addr2 = kmap_local_page(page2);
+ * ...
+ * kunmap_local(addr2);
+ * kunmap_local(addr1);
+ *
+ * Unmapping addr1 before addr2 is invalid and causes malfunction.
+ *
+ * Contrary to kmap() mappings the mapping is only valid in the context of
+ * the caller and cannot be handed to other contexts.
+ *
+ * On CONFIG_HIGHMEM=n kernels and for low memory pages this returns the
+ * virtual address of the direct mapping. Only real highmem pages are
+ * temporarily mapped.
+ *
+ * While it is significantly faster than kmap() for the higmem case it
+ * comes with restrictions about the pointer validity. Only use when really
+ * necessary.
+ *
+ * On HIGHMEM enabled systems mapping a highmem page has the side effect of
+ * disabling migration in order to keep the virtual address stable across
+ * preemption. No caller of kmap_local_page() can rely on this side effect.
+ */
+static inline void *kmap_local_page(struct page *page);
 
-static inline void *kmap(struct page *page)
-{
-	might_sleep();
-	return page_address(page);
-}
+/**
+ * kmap_atomic - Atomically map a page for temporary usage - Deprecated!
+ * @page:	Pointer to the page to be mapped
+ *
+ * Returns: The virtual address of the mapping
+ *
+ * Effectively a wrapper around kmap_local_page() which disables pagefaults
+ * and preemption.
+ *
+ * Do not use in new code. Use kmap_local_page() instead.
+ */
+static inline void *kmap_atomic(struct page *page);
 
-static inline void kunmap_high(struct page *page)
-{
-}
+/**
+ * kunmap_atomic - Unmap the virtual address mapped by kmap_atomic()
+ * @addr:	Virtual address to be unmapped
+ *
+ * Counterpart to kmap_atomic().
+ *
+ * Effectively a wrapper around kunmap_local() which additionally undoes
+ * the side effects of kmap_atomic(), i.e. reenabling pagefaults and
+ * preemption.
+ */
 
-static inline void kunmap(struct page *page)
-{
-#ifdef ARCH_HAS_FLUSH_ON_KUNMAP
-	kunmap_flush_on_unmap(page_address(page));
-#endif
-}
+/* Highmem related interfaces for management code */
+static inline unsigned int nr_free_highpages(void);
+static inline unsigned long totalhigh_pages(void);
 
-static inline void *kmap_atomic(struct page *page)
+#ifndef ARCH_HAS_FLUSH_ANON_PAGE
+static inline void flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned long vmaddr)
 {
-	preempt_disable();
-	pagefault_disable();
-	return page_address(page);
 }
-#define kmap_atomic_prot(page, prot)	kmap_atomic(page)
-
-static inline void kunmap_atomic_high(void *addr)
-{
-	/*
-	 * Mostly nothing to do in the CONFIG_HIGHMEM=n case as kunmap_atomic()
-	 * handles re-enabling faults + preemption
-	 */
-#ifdef ARCH_HAS_FLUSH_ON_KUNMAP
-	kunmap_flush_on_unmap(addr);
 #endif
-}
-
-#define kmap_atomic_pfn(pfn)	kmap_atomic(pfn_to_page(pfn))
-
-#define kmap_flush_unused()	do {} while(0)
-
-#endif /* CONFIG_HIGHMEM */
-
-#if defined(CONFIG_HIGHMEM) || defined(CONFIG_X86_32)
-
-DECLARE_PER_CPU(int, __kmap_atomic_idx);
 
-static inline int kmap_atomic_idx_push(void)
+#ifndef ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
+static inline void flush_kernel_dcache_page(struct page *page)
 {
-	int idx = __this_cpu_inc_return(__kmap_atomic_idx) - 1;
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-	WARN_ON_ONCE(in_irq() && !irqs_disabled());
-	BUG_ON(idx >= KM_TYPE_NR);
-#endif
-	return idx;
 }
-
-static inline int kmap_atomic_idx(void)
+static inline void flush_kernel_vmap_range(void *vaddr, int size)
 {
-	return __this_cpu_read(__kmap_atomic_idx) - 1;
 }
-
-static inline void kmap_atomic_idx_pop(void)
+static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
 {
-#ifdef CONFIG_DEBUG_HIGHMEM
-	int idx = __this_cpu_dec_return(__kmap_atomic_idx);
-
-	BUG_ON(idx < 0);
-#else
-	__this_cpu_dec(__kmap_atomic_idx);
-#endif
 }
-
 #endif
 
-/*
- * Prevent people trying to call kunmap_atomic() as if it were kunmap()
- * kunmap_atomic() should get the return value of kmap_atomic, not the page.
- */
-#define kunmap_atomic(addr)                                     \
-do {                                                            \
-	BUILD_BUG_ON(__same_type((addr), struct page *));       \
-	kunmap_atomic_high(addr);                                  \
-	pagefault_enable();                                     \
-	preempt_enable();                                       \
-} while (0)
-
-
 /* when CONFIG_HIGHMEM is not set these will be plain clear/copy_page */
 #ifndef clear_user_highpage
 static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
diff --git a/include/linux/io-mapping.h b/include/linux/io-mapping.h
index c75e4d3d8833..c093e81310a9 100644
--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -69,13 +69,32 @@ io_mapping_map_atomic_wc(struct io_mapping *mapping,
 
 	BUG_ON(offset >= mapping->size);
 	phys_addr = mapping->base + offset;
-	return iomap_atomic_prot_pfn(PHYS_PFN(phys_addr), mapping->prot);
+	preempt_disable();
+	pagefault_disable();
+	return __iomap_local_pfn_prot(PHYS_PFN(phys_addr), mapping->prot);
 }
 
 static inline void
 io_mapping_unmap_atomic(void __iomem *vaddr)
 {
-	iounmap_atomic(vaddr);
+	kunmap_local_indexed((void __force *)vaddr);
+	pagefault_enable();
+	preempt_enable();
+}
+
+static inline void __iomem *
+io_mapping_map_local_wc(struct io_mapping *mapping, unsigned long offset)
+{
+	resource_size_t phys_addr;
+
+	BUG_ON(offset >= mapping->size);
+	phys_addr = mapping->base + offset;
+	return __iomap_local_pfn_prot(PHYS_PFN(phys_addr), mapping->prot);
+}
+
+static inline void io_mapping_unmap_local(void __iomem *vaddr)
+{
+	kunmap_local_indexed((void __force *)vaddr);
 }
 
 static inline void __iomem *
@@ -97,7 +116,7 @@ io_mapping_unmap(void __iomem *vaddr)
 	iounmap(vaddr);
 }
 
-#else
+#else  /* HAVE_ATOMIC_IOMAP */
 
 #include <linux/uaccess.h>
 
@@ -162,7 +181,18 @@ io_mapping_unmap_atomic(void __iomem *vaddr)
 	preempt_enable();
 }
 
-#endif /* HAVE_ATOMIC_IOMAP */
+static inline void __iomem *
+io_mapping_map_local_wc(struct io_mapping *mapping, unsigned long offset)
+{
+	return io_mapping_map_wc(mapping, offset, PAGE_SIZE);
+}
+
+static inline void io_mapping_unmap_local(void __iomem *vaddr)
+{
+	io_mapping_unmap(vaddr);
+}
+
+#endif /* !HAVE_ATOMIC_IOMAP */
 
 static inline struct io_mapping *
 io_mapping_create_wc(resource_size_t base,
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2f05e9128201..665837f9a831 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -204,6 +204,7 @@ extern int _cond_resched(void);
 extern void ___might_sleep(const char *file, int line, int preempt_offset);
 extern void __might_sleep(const char *file, int line, int preempt_offset);
 extern void __cant_sleep(const char *file, int line, int preempt_offset);
+extern void __cant_migrate(const char *file, int line);
 
 /**
  * might_sleep - annotation for functions that can sleep
@@ -227,6 +228,18 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
 # define cant_sleep() \
 	do { __cant_sleep(__FILE__, __LINE__, 0); } while (0)
 # define sched_annotate_sleep()	(current->task_state_change = 0)
+
+/**
+ * cant_migrate - annotation for functions that cannot migrate
+ *
+ * Will print a stack trace if executed in code which is migratable
+ */
+# define cant_migrate()							\
+	do {								\
+		if (IS_ENABLED(CONFIG_SMP))				\
+			__cant_migrate(__FILE__, __LINE__);		\
+	} while (0)
+
 /**
  * non_block_start - annotate the start of section where sleeping is prohibited
  *
@@ -251,6 +264,7 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
 				   int preempt_offset) { }
 # define might_sleep() do { might_resched(); } while (0)
 # define cant_sleep() do { } while (0)
+# define cant_migrate()		do { } while (0)
 # define sched_annotate_sleep() do { } while (0)
 # define non_block_start() do { } while (0)
 # define non_block_end() do { } while (0)
@@ -258,13 +272,6 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
 
 #define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
 
-#ifndef CONFIG_PREEMPT_RT
-# define cant_migrate()		cant_sleep()
-#else
-  /* Placeholder for now */
-# define cant_migrate()		do { } while (0)
-#endif
-
 /**
  * abs - return absolute value of an argument
  * @x: the value.  If it is unsigned type, it is converted to signed type first.
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 7d9c1c0e149c..6df63cbe8bb0 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -322,34 +322,71 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
 
 #endif
 
-/**
- * migrate_disable - Prevent migration of the current task
+#ifdef CONFIG_SMP
+
+/*
+ * Migrate-Disable and why it is undesired.
  *
- * Maps to preempt_disable() which also disables preemption. Use
- * migrate_disable() to annotate that the intent is to prevent migration,
- * but not necessarily preemption.
+ * When a preempted task becomes elegible to run under the ideal model (IOW it
+ * becomes one of the M highest priority tasks), it might still have to wait
+ * for the preemptee's migrate_disable() section to complete. Thereby suffering
+ * a reduction in bandwidth in the exact duration of the migrate_disable()
+ * section.
  *
- * Can be invoked nested like preempt_disable() and needs the corresponding
- * number of migrate_enable() invocations.
- */
-static __always_inline void migrate_disable(void)
-{
-	preempt_disable();
-}
-
-/**
- * migrate_enable - Allow migration of the current task
+ * Per this argument, the change from preempt_disable() to migrate_disable()
+ * gets us:
+ *
+ * - a higher priority tasks gains reduced wake-up latency; with preempt_disable()
+ *   it would have had to wait for the lower priority task.
+ *
+ * - a lower priority tasks; which under preempt_disable() could've instantly
+ *   migrated away when another CPU becomes available, is now constrained
+ *   by the ability to push the higher priority task away, which might itself be
+ *   in a migrate_disable() section, reducing it's available bandwidth.
+ *
+ * IOW it trades latency / moves the interference term, but it stays in the
+ * system, and as long as it remains unbounded, the system is not fully
+ * deterministic.
+ *
+ *
+ * The reason we have it anyway.
  *
- * Counterpart to migrate_disable().
+ * PREEMPT_RT breaks a number of assumptions traditionally held. By forcing a
+ * number of primitives into becoming preemptible, they would also allow
+ * migration. This turns out to break a bunch of per-cpu usage. To this end,
+ * all these primitives employ migirate_disable() to restore this implicit
+ * assumption.
  *
- * As migrate_disable() can be invoked nested, only the outermost invocation
- * reenables migration.
+ * This is a 'temporary' work-around at best. The correct solution is getting
+ * rid of the above assumptions and reworking the code to employ explicit
+ * per-cpu locking or short preempt-disable regions.
+ *
+ * The end goal must be to get rid of migrate_disable(), alternatively we need
+ * a schedulability theory that does not depend on abritrary migration.
+ *
+ *
+ * Notes on the implementation.
+ *
+ * The implementation is particularly tricky since existing code patterns
+ * dictate neither migrate_disable() nor migrate_enable() is allowed to block.
+ * This means that it cannot use cpus_read_lock() to serialize against hotplug,
+ * nor can it easily migrate itself into a pending affinity mask change on
+ * migrate_enable().
+ *
+ *
+ * Note: even non-work-conserving schedulers like semi-partitioned depends on
+ *       migration, so migrate_disable() is not only a problem for
+ *       work-conserving schedulers.
  *
- * Currently mapped to preempt_enable().
  */
-static __always_inline void migrate_enable(void)
-{
-	preempt_enable();
-}
+extern void migrate_disable(void);
+extern void migrate_enable(void);
+
+#else
+
+static inline void migrate_disable(void) { }
+static inline void migrate_enable(void) { }
+
+#endif /* CONFIG_SMP */
 
 #endif /* __LINUX_PREEMPT_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 063cd120b459..8946911cee9f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -34,6 +34,7 @@
 #include <linux/rseq.h>
 #include <linux/seqlock.h>
 #include <linux/kcsan.h>
+#include <asm/kmap_size.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -629,6 +630,13 @@ struct wake_q_node {
 	struct wake_q_node *next;
 };
 
+struct kmap_ctrl {
+#ifdef CONFIG_KMAP_LOCAL
+	int				idx;
+	pte_t				pteval[KM_MAX_IDX];
+#endif
+};
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/*
@@ -714,6 +722,11 @@ struct task_struct {
 	int				nr_cpus_allowed;
 	const cpumask_t			*cpus_ptr;
 	cpumask_t			cpus_mask;
+	void				*migration_pending;
+#ifdef CONFIG_SMP
+	unsigned short			migration_disabled;
+#endif
+	unsigned short			migration_flags;
 
 #ifdef CONFIG_PREEMPT_RCU
 	int				rcu_read_lock_nesting;
@@ -1289,6 +1302,7 @@ struct task_struct {
 	unsigned int			sequential_io;
 	unsigned int			sequential_io_avg;
 #endif
+	struct kmap_ctrl		kmap_ctrl;
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 	unsigned long			task_state_change;
 #endif
diff --git a/include/linux/sched/hotplug.h b/include/linux/sched/hotplug.h
index 9a62ffdd296f..412cdaba33eb 100644
--- a/include/linux/sched/hotplug.h
+++ b/include/linux/sched/hotplug.h
@@ -11,8 +11,10 @@ extern int sched_cpu_activate(unsigned int cpu);
 extern int sched_cpu_deactivate(unsigned int cpu);
 
 #ifdef CONFIG_HOTPLUG_CPU
+extern int sched_cpu_wait_empty(unsigned int cpu);
 extern int sched_cpu_dying(unsigned int cpu);
 #else
+# define sched_cpu_wait_empty	NULL
 # define sched_cpu_dying	NULL
 #endif
 
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index d5ece7a9a403..a91fb3ad9ec7 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -347,6 +347,8 @@ static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
 
 extern void membarrier_exec_mmap(struct mm_struct *mm);
 
+extern void membarrier_update_current_mm(struct mm_struct *next_mm);
+
 #else
 #ifdef CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS
 static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
@@ -361,6 +363,9 @@ static inline void membarrier_exec_mmap(struct mm_struct *mm)
 static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
 {
 }
+static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
+{
+}
 #endif
 
 #endif /* _LINUX_SCHED_MM_H */
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 9ef7bf686a9f..8f0f778b7c91 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -225,6 +225,14 @@ static inline bool cpus_share_cache(int this_cpu, int that_cpu)
 
 #endif	/* !CONFIG_SMP */
 
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+extern void rebuild_sched_domains_energy(void);
+#else
+static inline void rebuild_sched_domains_energy(void)
+{
+}
+#endif
+
 #ifndef arch_scale_cpu_capacity
 /**
  * arch_scale_cpu_capacity - get the capacity scale factor of a given CPU.
diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index 76d8b09384a7..30577c3aecf8 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -24,6 +24,7 @@ typedef int (*cpu_stop_fn_t)(void *arg);
 struct cpu_stop_work {
 	struct list_head	list;		/* cpu_stopper->works */
 	cpu_stop_fn_t		fn;
+	unsigned long		caller;
 	void			*arg;
 	struct cpu_stop_done	*done;
 };
@@ -36,6 +37,8 @@ void stop_machine_park(int cpu);
 void stop_machine_unpark(int cpu);
 void stop_machine_yield(const struct cpumask *cpumask);
 
+extern void print_stop_info(const char *log_lvl, struct task_struct *task);
+
 #else	/* CONFIG_SMP */
 
 #include <linux/workqueue.h>
@@ -80,6 +83,8 @@ static inline bool stop_one_cpu_nowait(unsigned int cpu,
 	return false;
 }
 
+static inline void print_stop_info(const char *log_lvl, struct task_struct *task) { }
+
 #endif	/* CONFIG_SMP */
 
 /*
diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index c852153ddb0d..f2c4589d4dbf 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -96,6 +96,8 @@ struct sched_param {
  * on a CPU with a capacity big enough to fit the specified value.
  * A task with a max utilization value smaller than 1024 is more likely
  * scheduled on a CPU with no more capacity than the specified value.
+ *
+ * A task utilization boundary can be reset by setting the attribute to -1.
  */
 struct sched_attr {
 	__u32 size;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 57b5b5d0a5fd..53c70c470a38 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -983,25 +983,48 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
  */
 static void rebuild_sched_domains_locked(void)
 {
+	struct cgroup_subsys_state *pos_css;
 	struct sched_domain_attr *attr;
 	cpumask_var_t *doms;
+	struct cpuset *cs;
 	int ndoms;
 
 	lockdep_assert_cpus_held();
 	percpu_rwsem_assert_held(&cpuset_rwsem);
 
 	/*
-	 * We have raced with CPU hotplug. Don't do anything to avoid
+	 * If we have raced with CPU hotplug, return early to avoid
 	 * passing doms with offlined cpu to partition_sched_domains().
-	 * Anyways, hotplug work item will rebuild sched domains.
+	 * Anyways, cpuset_hotplug_workfn() will rebuild sched domains.
+	 *
+	 * With no CPUs in any subpartitions, top_cpuset's effective CPUs
+	 * should be the same as the active CPUs, so checking only top_cpuset
+	 * is enough to detect racing CPU offlines.
 	 */
 	if (!top_cpuset.nr_subparts_cpus &&
 	    !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
 		return;
 
-	if (top_cpuset.nr_subparts_cpus &&
-	   !cpumask_subset(top_cpuset.effective_cpus, cpu_active_mask))
-		return;
+	/*
+	 * With subpartition CPUs, however, the effective CPUs of a partition
+	 * root should be only a subset of the active CPUs.  Since a CPU in any
+	 * partition root could be offlined, all must be checked.
+	 */
+	if (top_cpuset.nr_subparts_cpus) {
+		rcu_read_lock();
+		cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
+			if (!is_partition_root(cs)) {
+				pos_css = css_rightmost_descendant(pos_css);
+				continue;
+			}
+			if (!cpumask_subset(cs->effective_cpus,
+					    cpu_active_mask)) {
+				rcu_read_unlock();
+				return;
+			}
+		}
+		rcu_read_unlock();
+	}
 
 	/* Generate domain masks and attrs */
 	ndoms = generate_sched_domains(&doms, &attr);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6ff2578ecf17..fa535eaa4826 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1602,7 +1602,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.name			= "ap:online",
 	},
 	/*
-	 * Handled on controll processor until the plugged processor manages
+	 * Handled on control processor until the plugged processor manages
 	 * this itself.
 	 */
 	[CPUHP_TEARDOWN_CPU] = {
@@ -1611,6 +1611,13 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.teardown.single	= takedown_cpu,
 		.cant_stop		= true,
 	},
+
+	[CPUHP_AP_SCHED_WAIT_EMPTY] = {
+		.name			= "sched:waitempty",
+		.startup.single		= NULL,
+		.teardown.single	= sched_cpu_wait_empty,
+	},
+
 	/* Handle smpboot threads park/unpark */
 	[CPUHP_AP_SMPBOOT_THREADS] = {
 		.name			= "smpboot/threads:online",
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 2b8366693d5c..4ae1fe0898e9 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -2,6 +2,7 @@
 
 #include <linux/context_tracking.h>
 #include <linux/entry-common.h>
+#include <linux/highmem.h>
 #include <linux/livepatch.h>
 #include <linux/audit.h>
 
@@ -194,6 +195,7 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
 
 	/* Ensure that the address limit is intact and no locks are held */
 	addr_limit_user_check();
+	kmap_assert_nomap();
 	lockdep_assert_irqs_disabled();
 	lockdep_sys_exit();
 }
diff --git a/kernel/exit.c b/kernel/exit.c
index 87a2d515de0d..a3dd6b36f99a 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -475,10 +475,24 @@ static void exit_mm(void)
 	BUG_ON(mm != current->active_mm);
 	/* more a memory barrier than a real lock */
 	task_lock(current);
+	/*
+	 * When a thread stops operating on an address space, the loop
+	 * in membarrier_private_expedited() may not observe that
+	 * tsk->mm, and the loop in membarrier_global_expedited() may
+	 * not observe a MEMBARRIER_STATE_GLOBAL_EXPEDITED
+	 * rq->membarrier_state, so those would not issue an IPI.
+	 * Membarrier requires a memory barrier after accessing
+	 * user-space memory, before clearing tsk->mm or the
+	 * rq->membarrier_state.
+	 */
+	smp_mb__after_spinlock();
+	local_irq_disable();
 	current->mm = NULL;
-	mmap_read_unlock(mm);
+	membarrier_update_current_mm(NULL);
 	enter_lazy_tlb(mm, current);
+	local_irq_enable();
 	task_unlock(current);
+	mmap_read_unlock(mm);
 	mm_update_next_owner(mm);
 	mmput(mm);
 	if (test_thread_flag(TIF_MEMDIE))
diff --git a/kernel/fork.c b/kernel/fork.c
index 32083db7a2a2..17dcd1817799 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -930,6 +930,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	account_kernel_stack(tsk, 1);
 
 	kcov_task_init(tsk);
+	kmap_local_fork(tsk);
 
 #ifdef CONFIG_FAULT_INJECTION
 	tsk->fail_nth = 0;
diff --git a/kernel/kthread.c b/kernel/kthread.c
index e29773c82b70..481428fe5f22 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1248,6 +1248,7 @@ void kthread_use_mm(struct mm_struct *mm)
 		tsk->active_mm = mm;
 	}
 	tsk->mm = mm;
+	membarrier_update_current_mm(mm);
 	switch_mm_irqs_off(active_mm, mm, tsk);
 	local_irq_enable();
 	task_unlock(tsk);
@@ -1255,8 +1256,19 @@ void kthread_use_mm(struct mm_struct *mm)
 	finish_arch_post_lock_switch();
 #endif
 
+	/*
+	 * When a kthread starts operating on an address space, the loop
+	 * in membarrier_{private,global}_expedited() may not observe
+	 * that tsk->mm, and not issue an IPI. Membarrier requires a
+	 * memory barrier after storing to tsk->mm, before accessing
+	 * user-space memory. A full memory barrier for membarrier
+	 * {PRIVATE,GLOBAL}_EXPEDITED is implicitly provided by
+	 * mmdrop(), or explicitly with smp_mb().
+	 */
 	if (active_mm != mm)
 		mmdrop(active_mm);
+	else
+		smp_mb();
 
 	to_kthread(tsk)->oldfs = force_uaccess_begin();
 }
@@ -1276,9 +1288,18 @@ void kthread_unuse_mm(struct mm_struct *mm)
 	force_uaccess_end(to_kthread(tsk)->oldfs);
 
 	task_lock(tsk);
+	/*
+	 * When a kthread stops operating on an address space, the loop
+	 * in membarrier_{private,global}_expedited() may not observe
+	 * that tsk->mm, and not issue an IPI. Membarrier requires a
+	 * memory barrier after accessing user-space memory, before
+	 * clearing tsk->mm.
+	 */
+	smp_mb__after_spinlock();
 	sync_mm_rss(mm);
 	local_irq_disable();
 	tsk->mm = NULL;
+	membarrier_update_current_mm(NULL);
 	/* active_mm is still 'mm' */
 	enter_lazy_tlb(mm, tsk);
 	local_irq_enable();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d2003a7d5ab5..953abdbe1472 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -97,7 +97,7 @@ int sysctl_sched_rt_runtime = 950000;
  *
  * Normal scheduling state is serialized by rq->lock. __schedule() takes the
  * local CPU's rq->lock, it optionally removes the task from the runqueue and
- * always looks at the local rq data structures to find the most elegible task
+ * always looks at the local rq data structures to find the most eligible task
  * to run next.
  *
  * Task enqueue is also under rq->lock, possibly taken from another CPU.
@@ -518,7 +518,7 @@ static bool __wake_q_add(struct wake_q_head *head, struct task_struct *task)
 
 	/*
 	 * Atomically grab the task, if ->wake_q is !nil already it means
-	 * its already queued (either by us or someone else) and will get the
+	 * it's already queued (either by us or someone else) and will get the
 	 * wakeup due to that.
 	 *
 	 * In order to ensure that a pending wakeup will observe our pending
@@ -769,7 +769,7 @@ bool sched_can_stop_tick(struct rq *rq)
 		return false;
 
 	/*
-	 * If there are more than one RR tasks, we need the tick to effect the
+	 * If there are more than one RR tasks, we need the tick to affect the
 	 * actual RR behaviour.
 	 */
 	if (rq->rt.rr_nr_running) {
@@ -1187,14 +1187,14 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	 * accounting was performed at enqueue time and we can just return
 	 * here.
 	 *
-	 * Need to be careful of the following enqeueue/dequeue ordering
+	 * Need to be careful of the following enqueue/dequeue ordering
 	 * problem too
 	 *
 	 *	enqueue(taskA)
 	 *	// sched_uclamp_used gets enabled
 	 *	enqueue(taskB)
 	 *	dequeue(taskA)
-	 *	// Must not decrement bukcet->tasks here
+	 *	// Must not decrement bucket->tasks here
 	 *	dequeue(taskB)
 	 *
 	 * where we could end up with stale data in uc_se and
@@ -1413,17 +1413,24 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 static int uclamp_validate(struct task_struct *p,
 			   const struct sched_attr *attr)
 {
-	unsigned int lower_bound = p->uclamp_req[UCLAMP_MIN].value;
-	unsigned int upper_bound = p->uclamp_req[UCLAMP_MAX].value;
+	int util_min = p->uclamp_req[UCLAMP_MIN].value;
+	int util_max = p->uclamp_req[UCLAMP_MAX].value;
 
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
-		lower_bound = attr->sched_util_min;
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
-		upper_bound = attr->sched_util_max;
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
+		util_min = attr->sched_util_min;
 
-	if (lower_bound > upper_bound)
-		return -EINVAL;
-	if (upper_bound > SCHED_CAPACITY_SCALE)
+		if (util_min + 1 > SCHED_CAPACITY_SCALE + 1)
+			return -EINVAL;
+	}
+
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
+		util_max = attr->sched_util_max;
+
+		if (util_max + 1 > SCHED_CAPACITY_SCALE + 1)
+			return -EINVAL;
+	}
+
+	if (util_min != -1 && util_max != -1 && util_min > util_max)
 		return -EINVAL;
 
 	/*
@@ -1438,20 +1445,41 @@ static int uclamp_validate(struct task_struct *p,
 	return 0;
 }
 
+static bool uclamp_reset(const struct sched_attr *attr,
+			 enum uclamp_id clamp_id,
+			 struct uclamp_se *uc_se)
+{
+	/* Reset on sched class change for a non user-defined clamp value. */
+	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)) &&
+	    !uc_se->user_defined)
+		return true;
+
+	/* Reset on sched_util_{min,max} == -1. */
+	if (clamp_id == UCLAMP_MIN &&
+	    attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN &&
+	    attr->sched_util_min == -1) {
+		return true;
+	}
+
+	if (clamp_id == UCLAMP_MAX &&
+	    attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX &&
+	    attr->sched_util_max == -1) {
+		return true;
+	}
+
+	return false;
+}
+
 static void __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr)
 {
 	enum uclamp_id clamp_id;
 
-	/*
-	 * On scheduling class change, reset to default clamps for tasks
-	 * without a task-specific value.
-	 */
 	for_each_clamp_id(clamp_id) {
 		struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
+		unsigned int value;
 
-		/* Keep using defined clamps across class changes */
-		if (uc_se->user_defined)
+		if (!uclamp_reset(attr, clamp_id, uc_se))
 			continue;
 
 		/*
@@ -1459,21 +1487,25 @@ static void __setscheduler_uclamp(struct task_struct *p,
 		 * at runtime.
 		 */
 		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
-			__uclamp_update_util_min_rt_default(p);
+			value = sysctl_sched_uclamp_util_min_rt_default;
 		else
-			uclamp_se_set(uc_se, uclamp_none(clamp_id), false);
+			value = uclamp_none(clamp_id);
+
+		uclamp_se_set(uc_se, value, false);
 
 	}
 
 	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
 		return;
 
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN &&
+	    attr->sched_util_min != -1) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
 			      attr->sched_util_min, true);
 	}
 
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX &&
+	    attr->sched_util_max != -1) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
 			      attr->sched_util_max, true);
 	}
@@ -1696,6 +1728,76 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 
 #ifdef CONFIG_SMP
 
+static void
+__do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32 flags);
+
+static int __set_cpus_allowed_ptr(struct task_struct *p,
+				  const struct cpumask *new_mask,
+				  u32 flags);
+
+static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
+{
+	if (likely(!p->migration_disabled))
+		return;
+
+	if (p->cpus_ptr != &p->cpus_mask)
+		return;
+
+	/*
+	 * Violates locking rules! see comment in __do_set_cpus_allowed().
+	 */
+	__do_set_cpus_allowed(p, cpumask_of(rq->cpu), SCA_MIGRATE_DISABLE);
+}
+
+void migrate_disable(void)
+{
+	struct task_struct *p = current;
+
+	if (p->migration_disabled) {
+		p->migration_disabled++;
+		return;
+	}
+
+	preempt_disable();
+	this_rq()->nr_pinned++;
+	p->migration_disabled = 1;
+	preempt_enable();
+}
+EXPORT_SYMBOL_GPL(migrate_disable);
+
+void migrate_enable(void)
+{
+	struct task_struct *p = current;
+
+	if (p->migration_disabled > 1) {
+		p->migration_disabled--;
+		return;
+	}
+
+	/*
+	 * Ensure stop_task runs either before or after this, and that
+	 * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
+	 */
+	preempt_disable();
+	if (p->cpus_ptr != &p->cpus_mask)
+		__set_cpus_allowed_ptr(p, &p->cpus_mask, SCA_MIGRATE_ENABLE);
+	/*
+	 * Mustn't clear migration_disabled() until cpus_ptr points back at the
+	 * regular cpus_mask, otherwise things that race (eg.
+	 * select_fallback_rq) get confused.
+	 */
+	barrier();
+	p->migration_disabled = 0;
+	this_rq()->nr_pinned--;
+	preempt_enable();
+}
+EXPORT_SYMBOL_GPL(migrate_enable);
+
+static inline bool rq_has_pinned_tasks(struct rq *rq)
+{
+	return rq->nr_pinned;
+}
+
 /*
  * Per-CPU kthreads are allowed to run on !active && online CPUs, see
  * __set_cpus_allowed_ptr() and select_fallback_rq().
@@ -1705,7 +1807,7 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 		return false;
 
-	if (is_per_cpu_kthread(p))
+	if (is_per_cpu_kthread(p) || is_migration_disabled(p))
 		return cpu_online(cpu);
 
 	return cpu_active(cpu);
@@ -1750,8 +1852,16 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 }
 
 struct migration_arg {
-	struct task_struct *task;
-	int dest_cpu;
+	struct task_struct		*task;
+	int				dest_cpu;
+	struct set_affinity_pending	*pending;
+};
+
+struct set_affinity_pending {
+	refcount_t		refs;
+	struct completion	done;
+	struct cpu_stop_work	stop_work;
+	struct migration_arg	arg;
 };
 
 /*
@@ -1783,16 +1893,19 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
  */
 static int migration_cpu_stop(void *data)
 {
+	struct set_affinity_pending *pending;
 	struct migration_arg *arg = data;
 	struct task_struct *p = arg->task;
+	int dest_cpu = arg->dest_cpu;
 	struct rq *rq = this_rq();
+	bool complete = false;
 	struct rq_flags rf;
 
 	/*
 	 * The original target CPU might have gone down and we might
 	 * be on another CPU but it doesn't matter.
 	 */
-	local_irq_disable();
+	local_irq_save(rf.flags);
 	/*
 	 * We need to explicitly wake pending tasks before running
 	 * __migrate_task() such that we will not miss enforcing cpus_ptr
@@ -1802,21 +1915,137 @@ static int migration_cpu_stop(void *data)
 
 	raw_spin_lock(&p->pi_lock);
 	rq_lock(rq, &rf);
+
+	pending = p->migration_pending;
 	/*
 	 * If task_rq(p) != rq, it cannot be migrated here, because we're
 	 * holding rq->lock, if p->on_rq == 0 it cannot get enqueued because
 	 * we're holding p->pi_lock.
 	 */
 	if (task_rq(p) == rq) {
+		if (is_migration_disabled(p))
+			goto out;
+
+		if (pending) {
+			p->migration_pending = NULL;
+			complete = true;
+		}
+
+		/* migrate_enable() --  we must not race against SCA */
+		if (dest_cpu < 0) {
+			/*
+			 * When this was migrate_enable() but we no longer
+			 * have a @pending, a concurrent SCA 'fixed' things
+			 * and we should be valid again. Nothing to do.
+			 */
+			if (!pending) {
+				WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), &p->cpus_mask));
+				goto out;
+			}
+
+			dest_cpu = cpumask_any_distribute(&p->cpus_mask);
+		}
+
 		if (task_on_rq_queued(p))
-			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
+			rq = __migrate_task(rq, &rf, p, dest_cpu);
 		else
-			p->wake_cpu = arg->dest_cpu;
+			p->wake_cpu = dest_cpu;
+
+	} else if (dest_cpu < 0 || pending) {
+		/*
+		 * This happens when we get migrated between migrate_enable()'s
+		 * preempt_enable() and scheduling the stopper task. At that
+		 * point we're a regular task again and not current anymore.
+		 *
+		 * A !PREEMPT kernel has a giant hole here, which makes it far
+		 * more likely.
+		 */
+
+		/*
+		 * The task moved before the stopper got to run. We're holding
+		 * ->pi_lock, so the allowed mask is stable - if it got
+		 * somewhere allowed, we're done.
+		 */
+		if (pending && cpumask_test_cpu(task_cpu(p), p->cpus_ptr)) {
+			p->migration_pending = NULL;
+			complete = true;
+			goto out;
+		}
+
+		/*
+		 * When this was migrate_enable() but we no longer have an
+		 * @pending, a concurrent SCA 'fixed' things and we should be
+		 * valid again. Nothing to do.
+		 */
+		if (!pending) {
+			WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), &p->cpus_mask));
+			goto out;
+		}
+
+		/*
+		 * When migrate_enable() hits a rq mis-match we can't reliably
+		 * determine is_migration_disabled() and so have to chase after
+		 * it.
+		 */
+		task_rq_unlock(rq, p, &rf);
+		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
+				    &pending->arg, &pending->stop_work);
+		return 0;
 	}
-	rq_unlock(rq, &rf);
-	raw_spin_unlock(&p->pi_lock);
+out:
+	task_rq_unlock(rq, p, &rf);
+
+	if (complete)
+		complete_all(&pending->done);
+
+	/* For pending->{arg,stop_work} */
+	pending = arg->pending;
+	if (pending && refcount_dec_and_test(&pending->refs))
+		wake_up_var(&pending->refs);
+
+	return 0;
+}
+
+int push_cpu_stop(void *arg)
+{
+	struct rq *lowest_rq = NULL, *rq = this_rq();
+	struct task_struct *p = arg;
+
+	raw_spin_lock_irq(&p->pi_lock);
+	raw_spin_lock(&rq->lock);
+
+	if (task_rq(p) != rq)
+		goto out_unlock;
+
+	if (is_migration_disabled(p)) {
+		p->migration_flags |= MDF_PUSH;
+		goto out_unlock;
+	}
+
+	p->migration_flags &= ~MDF_PUSH;
+
+	if (p->sched_class->find_lock_rq)
+		lowest_rq = p->sched_class->find_lock_rq(p, rq);
+
+	if (!lowest_rq)
+		goto out_unlock;
+
+	// XXX validate p is still the highest prio task
+	if (task_rq(p) == rq) {
+		deactivate_task(rq, p, 0);
+		set_task_cpu(p, lowest_rq->cpu);
+		activate_task(lowest_rq, p, 0);
+		resched_curr(lowest_rq);
+	}
+
+	double_unlock_balance(rq, lowest_rq);
+
+out_unlock:
+	rq->push_busy = false;
+	raw_spin_unlock(&rq->lock);
+	raw_spin_unlock_irq(&p->pi_lock);
 
-	local_irq_enable();
+	put_task_struct(p);
 	return 0;
 }
 
@@ -1824,18 +2053,39 @@ static int migration_cpu_stop(void *data)
  * sched_class::set_cpus_allowed must do the below, but is not required to
  * actually call this function.
  */
-void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask)
+void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags)
 {
+	if (flags & (SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) {
+		p->cpus_ptr = new_mask;
+		return;
+	}
+
 	cpumask_copy(&p->cpus_mask, new_mask);
 	p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
 
-void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
+static void
+__do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32 flags)
 {
 	struct rq *rq = task_rq(p);
 	bool queued, running;
 
-	lockdep_assert_held(&p->pi_lock);
+	/*
+	 * This here violates the locking rules for affinity, since we're only
+	 * supposed to change these variables while holding both rq->lock and
+	 * p->pi_lock.
+	 *
+	 * HOWEVER, it magically works, because ttwu() is the only code that
+	 * accesses these variables under p->pi_lock and only does so after
+	 * smp_cond_load_acquire(&p->on_cpu, !VAL), and we're in __schedule()
+	 * before finish_task().
+	 *
+	 * XXX do further audits, this smells like something putrid.
+	 */
+	if (flags & SCA_MIGRATE_DISABLE)
+		SCHED_WARN_ON(!p->on_cpu);
+	else
+		lockdep_assert_held(&p->pi_lock);
 
 	queued = task_on_rq_queued(p);
 	running = task_current(rq, p);
@@ -1851,7 +2101,7 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 	if (running)
 		put_prev_task(rq, p);
 
-	p->sched_class->set_cpus_allowed(p, new_mask);
+	p->sched_class->set_cpus_allowed(p, new_mask, flags);
 
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
@@ -1859,6 +2109,208 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 		set_next_task(rq, p);
 }
 
+void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
+{
+	__do_set_cpus_allowed(p, new_mask, 0);
+}
+
+/*
+ * This function is wildly self concurrent; here be dragons.
+ *
+ *
+ * When given a valid mask, __set_cpus_allowed_ptr() must block until the
+ * designated task is enqueued on an allowed CPU. If that task is currently
+ * running, we have to kick it out using the CPU stopper.
+ *
+ * Migrate-Disable comes along and tramples all over our nice sandcastle.
+ * Consider:
+ *
+ *     Initial conditions: P0->cpus_mask = [0, 1]
+ *
+ *     P0@CPU0                  P1
+ *
+ *     migrate_disable();
+ *     <preempted>
+ *                              set_cpus_allowed_ptr(P0, [1]);
+ *
+ * P1 *cannot* return from this set_cpus_allowed_ptr() call until P0 executes
+ * its outermost migrate_enable() (i.e. it exits its Migrate-Disable region).
+ * This means we need the following scheme:
+ *
+ *     P0@CPU0                  P1
+ *
+ *     migrate_disable();
+ *     <preempted>
+ *                              set_cpus_allowed_ptr(P0, [1]);
+ *                                <blocks>
+ *     <resumes>
+ *     migrate_enable();
+ *       __set_cpus_allowed_ptr();
+ *       <wakes local stopper>
+ *                         `--> <woken on migration completion>
+ *
+ * Now the fun stuff: there may be several P1-like tasks, i.e. multiple
+ * concurrent set_cpus_allowed_ptr(P0, [*]) calls. CPU affinity changes of any
+ * task p are serialized by p->pi_lock, which we can leverage: the one that
+ * should come into effect at the end of the Migrate-Disable region is the last
+ * one. This means we only need to track a single cpumask (i.e. p->cpus_mask),
+ * but we still need to properly signal those waiting tasks at the appropriate
+ * moment.
+ *
+ * This is implemented using struct set_affinity_pending. The first
+ * __set_cpus_allowed_ptr() caller within a given Migrate-Disable region will
+ * setup an instance of that struct and install it on the targeted task_struct.
+ * Any and all further callers will reuse that instance. Those then wait for
+ * a completion signaled at the tail of the CPU stopper callback (1), triggered
+ * on the end of the Migrate-Disable region (i.e. outermost migrate_enable()).
+ *
+ *
+ * (1) In the cases covered above. There is one more where the completion is
+ * signaled within affine_move_task() itself: when a subsequent affinity request
+ * cancels the need for an active migration. Consider:
+ *
+ *     Initial conditions: P0->cpus_mask = [0, 1]
+ *
+ *     P0@CPU0            P1                             P2
+ *
+ *     migrate_disable();
+ *     <preempted>
+ *                        set_cpus_allowed_ptr(P0, [1]);
+ *                          <blocks>
+ *                                                       set_cpus_allowed_ptr(P0, [0, 1]);
+ *                                                         <signal completion>
+ *                          <awakes>
+ *
+ * Note that the above is safe vs a concurrent migrate_enable(), as any
+ * pending affinity completion is preceded by an uninstallation of
+ * p->migration_pending done with p->pi_lock held.
+ */
+static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flags *rf,
+			    int dest_cpu, unsigned int flags)
+{
+	struct set_affinity_pending my_pending = { }, *pending = NULL;
+	struct migration_arg arg = {
+		.task = p,
+		.dest_cpu = dest_cpu,
+	};
+	bool complete = false;
+
+	/* Can the task run on the task's current CPU? If so, we're done */
+	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
+		struct task_struct *push_task = NULL;
+
+		if ((flags & SCA_MIGRATE_ENABLE) &&
+		    (p->migration_flags & MDF_PUSH) && !rq->push_busy) {
+			rq->push_busy = true;
+			push_task = get_task_struct(p);
+		}
+
+		pending = p->migration_pending;
+		if (pending) {
+			refcount_inc(&pending->refs);
+			p->migration_pending = NULL;
+			complete = true;
+		}
+		task_rq_unlock(rq, p, rf);
+
+		if (push_task) {
+			stop_one_cpu_nowait(rq->cpu, push_cpu_stop,
+					    p, &rq->push_work);
+		}
+
+		if (complete)
+			goto do_complete;
+
+		return 0;
+	}
+
+	if (!(flags & SCA_MIGRATE_ENABLE)) {
+		/* serialized by p->pi_lock */
+		if (!p->migration_pending) {
+			/* Install the request */
+			refcount_set(&my_pending.refs, 1);
+			init_completion(&my_pending.done);
+			p->migration_pending = &my_pending;
+		} else {
+			pending = p->migration_pending;
+			refcount_inc(&pending->refs);
+		}
+	}
+	pending = p->migration_pending;
+	/*
+	 * - !MIGRATE_ENABLE:
+	 *   we'll have installed a pending if there wasn't one already.
+	 *
+	 * - MIGRATE_ENABLE:
+	 *   we're here because the current CPU isn't matching anymore,
+	 *   the only way that can happen is because of a concurrent
+	 *   set_cpus_allowed_ptr() call, which should then still be
+	 *   pending completion.
+	 *
+	 * Either way, we really should have a @pending here.
+	 */
+	if (WARN_ON_ONCE(!pending)) {
+		task_rq_unlock(rq, p, rf);
+		return -EINVAL;
+	}
+
+	if (flags & SCA_MIGRATE_ENABLE) {
+
+		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
+		p->migration_flags &= ~MDF_PUSH;
+		task_rq_unlock(rq, p, rf);
+
+		pending->arg = (struct migration_arg) {
+			.task = p,
+			.dest_cpu = -1,
+			.pending = pending,
+		};
+
+		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
+				    &pending->arg, &pending->stop_work);
+
+		return 0;
+	}
+
+	if (task_running(rq, p) || p->state == TASK_WAKING) {
+		/*
+		 * Lessen races (and headaches) by delegating
+		 * is_migration_disabled(p) checks to the stopper, which will
+		 * run on the same CPU as said p.
+		 */
+		task_rq_unlock(rq, p, rf);
+		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
+
+	} else {
+
+		if (!is_migration_disabled(p)) {
+			if (task_on_rq_queued(p))
+				rq = move_queued_task(rq, rf, p, dest_cpu);
+
+			p->migration_pending = NULL;
+			complete = true;
+		}
+		task_rq_unlock(rq, p, rf);
+
+do_complete:
+		if (complete)
+			complete_all(&pending->done);
+	}
+
+	wait_for_completion(&pending->done);
+
+	if (refcount_dec_and_test(&pending->refs))
+		wake_up_var(&pending->refs);
+
+	/*
+	 * Block the original owner of &pending until all subsequent callers
+	 * have seen the completion and decremented the refcount
+	 */
+	wait_var_event(&my_pending.refs, !refcount_read(&my_pending.refs));
+
+	return 0;
+}
+
 /*
  * Change a given task's CPU affinity. Migrate the thread to a
  * proper CPU and schedule it away if the CPU it's executing on
@@ -1869,7 +2321,8 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
  * call is not atomic; no spinlocks may be held.
  */
 static int __set_cpus_allowed_ptr(struct task_struct *p,
-				  const struct cpumask *new_mask, bool check)
+				  const struct cpumask *new_mask,
+				  u32 flags)
 {
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
 	unsigned int dest_cpu;
@@ -1880,9 +2333,14 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	rq = task_rq_lock(p, &rf);
 	update_rq_clock(rq);
 
-	if (p->flags & PF_KTHREAD) {
+	if (p->flags & PF_KTHREAD || is_migration_disabled(p)) {
 		/*
-		 * Kernel threads are allowed on online && !active CPUs
+		 * Kernel threads are allowed on online && !active CPUs.
+		 *
+		 * Specifically, migration_disabled() tasks must not fail the
+		 * cpumask_any_and_distribute() pick below, esp. so on
+		 * SCA_MIGRATE_ENABLE, otherwise we'll not call
+		 * set_cpus_allowed_common() and actually reset p->cpus_ptr.
 		 */
 		cpu_valid_mask = cpu_online_mask;
 	}
@@ -1891,13 +2349,22 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	 * Must re-check here, to close a race against __kthread_bind(),
 	 * sched_setaffinity() is not guaranteed to observe the flag.
 	 */
-	if (check && (p->flags & PF_NO_SETAFFINITY)) {
+	if ((flags & SCA_CHECK) && (p->flags & PF_NO_SETAFFINITY)) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	if (cpumask_equal(&p->cpus_mask, new_mask))
-		goto out;
+	if (!(flags & SCA_MIGRATE_ENABLE)) {
+		if (cpumask_equal(&p->cpus_mask, new_mask))
+			goto out;
+
+		if (WARN_ON_ONCE(p == current &&
+				 is_migration_disabled(p) &&
+				 !cpumask_test_cpu(task_cpu(p), new_mask))) {
+			ret = -EBUSY;
+			goto out;
+		}
+	}
 
 	/*
 	 * Picking a ~random cpu helps in cases where we are changing affinity
@@ -1910,7 +2377,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		goto out;
 	}
 
-	do_set_cpus_allowed(p, new_mask);
+	__do_set_cpus_allowed(p, new_mask, flags);
 
 	if (p->flags & PF_KTHREAD) {
 		/*
@@ -1922,23 +2389,8 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 			p->nr_cpus_allowed != 1);
 	}
 
-	/* Can the task run on the task's current CPU? If so, we're done */
-	if (cpumask_test_cpu(task_cpu(p), new_mask))
-		goto out;
+	return affine_move_task(rq, p, &rf, dest_cpu, flags);
 
-	if (task_running(rq, p) || p->state == TASK_WAKING) {
-		struct migration_arg arg = { p, dest_cpu };
-		/* Need help from migration thread: drop lock and wait. */
-		task_rq_unlock(rq, p, &rf);
-		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
-		return 0;
-	} else if (task_on_rq_queued(p)) {
-		/*
-		 * OK, since we're going to drop the lock immediately
-		 * afterwards anyway.
-		 */
-		rq = move_queued_task(rq, &rf, p, dest_cpu);
-	}
 out:
 	task_rq_unlock(rq, p, &rf);
 
@@ -1947,7 +2399,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 
 int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
 {
-	return __set_cpus_allowed_ptr(p, new_mask, false);
+	return __set_cpus_allowed_ptr(p, new_mask, 0);
 }
 EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
 
@@ -1988,6 +2440,8 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 	 * Clearly, migrating tasks to offline CPUs is a fairly daft thing.
 	 */
 	WARN_ON_ONCE(!cpu_online(new_cpu));
+
+	WARN_ON_ONCE(is_migration_disabled(p));
 #endif
 
 	trace_sched_migrate_task(p, new_cpu);
@@ -2318,6 +2772,12 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 			}
 			fallthrough;
 		case possible:
+			/*
+			 * XXX When called from select_task_rq() we only
+			 * hold p->pi_lock and again violate locking order.
+			 *
+			 * More yuck to audit.
+			 */
 			do_set_cpus_allowed(p, cpu_possible_mask);
 			state = fail;
 			break;
@@ -2348,12 +2808,12 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
  * The caller (fork, wakeup) owns p->pi_lock, ->cpus_ptr is stable.
  */
 static inline
-int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
+int select_task_rq(struct task_struct *p, int cpu, int wake_flags)
 {
 	lockdep_assert_held(&p->pi_lock);
 
-	if (p->nr_cpus_allowed > 1)
-		cpu = p->sched_class->select_task_rq(p, cpu, sd_flags, wake_flags);
+	if (p->nr_cpus_allowed > 1 && !is_migration_disabled(p))
+		cpu = p->sched_class->select_task_rq(p, cpu, wake_flags);
 	else
 		cpu = cpumask_any(p->cpus_ptr);
 
@@ -2375,6 +2835,7 @@ int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
 
 void sched_set_stop_task(int cpu, struct task_struct *stop)
 {
+	static struct lock_class_key stop_pi_lock;
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
 	struct task_struct *old_stop = cpu_rq(cpu)->stop;
 
@@ -2390,6 +2851,20 @@ void sched_set_stop_task(int cpu, struct task_struct *stop)
 		sched_setscheduler_nocheck(stop, SCHED_FIFO, &param);
 
 		stop->sched_class = &stop_sched_class;
+
+		/*
+		 * The PI code calls rt_mutex_setprio() with ->pi_lock held to
+		 * adjust the effective priority of a task. As a result,
+		 * rt_mutex_setprio() can trigger (RT) balancing operations,
+		 * which can then trigger wakeups of the stop thread to push
+		 * around the current task.
+		 *
+		 * The stop task itself will never be part of the PI-chain, it
+		 * never blocks, therefore that ->pi_lock recursion is safe.
+		 * Tell lockdep about this by placing the stop->pi_lock in its
+		 * own class.
+		 */
+		lockdep_set_class(&stop->pi_lock, &stop_pi_lock);
 	}
 
 	cpu_rq(cpu)->stop = stop;
@@ -2403,15 +2878,23 @@ void sched_set_stop_task(int cpu, struct task_struct *stop)
 	}
 }
 
-#else
+#else /* CONFIG_SMP */
 
 static inline int __set_cpus_allowed_ptr(struct task_struct *p,
-					 const struct cpumask *new_mask, bool check)
+					 const struct cpumask *new_mask,
+					 u32 flags)
 {
 	return set_cpus_allowed_ptr(p, new_mask);
 }
 
-#endif /* CONFIG_SMP */
+static inline void migrate_disable_switch(struct rq *rq, struct task_struct *p) { }
+
+static inline bool rq_has_pinned_tasks(struct rq *rq)
+{
+	return false;
+}
+
+#endif /* !CONFIG_SMP */
 
 static void
 ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
@@ -2465,7 +2948,7 @@ static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken) {
 		/*
-		 * Our task @p is fully woken up and running; so its safe to
+		 * Our task @p is fully woken up and running; so it's safe to
 		 * drop the rq->lock, hereafter rq is only used for statistics.
 		 */
 		rq_unpin_lock(rq, rf);
@@ -2952,7 +3435,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 
 	/*
 	 * If the owning (remote) CPU is still in the middle of schedule() with
-	 * this task as prev, wait until its done referencing the task.
+	 * this task as prev, wait until it's done referencing the task.
 	 *
 	 * Pairs with the smp_store_release() in finish_task().
 	 *
@@ -2961,7 +3444,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 */
 	smp_cond_load_acquire(&p->on_cpu, !VAL);
 
-	cpu = select_task_rq(p, p->wake_cpu, SD_BALANCE_WAKE, wake_flags);
+	cpu = select_task_rq(p, p->wake_cpu, wake_flags | WF_TTWU);
 	if (task_cpu(p) != cpu) {
 		wake_flags |= WF_MIGRATED;
 		psi_ttwu_dequeue(p);
@@ -3098,6 +3581,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	init_numa_balancing(clone_flags, p);
 #ifdef CONFIG_SMP
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
+	p->migration_pending = NULL;
 #endif
 }
 
@@ -3344,7 +3828,7 @@ void wake_up_new_task(struct task_struct *p)
 	 */
 	p->recent_used_cpu = task_cpu(p);
 	rseq_migrate(p);
-	__set_task_cpu(p, select_task_rq(p, task_cpu(p), SD_BALANCE_FORK, 0));
+	__set_task_cpu(p, select_task_rq(p, task_cpu(p), WF_FORK));
 #endif
 	rq = __task_rq_lock(p, &rf);
 	update_rq_clock(rq);
@@ -3356,7 +3840,7 @@ void wake_up_new_task(struct task_struct *p)
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken) {
 		/*
-		 * Nothing relies on rq->lock after this, so its fine to
+		 * Nothing relies on rq->lock after this, so it's fine to
 		 * drop it.
 		 */
 		rq_unpin_lock(rq, &rf);
@@ -3485,6 +3969,90 @@ static inline void finish_task(struct task_struct *prev)
 #endif
 }
 
+#ifdef CONFIG_SMP
+
+static void do_balance_callbacks(struct rq *rq, struct callback_head *head)
+{
+	void (*func)(struct rq *rq);
+	struct callback_head *next;
+
+	lockdep_assert_held(&rq->lock);
+
+	while (head) {
+		func = (void (*)(struct rq *))head->func;
+		next = head->next;
+		head->next = NULL;
+		head = next;
+
+		func(rq);
+	}
+}
+
+static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
+{
+	struct callback_head *head = rq->balance_callback;
+
+	lockdep_assert_held(&rq->lock);
+	if (head) {
+		rq->balance_callback = NULL;
+		rq->balance_flags &= ~BALANCE_WORK;
+	}
+
+	return head;
+}
+
+static void __balance_callbacks(struct rq *rq)
+{
+	do_balance_callbacks(rq, splice_balance_callbacks(rq));
+}
+
+static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
+{
+	unsigned long flags;
+
+	if (unlikely(head)) {
+		raw_spin_lock_irqsave(&rq->lock, flags);
+		do_balance_callbacks(rq, head);
+		raw_spin_unlock_irqrestore(&rq->lock, flags);
+	}
+}
+
+static void balance_push(struct rq *rq);
+
+static inline void balance_switch(struct rq *rq)
+{
+	if (likely(!rq->balance_flags))
+		return;
+
+	if (rq->balance_flags & BALANCE_PUSH) {
+		balance_push(rq);
+		return;
+	}
+
+	__balance_callbacks(rq);
+}
+
+#else
+
+static inline void __balance_callbacks(struct rq *rq)
+{
+}
+
+static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
+{
+	return NULL;
+}
+
+static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
+{
+}
+
+static inline void balance_switch(struct rq *rq)
+{
+}
+
+#endif
+
 static inline void
 prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 {
@@ -3510,6 +4078,7 @@ static inline void finish_lock_switch(struct rq *rq)
 	 * prev into current:
 	 */
 	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
+	balance_switch(rq);
 	raw_spin_unlock_irq(&rq->lock);
 }
 
@@ -3525,6 +4094,22 @@ static inline void finish_lock_switch(struct rq *rq)
 # define finish_arch_post_lock_switch()	do { } while (0)
 #endif
 
+static inline void kmap_local_sched_out(void)
+{
+#ifdef CONFIG_KMAP_LOCAL
+	if (unlikely(current->kmap_ctrl.idx))
+		__kmap_local_sched_out();
+#endif
+}
+
+static inline void kmap_local_sched_in(void)
+{
+#ifdef CONFIG_KMAP_LOCAL
+	if (unlikely(current->kmap_ctrl.idx))
+		__kmap_local_sched_in();
+#endif
+}
+
 /**
  * prepare_task_switch - prepare to switch tasks
  * @rq: the runqueue preparing to switch
@@ -3547,6 +4132,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
 	perf_event_task_sched_out(prev, next);
 	rseq_preempt(prev);
 	fire_sched_out_preempt_notifiers(prev, next);
+	kmap_local_sched_out();
 	prepare_task(next);
 	prepare_arch_switch(next);
 }
@@ -3613,6 +4199,14 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	finish_lock_switch(rq);
 	finish_arch_post_lock_switch();
 	kcov_finish_switch(current);
+	/*
+	 * kmap_local_sched_out() is invoked with rq::lock held and
+	 * interrupts disabled. There is no requirement for that, but the
+	 * sched out code does not have an interrupt enabled section.
+	 * Restoring the maps on sched in does not require interrupts being
+	 * disabled either.
+	 */
+	kmap_local_sched_in();
 
 	fire_sched_in_preempt_notifiers(current);
 	/*
@@ -3651,43 +4245,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	return rq;
 }
 
-#ifdef CONFIG_SMP
-
-/* rq->lock is NOT held, but preemption is disabled */
-static void __balance_callback(struct rq *rq)
-{
-	struct callback_head *head, *next;
-	void (*func)(struct rq *rq);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&rq->lock, flags);
-	head = rq->balance_callback;
-	rq->balance_callback = NULL;
-	while (head) {
-		func = (void (*)(struct rq *))head->func;
-		next = head->next;
-		head->next = NULL;
-		head = next;
-
-		func(rq);
-	}
-	raw_spin_unlock_irqrestore(&rq->lock, flags);
-}
-
-static inline void balance_callback(struct rq *rq)
-{
-	if (unlikely(rq->balance_callback))
-		__balance_callback(rq);
-}
-
-#else
-
-static inline void balance_callback(struct rq *rq)
-{
-}
-
-#endif
-
 /**
  * schedule_tail - first thing a freshly forked thread must call.
  * @prev: the thread we just switched away from.
@@ -3707,7 +4264,6 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	 */
 
 	rq = finish_task_switch(prev);
-	balance_callback(rq);
 	preempt_enable();
 
 	if (current->set_child_tid)
@@ -3836,7 +4392,7 @@ unsigned long nr_iowait_cpu(int cpu)
 }
 
 /*
- * IO-wait accounting, and how its mostly bollocks (on SMP).
+ * IO-wait accounting, and how it's mostly bollocks (on SMP).
  *
  * The idea behind IO-wait account is to account the idle time that we could
  * have spend running if it were not for IO. That is, if we were to improve the
@@ -3888,7 +4444,7 @@ void sched_exec(void)
 	int dest_cpu;
 
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
-	dest_cpu = p->sched_class->select_task_rq(p, task_cpu(p), SD_BALANCE_EXEC, 0);
+	dest_cpu = p->sched_class->select_task_rq(p, task_cpu(p), WF_EXEC);
 	if (dest_cpu == smp_processor_id())
 		goto unlock;
 
@@ -4331,7 +4887,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	/*
 	 * Optimization: we know that if all tasks are in the fair class we can
 	 * call that function directly, but only if the @prev task wasn't of a
-	 * higher scheduling class, because otherwise those loose the
+	 * higher scheduling class, because otherwise those lose the
 	 * opportunity to pull in more work from other CPUs.
 	 */
 	if (likely(prev->sched_class <= &fair_sched_class &&
@@ -4515,6 +5071,7 @@ static void __sched notrace __schedule(bool preempt)
 		 */
 		++*switch_count;
 
+		migrate_disable_switch(rq, prev);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
 		trace_sched_switch(preempt, prev, next);
@@ -4523,10 +5080,11 @@ static void __sched notrace __schedule(bool preempt)
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
 		rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
-		rq_unlock_irq(rq, &rf);
-	}
 
-	balance_callback(rq);
+		rq_unpin_lock(rq, &rf);
+		__balance_callbacks(rq);
+		raw_spin_unlock_irq(&rq->lock);
+	}
 }
 
 void __noreturn do_task_dead(void)
@@ -4852,7 +5410,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	 * right. rt_mutex_slowunlock()+rt_mutex_postunlock() work together to
 	 * ensure a task is de-boosted (pi_task is set to NULL) before the
 	 * task is allowed to run again (and can exit). This ensures the pointer
-	 * points to a blocked task -- which guaratees the task is present.
+	 * points to a blocked task -- which guarantees the task is present.
 	 */
 	p->pi_top_task = pi_task;
 
@@ -4937,9 +5495,11 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 out_unlock:
 	/* Avoid rq from going away on us: */
 	preempt_disable();
-	__task_rq_unlock(rq, &rf);
 
-	balance_callback(rq);
+	rq_unpin_lock(rq, &rf);
+	__balance_callbacks(rq);
+	raw_spin_unlock(&rq->lock);
+
 	preempt_enable();
 }
 #else
@@ -4968,7 +5528,7 @@ void set_user_nice(struct task_struct *p, long nice)
 	/*
 	 * The RT priorities are set via sched_setscheduler(), but we still
 	 * allow the 'normal' nice value to be set - but as expected
-	 * it wont have any effect on scheduling until the task is
+	 * it won't have any effect on scheduling until the task is
 	 * SCHED_DEADLINE, SCHED_FIFO or SCHED_RR:
 	 */
 	if (task_has_dl_policy(p) || task_has_rt_policy(p)) {
@@ -5213,6 +5773,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	int retval, oldprio, oldpolicy = -1, queued, running;
 	int new_effective_prio, policy = attr->sched_policy;
 	const struct sched_class *prev_class;
+	struct callback_head *head;
 	struct rq_flags rf;
 	int reset_on_fork;
 	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
@@ -5451,6 +6012,7 @@ static int __sched_setscheduler(struct task_struct *p,
 
 	/* Avoid rq from going away on us: */
 	preempt_disable();
+	head = splice_balance_callbacks(rq);
 	task_rq_unlock(rq, p, &rf);
 
 	if (pi) {
@@ -5459,7 +6021,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	}
 
 	/* Run balance callbacks after we've adjusted the PI chain: */
-	balance_callback(rq);
+	balance_callbacks(rq, head);
 	preempt_enable();
 
 	return 0;
@@ -5954,7 +6516,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	}
 #endif
 again:
-	retval = __set_cpus_allowed_ptr(p, new_mask, true);
+	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
 
 	if (!retval) {
 		cpuset_cpus_allowed(p, cpus_allowed);
@@ -6094,12 +6656,8 @@ static void do_sched_yield(void)
 	schedstat_inc(rq->yld_count);
 	current->sched_class->yield_task(rq);
 
-	/*
-	 * Since we are going to call schedule() anyway, there's
-	 * no need to preempt or enable interrupts:
-	 */
 	preempt_disable();
-	rq_unlock(rq, &rf);
+	rq_unlock_irq(rq, &rf);
 	sched_preempt_enable_no_resched();
 
 	schedule();
@@ -6159,7 +6717,7 @@ EXPORT_SYMBOL(__cond_resched_lock);
  *
  * The scheduler is at all times free to pick the calling task as the most
  * eligible task to run, if removing the yield() call from your code breaks
- * it, its already broken.
+ * it, it's already broken.
  *
  * Typical broken usage is:
  *
@@ -6447,6 +7005,7 @@ void sched_show_task(struct task_struct *p)
 		(unsigned long)task_thread_info(p)->flags);
 
 	print_worker_info(KERN_INFO, p);
+	print_stop_info(KERN_INFO, p);
 	show_stack(p, NULL, KERN_INFO);
 	put_task_stack(p);
 }
@@ -6532,12 +7091,12 @@ void init_idle(struct task_struct *idle, int cpu)
 
 #ifdef CONFIG_SMP
 	/*
-	 * Its possible that init_idle() gets called multiple times on a task,
+	 * It's possible that init_idle() gets called multiple times on a task,
 	 * in that case do_set_cpus_allowed() will not do the right thing.
 	 *
 	 * And since this is boot we can forgo the serialization.
 	 */
-	set_cpus_allowed_common(idle, cpumask_of(cpu));
+	set_cpus_allowed_common(idle, cpumask_of(cpu), 0);
 #endif
 	/*
 	 * We're having a chicken and egg problem, even though we are
@@ -6688,119 +7247,126 @@ void idle_task_exit(void)
 	/* finish_cpu(), as ran on the BP, will clean up the active_mm state */
 }
 
-/*
- * Since this CPU is going 'away' for a while, fold any nr_active delta
- * we might have. Assumes we're called after migrate_tasks() so that the
- * nr_active count is stable. We need to take the teardown thread which
- * is calling this into account, so we hand in adjust = 1 to the load
- * calculation.
- *
- * Also see the comment "Global load-average calculations".
- */
-static void calc_load_migrate(struct rq *rq)
+static int __balance_push_cpu_stop(void *arg)
 {
-	long delta = calc_load_fold_active(rq, 1);
-	if (delta)
-		atomic_long_add(delta, &calc_load_tasks);
-}
+	struct task_struct *p = arg;
+	struct rq *rq = this_rq();
+	struct rq_flags rf;
+	int cpu;
 
-static struct task_struct *__pick_migrate_task(struct rq *rq)
-{
-	const struct sched_class *class;
-	struct task_struct *next;
+	raw_spin_lock_irq(&p->pi_lock);
+	rq_lock(rq, &rf);
 
-	for_each_class(class) {
-		next = class->pick_next_task(rq);
-		if (next) {
-			next->sched_class->put_prev_task(rq, next);
-			return next;
-		}
+	update_rq_clock(rq);
+
+	if (task_rq(p) == rq && task_on_rq_queued(p)) {
+		cpu = select_fallback_rq(rq->cpu, p);
+		rq = __migrate_task(rq, &rf, p, cpu);
 	}
 
-	/* The idle class should always have a runnable task */
-	BUG();
+	rq_unlock(rq, &rf);
+	raw_spin_unlock_irq(&p->pi_lock);
+
+	put_task_struct(p);
+
+	return 0;
 }
 
+static DEFINE_PER_CPU(struct cpu_stop_work, push_work);
+
 /*
- * Migrate all tasks from the rq, sleeping tasks will be migrated by
- * try_to_wake_up()->select_task_rq().
- *
- * Called with rq->lock held even though we'er in stop_machine() and
- * there's no concurrency possible, we hold the required locks anyway
- * because of lock validation efforts.
+ * Ensure we only run per-cpu kthreads once the CPU goes !active.
  */
-static void migrate_tasks(struct rq *dead_rq, struct rq_flags *rf)
+static void balance_push(struct rq *rq)
 {
-	struct rq *rq = dead_rq;
-	struct task_struct *next, *stop = rq->stop;
-	struct rq_flags orf = *rf;
-	int dest_cpu;
+	struct task_struct *push_task = rq->curr;
+
+	lockdep_assert_held(&rq->lock);
+	SCHED_WARN_ON(rq->cpu != smp_processor_id());
 
 	/*
-	 * Fudge the rq selection such that the below task selection loop
-	 * doesn't get stuck on the currently eligible stop task.
-	 *
-	 * We're currently inside stop_machine() and the rq is either stuck
-	 * in the stop_machine_cpu_stop() loop, or we're executing this code,
-	 * either way we should never end up calling schedule() until we're
-	 * done here.
+	 * Both the cpu-hotplug and stop task are in this case and are
+	 * required to complete the hotplug process.
 	 */
-	rq->stop = NULL;
+	if (is_per_cpu_kthread(push_task) || is_migration_disabled(push_task)) {
+		/*
+		 * If this is the idle task on the outgoing CPU try to wake
+		 * up the hotplug control thread which might wait for the
+		 * last task to vanish. The rcuwait_active() check is
+		 * accurate here because the waiter is pinned on this CPU
+		 * and can't obviously be running in parallel.
+		 *
+		 * On RT kernels this also has to check whether there are
+		 * pinned and scheduled out tasks on the runqueue. They
+		 * need to leave the migrate disabled section first.
+		 */
+		if (!rq->nr_running && !rq_has_pinned_tasks(rq) &&
+		    rcuwait_active(&rq->hotplug_wait)) {
+			raw_spin_unlock(&rq->lock);
+			rcuwait_wake_up(&rq->hotplug_wait);
+			raw_spin_lock(&rq->lock);
+		}
+		return;
+	}
 
+	get_task_struct(push_task);
 	/*
-	 * put_prev_task() and pick_next_task() sched
-	 * class method both need to have an up-to-date
-	 * value of rq->clock[_task]
+	 * Temporarily drop rq->lock such that we can wake-up the stop task.
+	 * Both preemption and IRQs are still disabled.
 	 */
-	update_rq_clock(rq);
+	raw_spin_unlock(&rq->lock);
+	stop_one_cpu_nowait(rq->cpu, __balance_push_cpu_stop, push_task,
+			    this_cpu_ptr(&push_work));
+	/*
+	 * At this point need_resched() is true and we'll take the loop in
+	 * schedule(). The next pick is obviously going to be the stop task
+	 * which is_per_cpu_kthread() and will push this task away.
+	 */
+	raw_spin_lock(&rq->lock);
+}
 
-	for (;;) {
-		/*
-		 * There's this thread running, bail when that's the only
-		 * remaining thread:
-		 */
-		if (rq->nr_running == 1)
-			break;
+static void balance_push_set(int cpu, bool on)
+{
+	struct rq *rq = cpu_rq(cpu);
+	struct rq_flags rf;
 
-		next = __pick_migrate_task(rq);
+	rq_lock_irqsave(rq, &rf);
+	if (on)
+		rq->balance_flags |= BALANCE_PUSH;
+	else
+		rq->balance_flags &= ~BALANCE_PUSH;
+	rq_unlock_irqrestore(rq, &rf);
+}
 
-		/*
-		 * Rules for changing task_struct::cpus_mask are holding
-		 * both pi_lock and rq->lock, such that holding either
-		 * stabilizes the mask.
-		 *
-		 * Drop rq->lock is not quite as disastrous as it usually is
-		 * because !cpu_active at this point, which means load-balance
-		 * will not interfere. Also, stop-machine.
-		 */
-		rq_unlock(rq, rf);
-		raw_spin_lock(&next->pi_lock);
-		rq_relock(rq, rf);
+/*
+ * Invoked from a CPUs hotplug control thread after the CPU has been marked
+ * inactive. All tasks which are not per CPU kernel threads are either
+ * pushed off this CPU now via balance_push() or placed on a different CPU
+ * during wakeup. Wait until the CPU is quiescent.
+ */
+static void balance_hotplug_wait(void)
+{
+	struct rq *rq = this_rq();
 
-		/*
-		 * Since we're inside stop-machine, _nothing_ should have
-		 * changed the task, WARN if weird stuff happened, because in
-		 * that case the above rq->lock drop is a fail too.
-		 */
-		if (WARN_ON(task_rq(next) != rq || !task_on_rq_queued(next))) {
-			raw_spin_unlock(&next->pi_lock);
-			continue;
-		}
+	rcuwait_wait_event(&rq->hotplug_wait,
+			   rq->nr_running == 1 && !rq_has_pinned_tasks(rq),
+			   TASK_UNINTERRUPTIBLE);
+}
 
-		/* Find suitable destination for @next, with force if needed. */
-		dest_cpu = select_fallback_rq(dead_rq->cpu, next);
-		rq = __migrate_task(rq, rf, next, dest_cpu);
-		if (rq != dead_rq) {
-			rq_unlock(rq, rf);
-			rq = dead_rq;
-			*rf = orf;
-			rq_relock(rq, rf);
-		}
-		raw_spin_unlock(&next->pi_lock);
-	}
+#else
 
-	rq->stop = stop;
+static inline void balance_push(struct rq *rq)
+{
 }
+
+static inline void balance_push_set(int cpu, bool on)
+{
+}
+
+static inline void balance_hotplug_wait(void)
+{
+}
+
 #endif /* CONFIG_HOTPLUG_CPU */
 
 void set_rq_online(struct rq *rq)
@@ -6886,6 +7452,8 @@ int sched_cpu_activate(unsigned int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	struct rq_flags rf;
 
+	balance_push_set(cpu, false);
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going up, increment the number of cores with SMT present.
@@ -6921,6 +7489,8 @@ int sched_cpu_activate(unsigned int cpu)
 
 int sched_cpu_deactivate(unsigned int cpu)
 {
+	struct rq *rq = cpu_rq(cpu);
+	struct rq_flags rf;
 	int ret;
 
 	set_cpu_active(cpu, false);
@@ -6933,6 +7503,16 @@ int sched_cpu_deactivate(unsigned int cpu)
 	 */
 	synchronize_rcu();
 
+	balance_push_set(cpu, true);
+
+	rq_lock_irqsave(rq, &rf);
+	if (rq->rd) {
+		update_rq_clock(rq);
+		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
+		set_rq_offline(rq);
+	}
+	rq_unlock_irqrestore(rq, &rf);
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going down, decrement the number of cores with SMT present.
@@ -6946,6 +7526,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 
 	ret = cpuset_cpu_inactive(cpu);
 	if (ret) {
+		balance_push_set(cpu, false);
 		set_cpu_active(cpu, true);
 		return ret;
 	}
@@ -6969,6 +7550,41 @@ int sched_cpu_starting(unsigned int cpu)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
+
+/*
+ * Invoked immediately before the stopper thread is invoked to bring the
+ * CPU down completely. At this point all per CPU kthreads except the
+ * hotplug thread (current) and the stopper thread (inactive) have been
+ * either parked or have been unbound from the outgoing CPU. Ensure that
+ * any of those which might be on the way out are gone.
+ *
+ * If after this point a bound task is being woken on this CPU then the
+ * responsible hotplug callback has failed to do it's job.
+ * sched_cpu_dying() will catch it with the appropriate fireworks.
+ */
+int sched_cpu_wait_empty(unsigned int cpu)
+{
+	balance_hotplug_wait();
+	return 0;
+}
+
+/*
+ * Since this CPU is going 'away' for a while, fold any nr_active delta we
+ * might have. Called from the CPU stopper task after ensuring that the
+ * stopper is the last running task on the CPU, so nr_active count is
+ * stable. We need to take the teardown thread which is calling this into
+ * account, so we hand in adjust = 1 to the load calculation.
+ *
+ * Also see the comment "Global load-average calculations".
+ */
+static void calc_load_migrate(struct rq *rq)
+{
+	long delta = calc_load_fold_active(rq, 1);
+
+	if (delta)
+		atomic_long_add(delta, &calc_load_tasks);
+}
+
 int sched_cpu_dying(unsigned int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -6978,12 +7594,7 @@ int sched_cpu_dying(unsigned int cpu)
 	sched_tick_stop(cpu);
 
 	rq_lock_irqsave(rq, &rf);
-	if (rq->rd) {
-		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
-		set_rq_offline(rq);
-	}
-	migrate_tasks(rq, &rf);
-	BUG_ON(rq->nr_running != 1);
+	BUG_ON(rq->nr_running != 1 || rq_has_pinned_tasks(rq));
 	rq_unlock_irqrestore(rq, &rf);
 
 	calc_load_migrate(rq);
@@ -7190,6 +7801,9 @@ void __init sched_init(void)
 
 		rq_csd_init(rq, &rq->nohz_csd, nohz_csd_func);
 #endif
+#ifdef CONFIG_HOTPLUG_CPU
+		rcuwait_init(&rq->hotplug_wait);
+#endif
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
@@ -7327,6 +7941,39 @@ void __cant_sleep(const char *file, int line, int preempt_offset)
 	add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
 }
 EXPORT_SYMBOL_GPL(__cant_sleep);
+
+#ifdef CONFIG_SMP
+void __cant_migrate(const char *file, int line)
+{
+	static unsigned long prev_jiffy;
+
+	if (irqs_disabled())
+		return;
+
+	if (is_migration_disabled(current))
+		return;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
+		return;
+
+	if (preempt_count() > 0)
+		return;
+
+	if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
+		return;
+	prev_jiffy = jiffies;
+
+	pr_err("BUG: assuming non migratable context at %s:%d\n", file, line);
+	pr_err("in_atomic(): %d, irqs_disabled(): %d, migration_disabled() %u pid: %d, name: %s\n",
+	       in_atomic(), irqs_disabled(), is_migration_disabled(current),
+	       current->pid, current->comm);
+
+	debug_show_held_locks(current);
+	dump_stack();
+	add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
+}
+EXPORT_SYMBOL_GPL(__cant_migrate);
+#endif
 #endif
 
 #ifdef CONFIG_MAGIC_SYSRQ
@@ -7660,7 +8307,7 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 			return -EINVAL;
 #endif
 		/*
-		 * Serialize against wake_up_new_task() such that if its
+		 * Serialize against wake_up_new_task() such that if it's
 		 * running, we're sure to observe its full state.
 		 */
 		raw_spin_lock_irq(&task->pi_lock);
diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 8cb06c8c7eb1..ceb03d76c0cc 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -120,7 +120,7 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 	const struct sched_dl_entity *dl_se = &p->dl;
 
 	if (later_mask &&
-	    cpumask_and(later_mask, cp->free_cpus, p->cpus_ptr)) {
+	    cpumask_and(later_mask, cp->free_cpus, &p->cpus_mask)) {
 		unsigned long cap, max_cap = 0;
 		int cpu, max_cpu = -1;
 
@@ -151,7 +151,7 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 
 		WARN_ON(best_cpu != -1 && !cpu_present(best_cpu));
 
-		if (cpumask_test_cpu(best_cpu, p->cpus_ptr) &&
+		if (cpumask_test_cpu(best_cpu, &p->cpus_mask) &&
 		    dl_time_before(dl_se->deadline, cp->elements[0].dl)) {
 			if (later_mask)
 				cpumask_set_cpu(best_cpu, later_mask);
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index c03a5775d019..8a5f5cf8521a 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -901,16 +901,9 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 cpufreq_governor_init(schedutil_gov);
 
 #ifdef CONFIG_ENERGY_MODEL
-extern bool sched_energy_update;
-extern struct mutex sched_energy_mutex;
-
 static void rebuild_sd_workfn(struct work_struct *work)
 {
-	mutex_lock(&sched_energy_mutex);
-	sched_energy_update = true;
-	rebuild_sched_domains();
-	sched_energy_update = false;
-	mutex_unlock(&sched_energy_mutex);
+	rebuild_sched_domains_energy();
 }
 static DECLARE_WORK(rebuild_sd_work, rebuild_sd_workfn);
 
diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index 0033731a0797..ec9be789c7e2 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -11,7 +11,7 @@
  *  This code tracks the priority of each CPU so that global migration
  *  decisions are easy to calculate.  Each CPU can be in a state as follows:
  *
- *                 (INVALID), IDLE, NORMAL, RT1, ... RT99
+ *                 (INVALID), NORMAL, RT1, ... RT99, HIGHER
  *
  *  going from the lowest priority to the highest.  CPUs in the INVALID state
  *  are not eligible for routing.  The system maintains this state with
@@ -19,24 +19,48 @@
  *  in that class).  Therefore a typical application without affinity
  *  restrictions can find a suitable CPU with O(1) complexity (e.g. two bit
  *  searches).  For tasks with affinity restrictions, the algorithm has a
- *  worst case complexity of O(min(102, nr_domcpus)), though the scenario that
+ *  worst case complexity of O(min(101, nr_domcpus)), though the scenario that
  *  yields the worst case search is fairly contrived.
  */
 #include "sched.h"
 
-/* Convert between a 140 based task->prio, and our 102 based cpupri */
+/*
+ * p->rt_priority   p->prio   newpri   cpupri
+ *
+ *				  -1       -1 (CPUPRI_INVALID)
+ *
+ *				  99        0 (CPUPRI_NORMAL)
+ *
+ *		1        98       98        1
+ *	      ...
+ *	       49        50       50       49
+ *	       50        49       49       50
+ *	      ...
+ *	       99         0        0       99
+ *
+ *				 100	  100 (CPUPRI_HIGHER)
+ */
 static int convert_prio(int prio)
 {
 	int cpupri;
 
-	if (prio == CPUPRI_INVALID)
-		cpupri = CPUPRI_INVALID;
-	else if (prio == MAX_PRIO)
-		cpupri = CPUPRI_IDLE;
-	else if (prio >= MAX_RT_PRIO)
-		cpupri = CPUPRI_NORMAL;
-	else
-		cpupri = MAX_RT_PRIO - prio + 1;
+	switch (prio) {
+	case CPUPRI_INVALID:
+		cpupri = CPUPRI_INVALID;	/* -1 */
+		break;
+
+	case 0 ... 98:
+		cpupri = MAX_RT_PRIO-1 - prio;	/* 1 ... 99 */
+		break;
+
+	case MAX_RT_PRIO-1:
+		cpupri = CPUPRI_NORMAL;		/*  0 */
+		break;
+
+	case MAX_RT_PRIO:
+		cpupri = CPUPRI_HIGHER;		/* 100 */
+		break;
+	}
 
 	return cpupri;
 }
@@ -73,11 +97,11 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
 	if (skip)
 		return 0;
 
-	if (cpumask_any_and(p->cpus_ptr, vec->mask) >= nr_cpu_ids)
+	if (cpumask_any_and(&p->cpus_mask, vec->mask) >= nr_cpu_ids)
 		return 0;
 
 	if (lowest_mask) {
-		cpumask_and(lowest_mask, p->cpus_ptr, vec->mask);
+		cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
 
 		/*
 		 * We have to ensure that we have at least one bit
@@ -177,7 +201,7 @@ int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
  * cpupri_set - update the CPU priority setting
  * @cp: The cpupri context
  * @cpu: The target CPU
- * @newpri: The priority (INVALID-RT99) to assign to this CPU
+ * @newpri: The priority (INVALID,NORMAL,RT1-RT99,HIGHER) to assign to this CPU
  *
  * Note: Assumes cpu_rq(cpu)->lock is locked
  *
diff --git a/kernel/sched/cpupri.h b/kernel/sched/cpupri.h
index efbb492bb94c..d6cba0020064 100644
--- a/kernel/sched/cpupri.h
+++ b/kernel/sched/cpupri.h
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-#define CPUPRI_NR_PRIORITIES	(MAX_RT_PRIO + 2)
+#define CPUPRI_NR_PRIORITIES	(MAX_RT_PRIO+1)
 
 #define CPUPRI_INVALID		-1
-#define CPUPRI_IDLE		 0
-#define CPUPRI_NORMAL		 1
-/* values 2-101 are RT priorities 0-99 */
+#define CPUPRI_NORMAL		 0
+/* values 1-99 are for RT1-RT99 priorities */
+#define CPUPRI_HIGHER		100
 
 struct cpupri_vec {
 	atomic_t		count;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f232305dcefe..2a5836f440e0 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -97,6 +97,17 @@ static inline unsigned long dl_bw_capacity(int i)
 		return __dl_bw_capacity(i);
 	}
 }
+
+static inline bool dl_bw_visited(int cpu, u64 gen)
+{
+	struct root_domain *rd = cpu_rq(cpu)->rd;
+
+	if (rd->visit_gen == gen)
+		return true;
+
+	rd->visit_gen = gen;
+	return false;
+}
 #else
 static inline struct dl_bw *dl_bw_of(int i)
 {
@@ -112,6 +123,11 @@ static inline unsigned long dl_bw_capacity(int i)
 {
 	return SCHED_CAPACITY_SCALE;
 }
+
+static inline bool dl_bw_visited(int cpu, u64 gen)
+{
+	return false;
+}
 #endif
 
 static inline
@@ -543,7 +559,7 @@ static int push_dl_task(struct rq *rq);
 
 static inline bool need_pull_dl_task(struct rq *rq, struct task_struct *prev)
 {
-	return dl_task(prev);
+	return rq->online && dl_task(prev);
 }
 
 static DEFINE_PER_CPU(struct callback_head, dl_push_head);
@@ -1378,6 +1394,8 @@ static void inc_dl_deadline(struct dl_rq *dl_rq, u64 deadline)
 
 	if (dl_rq->earliest_dl.curr == 0 ||
 	    dl_time_before(deadline, dl_rq->earliest_dl.curr)) {
+		if (dl_rq->earliest_dl.curr == 0)
+			cpupri_set(&rq->rd->cpupri, rq->cpu, CPUPRI_HIGHER);
 		dl_rq->earliest_dl.curr = deadline;
 		cpudl_set(&rq->rd->cpudl, rq->cpu, deadline);
 	}
@@ -1395,6 +1413,7 @@ static void dec_dl_deadline(struct dl_rq *dl_rq, u64 deadline)
 		dl_rq->earliest_dl.curr = 0;
 		dl_rq->earliest_dl.next = 0;
 		cpudl_clear(&rq->rd->cpudl, rq->cpu);
+		cpupri_set(&rq->rd->cpupri, rq->cpu, rq->rt.highest_prio.curr);
 	} else {
 		struct rb_node *leftmost = dl_rq->root.rb_leftmost;
 		struct sched_dl_entity *entry;
@@ -1664,13 +1683,13 @@ static void yield_task_dl(struct rq *rq)
 static int find_later_rq(struct task_struct *task);
 
 static int
-select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
+select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 {
 	struct task_struct *curr;
 	bool select_rq;
 	struct rq *rq;
 
-	if (sd_flag != SD_BALANCE_WAKE)
+	if (!(flags & WF_TTWU))
 		goto out;
 
 	rq = cpu_rq(cpu);
@@ -1912,7 +1931,7 @@ static void task_fork_dl(struct task_struct *p)
 static int pick_dl_task(struct rq *rq, struct task_struct *p, int cpu)
 {
 	if (!task_running(rq, p) &&
-	    cpumask_test_cpu(cpu, p->cpus_ptr))
+	    cpumask_test_cpu(cpu, &p->cpus_mask))
 		return 1;
 	return 0;
 }
@@ -2002,8 +2021,8 @@ static int find_later_rq(struct task_struct *task)
 				return this_cpu;
 			}
 
-			best_cpu = cpumask_first_and(later_mask,
-							sched_domain_span(sd));
+			best_cpu = cpumask_any_and_distribute(later_mask,
+							      sched_domain_span(sd));
 			/*
 			 * Last chance: if a CPU being in both later_mask
 			 * and current sd span is valid, that becomes our
@@ -2025,7 +2044,7 @@ static int find_later_rq(struct task_struct *task)
 	if (this_cpu != -1)
 		return this_cpu;
 
-	cpu = cpumask_any(later_mask);
+	cpu = cpumask_any_distribute(later_mask);
 	if (cpu < nr_cpu_ids)
 		return cpu;
 
@@ -2062,7 +2081,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 		/* Retry if something changed. */
 		if (double_lock_balance(rq, later_rq)) {
 			if (unlikely(task_rq(task) != rq ||
-				     !cpumask_test_cpu(later_rq->cpu, task->cpus_ptr) ||
+				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
 				     task_running(rq, task) ||
 				     !dl_task(task) ||
 				     !task_on_rq_queued(task))) {
@@ -2129,6 +2148,9 @@ static int push_dl_task(struct rq *rq)
 		return 0;
 
 retry:
+	if (is_migration_disabled(next_task))
+		return 0;
+
 	if (WARN_ON(next_task == rq->curr))
 		return 0;
 
@@ -2206,7 +2228,7 @@ static void push_dl_tasks(struct rq *rq)
 static void pull_dl_task(struct rq *this_rq)
 {
 	int this_cpu = this_rq->cpu, cpu;
-	struct task_struct *p;
+	struct task_struct *p, *push_task;
 	bool resched = false;
 	struct rq *src_rq;
 	u64 dmin = LONG_MAX;
@@ -2236,6 +2258,7 @@ static void pull_dl_task(struct rq *this_rq)
 			continue;
 
 		/* Might drop this_rq->lock */
+		push_task = NULL;
 		double_lock_balance(this_rq, src_rq);
 
 		/*
@@ -2267,17 +2290,27 @@ static void pull_dl_task(struct rq *this_rq)
 					   src_rq->curr->dl.deadline))
 				goto skip;
 
-			resched = true;
-
-			deactivate_task(src_rq, p, 0);
-			set_task_cpu(p, this_cpu);
-			activate_task(this_rq, p, 0);
-			dmin = p->dl.deadline;
+			if (is_migration_disabled(p)) {
+				push_task = get_push_task(src_rq);
+			} else {
+				deactivate_task(src_rq, p, 0);
+				set_task_cpu(p, this_cpu);
+				activate_task(this_rq, p, 0);
+				dmin = p->dl.deadline;
+				resched = true;
+			}
 
 			/* Is there any other task even earlier? */
 		}
 skip:
 		double_unlock_balance(this_rq, src_rq);
+
+		if (push_task) {
+			raw_spin_unlock(&this_rq->lock);
+			stop_one_cpu_nowait(src_rq->cpu, push_cpu_stop,
+					    push_task, &src_rq->push_work);
+			raw_spin_lock(&this_rq->lock);
+		}
 	}
 
 	if (resched)
@@ -2301,7 +2334,8 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
 }
 
 static void set_cpus_allowed_dl(struct task_struct *p,
-				const struct cpumask *new_mask)
+				const struct cpumask *new_mask,
+				u32 flags)
 {
 	struct root_domain *src_rd;
 	struct rq *rq;
@@ -2330,7 +2364,7 @@ static void set_cpus_allowed_dl(struct task_struct *p,
 		raw_spin_unlock(&src_dl_b->lock);
 	}
 
-	set_cpus_allowed_common(p, new_mask);
+	set_cpus_allowed_common(p, new_mask, flags);
 }
 
 /* Assumes rq->lock is held */
@@ -2503,8 +2537,8 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 	}
 }
 
-const struct sched_class dl_sched_class
-	__section("__dl_sched_class") = {
+DEFINE_SCHED_CLASS(dl) = {
+
 	.enqueue_task		= enqueue_task_dl,
 	.dequeue_task		= dequeue_task_dl,
 	.yield_task		= yield_task_dl,
@@ -2523,6 +2557,7 @@ const struct sched_class dl_sched_class
 	.rq_online              = rq_online_dl,
 	.rq_offline             = rq_offline_dl,
 	.task_woken		= task_woken_dl,
+	.find_lock_rq		= find_lock_later_rq,
 #endif
 
 	.task_tick		= task_tick_dl,
@@ -2535,33 +2570,39 @@ const struct sched_class dl_sched_class
 	.update_curr		= update_curr_dl,
 };
 
+/* Used for dl_bw check and update, used under sched_rt_handler()::mutex */
+static u64 dl_generation;
+
 int sched_dl_global_validate(void)
 {
 	u64 runtime = global_rt_runtime();
 	u64 period = global_rt_period();
 	u64 new_bw = to_ratio(period, runtime);
+	u64 gen = ++dl_generation;
 	struct dl_bw *dl_b;
-	int cpu, ret = 0;
+	int cpu, cpus, ret = 0;
 	unsigned long flags;
 
 	/*
 	 * Here we want to check the bandwidth not being set to some
 	 * value smaller than the currently allocated bandwidth in
 	 * any of the root_domains.
-	 *
-	 * FIXME: Cycling on all the CPUs is overdoing, but simpler than
-	 * cycling on root_domains... Discussion on different/better
-	 * solutions is welcome!
 	 */
 	for_each_possible_cpu(cpu) {
 		rcu_read_lock_sched();
+
+		if (dl_bw_visited(cpu, gen))
+			goto next;
+
 		dl_b = dl_bw_of(cpu);
+		cpus = dl_bw_cpus(cpu);
 
 		raw_spin_lock_irqsave(&dl_b->lock, flags);
-		if (new_bw < dl_b->total_bw)
+		if (new_bw * cpus < dl_b->total_bw)
 			ret = -EBUSY;
 		raw_spin_unlock_irqrestore(&dl_b->lock, flags);
 
+next:
 		rcu_read_unlock_sched();
 
 		if (ret)
@@ -2587,6 +2628,7 @@ static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq)
 void sched_dl_do_global(void)
 {
 	u64 new_bw = -1;
+	u64 gen = ++dl_generation;
 	struct dl_bw *dl_b;
 	int cpu;
 	unsigned long flags;
@@ -2597,11 +2639,14 @@ void sched_dl_do_global(void)
 	if (global_rt_runtime() != RUNTIME_INF)
 		new_bw = to_ratio(global_rt_period(), global_rt_runtime());
 
-	/*
-	 * FIXME: As above...
-	 */
 	for_each_possible_cpu(cpu) {
 		rcu_read_lock_sched();
+
+		if (dl_bw_visited(cpu, gen)) {
+			rcu_read_unlock_sched();
+			continue;
+		}
+
 		dl_b = dl_bw_of(cpu);
 
 		raw_spin_lock_irqsave(&dl_b->lock, flags);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 290f9e38378c..6691e28fa3da 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -906,6 +906,15 @@ update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	if (!schedstat_enabled())
 		return;
 
+	/*
+	 * When the sched_schedstat changes from 0 to 1, some sched se
+	 * maybe already in the runqueue, the se->statistics.wait_start
+	 * will be 0.So it will let the delta wrong. We need to avoid this
+	 * scenario.
+	 */
+	if (unlikely(!schedstat_val(se->statistics.wait_start)))
+		return;
+
 	delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(se->statistics.wait_start);
 
 	if (entity_is_task(se)) {
@@ -4779,25 +4788,37 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 		/* throttled entity or throttle-on-deactivate */
 		if (!se->on_rq)
-			break;
+			goto done;
 
-		if (dequeue) {
-			dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
-		} else {
-			update_load_avg(qcfs_rq, se, 0);
-			se_update_runnable(se);
-		}
+		dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
 
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 
-		if (qcfs_rq->load.weight)
-			dequeue = 0;
+		if (qcfs_rq->load.weight) {
+			/* Avoid re-evaluating load for this entity: */
+			se = parent_entity(se);
+			break;
+		}
 	}
 
-	if (!se)
-		sub_nr_running(rq, task_delta);
+	for_each_sched_entity(se) {
+		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
+		/* throttled entity or throttle-on-deactivate */
+		if (!se->on_rq)
+			goto done;
+
+		update_load_avg(qcfs_rq, se, 0);
+		se_update_runnable(se);
 
+		qcfs_rq->h_nr_running -= task_delta;
+		qcfs_rq->idle_h_nr_running -= idle_task_delta;
+	}
+
+	/* At this point se is NULL and we are at root level*/
+	sub_nr_running(rq, task_delta);
+
+done:
 	/*
 	 * Note: distribution will already see us throttled via the
 	 * throttled-list.  rq->lock protects completion.
@@ -5105,9 +5126,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 		return;
 
 	distribute_cfs_runtime(cfs_b);
-
-	raw_spin_lock_irqsave(&cfs_b->lock, flags);
-	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 }
 
 /*
@@ -5804,6 +5822,9 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	if (sync && cpu_rq(this_cpu)->nr_running == 1)
 		return this_cpu;
 
+	if (available_idle_cpu(prev_cpu))
+		return prev_cpu;
+
 	return nr_cpumask_bits;
 }
 
@@ -6663,7 +6684,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 /*
  * select_task_rq_fair: Select target runqueue for the waking task in domains
- * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
+ * that have the relevant SD flag set. In practice, this is SD_BALANCE_WAKE,
  * SD_BALANCE_FORK, or SD_BALANCE_EXEC.
  *
  * Balances load by selecting the idlest CPU in the idlest group, or under
@@ -6674,15 +6695,17 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
  * preempt must be disabled.
  */
 static int
-select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
+select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 {
+	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
 	struct sched_domain *tmp, *sd = NULL;
 	int cpu = smp_processor_id();
 	int new_cpu = prev_cpu;
 	int want_affine = 0;
-	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
+	/* SD_flags and WF_flags share the first nibble */
+	int sd_flag = wake_flags & 0xF;
 
-	if (sd_flag & SD_BALANCE_WAKE) {
+	if (wake_flags & WF_TTWU) {
 		record_wakee(p);
 
 		if (sched_energy_enabled()) {
@@ -6719,9 +6742,8 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	if (unlikely(sd)) {
 		/* Slow path */
 		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
-	} else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
+	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
-
 		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
 
 		if (want_affine)
@@ -10047,6 +10069,10 @@ static inline int find_new_ilb(void)
 
 	for_each_cpu_and(ilb, nohz.idle_cpus_mask,
 			      housekeeping_cpumask(HK_FLAG_MISC)) {
+
+		if (ilb == smp_processor_id())
+			continue;
+
 		if (idle_cpu(ilb))
 			return ilb;
 	}
@@ -11158,8 +11184,8 @@ static unsigned int get_rr_interval_fair(struct rq *rq, struct task_struct *task
 /*
  * All the scheduling class methods:
  */
-const struct sched_class fair_sched_class
-	__section("__fair_sched_class") = {
+DEFINE_SCHED_CLASS(fair) = {
+
 	.enqueue_task		= enqueue_task_fair,
 	.dequeue_task		= dequeue_task_fair,
 	.yield_task		= yield_task_fair,
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 24d0ee26377d..df91b198a74c 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -338,6 +338,7 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
 	WARN_ON_ONCE(!(current->flags & PF_KTHREAD));
 	WARN_ON_ONCE(!(current->flags & PF_NO_SETAFFINITY));
 	WARN_ON_ONCE(!duration_ns);
+	WARN_ON_ONCE(current->mm);
 
 	rcu_sleep_check();
 	preempt_disable();
@@ -375,7 +376,7 @@ void cpu_startup_entry(enum cpuhp_state state)
 
 #ifdef CONFIG_SMP
 static int
-select_task_rq_idle(struct task_struct *p, int cpu, int sd_flag, int flags)
+select_task_rq_idle(struct task_struct *p, int cpu, int flags)
 {
 	return task_cpu(p); /* IDLE tasks as never migrated */
 }
@@ -457,8 +458,8 @@ static void update_curr_idle(struct rq *rq)
 /*
  * Simple, special scheduling class for the per-CPU idle tasks:
  */
-const struct sched_class idle_sched_class
-	__section("__idle_sched_class") = {
+DEFINE_SCHED_CLASS(idle) = {
+
 	/* no enqueue/yield_task for idle tasks */
 
 	/* dequeue is not valid, we print a debug message there: */
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index e23e74d52db5..5a40b3828ff2 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -6,6 +6,134 @@
  */
 #include "sched.h"
 
+/*
+ * For documentation purposes, here are some membarrier ordering
+ * scenarios to keep in mind:
+ *
+ * A) Userspace thread execution after IPI vs membarrier's memory
+ *    barrier before sending the IPI
+ *
+ * Userspace variables:
+ *
+ * int x = 0, y = 0;
+ *
+ * The memory barrier at the start of membarrier() on CPU0 is necessary in
+ * order to enforce the guarantee that any writes occurring on CPU0 before
+ * the membarrier() is executed will be visible to any code executing on
+ * CPU1 after the IPI-induced memory barrier:
+ *
+ *         CPU0                              CPU1
+ *
+ *         x = 1
+ *         membarrier():
+ *           a: smp_mb()
+ *           b: send IPI                       IPI-induced mb
+ *           c: smp_mb()
+ *         r2 = y
+ *                                           y = 1
+ *                                           barrier()
+ *                                           r1 = x
+ *
+ *                     BUG_ON(r1 == 0 && r2 == 0)
+ *
+ * The write to y and load from x by CPU1 are unordered by the hardware,
+ * so it's possible to have "r1 = x" reordered before "y = 1" at any
+ * point after (b).  If the memory barrier at (a) is omitted, then "x = 1"
+ * can be reordered after (a) (although not after (c)), so we get r1 == 0
+ * and r2 == 0.  This violates the guarantee that membarrier() is
+ * supposed by provide.
+ *
+ * The timing of the memory barrier at (a) has to ensure that it executes
+ * before the IPI-induced memory barrier on CPU1.
+ *
+ * B) Userspace thread execution before IPI vs membarrier's memory
+ *    barrier after completing the IPI
+ *
+ * Userspace variables:
+ *
+ * int x = 0, y = 0;
+ *
+ * The memory barrier at the end of membarrier() on CPU0 is necessary in
+ * order to enforce the guarantee that any writes occurring on CPU1 before
+ * the membarrier() is executed will be visible to any code executing on
+ * CPU0 after the membarrier():
+ *
+ *         CPU0                              CPU1
+ *
+ *                                           x = 1
+ *                                           barrier()
+ *                                           y = 1
+ *         r2 = y
+ *         membarrier():
+ *           a: smp_mb()
+ *           b: send IPI                       IPI-induced mb
+ *           c: smp_mb()
+ *         r1 = x
+ *         BUG_ON(r1 == 0 && r2 == 1)
+ *
+ * The writes to x and y are unordered by the hardware, so it's possible to
+ * have "r2 = 1" even though the write to x doesn't execute until (b).  If
+ * the memory barrier at (c) is omitted then "r1 = x" can be reordered
+ * before (b) (although not before (a)), so we get "r1 = 0".  This violates
+ * the guarantee that membarrier() is supposed to provide.
+ *
+ * The timing of the memory barrier at (c) has to ensure that it executes
+ * after the IPI-induced memory barrier on CPU1.
+ *
+ * C) Scheduling userspace thread -> kthread -> userspace thread vs membarrier
+ *
+ *           CPU0                            CPU1
+ *
+ *           membarrier():
+ *           a: smp_mb()
+ *                                           d: switch to kthread (includes mb)
+ *           b: read rq->curr->mm == NULL
+ *                                           e: switch to user (includes mb)
+ *           c: smp_mb()
+ *
+ * Using the scenario from (A), we can show that (a) needs to be paired
+ * with (e). Using the scenario from (B), we can show that (c) needs to
+ * be paired with (d).
+ *
+ * D) exit_mm vs membarrier
+ *
+ * Two thread groups are created, A and B.  Thread group B is created by
+ * issuing clone from group A with flag CLONE_VM set, but not CLONE_THREAD.
+ * Let's assume we have a single thread within each thread group (Thread A
+ * and Thread B).  Thread A runs on CPU0, Thread B runs on CPU1.
+ *
+ *           CPU0                            CPU1
+ *
+ *           membarrier():
+ *             a: smp_mb()
+ *                                           exit_mm():
+ *                                             d: smp_mb()
+ *                                             e: current->mm = NULL
+ *             b: read rq->curr->mm == NULL
+ *             c: smp_mb()
+ *
+ * Using scenario (B), we can show that (c) needs to be paired with (d).
+ *
+ * E) kthread_{use,unuse}_mm vs membarrier
+ *
+ *           CPU0                            CPU1
+ *
+ *           membarrier():
+ *           a: smp_mb()
+ *                                           kthread_unuse_mm()
+ *                                             d: smp_mb()
+ *                                             e: current->mm = NULL
+ *           b: read rq->curr->mm == NULL
+ *                                           kthread_use_mm()
+ *                                             f: current->mm = mm
+ *                                             g: smp_mb()
+ *           c: smp_mb()
+ *
+ * Using the scenario from (A), we can show that (a) needs to be paired
+ * with (g). Using the scenario from (B), we can show that (c) needs to
+ * be paired with (d).
+ */
+
 /*
  * Bitmask made from a "or" of all commands within enum membarrier_cmd,
  * except MEMBARRIER_CMD_QUERY.
@@ -76,6 +204,18 @@ void membarrier_exec_mmap(struct mm_struct *mm)
 	this_cpu_write(runqueues.membarrier_state, 0);
 }
 
+void membarrier_update_current_mm(struct mm_struct *next_mm)
+{
+	struct rq *rq = this_rq();
+	int membarrier_state = 0;
+
+	if (next_mm)
+		membarrier_state = atomic_read(&next_mm->membarrier_state);
+	if (READ_ONCE(rq->membarrier_state) == membarrier_state)
+		return;
+	WRITE_ONCE(rq->membarrier_state, membarrier_state);
+}
+
 static int membarrier_global_expedited(void)
 {
 	int cpu;
@@ -114,12 +254,11 @@ static int membarrier_global_expedited(void)
 			continue;
 
 		/*
-		 * Skip the CPU if it runs a kernel thread. The scheduler
-		 * leaves the prior task mm in place as an optimization when
-		 * scheduling a kthread.
+		 * Skip the CPU if it runs a kernel thread which is not using
+		 * a task mm.
 		 */
 		p = rcu_dereference(cpu_rq(cpu)->curr);
-		if (p->flags & PF_KTHREAD)
+		if (!p->mm)
 			continue;
 
 		__cpumask_set_cpu(cpu, tmpmask);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 49ec096a8aa1..dbe4629cf7ba 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -89,8 +89,8 @@ void init_rt_rq(struct rt_rq *rt_rq)
 	__set_bit(MAX_RT_PRIO, array->bitmap);
 
 #if defined CONFIG_SMP
-	rt_rq->highest_prio.curr = MAX_RT_PRIO;
-	rt_rq->highest_prio.next = MAX_RT_PRIO;
+	rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
+	rt_rq->highest_prio.next = MAX_RT_PRIO-1;
 	rt_rq->rt_nr_migratory = 0;
 	rt_rq->overloaded = 0;
 	plist_head_init(&rt_rq->pushable_tasks);
@@ -161,7 +161,7 @@ void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
 {
 	struct rq *rq = cpu_rq(cpu);
 
-	rt_rq->highest_prio.curr = MAX_RT_PRIO;
+	rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
 	rt_rq->rt_nr_boosted = 0;
 	rt_rq->rq = rq;
 	rt_rq->tg = tg;
@@ -265,7 +265,7 @@ static void pull_rt_task(struct rq *this_rq);
 static inline bool need_pull_rt_task(struct rq *rq, struct task_struct *prev)
 {
 	/* Try to pull RT tasks here if we lower this rq's prio */
-	return rq->rt.highest_prio.curr > prev->prio;
+	return rq->online && rq->rt.highest_prio.curr > prev->prio;
 }
 
 static inline int rt_overloaded(struct rq *rq)
@@ -393,8 +393,9 @@ static void dequeue_pushable_task(struct rq *rq, struct task_struct *p)
 		p = plist_first_entry(&rq->rt.pushable_tasks,
 				      struct task_struct, pushable_tasks);
 		rq->rt.highest_prio.next = p->prio;
-	} else
-		rq->rt.highest_prio.next = MAX_RT_PRIO;
+	} else {
+		rq->rt.highest_prio.next = MAX_RT_PRIO-1;
+	}
 }
 
 #else
@@ -1147,8 +1148,9 @@ dec_rt_prio(struct rt_rq *rt_rq, int prio)
 				sched_find_first_bit(array->bitmap);
 		}
 
-	} else
-		rt_rq->highest_prio.curr = MAX_RT_PRIO;
+	} else {
+		rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
+	}
 
 	dec_rt_prio_smp(rt_rq, prio, prev_prio);
 }
@@ -1428,14 +1430,14 @@ static void yield_task_rt(struct rq *rq)
 static int find_lowest_rq(struct task_struct *task);
 
 static int
-select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
+select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 {
 	struct task_struct *curr;
 	struct rq *rq;
 	bool test;
 
 	/* For anything but wake ups, just return the task_cpu */
-	if (sd_flag != SD_BALANCE_WAKE && sd_flag != SD_BALANCE_FORK)
+	if (!(flags & (WF_TTWU | WF_FORK)))
 		goto out;
 
 	rq = cpu_rq(cpu);
@@ -1658,7 +1660,7 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
 {
 	if (!task_running(rq, p) &&
-	    cpumask_test_cpu(cpu, p->cpus_ptr))
+	    cpumask_test_cpu(cpu, &p->cpus_mask))
 		return 1;
 
 	return 0;
@@ -1752,8 +1754,8 @@ static int find_lowest_rq(struct task_struct *task)
 				return this_cpu;
 			}
 
-			best_cpu = cpumask_first_and(lowest_mask,
-						     sched_domain_span(sd));
+			best_cpu = cpumask_any_and_distribute(lowest_mask,
+							      sched_domain_span(sd));
 			if (best_cpu < nr_cpu_ids) {
 				rcu_read_unlock();
 				return best_cpu;
@@ -1770,7 +1772,7 @@ static int find_lowest_rq(struct task_struct *task)
 	if (this_cpu != -1)
 		return this_cpu;
 
-	cpu = cpumask_any(lowest_mask);
+	cpu = cpumask_any_distribute(lowest_mask);
 	if (cpu < nr_cpu_ids)
 		return cpu;
 
@@ -1811,7 +1813,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			 * Also make sure that it wasn't scheduled on its rq.
 			 */
 			if (unlikely(task_rq(task) != rq ||
-				     !cpumask_test_cpu(lowest_rq->cpu, task->cpus_ptr) ||
+				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
 				     task_running(rq, task) ||
 				     !rt_task(task) ||
 				     !task_on_rq_queued(task))) {
@@ -1859,7 +1861,7 @@ static struct task_struct *pick_next_pushable_task(struct rq *rq)
  * running task can migrate over to a CPU that is running a task
  * of lesser priority.
  */
-static int push_rt_task(struct rq *rq)
+static int push_rt_task(struct rq *rq, bool pull)
 {
 	struct task_struct *next_task;
 	struct rq *lowest_rq;
@@ -1873,6 +1875,34 @@ static int push_rt_task(struct rq *rq)
 		return 0;
 
 retry:
+	if (is_migration_disabled(next_task)) {
+		struct task_struct *push_task = NULL;
+		int cpu;
+
+		if (!pull || rq->push_busy)
+			return 0;
+
+		cpu = find_lowest_rq(rq->curr);
+		if (cpu == -1 || cpu == rq->cpu)
+			return 0;
+
+		/*
+		 * Given we found a CPU with lower priority than @next_task,
+		 * therefore it should be running. However we cannot migrate it
+		 * to this other CPU, instead attempt to push the current
+		 * running task on this CPU away.
+		 */
+		push_task = get_push_task(rq);
+		if (push_task) {
+			raw_spin_unlock(&rq->lock);
+			stop_one_cpu_nowait(rq->cpu, push_cpu_stop,
+					    push_task, &rq->push_work);
+			raw_spin_lock(&rq->lock);
+		}
+
+		return 0;
+	}
+
 	if (WARN_ON(next_task == rq->curr))
 		return 0;
 
@@ -1927,12 +1957,10 @@ static int push_rt_task(struct rq *rq)
 	deactivate_task(rq, next_task, 0);
 	set_task_cpu(next_task, lowest_rq->cpu);
 	activate_task(lowest_rq, next_task, 0);
-	ret = 1;
-
 	resched_curr(lowest_rq);
+	ret = 1;
 
 	double_unlock_balance(rq, lowest_rq);
-
 out:
 	put_task_struct(next_task);
 
@@ -1942,7 +1970,7 @@ static int push_rt_task(struct rq *rq)
 static void push_rt_tasks(struct rq *rq)
 {
 	/* push_rt_task will return true if it moved an RT */
-	while (push_rt_task(rq))
+	while (push_rt_task(rq, false))
 		;
 }
 
@@ -2095,7 +2123,8 @@ void rto_push_irq_work_func(struct irq_work *work)
 	 */
 	if (has_pushable_tasks(rq)) {
 		raw_spin_lock(&rq->lock);
-		push_rt_tasks(rq);
+		while (push_rt_task(rq, true))
+			;
 		raw_spin_unlock(&rq->lock);
 	}
 
@@ -2120,7 +2149,7 @@ static void pull_rt_task(struct rq *this_rq)
 {
 	int this_cpu = this_rq->cpu, cpu;
 	bool resched = false;
-	struct task_struct *p;
+	struct task_struct *p, *push_task;
 	struct rq *src_rq;
 	int rt_overload_count = rt_overloaded(this_rq);
 
@@ -2167,6 +2196,7 @@ static void pull_rt_task(struct rq *this_rq)
 		 * double_lock_balance, and another CPU could
 		 * alter this_rq
 		 */
+		push_task = NULL;
 		double_lock_balance(this_rq, src_rq);
 
 		/*
@@ -2194,11 +2224,14 @@ static void pull_rt_task(struct rq *this_rq)
 			if (p->prio < src_rq->curr->prio)
 				goto skip;
 
-			resched = true;
-
-			deactivate_task(src_rq, p, 0);
-			set_task_cpu(p, this_cpu);
-			activate_task(this_rq, p, 0);
+			if (is_migration_disabled(p)) {
+				push_task = get_push_task(src_rq);
+			} else {
+				deactivate_task(src_rq, p, 0);
+				set_task_cpu(p, this_cpu);
+				activate_task(this_rq, p, 0);
+				resched = true;
+			}
 			/*
 			 * We continue with the search, just in
 			 * case there's an even higher prio task
@@ -2208,6 +2241,13 @@ static void pull_rt_task(struct rq *this_rq)
 		}
 skip:
 		double_unlock_balance(this_rq, src_rq);
+
+		if (push_task) {
+			raw_spin_unlock(&this_rq->lock);
+			stop_one_cpu_nowait(src_rq->cpu, push_cpu_stop,
+					    push_task, &src_rq->push_work);
+			raw_spin_lock(&this_rq->lock);
+		}
 	}
 
 	if (resched)
@@ -2429,8 +2469,8 @@ static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)
 		return 0;
 }
 
-const struct sched_class rt_sched_class
-	__section("__rt_sched_class") = {
+DEFINE_SCHED_CLASS(rt) = {
+
 	.enqueue_task		= enqueue_task_rt,
 	.dequeue_task		= dequeue_task_rt,
 	.yield_task		= yield_task_rt,
@@ -2449,6 +2489,7 @@ const struct sched_class rt_sched_class
 	.rq_offline             = rq_offline_rt,
 	.task_woken		= task_woken_rt,
 	.switched_from		= switched_from_rt,
+	.find_lock_rq		= find_lock_lowest_rq,
 #endif
 
 	.task_tick		= task_tick_rt,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index df80bfcea92e..f5acb6c5ce49 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -67,7 +67,6 @@
 #include <linux/tsacct_kern.h>
 
 #include <asm/tlb.h>
-#include <asm-generic/vmlinux.lds.h>
 
 #ifdef CONFIG_PARAVIRT
 # include <asm/paravirt.h>
@@ -257,30 +256,6 @@ struct rt_bandwidth {
 
 void __dl_clear_params(struct task_struct *p);
 
-/*
- * To keep the bandwidth of -deadline tasks and groups under control
- * we need some place where:
- *  - store the maximum -deadline bandwidth of the system (the group);
- *  - cache the fraction of that bandwidth that is currently allocated.
- *
- * This is all done in the data structure below. It is similar to the
- * one used for RT-throttling (rt_bandwidth), with the main difference
- * that, since here we are only interested in admission control, we
- * do not decrease any runtime while the group "executes", neither we
- * need a timer to replenish it.
- *
- * With respect to SMP, the bandwidth is given on a per-CPU basis,
- * meaning that:
- *  - dl_bw (< 100%) is the bandwidth of the system (group) on each CPU;
- *  - dl_total_bw array contains, in the i-eth element, the currently
- *    allocated bandwidth on the i-eth CPU.
- * Moreover, groups consume bandwidth on each CPU, while tasks only
- * consume bandwidth on the CPU they're running on.
- * Finally, dl_total_bw_cpu is used to cache the index of dl_total_bw
- * that will be shown the next time the proc or cgroup controls will
- * be red. It on its turn can be changed by writing on its own
- * control.
- */
 struct dl_bandwidth {
 	raw_spinlock_t		dl_runtime_lock;
 	u64			dl_runtime;
@@ -292,6 +267,24 @@ static inline int dl_bandwidth_enabled(void)
 	return sysctl_sched_rt_runtime >= 0;
 }
 
+/*
+ * To keep the bandwidth of -deadline tasks under control
+ * we need some place where:
+ *  - store the maximum -deadline bandwidth of each cpu;
+ *  - cache the fraction of bandwidth that is currently allocated in
+ *    each root domain;
+ *
+ * This is all done in the data structure below. It is similar to the
+ * one used for RT-throttling (rt_bandwidth), with the main difference
+ * that, since here we are only interested in admission control, we
+ * do not decrease any runtime while the group "executes", neither we
+ * need a timer to replenish it.
+ *
+ * With respect to SMP, bandwidth is given on a per root domain basis,
+ * meaning that:
+ *  - bw (< 100%) is the deadline bandwidth of each CPU;
+ *  - total_bw is the currently allocated bandwidth in each root domain;
+ */
 struct dl_bw {
 	raw_spinlock_t		lock;
 	u64			bw;
@@ -801,6 +794,15 @@ struct root_domain {
 	struct dl_bw		dl_bw;
 	struct cpudl		cpudl;
 
+	/*
+	 * Indicate whether a root_domain's dl_bw has been checked or
+	 * updated. It's monotonously increasing value.
+	 *
+	 * Also, some corner cases, like 'wrap around' is dangerous, but given
+	 * that u64 is 'big enough'. So that shouldn't be a concern.
+	 */
+	u64 visit_gen;
+
 #ifdef HAVE_RT_PUSH_IPI
 	/*
 	 * For IPI pull requests, loop across the rto_mask.
@@ -973,6 +975,7 @@ struct rq {
 	unsigned long		cpu_capacity_orig;
 
 	struct callback_head	*balance_callback;
+	unsigned char		balance_flags;
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
@@ -1003,6 +1006,10 @@ struct rq {
 
 	/* This is used to determine avg_idle's max value */
 	u64			max_idle_balance_cost;
+
+#ifdef CONFIG_HOTPLUG_CPU
+	struct rcuwait		hotplug_wait;
+#endif
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
@@ -1048,6 +1055,12 @@ struct rq {
 	/* Must be inspected within a rcu lock section */
 	struct cpuidle_state	*idle_state;
 #endif
+
+#ifdef CONFIG_SMP
+	unsigned int		nr_pinned;
+#endif
+	unsigned int		push_busy;
+	struct cpu_stop_work	push_work;
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -1075,6 +1088,16 @@ static inline int cpu_of(struct rq *rq)
 #endif
 }
 
+#define MDF_PUSH	0x01
+
+static inline bool is_migration_disabled(struct task_struct *p)
+{
+#ifdef CONFIG_SMP
+	return p->migration_disabled;
+#else
+	return false;
+#endif
+}
 
 #ifdef CONFIG_SCHED_SMT
 extern void __update_idle_core(struct rq *rq);
@@ -1221,6 +1244,9 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
 	rf->clock_update_flags = 0;
 #endif
+#ifdef CONFIG_SMP
+	SCHED_WARN_ON(rq->balance_callback);
+#endif
 }
 
 static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
@@ -1382,6 +1408,9 @@ init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 
 #ifdef CONFIG_SMP
 
+#define BALANCE_WORK	0x01
+#define BALANCE_PUSH	0x02
+
 static inline void
 queue_balance_callback(struct rq *rq,
 		       struct callback_head *head,
@@ -1389,12 +1418,13 @@ queue_balance_callback(struct rq *rq,
 {
 	lockdep_assert_held(&rq->lock);
 
-	if (unlikely(head->next))
+	if (unlikely(head->next || (rq->balance_flags & BALANCE_PUSH)))
 		return;
 
 	head->func = (void (*)(struct callback_head *))func;
 	head->next = rq->balance_callback;
 	rq->balance_callback = head;
+	rq->balance_flags |= BALANCE_WORK;
 }
 
 #define rcu_dereference_check_sched_domain(p) \
@@ -1714,13 +1744,20 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 	return READ_ONCE(p->on_rq) == TASK_ON_RQ_MIGRATING;
 }
 
-/*
- * wake flags
- */
-#define WF_SYNC			0x01		/* Waker goes to sleep after wakeup */
-#define WF_FORK			0x02		/* Child wakeup after fork */
-#define WF_MIGRATED		0x04		/* Internal use, task got migrated */
-#define WF_ON_CPU		0x08		/* Wakee is on_cpu */
+/* Wake flags. The first three directly map to some SD flag value */
+#define WF_EXEC     0x02 /* Wakeup after exec; maps to SD_BALANCE_EXEC */
+#define WF_FORK     0x04 /* Wakeup after fork; maps to SD_BALANCE_FORK */
+#define WF_TTWU     0x08 /* Wakeup;            maps to SD_BALANCE_WAKE */
+
+#define WF_SYNC     0x10 /* Waker goes to sleep after wakeup */
+#define WF_MIGRATED 0x20 /* Internal use, task got migrated */
+#define WF_ON_CPU   0x40 /* Wakee is on_cpu */
+
+#ifdef CONFIG_SMP
+static_assert(WF_EXEC == SD_BALANCE_EXEC);
+static_assert(WF_FORK == SD_BALANCE_FORK);
+static_assert(WF_TTWU == SD_BALANCE_WAKE);
+#endif
 
 /*
  * To aid in avoiding the subversion of "niceness" due to uneven distribution
@@ -1796,16 +1833,19 @@ struct sched_class {
 
 #ifdef CONFIG_SMP
 	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
-	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int sd_flag, int flags);
+	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int flags);
 	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
 
 	void (*task_woken)(struct rq *this_rq, struct task_struct *task);
 
 	void (*set_cpus_allowed)(struct task_struct *p,
-				 const struct cpumask *newmask);
+				 const struct cpumask *newmask,
+				 u32 flags);
 
 	void (*rq_online)(struct rq *rq);
 	void (*rq_offline)(struct rq *rq);
+
+	struct rq *(*find_lock_rq)(struct task_struct *p, struct rq *rq);
 #endif
 
 	void (*task_tick)(struct rq *rq, struct task_struct *p, int queued);
@@ -1833,7 +1873,7 @@ struct sched_class {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	void (*task_change_group)(struct task_struct *p, int type);
 #endif
-} __aligned(STRUCT_ALIGNMENT); /* STRUCT_ALIGN(), vmlinux.lds.h */
+};
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
@@ -1847,6 +1887,20 @@ static inline void set_next_task(struct rq *rq, struct task_struct *next)
 	next->sched_class->set_next_task(rq, next, false);
 }
 
+
+/*
+ * Helper to define a sched_class instance; each one is placed in a separate
+ * section which is ordered by the linker script:
+ *
+ *   include/asm-generic/vmlinux.lds.h
+ *
+ * Also enforce alignment on the instance, not the type, to guarantee layout.
+ */
+#define DEFINE_SCHED_CLASS(name) \
+const struct sched_class name##_sched_class \
+	__aligned(__alignof__(struct sched_class)) \
+	__section("__" #name "_sched_class")
+
 /* Defined in include/asm-generic/vmlinux.lds.h */
 extern struct sched_class __begin_sched_classes[];
 extern struct sched_class __end_sched_classes[];
@@ -1889,13 +1943,35 @@ static inline bool sched_fair_runnable(struct rq *rq)
 extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
 extern struct task_struct *pick_next_task_idle(struct rq *rq);
 
+#define SCA_CHECK		0x01
+#define SCA_MIGRATE_DISABLE	0x02
+#define SCA_MIGRATE_ENABLE	0x04
+
 #ifdef CONFIG_SMP
 
 extern void update_group_capacity(struct sched_domain *sd, int cpu);
 
 extern void trigger_load_balance(struct rq *rq);
 
-extern void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask);
+extern void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags);
+
+static inline struct task_struct *get_push_task(struct rq *rq)
+{
+	struct task_struct *p = rq->curr;
+
+	lockdep_assert_held(&rq->lock);
+
+	if (rq->push_busy)
+		return NULL;
+
+	if (p->nr_cpus_allowed == 1)
+		return NULL;
+
+	rq->push_busy = true;
+	return get_task_struct(p);
+}
+
+extern int push_cpu_stop(void *arg);
 
 #endif
 
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index ceb5b6b12561..55f39125c0e1 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -11,7 +11,7 @@
 
 #ifdef CONFIG_SMP
 static int
-select_task_rq_stop(struct task_struct *p, int cpu, int sd_flag, int flags)
+select_task_rq_stop(struct task_struct *p, int cpu, int flags)
 {
 	return task_cpu(p); /* stop tasks as never migrate */
 }
@@ -109,8 +109,7 @@ static void update_curr_stop(struct rq *rq)
 /*
  * Simple, special scheduling class for the per-CPU stop tasks:
  */
-const struct sched_class stop_sched_class
-	__section("__stop_sched_class") = {
+DEFINE_SCHED_CLASS(stop) = {
 
 	.enqueue_task		= enqueue_task_stop,
 	.dequeue_task		= dequeue_task_stop,
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index dd7770226086..5d3675c7a76b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -211,6 +211,15 @@ unsigned int sysctl_sched_energy_aware = 1;
 DEFINE_MUTEX(sched_energy_mutex);
 bool sched_energy_update;
 
+void rebuild_sched_domains_energy(void)
+{
+	mutex_lock(&sched_energy_mutex);
+	sched_energy_update = true;
+	rebuild_sched_domains();
+	sched_energy_update = false;
+	mutex_unlock(&sched_energy_mutex);
+}
+
 #ifdef CONFIG_PROC_SYSCTL
 int sched_energy_aware_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
@@ -223,13 +232,8 @@ int sched_energy_aware_handler(struct ctl_table *table, int write,
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (!ret && write) {
 		state = static_branch_unlikely(&sched_energy_present);
-		if (state != sysctl_sched_energy_aware) {
-			mutex_lock(&sched_energy_mutex);
-			sched_energy_update = 1;
-			rebuild_sched_domains();
-			sched_energy_update = 0;
-			mutex_unlock(&sched_energy_mutex);
-		}
+		if (state != sysctl_sched_energy_aware)
+			rebuild_sched_domains_energy();
 	}
 
 	return ret;
@@ -324,6 +328,7 @@ static void sched_energy_set(bool has_eas)
  *    3. no SMT is detected.
  *    4. the EM complexity is low enough to keep scheduling overheads low;
  *    5. schedutil is driving the frequency of all CPUs of the rd;
+ *    6. frequency invariance support is present;
  *
  * The complexity of the Energy Model is defined as:
  *
@@ -372,6 +377,14 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
 		goto free;
 	}
 
+	if (!arch_scale_freq_invariant()) {
+		if (sched_debug()) {
+			pr_warn("rd %*pbl: Disabling EAS: frequency-invariant load tracking not yet supported",
+				cpumask_pr_args(cpu_map));
+		}
+		goto free;
+	}
+
 	for_each_cpu(i, cpu_map) {
 		/* Skip already covered CPUs. */
 		if (find_pd(pd, i))
@@ -516,6 +529,7 @@ static int init_rootdomain(struct root_domain *rd)
 	init_irq_work(&rd->rto_push_work, rto_push_irq_work_func);
 #endif
 
+	rd->visit_gen = 0;
 	init_dl_bw(&rd->dl_bw);
 	if (cpudl_init(&rd->cpudl) != 0)
 		goto free_rto_mask;
@@ -674,6 +688,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct sched_domain *tmp;
+	int numa_distance = 0;
 
 	/* Remove the sched domains which do not contribute to scheduling. */
 	for (tmp = sd; tmp; ) {
@@ -705,6 +720,38 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 			sd->child = NULL;
 	}
 
+	for (tmp = sd; tmp; tmp = tmp->parent)
+		numa_distance += !!(tmp->flags & SD_NUMA);
+
+	/*
+	 * FIXME: Diameter >=3 is misrepresented.
+	 *
+	 * Smallest diameter=3 topology is:
+	 *
+	 *   node   0   1   2   3
+	 *     0:  10  20  30  40
+	 *     1:  20  10  20  30
+	 *     2:  30  20  10  20
+	 *     3:  40  30  20  10
+	 *
+	 *   0 --- 1 --- 2 --- 3
+	 *
+	 * NUMA-3	0-3		N/A		N/A		0-3
+	 *  groups:	{0-2},{1-3}					{1-3},{0-2}
+	 *
+	 * NUMA-2	0-2		0-3		0-3		1-3
+	 *  groups:	{0-1},{1-3}	{0-2},{2-3}	{1-3},{0-1}	{2-3},{0-2}
+	 *
+	 * NUMA-1	0-1		0-2		1-3		2-3
+	 *  groups:	{0},{1}		{1},{2},{0}	{2},{3},{1}	{3},{2}
+	 *
+	 * NUMA-0	0		1		2		3
+	 *
+	 * The NUMA-2 groups for nodes 0 and 3 are obviously buggered, as the
+	 * group span isn't a subset of the domain span.
+	 */
+	WARN_ONCE(numa_distance > 2, "Shortest NUMA path spans too many nodes\n");
+
 	sched_domain_debug(sd, cpu);
 
 	rq_attach_root(rq, rd);
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 890b79cf0e7c..971d8acceaec 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -42,11 +42,27 @@ struct cpu_stopper {
 	struct list_head	works;		/* list of pending works */
 
 	struct cpu_stop_work	stop_work;	/* for stop_cpus */
+	unsigned long		caller;
+	cpu_stop_fn_t		fn;
 };
 
 static DEFINE_PER_CPU(struct cpu_stopper, cpu_stopper);
 static bool stop_machine_initialized = false;
 
+void print_stop_info(const char *log_lvl, struct task_struct *task)
+{
+	/*
+	 * If @task is a stopper task, it cannot migrate and task_cpu() is
+	 * stable.
+	 */
+	struct cpu_stopper *stopper = per_cpu_ptr(&cpu_stopper, task_cpu(task));
+
+	if (task != stopper->thread)
+		return;
+
+	printk("%sStopper: %pS <- %pS\n", log_lvl, stopper->fn, (void *)stopper->caller);
+}
+
 /* static data for stop_cpus */
 static DEFINE_MUTEX(stop_cpus_mutex);
 static bool stop_cpus_in_progress;
@@ -123,7 +139,7 @@ static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
 int stop_one_cpu(unsigned int cpu, cpu_stop_fn_t fn, void *arg)
 {
 	struct cpu_stop_done done;
-	struct cpu_stop_work work = { .fn = fn, .arg = arg, .done = &done };
+	struct cpu_stop_work work = { .fn = fn, .arg = arg, .done = &done, .caller = _RET_IP_ };
 
 	cpu_stop_init_done(&done, 1);
 	if (!cpu_stop_queue_work(cpu, &work))
@@ -331,7 +347,8 @@ int stop_two_cpus(unsigned int cpu1, unsigned int cpu2, cpu_stop_fn_t fn, void *
 	work1 = work2 = (struct cpu_stop_work){
 		.fn = multi_cpu_stop,
 		.arg = &msdata,
-		.done = &done
+		.done = &done,
+		.caller = _RET_IP_,
 	};
 
 	cpu_stop_init_done(&done, 2);
@@ -367,7 +384,7 @@ int stop_two_cpus(unsigned int cpu1, unsigned int cpu2, cpu_stop_fn_t fn, void *
 bool stop_one_cpu_nowait(unsigned int cpu, cpu_stop_fn_t fn, void *arg,
 			struct cpu_stop_work *work_buf)
 {
-	*work_buf = (struct cpu_stop_work){ .fn = fn, .arg = arg, };
+	*work_buf = (struct cpu_stop_work){ .fn = fn, .arg = arg, .caller = _RET_IP_, };
 	return cpu_stop_queue_work(cpu, work_buf);
 }
 
@@ -487,6 +504,8 @@ static void cpu_stopper_thread(unsigned int cpu)
 		int ret;
 
 		/* cpu stop callbacks must not sleep, make in_atomic() == T */
+		stopper->caller = work->caller;
+		stopper->fn = fn;
 		preempt_count_inc();
 		ret = fn(arg);
 		if (done) {
@@ -495,6 +514,8 @@ static void cpu_stopper_thread(unsigned int cpu)
 			cpu_stop_signal_done(done);
 		}
 		preempt_count_dec();
+		stopper->fn = NULL;
+		stopper->caller = 0;
 		WARN_ONCE(preempt_count(),
 			  "cpu_stop: %ps(%p) leaked preempt count\n", fn, arg);
 		goto repeat;
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 437935e7a199..c71da2a59e12 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4908,6 +4908,10 @@ static void unbind_workers(int cpu)
 		pool->flags |= POOL_DISASSOCIATED;
 
 		raw_spin_unlock_irq(&pool->lock);
+
+		for_each_pool_worker(worker, pool)
+			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_active_mask) < 0);
+
 		mutex_unlock(&wq_pool_attach_mutex);
 
 		/*
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c789b39ed527..e952f892f047 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -849,9 +849,31 @@ config DEBUG_PER_CPU_MAPS
 
 	  Say N if unsure.
 
+config DEBUG_KMAP_LOCAL
+	bool "Debug kmap_local temporary mappings"
+	depends on DEBUG_KERNEL && KMAP_LOCAL
+	help
+	  This option enables additional error checking for the kmap_local
+	  infrastructure.  Disable for production use.
+
+config ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP
+	bool
+
+config DEBUG_KMAP_LOCAL_FORCE_MAP
+	bool "Enforce kmap_local temporary mappings"
+	depends on DEBUG_KERNEL && ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP
+	select KMAP_LOCAL
+	select DEBUG_KMAP_LOCAL
+	help
+	  This option enforces temporary mappings through the kmap_local
+	  mechanism for non-highmem pages and on non-highmem systems.
+	  Disable this for production systems!
+
 config DEBUG_HIGHMEM
 	bool "Highmem debugging"
 	depends on DEBUG_KERNEL && HIGHMEM
+	select DEBUG_KMAP_LOCAL_FORCE_MAP if ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP
+	select DEBUG_KMAP_LOCAL
 	help
 	  This option enables additional error checking for high memory
 	  systems.  Disable for production systems.
diff --git a/lib/cpumask.c b/lib/cpumask.c
index 85da6ab4fbb5..35924025097b 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -267,3 +267,21 @@ int cpumask_any_and_distribute(const struct cpumask *src1p,
 	return next;
 }
 EXPORT_SYMBOL(cpumask_any_and_distribute);
+
+int cpumask_any_distribute(const struct cpumask *srcp)
+{
+	int next, prev;
+
+	/* NOTE: our first selection will skip 0. */
+	prev = __this_cpu_read(distribute_cpu_mask_prev);
+
+	next = cpumask_next(prev, srcp);
+	if (next >= nr_cpu_ids)
+		next = cpumask_first(srcp);
+
+	if (next < nr_cpu_ids)
+		__this_cpu_write(distribute_cpu_mask_prev, next);
+
+	return next;
+}
+EXPORT_SYMBOL(cpumask_any_distribute);
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index a00ee6eedc7c..f5a33b6f773f 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -12,6 +12,7 @@
 #include <linux/atomic.h>
 #include <linux/kexec.h>
 #include <linux/utsname.h>
+#include <linux/stop_machine.h>
 
 static char dump_stack_arch_desc_str[128];
 
@@ -57,6 +58,7 @@ void dump_stack_print_info(const char *log_lvl)
 		       log_lvl, dump_stack_arch_desc_str);
 
 	print_worker_info(log_lvl, current);
+	print_stop_info(log_lvl, current);
 }
 
 /**
diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 525222e4f409..1c1dbd300325 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -26,6 +26,11 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 	if (current->nr_cpus_allowed == 1)
 		goto out;
 
+#ifdef CONFIG_SMP
+	if (current->migration_disabled)
+		goto out;
+#endif
+
 	/*
 	 * It is valid to assume CPU-locality during early bootup:
 	 */
diff --git a/mm/Kconfig b/mm/Kconfig
index d42423f884a7..a1ccf98b7333 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -872,4 +872,7 @@ config ARCH_HAS_HUGEPD
 config MAPPING_DIRTY_HELPERS
         bool
 
+config KMAP_LOCAL
+	bool
+
 endmenu
diff --git a/mm/highmem.c b/mm/highmem.c
index 1352a27951e3..83f9660f168f 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -31,10 +31,6 @@
 #include <asm/tlbflush.h>
 #include <linux/vmalloc.h>
 
-#if defined(CONFIG_HIGHMEM) || defined(CONFIG_X86_32)
-DEFINE_PER_CPU(int, __kmap_atomic_idx);
-#endif
-
 /*
  * Virtual_count is not a pure "count".
  *  0 means that it is not mapped, and has not been mapped
@@ -108,9 +104,7 @@ static inline wait_queue_head_t *get_pkmap_wait_queue_head(unsigned int color)
 atomic_long_t _totalhigh_pages __read_mostly;
 EXPORT_SYMBOL(_totalhigh_pages);
 
-EXPORT_PER_CPU_SYMBOL(__kmap_atomic_idx);
-
-unsigned int nr_free_highpages (void)
+unsigned int __nr_free_highpages (void)
 {
 	struct zone *zone;
 	unsigned int pages = 0;
@@ -147,7 +141,7 @@ pte_t * pkmap_page_table;
 		do { spin_unlock(&kmap_lock); (void)(flags); } while (0)
 #endif
 
-struct page *kmap_to_page(void *vaddr)
+struct page *__kmap_to_page(void *vaddr)
 {
 	unsigned long addr = (unsigned long)vaddr;
 
@@ -158,7 +152,7 @@ struct page *kmap_to_page(void *vaddr)
 
 	return virt_to_page(addr);
 }
-EXPORT_SYMBOL(kmap_to_page);
+EXPORT_SYMBOL(__kmap_to_page);
 
 static void flush_all_zero_pkmaps(void)
 {
@@ -200,10 +194,7 @@ static void flush_all_zero_pkmaps(void)
 		flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
 }
 
-/**
- * kmap_flush_unused - flush all unused kmap mappings in order to remove stray mappings
- */
-void kmap_flush_unused(void)
+void __kmap_flush_unused(void)
 {
 	lock_kmap();
 	flush_all_zero_pkmaps();
@@ -367,9 +358,260 @@ void kunmap_high(struct page *page)
 	if (need_wakeup)
 		wake_up(pkmap_map_wait);
 }
-
 EXPORT_SYMBOL(kunmap_high);
-#endif	/* CONFIG_HIGHMEM */
+#endif /* CONFIG_HIGHMEM */
+
+#ifdef CONFIG_KMAP_LOCAL
+
+#include <asm/kmap_size.h>
+
+/*
+ * With DEBUG_KMAP_LOCAL the stack depth is doubled and every second
+ * slot is unused which acts as a guard page
+ */
+#ifdef CONFIG_DEBUG_KMAP_LOCAL
+# define KM_INCR	2
+#else
+# define KM_INCR	1
+#endif
+
+static inline int kmap_local_idx_push(void)
+{
+	WARN_ON_ONCE(in_irq() && !irqs_disabled());
+	current->kmap_ctrl.idx += KM_INCR;
+	BUG_ON(current->kmap_ctrl.idx >= KM_MAX_IDX);
+	return current->kmap_ctrl.idx - 1;
+}
+
+static inline int kmap_local_idx(void)
+{
+	return current->kmap_ctrl.idx - 1;
+}
+
+static inline void kmap_local_idx_pop(void)
+{
+	current->kmap_ctrl.idx -= KM_INCR;
+	BUG_ON(current->kmap_ctrl.idx < 0);
+}
+
+#ifndef arch_kmap_local_post_map
+# define arch_kmap_local_post_map(vaddr, pteval)	do { } while (0)
+#endif
+
+#ifndef arch_kmap_local_pre_unmap
+# define arch_kmap_local_pre_unmap(vaddr)		do { } while (0)
+#endif
+
+#ifndef arch_kmap_local_post_unmap
+# define arch_kmap_local_post_unmap(vaddr)		do { } while (0)
+#endif
+
+#ifndef arch_kmap_local_map_idx
+#define arch_kmap_local_map_idx(idx, pfn)	kmap_local_calc_idx(idx)
+#endif
+
+#ifndef arch_kmap_local_unmap_idx
+#define arch_kmap_local_unmap_idx(idx, vaddr)	kmap_local_calc_idx(idx)
+#endif
+
+#ifndef arch_kmap_local_high_get
+static inline void *arch_kmap_local_high_get(struct page *page)
+{
+	return NULL;
+}
+#endif
+
+/* Unmap a local mapping which was obtained by kmap_high_get() */
+static inline bool kmap_high_unmap_local(unsigned long vaddr)
+{
+#ifdef ARCH_NEEDS_KMAP_HIGH_GET
+	if (vaddr >= PKMAP_ADDR(0) && vaddr < PKMAP_ADDR(LAST_PKMAP)) {
+		kunmap_high(pte_page(pkmap_page_table[PKMAP_NR(vaddr)]));
+		return true;
+	}
+#endif
+	return false;
+}
+
+static inline int kmap_local_calc_idx(int idx)
+{
+	return idx + KM_MAX_IDX * smp_processor_id();
+}
+
+static pte_t *__kmap_pte;
+
+static pte_t *kmap_get_pte(void)
+{
+	if (!__kmap_pte)
+		__kmap_pte = virt_to_kpte(__fix_to_virt(FIX_KMAP_BEGIN));
+	return __kmap_pte;
+}
+
+void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot)
+{
+	pte_t pteval, *kmap_pte = kmap_get_pte();
+	unsigned long vaddr;
+	int idx;
+
+	/*
+	 * Disable migration so resulting virtual address is stable
+	 * accross preemption.
+	 */
+	migrate_disable();
+	preempt_disable();
+	idx = arch_kmap_local_map_idx(kmap_local_idx_push(), pfn);
+	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+	BUG_ON(!pte_none(*(kmap_pte - idx)));
+	pteval = pfn_pte(pfn, prot);
+	set_pte_at(&init_mm, vaddr, kmap_pte - idx, pteval);
+	arch_kmap_local_post_map(vaddr, pteval);
+	current->kmap_ctrl.pteval[kmap_local_idx()] = pteval;
+	preempt_enable();
+
+	return (void *)vaddr;
+}
+EXPORT_SYMBOL_GPL(__kmap_local_pfn_prot);
+
+void *__kmap_local_page_prot(struct page *page, pgprot_t prot)
+{
+	void *kmap;
+
+	/*
+	 * To broaden the usage of the actual kmap_local() machinery always map
+	 * pages when debugging is enabled and the architecture has no problems
+	 * with alias mappings.
+	 */
+	if (!IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) && !PageHighMem(page))
+		return page_address(page);
+
+	/* Try kmap_high_get() if architecture has it enabled */
+	kmap = arch_kmap_local_high_get(page);
+	if (kmap)
+		return kmap;
+
+	return __kmap_local_pfn_prot(page_to_pfn(page), prot);
+}
+EXPORT_SYMBOL(__kmap_local_page_prot);
+
+void kunmap_local_indexed(void *vaddr)
+{
+	unsigned long addr = (unsigned long) vaddr & PAGE_MASK;
+	pte_t *kmap_pte = kmap_get_pte();
+	int idx;
+
+	if (addr < __fix_to_virt(FIX_KMAP_END) ||
+	    addr > __fix_to_virt(FIX_KMAP_BEGIN)) {
+		if (IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP)) {
+			/* This _should_ never happen! See above. */
+			WARN_ON_ONCE(1);
+			return;
+		}
+		/*
+		 * Handle mappings which were obtained by kmap_high_get()
+		 * first as the virtual address of such mappings is below
+		 * PAGE_OFFSET. Warn for all other addresses which are in
+		 * the user space part of the virtual address space.
+		 */
+		if (!kmap_high_unmap_local(addr))
+			WARN_ON_ONCE(addr < PAGE_OFFSET);
+		return;
+	}
+
+	preempt_disable();
+	idx = arch_kmap_local_unmap_idx(kmap_local_idx(), addr);
+	WARN_ON_ONCE(addr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
+
+	arch_kmap_local_pre_unmap(addr);
+	pte_clear(&init_mm, addr, kmap_pte - idx);
+	arch_kmap_local_post_unmap(addr);
+	current->kmap_ctrl.pteval[kmap_local_idx()] = __pte(0);
+	kmap_local_idx_pop();
+	preempt_enable();
+	migrate_enable();
+}
+EXPORT_SYMBOL(kunmap_local_indexed);
+
+/*
+ * Invoked before switch_to(). This is safe even when during or after
+ * clearing the maps an interrupt which needs a kmap_local happens because
+ * the task::kmap_ctrl.idx is not modified by the unmapping code so a
+ * nested kmap_local will use the next unused index and restore the index
+ * on unmap. The already cleared kmaps of the outgoing task are irrelevant
+ * because the interrupt context does not know about them. The same applies
+ * when scheduling back in for an interrupt which happens before the
+ * restore is complete.
+ */
+void __kmap_local_sched_out(void)
+{
+	struct task_struct *tsk = current;
+	pte_t *kmap_pte = kmap_get_pte();
+	int i;
+
+	/* Clear kmaps */
+	for (i = 0; i < tsk->kmap_ctrl.idx; i++) {
+		pte_t pteval = tsk->kmap_ctrl.pteval[i];
+		unsigned long addr;
+		int idx;
+
+		/* With debug all even slots are unmapped and act as guard */
+		if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !(i & 0x01)) {
+			WARN_ON_ONCE(!pte_none(pteval));
+			continue;
+		}
+		if (WARN_ON_ONCE(pte_none(pteval)))
+			continue;
+
+		/*
+		 * This is a horrible hack for XTENSA to calculate the
+		 * coloured PTE index. Uses the PFN encoded into the pteval
+		 * and the map index calculation because the actual mapped
+		 * virtual address is not stored in task::kmap_ctrl.
+		 * For any sane architecture this is optimized out.
+		 */
+		idx = arch_kmap_local_map_idx(i, pte_pfn(pteval));
+
+		addr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+		arch_kmap_local_pre_unmap(addr);
+		pte_clear(&init_mm, addr, kmap_pte - idx);
+		arch_kmap_local_post_unmap(addr);
+	}
+}
+
+void __kmap_local_sched_in(void)
+{
+	struct task_struct *tsk = current;
+	pte_t *kmap_pte = kmap_get_pte();
+	int i;
+
+	/* Restore kmaps */
+	for (i = 0; i < tsk->kmap_ctrl.idx; i++) {
+		pte_t pteval = tsk->kmap_ctrl.pteval[i];
+		unsigned long addr;
+		int idx;
+
+		/* With debug all even slots are unmapped and act as guard */
+		if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !(i & 0x01)) {
+			WARN_ON_ONCE(!pte_none(pteval));
+			continue;
+		}
+		if (WARN_ON_ONCE(pte_none(pteval)))
+			continue;
+
+		/* See comment in __kmap_local_sched_out() */
+		idx = arch_kmap_local_map_idx(i, pte_pfn(pteval));
+		addr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+		set_pte_at(&init_mm, addr, kmap_pte - idx, pteval);
+		arch_kmap_local_post_map(addr, pteval);
+	}
+}
+
+void kmap_local_fork(struct task_struct *tsk)
+{
+	if (WARN_ON_ONCE(tsk->kmap_ctrl.idx))
+		memset(&tsk->kmap_ctrl, 0, sizeof(tsk->kmap_ctrl));
+}
+
+#endif
 
 #if defined(HASHED_PAGE_VIRTUAL)
 

