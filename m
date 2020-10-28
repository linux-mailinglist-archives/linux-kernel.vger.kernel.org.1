Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6616029DFA5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbgJ2BD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:03:27 -0400
Received: from foss.arm.com ([217.140.110.172]:39132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730478AbgJ1WKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:10:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0857E31B;
        Wed, 28 Oct 2020 15:10:11 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1E57E3F68F;
        Wed, 28 Oct 2020 15:10:10 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 09/26] coresight: Convert coresight_timeout to use access abstraction
Date:   Wed, 28 Oct 2020 22:09:28 +0000
Message-Id: <20201028220945.3826358-11-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201028220945.3826358-1-suzuki.poulose@arm.com>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the generic routines to use the new access abstraction layer
gradually, starting with coresigth_timeout.

Cc: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-catu.c  |  5 ++--
 drivers/hwtracing/coresight/coresight-core.c  | 15 ++++++----
 drivers/hwtracing/coresight/coresight-etb10.c |  5 ++--
 .../coresight/coresight-etm4x-core.c          | 30 ++++++++++++-------
 drivers/hwtracing/coresight/coresight-stm.c   |  3 +-
 .../hwtracing/coresight/coresight-tmc-core.c  | 15 ++++++----
 drivers/hwtracing/coresight/coresight-tpiu.c  |  4 +--
 include/linux/coresight.h                     | 17 ++++++++---
 8 files changed, 61 insertions(+), 33 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 5baf29510f1b..34c74b05c542 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -401,8 +401,9 @@ static const struct attribute_group *catu_groups[] = {
 
 static inline int catu_wait_for_ready(struct catu_drvdata *drvdata)
 {
-	return coresight_timeout(drvdata->base,
-				 CATU_STATUS, CATU_STATUS_READY, 1);
+	struct csdev_access *csa = &drvdata->csdev->access;
+
+	return coresight_timeout(csa, CATU_STATUS, CATU_STATUS_READY, 1);
 }
 
 static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index e96deaca8cab..42ba989a6b5e 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1412,23 +1412,26 @@ static void coresight_remove_conns(struct coresight_device *csdev)
 }
 
 /**
- * coresight_timeout - loop until a bit has changed to a specific state.
- * @addr: base address of the area of interest.
- * @offset: address of a register, starting from @addr.
+ * coresight_timeout - loop until a bit has changed to a specific register
+ *			state.
+ * @csa: coresight device access for the device
+ * @offset: Offset of the register from the base of the device.
  * @position: the position of the bit of interest.
  * @value: the value the bit should have.
  *
  * Return: 0 as soon as the bit has taken the desired state or -EAGAIN if
  * TIMEOUT_US has elapsed, which ever happens first.
  */
-
-int coresight_timeout(void __iomem *addr, u32 offset, int position, int value)
+int coresight_timeout(struct csdev_access *csa,
+		      u32 offset,
+		      int position,
+		      int value)
 {
 	int i;
 	u32 val;
 
 	for (i = TIMEOUT_US; i > 0; i--) {
-		val = __raw_readl(addr + offset);
+		val = csdev_access_read32(csa, offset);
 		/* waiting on the bit to go from 0 to 1 */
 		if (value) {
 			if (val & BIT(position))
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index b91633c6c9b4..f994a22876d9 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -251,6 +251,7 @@ static void __etb_disable_hw(struct etb_drvdata *drvdata)
 {
 	u32 ffcr;
 	struct device *dev = &drvdata->csdev->dev;
+	struct csdev_access *csa = &drvdata->csdev->access;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -262,7 +263,7 @@ static void __etb_disable_hw(struct etb_drvdata *drvdata)
 	ffcr |= ETB_FFCR_FON_MAN;
 	writel_relaxed(ffcr, drvdata->base + ETB_FFCR);
 
-	if (coresight_timeout(drvdata->base, ETB_FFCR, ETB_FFCR_BIT, 0)) {
+	if (coresight_timeout(csa, ETB_FFCR, ETB_FFCR_BIT, 0)) {
 		dev_err(dev,
 		"timeout while waiting for completion of Manual Flush\n");
 	}
@@ -270,7 +271,7 @@ static void __etb_disable_hw(struct etb_drvdata *drvdata)
 	/* disable trace capture */
 	writel_relaxed(0x0, drvdata->base + ETB_CTL_REG);
 
-	if (coresight_timeout(drvdata->base, ETB_FFSR, ETB_FFSR_BIT, 1)) {
+	if (coresight_timeout(csa, ETB_FFSR, ETB_FFSR_BIT, 1)) {
 		dev_err(dev,
 			"timeout while waiting for Formatter to Stop\n");
 	}
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index c5cb93f1b80c..2744aadaa5ec 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -107,7 +107,9 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 {
 	int i, rc;
 	struct etmv4_config *config = &drvdata->config;
-	struct device *etm_dev = &drvdata->csdev->dev;
+	struct coresight_device *csdev = drvdata->csdev;
+	struct device *etm_dev = &csdev->dev;
+	struct csdev_access *csa = &csdev->access;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -121,7 +123,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	writel_relaxed(0, drvdata->base + TRCPRGCTLR);
 
 	/* wait for TRCSTATR.IDLE to go up */
-	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 1))
+	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 1))
 		dev_err(etm_dev,
 			"timeout while waiting for Idle Trace Status\n");
 	if (drvdata->nr_pe)
@@ -212,7 +214,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	writel_relaxed(1, drvdata->base + TRCPRGCTLR);
 
 	/* wait for TRCSTATR.IDLE to go back down to '0' */
-	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 0))
+	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 0))
 		dev_err(etm_dev,
 			"timeout while waiting for Idle Trace Status\n");
 
