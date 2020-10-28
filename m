Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2B029DFAD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbgJ2BDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:03:49 -0400
Received: from foss.arm.com ([217.140.110.172]:39068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730414AbgJ1WKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:10:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99034176A;
        Wed, 28 Oct 2020 15:10:06 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC3CD3F73C;
        Wed, 28 Oct 2020 15:10:05 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 05/26] coresight: etm4x: Handle TRCVIPCSSCTLR accesses
Date:   Wed, 28 Oct 2020 22:09:24 +0000
Message-Id: <20201028220945.3826358-7-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201028220945.3826358-1-suzuki.poulose@arm.com>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TRCVIPCSSCTLR is not present if the TRCIDR4.NUMPC > 0. Thus we
should only access the register if it is present, preventing
any undesired behavior.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 28dd278f6d47..d78a37b6592c 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -141,8 +141,9 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	writel_relaxed(config->viiectlr, drvdata->base + TRCVIIECTLR);
 	writel_relaxed(config->vissctlr,
 		       drvdata->base + TRCVISSCTLR);
-	writel_relaxed(config->vipcssctlr,
-		       drvdata->base + TRCVIPCSSCTLR);
+	if (drvdata->nr_pe_cmp)
+		writel_relaxed(config->vipcssctlr,
+			       drvdata->base + TRCVIPCSSCTLR);
 	for (i = 0; i < drvdata->nrseqstate - 1; i++)
 		writel_relaxed(config->seq_ctrl[i],
 			       drvdata->base + TRCSEQEVRn(i));
@@ -1202,7 +1203,8 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	state->trcvictlr = readl(drvdata->base + TRCVICTLR);
 	state->trcviiectlr = readl(drvdata->base + TRCVIIECTLR);
 	state->trcvissctlr = readl(drvdata->base + TRCVISSCTLR);
-	state->trcvipcssctlr = readl(drvdata->base + TRCVIPCSSCTLR);
+	if (drvdata->nr_pe_cmp)
+		state->trcvipcssctlr = readl(drvdata->base + TRCVIPCSSCTLR);
 	state->trcvdctlr = readl(drvdata->base + TRCVDCTLR);
 	state->trcvdsacctlr = readl(drvdata->base + TRCVDSACCTLR);
 	state->trcvdarcctlr = readl(drvdata->base + TRCVDARCCTLR);
@@ -1310,7 +1312,8 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 	writel_relaxed(state->trcvictlr, drvdata->base + TRCVICTLR);
 	writel_relaxed(state->trcviiectlr, drvdata->base + TRCVIIECTLR);
 	writel_relaxed(state->trcvissctlr, drvdata->base + TRCVISSCTLR);
-	writel_relaxed(state->trcvipcssctlr, drvdata->base + TRCVIPCSSCTLR);
+	if (drvdata->nr_pe_cmp)
+		writel_relaxed(state->trcvipcssctlr, drvdata->base + TRCVIPCSSCTLR);
 	writel_relaxed(state->trcvdctlr, drvdata->base + TRCVDCTLR);
 	writel_relaxed(state->trcvdsacctlr, drvdata->base + TRCVDSACCTLR);
 	writel_relaxed(state->trcvdarcctlr, drvdata->base + TRCVDARCCTLR);
-- 
2.24.1

