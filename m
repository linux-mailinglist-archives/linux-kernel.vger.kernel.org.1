Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219D92F4307
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 05:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbhAMETx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 23:19:53 -0500
Received: from foss.arm.com ([217.140.110.172]:57994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbhAMETw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 23:19:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E895139F;
        Tue, 12 Jan 2021 20:18:37 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B62B23F719;
        Tue, 12 Jan 2021 20:18:34 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linu Cherian <lcherian@marvell.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 05/11] coresight: ete: Add support for ETE tracing
Date:   Wed, 13 Jan 2021 09:48:12 +0530
Message-Id: <1610511498-4058-6-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610511498-4058-1-git-send-email-anshuman.khandual@arm.com>
References: <1610511498-4058-1-git-send-email-anshuman.khandual@arm.com>
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
Changes in V2:

- Update Kconfig title and description to include ETE
- Filter out registers not implemented in ETE from sysfs

 drivers/hwtracing/coresight/Kconfig                | 10 ++--
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 56 +++++++++++++++++-----
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    | 19 ++++++--
 drivers/hwtracing/coresight/coresight-etm4x.h      | 16 ++++++-
 4 files changed, 79 insertions(+), 22 deletions(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 7b44ba2..f154ae7 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -97,15 +97,15 @@ config CORESIGHT_SOURCE_ETM3X
 	  module will be called coresight-etm3x.
 
 config CORESIGHT_SOURCE_ETM4X
-	tristate "CoreSight Embedded Trace Macrocell 4.x driver"
+	tristate "CoreSight ETMv4.x / ETE driver"
 	depends on ARM64
 	select CORESIGHT_LINKS_AND_SINKS
 	select PID_IN_CONTEXTIDR
 	help
-	  This driver provides support for the ETM4.x tracer module, tracing the
-	  instructions that a processor is executing. This is primarily useful
-	  for instruction level tracing. Depending on the implemented version
-	  data tracing may also be available.
+	  This driver provides support for the CoreSight Embedded Trace Macrocell
+	  version 4.x and the Embedded Trace Extensions (ETE). Both are CPU tracer
+	  modules, tracing the instructions that a processor is executing. This is
+	  primarily useful for instruction level tracing.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called coresight-etm4x.
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 4305dc2..1c1b13d 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -431,6 +431,13 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 		etm4x_relaxed_write32(csa, trcpdcr | TRCPDCR_PU, TRCPDCR);
 	}
 
+	/*
+	 * ETE mandates that the TRCRSR is written to before
+	 * enabling it.
+	 */
+	if (etm4x_is_ete(drvdata))
+		etm4x_relaxed_write32(csa, TRCRSR_TA, TRCRSR);
+
 	/* Enable the trace unit */
 	etm4x_relaxed_write32(csa, 1, TRCPRGCTLR);
 
