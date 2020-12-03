Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314642CD8CB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbgLCORE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:17:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8628 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgLCORD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:17:03 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CmyYN3B3sz15WyR;
        Thu,  3 Dec 2020 22:15:52 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Dec 2020 22:16:13 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>
Subject: [PATCH v4] drivers/perf: Add support for ARMv8.3-SPE
Date:   Thu, 3 Dec 2020 22:16:09 +0800
Message-ID: <20201203141609.14148-1-liwei391@huawei.com>
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
alignment event in SPE driver.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
v3 -> v4:
 - Return the highest supported version in default in arm_spe_pmsevfr_res0().
 - Drop the exposing of 'pmsver'.
   (Suggested by Will.)
---
v2 -> v3:
 - Make the definition of 'pmsevfr_res0' progressive and easy to check.
   (Suggested by Will.)
---
v1 -> v2:
 - Rename 'pmuver' to 'pmsver', change it's type to 'u16' from 'int'.
   (Suggested by Will and Leo.)
 - Expose 'pmsver' as cap attribute through sysfs, instead of printing.
   (Suggested by Will.)
---
 arch/arm64/include/asm/sysreg.h |  9 ++++++++-
 drivers/perf/arm_spe_pmu.c      | 17 +++++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index d52c1b3ce589..57e5aee6f7e6 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -287,7 +287,11 @@
 #define SYS_PMSFCR_EL1_ST_SHIFT		18
 
 #define SYS_PMSEVFR_EL1			sys_reg(3, 0, 9, 9, 5)
-#define SYS_PMSEVFR_EL1_RES0		0x0000ffff00ff0f55UL
+#define SYS_PMSEVFR_EL1_RES0_8_2	\
+	(GENMASK_ULL(47, 32) | GENMASK_ULL(23, 16) | GENMASK_ULL(11, 8) |\
+	 BIT_ULL(6) | BIT_ULL(4) | BIT_ULL(2) | BIT_ULL(0))
+#define SYS_PMSEVFR_EL1_RES0_8_3	\
+	(SYS_PMSEVFR_EL1_RES0_8_2 & ~(BIT_ULL(18) | BIT_ULL(17) | BIT_ULL(11)))
 
 #define SYS_PMSLATFR_EL1		sys_reg(3, 0, 9, 9, 6)
 #define SYS_PMSLATFR_EL1_MINLAT_SHIFT	0
@@ -829,6 +833,9 @@
 #define ID_AA64DFR0_PMUVER_8_5		0x6
 #define ID_AA64DFR0_PMUVER_IMP_DEF	0xf
 
+#define ID_AA64DFR0_PMSVER_8_2		0x1
+#define ID_AA64DFR0_PMSVER_8_3		0x2
+
 #define ID_DFR0_PERFMON_SHIFT		24
 
 #define ID_DFR0_PERFMON_8_1		0x4
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index cc00915ad6d1..bce9aff9f546 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -54,7 +54,7 @@ struct arm_spe_pmu {
 	struct hlist_node			hotplug_node;
 
 	int					irq; /* PPI */
-
+	u16					pmsver;
 	u16					min_period;
 	u16					counter_sz;
 
@@ -655,6 +655,18 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static u64 arm_spe_pmsevfr_res0(u16 pmsver)
+{
+	switch (pmsver) {
+	case ID_AA64DFR0_PMSVER_8_2:
+		return SYS_PMSEVFR_EL1_RES0_8_2;
+	case ID_AA64DFR0_PMSVER_8_3:
+	/* Return the highest version we support in default */
+	default:
+		return SYS_PMSEVFR_EL1_RES0_8_3;
+	}
+}
+
 /* Perf callbacks */
 static int arm_spe_pmu_event_init(struct perf_event *event)
 {
@@ -670,7 +682,7 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
 		return -ENOENT;
 
-	if (arm_spe_event_to_pmsevfr(event) & SYS_PMSEVFR_EL1_RES0)
+	if (arm_spe_event_to_pmsevfr(event) & arm_spe_pmsevfr_res0(spe_pmu->pmsver))
 		return -EOPNOTSUPP;
 
 	if (attr->exclude_idle)
@@ -937,6 +949,7 @@ static void __arm_spe_pmu_dev_probe(void *info)
 			fld, smp_processor_id());
 		return;
 	}
+	spe_pmu->pmsver = (u16)fld;
 
 	/* Read PMBIDR first to determine whether or not we have access */
 	reg = read_sysreg_s(SYS_PMBIDR_EL1);
-- 
2.17.1

