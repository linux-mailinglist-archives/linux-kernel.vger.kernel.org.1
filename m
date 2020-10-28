Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C375B29D609
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbgJ1WLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:11:04 -0400
Received: from foss.arm.com ([217.140.110.172]:39218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730533AbgJ1WK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:10:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7AED1ACC;
        Wed, 28 Oct 2020 15:10:28 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C12723F918;
        Wed, 28 Oct 2020 15:10:27 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 25/26] coresight: etm4x: Add support for sysreg only devices
Date:   Wed, 28 Oct 2020 22:09:44 +0000
Message-Id: <20201028220945.3826358-27-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201028220945.3826358-1-suzuki.poulose@arm.com>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for devices with system instruction access only.
They don't have a memory mapped interface and thus are not
AMBA devices.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 50 +++++++++++++++++--
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 25fab5513604..50a574228866 100644
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
@@ -1623,9 +1624,6 @@ static int etm4_probe(struct device *dev, void __iomem *base)
 			return -ENOMEM;
 	}
 
-	if (fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
-		drvdata->skip_power_up = true;
-
 	drvdata->base = base;
 
 	spin_lock_init(&drvdata->spinlock);
@@ -1648,6 +1646,11 @@ static int etm4_probe(struct device *dev, void __iomem *base)
 	if (!drvdata->arch)
 		return -EINVAL;
 
+	/* Skip programming TRCPDCR for system instructions. */
+	if (!desc.access.io_mem ||
+	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
+		drvdata->skip_power_up = true;
+
 	etm4_init_trace_id(drvdata);
 	etm4_set_default(&drvdata->config);
 
@@ -1706,6 +1709,20 @@ static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
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
@@ -1781,6 +1798,20 @@ static struct amba_driver etm4x_amba_driver = {
 	.id_table	= etm4_ids,
 };
 
+static const struct of_device_id etm_sysreg_match[] = {
+	{ .compatible	= "arm,coresight-etm-sysreg" },
+	{}
+};
+
+static struct platform_driver etm4_platform_driver = {
+	.probe		= etm4_probe_platform_dev,
+	.driver			= {
+		.name			= "coresight-etm4x",
+		.of_match_table		= etm_sysreg_match,
+		.suppress_bind_attrs	= true,
+	},
+};
+
 static int __init etm4x_init(void)
 {
 	int ret;
@@ -1793,10 +1824,19 @@ static int __init etm4x_init(void)
 
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
 
-- 
2.24.1

