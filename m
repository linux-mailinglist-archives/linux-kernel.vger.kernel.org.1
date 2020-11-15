Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CDE2B3501
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 14:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgKONBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 08:01:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35258 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgKONBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 08:01:39 -0500
Date:   Sun, 15 Nov 2020 13:00:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605445294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=e00ubBBWIeFWqTUq8ArWW+yXaXc7hna5BptBovjsNsE=;
        b=nWn36TWRGzEMk81NBkd84z3uVcDTEbfVbgrzTtOKYRgljy+xFEb+rA0trO7jcdB2VSEyG6
        bd0lPbBIRhYAAsUVdlDj6Yq08Uti1LKmQS6x/GNtEkeaLq/oZvWH0Xs9aMcrqKyhseSSv9
        goC+Dft6HGRbboII/Mzxp0sXz/3Sy1d1ymtnsbwYFedakgoxYt7HgoGCTesb9M6dwq6amR
        yvH8Qz0+bYansFV8ji8wJh0cPVg4QAQ5p2Gtskk/1RUNWW+TCvXiy+LvSdhWev5R9EQ3cj
        1d0XHFhc8Lw7lLj7JvMNszNdc8N19d8bEa7rG2FXNm5JXwX42saUoOSilLMUWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605445294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=e00ubBBWIeFWqTUq8ArWW+yXaXc7hna5BptBovjsNsE=;
        b=bhZe9d/voaESZsi9vV07jepMxzengiKz7OZqYwxAwwHV5Yv7UMxtUGhOhWcEE/79aRcVpu
        iUsGm/hvhYsQEHDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for v5.10-rc4
References: <160544524024.25051.12292089189937197323.tglx@nanos>
Message-ID: <160544524145.25051.6722901041651113077.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-11-15

up to:  1a8cfa24e21c: perf/x86/intel/uncore: Fix Add BW copypasta

A set of fixes for perf:

 - A set of commits which reduce the stack usage of various perf event
   handling functions which allocated large data structs on stack causing
   stack overflows in the worst case.

 - Use the proper mechanism for detecting soft interrupts in the recursion
   protection.

 - Make the resursion protection simpler and more robust.

 - Simplify the scheduling of event groups to make the code more robust and
   prepare for fixing the issues vs. scheduling of exclusive event groups.

 - Prevent event multiplexing and rotation for exclusive event groups

 - Correct the perf event attribute exclusive semantics to take pinned
   events, e.g. the PMU watchdog, into account

 - Make the anythread filtering conditional for Intel's generic PMU
   counters as it is not longer guaranteed to be supported on newer
   CPUs. Check the corresponding CPUID leaf to make sure.

 - Fixup a duplicate initialization in an array which was probably cause by
   the usual copy & paste - forgot to edit mishap.

Thanks,

	tglx

------------------>
Arnd Bergmann (1):
      perf/x86/intel/uncore: Fix Add BW copypasta

Peter Zijlstra (10):
      perf: Reduce stack usage of perf_output_begin()
      perf/x86: Reduce stack usage for x86_pmu::drain_pebs()
      perf: Fix get_recursion_context()
      perf: Optimize get_recursion_context()
      perf/arch: Remove perf_sample_data::regs_user_copy
      perf/x86: Make dummy_iregs static
      perf: Simplify group_sched_out()
      perf: Simplify group_sched_in()
      perf: Fix event multiplexing for exclusive groups
      perf: Tweak perf_event_attr::exclusive semantics

