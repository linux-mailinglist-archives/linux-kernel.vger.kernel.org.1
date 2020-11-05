Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653412A7E89
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 13:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgKEM1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:27:23 -0500
Received: from foss.arm.com ([217.140.110.172]:59322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgKEM1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:27:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D0C0142F;
        Thu,  5 Nov 2020 04:27:22 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 32D4E3F719;
        Thu,  5 Nov 2020 04:27:21 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org
Cc:     souvik.chakravarty@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com
Subject: [PATCH v3 1/3] arm64: wrap and generalise counter read functions
Date:   Thu,  5 Nov 2020 12:27:00 +0000
Message-Id: <20201105122702.13916-2-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201105122702.13916-1-ionela.voinescu@arm.com>
References: <20201105122702.13916-1-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for other uses of Activity Monitors (AMU) cycle counters,
place counter read functionality in generic functions that can reused:
read_corecnt() and read_constcnt().

As a result, implement update_freq_counters_refs() to replace
init_cpu_freq_invariance_counters() and both initialise and update
the per-cpu reference variables.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h |  5 ++++
 arch/arm64/include/asm/topology.h   |  4 +++-
 arch/arm64/kernel/cpufeature.c      |  5 +---
 arch/arm64/kernel/topology.c        | 36 +++++++++++++++++++----------
 4 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 97244d4feca9..751bd9d3376b 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -765,6 +765,11 @@ static inline bool cpu_has_hw_af(void)
 #ifdef CONFIG_ARM64_AMU_EXTN
 /* Check whether the cpu supports the Activity Monitors Unit (AMU) */
 extern bool cpu_has_amu_feat(int cpu);
+#else
+static inline bool cpu_has_amu_feat(int cpu)
+{
+	return false;
+}
 #endif
 
 static inline unsigned int get_vmid_bits(u64 mmfr1)
diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 11a465243f66..3b8dca4eb08d 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -16,12 +16,14 @@ int pcibus_to_node(struct pci_bus *bus);
 
 #include <linux/arch_topology.h>
 
+void update_freq_counters_refs(void);
+void topology_scale_freq_tick(void);
+
 #ifdef CONFIG_ARM64_AMU_EXTN
 /*
  * Replace task scheduler's default counter-based
  * frequency-invariance scale factor setting.
  */
-void topology_scale_freq_tick(void);
 #define arch_scale_freq_tick topology_scale_freq_tick
 #endif /* CONFIG_ARM64_AMU_EXTN */
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index dcc165b3fc04..1142970e985b 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1526,16 +1526,13 @@ bool cpu_has_amu_feat(int cpu)
 	return cpumask_test_cpu(cpu, &amu_cpus);
 }
 
-/* Initialize the use of AMU counters for frequency invariance */
-extern void init_cpu_freq_invariance_counters(void);
-
 static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
 {
 	if (has_cpuid_feature(cap, SCOPE_LOCAL_CPU)) {
 		pr_info("detected CPU%d: Activity Monitors Unit (AMU)\n",
 			smp_processor_id());
 		cpumask_set_cpu(smp_processor_id(), &amu_cpus);
-		init_cpu_freq_invariance_counters();
+		update_freq_counters_refs();
 	}
 }
 
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 543c67cae02f..db03c440e157 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -123,23 +123,33 @@ int __init parse_acpi_topology(void)
 }
 #endif
 
-#ifdef CONFIG_ARM64_AMU_EXTN
+#define COUNTER_READ_STORE(NAME, VAL) \
+static inline u64 read_##NAME(void) \
+{ \
+	return VAL; \
+} \
+static inline void store_##NAME(void *val) \
+{ \
+	*(u64 *)val = read_##NAME(); \
+}
 
-#undef pr_fmt
-#define pr_fmt(fmt) "AMU: " fmt
+#ifdef CONFIG_ARM64_AMU_EXTN
+COUNTER_READ_STORE(corecnt, read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0));
+COUNTER_READ_STORE(constcnt, read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0));
+#else
+COUNTER_READ_STORE(corecnt, 0);
+COUNTER_READ_STORE(constcnt, 0);
+#endif
 
 static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale);
 static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
 static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
 static cpumask_var_t amu_fie_cpus;
 
-/* Initialize counter reference per-cpu variables for the current CPU */
-void init_cpu_freq_invariance_counters(void)
+void update_freq_counters_refs(void)
 {
-	this_cpu_write(arch_core_cycles_prev,
-		       read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0));
-	this_cpu_write(arch_const_cycles_prev,
-		       read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0));
+	this_cpu_write(arch_core_cycles_prev, read_corecnt());
+	this_cpu_write(arch_const_cycles_prev, read_constcnt());
 }
 
 static int validate_cpu_freq_invariance_counters(int cpu)
@@ -280,11 +290,14 @@ void topology_scale_freq_tick(void)
 	if (!cpumask_test_cpu(cpu, amu_fie_cpus))
 		return;
 
-	const_cnt = read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0);
-	core_cnt = read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0);
 	prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
 	prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
 
+	update_freq_counters_refs();
+
+	const_cnt = this_cpu_read(arch_const_cycles_prev);
+	core_cnt = this_cpu_read(arch_core_cycles_prev);
+
 	if (unlikely(core_cnt <= prev_core_cnt ||
 		     const_cnt <= prev_const_cnt))
 		goto store_and_exit;
@@ -309,4 +322,3 @@ void topology_scale_freq_tick(void)
 	this_cpu_write(arch_core_cycles_prev, core_cnt);
 	this_cpu_write(arch_const_cycles_prev, const_cnt);
 }
-#endif /* CONFIG_ARM64_AMU_EXTN */
-- 
2.17.1

