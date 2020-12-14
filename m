Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D6B2DA180
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503302AbgLNU1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:27:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54124 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503188AbgLNU0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:26:33 -0500
Date:   Mon, 14 Dec 2020 20:22:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607977531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=uV223PaH92kdkr3CfIzc60U67fRVYrL09gWfsw21WAk=;
        b=mp/kj9arGHkYxKKvOSSSzexGDSIUJJZLVzs6q/T9GkXqdrNqsPbJpq2lCKcQ3VGMOVydXc
        mYh8DZvNEKbelM9xxM9DWd3uR4ctY+f31HTHwjQROVMkEYD+ivNMp6Wk6VLO9VBhamec37
        dSjnMNzgOJR+ZYMqXrLcKd+r6i36tDzZRvVFA6akOxgwSDQYVIl42+YVFiuKDQiC5Bjl7J
        U+t2U7wtrRvGHxVU/SZNtfRDRuLlS0rVe9PTlX4fvtngkyDf5wNXfRzX9G+Zz3B6taypCI
        ZncZKgzW4iKMY5Ef4ii+ThF0fKUNhYa6KFGaMpxACWwrDmWodIuzJeimgdw6nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607977531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=uV223PaH92kdkr3CfIzc60U67fRVYrL09gWfsw21WAk=;
        b=LXikcqyKR0EB+2eSPP5GkMf08cnOPMLaN++70EBuHvJkEUCDRi/+ykusdGXe0rTCVIrSpQ
        dCrRoMWkMCDkWzCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/core for v5.11-rc1
References: <160797732939.10793.9152151866806316627.tglx@nanos>
Message-ID: <160797733789.10793.18065892325435860673.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2020-12-14

up to:  5b78f2dc3153: sched/fair: Trivial correction of the newidle_balance() comment


Scheduler updates:

 - migrate_disable/enable() support which originates from the RT tree and
   is now a prerequisite for the new preemptible kmap_local() API which aims
   to replace kmap_atomic().

 - A fair amount of topology and NUMA related improvements

 - Improvements for the frequency invariant calculations

 - Enhanced robustness for the global CPU priority tracking and decision
   making

 - The usual small fixes and enhancements all over the place


Thanks,

	tglx

------------------>
Barry Song (2):
      Documentation: scheduler: fix information on arch SD flags, sched_domain and sched_debug
      sched/fair: Trivial correction of the newidle_balance() comment

Daniel Jordan (1):
      cpuset: fix race between hotplug work and later CPU offline

Dietmar Eggemann (3):
      sched/cpupri: Remove pri_to_cpu[CPUPRI_IDLE]
      sched/cpupri: Remove pri_to_cpu[1]
      sched/uclamp: Allow to reset a task uclamp constraint value

Giovanni Gherdovich (2):
      x86, sched: Use midpoint of max_boost and max_P for frequency invariance on AMD EPYC
      x86: Print ratio freq_max/freq_base used in frequency invariance calculations

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

Mauro Carvalho Chehab (1):
      sched: Fix kernel-doc markup

Mel Gorman (5):
      sched/numa: Rename nr_running and break out the magic number
      sched: Avoid unnecessary calculation of load imbalance at clone time
      sched/numa: Allow a floating imbalance between NUMA nodes
      sched: Limit the amount of NUMA imbalance that can exist at fork time
      sched/fair: Clear SMT siblings after determining the core is not idle

Nathan Fontenot (1):
      x86, sched: Calculate frequency invariance for AMD systems

Peng Liu (2):
      sched/deadline: Optimize sched_dl_global_validate()
      sched/deadline: Fix sched_dl_global_validate()

Peng Wang (1):
      sched/fair: Reorder throttle_cfs_rq() path

Peter Zijlstra (21):
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
      irq_work: Cleanup
      smp: Cleanup smp_call_function*()
      irq_work: Optimize irq_work_single()

Tal Zussman (1):
      sched/core: Fix typos in comments

Thomas Gleixner (5):
      sched: Reenable interrupts in do_sched_yield()
      sched/core: Wait for tasks being pushed away on hotplug
      sched/hotplug: Consolidate task migration on CPU unplug
      sched/core: Make migrate disable and CPU hotplug cooperative
      sched: Make migrate_disable/enable() independent of RT

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


 Documentation/scheduler/sched-domains.rst       |   26 +-
 arch/arm64/kernel/topology.c                    |   10 +
 arch/mips/kernel/process.c                      |    5 +-
 arch/mips/kernel/smp.c                          |   25 +-
 arch/s390/pci/pci_irq.c                         |    4 +-
 arch/x86/include/asm/topology.h                 |    5 +
 arch/x86/kernel/cpuid.c                         |    7 +-
 arch/x86/kernel/smpboot.c                       |   79 +-
 arch/x86/lib/msr-smp.c                          |    7 +-
 block/blk-mq.c                                  |    4 +-
 drivers/acpi/cppc_acpi.c                        |    7 +
 drivers/cpuidle/coupled.c                       |    3 +-
 drivers/gpu/drm/i915/i915_request.c             |    4 +-
 drivers/net/ethernet/cavium/liquidio/lio_core.c |    9 +-
 fs/proc/array.c                                 |    4 +-
 include/linux/cpuhotplug.h                      |    1 +
 include/linux/cpumask.h                         |    6 +
 include/linux/irq_work.h                        |   33 +-
 include/linux/irqflags.h                        |    8 +-
 include/linux/kernel.h                          |   21 +-
 include/linux/preempt.h                         |   83 +-
 include/linux/sched.h                           |    5 +
 include/linux/sched/hotplug.h                   |    2 +
 include/linux/sched/mm.h                        |    5 +
 include/linux/sched/topology.h                  |    8 +
 include/linux/smp.h                             |   19 +-
 include/linux/stop_machine.h                    |    5 +
 include/uapi/linux/sched/types.h                |    2 +
 kernel/bpf/stackmap.c                           |    2 +-
 kernel/cgroup/cpuset.c                          |   33 +-
 kernel/cpu.c                                    |    9 +-
 kernel/debug/debug_core.c                       |    6 +-
 kernel/exit.c                                   |   16 +-
 kernel/irq_work.c                               |   45 +-
 kernel/kthread.c                                |   21 +
 kernel/printk/printk.c                          |    6 +-
 kernel/rcu/tree.c                               |    3 +-
 kernel/sched/core.c                             | 1104 ++++++++++++++++++-----
 kernel/sched/cpudeadline.c                      |    4 +-
 kernel/sched/cpufreq_schedutil.c                |    9 +-
 kernel/sched/cpupri.c                           |   52 +-
 kernel/sched/cpupri.h                           |    8 +-
 kernel/sched/deadline.c                         |  101 ++-
 kernel/sched/fair.c                             |  121 ++-
 kernel/sched/idle.c                             |    7 +-
 kernel/sched/membarrier.c                       |  147 ++-
 kernel/sched/rt.c                               |   99 +-
 kernel/sched/sched.h                            |  150 ++-
 kernel/sched/stop_task.c                        |    5 +-
 kernel/sched/topology.c                         |   61 +-
 kernel/smp.c                                    |   52 +-
 kernel/stop_machine.c                           |   27 +-
 kernel/time/tick-sched.c                        |    6 +-
 kernel/trace/bpf_trace.c                        |    2 +-
 kernel/workqueue.c                              |    4 +
 lib/cpumask.c                                   |   18 +
 lib/dump_stack.c                                |    2 +
 lib/smp_processor_id.c                          |    5 +
 net/core/dev.c                                  |    3 +-
 59 files changed, 1906 insertions(+), 619 deletions(-)

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
 
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 75ebd8d7bd5d..d7e288f3a1e7 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -702,7 +702,6 @@ unsigned long arch_align_stack(unsigned long sp)
 	return sp & ALMASK;
 }
 
-static DEFINE_PER_CPU(call_single_data_t, backtrace_csd);
 static struct cpumask backtrace_csd_busy;
 
 static void handle_backtrace(void *info)
@@ -711,6 +710,9 @@ static void handle_backtrace(void *info)
 	cpumask_clear_cpu(smp_processor_id(), &backtrace_csd_busy);
 }
 
+static DEFINE_PER_CPU(call_single_data_t, backtrace_csd) =
+	CSD_INIT(handle_backtrace, NULL);
+
 static void raise_backtrace(cpumask_t *mask)
 {
 	call_single_data_t *csd;
@@ -730,7 +732,6 @@ static void raise_backtrace(cpumask_t *mask)
 		}
 
 		csd = &per_cpu(backtrace_csd, cpu);
