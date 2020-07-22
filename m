Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE84229E57
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 19:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbgGVRVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 13:21:01 -0400
Received: from foss.arm.com ([217.140.110.172]:59974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgGVRVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:21:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20F4131B;
        Wed, 22 Jul 2020 10:21:00 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3C6A53F66F;
        Wed, 22 Jul 2020 10:20:59 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RFC PATCH 04/14] coresight: etm4x: Free up argument of etm4_init_arch_data
Date:   Wed, 22 Jul 2020 18:20:30 +0100
Message-Id: <20200722172040.1299289-5-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200722172040.1299289-1-suzuki.poulose@arm.com>
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

etm4_init_arch_data is called early during the device probe,
even before the coresight_device is registered. Since we are
about to replace the direct access via abstraction layer, we
need a way to pass in the csdev_access for the given device.
Towards this free up the argument, which is already available
via etmdrvdata[smp_processor_id()].

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 7bb74c659c4f..67deb4a4e618 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -614,7 +614,8 @@ static const struct coresight_ops etm4_cs_ops = {
 	.source_ops	= &etm4_source_ops,
 };
 
-static void etm4_init_arch_data(void *info)
+
+static void etm4_init_arch_data(void *__unused)
 {
 	u32 etmidr0;
 	u32 etmidr1;
@@ -622,8 +623,14 @@ static void etm4_init_arch_data(void *info)
 	u32 etmidr3;
 	u32 etmidr4;
 	u32 etmidr5;
-	struct etmv4_drvdata *drvdata = info;
-	int i;
+	struct etmv4_drvdata *drvdata;
+	int i, cpu;
+
+	cpu = raw_smp_processor_id();
+	drvdata = etmdrvdata[cpu];
+
+	if (WARN_ON(!etmdrvdata[cpu]))
+		return;
 
 	/* Make sure all registers are accessible */
 	etm4_os_unlock(drvdata);
@@ -1517,7 +1524,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	etmdrvdata[drvdata->cpu] = drvdata;
 
 	if (smp_call_function_single(drvdata->cpu,
-				etm4_init_arch_data,  drvdata, 1))
+				etm4_init_arch_data,  NULL, 1))
 		dev_err(dev, "ETM arch init failed\n");
 
 	ret = etm4_pm_setup_cpuslocked();
-- 
2.24.1

