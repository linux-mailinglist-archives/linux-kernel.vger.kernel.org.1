Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A29B2D9E6A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 19:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408739AbgLNSAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 13:00:54 -0500
Received: from foss.arm.com ([217.140.110.172]:50522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408641AbgLNRjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:39:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EED7D1516;
        Mon, 14 Dec 2020 09:38:14 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B56693F66E;
        Mon, 14 Dec 2020 09:38:13 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, jonathan.zhouwen@huawei.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 22/25] coresight: etm4x: Add support for sysreg only devices
Date:   Mon, 14 Dec 2020 17:37:28 +0000
Message-Id: <20201214173731.302520-23-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201214173731.302520-1-suzuki.poulose@arm.com>
References: <20201214173731.302520-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for devices with system instruction access only.
They don't have a memory mapped interface and thus are not
AMBA devices.

Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v4
 - Add "remove" callback for platform_driver.
 - Dropped Reviewed-by tag from Mathieu due to the above

Changes since v3
 - Improve comment over "TRCPDCR" usage with sysreg
 - Rename etm_xx => etm4_xx
 - Update the compatible to "arm,coresight-etm4x-sysreg"
---
 .../coresight/coresight-etm4x-core.c          | 63 +++++++++++++++++--
 1 file changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 89bb5a424a2b..fe38c81e0bed 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -26,6 +26,7 @@
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 #include <linux/perf_event.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <asm/sections.h>
@@ -1635,9 +1636,6 @@ static int etm4_probe(struct device *dev, void __iomem *base)
 			return -ENOMEM;
 	}
 
-	if (fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
-		drvdata->skip_power_up = true;
-
 	drvdata->base = base;
 
 	spin_lock_init(&drvdata->spinlock);
@@ -1660,6 +1658,11 @@ static int etm4_probe(struct device *dev, void __iomem *base)
 	if (!drvdata->arch)
 		return -EINVAL;
 
+	/* TRCPDCR is not accessible with system instructions. */
+	if (!desc.access.io_mem ||
+	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
+		drvdata->skip_power_up = true;
+
 	etm4_init_trace_id(drvdata);
 	etm4_set_default(&drvdata->config);
 
@@ -1718,6 +1721,20 @@ static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
+static int etm4_probe_platform_dev(struct platform_device *pdev)
+{
+	int ret;
+
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = etm4_probe(&pdev->dev, NULL);
+
+	pm_runtime_put(&pdev->dev);
+	return ret;
+}
+
 static struct amba_cs_uci_id uci_id_etm4[] = {
 	{
 		/*  ETMv4 UCI data */
@@ -1767,6 +1784,17 @@ static int __exit etm4_remove_amba(struct amba_device *adev)
 	return 0;
 }
 
+static int __exit etm4_remove_platform_dev(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
+
+	if (drvdata)
+		ret = etm4_remove_dev(drvdata);
+	pm_runtime_disable(&pdev->dev);
+	return ret;
+}
+
 static const struct amba_id etm4_ids[] = {
 	CS_AMBA_ID(0x000bb95d),			/* Cortex-A53 */
 	CS_AMBA_ID(0x000bb95e),			/* Cortex-A57 */
@@ -1799,6 +1827,21 @@ static struct amba_driver etm4x_amba_driver = {
 	.id_table	= etm4_ids,
 };
 
+static const struct of_device_id etm4_sysreg_match[] = {
+	{ .compatible	= "arm,coresight-etm4x-sysreg" },
+	{}
+};
+
+static struct platform_driver etm4_platform_driver = {
+	.probe		= etm4_probe_platform_dev,
+	.remove		= etm4_remove_platform_dev,
+	.driver			= {
+		.name			= "coresight-etm4x",
+		.of_match_table		= etm4_sysreg_match,
+		.suppress_bind_attrs	= true,
+	},
+};
+
 static int __init etm4x_init(void)
 {
 	int ret;
@@ -1811,16 +1854,26 @@ static int __init etm4x_init(void)
 
 	ret = amba_driver_register(&etm4x_amba_driver);
 	if (ret) {
-		pr_err("Error registering etm4x driver\n");
-		etm4_pm_clear();
+		pr_err("Error registering etm4x AMBA driver\n");
+		goto clear_pm;
 	}
 
+	ret = platform_driver_register(&etm4_platform_driver);
+	if (!ret)
+		return 0;
+
+	pr_err("Error registering etm4x platform driver\n");
+	amba_driver_unregister(&etm4x_amba_driver);
+
+clear_pm:
+	etm4_pm_clear();
 	return ret;
 }
 
 static void __exit etm4x_exit(void)
 {
 	amba_driver_unregister(&etm4x_amba_driver);
+	platform_driver_unregister(&etm4_platform_driver);
 	etm4_pm_clear();
 }
 
-- 
2.24.1