Stephane Eranian (1):
      perf/x86/intel: Make anythread filter support conditional


 arch/arm/kernel/perf_regs.c        |  3 +-
 arch/arm64/kernel/perf_regs.c      |  3 +-
 arch/csky/kernel/perf_regs.c       |  3 +-
 arch/powerpc/perf/imc-pmu.c        |  2 +-
 arch/powerpc/perf/perf_regs.c      |  3 +-
 arch/riscv/kernel/perf_regs.c      |  3 +-
 arch/s390/kernel/perf_cpum_sf.c    |  2 +-
 arch/s390/kernel/perf_regs.c       |  3 +-
 arch/x86/events/intel/core.c       | 12 +++++++-
 arch/x86/events/intel/ds.c         | 53 ++++++++++++++++++-----------------
 arch/x86/events/intel/uncore_snb.c |  2 +-
 arch/x86/events/perf_event.h       |  3 +-
 arch/x86/include/asm/perf_event.h  |  4 ++-
 arch/x86/kernel/perf_regs.c        | 15 +++++++---
 arch/x86/kvm/cpuid.c               |  4 ++-
 include/linux/perf_event.h         | 13 ++++-----
 include/linux/perf_regs.h          |  6 ++--
 kernel/events/core.c               | 57 +++++++++++++++++---------------------
 kernel/events/internal.h           | 16 ++++-------
 kernel/events/ring_buffer.c        | 20 +++++++------
 20 files changed, 116 insertions(+), 111 deletions(-)

diff --git a/arch/arm/kernel/perf_regs.c b/arch/arm/kernel/perf_regs.c
index 05fe92aa7d98..0529f90395c9 100644
--- a/arch/arm/kernel/perf_regs.c
+++ b/arch/arm/kernel/perf_regs.c
@@ -32,8 +32,7 @@ u64 perf_reg_abi(struct task_struct *task)
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index 94e8718e7229..f6f58e6265df 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -73,8 +73,7 @@ u64 perf_reg_abi(struct task_struct *task)
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
diff --git a/arch/csky/kernel/perf_regs.c b/arch/csky/kernel/perf_regs.c
index eb32838b8210..09b7f88a2d6a 100644
--- a/arch/csky/kernel/perf_regs.c
+++ b/arch/csky/kernel/perf_regs.c
@@ -32,8 +32,7 @@ u64 perf_reg_abi(struct task_struct *task)
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 9ed4fcccf8a9..7b25548ec42b 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1336,7 +1336,7 @@ static void dump_trace_imc_data(struct perf_event *event)
 			/* If this is a valid record, create the sample */
 			struct perf_output_handle handle;
 
-			if (perf_output_begin(&handle, event, header.size))
+			if (perf_output_begin(&handle, &data, event, header.size))
 				return;
 
 			perf_output_sample(&handle, &header, &data, event);
diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
index 8e53f2fc3fe0..6f681b105eec 100644
--- a/arch/powerpc/perf/perf_regs.c
+++ b/arch/powerpc/perf/perf_regs.c
@@ -144,8 +144,7 @@ u64 perf_reg_abi(struct task_struct *task)
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = (regs_user->regs) ? perf_reg_abi(current) :
diff --git a/arch/riscv/kernel/perf_regs.c b/arch/riscv/kernel/perf_regs.c
index 04a38fbeb9c7..fd304a248de6 100644
--- a/arch/riscv/kernel/perf_regs.c
+++ b/arch/riscv/kernel/perf_regs.c
@@ -36,8 +36,7 @@ u64 perf_reg_abi(struct task_struct *task)
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 4f9e4626df55..00255ae3979d 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -672,7 +672,7 @@ static void cpumsf_output_event_pid(struct perf_event *event,
 	rcu_read_lock();
 
 	perf_prepare_sample(&header, data, event, regs);
-	if (perf_output_begin(&handle, event, header.size))
+	if (perf_output_begin(&handle, data, event, header.size))
 		goto out;
 
 	/* Update the process ID (see also kernel/events/core.c) */
diff --git a/arch/s390/kernel/perf_regs.c b/arch/s390/kernel/perf_regs.c
index 4352a504f235..6e9e5d5e927e 100644
--- a/arch/s390/kernel/perf_regs.c
+++ b/arch/s390/kernel/perf_regs.c
@@ -53,8 +53,7 @@ u64 perf_reg_abi(struct task_struct *task)
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	/*
 	 * Use the regs from the first interruption and let
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f1926e9f2143..af457f8cb29d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2630,7 +2630,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		u64 pebs_enabled = cpuc->pebs_enabled;
 
 		handled++;
-		x86_pmu.drain_pebs(regs);
+		x86_pmu.drain_pebs(regs, &data);
 		status &= x86_pmu.intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
 
 		/*
@@ -4987,6 +4987,12 @@ __init int intel_pmu_init(void)
 
 	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
 
+	if (version >= 5) {
+		x86_pmu.intel_cap.anythread_deprecated = edx.split.anythread_deprecated;
+		if (x86_pmu.intel_cap.anythread_deprecated)
+			pr_cont(" AnyThread deprecated, ");
+	}
+
 	/*
 	 * Install the hw-cache-events table:
 	 */
@@ -5512,6 +5518,10 @@ __init int intel_pmu_init(void)
 	x86_pmu.intel_ctrl |=
 		((1LL << x86_pmu.num_counters_fixed)-1) << INTEL_PMC_IDX_FIXED;
 
+	/* AnyThread may be deprecated on arch perfmon v5 or later */
+	if (x86_pmu.intel_cap.anythread_deprecated)
+		x86_pmu.format_attrs = intel_arch_formats_attr;
+
 	if (x86_pmu.event_constraints) {
 		/*
 		 * event on fixed counter2 (REF_CYCLES) only works on this
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 404315df1e16..b47cc4226934 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -642,8 +642,8 @@ int intel_pmu_drain_bts_buffer(void)
 	rcu_read_lock();
 	perf_prepare_sample(&header, &data, event, &regs);
 
-	if (perf_output_begin(&handle, event, header.size *
-			      (top - base - skip)))
+	if (perf_output_begin(&handle, &data, event,
+			      header.size * (top - base - skip)))
 		goto unlock;
 
 	for (at = base; at < top; at++) {
@@ -670,7 +670,9 @@ int intel_pmu_drain_bts_buffer(void)
 
 static inline void intel_pmu_drain_pebs_buffer(void)
 {
-	x86_pmu.drain_pebs(NULL);
+	struct perf_sample_data data;
+
+	x86_pmu.drain_pebs(NULL, &data);
 }
 
 /*
@@ -1719,23 +1721,24 @@ intel_pmu_save_and_restart_reload(struct perf_event *event, int count)
 	return 0;
 }
 
-static void __intel_pmu_pebs_event(struct perf_event *event,
-				   struct pt_regs *iregs,
-				   void *base, void *top,
-				   int bit, int count,
-				   void (*setup_sample)(struct perf_event *,
-						struct pt_regs *,
-						void *,
-						struct perf_sample_data *,
-						struct pt_regs *))
+static __always_inline void
+__intel_pmu_pebs_event(struct perf_event *event,
+		       struct pt_regs *iregs,
+		       struct perf_sample_data *data,
+		       void *base, void *top,
+		       int bit, int count,
+		       void (*setup_sample)(struct perf_event *,
+					    struct pt_regs *,
+					    void *,
+					    struct perf_sample_data *,
+					    struct pt_regs *))
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
-	struct perf_sample_data data;
 	struct x86_perf_regs perf_regs;
 	struct pt_regs *regs = &perf_regs.regs;
 	void *at = get_next_pebs_record_by_bit(base, top, bit);
-	struct pt_regs dummy_iregs;
+	static struct pt_regs dummy_iregs;
 
 	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
 		/*
@@ -1752,14 +1755,14 @@ static void __intel_pmu_pebs_event(struct perf_event *event,
 		iregs = &dummy_iregs;
 
 	while (count > 1) {
-		setup_sample(event, iregs, at, &data, regs);
-		perf_event_output(event, &data, regs);
+		setup_sample(event, iregs, at, data, regs);
+		perf_event_output(event, data, regs);
 		at += cpuc->pebs_record_size;
 		at = get_next_pebs_record_by_bit(at, top, bit);
 		count--;
 	}
 
-	setup_sample(event, iregs, at, &data, regs);
+	setup_sample(event, iregs, at, data, regs);
 	if (iregs == &dummy_iregs) {
 		/*
 		 * The PEBS records may be drained in the non-overflow context,
@@ -1767,18 +1770,18 @@ static void __intel_pmu_pebs_event(struct perf_event *event,
 		 * last record the same as other PEBS records, and doesn't
 		 * invoke the generic overflow handler.
 		 */
-		perf_event_output(event, &data, regs);
+		perf_event_output(event, data, regs);
 	} else {
 		/*
 		 * All but the last records are processed.
 		 * The last one is left to be able to call the overflow handler.
 		 */
-		if (perf_event_overflow(event, &data, regs))
+		if (perf_event_overflow(event, data, regs))
 			x86_pmu_stop(event, 0);
 	}
 }
 
