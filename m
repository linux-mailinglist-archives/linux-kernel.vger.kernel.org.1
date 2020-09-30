Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D25F27E534
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgI3Jdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:33:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48304 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbgI3Jdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:33:41 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 532C016F16B06CA127DE;
        Wed, 30 Sep 2020 17:33:37 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 30 Sep 2020 17:32:35 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [PATCH v2] drivers/perf: Add support for ARMv8.3-SPE
Date:   Wed, 30 Sep 2020 17:31:35 +0800
Message-ID: <20200930093136.30301-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Armv8.3 extends the SPE by adding:
- Alignment field in the Events packet, and filtering on this event
  using PMSEVFR_EL1.
- Support for the Scalable Vector Extension (SVE).

The main additions for SVE are:
- Recording the vector length for SVE operations in the Operation Type
  packet. It is not possible to filter on vector length.
- Incomplete predicate and empty predicate fields in the Events packet,
  and filtering on these events using PMSEVFR_EL1.

Update the check of pmsevfr for empty/partial predicated SVE and
alignment event in SPE driver. For adaption by the version of SPE,
expose 'pmsver' as cap attribute to userspace.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
v1 -> v2:
 - Rename 'pmuver' to 'pmsver', change it's type to 'u16' from 'int'.
   (Suggested by Will and Leo.)
 - Expose 'pmsver' as cap attribute through sysfs, instead of printing.
   (Suggested by Will.)
---
 arch/arm64/include/asm/sysreg.h |  4 +++-
 drivers/perf/arm_spe_pmu.c      | 18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 554a7e8ecb07..f4f9c1fc6398 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -281,7 +281,6 @@
 #define SYS_PMSFCR_EL1_ST_SHIFT		18
 
 #define SYS_PMSEVFR_EL1			sys_reg(3, 0, 9, 9, 5)
-#define SYS_PMSEVFR_EL1_RES0		0x0000ffff00ff0f55UL
 
 #define SYS_PMSLATFR_EL1		sys_reg(3, 0, 9, 9, 6)
 #define SYS_PMSLATFR_EL1_MINLAT_SHIFT	0
@@ -787,6 +786,9 @@
 #define ID_AA64DFR0_PMUVER_8_5		0x6
 #define ID_AA64DFR0_PMUVER_IMP_DEF	0xf
 
+#define ID_AA64DFR0_PMSVER_8_2		0x1
+#define ID_AA64DFR0_PMSVER_8_3		0x2
+
 #define ID_DFR0_PERFMON_SHIFT		24
 
 #define ID_DFR0_PERFMON_8_1		0x4
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index cc00915ad6d1..52e7869f5621 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -54,7 +54,7 @@ struct arm_spe_pmu {
 	struct hlist_node			hotplug_node;
 
 	int					irq; /* PPI */
-
+	u16					pmsver;
 	u16					min_period;
 	u16					counter_sz;
 
@@ -80,6 +80,15 @@ struct arm_spe_pmu {
 /* Keep track of our dynamic hotplug state */
 static enum cpuhp_state arm_spe_pmu_online;
 
+static u64 sys_pmsevfr_el1_mask[] = {
+	[ID_AA64DFR0_PMSVER_8_2] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
+		GENMASK_ULL(15, 12) | BIT_ULL(7) | BIT_ULL(5) | BIT_ULL(3) |
+		BIT_ULL(1),
+	[ID_AA64DFR0_PMSVER_8_3] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
+		GENMASK_ULL(18, 17) | GENMASK_ULL(15, 11) | BIT_ULL(7) |
+		BIT_ULL(5) | BIT_ULL(3) | BIT_ULL(1),
+};
+
 enum arm_spe_pmu_buf_fault_action {
 	SPE_PMU_BUF_FAULT_ACT_SPURIOUS,
 	SPE_PMU_BUF_FAULT_ACT_FATAL,
@@ -93,6 +102,7 @@ enum arm_spe_pmu_capabilities {
 	SPE_PMU_CAP_FEAT_MAX,
 	SPE_PMU_CAP_CNT_SZ = SPE_PMU_CAP_FEAT_MAX,
 	SPE_PMU_CAP_MIN_IVAL,
+	SPE_PMU_CAP_PMSVER,
 };
 
 static int arm_spe_pmu_feat_caps[SPE_PMU_CAP_FEAT_MAX] = {
@@ -110,6 +120,8 @@ static u32 arm_spe_pmu_cap_get(struct arm_spe_pmu *spe_pmu, int cap)
 		return spe_pmu->counter_sz;
 	case SPE_PMU_CAP_MIN_IVAL:
 		return spe_pmu->min_period;
+	case SPE_PMU_CAP_PMSVER:
+		return spe_pmu->pmsver;
 	default:
 		WARN(1, "unknown cap %d\n", cap);
 	}
@@ -143,6 +155,7 @@ static struct attribute *arm_spe_pmu_cap_attr[] = {
 	SPE_CAP_EXT_ATTR_ENTRY(ernd, SPE_PMU_CAP_ERND),
 	SPE_CAP_EXT_ATTR_ENTRY(count_size, SPE_PMU_CAP_CNT_SZ),
 	SPE_CAP_EXT_ATTR_ENTRY(min_interval, SPE_PMU_CAP_MIN_IVAL),
+	SPE_CAP_EXT_ATTR_ENTRY(pmsver, SPE_PMU_CAP_PMSVER),
 	NULL,
 };
 
@@ -670,7 +683,7 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
 		return -ENOENT;
 
-	if (arm_spe_event_to_pmsevfr(event) & SYS_PMSEVFR_EL1_RES0)
+	if (arm_spe_event_to_pmsevfr(event) & ~sys_pmsevfr_el1_mask[spe_pmu->pmsver])
 		return -EOPNOTSUPP;
 
 	if (attr->exclude_idle)
@@ -937,6 +950,7 @@ static void __arm_spe_pmu_dev_probe(void *info)
 			fld, smp_processor_id());
 		return;
 	}
+	spe_pmu->pmsver = (u16)fld;
 
 	/* Read PMBIDR first to determine whether or not we have access */
 	reg = read_sysreg_s(SYS_PMBIDR_EL1);
-- 
2.17.1

