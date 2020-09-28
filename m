Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C181327B1FA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgI1Qfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgI1Qf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:27 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE7CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:25 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x22so1494646pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4QN691BXao3PnqcNAUhINxRttOXk+OwnyXq6jctViII=;
        b=srvl1dUuIyNeF9lSxf7h8DgWXz3vjSS9TIQPSbmIWzW2KZes294tXMwgvCtmgPXZM2
         IOtKwDNM2AeX2Vj1ZSS7Yzy9NR+7adH7K2rLuGLh2+gEOjfWk3pNOzoNJkwMadPWAXR4
         HoNmTk5pg6oCICD/yTlsc0Q3TM5tyAv9g+PMlCqt4e9JyPcDAAnjn3E26wItt0zVevpY
         L2e0evrOi3mixMYF5jLDzSkzxraLUUYOO9DyMhFACqbFsOVfDr6nZfO7PRQuUtRC52Ip
         bVGVnXkTbvM1x03K7M75h9+S8kmsm+G3GVFLASQHwz3aftbBCvaCOQfTBM7jRFEGmtAK
         OELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4QN691BXao3PnqcNAUhINxRttOXk+OwnyXq6jctViII=;
        b=IPafUYl8avFKeO7WKstcNU1znY3vD8PwDBbDDTpkUSDaHj74nJiNnSYR5HTufGQVW4
         SGpq82LhTHgh1ZEQHC7dbQ3e/QwvEVLfEH8dwB65UjCVl2wNlY8EuZkgkcSu4V0FLUZo
         RxNS2dZb2v1k1fhOKCQJTJRpCwVBHBVphOQSBOK3Pe1E+nP+OERHLtP39SpEFipbPeEU
         QEjN8INVZpo01nCuu2qCOy0N4z4YF8tgIAcm9ADNX6Malrni6DxXPt6wnxy+Ie8Hhte0
         SqMp/bldgIKlZFQPU3C0IkXBwpNkmgJcW+RgHI0hF/vpMNxio2ITGczppR/6cshdQ5gn
         l40A==
X-Gm-Message-State: AOAM532CRwN7OSgryeHsEn++aERQcBfFLe5liIp2eqLiGZ6FjjWaddpM
        x92CfmJgK0Ombp1dIFBmuPdp+QfhFvgDcg==
X-Google-Smtp-Source: ABdhPJyy2hBUA0XfPWRwLYXR6S3zVE5i2+XVuZPlltHyS51ngnfJF8pX+uJWzKLrFhQ8NyvGspSoxQ==
X-Received: by 2002:a17:902:a982:b029:d2:8cba:921b with SMTP id bh2-20020a170902a982b02900d28cba921bmr264678plb.50.1601310924619;
        Mon, 28 Sep 2020 09:35:24 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:24 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/25] coresight: etm3x: Allow etm3x to be built as a module
Date:   Mon, 28 Sep 2020 10:34:57 -0600
Message-Id: <20200928163513.70169-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig           |   5 +-
 drivers/hwtracing/coresight/Makefile          |   5 +-
 ...resight-etm3x.c => coresight-etm3x-core.c} | 154 +++++++++++++-----
 3 files changed, 122 insertions(+), 42 deletions(-)
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
index bf22dcfd3327..47f610b1c2b1 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -40,8 +40,6 @@
 static int boot_enable;
 module_param_named(boot_enable, boot_enable, int, S_IRUGO);
 
-/* The number of ETM/PTM currently registered */
-static int etm_count;
 static struct etm_drvdata *etmdrvdata[NR_CPUS];
 
 static enum cpuhp_state hp_online;
@@ -782,6 +780,42 @@ static void etm_init_trace_id(struct etm_drvdata *drvdata)
 	drvdata->traceid = coresight_get_trace_id(drvdata->cpu);
 }
 
+static int __init etm_hp_setup(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ARM_CORESIGHT_STARTING,
+						   "arm/coresight:starting",
+						   etm_starting_cpu, etm_dying_cpu);
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
@@ -823,39 +857,20 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!desc.name)
 		return -ENOMEM;
 
-	cpus_read_lock();
-	etmdrvdata[drvdata->cpu] = drvdata;
-
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
-	cpus_read_unlock();
-
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
@@ -865,17 +880,17 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
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
@@ -885,14 +900,40 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
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
@@ -937,6 +978,8 @@ static const struct amba_id etm_ids[] = {
 	{ 0, 0},
 };
 
+MODULE_DEVICE_TABLE(amba, etm_ids);
+
 static struct amba_driver etm_driver = {
 	.drv = {
 		.name	= "coresight-etm3x",
@@ -945,6 +988,39 @@ static struct amba_driver etm_driver = {
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
+	/* etm_hp_setup() does its own cleanup - exit on error */
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
2.25.1

