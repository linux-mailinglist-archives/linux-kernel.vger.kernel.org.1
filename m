Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1242D9E7E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 19:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502599AbgLNSFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 13:05:20 -0500
Received: from foss.arm.com ([217.140.110.172]:50512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408615AbgLNRjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:39:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B3BD11FB;
        Mon, 14 Dec 2020 09:37:51 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1BE8A3F66E;
        Mon, 14 Dec 2020 09:37:49 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, jonathan.zhouwen@huawei.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 06/25] coresight: Convert claim/disclaim operations to use access wrappers
Date:   Mon, 14 Dec 2020 17:37:12 +0000
Message-Id: <20201214173731.302520-7-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201214173731.302520-1-suzuki.poulose@arm.com>
References: <20201214173731.302520-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the generic CLAIM tag management APIs to use the
device access layer abstraction.

Cc: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V3:
 - Removed WARN_ON(!csdev) check. (Mathieu)
 - Fixed indentation (Mathieu)
---
 drivers/hwtracing/coresight/coresight-catu.c  |  6 +-
 drivers/hwtracing/coresight/coresight-core.c  | 66 +++++++++++--------
 .../hwtracing/coresight/coresight-cti-core.c  | 17 +++--
 drivers/hwtracing/coresight/coresight-etb10.c |  4 +-
 .../coresight/coresight-etm3x-core.c          |  8 ++-
 .../coresight/coresight-etm4x-core.c          |  4 +-
 .../hwtracing/coresight/coresight-funnel.c    |  6 +-
 .../coresight/coresight-replicator.c          | 12 ++--
 .../hwtracing/coresight/coresight-tmc-etf.c   | 10 +--
 .../hwtracing/coresight/coresight-tmc-etr.c   |  4 +-
 include/linux/coresight.h                     | 16 ++---
 11 files changed, 91 insertions(+), 62 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index d6097454d399..9a0b9ce4a7da 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -412,6 +412,7 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
 	u32 control, mode;
 	struct etr_buf *etr_buf = data;
 	struct device *dev = &drvdata->csdev->dev;
+	struct coresight_device *csdev = drvdata->csdev;
 
 	if (catu_wait_for_ready(drvdata))
 		dev_warn(dev, "Timeout while waiting for READY\n");
@@ -422,7 +423,7 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
 		return -EBUSY;
 	}
 
-	rc = coresight_claim_device_unlocked(drvdata->base);
+	rc = coresight_claim_device_unlocked(csdev);
 	if (rc)
 		return rc;
 
