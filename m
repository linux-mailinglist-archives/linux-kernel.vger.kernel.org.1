Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F6D2F0A1E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 23:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbhAJWu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 17:50:57 -0500
Received: from foss.arm.com ([217.140.110.172]:39072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbhAJWu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 17:50:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E79401529;
        Sun, 10 Jan 2021 14:49:31 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 98BB73F719;
        Sun, 10 Jan 2021 14:49:30 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        jonathan.zhouwen@huawei.com, catalin.marinas@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v7 19/28] coresight: etm4x: Use TRCDEVARCH for component discovery
Date:   Sun, 10 Jan 2021 22:48:41 +0000
Message-Id: <20210110224850.1880240-20-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210110224850.1880240-1-suzuki.poulose@arm.com>
References: <20210110224850.1880240-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have been using TRCIDR1 for detecting the ETM version. This
is in preparation for the future IP support.

Cc: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 46 +++++++++----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 7adc9bd03eb5..5d3041eccc14 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -153,18 +153,6 @@ static void etm4_cs_unlock(struct etmv4_drvdata *drvdata,
 		CS_UNLOCK(csa->base);
 }
 
-static bool etm4_arch_supported(u8 arch)
-{
-	/* Mask out the minor version number */
-	switch (arch & 0xf0) {
-	case ETM_ARCH_V4:
-		break;
-	default:
-		return false;
-	}
-	return true;
-}
-
 static int etm4_cpu_id(struct coresight_device *csdev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -784,6 +772,26 @@ static const struct coresight_ops etm4_cs_ops = {
 static bool etm4_init_iomem_access(struct etmv4_drvdata *drvdata,
 				   struct csdev_access *csa)
 {
+	u32 devarch = readl_relaxed(drvdata->base + TRCDEVARCH);
+	u32 idr1 = readl_relaxed(drvdata->base + TRCIDR1);
+
+	/*
+	 * All ETMs must implement TRCDEVARCH to indicate that
+	 * the component is an ETMv4. To support any broken
+	 * implementations we fall back to TRCIDR1 check, which
+	 * is not really reliable.
+	 */
+	if ((devarch & ETM_DEVARCH_ID_MASK) == ETM_DEVARCH_ETMv4x_ARCH) {
+		drvdata->arch = etm_devarch_to_arch(devarch);
+	} else {
+		pr_warn("CPU%d: ETM4x incompatible TRCDEVARCH: %x, falling back to TRCIDR1\n",
+			smp_processor_id(), devarch);
+
+		if (ETM_TRCIDR1_ARCH_MAJOR(idr1) != ETM_TRCIDR1_ARCH_ETMv4)
+			return false;
+		drvdata->arch = etm_trcidr_to_arch(idr1);
+	}
+
 	*csa = CSDEV_ACCESS_IOMEM(drvdata->base);
 	return true;
 }
@@ -800,7 +808,6 @@ static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
 static void etm4_init_arch_data(void *info)
 {
 	u32 etmidr0;
-	u32 etmidr1;
 	u32 etmidr2;
 	u32 etmidr3;
 	u32 etmidr4;
@@ -865,14 +872,6 @@ static void etm4_init_arch_data(void *info)
 	/* TSSIZE, bits[28:24] Global timestamp size field */
 	drvdata->ts_size = BMVAL(etmidr0, 24, 28);
 
-	/* base architecture of trace unit */
-	etmidr1 = etm4x_relaxed_read32(csa, TRCIDR1);
-	/*
-	 * TRCARCHMIN, bits[7:4] architecture the minor version number
-	 * TRCARCHMAJ, bits[11:8] architecture major versin number
-	 */
-	drvdata->arch = BMVAL(etmidr1, 4, 11);
-
 	/* maximum size of resources */
 	etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
 	/* CIDSIZE, bits[9:5] Indicates the Context ID size */
@@ -1712,7 +1711,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 				etm4_init_arch_data,  &init_arg, 1))
 		dev_err(dev, "ETM arch init failed\n");
 
-	if (etm4_arch_supported(drvdata->arch) == false)
+	if (!drvdata->arch)
 		return -EINVAL;
 
 	etm4_init_trace_id(drvdata);
@@ -1744,7 +1743,8 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 
 	pm_runtime_put(&adev->dev);
 	dev_info(&drvdata->csdev->dev, "CPU%d: ETM v%d.%d initialized\n",
-		 drvdata->cpu, drvdata->arch >> 4, drvdata->arch & 0xf);
+		 drvdata->cpu, ETM_ARCH_MAJOR_VERSION(drvdata->arch),
+		 ETM_ARCH_MINOR_VERSION(drvdata->arch));
 
 	if (boot_enable) {
 		coresight_enable(drvdata->csdev);
-- 
2.24.1

