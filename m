Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA102ED018
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 13:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbhAGMli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 07:41:38 -0500
Received: from foss.arm.com ([217.140.110.172]:59978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728518AbhAGMle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 07:41:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3110614F6;
        Thu,  7 Jan 2021 04:39:36 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1441C3F719;
        Thu,  7 Jan 2021 04:39:34 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, leo.yan@linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v6 16/26] coresight: etm4x: Detect access early on the target CPU
Date:   Thu,  7 Jan 2021 12:38:49 +0000
Message-Id: <20210107123859.674252-17-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210107123859.674252-1-suzuki.poulose@arm.com>
References: <20210107123859.674252-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to detect the support for system instruction
support, move the detection of the device access to the target
CPU.

Cc: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v3
 - Name constructs etm4_xx instead of etm_** (Mathieu)
---
 .../coresight/coresight-etm4x-core.c          | 45 ++++++++++++++++---
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 6e38b1592b5d..a97870ac0d08 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -59,6 +59,11 @@ static u64 etm4_get_access_type(struct etmv4_config *config);
 
 static enum cpuhp_state hp_online;
 
+struct etm4_init_arg {
+	struct etmv4_drvdata	*drvdata;
+	struct csdev_access	*csa;
+};
+
 /*
  * Check if TRCSSPCICRn(i) is implemented for a given instance.
  *
@@ -776,6 +781,22 @@ static const struct coresight_ops etm4_cs_ops = {
 	.source_ops	= &etm4_source_ops,
 };
 
+static bool etm4_init_iomem_access(struct etmv4_drvdata *drvdata,
+				   struct csdev_access *csa)
+{
+	*csa = CSDEV_ACCESS_IOMEM(drvdata->base);
+	return true;
+}
+
+static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
+				   struct csdev_access *csa)
+{
+	if (drvdata->base)
+		return etm4_init_iomem_access(drvdata, csa);
+
+	return false;
+}
+
 static void etm4_init_arch_data(void *info)
 {
 	u32 etmidr0;
@@ -784,11 +805,22 @@ static void etm4_init_arch_data(void *info)
 	u32 etmidr3;
 	u32 etmidr4;
 	u32 etmidr5;
-	struct etmv4_drvdata *drvdata = info;
-	struct csdev_access tmp_csa = CSDEV_ACCESS_IOMEM(drvdata->base);
-	struct csdev_access *csa = &tmp_csa;
+	struct etm4_init_arg *init_arg = info;
+	struct etmv4_drvdata *drvdata;
+	struct csdev_access *csa;
 	int i;
 
+	drvdata = init_arg->drvdata;
+	csa = init_arg->csa;
+
+	/*
+	 * If we are unable to detect the access mechanism,
+	 * or unable to detect the trace unit type, fail
+	 * early.
+	 */
+	if (!etm4_init_csdev_access(drvdata, csa))
+		return;
+
 	/* Make sure all registers are accessible */
 	etm4_os_unlock_csa(drvdata, csa);
 	etm4_cs_unlock(drvdata, csa);
@@ -1634,6 +1666,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	struct etmv4_drvdata *drvdata;
 	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
+	struct etm4_init_arg init_arg = { 0 };
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
@@ -1661,7 +1694,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 		return PTR_ERR(base);
 
 	drvdata->base = base;
-	desc.access = CSDEV_ACCESS_IOMEM(base);
 
 	spin_lock_init(&drvdata->spinlock);
 
@@ -1673,8 +1705,11 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!desc.name)
 		return -ENOMEM;
 
+	init_arg.drvdata = drvdata;
+	init_arg.csa = &desc.access;
+
 	if (smp_call_function_single(drvdata->cpu,
-				etm4_init_arch_data,  drvdata, 1))
+				etm4_init_arch_data,  &init_arg, 1))
 		dev_err(dev, "ETM arch init failed\n");
 
 	if (etm4_arch_supported(drvdata->arch) == false)
-- 
2.24.1

