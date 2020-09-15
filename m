Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1275726A365
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 12:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgIOKo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 06:44:29 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38273 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbgIOKnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:43:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600166575; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=GuvuqZfFSYblJfYSjFefR5FAK9JFKO1Nm4He3cwsuBQ=; b=h/2VNcElHeHtBIUK+uff9HJfDpWYzu5ryQT27mQubaV136T5zDDPBkM3EK1yeXkZ6ZVsiAcv
 apz6enh9gToCcQaA+cFQQGuf5FtpacwC6sBmIFfD8pBl0xDwgpfL9g5iEYLUuz05VpLG7DNj
 Jcvv3UVsRbFoBxOA8T5ltRy4c10=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f609aa29f3347551f6ec432 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 10:42:42
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7A167C433F0; Tue, 15 Sep 2020 10:42:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ABACAC4339C;
        Tue, 15 Sep 2020 10:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ABACAC4339C
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
Subject: [PATCH v11 09/24] coresight: etm3x: allow etm3x to be built as a module
Date:   Tue, 15 Sep 2020 18:41:01 +0800
Message-Id: <20200915104116.16789-10-tingwei@codeaurora.org>
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

Allow to build coresight-etm3x as a module, for ease of development.

- Kconfig becomes a tristate, to allow =m
- append -core to source file name to allow module to
  be called coresight-etm3x by the Makefile
- add an etm_remove function, for module unload
- add a MODULE_DEVICE_TABLE for autoloading on boot
- delay advertising the per-cpu etmdrvdata
- protect etmdrvdata[] by modifying it on relevant CPU

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
 drivers/hwtracing/coresight/Kconfig           |   5 +-
 drivers/hwtracing/coresight/Makefile          |   5 +-
 ...resight-etm3x.c => coresight-etm3x-core.c} | 148 ++++++++++++++----
 3 files changed, 122 insertions(+), 36 deletions(-)
 rename drivers/hwtracing/coresight/{coresight-etm3x.c => coresight-etm3x-core.c} (90%)

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
index 19497d1d92bf..86b4648844b4 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -11,8 +11,9 @@ obj-$(CONFIG_CORESIGHT_SINK_TPIU) += coresight-tpiu.o
 obj-$(CONFIG_CORESIGHT_SINK_ETBV10) += coresight-etb10.o
 obj-$(CONFIG_CORESIGHT_LINKS_AND_SINKS) += coresight-funnel.o \
 					   coresight-replicator.o
-obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o coresight-etm-cp14.o \
-					coresight-etm3x-sysfs.o
+obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o
+coresight-etm3x-y := coresight-etm3x-core.o coresight-etm-cp14.o \
+		     coresight-etm3x-sysfs.o
 obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o \
 					coresight-etm4x-sysfs.o
 obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
similarity index 90%
rename from drivers/hwtracing/coresight/coresight-etm3x.c
rename to drivers/hwtracing/coresight/coresight-etm3x-core.c
index bf22dcfd3327..56eba0b5c71f 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -782,6 +782,42 @@ static void etm_init_trace_id(struct etm_drvdata *drvdata)
 	drvdata->traceid = coresight_get_trace_id(drvdata->cpu);
 }
 
+static int __init etm_hp_setup(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ARM_CORESIGHT_STARTING,
+					     "arm/coresight:starting",
+					     etm_starting_cpu, etm_dying_cpu);
+
+	if (ret)
+		return ret;
+
+	ret = cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ONLINE_DYN,
+						   "arm/coresight:online",
+						   etm_online_cpu, NULL);
+
+	/* HP dyn state ID returned in ret on success */
+	if (ret > 0) {
+		hp_online = ret;
+		return 0;
+	}
+
+	/* failed dyn state - remove others */
+	cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING);
+
+	return ret;
+}
+
+static void etm_hp_clear(void)
+{
+	cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING);
+	if (hp_online) {
+		cpuhp_remove_state_nocalls(hp_online);
+		hp_online = 0;
+	}
+}
+
 static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	int ret;
@@ -824,38 +860,23 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 		return -ENOMEM;
 
 	cpus_read_lock();
-	etmdrvdata[drvdata->cpu] = drvdata;
 
 	if (smp_call_function_single(drvdata->cpu,
 				     etm_init_arch_data,  drvdata, 1))
 		dev_err(dev, "ETM arch init failed\n");
 