-static void intel_pmu_drain_pebs_core(struct pt_regs *iregs)
+static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
@@ -1812,7 +1815,7 @@ static void intel_pmu_drain_pebs_core(struct pt_regs *iregs)
 		return;
 	}
 
-	__intel_pmu_pebs_event(event, iregs, at, top, 0, n,
+	__intel_pmu_pebs_event(event, iregs, data, at, top, 0, n,
 			       setup_pebs_fixed_sample_data);
 }
 
@@ -1835,7 +1838,7 @@ static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, int
 	}
 }
 
-static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
+static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
@@ -1942,14 +1945,14 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
 		}
 
 		if (counts[bit]) {
-			__intel_pmu_pebs_event(event, iregs, base,
+			__intel_pmu_pebs_event(event, iregs, data, base,
 					       top, bit, counts[bit],
 					       setup_pebs_fixed_sample_data);
 		}
 	}
 }
 
-static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs)
+static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1997,7 +2000,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs)
 		if (WARN_ON_ONCE(!event->attr.precise_ip))
 			continue;
 
-		__intel_pmu_pebs_event(event, iregs, base,
+		__intel_pmu_pebs_event(event, iregs, data, base,
 				       top, bit, counts[bit],
 				       setup_pebs_adaptive_sample_data);
 	}
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 39e632ed6ca9..bbd1120ae161 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -475,7 +475,7 @@ enum perf_snb_uncore_imc_freerunning_types {
 static struct freerunning_counters snb_uncore_imc_freerunning[] = {
 	[SNB_PCI_UNCORE_IMC_DATA_READS]		= { SNB_UNCORE_PCI_IMC_DATA_READS_BASE,
 							0x0, 0x0, 1, 32 },
-	[SNB_PCI_UNCORE_IMC_DATA_READS]		= { SNB_UNCORE_PCI_IMC_DATA_WRITES_BASE,
+	[SNB_PCI_UNCORE_IMC_DATA_WRITES]	= { SNB_UNCORE_PCI_IMC_DATA_WRITES_BASE,
 							0x0, 0x0, 1, 32 },
 	[SNB_PCI_UNCORE_IMC_GT_REQUESTS]	= { SNB_UNCORE_PCI_IMC_GT_REQUESTS_BASE,
 							0x0, 0x0, 1, 32 },
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ee2b9b9fc2a5..6a8edfe59b09 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -585,6 +585,7 @@ union perf_capabilities {
 		u64     pebs_baseline:1;
 		u64	perf_metrics:1;
 		u64	pebs_output_pt_available:1;
+		u64	anythread_deprecated:1;
 	};
 	u64	capabilities;
 };
@@ -727,7 +728,7 @@ struct x86_pmu {
 	int		pebs_record_size;
 	int		pebs_buffer_size;
 	int		max_pebs_events;
-	void		(*drain_pebs)(struct pt_regs *regs);
+	void		(*drain_pebs)(struct pt_regs *regs, struct perf_sample_data *data);
 	struct event_constraint *pebs_constraints;
 	void		(*pebs_aliases)(struct perf_event *event);
 	unsigned long	large_pebs_flags;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 6960cd6d1f23..b9a7fd0a27e2 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -137,7 +137,9 @@ union cpuid10_edx {
 	struct {
 		unsigned int num_counters_fixed:5;
 		unsigned int bit_width_fixed:8;
-		unsigned int reserved:19;
+		unsigned int reserved1:2;
+		unsigned int anythread_deprecated:1;
+		unsigned int reserved2:16;
 	} split;
 	unsigned int full;
 };
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index bb7e1132290b..f9e5352b3bef 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -101,8 +101,7 @@ u64 perf_reg_abi(struct task_struct *task)
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
@@ -129,12 +128,20 @@ u64 perf_reg_abi(struct task_struct *task)
 		return PERF_SAMPLE_REGS_ABI_64;
 }
 
+static DEFINE_PER_CPU(struct pt_regs, nmi_user_regs);
+
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
+	struct pt_regs *regs_user_copy = this_cpu_ptr(&nmi_user_regs);
 	struct pt_regs *user_regs = task_pt_regs(current);
 
+	if (!in_nmi()) {
+		regs_user->regs = user_regs;
+		regs_user->abi = perf_reg_abi(current);
+		return;
+	}
+
 	/*
 	 * If we're in an NMI that interrupted task_pt_regs setup, then
 	 * we can't sample user regs at all.  This check isn't really
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 06a278b3701d..0752dec66e29 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -672,7 +672,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 
 		edx.split.num_counters_fixed = min(cap.num_counters_fixed, MAX_FIXED_COUNTERS);
 		edx.split.bit_width_fixed = cap.bit_width_fixed;
-		edx.split.reserved = 0;
+		edx.split.anythread_deprecated = 1;
+		edx.split.reserved1 = 0;
+		edx.split.reserved2 = 0;
 
 		entry->eax = eax.full;
 		entry->ebx = cap.events_mask;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0c19d279b97f..96450f6fb1de 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1022,13 +1022,7 @@ struct perf_sample_data {
 	struct perf_callchain_entry	*callchain;
 	u64				aux_size;
 
-	/*
-	 * regs_user may point to task_pt_regs or to regs_user_copy, depending
-	 * on arch details.
-	 */
 	struct perf_regs		regs_user;
-	struct pt_regs			regs_user_copy;
-
 	struct perf_regs		regs_intr;
 	u64				stack_user_size;
 
@@ -1400,11 +1394,14 @@ perf_event_addr_filters(struct perf_event *event)
 extern void perf_event_addr_filters_sync(struct perf_event *event);
 
 extern int perf_output_begin(struct perf_output_handle *handle,
+			     struct perf_sample_data *data,
 			     struct perf_event *event, unsigned int size);
 extern int perf_output_begin_forward(struct perf_output_handle *handle,
-				    struct perf_event *event,
-				    unsigned int size);
+				     struct perf_sample_data *data,
+				     struct perf_event *event,
+				     unsigned int size);
 extern int perf_output_begin_backward(struct perf_output_handle *handle,
+				      struct perf_sample_data *data,
 				      struct perf_event *event,
 				      unsigned int size);
 
diff --git a/include/linux/perf_regs.h b/include/linux/perf_regs.h
index 2d12e97d5e7b..f632c5725f16 100644
--- a/include/linux/perf_regs.h
+++ b/include/linux/perf_regs.h
@@ -20,8 +20,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx);
 int perf_reg_validate(u64 mask);
 u64 perf_reg_abi(struct task_struct *task);
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy);
+			struct pt_regs *regs);
 #else
 
 #define PERF_REG_EXTENDED_MASK	0
