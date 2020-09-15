Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D219326A390
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 12:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgIOKsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 06:48:05 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38273 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgIOKnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:43:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600166632; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=0/jzt5Rc6RFntYIcqDWlXIKrqo7Dznpof6HJuCYJOOw=; b=tSjxb/yUYJ/zCP0fZ39NISGydAUozH4XokH4zcAXZMPGH0o5CHQGTo8L0yFouGrgltW4/nVp
 CgHDVF3Uxb3cBmjkJFHccWK2C+c/gVGUWcAUpIWETTY0Vby8GdHs6H3NxTWUbCd6hHEe8WG8
 5uFnHOiTJOT59mrTWx9LAiMUrzQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f609ab9d3d3df8c39c24514 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 10:43:05
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 36AEFC43385; Tue, 15 Sep 2020 10:43:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 54EACC433F0;
        Tue, 15 Sep 2020 10:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54EACC433F0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Kim Phillips <kim.phillips@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v11 14/24] coresight: allow funnel driver to be built as module
Date:   Tue, 15 Sep 2020 18:41:06 +0800
Message-Id: <20200915104116.16789-15-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200915104116.16789-1-tingwei@codeaurora.org>
References: <20200915104116.16789-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
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
Reported-by: kernel test robot <lkp@intel.com>
Tested-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

