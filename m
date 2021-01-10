Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C92F2F0A12
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 23:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbhAJWt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 17:49:56 -0500
Received: from foss.arm.com ([217.140.110.172]:38804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbhAJWtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 17:49:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A245311B3;
        Sun, 10 Jan 2021 14:49:05 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1E1D13F719;
        Sun, 10 Jan 2021 14:49:04 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        jonathan.zhouwen@huawei.com, catalin.marinas@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>
Subject: [PATCH v7 02/28] coresight: etm4x: Skip accessing TRCPDCR in save/restore
Date:   Sun, 10 Jan 2021 22:48:24 +0000
Message-Id: <20210110224850.1880240-3-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210110224850.1880240-1-suzuki.poulose@arm.com>
References: <20210110224850.1880240-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the ETM is affected by Qualcomm errata, modifying the
TRCPDCR could cause the system hang. Even though this is
taken care of during enable/disable ETM, the ETM state
save/restore could still access the TRCPDCR. Make sure
we skip the access during the save/restore.

Found by code inspection.

Fixes: 02510a5aa78df45 ("coresight: etm4x: Add support to skip trace unit power up")
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 76526679b998..cce65fc0c9aa 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1373,7 +1373,8 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 
 	state->trcclaimset = readl(drvdata->base + TRCCLAIMCLR);
 
-	state->trcpdcr = readl(drvdata->base + TRCPDCR);
+	if (!drvdata->skip_power_up)
+		state->trcpdcr = readl(drvdata->base + TRCPDCR);
 
 	/* wait for TRCSTATR.IDLE to go up */
 	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 1)) {
@@ -1391,9 +1392,9 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	 * potentially save power on systems that respect the TRCPDCR_PU
 	 * despite requesting software to save/restore state.
 	 */
-	writel_relaxed((state->trcpdcr & ~TRCPDCR_PU),
-			drvdata->base + TRCPDCR);
-
+	if (!drvdata->skip_power_up)
+		writel_relaxed((state->trcpdcr & ~TRCPDCR_PU),
+				drvdata->base + TRCPDCR);
 out:
 	CS_LOCK(drvdata->base);
 	return ret;
@@ -1488,7 +1489,8 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 
 	writel_relaxed(state->trcclaimset, drvdata->base + TRCCLAIMSET);
 
-	writel_relaxed(state->trcpdcr, drvdata->base + TRCPDCR);
+	if (!drvdata->skip_power_up)
+		writel_relaxed(state->trcpdcr, drvdata->base + TRCPDCR);
 
 	drvdata->state_needs_restore = false;
 
-- 
2.24.1