-		csd->func = handle_backtrace;
 		smp_call_function_single_async(cpu, csd);
 	}
 }
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 48d84d5fcc36..74b9102fd06e 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -687,36 +687,23 @@ EXPORT_SYMBOL(flush_tlb_one);
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 
-static DEFINE_PER_CPU(call_single_data_t, tick_broadcast_csd);
-
-void tick_broadcast(const struct cpumask *mask)
-{
-	call_single_data_t *csd;
-	int cpu;
-
-	for_each_cpu(cpu, mask) {
-		csd = &per_cpu(tick_broadcast_csd, cpu);
-		smp_call_function_single_async(cpu, csd);
-	}
-}
-
 static void tick_broadcast_callee(void *info)
 {
 	tick_receive_broadcast();
 }
 
-static int __init tick_broadcast_init(void)
+static DEFINE_PER_CPU(call_single_data_t, tick_broadcast_csd) =
+	CSD_INIT(tick_broadcast_callee, NULL);
+
+void tick_broadcast(const struct cpumask *mask)
 {
 	call_single_data_t *csd;
 	int cpu;
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+	for_each_cpu(cpu, mask) {
 		csd = &per_cpu(tick_broadcast_csd, cpu);
-		csd->func = tick_broadcast_callee;
+		smp_call_function_single_async(cpu, csd);
 	}
-
-	return 0;
 }
-early_initcall(tick_broadcast_init);
 
 #endif /* CONFIG_GENERIC_CLOCKEVENTS_BROADCAST */
diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 743f257cf2cb..1311b6f9d6dd 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -178,9 +178,7 @@ static void zpci_handle_fallback_irq(void)
 		if (atomic_inc_return(&cpu_data->scheduled) > 1)
 			continue;
 
-		cpu_data->csd.func = zpci_handle_remote_irq;
-		cpu_data->csd.info = &cpu_data->scheduled;
-		cpu_data->csd.flags = 0;
+		INIT_CSD(&cpu_data->csd, zpci_handle_remote_irq, &cpu_data->scheduled);
 		smp_call_function_single_async(cpu, &cpu_data->csd);
 	}
 }
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index f4234575f3fd..488a8e848754 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -218,4 +218,9 @@ static inline void arch_set_max_freq_ratio(bool turbo_disabled)
 }
 #endif
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+void init_freq_invariance_cppc(void);
+#define init_freq_invariance_cppc init_freq_invariance_cppc
+#endif
+
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/arch/x86/kernel/cpuid.c b/arch/x86/kernel/cpuid.c
index 3492aa36bf09..6f7b8cc1bc9f 100644
--- a/arch/x86/kernel/cpuid.c
+++ b/arch/x86/kernel/cpuid.c
@@ -74,10 +74,9 @@ static ssize_t cpuid_read(struct file *file, char __user *buf,
 
 	init_completion(&cmd.done);
 	for (; count; count -= 16) {
-		call_single_data_t csd = {
-			.func = cpuid_smp_cpuid,
-			.info = &cmd,
-		};
+		call_single_data_t csd;
+
+		INIT_CSD(&csd, cpuid_smp_cpuid, &cmd);
 
 		cmd.regs.eax = pos;
 		cmd.regs.ecx = pos >> 32;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index de776b2e6046..3577bb756d64 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -82,6 +82,10 @@
 #include <asm/hw_irq.h>
 #include <asm/stackprotector.h>
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+#include <acpi/cppc_acpi.h>
+#endif
+
 /* representing HT siblings of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
@@ -148,7 +152,7 @@ static inline void smpboot_restore_warm_reset_vector(void)
 	*((volatile u32 *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) = 0;
 }
 
-static void init_freq_invariance(bool secondary);
+static void init_freq_invariance(bool secondary, bool cppc_ready);
 
 /*
  * Report back to the Boot Processor during boot time or to the caller processor
@@ -186,7 +190,7 @@ static void smp_callin(void)
 	 */
 	set_cpu_sibling_map(raw_smp_processor_id());
 
-	init_freq_invariance(true);
+	init_freq_invariance(true, false);
 
 	/*
 	 * Get our bogomips.
@@ -1340,7 +1344,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	set_sched_topology(x86_topology);
 
 	set_cpu_sibling_map(0);
-	init_freq_invariance(false);
+	init_freq_invariance(false, false);
 	smp_sanity_check();
 
 	switch (apic_intr_mode) {
@@ -2027,6 +2031,48 @@ static bool intel_set_max_freq_ratio(void)
 	return true;
 }
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+static bool amd_set_max_freq_ratio(void)
+{
+	struct cppc_perf_caps perf_caps;
+	u64 highest_perf, nominal_perf;
+	u64 perf_ratio;
+	int rc;
+
+	rc = cppc_get_perf_caps(0, &perf_caps);
+	if (rc) {
+		pr_debug("Could not retrieve perf counters (%d)\n", rc);
+		return false;
+	}
+
+	highest_perf = perf_caps.highest_perf;
+	nominal_perf = perf_caps.nominal_perf;
+
+	if (!highest_perf || !nominal_perf) {
+		pr_debug("Could not retrieve highest or nominal performance\n");
+		return false;
+	}
+
+	perf_ratio = div_u64(highest_perf * SCHED_CAPACITY_SCALE, nominal_perf);
+	/* midpoint between max_boost and max_P */
+	perf_ratio = (perf_ratio + SCHED_CAPACITY_SCALE) >> 1;
+	if (!perf_ratio) {
+		pr_debug("Non-zero highest/nominal perf values led to a 0 ratio\n");
+		return false;
+	}
+
+	arch_turbo_freq_ratio = perf_ratio;
+	arch_set_max_freq_ratio(false);
+
+	return true;
+}
+#else
+static bool amd_set_max_freq_ratio(void)
+{
+	return false;
+}
+#endif
+
 static void init_counter_refs(void)
 {
 	u64 aperf, mperf;
@@ -2038,7 +2084,7 @@ static void init_counter_refs(void)
 	this_cpu_write(arch_prev_mperf, mperf);
 }
 
-static void init_freq_invariance(bool secondary)
+static void init_freq_invariance(bool secondary, bool cppc_ready)
 {
 	bool ret = false;
 
@@ -2054,15 +2100,38 @@ static void init_freq_invariance(bool secondary)
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 		ret = intel_set_max_freq_ratio();
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+		if (!cppc_ready) {
+			return;
+		}
+		ret = amd_set_max_freq_ratio();
+	}
 
 	if (ret) {
 		init_counter_refs();
 		static_branch_enable(&arch_scale_freq_key);
+		pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
 	} else {
 		pr_debug("Couldn't determine max cpu frequency, necessary for scale-invariant accounting.\n");
 	}
 }
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+static DEFINE_MUTEX(freq_invariance_lock);
+
+void init_freq_invariance_cppc(void)
+{
+	static bool secondary;
+
+	mutex_lock(&freq_invariance_lock);
+
+	init_freq_invariance(secondary, true);
+	secondary = true;
+
+	mutex_unlock(&freq_invariance_lock);
+}
+#endif
+
 static void disable_freq_invariance_workfn(struct work_struct *work)
 {
 	static_branch_disable(&arch_scale_freq_key);
@@ -2112,7 +2181,7 @@ void arch_scale_freq_tick(void)
 	schedule_work(&disable_freq_invariance_work);
 }
 #else
