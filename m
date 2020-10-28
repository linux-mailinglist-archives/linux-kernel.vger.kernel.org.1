Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37A429DFAC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgJ1WKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:10:08 -0400
Received: from foss.arm.com ([217.140.110.172]:39050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730438AbgJ1WKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:10:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 775461764;
        Wed, 28 Oct 2020 15:10:05 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9485C3F73C;
        Wed, 28 Oct 2020 15:10:04 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 04/26] coresight: etm4x: Fix accesses to TRCPROCSELR
Date:   Wed, 28 Oct 2020 22:09:23 +0000
Message-Id: <20201028220945.3826358-6-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201028220945.3826358-1-suzuki.poulose@arm.com>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TRCPROCSELR is not implemented if the TRCIDR3.NUMPROC == 0. Skip
accessing the register in such cases.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index cbbe755d1d16..28dd278f6d47 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -124,8 +124,8 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 1))
 		dev_err(etm_dev,
 			"timeout while waiting for Idle Trace Status\n");
-
-	writel_relaxed(config->pe_sel, drvdata->base + TRCPROCSELR);
+	if (drvdata->nr_pe)
+		writel_relaxed(config->pe_sel, drvdata->base + TRCPROCSELR);
 	writel_relaxed(config->cfg, drvdata->base + TRCCONFIGR);
 	/* nothing specific implemented */
 	writel_relaxed(0x0, drvdata->base + TRCAUXCTLR);
@@ -1185,7 +1185,8 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	state = drvdata->save_state;
 
 	state->trcprgctlr = readl(drvdata->base + TRCPRGCTLR);
-	state->trcprocselr = readl(drvdata->base + TRCPROCSELR);
+	if (drvdata->nr_pe)
+		state->trcprocselr = readl(drvdata->base + TRCPROCSELR);
 	state->trcconfigr = readl(drvdata->base + TRCCONFIGR);
 	state->trcauxctlr = readl(drvdata->base + TRCAUXCTLR);
 	state->trceventctl0r = readl(drvdata->base + TRCEVENTCTL0R);
@@ -1292,7 +1293,8 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 	writel_relaxed(state->trcclaimset, drvdata->base + TRCCLAIMSET);
 
 	writel_relaxed(state->trcprgctlr, drvdata->base + TRCPRGCTLR);
-	writel_relaxed(state->trcprocselr, drvdata->base + TRCPROCSELR);
+	if (drvdata->nr_pe)
+		writel_relaxed(state->trcprocselr, drvdata->base + TRCPROCSELR);
 	writel_relaxed(state->trcconfigr, drvdata->base + TRCCONFIGR);
 	writel_relaxed(state->trcauxctlr, drvdata->base + TRCAUXCTLR);
 	writel_relaxed(state->trceventctl0r, drvdata->base + TRCEVENTCTL0R);
-- 
2.24.1

