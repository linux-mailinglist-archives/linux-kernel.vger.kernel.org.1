Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8282A7E8B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 13:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbgKEM1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:27:30 -0500
Received: from foss.arm.com ([217.140.110.172]:59348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbgKEM13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:27:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B57A6142F;
        Thu,  5 Nov 2020 04:27:28 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4B0593F719;
        Thu,  5 Nov 2020 04:27:27 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org
Cc:     souvik.chakravarty@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com
Subject: [PATCH v3 3/3] arm64: implement CPPC FFH support using AMUs
Date:   Thu,  5 Nov 2020 12:27:02 +0000
Message-Id: <20201105122702.13916-4-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201105122702.13916-1-ionela.voinescu@arm.com>
References: <20201105122702.13916-1-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If Activity Monitors (AMUs) are present, two of the counters can be used
to implement support for CPPC's (Collaborative Processor Performance
Control) delivered and reference performance monitoring functionality
using FFH (Functional Fixed Hardware).

Given that counters for a certain CPU can only be read from that CPU,
while FFH operations can be called from any CPU for any of the CPUs, use
smp_call_function_single() to provide the requested values.

Therefore, depending on the register addresses, the following values
are returned:
 - 0x0 (DeliveredPerformanceCounterRegister): AMU core counter
 - 0x1 (ReferencePerformanceCounterRegister): AMU constant counter

The use of Activity Monitors is hidden behind the generic
{read,store}_{corecnt,constcnt}() functions.

Read functionality for these two registers represents the only current
FFH support for CPPC. Read operations for other register values or write
operation for all registers are unsupported. Therefore, keep CPPC's FFH
unsupported if no CPUs have valid AMU frequency counters. For this
purpose, the get_cpu_with_amu_feat() is introduced.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h |  3 ++
 arch/arm64/kernel/cpufeature.c      | 10 ++++++
 arch/arm64/kernel/topology.c        | 54 +++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 751bd9d3376b..f5b44ac354dc 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -772,6 +772,9 @@ static inline bool cpu_has_amu_feat(int cpu)
 }
 #endif
 
+/* Get a cpu that supports the Activity Monitors Unit (AMU) */
+extern int get_cpu_with_amu_feat(void);
+
 static inline unsigned int get_vmid_bits(u64 mmfr1)
 {
 	int vmid_bits;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 1142970e985b..6b08ae74ad0a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1526,6 +1526,11 @@ bool cpu_has_amu_feat(int cpu)
 	return cpumask_test_cpu(cpu, &amu_cpus);
 }
 
+int get_cpu_with_amu_feat(void)
+{
+	return cpumask_any(&amu_cpus);
+}
+
 static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
 {
 	if (has_cpuid_feature(cap, SCOPE_LOCAL_CPU)) {
@@ -1554,6 +1559,11 @@ static bool has_amu(const struct arm64_cpu_capabilities *cap,
 
 	return true;
 }
+#else
+int get_cpu_with_amu_feat(void)
+{
+	return nr_cpu_ids;
+}
 #endif
 
 #ifdef CONFIG_ARM64_VHE
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 764fdb0f947b..7d25087deaa5 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -154,6 +154,9 @@ void update_freq_counters_refs(void)
 
 static inline bool freq_counters_valid(int cpu)
 {
+	if ((cpu >= nr_cpu_ids) || !cpumask_test_cpu(cpu, cpu_present_mask))
+		return false;
+
 	if (!cpu_has_amu_feat(cpu)) {
 		pr_debug("CPU%d: counters are not supported.\n", cpu);
 		return false;
@@ -330,3 +333,54 @@ void topology_scale_freq_tick(void)
 	this_cpu_write(arch_core_cycles_prev, core_cnt);
 	this_cpu_write(arch_const_cycles_prev, const_cnt);
 }
+
+#ifdef CONFIG_ACPI_CPPC_LIB
+#include <acpi/cppc_acpi.h>
+
+static inline
+int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
+{
+	if (!cpu_has_amu_feat(cpu))
+		return -EOPNOTSUPP;
+
+	smp_call_function_single(cpu, func, val, 1);
+
+	return 0;
+}
+
+/*
+ * Refer to drivers/acpi/cppc_acpi.c for the description of the functions
+ * below.
+ */
+bool cpc_ffh_supported(void)
+{
+	return freq_counters_valid(get_cpu_with_amu_feat());
+}
+
+int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
+{
+	int ret = -EOPNOTSUPP;
+
+	switch ((u64)reg->address) {
+	case 0x0:
+		ret = counters_read_on_cpu(cpu, store_corecnt, val);
+		break;
+	case 0x1:
+		ret = counters_read_on_cpu(cpu, store_constcnt, val);
+		break;
+	}
+
+	if (!ret) {
+		*val &= GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
+				    reg->bit_offset);
+		*val >>= reg->bit_offset;
+	}
+
+	return ret;
+}
+
+int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_ACPI_CPPC_LIB */
-- 
2.17.1

