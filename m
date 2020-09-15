Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EB926A361
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 12:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgIOKn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 06:43:26 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:63928 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726387AbgIOKnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:43:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600166582; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=D0sXL7RJO3/xB4/CJMjlXFBF5V2viCaV6+3MLqm+Ulw=; b=QT2itfz2PAZM0KAKD8xiJg9/XaqJZ31HjsD3YYMBSI1VUujhXxQ+1mVYx96GYR8UFbw1V9yA
 /h1qwAtA55uIJe9Akse7MCPcvEMlWlHZfJNcckjZMtFM+UGxoAPcz7ZwCnvxTeQuhIgNrQGL
 ILjoMKCyc8HAd03fhC6lIP2Tt7E=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f609ab47f21d51b30624f90 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 10:43:00
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F3F77C433FF; Tue, 15 Sep 2020 10:42:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B3C88C433FF;
        Tue, 15 Sep 2020 10:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3C88C433FF
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
        Tingwei Zhang <tingwei@codeaurora.org>
Subject: [PATCH v11 13/24] coresight: tmc: allow tmc to be built as a module
Date:   Tue, 15 Sep 2020 18:41:05 +0800
Message-Id: <20200915104116.16789-14-tingwei@codeaurora.org>
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

Allow to build coresight-tmc as a module, for ease of development.

- Kconfig becomes a tristate, to allow =m
- append -core to source file name to allow module to
  be called coresight-tmc by the Makefile
- add an tmc_remove function, for module unload
- add a MODULE_DEVICE_TABLE for autoloading on boot

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Tested-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig           |  6 ++++-
 drivers/hwtracing/coresight/Makefile          |  6 ++---
 .../{coresight-tmc.c => coresight-tmc-core.c} | 25 ++++++++++++++++++-
 3 files changed, 32 insertions(+), 5 deletions(-)
 rename drivers/hwtracing/coresight/{coresight-tmc.c => coresight-tmc-core.c} (95%)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 8fd9887fb03b..fc48ae086746 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -25,7 +25,8 @@ config CORESIGHT_LINKS_AND_SINKS
 	  entity at run time to form a complete trace path.
 
 config CORESIGHT_LINK_AND_SINK_TMC
-	bool "Coresight generic TMC driver"
+	tristate "Coresight generic TMC driver"
+
 	depends on CORESIGHT_LINKS_AND_SINKS
 	help
 	  This enables support for the Trace Memory Controller driver.
@@ -34,6 +35,9 @@ config CORESIGHT_LINK_AND_SINK_TMC
 	  complies with the generic implementation of the component without
 	  special enhancement or added features.
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called coresight-tmc.
+
 config CORESIGHT_CATU
 	bool "Coresight Address Translation Unit (CATU) driver"
 	depends on CORESIGHT_LINK_AND_SINK_TMC
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 3f2b057443fb..3dbd49a060dd 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -4,9 +4,9 @@
 #
 obj-$(CONFIG_CORESIGHT) += coresight.o coresight-etm-perf.o \
 			   coresight-platform.o coresight-sysfs.o
-obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o \
-					     coresight-tmc-etf.o \
-					     coresight-tmc-etr.o
+obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
+coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
+		      coresight-tmc-etr.o
 obj-$(CONFIG_CORESIGHT_SINK_TPIU) += coresight-tpiu.o
 obj-$(CONFIG_CORESIGHT_SINK_ETBV10) += coresight-etb10.o
 obj-$(CONFIG_CORESIGHT_LINKS_AND_SINKS) += coresight-funnel.o \
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
similarity index 95%
rename from drivers/hwtracing/coresight/coresight-tmc.c
rename to drivers/hwtracing/coresight/coresight-tmc-core.c
index 9ca3aaafcfbc..5653e0945c74 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -559,6 +559,21 @@ static void tmc_shutdown(struct amba_device *adev)
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 }
 
+static int __exit tmc_remove(struct amba_device *adev)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	/*
+	 * Since misc_open() holds a refcount on the f_ops, which is
+	 * etb fops in this case, device is there until last file
+	 * handler to this device is closed.
+	 */
+	misc_deregister(&drvdata->miscdev);
+	coresight_unregister(drvdata->csdev);
+
+	return 0;
+}
+
 static const struct amba_id tmc_ids[] = {
 	CS_AMBA_ID(0x000bb961),
 	/* Coresight SoC 600 TMC-ETR/ETS */
@@ -570,6 +585,8 @@ static const struct amba_id tmc_ids[] = {
 	{ 0, 0},
 };
 
+MODULE_DEVICE_TABLE(amba, tmc_ids);
+
 static struct amba_driver tmc_driver = {
 	.drv = {
 		.name   = "coresight-tmc",
@@ -578,6 +595,12 @@ static struct amba_driver tmc_driver = {
 	},
 	.probe		= tmc_probe,
 	.shutdown	= tmc_shutdown,
+	.remove		= tmc_remove,
 	.id_table	= tmc_ids,
 };
-builtin_amba_driver(tmc_driver);
+
+module_amba_driver(tmc_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_DESCRIPTION("Arm CoreSight Trace Memory Controller driver");
+MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