@@ -42,8 +41,7 @@ static inline u64 perf_reg_abi(struct task_struct *task)
 }
 
 static inline void perf_get_regs_user(struct perf_regs *regs_user,
-				      struct pt_regs *regs,
-				      struct pt_regs *regs_user_copy)
+				      struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5a29ab09e72d..dc568ca295bd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2312,9 +2312,6 @@ group_sched_out(struct perf_event *group_event,
 		event_sched_out(event, cpuctx, ctx);
 
 	perf_pmu_enable(ctx->pmu);
-
-	if (group_event->attr.exclusive)
-		cpuctx->exclusive = 0;
 }
 
 #define DETACH_GROUP	0x01UL
@@ -2583,11 +2580,8 @@ group_sched_in(struct perf_event *group_event,
 
 	pmu->start_txn(pmu, PERF_PMU_TXN_ADD);
 
-	if (event_sched_in(group_event, cpuctx, ctx)) {
-		pmu->cancel_txn(pmu);
-		perf_mux_hrtimer_restart(cpuctx);
-		return -EAGAIN;
-	}
+	if (event_sched_in(group_event, cpuctx, ctx))
+		goto error;
 
 	/*
 	 * Schedule in siblings as one group (if any):
@@ -2616,10 +2610,8 @@ group_sched_in(struct perf_event *group_event,
 	}
 	event_sched_out(group_event, cpuctx, ctx);
 
+error:
 	pmu->cancel_txn(pmu);
-
-	perf_mux_hrtimer_restart(cpuctx);
-
 	return -EAGAIN;
 }
 
@@ -2645,7 +2637,7 @@ static int group_can_go_on(struct perf_event *event,
 	 * If this group is exclusive and there are already
 	 * events on the CPU, it can't go on.
 	 */
-	if (event->attr.exclusive && cpuctx->active_oncpu)
+	if (event->attr.exclusive && !list_empty(get_event_list(event)))
 		return 0;
 	/*
 	 * Otherwise, try to add it if all previous groups were able
@@ -3679,6 +3671,7 @@ static int merge_sched_in(struct perf_event *event, void *data)
 
 		*can_add_hw = 0;
 		ctx->rotate_necessary = 1;
+		perf_mux_hrtimer_restart(cpuctx);
 	}
 
 	return 0;
@@ -6374,14 +6367,13 @@ perf_output_sample_regs(struct perf_output_handle *handle,
 }
 
 static void perf_sample_regs_user(struct perf_regs *regs_user,
-				  struct pt_regs *regs,
-				  struct pt_regs *regs_user_copy)
+				  struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		regs_user->abi = perf_reg_abi(current);
 		regs_user->regs = regs;
 	} else if (!(current->flags & PF_KTHREAD)) {
-		perf_get_regs_user(regs_user, regs, regs_user_copy);
+		perf_get_regs_user(regs_user, regs);
 	} else {
 		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
 		regs_user->regs = NULL;
@@ -7083,8 +7075,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 	}
 
 	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER))
-		perf_sample_regs_user(&data->regs_user, regs,
-				      &data->regs_user_copy);
+		perf_sample_regs_user(&data->regs_user, regs);
 
 	if (sample_type & PERF_SAMPLE_REGS_USER) {
 		/* regs dump ABI info */
@@ -7186,6 +7177,7 @@ __perf_event_output(struct perf_event *event,
 		    struct perf_sample_data *data,
 		    struct pt_regs *regs,
 		    int (*output_begin)(struct perf_output_handle *,
+					struct perf_sample_data *,
 					struct perf_event *,
 					unsigned int))
 {
@@ -7198,7 +7190,7 @@ __perf_event_output(struct perf_event *event,
 
 	perf_prepare_sample(&header, data, event, regs);
 
-	err = output_begin(&handle, event, header.size);
+	err = output_begin(&handle, data, event, header.size);
 	if (err)
 		goto exit;
 
@@ -7264,7 +7256,7 @@ perf_event_read_event(struct perf_event *event,
 	int ret;
 
 	perf_event_header__init_id(&read_event.header, &sample, event);
-	ret = perf_output_begin(&handle, event, read_event.header.size);
+	ret = perf_output_begin(&handle, &sample, event, read_event.header.size);
 	if (ret)
 		return;
 
@@ -7533,7 +7525,7 @@ static void perf_event_task_output(struct perf_event *event,
 
 	perf_event_header__init_id(&task_event->event_id.header, &sample, event);
 
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				task_event->event_id.header.size);
 	if (ret)
 		goto out;
@@ -7636,7 +7628,7 @@ static void perf_event_comm_output(struct perf_event *event,
 		return;
 
 	perf_event_header__init_id(&comm_event->event_id.header, &sample, event);
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				comm_event->event_id.header.size);
 
 	if (ret)
@@ -7736,7 +7728,7 @@ static void perf_event_namespaces_output(struct perf_event *event,
 
 	perf_event_header__init_id(&namespaces_event->event_id.header,
 				   &sample, event);
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				namespaces_event->event_id.header.size);
 	if (ret)
 		goto out;
@@ -7863,7 +7855,7 @@ static void perf_event_cgroup_output(struct perf_event *event, void *data)
 
 	perf_event_header__init_id(&cgroup_event->event_id.header,
 				   &sample, event);
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				cgroup_event->event_id.header.size);
 	if (ret)
 		goto out;
@@ -7989,7 +7981,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 	}
 
 	perf_event_header__init_id(&mmap_event->event_id.header, &sample, event);
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				mmap_event->event_id.header.size);
 	if (ret)
 		goto out;
@@ -8299,7 +8291,7 @@ void perf_event_aux_event(struct perf_event *event, unsigned long head,
 	int ret;
 
 	perf_event_header__init_id(&rec.header, &sample, event);
-	ret = perf_output_begin(&handle, event, rec.header.size);
+	ret = perf_output_begin(&handle, &sample, event, rec.header.size);
 
 	if (ret)
 		return;
@@ -8333,7 +8325,7 @@ void perf_log_lost_samples(struct perf_event *event, u64 lost)
 
 	perf_event_header__init_id(&lost_samples_event.header, &sample, event);
 
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				lost_samples_event.header.size);
 	if (ret)
 		return;
@@ -8388,7 +8380,7 @@ static void perf_event_switch_output(struct perf_event *event, void *data)
 
 	perf_event_header__init_id(&se->event_id.header, &sample, event);
 
-	ret = perf_output_begin(&handle, event, se->event_id.header.size);
+	ret = perf_output_begin(&handle, &sample, event, se->event_id.header.size);
 	if (ret)
 		return;
 
@@ -8463,7 +8455,7 @@ static void perf_log_throttle(struct perf_event *event, int enable)
 
 	perf_event_header__init_id(&throttle_event.header, &sample, event);
 
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				throttle_event.header.size);
 	if (ret)
 		return;
