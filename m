Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7911A27B1FC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgI1Qfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgI1Qf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:26 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1BFC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:26 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l126so1522216pfd.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bZtzAoPbhcMJY41y/E57CaSilqkeyDxkF3e/HxapUoY=;
        b=CJtW7N5wojqdEzR6yH1IKjkVusNP++v4rfjscbesN5Q8gwOYxWyERVeJGeT9LLx7Lu
         Sy5G/mSkEzAZZPvE2w5fEaAOKOCd64by6tRpDX3nR2FI9pL8yF2Ot/LOWrUir45WayM9
         jMoHEl19QZpFEmcrMsz+qOQGHGK8glJBKP8q2Z919C/s0c+eAnqZRCNJTYihH3pnQNQT
         mg0pkqS3R0sqH2FktJJV2knvB7Ky/5glIem4BEgob0N/xjFd27/XQxZyExdCi1rlV3x5
         qL4AcxylZsrFFcDxexmwFavlU6WiIDNk3UKpqw1Lxf6Q5oXBItpmeJD+6g1WdkpUOEiU
         6aVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bZtzAoPbhcMJY41y/E57CaSilqkeyDxkF3e/HxapUoY=;
        b=Ir9tMhL4ct620tpbB29VgsQaS30jcNbQZhyqhp/Ysk60JhVlNhxHPfyPGGxCUlUsZO
         zO8xSZuLaSG001QDMNHISCkQeOXYrKigrabBxAg1RnHjGwRiqvoOruk8DJ336ZfgIiqp
         vQ+i2GwUMTO3K1jE8OnIDApDvrJLytIWyfDivv29VqflwFO/WdO3fcX5JO2J2+PCqKAr
         /FEh/PGy1Vm9HWLfUL1Or5FpYosiq2qAKo7r8o28nybEEvSwL3+6Tk0xwo8bEsVVM8Kx
         oHT8Y7qzcyr0bjXU1bMeBMLimaTpL0mJlrV9ld5Kxu67JBnLFhE9bk5sc7xovJY3gI8l
         uERQ==
X-Gm-Message-State: AOAM533w0+HnpMjy5X3NMPeSnil87P1D5sBc5t5PaUZrY+6i5Rwl8kFZ
        a6sVK8yLOpevanJP1Lhg8THNeA==
X-Google-Smtp-Source: ABdhPJxHZNeEmhFCGRYjsZU6E0X39hzL6gpcD0779Xe5/IV4IZmWiOLxegHmlk1aqbpoWyceCh3Rew==
X-Received: by 2002:a17:902:ec02:b029:d1:fc2b:fe95 with SMTP id l2-20020a170902ec02b02900d1fc2bfe95mr318906pld.79.1601310925613;
        Mon, 28 Sep 2020 09:35:25 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:25 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/25] coresight: etm4x: Allow etm4x to be built as a module
Date:   Mon, 28 Sep 2020 10:34:58 -0600
Message-Id: <20200928163513.70169-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@arm.com>

Allow to build coresight-etm4x as a module, for ease of development.

- Kconfig becomes a tristate, to allow =m
- append -core to source file name to allow module to
  be called coresight-etm4x by the Makefile
- add an etm4_remove function, for module unload
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
Tested-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig           |  5 +-
 drivers/hwtracing/coresight/Makefile          |  4 +-
 ...resight-etm4x.c => coresight-etm4x-core.c} | 84 ++++++++++++++-----
 3 files changed, 69 insertions(+), 24 deletions(-)
 rename drivers/hwtracing/coresight/{coresight-etm4x.c => coresight-etm4x-core.c} (96%)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 8fd9fd139cf3..d6e107bbd30b 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -78,7 +78,7 @@ config CORESIGHT_SOURCE_ETM3X
 	  module will be called coresight-etm3x.
 
 config CORESIGHT_SOURCE_ETM4X
-	bool "CoreSight Embedded Trace Macrocell 4.x driver"
+	tristate "CoreSight Embedded Trace Macrocell 4.x driver"
 	depends on ARM64
 	select CORESIGHT_LINKS_AND_SINKS
 	select PID_IN_CONTEXTIDR
