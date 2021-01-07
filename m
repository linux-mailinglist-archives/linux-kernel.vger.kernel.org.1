Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6543F2ED008
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 13:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbhAGMk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 07:40:57 -0500
Received: from foss.arm.com ([217.140.110.172]:59954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbhAGMkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 07:40:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86083147A;
        Thu,  7 Jan 2021 04:39:33 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6C0AE3F719;
        Thu,  7 Jan 2021 04:39:32 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, leo.yan@linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v6 14/26] coresight: etm4x: Clean up exception level masks
Date:   Thu,  7 Jan 2021 12:38:47 +0000
Message-Id: <20210107123859.674252-15-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210107123859.674252-1-suzuki.poulose@arm.com>
References: <20210107123859.674252-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

etm4_get_access_type() calculates the exception level bits
for use in address comparator registers. This is also used
by the TRCVICTLR register by shifting to the required position.

This patch cleans up the logic to make etm4_get_access_type()
calcualte a generic mask which can be used by all users by
shifting to their field.

No functional changes intended.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v3:
  - Fix errors in victlr ns_mask setting.
Changes since v2:
  - Fix the duplicate shift. More commentary
---
 .../coresight/coresight-etm4x-core.c          | 47 +++++++++----------
 .../coresight/coresight-etm4x-sysfs.c         | 12 ++---
 drivers/hwtracing/coresight/coresight-etm4x.h | 47 ++++++++++++-------
 3 files changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index ead8f5dd8483..8d696c0aef0d 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -959,20 +959,16 @@ static void etm4_init_arch_data(void *info)
 	etm4_cs_lock(drvdata, csa);
 }
 
+static inline u32 etm4_get_victlr_access_type(struct etmv4_config *config)
+{
+	return etm4_get_access_type(config) << TRCVICTLR_EXLEVEL_SHIFT;
+}
+
 /* Set ELx trace filter access in the TRCVICTLR register */
 static void etm4_set_victlr_access(struct etmv4_config *config)
 {
-	u64 access_type;
-
-	config->vinst_ctrl &= ~(ETM_EXLEVEL_S_VICTLR_MASK | ETM_EXLEVEL_NS_VICTLR_MASK);
-
-	/*
-	 * TRCVICTLR::EXLEVEL_NS:EXLEVELS: Set kernel / user filtering
-	 * bits in vinst_ctrl, same bit pattern as TRCACATRn values returned by
-	 * etm4_get_access_type() but with a relative shift in this register.
-	 */
-	access_type = etm4_get_access_type(config) << ETM_EXLEVEL_LSHIFT_TRCVICTLR;
-	config->vinst_ctrl |= (u32)access_type;
+	config->vinst_ctrl &= ~TRCVICTLR_EXLEVEL_MASK;
+	config->vinst_ctrl |= etm4_get_victlr_access_type(config);
 }
 
 static void etm4_set_default_config(struct etmv4_config *config)
@@ -1002,12 +998,9 @@ static u64 etm4_get_ns_access_type(struct etmv4_config *config)
 	u64 access_type = 0;
 
 	/*
-	 * EXLEVEL_NS, bits[15:12]
-	 * The Exception levels are:
-	 *   Bit[12] Exception level 0 - Application
-	 *   Bit[13] Exception level 1 - OS
-	 *   Bit[14] Exception level 2 - Hypervisor
-	 *   Bit[15] Never implemented
+	 * EXLEVEL_NS, for NonSecure Exception levels.
+	 * The mask here is a generic value and must be
+	 * shifted to the corresponding field for the registers
 	 */
 	if (!is_kernel_in_hyp_mode()) {
 		/* Stay away from hypervisor mode for non-VHE */
@@ -1024,20 +1017,26 @@ static u64 etm4_get_ns_access_type(struct etmv4_config *config)
 	return access_type;
 }
 
+/*
+ * Construct the exception level masks for a given config.
+ * This must be shifted to the corresponding register field
+ * for usage.
+ */
 static u64 etm4_get_access_type(struct etmv4_config *config)
 {
-	u64 access_type = etm4_get_ns_access_type(config);
-
-	/* All supported secure ELs are excluded */
-	access_type |= (u64)config->s_ex_level << TRCACATR_EXLEVEL_SHIFT;
+	/* All Secure exception levels are excluded from the trace */
+	return etm4_get_ns_access_type(config) | (u64)config->s_ex_level;
+}
 