@@ -864,13 +871,24 @@ static bool etm4_init_sysreg_access(struct etmv4_drvdata *drvdata,
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
@@ -1808,6 +1826,8 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 	struct etmv4_drvdata *drvdata;
 	struct coresight_desc desc = { 0 };
 	struct etm4_init_arg init_arg = { 0 };
+	u8 major, minor;
+	char *type_name;
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
@@ -1834,10 +1854,6 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 	if (drvdata->cpu < 0)
 		return drvdata->cpu;
 
-	desc.name = devm_kasprintf(dev, GFP_KERNEL, "etm%d", drvdata->cpu);
-	if (!desc.name)
-		return -ENOMEM;
-
 	init_arg.drvdata = drvdata;
 	init_arg.csa = &desc.access;
 	init_arg.pid = etm_pid;
@@ -1853,6 +1869,20 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 	if (!desc.access.io_mem ||
 	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
 		drvdata->skip_power_up = true;
+	major = ETM_ARCH_MAJOR_VERSION(drvdata->arch);
+	minor = ETM_ARCH_MINOR_VERSION(drvdata->arch);
+	if (etm4x_is_ete(drvdata)) {
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
@@ -1881,9 +1911,8 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 
 	etmdrvdata[drvdata->cpu] = drvdata;
 
-	dev_info(&drvdata->csdev->dev, "CPU%d: ETM v%d.%d initialized\n",
-		 drvdata->cpu, ETM_ARCH_MAJOR_VERSION(drvdata->arch),
-		 ETM_ARCH_MINOR_VERSION(drvdata->arch));
+	dev_info(&drvdata->csdev->dev, "CPU%d: %s v%d.%d initialized\n",
+		 drvdata->cpu, type_name, major, minor);
 
 	if (boot_enable) {
 		coresight_enable(drvdata->csdev);
@@ -2025,6 +2054,7 @@ static struct amba_driver etm4x_amba_driver = {
 
 static const struct of_device_id etm4_sysreg_match[] = {
 	{ .compatible	= "arm,coresight-etm4x-sysreg" },
+	{ .compatible	= "arm,embedded-trace-extension" },
 	{}
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index b646d53..1c490bc 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2374,12 +2374,20 @@ static inline bool
 etm4x_register_implemented(struct etmv4_drvdata *drvdata, u32 offset)
 {
 	switch (offset) {
-	ETM4x_SYSREG_LIST_CASES
+	ETM_COMMON_SYSREG_LIST_CASES
 		/*
-		 * Registers accessible via system instructions are always
-		 * implemented.
+		 * Common registers to ETE & ETM4x accessible via system
+		 * instructions are always implemented.
 		 */
 		return true;
+
+	ETM4x_ONLY_SYSREG_LIST_CASES
+		/*
+		 * We only support etm4x and ete. So if the device is not
+		 * ETE, it must be ETMv4x.
+		 */
+		return !etm4x_is_ete(drvdata);
+
 	ETM4x_MMAP_LIST_CASES
 		/*
 		 * Registers accessible only via memory-mapped registers
@@ -2389,8 +2397,13 @@ etm4x_register_implemented(struct etmv4_drvdata *drvdata, u32 offset)
 		 * coresight_register() and the csdev is not initialized
 		 * until that is done. So rely on the drvdata->base to
 		 * detect if we have a memory mapped access.
+		 * Also ETE doesn't implement memory mapped access, thus
+		 * it is sufficient to check that we are using mmio.
 		 */
 		return !!drvdata->base;
+
+	ETE_ONLY_SYSREG_LIST_CASES
+		return etm4x_is_ete(drvdata);
 	}
 
 	return false;
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index ca24ac5..8b90de5 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -128,6 +128,8 @@
 #define TRCCIDR2			0xFF8
 #define TRCCIDR3			0xFFC
 
+#define TRCRSR_TA			BIT(12)
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
@@ -390,6 +392,9 @@
 #define ETM_COMMON_SYSREG_LIST_CASES		\
 	ETM_COMMON_SYSREG_LIST(NOP, __unused)
 
+#define ETM4x_ONLY_SYSREG_LIST_CASES		\
+	ETM4x_ONLY_SYSREG_LIST(NOP, __unused)
+
 #define ETM4x_SYSREG_LIST_CASES			\
 	ETM_COMMON_SYSREG_LIST_CASES		\
 	ETM4x_ONLY_SYSREG_LIST(NOP, __unused)
@@ -406,7 +411,6 @@
 	ETE_ONLY_SYSREG_LIST(WRITE, (val))
 
 #define ETE_ONLY_SYSREG_LIST_CASES		\
-	ETM_COMMON_SYSREG_LIST_CASES		\
 	ETE_ONLY_SYSREG_LIST(NOP, __unused)
 
 #define read_etm4x_sysreg_offset(offset, _64bit)				\
@@ -589,11 +593,14 @@
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
@@ -683,6 +690,8 @@
 #define ETM_ARCH_MINOR_VERSION(arch)	((arch) & 0xfU)
 
 #define ETM_ARCH_V4	ETM_ARCH_VERSION(4, 0)
+#define ETM_ARCH_ETE	ETM_ARCH_VERSION(5, 0)
+
 /* Interpretation of resource numbers change at ETM v4.3 architecture */
 #define ETM_ARCH_V4_3	ETM_ARCH_VERSION(4, 3)
 
@@ -989,4 +998,9 @@ void etm4_config_trace_mode(struct etmv4_config *config);
 
 u64 etm4x_sysreg_read(u32 offset, bool _relaxed, bool _64bit);
 void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit);
+
+static inline bool etm4x_is_ete(struct etmv4_drvdata *drvdata)
+{
+	return drvdata->arch >= ETM_ARCH_ETE;
+}
 #endif
-- 
2.7.4