-	if (!etm_count++) {
-		cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ARM_CORESIGHT_STARTING,
-						     "arm/coresight:starting",
-						     etm_starting_cpu, etm_dying_cpu);
-		ret = cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ONLINE_DYN,
-							   "arm/coresight:online",
-							   etm_online_cpu, NULL);
-		if (ret < 0)
-			goto err_arch_supported;
-		hp_online = ret;
-	}
 	cpus_read_unlock();
 
-	if (etm_arch_supported(drvdata->arch) == false) {
-		ret = -EINVAL;
-		goto err_arch_supported;
-	}
+	if (etm_arch_supported(drvdata->arch) == false)
+		return -EINVAL;
 
 	etm_init_trace_id(drvdata);
 	etm_set_default(&drvdata->config);
 
 	pdata = coresight_get_platform_data(dev);
-	if (IS_ERR(pdata)) {
-		ret = PTR_ERR(pdata);
-		goto err_arch_supported;
-	}
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+
 	adev->dev.platform_data = pdata;
 
 	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
@@ -865,17 +886,17 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.dev = dev;
 	desc.groups = coresight_etm_groups;
 	drvdata->csdev = coresight_register(&desc);
-	if (IS_ERR(drvdata->csdev)) {
-		ret = PTR_ERR(drvdata->csdev);
-		goto err_arch_supported;
-	}
+	if (IS_ERR(drvdata->csdev))
+		return PTR_ERR(drvdata->csdev);
 
 	ret = etm_perf_symlink(drvdata->csdev, true);
 	if (ret) {
 		coresight_unregister(drvdata->csdev);
-		goto err_arch_supported;
+		return ret;
 	}
 
+	etmdrvdata[drvdata->cpu] = drvdata;
+
 	pm_runtime_put(&adev->dev);
 	dev_info(&drvdata->csdev->dev,
 		 "%s initialized\n", (char *)coresight_get_uci_data(id));
@@ -885,14 +906,40 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	return 0;
+}
 
-err_arch_supported:
-	if (--etm_count == 0) {
-		cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING);
-		if (hp_online)
-			cpuhp_remove_state_nocalls(hp_online);
-	}
-	return ret;
+static void __exit clear_etmdrvdata(void *info)
+{
+	int cpu = *(int *)info;
+
+	etmdrvdata[cpu] = NULL;
+}
+
+static int __exit etm_remove(struct amba_device *adev)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	etm_perf_symlink(drvdata->csdev, false);
+
+	/*
+	 * Taking hotplug lock here to avoid racing between etm_remove and
+	 * CPU hotplug call backs.
+	 */
+	cpus_read_lock();
+	/*
+	 * The readers for etmdrvdata[] are CPU hotplug call backs
+	 * and PM notification call backs. Change etmdrvdata[i] on
+	 * CPU i ensures these call backs has consistent view
+	 * inside one call back function.
+	 */
+	if (smp_call_function_single(drvdata->cpu, clear_etmdrvdata, &drvdata->cpu, 1))
+		etmdrvdata[drvdata->cpu] = NULL;
+
+	cpus_read_unlock();
+
+	coresight_unregister(drvdata->csdev);
+
+	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -937,6 +984,8 @@ static const struct amba_id etm_ids[] = {
 	{ 0, 0},
 };
 
+MODULE_DEVICE_TABLE(amba, etm_ids);
+
 static struct amba_driver etm_driver = {
 	.drv = {
 		.name	= "coresight-etm3x",
@@ -945,6 +994,39 @@ static struct amba_driver etm_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe		= etm_probe,
+	.remove         = etm_remove,
 	.id_table	= etm_ids,
 };
-builtin_amba_driver(etm_driver);
+
+static int __init etm_init(void)
+{
+	int ret;
+
+	ret = etm_hp_setup();
+
+	/* etm_pm_setup() does its own cleanup - exit on error */
+	if (ret)
+		return ret;
+
+	ret = amba_driver_register(&etm_driver);
+	if (ret) {
+		pr_err("Error registering etm3x driver\n");
+		etm_hp_clear();
+	}
+
+	return ret;
+}
+
+static void __exit etm_exit(void)
+{
+	amba_driver_unregister(&etm_driver);
+	etm_hp_clear();
+}
+
+module_init(etm_init);
+module_exit(etm_exit);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight Program Flow Trace driver");
+MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

