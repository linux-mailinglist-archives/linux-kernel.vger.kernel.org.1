Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE98829DFB1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbgJ2BD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:03:58 -0400
Received: from foss.arm.com ([217.140.110.172]:39030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730420AbgJ1WKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:10:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5475231B;
        Wed, 28 Oct 2020 15:10:03 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 618EF3F73C;
        Wed, 28 Oct 2020 15:10:02 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 02/26] coresight: etm4x: Fix accesses to TRCCIDCTLR1
Date:   Wed, 28 Oct 2020 22:09:21 +0000
Message-Id: <20201028220945.3826358-4-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201028220945.3826358-1-suzuki.poulose@arm.com>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TRCCIDCTLR1 is only implemented if TRCIDR4.NUMCIDC > 4.
Don't touch the register if it is not implemented.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index e67365d1ce28..af0ab2f44865 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -187,7 +187,8 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 		writeq_relaxed(config->ctxid_pid[i],
 			       drvdata->base + TRCCIDCVRn(i));
 	writel_relaxed(config->ctxid_mask0, drvdata->base + TRCCIDCCTLR0);
-	writel_relaxed(config->ctxid_mask1, drvdata->base + TRCCIDCCTLR1);
+	if (drvdata->numcidc > 4)
+		writel_relaxed(config->ctxid_mask1, drvdata->base + TRCCIDCCTLR1);
 
 	for (i = 0; i < drvdata->numvmidc; i++)
 		writeq_relaxed(config->vmid_val[i],
@@ -1241,7 +1242,8 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 		state->trcvmidcvr[i] = readq(drvdata->base + TRCVMIDCVRn(i));
 
 	state->trccidcctlr0 = readl(drvdata->base + TRCCIDCCTLR0);
-	state->trccidcctlr1 = readl(drvdata->base + TRCCIDCCTLR1);
+	if (drvdata->numcidc > 4)
+		state->trccidcctlr1 = readl(drvdata->base + TRCCIDCCTLR1);
 
 	state->trcvmidcctlr0 = readl(drvdata->base + TRCVMIDCCTLR0);
 	if (drvdata->numvmidc > 4)
@@ -1352,7 +1354,8 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 			       drvdata->base + TRCVMIDCVRn(i));
 
 	writel_relaxed(state->trccidcctlr0, drvdata->base + TRCCIDCCTLR0);
-	writel_relaxed(state->trccidcctlr1, drvdata->base + TRCCIDCCTLR1);
+	if (drvdata->numcidc > 4)
+		writel_relaxed(state->trccidcctlr1, drvdata->base + TRCCIDCCTLR1);
 
 	writel_relaxed(state->trcvmidcctlr0, drvdata->base + TRCVMIDCCTLR0);
 	if (drvdata->numvmidc > 4)
-- 
2.24.1

