Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FD72F0A10
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 23:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbhAJWtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 17:49:51 -0500
Received: from foss.arm.com ([217.140.110.172]:38792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbhAJWtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 17:49:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF645113E;
        Sun, 10 Jan 2021 14:49:03 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 907463F719;
        Sun, 10 Jan 2021 14:49:02 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        jonathan.zhouwen@huawei.com, catalin.marinas@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v7 01/28] coresight: etm4x: Handle access to TRCSSPCICRn
Date:   Sun, 10 Jan 2021 22:48:23 +0000
Message-Id: <20210110224850.1880240-2-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210110224850.1880240-1-suzuki.poulose@arm.com>
References: <20210110224850.1880240-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TRCSSPCICR<n> is present only if all of the following are true:
	TRCIDR4.NUMSSCC > n.
	TRCIDR4.NUMPC > 0b0000 .
	TRCSSCSR<n>.PC == 0b1

Add a helper function to check all the conditions.

Cc: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v3:
 - Check for TRCSSCSRn.PC too.  (Mathieu)
 - Moved into a helper for easy reuse.
---
 .../coresight/coresight-etm4x-core.c          | 29 +++++++++++++++----
 drivers/hwtracing/coresight/coresight-etm4x.h |  2 ++
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index b20b6ff17cf6..76526679b998 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -59,6 +59,22 @@ static u64 etm4_get_access_type(struct etmv4_config *config);
 
 static enum cpuhp_state hp_online;
 
+/*
+ * Check if TRCSSPCICRn(i) is implemented for a given instance.
+ *
+ * TRCSSPCICRn is implemented only if :
+ *	TRCSSPCICR<n> is present only if all of the following are true:
+ *		TRCIDR4.NUMSSCC > n.
+ *		TRCIDR4.NUMPC > 0b0000 .
+ *		TRCSSCSR<n>.PC == 0b1
+ */
+static inline bool etm4x_sspcicrn_present(struct etmv4_drvdata *drvdata, int n)
+{
+	return (n < drvdata->nr_ss_cmp) &&
+	       drvdata->nr_pe &&
+	       (drvdata->config.ss_status[n] & TRCSSCSRn_PC);
+}
+
 static void etm4_os_unlock(struct etmv4_drvdata *drvdata)
 {
 	/* Writing 0 to TRCOSLAR unlocks the trace registers */
@@ -270,8 +286,9 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 			       drvdata->base + TRCSSCCRn(i));
 		writel_relaxed(config->ss_status[i],
 			       drvdata->base + TRCSSCSRn(i));
-		writel_relaxed(config->ss_pe_cmp[i],
-			       drvdata->base + TRCSSPCICRn(i));
+		if (etm4x_sspcicrn_present(drvdata, i))
+			writel_relaxed(config->ss_pe_cmp[i],
+				       drvdata->base + TRCSSPCICRn(i));
 	}
 	for (i = 0; i < drvdata->nr_addr_cmp; i++) {
 		writeq_relaxed(config->addr_val[i],
@@ -1324,7 +1341,8 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
 		state->trcssccr[i] = readl(drvdata->base + TRCSSCCRn(i));
 		state->trcsscsr[i] = readl(drvdata->base + TRCSSCSRn(i));
-		state->trcsspcicr[i] = readl(drvdata->base + TRCSSPCICRn(i));
+		if (etm4x_sspcicrn_present(drvdata, i))
+			state->trcsspcicr[i] = readl(drvdata->base + TRCSSPCICRn(i));
 	}
 
 	for (i = 0; i < drvdata->nr_addr_cmp * 2; i++) {
@@ -1440,8 +1458,9 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 			       drvdata->base + TRCSSCCRn(i));
 		writel_relaxed(state->trcsscsr[i],
 			       drvdata->base + TRCSSCSRn(i));
-		writel_relaxed(state->trcsspcicr[i],
-			       drvdata->base + TRCSSPCICRn(i));
+		if (etm4x_sspcicrn_present(drvdata, i))
+			writel_relaxed(state->trcsspcicr[i],
+				       drvdata->base + TRCSSPCICRn(i));
 	}
 
 	for (i = 0; i < drvdata->nr_addr_cmp * 2; i++) {
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 3dd3e0633328..80e480c7fe5c 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -179,6 +179,8 @@
 #define TRCSTATR_PMSTABLE_BIT		1
 #define ETM_DEFAULT_ADDR_COMP		0
 
+#define TRCSSCSRn_PC			BIT(3)
+
 /* PowerDown Control Register bits */
 #define TRCPDCR_PU			BIT(3)
 
-- 
2.24.1

