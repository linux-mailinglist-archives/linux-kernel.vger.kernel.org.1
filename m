Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE8827B20A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgI1QgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgI1Qfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:31 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87377C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:30 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m34so1315789pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vMwbm6M17eoKIMI3/97ZhWWkuJ53zAySuNIn1r+zO7o=;
        b=MIB+37QMnkKch3OGAmY/TF8pDjDUOzFVG+pW4cC3/gjdCg7p2YD9kzGItbhRKuIm2t
         3TvAZ7sR2kNtnUaPtAdSWgm5mpCgOdpTa8dhRhllIMkSlEMyEKJUmATRUvqzgwMLkl7U
         Co+BZCZhpTPhXitC9gSAr98vhuOr4a/cS2qkzb2jEgijldq3jCpjuCPX3csNA966edRV
         O9sB9MBBv5cRDQ7bgVRE2unoaWDbcwyYoexPHvMTCDrUzcCgaQU1LmnUdfusSnfWoHkG
         SdMp6nfVHe3PSftGHyz2YNEi2rdStKJM8lmc2T0TikeIeeK7SzKDUrAHNTBqDzLAYVfK
         emTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vMwbm6M17eoKIMI3/97ZhWWkuJ53zAySuNIn1r+zO7o=;
        b=ku7gRRe/so2VWy0db3CXt5lqXb+xAr8w3v9zKvJMbK0Hw8+ppQi3+nn+Xu64WAg41L
         ixytUQTiBJlY4jfE55+WDoq7t3blz8yFAfg7gY/DvTc49ZR000DEp0KvfXXsrIbzHxHp
         5ANGZL7U6yM3kzwdmE11E0qFFBFKYAPp10Nh3ptZ1zmMjl1A1T+OsSWT/Os5lHxEKXB/
         4FCapfU/F7ggsYvleJnZcI5titOFqJbplHAc1NlxGLV7Z5J5QyEdvxrKArrk5vWLs3/A
         VwEauryoE5o1jkdrWvO1e1m0q9FMyDusrO8mK8rWLd5zp9sqNLDlhK4YM4eCamas66FD
         CqCw==
X-Gm-Message-State: AOAM530sO31ntYUHECgJ/SnALnsPF/kjgdveBGlSSHXpGwQlN/C3dRuY
        1DU0RtLUu9UijJvEgKP4jtZIhw==
X-Google-Smtp-Source: ABdhPJw9a0z4zuW2GGmK3wRCFrZbpPgX7Wrp96hGFD20ClnIyJq1ieH/D9WVbPRQ+bV8PB64NtOjYg==
X-Received: by 2002:a63:1a66:: with SMTP id a38mr1736255pgm.253.1601310930011;
        Mon, 28 Sep 2020 09:35:30 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:29 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/25] coresight: funnel: Allow funnel driver to be built as module
Date:   Mon, 28 Sep 2020 10:35:02 -0600
Message-Id: <20200928163513.70169-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@arm.com>

Allow to build coresight-funnel as module, for ease of development.

- combine static and dynamic funnel init into single
  module_init/exit call
- add funnel_remove functions, for module unload
- add a MODULE_DEVICE_TABLE for autoloading on boot

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Co-developed-by: Mian Yousaf Kaukab <ykaukab@suse.de>
Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Tested-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../hwtracing/coresight/coresight-funnel.c    | 65 ++++++++++++++++++-
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 900690a9f7f0..af40814ce560 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -274,6 +274,15 @@ static int funnel_probe(struct device *dev, struct resource *res)
 	return ret;
 }
 
+static int __exit funnel_remove(struct device *dev)
+{
+	struct funnel_drvdata *drvdata = dev_get_drvdata(dev);
+
+	coresight_unregister(drvdata->csdev);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int funnel_runtime_suspend(struct device *dev)
 {
@@ -319,29 +328,41 @@ static int static_funnel_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int __exit static_funnel_remove(struct platform_device *pdev)
+{
+	funnel_remove(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
 static const struct of_device_id static_funnel_match[] = {
 	{.compatible = "arm,coresight-static-funnel"},
 	{}
 };
 
+MODULE_DEVICE_TABLE(of, static_funnel_match);
+
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id static_funnel_ids[] = {
 	{"ARMHC9FE", 0},
 	{},
 };
+
+MODULE_DEVICE_TABLE(acpi, static_funnel_ids);
 #endif
 
 static struct platform_driver static_funnel_driver = {
 	.probe          = static_funnel_probe,
+	.remove          = static_funnel_remove,
 	.driver         = {
 		.name   = "coresight-static-funnel",
+		.owner	= THIS_MODULE,
 		.of_match_table = static_funnel_match,
 		.acpi_match_table = ACPI_PTR(static_funnel_ids),
 		.pm	= &funnel_dev_pm_ops,
 		.suppress_bind_attrs = true,
 	},
 };
-builtin_platform_driver(static_funnel_driver);
 
 static int dynamic_funnel_probe(struct amba_device *adev,
 				const struct amba_id *id)
@@ -349,6 +370,11 @@ static int dynamic_funnel_probe(struct amba_device *adev,
 	return funnel_probe(&adev->dev, &adev->res);
 }
 
+static int __exit dynamic_funnel_remove(struct amba_device *adev)
+{
+	return funnel_remove(&adev->dev);
+}
+
 static const struct amba_id dynamic_funnel_ids[] = {
 	{
 		.id     = 0x000bb908,
@@ -362,6 +388,8 @@ static const struct amba_id dynamic_funnel_ids[] = {
 	{ 0, 0},
 };
 
+MODULE_DEVICE_TABLE(amba, dynamic_funnel_ids);
+
 static struct amba_driver dynamic_funnel_driver = {
 	.drv = {
 		.name	= "coresight-dynamic-funnel",
@@ -370,6 +398,39 @@ static struct amba_driver dynamic_funnel_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe		= dynamic_funnel_probe,
+	.remove		= dynamic_funnel_remove,
 	.id_table	= dynamic_funnel_ids,
 };
-builtin_amba_driver(dynamic_funnel_driver);
+
+static int __init funnel_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&static_funnel_driver);
+	if (ret) {
+		pr_info("Error registering platform driver\n");
+		return ret;
+	}
+
+	ret = amba_driver_register(&dynamic_funnel_driver);
+	if (ret) {
+		pr_info("Error registering amba driver\n");
+		platform_driver_unregister(&static_funnel_driver);
+	}
+
+	return ret;
+}
+
+static void __exit funnel_exit(void)
+{
+	platform_driver_unregister(&static_funnel_driver);
+	amba_driver_unregister(&dynamic_funnel_driver);
+}
+
+module_init(funnel_init);
+module_exit(funnel_exit);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight Funnel Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