-	return access_type;
+static u64 etm4_get_comparator_access_type(struct etmv4_config *config)
+{
+	return etm4_get_access_type(config) << TRCACATR_EXLEVEL_SHIFT;
 }
 
 static void etm4_set_comparator_filter(struct etmv4_config *config,
 				       u64 start, u64 stop, int comparator)
 {
-	u64 access_type = etm4_get_access_type(config);
+	u64 access_type = etm4_get_comparator_access_type(config);
 
 	/* First half of default address comparator */
 	config->addr_val[comparator] = start;
@@ -1072,7 +1071,7 @@ static void etm4_set_start_stop_filter(struct etmv4_config *config,
 				       enum etm_addr_type type)
 {
 	int shift;
-	u64 access_type = etm4_get_access_type(config);
+	u64 access_type = etm4_get_comparator_access_type(config);
 
 	/* Configure the comparator */
 	config->addr_val[comparator] = address;
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index fce9df16bfb5..009818675928 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -743,7 +743,7 @@ static ssize_t s_exlevel_vinst_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
-	val = (config->vinst_ctrl & ETM_EXLEVEL_S_VICTLR_MASK) >> 16;
+	val = (config->vinst_ctrl & TRCVICTLR_EXLEVEL_S_MASK) >> TRCVICTLR_EXLEVEL_S_SHIFT;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -760,10 +760,10 @@ static ssize_t s_exlevel_vinst_store(struct device *dev,
 
 	spin_lock(&drvdata->spinlock);
 	/* clear all EXLEVEL_S bits  */
-	config->vinst_ctrl &= ~(ETM_EXLEVEL_S_VICTLR_MASK);
+	config->vinst_ctrl &= ~(TRCVICTLR_EXLEVEL_S_MASK);
 	/* enable instruction tracing for corresponding exception level */
 	val &= drvdata->s_ex_level;
-	config->vinst_ctrl |= (val << 16);
+	config->vinst_ctrl |= (val << TRCVICTLR_EXLEVEL_S_SHIFT);
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -778,7 +778,7 @@ static ssize_t ns_exlevel_vinst_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	/* EXLEVEL_NS, bits[23:20] */
-	val = (config->vinst_ctrl & ETM_EXLEVEL_NS_VICTLR_MASK) >> 20;
+	val = (config->vinst_ctrl & TRCVICTLR_EXLEVEL_NS_MASK) >> TRCVICTLR_EXLEVEL_NS_SHIFT;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -795,10 +795,10 @@ static ssize_t ns_exlevel_vinst_store(struct device *dev,
 
 	spin_lock(&drvdata->spinlock);
 	/* clear EXLEVEL_NS bits  */
-	config->vinst_ctrl &= ~(ETM_EXLEVEL_NS_VICTLR_MASK);
+	config->vinst_ctrl &= ~(TRCVICTLR_EXLEVEL_NS_MASK);
 	/* enable instruction tracing for corresponding exception level */
 	val &= drvdata->ns_ex_level;
-	config->vinst_ctrl |= (val << 20);
+	config->vinst_ctrl |= (val << TRCVICTLR_EXLEVEL_NS_SHIFT);
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 0b7bdfd1e1b2..841a3fe88f39 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -552,24 +552,39 @@
 
 #define TRCACATR_EXLEVEL_SHIFT		8
 
-/* secure state access levels - TRCACATRn */
-#define ETM_EXLEVEL_S_APP		BIT(8)
-#define ETM_EXLEVEL_S_OS		BIT(9)
-#define ETM_EXLEVEL_S_HYP		BIT(10)
-#define ETM_EXLEVEL_S_MON		BIT(11)
-/* non-secure state access levels - TRCACATRn */
-#define ETM_EXLEVEL_NS_APP		BIT(12)
-#define ETM_EXLEVEL_NS_OS		BIT(13)
-#define ETM_EXLEVEL_NS_HYP		BIT(14)
-#define ETM_EXLEVEL_NS_NA		BIT(15)
-
-/* access level control in TRCVICTLR - same bits as TRCACATRn but shifted */
-#define ETM_EXLEVEL_LSHIFT_TRCVICTLR	8
+/*
+ * Exception level mask for Secure and Non-Secure ELs.
+ * ETM defines the bits for EL control (e.g, TRVICTLR, TRCACTRn).
+ * The Secure and Non-Secure ELs are always to gether.
+ * Non-secure EL3 is never implemented.
+ * We use the following generic mask as they appear in different
+ * registers and this can be shifted for the appropriate
+ * fields.
+ */
+#define ETM_EXLEVEL_S_APP		BIT(0)	/* Secure EL0		*/
+#define ETM_EXLEVEL_S_OS		BIT(1)	/* Secure EL1		*/
+#define ETM_EXLEVEL_S_HYP		BIT(2)	/* Secure EL2		*/
+#define ETM_EXLEVEL_S_MON		BIT(3)	/* Secure EL3/Monitor	*/
+#define ETM_EXLEVEL_NS_APP		BIT(4)	/* NonSecure EL0	*/
+#define ETM_EXLEVEL_NS_OS		BIT(5)	/* NonSecure EL1	*/
+#define ETM_EXLEVEL_NS_HYP		BIT(6)	/* NonSecure EL2	*/
+
+#define ETM_EXLEVEL_MASK		(GENMASK(6, 0))
+#define ETM_EXLEVEL_S_MASK		(GENMASK(3, 0))
+#define ETM_EXLEVEL_NS_MASK		(GENMASK(6, 4))
+
+/* access level controls in TRCACATRn */
+#define TRCACATR_EXLEVEL_SHIFT		8
+
+/* access level control in TRCVICTLR */
+#define TRCVICTLR_EXLEVEL_SHIFT		16
+#define TRCVICTLR_EXLEVEL_S_SHIFT	16
+#define TRCVICTLR_EXLEVEL_NS_SHIFT	20
 
 /* secure / non secure masks - TRCVICTLR, IDR3 */
-#define ETM_EXLEVEL_S_VICTLR_MASK	GENMASK(19, 16)
-/* NS MON (EL3) mode never implemented */
-#define ETM_EXLEVEL_NS_VICTLR_MASK	GENMASK(22, 20)
+#define TRCVICTLR_EXLEVEL_MASK		(ETM_EXLEVEL_MASK << TRCVICTLR_EXLEVEL_SHIFT)
+#define TRCVICTLR_EXLEVEL_S_MASK	(ETM_EXLEVEL_S_MASK << TRCVICTLR_EXLEVEL_SHIFT)
+#define TRCVICTLR_EXLEVEL_NS_MASK	(ETM_EXLEVEL_NS_MASK << TRCVICTLR_EXLEVEL_SHIFT)
 
 /* Interpretation of resource numbers change at ETM v4.3 architecture */
 #define ETM4X_ARCH_4V3	0x43
-- 
2.24.1