-static inline void init_freq_invariance(bool secondary)
+static inline void init_freq_invariance(bool secondary, bool cppc_ready)
 {
 }
 #endif /* CONFIG_X86_64 */
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index fee8b9c0520c..75a0915b0d01 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -169,12 +169,11 @@ static void __wrmsr_safe_on_cpu(void *info)
 int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
 {
 	struct msr_info_completion rv;
-	call_single_data_t csd = {
-		.func	= __rdmsr_safe_on_cpu,
-		.info	= &rv,
-	};
+	call_single_data_t csd;
 	int err;
 
+	INIT_CSD(&csd, __rdmsr_safe_on_cpu, &rv);
+
 	memset(&rv, 0, sizeof(rv));
 	init_completion(&rv.done);
 	rv.msr.msr_no = msr_no;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 55bcee5dc032..d35b3c0c876a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -671,9 +671,7 @@ bool blk_mq_complete_request_remote(struct request *rq)
 		return false;
 
 	if (blk_mq_complete_need_ipi(rq)) {
-		rq->csd.func = __blk_mq_complete_request_remote;
-		rq->csd.info = rq;
-		rq->csd.flags = 0;
+		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
 		smp_call_function_single_async(rq->mq_ctx->cpu, &rq->csd);
 	} else {
 		if (rq->q->nr_hw_queues > 1)
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 7a99b19bb893..a852dc4927f7 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -39,6 +39,7 @@
 #include <linux/ktime.h>
 #include <linux/rwsem.h>
 #include <linux/wait.h>
+#include <linux/topology.h>
 
 #include <acpi/cppc_acpi.h>
 
@@ -688,6 +689,10 @@ static bool is_cppc_supported(int revision, int num_ent)
  *	}
  */
 
+#ifndef init_freq_invariance_cppc
+static inline void init_freq_invariance_cppc(void) { }
+#endif
+
 /**
  * acpi_cppc_processor_probe - Search for per CPU _CPC objects.
  * @pr: Ptr to acpi_processor containing this CPU's logical ID.
@@ -850,6 +855,8 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 		goto out_free;
 	}
 
+	init_freq_invariance_cppc();
+
 	kfree(output.pointer);
 	return 0;
 
diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index 04003b90dc49..74068742cef3 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -674,8 +674,7 @@ int cpuidle_coupled_register_device(struct cpuidle_device *dev)
 	coupled->refcnt++;
 
 	csd = &per_cpu(cpuidle_coupled_poke_cb, dev->cpu);
-	csd->func = cpuidle_coupled_handle_poke;
-	csd->info = (void *)(unsigned long)dev->cpu;
+	INIT_CSD(csd, cpuidle_coupled_handle_poke, (void *)(unsigned long)dev->cpu);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 0e813819b041..5385b081a376 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -197,7 +197,7 @@ __notify_execute_cb(struct i915_request *rq, bool (*fn)(struct irq_work *wrk))
 
 	llist_for_each_entry_safe(cb, cn,
 				  llist_del_all(&rq->execute_cb),
-				  work.llnode)
+				  work.node.llist)
 		fn(&cb->work);
 }
 
@@ -460,7 +460,7 @@ __await_execution(struct i915_request *rq,
 	 * callback first, then checking the ACTIVE bit, we serialise with
 	 * the completed/retired request.
 	 */
-	if (llist_add(&cb->work.llnode, &signal->execute_cb)) {
+	if (llist_add(&cb->work.node.llist, &signal->execute_cb)) {
 		if (i915_request_is_active(signal) ||
 		    __request_in_flight(signal))
 			__notify_execute_cb_imm(signal);
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_core.c b/drivers/net/ethernet/cavium/liquidio/lio_core.c
index 9ef172976b35..37d064193f0f 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_core.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_core.c
@@ -729,13 +729,8 @@ static void liquidio_napi_drv_callback(void *arg)
 	    droq->cpu_id == this_cpu) {
 		napi_schedule_irqoff(&droq->napi);
 	} else {
-		call_single_data_t *csd = &droq->csd;
-
-		csd->func = napi_schedule_wrapper;
-		csd->info = &droq->napi;
-		csd->flags = 0;
-
-		smp_call_function_single_async(droq->cpu_id, csd);
+		INIT_CSD(&droq->csd, napi_schedule_wrapper, &droq->napi);
+		smp_call_function_single_async(droq->cpu_id, &droq->csd);
 	}
 }
 
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
diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 30823780c192..ec2a47a81e42 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -14,28 +14,37 @@
  */
 
 struct irq_work {
-	union {
-		struct __call_single_node node;
-		struct {
-			struct llist_node llnode;
-			atomic_t flags;
-		};
-	};
+	struct __call_single_node node;
 	void (*func)(struct irq_work *);
 };
 
+#define __IRQ_WORK_INIT(_func, _flags) (struct irq_work){	\
+	.node = { .u_flags = (_flags), },			\
+	.func = (_func),					\
+}
+
+#define IRQ_WORK_INIT(_func) __IRQ_WORK_INIT(_func, 0)
+#define IRQ_WORK_INIT_LAZY(_func) __IRQ_WORK_INIT(_func, IRQ_WORK_LAZY)
+#define IRQ_WORK_INIT_HARD(_func) __IRQ_WORK_INIT(_func, IRQ_WORK_HARD_IRQ)
+
+#define DEFINE_IRQ_WORK(name, _f)				\
+	struct irq_work name = IRQ_WORK_INIT(_f)
+
 static inline
 void init_irq_work(struct irq_work *work, void (*func)(struct irq_work *))
 {
-	atomic_set(&work->flags, 0);
-	work->func = func;
+	*work = IRQ_WORK_INIT(func);
 }
 
-#define DEFINE_IRQ_WORK(name, _f) struct irq_work name = {	\
-		.flags = ATOMIC_INIT(0),			\
-		.func  = (_f)					\
+static inline bool irq_work_is_pending(struct irq_work *work)
+{
+	return atomic_read(&work->node.a_flags) & IRQ_WORK_PENDING;
 }
 
+static inline bool irq_work_is_busy(struct irq_work *work)
+{
+	return atomic_read(&work->node.a_flags) & IRQ_WORK_BUSY;
+}
 
 bool irq_work_queue(struct irq_work *work);
 bool irq_work_queue_on(struct irq_work *work, int cpu);
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 3ed4e8771b64..8de0e1373de7 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -107,14 +107,14 @@ do {						\
 		  current->irq_config = 0;			\
 	  } while (0)
 
-# define lockdep_irq_work_enter(__work)					\
+# define lockdep_irq_work_enter(_flags)					\
 	  do {								\
-		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
+		  if (!((_flags) & IRQ_WORK_HARD_IRQ))			\
 			current->irq_config = 1;			\
 	  } while (0)
-# define lockdep_irq_work_exit(__work)					\
+# define lockdep_irq_work_exit(_flags)					\
 	  do {								\
-		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
+		  if (!((_flags) & IRQ_WORK_HARD_IRQ))			\
 			current->irq_config = 0;			\
 	  } while (0)
 
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
index 76cd21fa5501..942b87f80cc7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -722,6 +722,11 @@ struct task_struct {
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
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 9f13966d3d92..70c6f6284dcf 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -21,24 +21,23 @@ typedef bool (*smp_cond_func_t)(int cpu, void *info);
  * structure shares (partial) layout with struct irq_work
  */
 struct __call_single_data {
-	union {
-		struct __call_single_node node;
-		struct {
-			struct llist_node llist;
-			unsigned int flags;
-#ifdef CONFIG_64BIT
-			u16 src, dst;
-#endif
-		};
-	};
+	struct __call_single_node node;
 	smp_call_func_t func;
 	void *info;
 };
 
+#define CSD_INIT(_func, _info) \
+	(struct __call_single_data){ .func = (_func), .info = (_info), }
+
 /* Use __aligned() to avoid to use 2 cache lines for 1 csd */
 typedef struct __call_single_data call_single_data_t
 	__aligned(sizeof(struct __call_single_data));
 
+#define INIT_CSD(_csd, _func, _info)		\
+do {						\
+	*(_csd) = CSD_INIT((_func), (_info));	\
+} while (0)
+
 /*
  * Enqueue a llist_node on the call_single_queue; be very careful, read
  * flush_smp_call_function_queue() in detail.
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
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 06065fa27124..599041cd0c8a 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -298,7 +298,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 	if (irqs_disabled()) {
 		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
 			work = this_cpu_ptr(&up_read_work);
-			if (atomic_read(&work->irq_work.flags) & IRQ_WORK_BUSY) {
+			if (irq_work_is_busy(&work->irq_work)) {
 				/* cannot queue more up_read, fallback */
 				irq_work_busy = true;
 			}
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
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 1e75a8923a8d..af6e8b4fb359 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -225,8 +225,6 @@ NOKPROBE_SYMBOL(kgdb_skipexception);
  * Default (weak) implementation for kgdb_roundup_cpus
  */
 