@@ -466,9 +467,10 @@ static int catu_disable_hw(struct catu_drvdata *drvdata)
 {
 	int rc = 0;
 	struct device *dev = &drvdata->csdev->dev;
+	struct coresight_device *csdev = drvdata->csdev;
 
 	catu_write_control(drvdata, 0);
-	coresight_disclaim_device_unlocked(drvdata->base);
+	coresight_disclaim_device_unlocked(csdev);
 	if (catu_wait_for_ready(drvdata)) {
 		dev_info(dev, "Timeout while waiting for READY\n");
 		rc = -EAGAIN;
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 74985068f325..0062c8935653 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -145,30 +145,32 @@ static int coresight_find_link_outport(struct coresight_device *csdev,
 	return -ENODEV;
 }
 
-static inline u32 coresight_read_claim_tags(void __iomem *base)
+static inline u32 coresight_read_claim_tags(struct coresight_device *csdev)
 {
-	return readl_relaxed(base + CORESIGHT_CLAIMCLR);
+	return csdev_access_relaxed_read32(&csdev->access, CORESIGHT_CLAIMCLR);
 }
 
-static inline bool coresight_is_claimed_self_hosted(void __iomem *base)
+static inline bool coresight_is_claimed_self_hosted(struct coresight_device *csdev)
 {
-	return coresight_read_claim_tags(base) == CORESIGHT_CLAIM_SELF_HOSTED;
+	return coresight_read_claim_tags(csdev) == CORESIGHT_CLAIM_SELF_HOSTED;
 }
 
-static inline bool coresight_is_claimed_any(void __iomem *base)
+static inline bool coresight_is_claimed_any(struct coresight_device *csdev)
 {
-	return coresight_read_claim_tags(base) != 0;
+	return coresight_read_claim_tags(csdev) != 0;
 }
 
-static inline void coresight_set_claim_tags(void __iomem *base)
+static inline void coresight_set_claim_tags(struct coresight_device *csdev)
 {
-	writel_relaxed(CORESIGHT_CLAIM_SELF_HOSTED, base + CORESIGHT_CLAIMSET);
+	csdev_access_relaxed_write32(&csdev->access, CORESIGHT_CLAIM_SELF_HOSTED,
+				     CORESIGHT_CLAIMSET);
 	isb();
 }
 
-static inline void coresight_clear_claim_tags(void __iomem *base)
+static inline void coresight_clear_claim_tags(struct coresight_device *csdev)
 {
-	writel_relaxed(CORESIGHT_CLAIM_SELF_HOSTED, base + CORESIGHT_CLAIMCLR);
+	csdev_access_relaxed_write32(&csdev->access, CORESIGHT_CLAIM_SELF_HOSTED,
+				     CORESIGHT_CLAIMCLR);
 	isb();
 }
 
@@ -182,27 +184,33 @@ static inline void coresight_clear_claim_tags(void __iomem *base)
  * Called with CS_UNLOCKed for the component.
  * Returns : 0 on success
  */
-int coresight_claim_device_unlocked(void __iomem *base)
+int coresight_claim_device_unlocked(struct coresight_device *csdev)
 {
-	if (coresight_is_claimed_any(base))
+	if (WARN_ON(!csdev))
+		return -EINVAL;
+
+	if (coresight_is_claimed_any(csdev))
 		return -EBUSY;
 
-	coresight_set_claim_tags(base);
-	if (coresight_is_claimed_self_hosted(base))
+	coresight_set_claim_tags(csdev);
+	if (coresight_is_claimed_self_hosted(csdev))
 		return 0;
 	/* There was a race setting the tags, clean up and fail */
-	coresight_clear_claim_tags(base);
+	coresight_clear_claim_tags(csdev);
 	return -EBUSY;
 }
 EXPORT_SYMBOL_GPL(coresight_claim_device_unlocked);
 
-int coresight_claim_device(void __iomem *base)
+int coresight_claim_device(struct coresight_device *csdev)
 {
 	int rc;
 
-	CS_UNLOCK(base);
-	rc = coresight_claim_device_unlocked(base);
-	CS_LOCK(base);
+	if (WARN_ON(!csdev))
+		return -EINVAL;
+
+	CS_UNLOCK(csdev->access.base);
+	rc = coresight_claim_device_unlocked(csdev);
+	CS_LOCK(csdev->access.base);
 
 	return rc;
 }
@@ -212,11 +220,14 @@ EXPORT_SYMBOL_GPL(coresight_claim_device);
  * coresight_disclaim_device_unlocked : Clear the claim tags for the device.
  * Called with CS_UNLOCKed for the component.
  */
-void coresight_disclaim_device_unlocked(void __iomem *base)
+void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
 {
 
-	if (coresight_is_claimed_self_hosted(base))
-		coresight_clear_claim_tags(base);
+	if (WARN_ON(!csdev))
+		return;
+
+	if (coresight_is_claimed_self_hosted(csdev))
+		coresight_clear_claim_tags(csdev);
 	else
 		/*
 		 * The external agent may have not honoured our claim
@@ -227,11 +238,14 @@ void coresight_disclaim_device_unlocked(void __iomem *base)
 }
 EXPORT_SYMBOL_GPL(coresight_disclaim_device_unlocked);
 
-void coresight_disclaim_device(void __iomem *base)
+void coresight_disclaim_device(struct coresight_device *csdev)
 {
-	CS_UNLOCK(base);
-	coresight_disclaim_device_unlocked(base);
-	CS_LOCK(base);
+	if (WARN_ON(!csdev))
+		return;
+
+	CS_UNLOCK(csdev->access.base);
+	coresight_disclaim_device_unlocked(csdev);
+	CS_LOCK(csdev->access.base);
 }
 EXPORT_SYMBOL_GPL(coresight_disclaim_device);
 
diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
index b38a8db5f252..0c81eb9603ae 100644
--- a/drivers/hwtracing/coresight/coresight-cti-core.c
+++ b/drivers/hwtracing/coresight/coresight-cti-core.c
@@ -102,7 +102,7 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
 		goto cti_state_unchanged;
 
 	/* claim the device */
-	rc = coresight_claim_device(drvdata->base);
+	rc = coresight_claim_device(drvdata->csdev);
 	if (rc)
 		goto cti_err_not_enabled;
 
@@ -136,7 +136,7 @@ static void cti_cpuhp_enable_hw(struct cti_drvdata *drvdata)
 		goto cti_hp_not_enabled;
 
 	/* try to claim the device */
-	if (coresight_claim_device(drvdata->base))
+	if (coresight_claim_device(drvdata->csdev))
 		goto cti_hp_not_enabled;
 
 	cti_write_all_hw_regs(drvdata);
@@ -154,6 +154,7 @@ static int cti_disable_hw(struct cti_drvdata *drvdata)
 {
 	struct cti_config *config = &drvdata->config;
 	struct device *dev = &drvdata->csdev->dev;
+	struct coresight_device *csdev = drvdata->csdev;
 
 	spin_lock(&drvdata->spinlock);
 
@@ -171,7 +172,7 @@ static int cti_disable_hw(struct cti_drvdata *drvdata)
 	writel_relaxed(0, drvdata->base + CTICONTROL);
 	config->hw_enabled = false;
 
-	coresight_disclaim_device_unlocked(drvdata->base);
+	coresight_disclaim_device_unlocked(csdev);
 	CS_LOCK(drvdata->base);
 	spin_unlock(&drvdata->spinlock);
 	pm_runtime_put(dev);
@@ -655,6 +656,7 @@ static int cti_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
 			     void *v)
 {
 	struct cti_drvdata *drvdata;
+	struct coresight_device *csdev;
 	unsigned int cpu = smp_processor_id();
 	int notify_res = NOTIFY_OK;
 
@@ -662,6 +664,7 @@ static int cti_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
 		return NOTIFY_OK;
 
 	drvdata = cti_cpu_drvdata[cpu];
+	csdev = drvdata->csdev;
 
 	if (WARN_ON_ONCE(drvdata->ctidev.cpu != cpu))
 		return NOTIFY_BAD;
@@ -673,13 +676,13 @@ static int cti_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
 		/* CTI regs all static - we have a copy & nothing to save */
 		drvdata->config.hw_powered = false;
 		if (drvdata->config.hw_enabled)
-			coresight_disclaim_device(drvdata->base);
+			coresight_disclaim_device(csdev);
 		break;
 
 	case CPU_PM_ENTER_FAILED:
 		drvdata->config.hw_powered = true;
 		if (drvdata->config.hw_enabled) {
-			if (coresight_claim_device(drvdata->base))
+			if (coresight_claim_device(csdev))
 				drvdata->config.hw_enabled = false;
 		}
 		break;
@@ -692,7 +695,7 @@ static int cti_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
 		/* check enable reference count to enable HW */
 		if (atomic_read(&drvdata->config.enable_req_count)) {
 			/* check we can claim the device as we re-power */
-			if (coresight_claim_device(drvdata->base))
+			if (coresight_claim_device(csdev))
 				goto cti_notify_exit;
 
 			drvdata->config.hw_enabled = true;
@@ -736,7 +739,7 @@ static int cti_dying_cpu(unsigned int cpu)
 	spin_lock(&drvdata->spinlock);
 	drvdata->config.hw_powered = false;
 	if (drvdata->config.hw_enabled)
-		coresight_disclaim_device(drvdata->base);
+		coresight_disclaim_device(drvdata->csdev);
 	spin_unlock(&drvdata->spinlock);
 	return 0;
 }
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 0f664aeeda93..74922c94f4b1 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -132,7 +132,7 @@ static void __etb_enable_hw(struct etb_drvdata *drvdata)
 
 static int etb_enable_hw(struct etb_drvdata *drvdata)
 {
-	int rc = coresight_claim_device(drvdata->base);
+	int rc = coresight_claim_device(drvdata->csdev);
 
 	if (rc)
 		return rc;
@@ -345,7 +345,7 @@ static void etb_disable_hw(struct etb_drvdata *drvdata)
 {
 	__etb_disable_hw(drvdata);
 	etb_dump_hw(drvdata);
-	coresight_disclaim_device(drvdata->base);
+	coresight_disclaim_device(drvdata->csdev);
 }
 
 static int etb_disable(struct coresight_device *csdev)
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index 3b7837cbe376..29d4dba4bee9 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -358,10 +358,11 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
 	int i, rc;
 	u32 etmcr;
 	struct etm_config *config = &drvdata->config;
+	struct coresight_device *csdev = drvdata->csdev;
 
 	CS_UNLOCK(drvdata->base);
 
-	rc = coresight_claim_device_unlocked(drvdata->base);
+	rc = coresight_claim_device_unlocked(csdev);
 	if (rc)
 		goto done;
 
@@ -566,6 +567,7 @@ static void etm_disable_hw(void *info)
 	int i;
 	struct etm_drvdata *drvdata = info;
 	struct etm_config *config = &drvdata->config;
+	struct coresight_device *csdev = drvdata->csdev;
 
 	CS_UNLOCK(drvdata->base);
 	etm_set_prog(drvdata);
@@ -577,7 +579,7 @@ static void etm_disable_hw(void *info)
 		config->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
 
 	etm_set_pwrdwn(drvdata);
-	coresight_disclaim_device_unlocked(drvdata->base);
+	coresight_disclaim_device_unlocked(csdev);
 
 	CS_LOCK(drvdata->base);
 
@@ -602,7 +604,7 @@ static void etm_disable_perf(struct coresight_device *csdev)
 	 * power down the tracer.
 	 */
 	etm_set_pwrdwn(drvdata);
-	coresight_disclaim_device_unlocked(drvdata->base);
+	coresight_disclaim_device_unlocked(csdev);
 
 	CS_LOCK(drvdata->base);
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 419c6e443932..201da6c2c652 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -131,7 +131,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 
 	etm4_os_unlock(drvdata);
 
-	rc = coresight_claim_device_unlocked(drvdata->base);
+	rc = coresight_claim_device_unlocked(csdev);
 	if (rc)
 		goto done;
 
@@ -539,7 +539,7 @@ static void etm4_disable_hw(void *info)
 			readl_relaxed(drvdata->base + TRCCNTVRn(i));
 	}
 
-	coresight_disclaim_device_unlocked(drvdata->base);
+	coresight_disclaim_device_unlocked(csdev);
 
 	CS_LOCK(drvdata->base);
 
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 8f7c40d7d8d6..38bebdddcbff 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -52,13 +52,14 @@ static int dynamic_funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
 {
 	u32 functl;
 	int rc = 0;
+	struct coresight_device *csdev = drvdata->csdev;
 
 	CS_UNLOCK(drvdata->base);
 
 	functl = readl_relaxed(drvdata->base + FUNNEL_FUNCTL);
 	/* Claim the device only when we enable the first slave */
 	if (!(functl & FUNNEL_ENSx_MASK)) {
-		rc = coresight_claim_device_unlocked(drvdata->base);
+		rc = coresight_claim_device_unlocked(csdev);
 		if (rc)
 			goto done;
 	}
@@ -101,6 +102,7 @@ static void dynamic_funnel_disable_hw(struct funnel_drvdata *drvdata,
 				      int inport)
 {
 	u32 functl;
+	struct coresight_device *csdev = drvdata->csdev;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -110,7 +112,7 @@ static void dynamic_funnel_disable_hw(struct funnel_drvdata *drvdata,
 
 	/* Disclaim the device if none of the slaves are now active */
 	if (!(functl & FUNNEL_ENSx_MASK))
-		coresight_disclaim_device_unlocked(drvdata->base);
+		coresight_disclaim_device_unlocked(csdev);
 
 	CS_LOCK(drvdata->base);
 }
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 205756fab729..a73fea9185b6 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -45,12 +45,14 @@ struct replicator_drvdata {
 
 static void dynamic_replicator_reset(struct replicator_drvdata *drvdata)
 {
+	struct coresight_device *csdev = drvdata->csdev;
+
 	CS_UNLOCK(drvdata->base);
 
-	if (!coresight_claim_device_unlocked(drvdata->base)) {
+	if (!coresight_claim_device_unlocked(csdev)) {
 		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
 		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
-		coresight_disclaim_device_unlocked(drvdata->base);
+		coresight_disclaim_device_unlocked(csdev);
 	}
 
 	CS_LOCK(drvdata->base);
@@ -70,6 +72,7 @@ static int dynamic_replicator_enable(struct replicator_drvdata *drvdata,
 {
 	int rc = 0;
 	u32 id0val, id1val;
+	struct coresight_device *csdev = drvdata->csdev;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -84,7 +87,7 @@ static int dynamic_replicator_enable(struct replicator_drvdata *drvdata,
 		id0val = id1val = 0xff;
 
 	if (id0val == 0xff && id1val == 0xff)
-		rc = coresight_claim_device_unlocked(drvdata->base);
+		rc = coresight_claim_device_unlocked(csdev);
 
 	if (!rc) {
 		switch (outport) {
@@ -140,6 +143,7 @@ static void dynamic_replicator_disable(struct replicator_drvdata *drvdata,
 				       int inport, int outport)
 {
 	u32 reg;
+	struct coresight_device *csdev = drvdata->csdev;
 
 	switch (outport) {
 	case 0:
@@ -160,7 +164,7 @@ static void dynamic_replicator_disable(struct replicator_drvdata *drvdata,
 
 	if ((readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0) == 0xff) &&
 	    (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0xff))
-		coresight_disclaim_device_unlocked(drvdata->base);
+		coresight_disclaim_device_unlocked(csdev);
 	CS_LOCK(drvdata->base);
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 989d965f3d90..45b85edfc690 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -37,7 +37,7 @@ static void __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 
 static int tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 {
-	int rc = coresight_claim_device(drvdata->base);
+	int rc = coresight_claim_device(drvdata->csdev);
 
 	if (rc)
 		return rc;
@@ -88,7 +88,7 @@ static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 {
 	__tmc_etb_disable_hw(drvdata);
-	coresight_disclaim_device(drvdata->base);
+	coresight_disclaim_device(drvdata->csdev);
 }
 
 static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
@@ -109,7 +109,7 @@ static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 
 static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 {
-	int rc = coresight_claim_device(drvdata->base);
+	int rc = coresight_claim_device(drvdata->csdev);
 
 	if (rc)
 		return rc;
@@ -120,11 +120,13 @@ static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 
 static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
 {
+	struct coresight_device *csdev = drvdata->csdev;
+
 	CS_UNLOCK(drvdata->base);
 
 	tmc_flush_and_stop(drvdata);
 	tmc_disable_hw(drvdata);
-	coresight_disclaim_device_unlocked(drvdata->base);
+	coresight_disclaim_device_unlocked(csdev);
 	CS_LOCK(drvdata->base);
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index bf5230e39c5b..acdb59e0e661 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1040,7 +1040,7 @@ static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 	rc = tmc_etr_enable_catu(drvdata, etr_buf);
 	if (rc)
 		return rc;
-	rc = coresight_claim_device(drvdata->base);
+	rc = coresight_claim_device(drvdata->csdev);
 	if (!rc) {
 		drvdata->etr_buf = etr_buf;
 		__tmc_etr_enable_hw(drvdata);
@@ -1134,7 +1134,7 @@ void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 	__tmc_etr_disable_hw(drvdata);
 	/* Disable CATU device if this ETR is connected to one */
 	tmc_etr_disable_catu(drvdata);
-	coresight_disclaim_device(drvdata->base);
+	coresight_disclaim_device(drvdata->csdev);
 	/* Reset the ETR buf used by hardware */
 	drvdata->etr_buf = NULL;
 }
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 89103c3298f2..951ba885992f 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -467,11 +467,11 @@ extern void coresight_disable(struct coresight_device *csdev);
 extern int coresight_timeout(struct csdev_access *csa, u32 offset,
 			     int position, int value);
 
-extern int coresight_claim_device(void __iomem *base);
-extern int coresight_claim_device_unlocked(void __iomem *base);
+extern int coresight_claim_device(struct coresight_device *csdev);
+extern int coresight_claim_device_unlocked(struct coresight_device *csdev);
 
-extern void coresight_disclaim_device(void __iomem *base);
-extern void coresight_disclaim_device_unlocked(void __iomem *base);
+extern void coresight_disclaim_device(struct coresight_device *csdev);
+extern void coresight_disclaim_device_unlocked(struct coresight_device *csdev);
 extern char *coresight_alloc_device_name(struct coresight_dev_list *devs,
 					 struct device *dev);
 
@@ -504,18 +504,18 @@ static inline int coresight_timeout(struct csdev_access *csa, u32 offset,
 	return 1;
 }
 
-static inline int coresight_claim_device_unlocked(void __iomem *base)
+static inline int coresight_claim_device_unlocked(struct coresight_device *csdev)
 {
 	return -EINVAL;
 }
 
-static inline int coresight_claim_device(void __iomem *base)
+static inline int coresight_claim_device(struct coresight_device *csdev)
 {
 	return -EINVAL;
 }
 
-static inline void coresight_disclaim_device(void __iomem *base) {}
-static inline void coresight_disclaim_device_unlocked(void __iomem *base) {}
+static inline void coresight_disclaim_device(struct coresight_device *csdev) {}
+static inline void coresight_disclaim_device_unlocked(struct coresight_device *csdev) {}
 
 static inline bool coresight_loses_context_with_cpu(struct device *dev)
 {
-- 
2.24.1

