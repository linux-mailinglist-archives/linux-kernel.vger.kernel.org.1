Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89925229E55
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 19:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbgGVRU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 13:20:57 -0400
Received: from foss.arm.com ([217.140.110.172]:59944 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730800AbgGVRU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:20:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF08AD6E;
        Wed, 22 Jul 2020 10:20:56 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EA5C63F66F;
        Wed, 22 Jul 2020 10:20:55 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RFC PATCH 01/14] coresight: etm4x: Skip save/restore before device registration
Date:   Wed, 22 Jul 2020 18:20:27 +0100
Message-Id: <20200722172040.1299289-2-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200722172040.1299289-1-suzuki.poulose@arm.com>
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip cpu save/restore before the coresight device is registered.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 6d7d2169bfb2..cb83fb77ded6 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1135,7 +1135,13 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 {
 	int i, ret = 0;
 	struct etmv4_save_state *state;
-	struct device *etm_dev = &drvdata->csdev->dev;
+	struct coresight_device *csdev = drvdata->csdev;
+	struct device *etm_dev;
+
+	if (WARN_ON(!csdev))
+		return -ENODEV;
+
+	etm_dev = &csdev->dev;
 
 	/*
 	 * As recommended by 3.4.1 ("The procedure when powering down the PE")
@@ -1261,6 +1267,10 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 {
 	int i;
 	struct etmv4_save_state *state = drvdata->save_state;
+	struct coresight_device *csdev = drvdata->csdev;
+
+	if (WARN_ON(!csdev))
+		return;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -1368,6 +1378,10 @@ static int etm4_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
 
 	drvdata = etmdrvdata[cpu];
 
+	/* If we have not registered the device there is nothing to do */
+	if (!drvdata->csdev)
+		return NOTIFY_OK;
+
 	if (!drvdata->save_state)
 		return NOTIFY_OK;
 
-- 
2.24.1