-static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd);
-
 void __weak kgdb_call_nmi_hook(void *ignored)
 {
 	/*
@@ -241,6 +239,9 @@ void __weak kgdb_call_nmi_hook(void *ignored)
 }
 NOKPROBE_SYMBOL(kgdb_call_nmi_hook);
 
+static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd) =
+	CSD_INIT(kgdb_call_nmi_hook, NULL);
+
 void __weak kgdb_roundup_cpus(void)
 {
 	call_single_data_t *csd;
@@ -267,7 +268,6 @@ void __weak kgdb_roundup_cpus(void)
 			continue;
 		kgdb_info[cpu].rounding_up = true;
 
-		csd->func = kgdb_call_nmi_hook;
 		ret = smp_call_function_single_async(cpu, csd);
 		if (ret)
 			kgdb_info[cpu].rounding_up = false;
diff --git a/kernel/exit.c b/kernel/exit.c
index 1f236ed375f8..3594291a8542 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -478,10 +478,24 @@ static void exit_mm(void)
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
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index eca83965b631..e8da1e71583a 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -31,10 +31,10 @@ static bool irq_work_claim(struct irq_work *work)
 {
 	int oflags;
 
-	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED | CSD_TYPE_IRQ_WORK, &work->flags);
+	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED | CSD_TYPE_IRQ_WORK, &work->node.a_flags);
 	/*
 	 * If the work is already pending, no need to raise the IPI.
-	 * The pairing atomic_fetch_andnot() in irq_work_run() makes sure
+	 * The pairing smp_mb() in irq_work_single() makes sure
 	 * everything we did before is visible.
 	 */
 	if (oflags & IRQ_WORK_PENDING)
@@ -53,12 +53,12 @@ void __weak arch_irq_work_raise(void)
 static void __irq_work_queue_local(struct irq_work *work)
 {
 	/* If the work is "lazy", handle it from next tick if any */
-	if (atomic_read(&work->flags) & IRQ_WORK_LAZY) {
-		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
+	if (atomic_read(&work->node.a_flags) & IRQ_WORK_LAZY) {
+		if (llist_add(&work->node.llist, this_cpu_ptr(&lazy_list)) &&
 		    tick_nohz_tick_stopped())
 			arch_irq_work_raise();
 	} else {
-		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
+		if (llist_add(&work->node.llist, this_cpu_ptr(&raised_list)))
 			arch_irq_work_raise();
 	}
 }
@@ -102,7 +102,7 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 	if (cpu != smp_processor_id()) {
 		/* Arch remote IPI send/receive backend aren't NMI safe */
 		WARN_ON_ONCE(in_nmi());
-		__smp_call_single_queue(cpu, &work->llnode);
+		__smp_call_single_queue(cpu, &work->node.llist);
 	} else {
 		__irq_work_queue_local(work);
 	}
@@ -136,23 +136,28 @@ void irq_work_single(void *arg)
 	int flags;
 
 	/*
-	 * Clear the PENDING bit, after this point the @work
-	 * can be re-used.
-	 * Make it immediately visible so that other CPUs trying
-	 * to claim that work don't rely on us to handle their data
-	 * while we are in the middle of the func.
+	 * Clear the PENDING bit, after this point the @work can be re-used.
+	 * The PENDING bit acts as a lock, and we own it, so we can clear it
+	 * without atomic ops.
 	 */
-	flags = atomic_fetch_andnot(IRQ_WORK_PENDING, &work->flags);
+	flags = atomic_read(&work->node.a_flags);
+	flags &= ~IRQ_WORK_PENDING;
+	atomic_set(&work->node.a_flags, flags);
+
+	/*
+	 * See irq_work_claim().
+	 */
+	smp_mb();
 
-	lockdep_irq_work_enter(work);
+	lockdep_irq_work_enter(flags);
 	work->func(work);
-	lockdep_irq_work_exit(work);
+	lockdep_irq_work_exit(flags);
+
 	/*
-	 * Clear the BUSY bit and return to the free state if
-	 * no-one else claimed it meanwhile.
+	 * Clear the BUSY bit, if set, and return to the free state if no-one
+	 * else claimed it meanwhile.
 	 */
-	flags &= ~IRQ_WORK_PENDING;
-	(void)atomic_cmpxchg(&work->flags, flags, flags & ~IRQ_WORK_BUSY);
+	(void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
 }
 
 static void irq_work_run_list(struct llist_head *list)
@@ -166,7 +171,7 @@ static void irq_work_run_list(struct llist_head *list)
 		return;
 
 	llnode = llist_del_all(list);
-	llist_for_each_entry_safe(work, tmp, llnode, llnode)
+	llist_for_each_entry_safe(work, tmp, llnode, node.llist)
 		irq_work_single(work);
 }
 
@@ -198,7 +203,7 @@ void irq_work_sync(struct irq_work *work)
 {
 	lockdep_assert_irqs_enabled();
 
-	while (atomic_read(&work->flags) & IRQ_WORK_BUSY)
+	while (irq_work_is_busy(work))
 		cpu_relax();
 }
 EXPORT_SYMBOL_GPL(irq_work_sync);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 933a625621b8..e6aa66551241 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1249,6 +1249,7 @@ void kthread_use_mm(struct mm_struct *mm)
 		tsk->active_mm = mm;
 	}
 	tsk->mm = mm;
+	membarrier_update_current_mm(mm);
 	switch_mm_irqs_off(active_mm, mm, tsk);
 	local_irq_enable();
 	task_unlock(tsk);
@@ -1256,8 +1257,19 @@ void kthread_use_mm(struct mm_struct *mm)
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
@@ -1277,9 +1289,18 @@ void kthread_unuse_mm(struct mm_struct *mm)
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
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fe64a49344bf..9ef23d4b07c7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3025,10 +3025,8 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
 		wake_up_interruptible(&log_wait);
 }
 
