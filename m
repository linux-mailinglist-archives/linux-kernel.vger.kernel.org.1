Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9F824CB86
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 05:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgHUDqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 23:46:03 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:50495 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727116AbgHUDqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 23:46:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597981561; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=eerdHILkw5cBqv1jX7gbIol9qUJRwlLYNGbKnm8Hhuw=; b=uxQgK1YopMm/V6kHdewcGT8DekfM9IDzk7f1bqN4u7pkowy+V/jq8AiHt00EyI/judkCVPyK
 QQ8J2fZeat6CaA+P0yq6hgs7U7pjGSg9xgBJe+LunRjZWP4r1e9iAczfKg0X1P77Q0hb5EMt
 m28bEMq8rLOMehAMf7wxaOQb0Fw=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f3f4376ce76f1f96143e6d3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 21 Aug 2020 03:45:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 59D3DC433AD; Fri, 21 Aug 2020 03:45:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A192C433CA;
        Fri, 21 Aug 2020 03:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A192C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
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
Subject: [PATCH v10 09/24] coresight: etm3x: allow etm3x to be built as a module
Date:   Fri, 21 Aug 2020 11:44:30 +0800
Message-Id: <20200821034445.967-10-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200821034445.967-1-tingwei@codeaurora.org>
References: <20200821034445.967-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@arm.com>

Allow to build coresight-etm3x as a module, for ease of development.

- Kconfig becomes a tristate, to allow =m
- append -core to source file name to allow module to
  be called coresight-etm3x by the Makefile
- add an etm_remove function, for module unload
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
Reviewed-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig           |  5 +++-
 drivers/hwtracing/coresight/Makefile          |  3 +-
 ...resight-etm3x.c => coresight-etm3x-core.c} | 28 ++++++++++++++++++-
 3 files changed, 33 insertions(+), 3 deletions(-)
 rename drivers/hwtracing/coresight/{coresight-etm3x.c => coresight-etm3x-core.c} (97%)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 6433f835fc97..8fd9fd139cf3 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -65,7 +65,7 @@ config CORESIGHT_SINK_ETBV10
 	  special enhancement or added features.
 
 config CORESIGHT_SOURCE_ETM3X
-	bool "CoreSight Embedded Trace Macrocell 3.x driver"
+	tristate "CoreSight Embedded Trace Macrocell 3.x driver"
 	depends on !ARM64
 	select CORESIGHT_LINKS_AND_SINKS
 	help
@@ -74,6 +74,9 @@ config CORESIGHT_SOURCE_ETM3X
 	  This is primarily useful for instruction level tracing.  Depending
 	  the ETM version data tracing may also be available.
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called coresight-etm3x.
+
 config CORESIGHT_SOURCE_ETM4X
 	bool "CoreSight Embedded Trace Macrocell 4.x driver"
 	depends on ARM64
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 19497d1d92bf..d619cfd0abd8 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -11,7 +11,8 @@ obj-$(CONFIG_CORESIGHT_SINK_TPIU) += coresight-tpiu.o
 obj-$(CONFIG_CORESIGHT_SINK_ETBV10) += coresight-etb10.o
 obj-$(CONFIG_CORESIGHT_LINKS_AND_SINKS) += coresight-funnel.o \
 					   coresight-replicator.o
-obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o coresight-etm-cp14.o \
+obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o
+coresight-etm3x-y := coresight-etm3x-core.o coresight-etm-cp14.o \
 					coresight-etm3x-sysfs.o
 obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o \
 					coresight-etm4x-sysfs.o
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
similarity index 97%
rename from drivers/hwtracing/coresight/coresight-etm3x.c
rename to drivers/hwtracing/coresight/coresight-etm3x-core.c
index bf22dcfd3327..ba9c86497acb 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -895,6 +895,23 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
+static int __exit etm_remove(struct amba_device *adev)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	etm_perf_symlink(drvdata->csdev, false);
+
+	if (--etm_count == 0) {
+		cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING);
+		if (hp_online)
+			cpuhp_remove_state_nocalls(hp_online);
+	}
+
+	coresight_unregister(drvdata->csdev);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int etm_runtime_suspend(struct device *dev)
 {
@@ -937,6 +954,8 @@ static const struct amba_id etm_ids[] = {
 	{ 0, 0},
 };
 
+MODULE_DEVICE_TABLE(amba, etm_ids);
+
 static struct amba_driver etm_driver = {
 	.drv = {
 		.name	= "coresight-etm3x",
@@ -945,6 +964,13 @@ static struct amba_driver etm_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe		= etm_probe,
+	.remove         = etm_remove,
 	.id_table	= etm_ids,
 };
-builtin_amba_driver(etm_driver);
+
+module_amba_driver(etm_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight Program Flow Trace driver");
+MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

