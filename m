Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B312A7E8A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 13:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbgKEM11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:27:27 -0500
Received: from foss.arm.com ([217.140.110.172]:59338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgKEM10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:27:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7180A14BF;
        Thu,  5 Nov 2020 04:27:25 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 05E7F3F719;
        Thu,  5 Nov 2020 04:27:23 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org
Cc:     souvik.chakravarty@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com
Subject: [PATCH v3 2/3] arm64: split counter validation function
Date:   Thu,  5 Nov 2020 12:27:01 +0000
Message-Id: <20201105122702.13916-3-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201105122702.13916-1-ionela.voinescu@arm.com>
References: <20201105122702.13916-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for the counter validation function to be reused, split
validate_cpu_freq_invariance_counters() into:
 - freq_counters_valid(cpu) - check cpu for valid cycle counters
 - freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate) -
   generic function that sets the normalization ratio used by
   topology_scale_freq_tick()

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/topology.c | 44 +++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index db03c440e157..764fdb0f947b 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -152,45 +152,49 @@ void update_freq_counters_refs(void)
 	this_cpu_write(arch_const_cycles_prev, read_constcnt());
 }
 
-static int validate_cpu_freq_invariance_counters(int cpu)
+static inline bool freq_counters_valid(int cpu)
 {
-	u64 max_freq_hz, ratio;
-
 	if (!cpu_has_amu_feat(cpu)) {
 		pr_debug("CPU%d: counters are not supported.\n", cpu);
-		return -EINVAL;
+		return false;
 	}
 
 	if (unlikely(!per_cpu(arch_const_cycles_prev, cpu) ||
 		     !per_cpu(arch_core_cycles_prev, cpu))) {
 		pr_debug("CPU%d: cycle counters are not enabled.\n", cpu);
-		return -EINVAL;
+		return false;
 	}
 
-	/* Convert maximum frequency from KHz to Hz and validate */
-	max_freq_hz = cpufreq_get_hw_max_freq(cpu) * 1000;
-	if (unlikely(!max_freq_hz)) {
-		pr_debug("CPU%d: invalid maximum frequency.\n", cpu);
+	return true;
+}
+
+static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
+{
+	u64 ratio;
+
+	if (unlikely(!max_rate || !ref_rate)) {
+		pr_debug("CPU%d: invalid maximum or reference frequency.\n",
+			 cpu);
 		return -EINVAL;
 	}
 
 	/*
 	 * Pre-compute the fixed ratio between the frequency of the constant
-	 * counter and the maximum frequency of the CPU.
+	 * reference counter and the maximum frequency of the CPU.
 	 *
-	 *			      const_freq
-	 * arch_max_freq_scale =   ---------------- * SCHED_CAPACITY_SCALE²
-	 *			   cpuinfo_max_freq
+	 *			    ref_rate
+	 * arch_max_freq_scale =   ---------- * SCHED_CAPACITY_SCALE²
+	 *			    max_rate
 	 *
 	 * We use a factor of 2 * SCHED_CAPACITY_SHIFT -> SCHED_CAPACITY_SCALE²
 	 * in order to ensure a good resolution for arch_max_freq_scale for
-	 * very low arch timer frequencies (down to the KHz range which should
+	 * very low reference frequencies (down to the KHz range which should
 	 * be unlikely).
 	 */
-	ratio = (u64)arch_timer_get_rate() << (2 * SCHED_CAPACITY_SHIFT);
-	ratio = div64_u64(ratio, max_freq_hz);
+	ratio = ref_rate << (2 * SCHED_CAPACITY_SHIFT);
+	ratio = div64_u64(ratio, max_rate);
 	if (!ratio) {
-		WARN_ONCE(1, "System timer frequency too low.\n");
+		WARN_ONCE(1, "Reference frequency too low.\n");
 		return -EINVAL;
 	}
 
@@ -237,8 +241,12 @@ static int __init init_amu_fie(void)
 	}
 
 	for_each_present_cpu(cpu) {
-		if (validate_cpu_freq_invariance_counters(cpu))
+		if (!freq_counters_valid(cpu) ||
+		    freq_inv_set_max_ratio(cpu,
+					   cpufreq_get_hw_max_freq(cpu) * 1000,
+					   arch_timer_get_rate()))
 			continue;
+
 		cpumask_set_cpu(cpu, valid_cpus);
 		have_policy |= enable_policy_freq_counters(cpu, valid_cpus);
 	}
-- 
2.17.1

