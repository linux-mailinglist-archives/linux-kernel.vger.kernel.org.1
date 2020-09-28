Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAA127B20B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgI1QgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgI1Qfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:31 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F05EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:31 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q123so1542551pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XIx91CccDaMdjV0kYj3bzRvAnnTG3Y6NVqg6FhgtymQ=;
        b=rrpGDK1PuYY26QV/Qus8zZSUEzEBSvGPLngFW0TycgAyGD79W5dMo5/vXMLrEbUD41
         I2ZBHj7Gjlf68vM/vDyCkHh//H+n3mYuJYzcIaHhbPHWUsYCAT+2F5V4+aNP2jk9rMQs
         w2KUFCOlcOgqH6EodqIa3EReq8joBWWZSLWgLJz7wmUsXrclUgwws68zy/Taw4mPnrzt
         GulDmVJcEcKiIWdzYmrfu6UqTlEC0AFWPDziF/D9psjPyxrDBZGHvIQE5Y1xInQUFSXV
         z9wslKx3T7Xm+TnC1avXJGh2b+veo8PJdxKa8N2aljQbglb3FiRvGB/hoCGWlfIj+dwq
         IUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XIx91CccDaMdjV0kYj3bzRvAnnTG3Y6NVqg6FhgtymQ=;
        b=mID/M5rzCkd3MDvngEFRM3dQUEXQOAfPp+hiWhpGzp02MewbUX4lx++q18rBux+U8x
         auTLQ9M0xuKi0IogZZtGT0btc0tgqCCNBT9yYqpfkdzaI4X4MMuCmqWiffLHySUDhXZa
         4Rsdrwth0QDMWEizxmzz8rrGvsSEjYYxbrpvUz/Islg85sknAt85Rv/RU3uoXnIJoQlf
         HTyyraF3kUqTzGlDrvoDo4Q2jj5fbhHH0Cpkpm+D84FBhEYTkrO51x6FbQJ+tCZjjjmA
         kdxFSLaaN+p42K74Lhx5XLypmgdHqoxUjW7rV2WLnZv/MHvPk4wSN9mLOsB4LIUR1lIO
         tNRg==
X-Gm-Message-State: AOAM5310ha3sNrP6GGq5qBqdJbwvn5G854PswcKCxrOU/XBAwCwrF0sS
        9XoPXrcrE8aSubmI1tAr2Yaq2k6AzdMkGA==
X-Google-Smtp-Source: ABdhPJxjBK1zCvQQ8uD6VTpZqiRhqtDxs2lAKFsh4876s8nAKwAUjuZQHqZOEg200ziiFRoqSmPqwQ==
X-Received: by 2002:a17:902:a407:b029:d2:2113:7f8f with SMTP id p7-20020a170902a407b02900d221137f8fmr360285plq.70.1601310930991;
        Mon, 28 Sep 2020 09:35:30 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:30 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/25] coresight: replicator: Allow replicator driver to be built as module
Date:   Mon, 28 Sep 2020 10:35:03 -0600
Message-Id: <20200928163513.70169-16-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@arm.com>

Allow to build coresight-replicator as modules, for ease of development.

- Kconfig becomes a tristate, to allow =m
- combine static and dynamic replicator init into single
  module_init/exit call
- add replicator_remove functions, for module unload
- add a MODULE_DEVICE_TABLE for autoloading on boot

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Co-developed-by: Mian Yousaf Kaukab <ykaukab@suse.de>
Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Tested-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig           |  5 +-
 .../coresight/coresight-replicator.c          | 65 ++++++++++++++++++-
 2 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index fc48ae086746..f31778dd0b5d 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -17,13 +17,16 @@ menuconfig CORESIGHT
 
 if CORESIGHT
 config CORESIGHT_LINKS_AND_SINKS
