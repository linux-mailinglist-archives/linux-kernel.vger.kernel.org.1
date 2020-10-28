Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7FE29DF95
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbgJ1WLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:11:16 -0400
Received: from foss.arm.com ([217.140.110.172]:39206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730522AbgJ1WKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:10:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F8721AC1;
        Wed, 28 Oct 2020 15:10:25 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A3273F68F;
        Wed, 28 Oct 2020 15:10:24 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 22/26] coresight: etm4x: Add necessary synchronization for sysreg access
Date:   Wed, 28 Oct 2020 22:09:41 +0000
Message-Id: <20201028220945.3826358-24-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201028220945.3826358-1-suzuki.poulose@arm.com>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the specification any update to the TRCPRGCTLR must be synchronized
by a context synchronization event (in our case an explicist ISB) before
the TRCSTATR is checked.

Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index e36bc1c722c7..4bc2f15b6332 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -178,6 +178,15 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	/* Disable the trace unit before programming trace registers */
 	etm4x_relaxed_write32(csa, 0, TRCPRGCTLR);
 
+	/*
+	 * If we use system instructions, we need to synchronize the
+	 * write to the TRCPRGCTLR, before accessing the TRCSTATR.
+	 * See ARM IHI0064F, section
+	 * "4.3.7 Synchronization of register updates"
+	 */
+	if (!csa->io_mem)
+		isb();
+
 	/* wait for TRCSTATR.IDLE to go up */
 	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 1))
 		dev_err(etm_dev,
@@ -256,6 +265,10 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	/* Enable the trace unit */
 	etm4x_relaxed_write32(csa, 1, TRCPRGCTLR);
 
+	/* Synchronize the register updates for sysreg access */
+	if (!csa->io_mem)
+		isb();
+
 	/* wait for TRCSTATR.IDLE to go back down to '0' */
 	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 0))
 		dev_err(etm_dev,
-- 
2.24.1

