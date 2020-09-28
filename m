Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2578127B20C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgI1QgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgI1Qf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:29 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C07AC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:29 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d13so1326778pgl.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3jVDw2F3FLGmwjOb7HhNx2sSGB+A2r03pvrlXP4qvw=;
        b=tKlH6Q2nCg7QhIkLFB8DujfYuejxynSpxjKqkvxOVgMyNH8ghIV6R0uITk5iR2YW2T
         X95Iu2I0Wnzg5WoRN21HX6BLmrHAhLbH35LIkSLgJX9zxxlVjVO1BliH15xURcsj/brO
         onRaI/htm7LHIVyEx+fJO/KvtdvEx7X5hb1k1dy2rKFZpdRlHfWmcAr4zzp61Nbwj1QG
         57cHw3C44dNNmgu4HWA2FJ+PlFECr2bx8GggNMm8q5qNMSBgxVXEjE4nlDD7LV0HPFZe
         xpmF1jSA+7dJiCe0KWSQLW+Ax/S/vEeIswfyuZnmKwGaSBpGJMigmZe6kviQ7slGmwgS
         HJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3jVDw2F3FLGmwjOb7HhNx2sSGB+A2r03pvrlXP4qvw=;
        b=lHBfT32g+scCsmVfsFdpINOCvr/k2ZruS7gCpjkJfh67dAOE8MrLkaQanozdrqk1E+
         QrdVZxWYNbm3N2u6UYL1/M/0jMzlBnQt0Gm6+qf7XdhDy3vDVGON7njDQEtSOF+HgRlW
         TzFYXaz1G2UKit6gpqHKXR9wZ+yiKqRAUPfw6Y0M8cDsAZlCyIsTMPKSASAY/5yXpyd7
         v+VQaNl4eGhdowyRW8z759wOWPx867yETbiqLqQ/Lv+DQ3hDhcO3O1TdCLw0bU4mVnLD
         3hqCiPbl6lF6StQ+D0clQD+LzbrMo5h/ez2V8c4/Kfia5WLzf/kTDVK4pnLkt3txgPC2
         lXrQ==
X-Gm-Message-State: AOAM531EQXQw9Hi0phbW9wjJEgDVZweMsEeoBHCwC1vHsjoa6HEfkNJg
        2j6y7MAqiyHMPiIbBvAvpEM/Wg==
X-Google-Smtp-Source: ABdhPJwJ4nykfCh9VS9dkXfNUx8G/MsHHxoNAxTMZpSm9SSuGCOV+t6xwvIqg3LI3qHWjS7GRT2Fbw==
X-Received: by 2002:a17:902:7681:b029:d2:88b1:b130 with SMTP id m1-20020a1709027681b02900d288b1b130mr383548pll.20.1601310928915;
        Mon, 28 Sep 2020 09:35:28 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:28 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/25] coresight: tmc: Allow tmc to be built as a module
Date:   Mon, 28 Sep 2020 10:35:01 -0600
Message-Id: <20200928163513.70169-14-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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
2.25.1