-	bool "CoreSight Link and Sink drivers"
+	tristate "CoreSight Link and Sink drivers"
 	help
 	  This enables support for CoreSight link and sink drivers that are
 	  responsible for transporting and collecting the trace data
 	  respectively.  Link and sinks are dynamically aggregated with a trace
 	  entity at run time to form a complete trace path.
 
+	  To compile these drivers as modules, choose M here: the
+	  modules will be called coresight-funnel and coresight-replicator.
+
 config CORESIGHT_LINK_AND_SINK_TMC
 	tristate "Coresight generic TMC driver"
 
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 78acf29c49ca..62afdde0e5ea 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -291,6 +291,14 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	return ret;
 }
 
+static int __exit replicator_remove(struct device *dev)
+{
+	struct replicator_drvdata *drvdata = dev_get_drvdata(dev);
+
+	coresight_unregister(drvdata->csdev);
+	return 0;
+}
+
 static int static_replicator_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -310,6 +318,13 @@ static int static_replicator_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int __exit static_replicator_remove(struct platform_device *pdev)
+{
+	replicator_remove(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int replicator_runtime_suspend(struct device *dev)
 {
@@ -343,24 +358,29 @@ static const struct of_device_id static_replicator_match[] = {
 	{}
 };
 
+MODULE_DEVICE_TABLE(of, static_replicator_match);
+
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id static_replicator_acpi_ids[] = {
 	{"ARMHC985", 0}, /* ARM CoreSight Static Replicator */
 	{}
 };
+
+MODULE_DEVICE_TABLE(acpi, static_replicator_acpi_ids);
 #endif
 
 static struct platform_driver static_replicator_driver = {
 	.probe          = static_replicator_probe,
+	.remove         = static_replicator_remove,
 	.driver         = {
 		.name   = "coresight-static-replicator",
+		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(static_replicator_match),
 		.acpi_match_table = ACPI_PTR(static_replicator_acpi_ids),
 		.pm	= &replicator_dev_pm_ops,
 		.suppress_bind_attrs = true,
 	},
 };
-builtin_platform_driver(static_replicator_driver);
 
 static int dynamic_replicator_probe(struct amba_device *adev,
 				    const struct amba_id *id)
@@ -368,19 +388,60 @@ static int dynamic_replicator_probe(struct amba_device *adev,
 	return replicator_probe(&adev->dev, &adev->res);
 }
 
+static int __exit dynamic_replicator_remove(struct amba_device *adev)
+{
+	return replicator_remove(&adev->dev);
+}
+
 static const struct amba_id dynamic_replicator_ids[] = {
 	CS_AMBA_ID(0x000bb909),
 	CS_AMBA_ID(0x000bb9ec),		/* Coresight SoC-600 */
 	{},
 };
 
+MODULE_DEVICE_TABLE(amba, dynamic_replicator_ids);
+
 static struct amba_driver dynamic_replicator_driver = {
 	.drv = {
 		.name	= "coresight-dynamic-replicator",
 		.pm	= &replicator_dev_pm_ops,
+		.owner	= THIS_MODULE,
 		.suppress_bind_attrs = true,
 	},
 	.probe		= dynamic_replicator_probe,
+	.remove         = dynamic_replicator_remove,
 	.id_table	= dynamic_replicator_ids,
 };
-builtin_amba_driver(dynamic_replicator_driver);
+
+static int __init replicator_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&static_replicator_driver);
+	if (ret) {
+		pr_info("Error registering platform driver\n");
+		return ret;
+	}
+
+	ret = amba_driver_register(&dynamic_replicator_driver);
+	if (ret) {
+		pr_info("Error registering amba driver\n");
+		platform_driver_unregister(&static_replicator_driver);
+	}
+
+	return ret;
+}
+
+static void __exit replicator_exit(void)
+{
+	platform_driver_unregister(&static_replicator_driver);
+	amba_driver_unregister(&dynamic_replicator_driver);
+}
+
+module_init(replicator_init);
+module_exit(replicator_exit);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight Replicator Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

