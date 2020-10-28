Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DC329D5FE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbgJ1WKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:10:40 -0400
Received: from foss.arm.com ([217.140.110.172]:39128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730503AbgJ1WKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:10:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B5481A25;
        Wed, 28 Oct 2020 15:10:22 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 33CA83F68F;
        Wed, 28 Oct 2020 15:10:21 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 19/26] coresight: etm4x: Detect access early on the target CPU
Date:   Wed, 28 Oct 2020 22:09:38 +0000
Message-Id: <20201028220945.3826358-21-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201028220945.3826358-1-suzuki.poulose@arm.com>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to detect the support for system instruction
support, move the detection of the device access to the target
CPU.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 45 ++++++++++++++++---
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index f038bb10bc78..308674ab746c 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -56,6 +56,11 @@ static u64 etm4_get_access_type(struct etmv4_config *config);
 
 static enum cpuhp_state hp_online;
 
+struct etm_init_arg {
+	struct etmv4_drvdata	*drvdata;
+	struct csdev_access	*csa;
+};
+
 u64 etm4x_sysreg_read(struct csdev_access *csa,
 		      u32 offset,
 		      bool _relaxed,
@@ -669,6 +674,22 @@ static const struct coresight_ops etm4_cs_ops = {
 	.source_ops	= &etm4_source_ops,
 };
 
+static bool etm_init_iomem_access(struct etmv4_drvdata *drvdata,
+				  struct csdev_access *csa)
+{
+	*csa = CSDEV_ACCESS_IOMEM(drvdata->base);
+	return true;
+}
+
+static bool etm_init_csdev_access(struct etmv4_drvdata *drvdata,
+				  struct csdev_access *csa)
+{
+	if (drvdata->base)
+		return etm_init_iomem_access(drvdata, csa);
+
+	return false;
+}
+
 static void etm4_init_arch_data(void *info)
 {
 	u32 etmidr0;
@@ -677,11 +698,22 @@ static void etm4_init_arch_data(void *info)
 	u32 etmidr3;
 	u32 etmidr4;
 	u32 etmidr5;
-	struct etmv4_drvdata *drvdata = info;
-	struct csdev_access tmp_csa = CSDEV_ACCESS_IOMEM(drvdata->base);
-	struct csdev_access *csa = &tmp_csa;
+	struct etm_init_arg *init_arg = info;
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
+	if (!etm_init_csdev_access(drvdata, csa))
+		return;
+
 	/* Make sure all registers are accessible */
 	etm4_os_unlock_csa(drvdata, csa);
 	etm4_cs_unlock(drvdata, csa);
@@ -1524,6 +1556,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	struct etmv4_drvdata *drvdata;
 	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
+	struct etm_init_arg init_arg = { 0 };
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
@@ -1551,7 +1584,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 		return PTR_ERR(base);
 
 	drvdata->base = base;
-	desc.access = CSDEV_ACCESS_IOMEM(base);
 
 	spin_lock_init(&drvdata->spinlock);
 
@@ -1563,8 +1595,11 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
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

