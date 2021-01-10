Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DA02F0A25
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 23:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbhAJWvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 17:51:25 -0500
Received: from foss.arm.com ([217.140.110.172]:39106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbhAJWvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 17:51:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0230A152D;
        Sun, 10 Jan 2021 14:49:35 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A77C23F719;
        Sun, 10 Jan 2021 14:49:33 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        jonathan.zhouwen@huawei.com, catalin.marinas@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v7 21/28] coresight: etm4x: Add necessary synchronization for sysreg access
Date:   Sun, 10 Jan 2021 22:48:43 +0000
Message-Id: <20210110224850.1880240-22-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210110224850.1880240-1-suzuki.poulose@arm.com>
References: <20210110224850.1880240-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the specification any update to the TRCPRGCTLR must be synchronized
by a context synchronization event (in our case an explicist ISB) before
the TRCSTATR is checked.

Cc: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 5d3041eccc14..3b17feb86d8a 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -284,6 +284,15 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
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
@@ -362,6 +371,10 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
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

