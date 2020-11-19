Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51B32B9867
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgKSQqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:46:07 -0500
Received: from foss.arm.com ([217.140.110.172]:34424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbgKSQqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:46:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAC8F1595;
        Thu, 19 Nov 2020 08:46:02 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AE62E3F719;
        Thu, 19 Nov 2020 08:46:01 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        jonathan.zhouwen@huawei.com, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 01/25] coresight: etm4x: Handle access to TRCSSPCICRn
Date:   Thu, 19 Nov 2020 16:45:23 +0000
Message-Id: <20201119164547.2982871-2-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201119164547.2982871-1-suzuki.poulose@arm.com>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
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

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
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
index d78a37b6592c..59a4a166adf4 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -56,6 +56,22 @@ static u64 etm4_get_access_type(struct etmv4_config *config);
 
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
@@ -175,8 +191,9 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
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
@@ -1228,7 +1245,8 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
 		state->trcssccr[i] = readl(drvdata->base + TRCSSCCRn(i));
 		state->trcsscsr[i] = readl(drvdata->base + TRCSSCSRn(i));
-		state->trcsspcicr[i] = readl(drvdata->base + TRCSSPCICRn(i));
+		if (etm4x_sspcicrn_present(drvdata, i))
+			state->trcsspcicr[i] = readl(drvdata->base + TRCSSPCICRn(i));
 	}
 
 	for (i = 0; i < drvdata->nr_addr_cmp * 2; i++) {
@@ -1344,8 +1362,9 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
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
index eefc7371c6c4..f56e011ff132 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -178,6 +178,8 @@
 #define TRCSTATR_PMSTABLE_BIT		1
 #define ETM_DEFAULT_ADDR_COMP		0
 
+#define TRCSSCSRn_PC			BIT(3)
+
 /* PowerDown Control Register bits */
 #define TRCPDCR_PU			BIT(3)
 
-- 
2.24.1

