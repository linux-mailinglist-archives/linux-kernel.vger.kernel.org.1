Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447FE2F0A1D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 23:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbhAJWu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 17:50:58 -0500
Received: from foss.arm.com ([217.140.110.172]:39068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbhAJWu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 17:50:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D773F1509;
        Sun, 10 Jan 2021 14:49:28 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 884EC3F719;
        Sun, 10 Jan 2021 14:49:27 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        jonathan.zhouwen@huawei.com, catalin.marinas@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v7 17/28] coresight: etm4x: Handle ETM architecture version
Date:   Sun, 10 Jan 2021 22:48:39 +0000
Message-Id: <20210110224850.1880240-18-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210110224850.1880240-1-suzuki.poulose@arm.com>
References: <20210110224850.1880240-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are about to rely on TRCDEVARCH for detecting the ETM
and its architecture version, falling back to TRCIDR1 if
the former is not implemented (in older broken implementations).

Also, we use the architecture version information to
make some decisions. Streamline the architecture version
handling by adding helpers.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-etm4x-core.c          |  2 +-
 drivers/hwtracing/coresight/coresight-etm4x.h | 60 ++++++++++++++++++-
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 548bd71c2168..862b424aef26 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -917,7 +917,7 @@ static void etm4_init_arch_data(void *info)
 	 * Otherwise for values 0x1 and above the number is N + 1 as per v4.2.
 	 */
 	drvdata->nr_resource = BMVAL(etmidr4, 16, 19);
-	if ((drvdata->arch < ETM4X_ARCH_4V3) || (drvdata->nr_resource > 0))
+	if ((drvdata->arch < ETM_ARCH_V4_3) || (drvdata->nr_resource > 0))
 		drvdata->nr_resource += 1;
 	/*
 	 * NUMSSCC, bits[23:20] the number of single-shot
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 91b82002e260..0af60571aa23 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -468,7 +468,6 @@
 #define ETM_MAX_RES_SEL			32
 #define ETM_MAX_SS_CMP			8
 
-#define ETM_ARCH_V4			0x40
 #define ETMv4_SYNC_MASK			0x1F
 #define ETM_CYC_THRESHOLD_MASK		0xFFF
 #define ETM_CYC_THRESHOLD_DEFAULT       0x100
@@ -593,8 +592,63 @@
 #define TRCVICTLR_EXLEVEL_S_MASK	(ETM_EXLEVEL_S_MASK << TRCVICTLR_EXLEVEL_SHIFT)
 #define TRCVICTLR_EXLEVEL_NS_MASK	(ETM_EXLEVEL_NS_MASK << TRCVICTLR_EXLEVEL_SHIFT)
 
+#define ETM_TRCIDR1_ARCH_MAJOR_SHIFT	8
+#define ETM_TRCIDR1_ARCH_MAJOR_MASK	(0xfU << ETM_TRCIDR1_ARCH_MAJOR_SHIFT)
+#define ETM_TRCIDR1_ARCH_MAJOR(x)	\
+	(((x) & ETM_TRCIDR1_ARCH_MAJOR_MASK) >> ETM_TRCIDR1_ARCH_MAJOR_SHIFT)
+#define ETM_TRCIDR1_ARCH_MINOR_SHIFT	4
+#define ETM_TRCIDR1_ARCH_MINOR_MASK	(0xfU << ETM_TRCIDR1_ARCH_MINOR_SHIFT)
+#define ETM_TRCIDR1_ARCH_MINOR(x)	\
+	(((x) & ETM_TRCIDR1_ARCH_MINOR_MASK) >> ETM_TRCIDR1_ARCH_MINOR_SHIFT)
+#define ETM_TRCIDR1_ARCH_SHIFT		ETM_TRCIDR1_ARCH_MINOR_SHIFT
+#define ETM_TRCIDR1_ARCH_MASK		\
+	(ETM_TRCIDR1_ARCH_MAJOR_MASK | ETM_TRCIDR1_ARCH_MINOR_MASK)
+
+#define ETM_TRCIDR1_ARCH_ETMv4		0x4
+
+/*
+ * Driver representation of the ETM architecture.
+ * The version of an ETM component can be detected from
+ *
+ * TRCDEVARCH	- CoreSight architected register
+ *                - Bits[15:12] - Major version
+ *                - Bits[19:16] - Minor version
+ * TRCIDR1	- ETM architected register
+ *                - Bits[11:8] - Major version
+ *                - Bits[7:4]  - Minor version
+ * We must rely on TRCDEVARCH for the version information,
+ * however we don't want to break the support for potential
+ * old implementations which might not implement it. Thus
+ * we fall back to TRCIDR1 if TRCDEVARCH is not implemented
+ * for memory mapped components.
+ * Now to make certain decisions easier based on the version
+ * we use an internal representation of the version in the
+ * driver, as follows :
+ *
+ * ETM_ARCH_VERSION[7:0], where :
+ *      Bits[7:4] - Major version
+ *      Bits[3:0] - Minro version
+ */
+#define ETM_ARCH_VERSION(major, minor)		\
+	((((major) & 0xfU) << 4) | (((minor) & 0xfU)))
+#define ETM_ARCH_MAJOR_VERSION(arch)	(((arch) >> 4) & 0xfU)
+#define ETM_ARCH_MINOR_VERSION(arch)	((arch) & 0xfU)
+
+#define ETM_ARCH_V4	ETM_ARCH_VERSION(4, 0)
 /* Interpretation of resource numbers change at ETM v4.3 architecture */
-#define ETM4X_ARCH_4V3	0x43
+#define ETM_ARCH_V4_3	ETM_ARCH_VERSION(4, 3)
+
+static inline u8 etm_devarch_to_arch(u32 devarch)
+{
+	return ETM_ARCH_VERSION(ETM_DEVARCH_ARCHID_ARCH_VER(devarch),
+				ETM_DEVARCH_REVISION(devarch));
+}
+
+static inline u8 etm_trcidr_to_arch(u32 trcidr1)
+{
+	return ETM_ARCH_VERSION(ETM_TRCIDR1_ARCH_MAJOR(trcidr1),
+				ETM_TRCIDR1_ARCH_MINOR(trcidr1));
+}
 
 enum etm_impdef_type {
 	ETM4_IMPDEF_HISI_CORE_COMMIT,
@@ -761,7 +815,7 @@ struct etmv4_save_state {
  * @spinlock:   Only one at a time pls.
  * @mode:	This tracer's mode, i.e sysFS, Perf or disabled.
  * @cpu:        The cpu this component is affined to.
- * @arch:       ETM version number.
+ * @arch:       ETM architecture version.
  * @nr_pe:	The number of processing entity available for tracing.
  * @nr_pe_cmp:	The number of processing entity comparator inputs that are
  *		available for tracing.
-- 
2.24.1

