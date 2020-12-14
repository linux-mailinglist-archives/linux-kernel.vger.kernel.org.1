Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6227B2D9EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 19:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440732AbgLNSXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 13:23:32 -0500
Received: from foss.arm.com ([217.140.110.172]:50338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502343AbgLNRid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:38:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57939D6E;
        Mon, 14 Dec 2020 09:37:45 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D747C3F66E;
        Mon, 14 Dec 2020 09:37:43 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, jonathan.zhouwen@huawei.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>
Subject: [PATCH v5 02/25] coresight: etm4x: Skip accessing TRCPDCR in save/restore
Date:   Mon, 14 Dec 2020 17:37:08 +0000
Message-Id: <20201214173731.302520-3-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201214173731.302520-1-suzuki.poulose@arm.com>
References: <20201214173731.302520-1-suzuki.poulose@arm.com>
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
index eb56fba1f7c0..20136722011e 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1277,7 +1277,8 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 
 	state->trcclaimset = readl(drvdata->base + TRCCLAIMCLR);
 
-	state->trcpdcr = readl(drvdata->base + TRCPDCR);
+	if (!drvdata->skip_power_up)
+		state->trcpdcr = readl(drvdata->base + TRCPDCR);
 
 	/* wait for TRCSTATR.IDLE to go up */
 	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 1)) {
@@ -1295,9 +1296,9 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
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
@@ -1392,7 +1393,8 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 
 	writel_relaxed(state->trcclaimset, drvdata->base + TRCCLAIMSET);
 
-	writel_relaxed(state->trcpdcr, drvdata->base + TRCPDCR);
+	if (!drvdata->skip_power_up)
+		writel_relaxed(state->trcpdcr, drvdata->base + TRCPDCR);
 
 	drvdata->state_needs_restore = false;
 
-- 
2.24.1