@@ -8506,7 +8498,7 @@ static void perf_event_ksymbol_output(struct perf_event *event, void *data)
 
 	perf_event_header__init_id(&ksymbol_event->event_id.header,
 				   &sample, event);
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, &sample, event,
 				ksymbol_event->event_id.header.size);
 	if (ret)
 		return;
@@ -8596,7 +8588,7 @@ static void perf_event_bpf_output(struct perf_event *event, void *data)
 
 	perf_event_header__init_id(&bpf_event->event_id.header,
 				   &sample, event);
-	ret = perf_output_begin(&handle, event,
+	ret = perf_output_begin(&handle, data, event,
 				bpf_event->event_id.header.size);
 	if (ret)
 		return;
@@ -8705,7 +8697,8 @@ static void perf_event_text_poke_output(struct perf_event *event, void *data)
 
 	perf_event_header__init_id(&text_poke_event->event_id.header, &sample, event);
 
-	ret = perf_output_begin(&handle, event, text_poke_event->event_id.header.size);
+	ret = perf_output_begin(&handle, &sample, event,
+				text_poke_event->event_id.header.size);
 	if (ret)
 		return;
 
@@ -8786,7 +8779,7 @@ static void perf_log_itrace_start(struct perf_event *event)
 	rec.tid	= perf_event_tid(event, current);
 
 	perf_event_header__init_id(&rec.header, &sample, event);
-	ret = perf_output_begin(&handle, event, rec.header.size);
+	ret = perf_output_begin(&handle, &sample, event, rec.header.size);
 
 	if (ret)
 		return;
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index fcbf5616a441..228801e20788 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -205,16 +205,12 @@ DEFINE_OUTPUT_COPY(__output_copy_user, arch_perf_out_copy_user)
 
 static inline int get_recursion_context(int *recursion)
 {
-	int rctx;
-
-	if (unlikely(in_nmi()))
-		rctx = 3;
-	else if (in_irq())
-		rctx = 2;
-	else if (in_softirq())
-		rctx = 1;
-	else
-		rctx = 0;
+	unsigned int pc = preempt_count();
+	unsigned char rctx = 0;
+
+	rctx += !!(pc & (NMI_MASK));
+	rctx += !!(pc & (NMI_MASK | HARDIRQ_MASK));
+	rctx += !!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET));
 
 	if (recursion[rctx])
 		return -1;
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 192b8abc6330..ef91ae75ca56 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -147,6 +147,7 @@ ring_buffer_has_space(unsigned long head, unsigned long tail,
 
 static __always_inline int
 __perf_output_begin(struct perf_output_handle *handle,
+		    struct perf_sample_data *data,
 		    struct perf_event *event, unsigned int size,
 		    bool backward)
 {
@@ -237,18 +238,16 @@ __perf_output_begin(struct perf_output_handle *handle,
 	handle->size = (1UL << page_shift) - offset;
 
 	if (unlikely(have_lost)) {
-		struct perf_sample_data sample_data;
-
 		lost_event.header.size = sizeof(lost_event);
 		lost_event.header.type = PERF_RECORD_LOST;
 		lost_event.header.misc = 0;
 		lost_event.id          = event->id;
 		lost_event.lost        = local_xchg(&rb->lost, 0);
 
-		perf_event_header__init_id(&lost_event.header,
-					   &sample_data, event);
+		/* XXX mostly redundant; @data is already fully initializes */
+		perf_event_header__init_id(&lost_event.header, data, event);
 		perf_output_put(handle, lost_event);
-		perf_event__output_id_sample(event, handle, &sample_data);
+		perf_event__output_id_sample(event, handle, data);
 	}
 
 	return 0;
@@ -263,22 +262,25 @@ __perf_output_begin(struct perf_output_handle *handle,
 }
 
 int perf_output_begin_forward(struct perf_output_handle *handle,
-			     struct perf_event *event, unsigned int size)
+			      struct perf_sample_data *data,
+			      struct perf_event *event, unsigned int size)
 {
-	return __perf_output_begin(handle, event, size, false);
+	return __perf_output_begin(handle, data, event, size, false);
 }
 
 int perf_output_begin_backward(struct perf_output_handle *handle,
+			       struct perf_sample_data *data,
 			       struct perf_event *event, unsigned int size)
 {
-	return __perf_output_begin(handle, event, size, true);
+	return __perf_output_begin(handle, data, event, size, true);
 }
 
 int perf_output_begin(struct perf_output_handle *handle,
+		      struct perf_sample_data *data,
 		      struct perf_event *event, unsigned int size)
 {
 
-	return __perf_output_begin(handle, event, size,
+	return __perf_output_begin(handle, data, event, size,
 				   unlikely(is_write_backward(event)));
 }
 