@@ -476,7 +478,9 @@ static void etm4_disable_hw(void *info)
 	u32 control;
 	struct etmv4_drvdata *drvdata = info;
 	struct etmv4_config *config = &drvdata->config;
-	struct device *etm_dev = &drvdata->csdev->dev;
+	struct coresight_device *csdev = drvdata->csdev;
+	struct device *etm_dev = &csdev->dev;
+	struct csdev_access *csa = &csdev->access;
 	int i;
 
 	CS_UNLOCK(drvdata->base);
@@ -503,8 +507,7 @@ static void etm4_disable_hw(void *info)
 	writel_relaxed(control, drvdata->base + TRCPRGCTLR);
 
 	/* wait for TRCSTATR.PMSTABLE to go to '1' */
-	if (coresight_timeout(drvdata->base, TRCSTATR,
-			      TRCSTATR_PMSTABLE_BIT, 1))
+	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_PMSTABLE_BIT, 1))
 		dev_err(etm_dev,
 			"timeout while waiting for PM stable Trace Status\n");
 
@@ -1160,7 +1163,15 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 {
 	int i, ret = 0;
 	struct etmv4_save_state *state;
-	struct device *etm_dev = &drvdata->csdev->dev;
+	struct coresight_device *csdev = drvdata->csdev;
+	struct csdev_access *csa;
+	struct device *etm_dev;
+
+	if (WARN_ON(!csdev))
+		return -ENODEV;
+
+	etm_dev = &csdev->dev;
+	csa = &csdev->access;
 
 	/*
 	 * As recommended by 3.4.1 ("The procedure when powering down the PE")
@@ -1175,8 +1186,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	etm4_os_lock(drvdata);
 
 	/* wait for TRCSTATR.PMSTABLE to go up */
-	if (coresight_timeout(drvdata->base, TRCSTATR,
-			      TRCSTATR_PMSTABLE_BIT, 1)) {
+	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_PMSTABLE_BIT, 1)) {
 		dev_err(etm_dev,
 			"timeout while waiting for PM Stable Status\n");
 		etm4_os_unlock(drvdata);
@@ -1264,7 +1274,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	state->trcpdcr = readl(drvdata->base + TRCPDCR);
 
 	/* wait for TRCSTATR.IDLE to go up */
-	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 1)) {
+	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 1)) {
 		dev_err(etm_dev,
 			"timeout while waiting for Idle Trace Status\n");
 		etm4_os_unlock(drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 315500b7763f..9cba67b27586 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -258,6 +258,7 @@ static void stm_disable(struct coresight_device *csdev,
 			struct perf_event *event)
 {
 	struct stm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct csdev_access *csa = &csdev->access;
 
 	/*
 	 * For as long as the tracer isn't disabled another entity can't
@@ -270,7 +271,7 @@ static void stm_disable(struct coresight_device *csdev,
 		spin_unlock(&drvdata->spinlock);
 
 		/* Wait until the engine has completely stopped */
-		coresight_timeout(drvdata->base, STMTCSR, STMTCSR_BUSY_BIT, 0);
+		coresight_timeout(csa, STMTCSR, STMTCSR_BUSY_BIT, 0);
 
 		pm_runtime_put(csdev->dev.parent);
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 8fd640d41e1b..572f4b316798 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -33,16 +33,20 @@ DEFINE_CORESIGHT_DEVLIST(etr_devs, "tmc_etr");
 
 void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
 {
+	struct coresight_device *csdev = drvdata->csdev;
+	struct csdev_access *csa = &csdev->access;
+
 	/* Ensure formatter, unformatter and hardware fifo are empty */
-	if (coresight_timeout(drvdata->base,
-			      TMC_STS, TMC_STS_TMCREADY_BIT, 1)) {
-		dev_err(&drvdata->csdev->dev,
+	if (coresight_timeout(csa, TMC_STS, TMC_STS_TMCREADY_BIT, 1)) {
+		dev_err(&csdev->dev,
 			"timeout while waiting for TMC to be Ready\n");
 	}
 }
 
 void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
 {
+	struct coresight_device *csdev = drvdata->csdev;
+	struct csdev_access *csa = &csdev->access;
 	u32 ffcr;
 
 	ffcr = readl_relaxed(drvdata->base + TMC_FFCR);
@@ -51,9 +55,8 @@ void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
 	ffcr |= BIT(TMC_FFCR_FLUSHMAN_BIT);
 	writel_relaxed(ffcr, drvdata->base + TMC_FFCR);
 	/* Ensure flush completes */
-	if (coresight_timeout(drvdata->base,
-			      TMC_FFCR, TMC_FFCR_FLUSHMAN_BIT, 0)) {
-		dev_err(&drvdata->csdev->dev,
+	if (coresight_timeout(csa, TMC_FFCR, TMC_FFCR_FLUSHMAN_BIT, 0)) {
+		dev_err(&csdev->dev,
 		"timeout while waiting for completion of Manual Flush\n");
 	}
 
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 98c4a029854c..1e92c76d9656 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -86,9 +86,9 @@ static void tpiu_disable_hw(struct csdev_access *csa)
 	/* Generate manual flush */
 	csdev_access_relaxed_write32(csa, FFCR_STOP_FI | FFCR_FON_MAN, TPIU_FFCR);
 	/* Wait for flush to complete */
-	coresight_timeout(csa->base, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
+	coresight_timeout(csa, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
 	/* Wait for formatter to stop */
-	coresight_timeout(csa->base, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
+	coresight_timeout(csa, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
 
 	CS_LOCK(csa->base);
 }
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 5a34c2f2debc..cefc8fe239e6 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -469,8 +469,10 @@ coresight_register(struct coresight_desc *desc);
 extern void coresight_unregister(struct coresight_device *csdev);
 extern int coresight_enable(struct coresight_device *csdev);
 extern void coresight_disable(struct coresight_device *csdev);
-extern int coresight_timeout(void __iomem *addr, u32 offset,
-			     int position, int value);
+extern int coresight_timeout(struct csdev_access *csa,
+			     u32 offset,
+			     int position,
+			     int value);
 
 extern int coresight_claim_device(void __iomem *base);
 extern int coresight_claim_device_unlocked(void __iomem *base);
@@ -502,8 +504,15 @@ static inline void coresight_unregister(struct coresight_device *csdev) {}
 static inline int
 coresight_enable(struct coresight_device *csdev) { return -ENOSYS; }
 static inline void coresight_disable(struct coresight_device *csdev) {}
-static inline int coresight_timeout(void __iomem *addr, u32 offset,
-				     int position, int value) { return 1; }
+
+static inline int coresight_timeout(struct csdev_access *csa,
+				    u32 offset,
+				    int position,
+				    int value)
+{
+	return 1;
+}
+
 static inline int coresight_claim_device_unlocked(void __iomem *base)
 {
 	return -EINVAL;
-- 
2.24.1

