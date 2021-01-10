Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D292F0A27
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 23:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbhAJWv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 17:51:29 -0500
Received: from foss.arm.com ([217.140.110.172]:39112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbhAJWvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 17:51:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 114331570;
        Sun, 10 Jan 2021 14:49:38 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B697D3F719;
        Sun, 10 Jan 2021 14:49:36 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        jonathan.zhouwen@huawei.com, catalin.marinas@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v7 23/28] coresight: etm4x: Refactor probing routine
Date:   Sun, 10 Jan 2021 22:48:45 +0000
Message-Id: <20210110224850.1880240-24-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210110224850.1880240-1-suzuki.poulose@arm.com>
References: <20210110224850.1880240-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CoreSight ETM with system register access may not have a
memory mapped i/o access. Refactor the ETM specific probing
into a common routine to allow reusing the code for such ETMs.

Cc: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v4:
 - Refactor the "remove" callback for AMBA driver, for reuse by
   platform_driver to follow
---
 .../coresight/coresight-etm4x-core.c          | 62 ++++++++++++-------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 6cbc6e0c0819..06edb9554c27 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1708,14 +1708,11 @@ static void etm4_pm_clear(void)
 	}
 }
 
-static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
+static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 {
 	int ret;
-	void __iomem *base;
-	struct device *dev = &adev->dev;
 	struct coresight_platform_data *pdata = NULL;
 	struct etmv4_drvdata *drvdata;
-	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
 	struct etm4_init_arg init_arg = { 0 };
 
@@ -1739,11 +1736,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	if (fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
 		drvdata->skip_power_up = true;
 
-	/* Validity for the resource is already checked by the AMBA core */
-	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
 	drvdata->base = base;
 
 	spin_lock_init(&drvdata->spinlock);
@@ -1773,7 +1765,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	if (IS_ERR(pdata))
 		return PTR_ERR(pdata);
 
-	adev->dev.platform_data = pdata;
+	dev->platform_data = pdata;
 
 	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
 	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
@@ -1793,7 +1785,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 
 	etmdrvdata[drvdata->cpu] = drvdata;
 
-	pm_runtime_put(&adev->dev);
 	dev_info(&drvdata->csdev->dev, "CPU%d: ETM v%d.%d initialized\n",
 		 drvdata->cpu, ETM_ARCH_MAJOR_VERSION(drvdata->arch),
 		 ETM_ARCH_MINOR_VERSION(drvdata->arch));
@@ -1803,11 +1794,30 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 		drvdata->boot_enable = true;
 	}
 
-	etm4_check_arch_features(drvdata, id->id);
+	etm4_check_arch_features(drvdata, etm_pid);
 
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
+	ret = etm4_probe(dev, base, id->id);
+	if (!ret)
+		pm_runtime_put(&adev->dev);
+
+	return ret;
+}
+
 static struct amba_cs_uci_id uci_id_etm4[] = {
 	{
 		/*  ETMv4 UCI data */
@@ -1824,15 +1834,12 @@ static void clear_etmdrvdata(void *info)
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
@@ -1851,6 +1858,15 @@ static int etm4_remove(struct amba_device *adev)
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
@@ -1872,14 +1888,14 @@ static const struct amba_id etm4_ids[] = {
 
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
 
@@ -1893,7 +1909,7 @@ static int __init etm4x_init(void)
 	if (ret)
 		return ret;
 
-	ret = amba_driver_register(&etm4x_driver);
+	ret = amba_driver_register(&etm4x_amba_driver);
 	if (ret) {
 		pr_err("Error registering etm4x driver\n");
 		etm4_pm_clear();
@@ -1904,7 +1920,7 @@ static int __init etm4x_init(void)
 
 static void __exit etm4x_exit(void)
 {
-	amba_driver_unregister(&etm4x_driver);
+	amba_driver_unregister(&etm4x_amba_driver);
 	etm4_pm_clear();
 }
 
-- 
2.24.1

