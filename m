Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFF829D5F9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbgJ1WKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:10:32 -0400
Received: from foss.arm.com ([217.140.110.172]:39114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730462AbgJ1WKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:10:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF9E41763;
        Wed, 28 Oct 2020 15:10:18 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E0EFD3F68F;
        Wed, 28 Oct 2020 15:10:17 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 16/26] coresight: etm4x: Check for Software Lock
Date:   Wed, 28 Oct 2020 22:09:35 +0000
Message-Id: <20201028220945.3826358-18-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201028220945.3826358-1-suzuki.poulose@arm.com>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Software lock is not implemented for system instructions
based accesses. So, skip the lock register access in such
cases.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 40 ++++++++++++-------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index a5c914b16e59..a12d58a04c5d 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -121,6 +121,21 @@ static void etm4_os_lock(struct etmv4_drvdata *drvdata)
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
@@ -160,8 +175,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	struct device *etm_dev = &csdev->dev;
 	struct csdev_access *csa = &csdev->access;
 
-	CS_UNLOCK(drvdata->base);
-
+	etm4_cs_unlock(drvdata, csa);
 	etm4_os_unlock(drvdata);
 
 	rc = coresight_claim_device_unlocked(csdev);
@@ -262,7 +276,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	isb();
 
 done:
-	CS_LOCK(drvdata->base);
+	etm4_cs_lock(drvdata, csa);
 
 	dev_dbg(etm_dev, "cpu: %d enable smp call done: %d\n",
 		drvdata->cpu, rc);
@@ -519,7 +533,7 @@ static void etm4_disable_hw(void *info)
 	struct csdev_access *csa = &csdev->access;
 	int i;
 
-	CS_UNLOCK(drvdata->base);
+	etm4_cs_unlock(drvdata, csa);
 
 	if (!drvdata->skip_power_up) {
 		/* power can be removed from the trace unit now */
@@ -560,8 +574,7 @@ static void etm4_disable_hw(void *info)
 	}
 
 	coresight_disclaim_device_unlocked(csdev);
-
-	CS_LOCK(drvdata->base);
+	etm4_cs_lock(drvdata, csa);
 
 	dev_dbg(&drvdata->csdev->dev,
 		"cpu: %d disable smp call done\n", drvdata->cpu);
@@ -671,8 +684,7 @@ static void etm4_init_arch_data(void *info)
 
 	/* Make sure all registers are accessible */
 	etm4_os_unlock_csa(drvdata, csa);
-
-	CS_UNLOCK(drvdata->base);
+	etm4_cs_unlock(drvdata, csa);
 
 	/* find all capabilities of the tracing unit */
 	etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
@@ -837,7 +849,7 @@ static void etm4_init_arch_data(void *info)
 	drvdata->nrseqstate = BMVAL(etmidr5, 25, 27);
 	/* NUMCNTR, bits[30:28] number of counters available for tracing */
 	drvdata->nr_cntr = BMVAL(etmidr5, 28, 30);
-	CS_LOCK(drvdata->base);
+	etm4_cs_lock(drvdata, csa);
 }
 
 /* Set ELx trace filter access in the TRCVICTLR register */
@@ -1218,8 +1230,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	dsb(sy);
 	isb();
 
-	CS_UNLOCK(drvdata->base);
-
+	etm4_cs_unlock(drvdata, csa);
 	/* Lock the OS lock to disable trace and external debugger access */
 	etm4_os_lock(drvdata);
 
@@ -1330,7 +1341,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	etm4x_relaxed_write32(csa, (state->trcpdcr & ~TRCPDCR_PU), TRCPDCR);
 
 out:
-	CS_LOCK(drvdata->base);
+	etm4_cs_lock(drvdata, csa);
 	return ret;
 }
 
@@ -1341,8 +1352,7 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 	struct csdev_access tmp_csa = CSDEV_ACCESS_IOMEM(drvdata->base);
 	struct csdev_access *csa = &tmp_csa;
 
-	CS_UNLOCK(drvdata->base);
-
+	etm4_cs_unlock(drvdata, csa);
 	etm4x_relaxed_write32(csa, state->trcclaimset, TRCCLAIMSET);
 
 	etm4x_relaxed_write32(csa, state->trcprgctlr, TRCPRGCTLR);
@@ -1426,7 +1436,7 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 
 	/* Unlock the OS lock to re-enable trace and external debug access */
 	etm4_os_unlock(drvdata);
-	CS_LOCK(drvdata->base);
+	etm4_cs_lock(drvdata, csa);
 }
 
 static int etm4_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
-- 
2.24.1