-static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) = {
-	.func = wake_up_klogd_work_func,
-	.flags = ATOMIC_INIT(IRQ_WORK_LAZY),
-};
+static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) =
+	IRQ_WORK_INIT_LAZY(wake_up_klogd_work_func);
 
 void wake_up_klogd(void)
 {
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bd04b09b84b3..ed4941f0bd59 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1311,8 +1311,6 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 		if (IS_ENABLED(CONFIG_IRQ_WORK) &&
 		    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
 		    (rnp->ffmask & rdp->grpmask)) {
-			init_irq_work(&rdp->rcu_iw, rcu_iw_handler);
-			atomic_set(&rdp->rcu_iw.flags, IRQ_WORK_HARD_IRQ);
 			rdp->rcu_iw_pending = true;
 			rdp->rcu_iw_gp_seq = rnp->gp_seq;
 			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
@@ -3964,6 +3962,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->cpu_no_qs.b.norm = true;
 	rdp->core_needs_qs = false;
 	rdp->rcu_iw_pending = false;
+	rdp->rcu_iw = IRQ_WORK_INIT_HARD(rcu_iw_handler);
 	rdp->rcu_iw_gp_seq = rdp->gp_seq - 1;
 	trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuonl"));
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e7e453492cff..7af80c3fce12 100644
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
@@ -320,14 +320,6 @@ void update_rq_clock(struct rq *rq)
 	update_rq_clock_task(rq, delta);
 }
 
-static inline void
-rq_csd_init(struct rq *rq, call_single_data_t *csd, smp_call_func_t func)
-{
-	csd->flags = 0;
-	csd->func = func;
-	csd->info = rq;
-}
-
 #ifdef CONFIG_SCHED_HRTICK
 /*
  * Use HR-timers to deliver accurate preemption points.
@@ -428,7 +420,7 @@ void hrtick_start(struct rq *rq, u64 delay)
 static void hrtick_rq_init(struct rq *rq)
 {
 #ifdef CONFIG_SMP
-	rq_csd_init(rq, &rq->hrtick_csd, __hrtick_start);
+	INIT_CSD(&rq->hrtick_csd, __hrtick_start, rq);
 #endif
 	hrtimer_init(&rq->hrtick_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	rq->hrtick_timer.function = hrtick;
@@ -518,7 +510,7 @@ static bool __wake_q_add(struct wake_q_head *head, struct task_struct *task)
 
 	/*
 	 * Atomically grab the task, if ->wake_q is !nil already it means
-	 * its already queued (either by us or someone else) and will get the
+	 * it's already queued (either by us or someone else) and will get the
 	 * wakeup due to that.
 	 *
 	 * In order to ensure that a pending wakeup will observe our pending
@@ -769,7 +761,7 @@ bool sched_can_stop_tick(struct rq *rq)
 		return false;
 
 	/*
-	 * If there are more than one RR tasks, we need the tick to effect the
+	 * If there are more than one RR tasks, we need the tick to affect the
 	 * actual RR behaviour.
 	 */
 	if (rq->rt.rr_nr_running) {
@@ -1187,14 +1179,14 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
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
@@ -1413,17 +1405,24 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
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
@@ -1438,20 +1437,41 @@ static int uclamp_validate(struct task_struct *p,
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
@@ -1459,21 +1479,25 @@ static void __setscheduler_uclamp(struct task_struct *p,
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
@@ -1696,6 +1720,76 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 
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
@@ -1705,7 +1799,7 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 		return false;
 
-	if (is_per_cpu_kthread(p))
+	if (is_per_cpu_kthread(p) || is_migration_disabled(p))
 		return cpu_online(cpu);
 
 	return cpu_active(cpu);
@@ -1750,8 +1844,16 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
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
@@ -1783,16 +1885,19 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
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
@@ -1802,21 +1907,137 @@ static int migration_cpu_stop(void *data)
 
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
 
-	local_irq_enable();
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
+
+	put_task_struct(p);
 	return 0;
 }
 
@@ -1824,18 +2045,39 @@ static int migration_cpu_stop(void *data)
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
@@ -1851,7 +2093,7 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 	if (running)
 		put_prev_task(rq, p);
 
-	p->sched_class->set_cpus_allowed(p, new_mask);
+	p->sched_class->set_cpus_allowed(p, new_mask, flags);
 
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
@@ -1859,6 +2101,208 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
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
@@ -1869,7 +2313,8 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
  * call is not atomic; no spinlocks may be held.
  */
 static int __set_cpus_allowed_ptr(struct task_struct *p,
-				  const struct cpumask *new_mask, bool check)
+				  const struct cpumask *new_mask,
+				  u32 flags)
 {
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
 	unsigned int dest_cpu;
@@ -1880,9 +2325,14 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
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
@@ -1891,13 +2341,22 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
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
@@ -1910,7 +2369,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		goto out;
 	}
 
-	do_set_cpus_allowed(p, new_mask);
+	__do_set_cpus_allowed(p, new_mask, flags);
 
 	if (p->flags & PF_KTHREAD) {
 		/*
@@ -1922,23 +2381,8 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
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
 
@@ -1947,7 +2391,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 
 int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
 {
-	return __set_cpus_allowed_ptr(p, new_mask, false);
+	return __set_cpus_allowed_ptr(p, new_mask, 0);
 }
 EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
 
@@ -1988,6 +2432,8 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 	 * Clearly, migrating tasks to offline CPUs is a fairly daft thing.
 	 */
 	WARN_ON_ONCE(!cpu_online(new_cpu));
+
+	WARN_ON_ONCE(is_migration_disabled(p));
 #endif
 
 	trace_sched_migrate_task(p, new_cpu);
@@ -2318,6 +2764,12 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
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
@@ -2348,12 +2800,12 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
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
 
@@ -2375,6 +2827,7 @@ int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
 
 void sched_set_stop_task(int cpu, struct task_struct *stop)
 {
+	static struct lock_class_key stop_pi_lock;
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
 	struct task_struct *old_stop = cpu_rq(cpu)->stop;
 
@@ -2390,6 +2843,20 @@ void sched_set_stop_task(int cpu, struct task_struct *stop)
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
@@ -2403,15 +2870,23 @@ void sched_set_stop_task(int cpu, struct task_struct *stop)
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
@@ -2465,7 +2940,7 @@ static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken) {
 		/*
-		 * Our task @p is fully woken up and running; so its safe to
+		 * Our task @p is fully woken up and running; so it's safe to
 		 * drop the rq->lock, hereafter rq is only used for statistics.
 		 */
 		rq_unpin_lock(rq, rf);
@@ -2952,7 +3427,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 
 	/*
 	 * If the owning (remote) CPU is still in the middle of schedule() with
-	 * this task as prev, wait until its done referencing the task.
+	 * this task as prev, wait until it's done referencing the task.
 	 *
 	 * Pairs with the smp_store_release() in finish_task().
 	 *
@@ -2961,7 +3436,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 */
 	smp_cond_load_acquire(&p->on_cpu, !VAL);
 
-	cpu = select_task_rq(p, p->wake_cpu, SD_BALANCE_WAKE, wake_flags);
+	cpu = select_task_rq(p, p->wake_cpu, wake_flags | WF_TTWU);
 	if (task_cpu(p) != cpu) {
 		if (p->in_iowait) {
 			delayacct_blkio_end(p);
@@ -3103,6 +3578,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	init_numa_balancing(clone_flags, p);
 #ifdef CONFIG_SMP
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
+	p->migration_pending = NULL;
 #endif
 }
 
@@ -3349,7 +3825,7 @@ void wake_up_new_task(struct task_struct *p)
 	 */
 	p->recent_used_cpu = task_cpu(p);
 	rseq_migrate(p);
-	__set_task_cpu(p, select_task_rq(p, task_cpu(p), SD_BALANCE_FORK, 0));
+	__set_task_cpu(p, select_task_rq(p, task_cpu(p), WF_FORK));
 #endif
 	rq = __task_rq_lock(p, &rf);
 	update_rq_clock(rq);
@@ -3361,7 +3837,7 @@ void wake_up_new_task(struct task_struct *p)
 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken) {
 		/*
-		 * Nothing relies on rq->lock after this, so its fine to
+		 * Nothing relies on rq->lock after this, so it's fine to
 		 * drop it.
 		 */
 		rq_unpin_lock(rq, &rf);
@@ -3490,6 +3966,90 @@ static inline void finish_task(struct task_struct *prev)
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
@@ -3515,6 +4075,7 @@ static inline void finish_lock_switch(struct rq *rq)
 	 * prev into current:
 	 */
 	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
+	balance_switch(rq);
 	raw_spin_unlock_irq(&rq->lock);
 }
 
@@ -3656,43 +4217,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
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
@@ -3712,7 +4236,6 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	 */
 
 	rq = finish_task_switch(prev);
-	balance_callback(rq);
 	preempt_enable();
 
 	if (current->set_child_tid)
@@ -3841,7 +4364,7 @@ unsigned long nr_iowait_cpu(int cpu)
 }
 
 /*
- * IO-wait accounting, and how its mostly bollocks (on SMP).
+ * IO-wait accounting, and how it's mostly bollocks (on SMP).
  *
  * The idea behind IO-wait account is to account the idle time that we could
  * have spend running if it were not for IO. That is, if we were to improve the
@@ -3893,7 +4416,7 @@ void sched_exec(void)
 	int dest_cpu;
 
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
-	dest_cpu = p->sched_class->select_task_rq(p, task_cpu(p), SD_BALANCE_EXEC, 0);
+	dest_cpu = p->sched_class->select_task_rq(p, task_cpu(p), WF_EXEC);
 	if (dest_cpu == smp_processor_id())
 		goto unlock;
 
@@ -4336,7 +4859,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	/*
 	 * Optimization: we know that if all tasks are in the fair class we can
 	 * call that function directly, but only if the @prev task wasn't of a
-	 * higher scheduling class, because otherwise those loose the
+	 * higher scheduling class, because otherwise those lose the
 	 * opportunity to pull in more work from other CPUs.
 	 */
 	if (likely(prev->sched_class <= &fair_sched_class &&
@@ -4520,6 +5043,7 @@ static void __sched notrace __schedule(bool preempt)
 		 */
 		++*switch_count;
 
+		migrate_disable_switch(rq, prev);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
 		trace_sched_switch(preempt, prev, next);
@@ -4528,10 +5052,11 @@ static void __sched notrace __schedule(bool preempt)
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
@@ -4857,7 +5382,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	 * right. rt_mutex_slowunlock()+rt_mutex_postunlock() work together to
 	 * ensure a task is de-boosted (pi_task is set to NULL) before the
 	 * task is allowed to run again (and can exit). This ensures the pointer
-	 * points to a blocked task -- which guaratees the task is present.
+	 * points to a blocked task -- which guarantees the task is present.
 	 */
 	p->pi_top_task = pi_task;
 
@@ -4943,9 +5468,11 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
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
@@ -4974,7 +5501,7 @@ void set_user_nice(struct task_struct *p, long nice)
 	/*
 	 * The RT priorities are set via sched_setscheduler(), but we still
 	 * allow the 'normal' nice value to be set - but as expected
-	 * it wont have any effect on scheduling until the task is
+	 * it won't have any effect on scheduling until the task is
 	 * SCHED_DEADLINE, SCHED_FIFO or SCHED_RR:
 	 */
 	if (task_has_dl_policy(p) || task_has_rt_policy(p)) {
@@ -5219,6 +5746,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	int retval, oldprio, oldpolicy = -1, queued, running;
 	int new_effective_prio, policy = attr->sched_policy;
 	const struct sched_class *prev_class;
+	struct callback_head *head;
 	struct rq_flags rf;
 	int reset_on_fork;
 	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
@@ -5457,6 +5985,7 @@ static int __sched_setscheduler(struct task_struct *p,
 
 	/* Avoid rq from going away on us: */
 	preempt_disable();
+	head = splice_balance_callbacks(rq);
 	task_rq_unlock(rq, p, &rf);
 
 	if (pi) {
@@ -5465,7 +5994,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	}
 
 	/* Run balance callbacks after we've adjusted the PI chain: */
-	balance_callback(rq);
+	balance_callbacks(rq, head);
 	preempt_enable();
 
 	return 0;
@@ -5960,7 +6489,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	}
 #endif
 again:
-	retval = __set_cpus_allowed_ptr(p, new_mask, true);
+	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
 
 	if (!retval) {
 		cpuset_cpus_allowed(p, cpus_allowed);
@@ -6082,14 +6611,6 @@ SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
 	return ret;
 }
 
-/**
- * sys_sched_yield - yield the current processor to other threads.
- *
- * This function yields the current CPU to other tasks. If there are no
- * other threads running on this CPU then this function will return.
- *
- * Return: 0.
- */
 static void do_sched_yield(void)
 {
 	struct rq_flags rf;
@@ -6100,17 +6621,21 @@ static void do_sched_yield(void)
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
 }
 
+/**
+ * sys_sched_yield - yield the current processor to other threads.
+ *
+ * This function yields the current CPU to other tasks. If there are no
+ * other threads running on this CPU then this function will return.
+ *
+ * Return: 0.
+ */
 SYSCALL_DEFINE0(sched_yield)
 {
 	do_sched_yield();
@@ -6165,7 +6690,7 @@ EXPORT_SYMBOL(__cond_resched_lock);
  *
  * The scheduler is at all times free to pick the calling task as the most
  * eligible task to run, if removing the yield() call from your code breaks
- * it, its already broken.
+ * it, it's already broken.
  *
  * Typical broken usage is:
  *
@@ -6453,6 +6978,7 @@ void sched_show_task(struct task_struct *p)
 		(unsigned long)task_thread_info(p)->flags);
 
 	print_worker_info(KERN_INFO, p);
+	print_stop_info(KERN_INFO, p);
 	show_stack(p, NULL, KERN_INFO);
 	put_task_stack(p);
 }
@@ -6538,12 +7064,12 @@ void init_idle(struct task_struct *idle, int cpu)
 
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
@@ -6694,119 +7220,126 @@ void idle_task_exit(void)
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
+
+static inline void balance_push(struct rq *rq)
+{
+}
 
-	rq->stop = stop;
+static inline void balance_push_set(int cpu, bool on)
+{
+}
+
+static inline void balance_hotplug_wait(void)
+{
 }
+
 #endif /* CONFIG_HOTPLUG_CPU */
 
 void set_rq_online(struct rq *rq)
@@ -6892,6 +7425,8 @@ int sched_cpu_activate(unsigned int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	struct rq_flags rf;
 
+	balance_push_set(cpu, false);
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going up, increment the number of cores with SMT present.
@@ -6927,6 +7462,8 @@ int sched_cpu_activate(unsigned int cpu)
 
 int sched_cpu_deactivate(unsigned int cpu)
 {
+	struct rq *rq = cpu_rq(cpu);
+	struct rq_flags rf;
 	int ret;
 
 	set_cpu_active(cpu, false);
@@ -6939,6 +7476,16 @@ int sched_cpu_deactivate(unsigned int cpu)
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
@@ -6952,6 +7499,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 
 	ret = cpuset_cpu_inactive(cpu);
 	if (ret) {
+		balance_push_set(cpu, false);
 		set_cpu_active(cpu, true);
 		return ret;
 	}
@@ -6975,6 +7523,41 @@ int sched_cpu_starting(unsigned int cpu)
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
@@ -6984,12 +7567,7 @@ int sched_cpu_dying(unsigned int cpu)
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
@@ -7194,7 +7772,10 @@ void __init sched_init(void)
 		rq->last_blocked_load_update_tick = jiffies;
 		atomic_set(&rq->nohz_flags, 0);
 
-		rq_csd_init(rq, &rq->nohz_csd, nohz_csd_func);
+		INIT_CSD(&rq->nohz_csd, nohz_csd_func, rq);
+#endif
+#ifdef CONFIG_HOTPLUG_CPU
+		rcuwait_init(&rq->hotplug_wait);
 #endif
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
@@ -7333,6 +7914,39 @@ void __cant_sleep(const char *file, int line, int preempt_offset)
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
@@ -7666,7 +8280,7 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
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
index 97d318b0cd0c..d90cad7a374f 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -899,16 +899,9 @@ struct cpufreq_governor *cpufreq_default_governor(void)
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
index 1d3c97268ec0..75686c6d4436 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -119,6 +119,17 @@ static inline unsigned long dl_bw_capacity(int i)
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
@@ -134,6 +145,11 @@ static inline unsigned long dl_bw_capacity(int i)
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
@@ -565,7 +581,7 @@ static int push_dl_task(struct rq *rq);
 
 static inline bool need_pull_dl_task(struct rq *rq, struct task_struct *prev)
 {
-	return dl_task(prev);
+	return rq->online && dl_task(prev);
 }
 
 static DEFINE_PER_CPU(struct callback_head, dl_push_head);
@@ -1397,6 +1413,8 @@ static void inc_dl_deadline(struct dl_rq *dl_rq, u64 deadline)
 
 	if (dl_rq->earliest_dl.curr == 0 ||
 	    dl_time_before(deadline, dl_rq->earliest_dl.curr)) {
+		if (dl_rq->earliest_dl.curr == 0)
+			cpupri_set(&rq->rd->cpupri, rq->cpu, CPUPRI_HIGHER);
 		dl_rq->earliest_dl.curr = deadline;
 		cpudl_set(&rq->rd->cpudl, rq->cpu, deadline);
 	}
@@ -1414,6 +1432,7 @@ static void dec_dl_deadline(struct dl_rq *dl_rq, u64 deadline)
 		dl_rq->earliest_dl.curr = 0;
 		dl_rq->earliest_dl.next = 0;
 		cpudl_clear(&rq->rd->cpudl, rq->cpu);
+		cpupri_set(&rq->rd->cpupri, rq->cpu, rq->rt.highest_prio.curr);
 	} else {
 		struct rb_node *leftmost = dl_rq->root.rb_leftmost;
 		struct sched_dl_entity *entry;
@@ -1670,13 +1689,13 @@ static void yield_task_dl(struct rq *rq)
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
@@ -1918,7 +1937,7 @@ static void task_fork_dl(struct task_struct *p)
 static int pick_dl_task(struct rq *rq, struct task_struct *p, int cpu)
 {
 	if (!task_running(rq, p) &&
-	    cpumask_test_cpu(cpu, p->cpus_ptr))
+	    cpumask_test_cpu(cpu, &p->cpus_mask))
 		return 1;
 	return 0;
 }
@@ -2008,8 +2027,8 @@ static int find_later_rq(struct task_struct *task)
 				return this_cpu;
 			}
 
-			best_cpu = cpumask_first_and(later_mask,
-							sched_domain_span(sd));
+			best_cpu = cpumask_any_and_distribute(later_mask,
+							      sched_domain_span(sd));
 			/*
 			 * Last chance: if a CPU being in both later_mask
 			 * and current sd span is valid, that becomes our
@@ -2031,7 +2050,7 @@ static int find_later_rq(struct task_struct *task)
 	if (this_cpu != -1)
 		return this_cpu;
 
-	cpu = cpumask_any(later_mask);
+	cpu = cpumask_any_distribute(later_mask);
 	if (cpu < nr_cpu_ids)
 		return cpu;
 
@@ -2068,7 +2087,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 		/* Retry if something changed. */
 		if (double_lock_balance(rq, later_rq)) {
 			if (unlikely(task_rq(task) != rq ||
-				     !cpumask_test_cpu(later_rq->cpu, task->cpus_ptr) ||
+				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
 				     task_running(rq, task) ||
 				     !dl_task(task) ||
 				     !task_on_rq_queued(task))) {
@@ -2135,6 +2154,9 @@ static int push_dl_task(struct rq *rq)
 		return 0;
 
 retry:
+	if (is_migration_disabled(next_task))
+		return 0;
+
 	if (WARN_ON(next_task == rq->curr))
 		return 0;
 
@@ -2212,7 +2234,7 @@ static void push_dl_tasks(struct rq *rq)
 static void pull_dl_task(struct rq *this_rq)
 {
 	int this_cpu = this_rq->cpu, cpu;
-	struct task_struct *p;
+	struct task_struct *p, *push_task;
 	bool resched = false;
 	struct rq *src_rq;
 	u64 dmin = LONG_MAX;
@@ -2242,6 +2264,7 @@ static void pull_dl_task(struct rq *this_rq)
 			continue;
 
 		/* Might drop this_rq->lock */
+		push_task = NULL;
 		double_lock_balance(this_rq, src_rq);
 
 		/*
@@ -2273,17 +2296,27 @@ static void pull_dl_task(struct rq *this_rq)
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
@@ -2307,7 +2340,8 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
 }
 
 static void set_cpus_allowed_dl(struct task_struct *p,
-				const struct cpumask *new_mask)
+				const struct cpumask *new_mask,
+				u32 flags)
 {
 	struct root_domain *src_rd;
 	struct rq *rq;
@@ -2336,7 +2370,7 @@ static void set_cpus_allowed_dl(struct task_struct *p,
 		raw_spin_unlock(&src_dl_b->lock);
 	}
 
-	set_cpus_allowed_common(p, new_mask);
+	set_cpus_allowed_common(p, new_mask, flags);
 }
 
 /* Assumes rq->lock is held */
@@ -2509,8 +2543,8 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 	}
 }
 
-const struct sched_class dl_sched_class
-	__section("__dl_sched_class") = {
+DEFINE_SCHED_CLASS(dl) = {
+
 	.enqueue_task		= enqueue_task_dl,
 	.dequeue_task		= dequeue_task_dl,
 	.yield_task		= yield_task_dl,
@@ -2529,6 +2563,7 @@ const struct sched_class dl_sched_class
 	.rq_online              = rq_online_dl,
 	.rq_offline             = rq_offline_dl,
 	.task_woken		= task_woken_dl,
+	.find_lock_rq		= find_lock_later_rq,
 #endif
 
 	.task_tick		= task_tick_dl,
@@ -2541,33 +2576,39 @@ const struct sched_class dl_sched_class
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
@@ -2593,6 +2634,7 @@ static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq)
 void sched_dl_do_global(void)
 {
 	u64 new_bw = -1;
+	u64 gen = ++dl_generation;
 	struct dl_bw *dl_b;
 	int cpu;
 	unsigned long flags;
@@ -2603,11 +2645,14 @@ void sched_dl_do_global(void)
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
index ae7ceba8fd4f..04a3ce20da67 100644
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
@@ -1550,7 +1559,8 @@ struct task_numa_env {
 static unsigned long cpu_load(struct rq *rq);
 static unsigned long cpu_runnable(struct rq *rq);
 static unsigned long cpu_util(int cpu);
-static inline long adjust_numa_imbalance(int imbalance, int nr_running);
+static inline long adjust_numa_imbalance(int imbalance,
+					int dst_running, int dst_weight);
 
 static inline enum
 numa_type numa_classify(unsigned int imbalance_pct,
@@ -1930,7 +1940,8 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 		src_running = env->src_stats.nr_running - 1;
 		dst_running = env->dst_stats.nr_running + 1;
 		imbalance = max(0, dst_running - src_running);
-		imbalance = adjust_numa_imbalance(imbalance, dst_running);
+		imbalance = adjust_numa_imbalance(imbalance, dst_running,
+							env->dst_stats.weight);
 
 		/* Use idle CPU if there is no imbalance */
 		if (!imbalance) {
@@ -4779,25 +4790,37 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
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
 
+		update_load_avg(qcfs_rq, se, 0);
+		se_update_runnable(se);
+
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
@@ -5105,9 +5128,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 		return;
 
 	distribute_cfs_runtime(cfs_b);
-
-	raw_spin_lock_irqsave(&cfs_b->lock, flags);
-	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 }
 
 /*
@@ -5805,6 +5825,9 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	if (sync && cpu_rq(this_cpu)->nr_running == 1)
 		return this_cpu;
 
+	if (available_idle_cpu(prev_cpu))
+		return prev_cpu;
+
 	return nr_cpumask_bits;
 }
 
@@ -6063,10 +6086,11 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 				break;
 			}
 		}
-		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
 
 		if (idle)
 			return core;
+
+		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
 	}
 
 	/*
@@ -6307,7 +6331,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 }
 
 /**
- * Amount of capacity of a CPU that is (estimated to be) used by CFS tasks
+ * cpu_util - Estimates the amount of capacity of a CPU used by CFS tasks.
  * @cpu: the CPU to get the utilization of
  *
  * The unit of the return value must be the one of capacity so we can compare
@@ -6683,7 +6707,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 /*
  * select_task_rq_fair: Select target runqueue for the waking task in domains
- * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
+ * that have the relevant SD flag set. In practice, this is SD_BALANCE_WAKE,
  * SD_BALANCE_FORK, or SD_BALANCE_EXEC.
  *
  * Balances load by selecting the idlest CPU in the idlest group, or under
@@ -6694,15 +6718,17 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
@@ -6739,9 +6765,8 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	if (unlikely(sd)) {
 		/* Slow path */
 		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
-	} else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
+	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
-
 		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
 
 		if (want_affine)
@@ -8757,6 +8782,16 @@ static bool update_pick_idlest(struct sched_group *idlest,
 	return true;
 }
 
+/*
+ * Allow a NUMA imbalance if busy CPUs is less than 25% of the domain.
+ * This is an approximation as the number of running tasks may not be
+ * related to the number of busy CPUs due to sched_setaffinity.
+ */
+static inline bool allow_numa_imbalance(int dst_running, int dst_weight)
+{
+	return (dst_running < (dst_weight >> 2));
+}
+
 /*
  * find_idlest_group() finds and returns the least busy CPU group within the
  * domain.
@@ -8775,9 +8810,6 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			.group_type = group_overloaded,
 	};
 
-	imbalance = scale_load_down(NICE_0_LOAD) *
-				(sd->imbalance_pct-100) / 100;
-
 	do {
 		int local_group;
 
@@ -8831,6 +8863,11 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 	switch (local_sgs.group_type) {
 	case group_overloaded:
 	case group_fully_busy:
+
+		/* Calculate allowed imbalance based on load */
+		imbalance = scale_load_down(NICE_0_LOAD) *
+				(sd->imbalance_pct-100) / 100;
+
 		/*
 		 * When comparing groups across NUMA domains, it's possible for
 		 * the local domain to be very lightly loaded relative to the
@@ -8887,7 +8924,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			 * a real need of migration, periodic load balance will
 			 * take care of it.
 			 */
-			if (local_sgs.idle_cpus)
+			if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->span_weight))
 				return NULL;
 		}
 
@@ -8989,16 +9026,19 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	}
 }
 
-static inline long adjust_numa_imbalance(int imbalance, int nr_running)
+#define NUMA_IMBALANCE_MIN 2
+
+static inline long adjust_numa_imbalance(int imbalance,
+				int dst_running, int dst_weight)
 {
-	unsigned int imbalance_min;
+	if (!allow_numa_imbalance(dst_running, dst_weight))
+		return imbalance;
 
 	/*
 	 * Allow a small imbalance based on a simple pair of communicating
-	 * tasks that remain local when the source domain is almost idle.
+	 * tasks that remain local when the destination is lightly loaded.
 	 */
-	imbalance_min = 2;
-	if (nr_running <= imbalance_min)
+	if (imbalance <= NUMA_IMBALANCE_MIN)
 		return 0;
 
 	return imbalance;
@@ -9101,9 +9141,10 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		}
 
 		/* Consider allowing a small imbalance between NUMA groups */
-		if (env->sd->flags & SD_NUMA)
+		if (env->sd->flags & SD_NUMA) {
 			env->imbalance = adjust_numa_imbalance(env->imbalance,
-						busiest->sum_nr_running);
+				busiest->sum_nr_running, busiest->group_weight);
+		}
 
 		return;
 	}
@@ -10068,6 +10109,10 @@ static inline int find_new_ilb(void)
 
 	for_each_cpu_and(ilb, nohz.idle_cpus_mask,
 			      housekeeping_cpumask(HK_FLAG_MISC)) {
+
+		if (ilb == smp_processor_id())
+			continue;
+
 		if (idle_cpu(ilb))
 			return ilb;
 	}
@@ -10505,7 +10550,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
 #endif /* CONFIG_NO_HZ_COMMON */
 
 /*
- * idle_balance is called by schedule() if this_cpu is about to become
+ * newidle_balance is called by schedule() if this_cpu is about to become
  * idle. Attempts to pull tasks from other CPUs.
  *
  * Returns:
@@ -11179,8 +11224,8 @@ static unsigned int get_rr_interval_fair(struct rq *rq, struct task_struct *task
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
diff --git a/kernel/smp.c b/kernel/smp.c
index 4d17501433be..1b6070bf97bb 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -27,7 +27,7 @@
 #include "smpboot.h"
 #include "sched/smp.h"
 
-#define CSD_TYPE(_csd)	((_csd)->flags & CSD_FLAG_TYPE_MASK)
+#define CSD_TYPE(_csd)	((_csd)->node.u_flags & CSD_FLAG_TYPE_MASK)
 
 struct call_function_data {
 	call_single_data_t	__percpu *csd;
@@ -130,7 +130,7 @@ static __always_inline int csd_lock_wait_getcpu(call_single_data_t *csd)
 
 	csd_type = CSD_TYPE(csd);
 	if (csd_type == CSD_TYPE_ASYNC || csd_type == CSD_TYPE_SYNC)
-		return csd->dst; /* Other CSD_TYPE_ values might not have ->dst. */
+		return csd->node.dst; /* Other CSD_TYPE_ values might not have ->dst. */
 	return -1;
 }
 
@@ -146,7 +146,7 @@ static __always_inline bool csd_lock_wait_toolong(call_single_data_t *csd, u64 t
 	bool firsttime;
 	u64 ts2, ts_delta;
 	call_single_data_t *cpu_cur_csd;
-	unsigned int flags = READ_ONCE(csd->flags);
+	unsigned int flags = READ_ONCE(csd->node.u_flags);
 
 	if (!(flags & CSD_FLAG_LOCK)) {
 		if (!unlikely(*bug_id))
@@ -224,14 +224,14 @@ static void csd_lock_record(call_single_data_t *csd)
 
 static __always_inline void csd_lock_wait(call_single_data_t *csd)
 {
-	smp_cond_load_acquire(&csd->flags, !(VAL & CSD_FLAG_LOCK));
+	smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK));
 }
 #endif
 
 static __always_inline void csd_lock(call_single_data_t *csd)
 {
 	csd_lock_wait(csd);
-	csd->flags |= CSD_FLAG_LOCK;
+	csd->node.u_flags |= CSD_FLAG_LOCK;
 
 	/*
 	 * prevent CPU from reordering the above assignment
@@ -243,12 +243,12 @@ static __always_inline void csd_lock(call_single_data_t *csd)
 
 static __always_inline void csd_unlock(call_single_data_t *csd)
 {
-	WARN_ON(!(csd->flags & CSD_FLAG_LOCK));
+	WARN_ON(!(csd->node.u_flags & CSD_FLAG_LOCK));
 
 	/*
 	 * ensure we're all done before releasing data:
 	 */
-	smp_store_release(&csd->flags, 0);
+	smp_store_release(&csd->node.u_flags, 0);
 }
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
@@ -300,7 +300,7 @@ static int generic_exec_single(int cpu, call_single_data_t *csd)
 		return -ENXIO;
 	}
 
