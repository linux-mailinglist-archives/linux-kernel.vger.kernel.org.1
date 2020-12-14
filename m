Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42252D9E63
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 19:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502587AbgLNSAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 13:00:55 -0500
Received: from foss.arm.com ([217.140.110.172]:50514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408642AbgLNRjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:39:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CB15150C;
        Mon, 14 Dec 2020 09:38:13 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 422BD3F66E;
        Mon, 14 Dec 2020 09:38:12 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, jonathan.zhouwen@huawei.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 21/25] coresight: etm4x: Refactor probing routine
Date:   Mon, 14 Dec 2020 17:37:27 +0000
Message-Id: <20201214173731.302520-22-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201214173731.302520-1-suzuki.poulose@arm.com>
References: <20201214173731.302520-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CoreSight ETM with system register access may not have a
memory mapped i/o access. Refactor the ETM specific probing
into a common routine to allow reusing the code for such ETMs.

Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v4:
 - Refactor the "remove" callback for AMBA driver, for reuse by
   platform_driver to follow
 - Removed Reviewed-by from Mathieu, due to the above
---
 .../coresight/coresight-etm4x-core.c          | 60 ++++++++++++-------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 25eb42c95527..89bb5a424a2b 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1610,14 +1610,11 @@ static void etm4_pm_clear(void)
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
 	struct etm4_init_arg init_arg = { 0 };
 
@@ -1641,11 +1638,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	if (fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
 		drvdata->skip_power_up = true;
 
-	/* Validity for the resource is already checked by the AMBA core */
-	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
 	drvdata->base = base;
 
 	spin_lock_init(&drvdata->spinlock);
@@ -1675,7 +1667,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	if (IS_ERR(pdata))
 		return PTR_ERR(pdata);
 
-	adev->dev.platform_data = pdata;
+	dev->platform_data = pdata;
 
 	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
 	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
@@ -1695,7 +1687,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 
 	etmdrvdata[drvdata->cpu] = drvdata;
 
-	pm_runtime_put(&adev->dev);
 	dev_info(&drvdata->csdev->dev, "CPU%d: ETM v%d.%d initialized\n",
 		 drvdata->cpu, ETM_ARCH_MAJOR_VERSION(drvdata->arch),
 		 ETM_ARCH_MINOR_VERSION(drvdata->arch));
@@ -1708,6 +1699,25 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
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
@@ -1724,15 +1734,12 @@ static void clear_etmdrvdata(void *info)
 	etmdrvdata[cpu] = NULL;
 }
 
-static int etm4_remove(struct amba_device *adev)
+static int __exit etm4_remove_dev(struct etmv4_drvdata *drvdata)
 {
-	struct etmv4_drvdata *drvdata = dev_get_drvdata(&adev->dev);
-
 	etm_perf_symlink(drvdata->csdev, false);
-
 	/*
-	 * Taking hotplug lock here to avoid racing between etm4_remove and
-	 * CPU hotplug call backs.
+	 * Taking hotplug lock here to avoid racing between etm4_remove_dev()
+	 * and CPU hotplug call backs.
 	 */
 	cpus_read_lock();
 	/*
@@ -1751,6 +1758,15 @@ static int etm4_remove(struct amba_device *adev)
 	return 0;
 }
 
+static int __exit etm4_remove_amba(struct amba_device *adev)
+{
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	if (drvdata)
+		return etm4_remove_dev(drvdata);
+	return 0;
+}
+
 static const struct amba_id etm4_ids[] = {
 	CS_AMBA_ID(0x000bb95d),			/* Cortex-A53 */
 	CS_AMBA_ID(0x000bb95e),			/* Cortex-A57 */
@@ -1772,14 +1788,14 @@ static const struct amba_id etm4_ids[] = {
 
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
 
@@ -1793,7 +1809,7 @@ static int __init etm4x_init(void)
 	if (ret)
 		return ret;
 
-	ret = amba_driver_register(&etm4x_driver);
+	ret = amba_driver_register(&etm4x_amba_driver);
 	if (ret) {
 		pr_err("Error registering etm4x driver\n");
 		etm4_pm_clear();
@@ -1804,7 +1820,7 @@ static int __init etm4x_init(void)
 
 static void __exit etm4x_exit(void)
 {
-	amba_driver_unregister(&etm4x_driver);
+	amba_driver_unregister(&etm4x_amba_driver);
 	etm4_pm_clear();
 }
 
-- 
2.24.1

