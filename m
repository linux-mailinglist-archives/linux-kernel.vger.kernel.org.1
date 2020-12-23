Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6ECF2E1AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 11:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgLWKFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 05:05:14 -0500
Received: from foss.arm.com ([217.140.110.172]:48050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbgLWKFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 05:05:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56925143D;
        Wed, 23 Dec 2020 02:03:57 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A02243F718;
        Wed, 23 Dec 2020 02:03:54 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Linu Cherian <lcherian@marvell.com>
Subject: [PATCH 05/11] coresight: ete: Add support for ETE tracing
Date:   Wed, 23 Dec 2020 15:33:37 +0530
Message-Id: <1608717823-18387-6-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608717823-18387-1-git-send-email-anshuman.khandual@arm.com>
References: <1608717823-18387-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Add ETE as one of the supported device types we support
with ETM4x driver. The devices are named following the
existing convention as ete<N>.

ETE mandates that the trace resource status register is programmed
before the tracing is turned on. For the moment simply write to
it indicating TraceActive.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 56 +++++++++++++++++-----
 drivers/hwtracing/coresight/coresight-etm4x.h      |  7 +++
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index dff502f..1af6ae0 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -333,6 +333,13 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 		etm4x_relaxed_write32(csa, trcpdcr | TRCPDCR_PU, TRCPDCR);
 	}
 
+	/*
+	 * ETE mandates that the TRCRSR is written to before
+	 * enabling it.
+	 */
+	if (drvdata->arch >= ETM_ARCH_ETE)
+		etm4x_relaxed_write32(csa, TRCRSR_TA, TRCRSR);
+
 	/* Enable the trace unit */
 	etm4x_relaxed_write32(csa, 1, TRCPRGCTLR);
 
