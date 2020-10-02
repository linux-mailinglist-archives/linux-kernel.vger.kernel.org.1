Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117FF28102B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 11:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387735AbgJBJ4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 05:56:01 -0400
Received: from foss.arm.com ([217.140.110.172]:59220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgJBJz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 05:55:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8AA51042;
        Fri,  2 Oct 2020 02:55:58 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4C9C23F73B;
        Fri,  2 Oct 2020 02:55:57 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com
Cc:     morten.rasmussen@arm.com, valentin.schneider@arm.com,
        souvik.chakravarty@arm.com, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: implement CPPC FFH support using AMUs
Date:   Fri,  2 Oct 2020 10:55:32 +0100
Message-Id: <20201002095532.6445-4-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002095532.6445-1-ionela.voinescu@arm.com>
References: <20201002095532.6445-1-ionela.voinescu@arm.com>
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
 arch/arm64/include/asm/cpufeature.h |  6 ++++
 arch/arm64/kernel/cpufeature.c      |  5 +++
 arch/arm64/kernel/topology.c        | 54 +++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 42187f424e11..9f4bdd2b26bf 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -741,9 +741,15 @@ static inline bool cpu_has_hw_af(void)
 }
 
 #ifdef CONFIG_ARM64_AMU_EXTN
+/* Get a cpu that supports the Activity Monitors Unit (AMU) */
+extern int get_cpu_with_amu_feat(void);
 /* Check whether the cpu supports the Activity Monitors Unit (AMU) */
 extern bool cpu_has_amu_feat(int cpu);
 #else
+static inline int get_cpu_with_amu_feat(void)
+{
+	return nr_cpu_ids;
+}
 static inline bool cpu_has_amu_feat(int cpu)
 {
 	return false;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 26f76c277ca3..114710820aa3 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1525,6 +1525,11 @@ bool cpu_has_amu_feat(int cpu)
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