@@ -88,6 +88,9 @@ config CORESIGHT_SOURCE_ETM4X
 	  for instruction level tracing. Depending on the implemented version
 	  data tracing may also be available.
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called coresight-etm4x.
+
 config CORESIGHT_STM
 	tristate "CoreSight System Trace Macrocell driver"
 	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 86b4648844b4..3f2b057443fb 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -14,8 +14,8 @@ obj-$(CONFIG_CORESIGHT_LINKS_AND_SINKS) += coresight-funnel.o \
 obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o
 coresight-etm3x-y := coresight-etm3x-core.o coresight-etm-cp14.o \
 		     coresight-etm3x-sysfs.o
-obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o \
-					coresight-etm4x-sysfs.o
+obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o
+coresight-etm4x-y := coresight-etm4x-core.o coresight-etm4x-sysfs.o
 obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
 obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
 obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
similarity index 96%
rename from drivers/hwtracing/coresight/coresight-etm4x.c
rename to drivers/hwtracing/coresight/coresight-etm4x-core.c
index f5ab13aaecea..de76d57850bc 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1447,7 +1447,7 @@ static int __init etm4_pm_setup(void)
 	return ret;
 }
 
-static void __init etm4_pm_clear(void)
+static void etm4_pm_clear(void)
 {
 	cpu_pm_unregister_notifier(&etm4_cpu_pm_nb);
 	cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING);
@@ -1504,25 +1504,20 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!desc.name)
 		return -ENOMEM;
 
-	etmdrvdata[drvdata->cpu] = drvdata;
-
 	if (smp_call_function_single(drvdata->cpu,
 				etm4_init_arch_data,  drvdata, 1))
 		dev_err(dev, "ETM arch init failed\n");
 
-	if (etm4_arch_supported(drvdata->arch) == false) {
-		ret = -EINVAL;
-		goto err_arch_supported;
-	}
+	if (etm4_arch_supported(drvdata->arch) == false)
+		return -EINVAL;
 
 	etm4_init_trace_id(drvdata);
 	etm4_set_default(&drvdata->config);
 
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
@@ -1532,17 +1527,17 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.dev = dev;
 	desc.groups = coresight_etmv4_groups;
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
 	dev_info(&drvdata->csdev->dev, "CPU%d: ETM v%d.%d initialized\n",
 		 drvdata->cpu, drvdata->arch >> 4, drvdata->arch & 0xf);
@@ -1553,10 +1548,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	return 0;
-
-err_arch_supported:
-	etmdrvdata[drvdata->cpu] = NULL;
-	return ret;
 }
 
 static struct amba_cs_uci_id uci_id_etm4[] = {
@@ -1568,6 +1559,40 @@ static struct amba_cs_uci_id uci_id_etm4[] = {
 	}
 };
 
+static void __exit clear_etmdrvdata(void *info)
+{
+	int cpu = *(int *)info;
+
+	etmdrvdata[cpu] = NULL;
+}
+
+static int __exit etm4_remove(struct amba_device *adev)
+{
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	etm_perf_symlink(drvdata->csdev, false);
+
+	/*
+	 * Taking hotplug lock here to avoid racing between etm4_remove and
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
+}
+
 static const struct amba_id etm4_ids[] = {
 	CS_AMBA_ID(0x000bb95d),			/* Cortex-A53 */
 	CS_AMBA_ID(0x000bb95e),			/* Cortex-A57 */
@@ -1587,12 +1612,16 @@ static const struct amba_id etm4_ids[] = {
 	{},
 };
 
+MODULE_DEVICE_TABLE(amba, etm4_ids);
+
 static struct amba_driver etm4x_driver = {
 	.drv = {
 		.name   = "coresight-etm4x",
+		.owner  = THIS_MODULE,
 		.suppress_bind_attrs = true,
 	},
 	.probe		= etm4_probe,
+	.remove         = etm4_remove,
 	.id_table	= etm4_ids,
 };
 
@@ -1614,4 +1643,17 @@ static int __init etm4x_init(void)
 
 	return ret;
 }
-device_initcall(etm4x_init);
+
+static void __exit etm4x_exit(void)
+{
+	amba_driver_unregister(&etm4x_driver);
+	etm4_pm_clear();
+}
+
+module_init(etm4x_init);
+module_exit(etm4x_exit);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight Program Flow Trace v4.x driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