@@ -765,13 +772,24 @@ static bool etm4_init_sysreg_access(struct etmv4_drvdata *drvdata,
 	 * ETMs implementing sysreg access must implement TRCDEVARCH.
 	 */
 	devarch = read_etm4x_sysreg_const_offset(TRCDEVARCH);
-	if ((devarch & ETM_DEVARCH_ID_MASK) != ETM_DEVARCH_ETMv4x_ARCH)
+	switch (devarch & ETM_DEVARCH_ID_MASK) {
+	case ETM_DEVARCH_ETMv4x_ARCH:
+		*csa = (struct csdev_access) {
+			.io_mem	= false,
+			.read	= etm4x_sysreg_read,
+			.write	= etm4x_sysreg_write,
+		};
+		break;
+	case ETM_DEVARCH_ETE_ARCH:
+		*csa = (struct csdev_access) {
+			.io_mem	= false,
+			.read	= ete_sysreg_read,
+			.write	= ete_sysreg_write,
+		};
+		break;
+	default:
 		return false;
-	*csa = (struct csdev_access) {
-		.io_mem	= false,
-		.read	= etm4x_sysreg_read,
-		.write	= etm4x_sysreg_write,
-	};
+	}
 
 	drvdata->arch = etm_devarch_to_arch(devarch);
 	return true;
@@ -1707,6 +1725,8 @@ static int etm4_probe(struct device *dev, void __iomem *base)
 	struct etmv4_drvdata *drvdata;
 	struct coresight_desc desc = { 0 };
 	struct etm4_init_arg init_arg = { 0 };
+	u8 major, minor;
+	char *type_name;
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
@@ -1733,10 +1753,6 @@ static int etm4_probe(struct device *dev, void __iomem *base)
 	if (drvdata->cpu < 0)
 		return drvdata->cpu;
 
-	desc.name = devm_kasprintf(dev, GFP_KERNEL, "etm%d", drvdata->cpu);
-	if (!desc.name)
-		return -ENOMEM;
-
 	init_arg.drvdata = drvdata;
 	init_arg.csa = &desc.access;
 
@@ -1751,6 +1767,20 @@ static int etm4_probe(struct device *dev, void __iomem *base)
 	if (!desc.access.io_mem ||
 	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
 		drvdata->skip_power_up = true;
+	major = ETM_ARCH_MAJOR_VERSION(drvdata->arch);
+	minor = ETM_ARCH_MINOR_VERSION(drvdata->arch);
+	if (drvdata->arch >= ETM_ARCH_ETE) {
+		type_name = "ete";
+		/* ETE v1 has major version == 5. Adjust this for logging.*/
+		major -= 4;
+	} else {
+		type_name = "etm";
+	}
+
+	desc.name = devm_kasprintf(dev, GFP_KERNEL,
+				   "%s%d", type_name, drvdata->cpu);
+	if (!desc.name)
+		return -ENOMEM;
 
 	etm4_init_trace_id(drvdata);
 	etm4_set_default(&drvdata->config);
@@ -1779,9 +1809,8 @@ static int etm4_probe(struct device *dev, void __iomem *base)
 
 	etmdrvdata[drvdata->cpu] = drvdata;
 
-	dev_info(&drvdata->csdev->dev, "CPU%d: ETM v%d.%d initialized\n",
-		 drvdata->cpu, ETM_ARCH_MAJOR_VERSION(drvdata->arch),
-		 ETM_ARCH_MINOR_VERSION(drvdata->arch));
+	dev_info(&drvdata->csdev->dev, "CPU%d: %s v%d.%d initialized\n",
+		 drvdata->cpu, type_name, major, minor);
 
 	if (boot_enable) {
 		coresight_enable(drvdata->csdev);
@@ -1918,6 +1947,7 @@ static struct amba_driver etm4x_amba_driver = {
 
 static const struct of_device_id etm4_sysreg_match[] = {
 	{ .compatible	= "arm,coresight-etm4x-sysreg" },
+	{ .compatible	= "arm,embedded-trace-extension" },
 	{}
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 6f64f08..96073f5 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -127,6 +127,8 @@
 #define TRCCIDR2			0xFF8
 #define TRCCIDR3			0xFFC
 
+#define TRCRSR_TA			BIT(12)
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
@@ -571,11 +573,14 @@
 	((ETM_DEVARCH_MAKE_ARCHID_ARCH_VER(major)) | ETM_DEVARCH_ARCHID_ARCH_PART(0xA13))
 
 #define ETM_DEVARCH_ARCHID_ETMv4x		ETM_DEVARCH_MAKE_ARCHID(0x4)
+#define ETM_DEVARCH_ARCHID_ETE			ETM_DEVARCH_MAKE_ARCHID(0x5)
 
 #define ETM_DEVARCH_ID_MASK						\
 	(ETM_DEVARCH_ARCHITECT_MASK | ETM_DEVARCH_ARCHID_MASK | ETM_DEVARCH_PRESENT)
 #define ETM_DEVARCH_ETMv4x_ARCH						\
 	(ETM_DEVARCH_ARCHITECT_ARM | ETM_DEVARCH_ARCHID_ETMv4x | ETM_DEVARCH_PRESENT)
+#define ETM_DEVARCH_ETE_ARCH						\
+	(ETM_DEVARCH_ARCHITECT_ARM | ETM_DEVARCH_ARCHID_ETE | ETM_DEVARCH_PRESENT)
 
 #define TRCSTATR_IDLE_BIT		0
 #define TRCSTATR_PMSTABLE_BIT		1
@@ -665,6 +670,8 @@
 #define ETM_ARCH_MINOR_VERSION(arch)	((arch) & 0xfU)
 
 #define ETM_ARCH_V4	ETM_ARCH_VERSION(4, 0)
+#define ETM_ARCH_ETE	ETM_ARCH_VERSION(5, 0)
+
 /* Interpretation of resource numbers change at ETM v4.3 architecture */
 #define ETM_ARCH_V4_3	ETM_ARCH_VERSION(4, 3)
 
-- 
2.7.4

