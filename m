Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1833F29D600
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbgJ1WKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:10:44 -0400
Received: from foss.arm.com ([217.140.110.172]:39252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730567AbgJ1WKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:10:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92EDA1763;
        Wed, 28 Oct 2020 15:10:37 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AA3483F73C;
        Wed, 28 Oct 2020 15:10:26 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 24/26] coresight: etm4x: Refactor probing routine
Date:   Wed, 28 Oct 2020 22:09:43 +0000
Message-Id: <20201028220945.3826358-26-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201028220945.3826358-1-suzuki.poulose@arm.com>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CoreSight ETM with system register access may not have a
memory mapped i/o access. Refactor the ETM specific probing
into a common routine to allow reusing the code for such ETMs.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 48 +++++++++++--------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index dc537b5612eb..25fab5513604 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1598,14 +1598,11 @@ static void etm4_pm_clear(void)
 	}
 }
 
-static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
+static int etm4_probe(struct device *dev, void __iomem *base)
 {
 	int ret;
-	void __iomem *base;
-	struct device *dev = &adev->dev;
 	struct coresight_platform_data *pdata = NULL;
 	struct etmv4_drvdata *drvdata;
-	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
 	struct etm_init_arg init_arg = { 0 };
 
@@ -1629,11 +1626,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	if (fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
 		drvdata->skip_power_up = true;
 
-	/* Validity for the resource is already checked by the AMBA core */
-	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
 	drvdata->base = base;
 
 	spin_lock_init(&drvdata->spinlock);
@@ -1663,7 +1655,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	if (IS_ERR(pdata))
 		return PTR_ERR(pdata);
 
-	adev->dev.platform_data = pdata;
+	dev->platform_data = pdata;
 
 	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
 	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
@@ -1683,7 +1675,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 
 	etmdrvdata[drvdata->cpu] = drvdata;
 
-	pm_runtime_put(&adev->dev);
 	dev_info(&drvdata->csdev->dev, "CPU%d: ETM v%d.%d initialized\n",
 		 drvdata->cpu, ETM_ARCH_MAJOR_VERSION(drvdata->arch),
 		 ETM_ARCH_MINOR_VERSION(drvdata->arch));
@@ -1696,6 +1687,25 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	return 0;
 }
 
+static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
+{
+	void __iomem *base;
+	struct device *dev = &adev->dev;
+	struct resource *res = &adev->res;
+	int ret;
+
+	/* Validity for the resource is already checked by the AMBA core */
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	ret = etm4_probe(dev, base);
+	if (!ret)
+		pm_runtime_put(&adev->dev);
+
+	return ret;
+}
+
 static struct amba_cs_uci_id uci_id_etm4[] = {
 	{
 		/*  ETMv4 UCI data */
@@ -1712,15 +1722,15 @@ static void __exit clear_etmdrvdata(void *info)
 	etmdrvdata[cpu] = NULL;
 }
 
-static int __exit etm4_remove(struct amba_device *adev)
+static int __exit etm4_remove_amba(struct amba_device *adev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(&adev->dev);
 
 	etm_perf_symlink(drvdata->csdev, false);
 
 	/*
-	 * Taking hotplug lock here to avoid racing between etm4_remove and
-	 * CPU hotplug call backs.
+	 * Taking hotplug lock here to avoid racing between etm4_remove_amba()
+	 * and CPU hotplug call backs.
 	 */
 	cpus_read_lock();
 	/*
@@ -1760,14 +1770,14 @@ static const struct amba_id etm4_ids[] = {
 
 MODULE_DEVICE_TABLE(amba, etm4_ids);
 
-static struct amba_driver etm4x_driver = {
+static struct amba_driver etm4x_amba_driver = {
 	.drv = {
 		.name   = "coresight-etm4x",
 		.owner  = THIS_MODULE,
 		.suppress_bind_attrs = true,
 	},
-	.probe		= etm4_probe,
-	.remove         = etm4_remove,
+	.probe		= etm4_probe_amba,
+	.remove         = etm4_remove_amba,
 	.id_table	= etm4_ids,
 };
 
@@ -1781,7 +1791,7 @@ static int __init etm4x_init(void)
 	if (ret)
 		return ret;
 
-	ret = amba_driver_register(&etm4x_driver);
+	ret = amba_driver_register(&etm4x_amba_driver);
 	if (ret) {
 		pr_err("Error registering etm4x driver\n");
 		etm4_pm_clear();
@@ -1792,7 +1802,7 @@ static int __init etm4x_init(void)
 
 static void __exit etm4x_exit(void)
 {
-	amba_driver_unregister(&etm4x_driver);
+	amba_driver_unregister(&etm4x_amba_driver);
 	etm4_pm_clear();
 }
 
-- 
2.24.1