-	__smp_call_single_queue(cpu, &csd->llist);
+	__smp_call_single_queue(cpu, &csd->node.llist);
 
 	return 0;
 }
@@ -353,7 +353,7 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 		 * We don't have to use the _safe() variant here
 		 * because we are not invoking the IPI handlers yet.
 		 */
-		llist_for_each_entry(csd, entry, llist) {
+		llist_for_each_entry(csd, entry, node.llist) {
 			switch (CSD_TYPE(csd)) {
 			case CSD_TYPE_ASYNC:
 			case CSD_TYPE_SYNC:
@@ -378,16 +378,16 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 	 * First; run all SYNC callbacks, people are waiting for us.
 	 */
 	prev = NULL;
-	llist_for_each_entry_safe(csd, csd_next, entry, llist) {
+	llist_for_each_entry_safe(csd, csd_next, entry, node.llist) {
 		/* Do we wait until *after* callback? */
 		if (CSD_TYPE(csd) == CSD_TYPE_SYNC) {
 			smp_call_func_t func = csd->func;
 			void *info = csd->info;
 
 			if (prev) {
-				prev->next = &csd_next->llist;
+				prev->next = &csd_next->node.llist;
 			} else {
-				entry = &csd_next->llist;
+				entry = &csd_next->node.llist;
 			}
 
 			csd_lock_record(csd);
@@ -395,7 +395,7 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 			csd_unlock(csd);
 			csd_lock_record(NULL);
 		} else {
-			prev = &csd->llist;
+			prev = &csd->node.llist;
 		}
 	}
 
@@ -406,14 +406,14 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 	 * Second; run all !SYNC callbacks.
 	 */
 	prev = NULL;
-	llist_for_each_entry_safe(csd, csd_next, entry, llist) {
+	llist_for_each_entry_safe(csd, csd_next, entry, node.llist) {
 		int type = CSD_TYPE(csd);
 
 		if (type != CSD_TYPE_TTWU) {
 			if (prev) {
-				prev->next = &csd_next->llist;
+				prev->next = &csd_next->node.llist;
 			} else {
-				entry = &csd_next->llist;
+				entry = &csd_next->node.llist;
 			}
 
 			if (type == CSD_TYPE_ASYNC) {
@@ -429,7 +429,7 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 			}
 
 		} else {
-			prev = &csd->llist;
+			prev = &csd->node.llist;
 		}
 	}
 
@@ -465,7 +465,7 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 {
 	call_single_data_t *csd;
 	call_single_data_t csd_stack = {
-		.flags = CSD_FLAG_LOCK | CSD_TYPE_SYNC,
+		.node = { .u_flags = CSD_FLAG_LOCK | CSD_TYPE_SYNC, },
 	};
 	int this_cpu;
 	int err;
@@ -502,8 +502,8 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 	csd->func = func;
 	csd->info = info;
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
-	csd->src = smp_processor_id();
-	csd->dst = cpu;
+	csd->node.src = smp_processor_id();
+	csd->node.dst = cpu;
 #endif
 
 	err = generic_exec_single(cpu, csd);
@@ -544,12 +544,12 @@ int smp_call_function_single_async(int cpu, call_single_data_t *csd)
 
 	preempt_disable();
 
-	if (csd->flags & CSD_FLAG_LOCK) {
+	if (csd->node.u_flags & CSD_FLAG_LOCK) {
 		err = -EBUSY;
 		goto out;
 	}
 
-	csd->flags = CSD_FLAG_LOCK;
+	csd->node.u_flags = CSD_FLAG_LOCK;
 	smp_wmb();
 
 	err = generic_exec_single(cpu, csd);
@@ -667,14 +667,14 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 
 		csd_lock(csd);
 		if (wait)
-			csd->flags |= CSD_TYPE_SYNC;
+			csd->node.u_flags |= CSD_TYPE_SYNC;
 		csd->func = func;
 		csd->info = info;
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
-		csd->src = smp_processor_id();
-		csd->dst = cpu;
+		csd->node.src = smp_processor_id();
+		csd->node.dst = cpu;
 #endif
-		if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
+		if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu)))
 			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
 	}
 
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
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 81632cd5e3b7..1b734070f028 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -243,10 +243,8 @@ static void nohz_full_kick_func(struct irq_work *work)
 	/* Empty, the tick restart happens on tick_nohz_irq_exit() */
 }
 
-static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) = {
-	.func = nohz_full_kick_func,
-	.flags = ATOMIC_INIT(IRQ_WORK_HARD_IRQ),
-};
+static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) =
+	IRQ_WORK_INIT_HARD(nohz_full_kick_func);
 
 /*
  * Kick this CPU if it's full dynticks in order to force it to
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 048c655315f1..818cf8ad6f76 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1096,7 +1096,7 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type)
 			return -EINVAL;
 
 		work = this_cpu_ptr(&send_signal_work);
-		if (atomic_read(&work->irq_work.flags) & IRQ_WORK_BUSY)
+		if (irq_work_is_busy(&work->irq_work))
 			return -EBUSY;
 
 		/* Add the current task, which is the target of sending signal,
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
diff --git a/net/core/dev.c b/net/core/dev.c
index 82dc6b48e45f..57352605f82c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11165,8 +11165,7 @@ static int __init net_dev_init(void)
 		INIT_LIST_HEAD(&sd->poll_list);
 		sd->output_queue_tailp = &sd->output_queue;
 #ifdef CONFIG_RPS
-		sd->csd.func = rps_trigger_softirq;
-		sd->csd.info = sd;
+		INIT_CSD(&sd->csd, rps_trigger_softirq, sd);
 		sd->cpu = i;
 #endif
 

