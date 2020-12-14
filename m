Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39C42D9EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 19:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440572AbgLNSIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 13:08:20 -0500
Received: from foss.arm.com ([217.140.110.172]:50522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408616AbgLNRjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:39:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BF8013D5;
        Mon, 14 Dec 2020 09:38:00 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 11A3B3F774;
        Mon, 14 Dec 2020 09:37:58 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, jonathan.zhouwen@huawei.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 12/25] coresight: etm4x: Check for Software Lock
Date:   Mon, 14 Dec 2020 17:37:18 +0000
Message-Id: <20201214173731.302520-13-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201214173731.302520-1-suzuki.poulose@arm.com>
References: <20201214173731.302520-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Software lock is not implemented for system instructions
based accesses. So, skip the lock register access in such
cases.

Cc: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 40 ++++++++++++-------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 923a6d730f7e..a1838b920062 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -130,6 +130,21 @@ static void etm4_os_lock(struct etmv4_drvdata *drvdata)
 	isb();
 }
 
+static void etm4_cs_lock(struct etmv4_drvdata *drvdata,
+			 struct csdev_access *csa)
+{
+	/* Software Lock is only accessible via memory mapped interface */
+	if (csa->io_mem)
+		CS_LOCK(csa->base);
+}
+
+static void etm4_cs_unlock(struct etmv4_drvdata *drvdata,
+			 struct csdev_access *csa)
+{
+	if (csa->io_mem)
+		CS_UNLOCK(csa->base);
+}
+
 static bool etm4_arch_supported(u8 arch)
 {
 	/* Mask out the minor version number */
@@ -169,8 +184,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	struct device *etm_dev = &csdev->dev;
 	struct csdev_access *csa = &csdev->access;
 
-	CS_UNLOCK(drvdata->base);
-
+	etm4_cs_unlock(drvdata, csa);
 	etm4_os_unlock(drvdata);
 
 	rc = coresight_claim_device_unlocked(csdev);
@@ -271,7 +285,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	isb();
 
 done:
-	CS_LOCK(drvdata->base);
+	etm4_cs_lock(drvdata, csa);
 
 	dev_dbg(etm_dev, "cpu: %d enable smp call done: %d\n",
 		drvdata->cpu, rc);
@@ -528,7 +542,7 @@ static void etm4_disable_hw(void *info)
 	struct csdev_access *csa = &csdev->access;
 	int i;
 
-	CS_UNLOCK(drvdata->base);
+	etm4_cs_unlock(drvdata, csa);
 
 	if (!drvdata->skip_power_up) {
 		/* power can be removed from the trace unit now */
@@ -569,8 +583,7 @@ static void etm4_disable_hw(void *info)
 	}
 
 	coresight_disclaim_device_unlocked(csdev);
-
-	CS_LOCK(drvdata->base);
+	etm4_cs_lock(drvdata, csa);
 
 	dev_dbg(&drvdata->csdev->dev,
 		"cpu: %d disable smp call done\n", drvdata->cpu);
@@ -680,8 +693,7 @@ static void etm4_init_arch_data(void *info)
 
 	/* Make sure all registers are accessible */
 	etm4_os_unlock_csa(drvdata, csa);
-
-	CS_UNLOCK(drvdata->base);
+	etm4_cs_unlock(drvdata, csa);
 
 	/* find all capabilities of the tracing unit */
 	etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
@@ -846,7 +858,7 @@ static void etm4_init_arch_data(void *info)
 	drvdata->nrseqstate = BMVAL(etmidr5, 25, 27);
 	/* NUMCNTR, bits[30:28] number of counters available for tracing */
 	drvdata->nr_cntr = BMVAL(etmidr5, 28, 30);
-	CS_LOCK(drvdata->base);
+	etm4_cs_lock(drvdata, csa);
 }
 
 /* Set ELx trace filter access in the TRCVICTLR register */
@@ -1227,8 +1239,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	dsb(sy);
 	isb();
 
-	CS_UNLOCK(drvdata->base);
-
+	etm4_cs_unlock(drvdata, csa);
 	/* Lock the OS lock to disable trace and external debugger access */
 	etm4_os_lock(drvdata);
 
@@ -1341,7 +1352,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 		etm4x_relaxed_write32(csa, (state->trcpdcr & ~TRCPDCR_PU),
 				      TRCPDCR);
 out:
-	CS_LOCK(drvdata->base);
+	etm4_cs_lock(drvdata, csa);
 	return ret;
 }
 
@@ -1352,8 +1363,7 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 	struct csdev_access tmp_csa = CSDEV_ACCESS_IOMEM(drvdata->base);
 	struct csdev_access *csa = &tmp_csa;
 
-	CS_UNLOCK(drvdata->base);
-
+	etm4_cs_unlock(drvdata, csa);
 	etm4x_relaxed_write32(csa, state->trcclaimset, TRCCLAIMSET);
 
 	etm4x_relaxed_write32(csa, state->trcprgctlr, TRCPRGCTLR);
@@ -1438,7 +1448,7 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 
 	/* Unlock the OS lock to re-enable trace and external debug access */
 	etm4_os_unlock(drvdata);
-	CS_LOCK(drvdata->base);
+	etm4_cs_lock(drvdata, csa);
 }
 
 static int etm4_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
-- 
2.24.1

