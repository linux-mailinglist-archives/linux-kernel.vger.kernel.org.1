Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2828A27B207
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgI1QgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgI1Qft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:49 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA17C0613D7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:37 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x123so1517885pfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ivbWO62B8/k+HVBL4SFDiAMi/0I8fix8+11SWaId4bY=;
        b=ObBy8vJtilE1GAR2jjlktnpUQ69kiKhcfz77CJ1CtcnVu2IFeEWVMNAaiqkh+QERYS
         11Aj+Bj5Fr582cwGunCQ2YZImInNM3vIZxARd7AU3cwRQxQ1adWFHr5QMiUsDiffpAdo
         ETINsPdp2Ty5tLUBPlX6b+y9sc8XXTJ4ha/0lb5CWJwj1yG2jt4Nk01M0rCVbzpCpUz7
         J6HB5bOvb9Kk+kDEGUGNTEkEuqFhmYIpcAmYBGzCtMYjaSfiioAHOBUuJuZxSQsL4OjZ
         mUMGFF614RKMy7NBxPlIQzlVYxgEujaRQx2hGf49EbLRbwIP8CuTgj7uuCQW4EepTEkN
         bu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ivbWO62B8/k+HVBL4SFDiAMi/0I8fix8+11SWaId4bY=;
        b=ArWo02xZ31FVzB8jQTtjRaW5qHLeQMIBnECDCNJt9fUViX1QLegoj1JnHvqJ3E5m3X
         L4ZyJ/d6m54DGIiPMUtlXEBCdXf8xLaHDSHRc3Elz8hMUt8VDn1MGmkbCeOQH0RGS89U
         7n8Lv79mh0UZa8md7c3ASkd5I9dHfkFXB4V8Wofos8M3QEHweutTKsdS8PSCWpRp95Uy
         v7vZt+TaQ5eQ7qXw8toF41iX6cMq2KbmaoaZduuKfWgtdbA9dKl2QJ/oqIQJ0HWF8H9p
         nMXSGZO30WbTYmzJsVewWxaNeq+jsIZFyFXrnPcXRX2qh4NDzWQd0K6UewR6GNrhbox2
         Wsrw==
X-Gm-Message-State: AOAM533YMlNkZxPmnWPZNCeZzo9bg67hbmt+E/8FNVbSxYh25oTKFUes
        UdAv/uTu6ELfAH/MBiRjRAmg6YmOYPaH0A==
X-Google-Smtp-Source: ABdhPJzyeA3Q5ngCzGIK7eSt6PW/tJB8tqaKnGIDg9q3no2KbHhZQJeHREM0JArhioIFXKbrUbsY9w==
X-Received: by 2002:a63:2e42:: with SMTP id u63mr1817811pgu.292.1601310937360;
        Mon, 28 Sep 2020 09:35:37 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:36 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/25] coresight: cti: Allow cti to be built as a module
Date:   Mon, 28 Sep 2020 10:35:09 -0600
Message-Id: <20200928163513.70169-22-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

Allow to build coresight-cti as a module, for ease of development.

- Kconfig becomes a tristate, to allow =m
- append -core to source file name to allow module to
  be called coresight-cti by the Makefile
- add an cti_remove function, for module unload
- add a MODULE_DEVICE_TABLE for autoloading on boot
- move cti_remove_conn_xrefs to cti_remove since all sysfs links
  have gone when system calls device_release.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Tested-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig           |  5 ++++-
 drivers/hwtracing/coresight/Makefile          |  6 +++---
 .../{coresight-cti.c => coresight-cti-core.c} | 20 ++++++++++++++++++-
 .../hwtracing/coresight/coresight-platform.c  |  1 +
 drivers/hwtracing/coresight/coresight.c       |  1 +
 5 files changed, 28 insertions(+), 5 deletions(-)
 rename drivers/hwtracing/coresight/{coresight-cti.c => coresight-cti-core.c} (98%)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index f31778dd0b5d..b04aae2ceecc 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -136,7 +136,7 @@ config CORESIGHT_CPU_DEBUG
 	  module will be called coresight-cpu-debug.
 
 config CORESIGHT_CTI
-	bool "CoreSight Cross Trigger Interface (CTI) driver"
+	tristate "CoreSight Cross Trigger Interface (CTI) driver"
 	depends on ARM || ARM64
 	help
 	  This driver provides support for CoreSight CTI and CTM components.
@@ -147,6 +147,9 @@ config CORESIGHT_CTI
 	  halt compared to disabling sources and sinks normally in driver
 	  software.
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called coresight-cti.
+
 config CORESIGHT_CTI_INTEGRATION_REGS
 	bool "Access CTI CoreSight Integration Registers"
 	depends on CORESIGHT_CTI
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 3dbd49a060dd..27034bd4d3c7 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -19,6 +19,6 @@ coresight-etm4x-y := coresight-etm4x-core.o coresight-etm4x-sysfs.o
 obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
 obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
 obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
-obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o \
-				coresight-cti-platform.o \
-				coresight-cti-sysfs.o
+obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
+coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
+		   coresight-cti-sysfs.o
diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti-core.c
similarity index 98%
rename from drivers/hwtracing/coresight/coresight-cti.c
rename to drivers/hwtracing/coresight/coresight-cti-core.c
index 38e785d913b0..d28eae93e55c 100644
--- a/drivers/hwtracing/coresight/coresight-cti.c
+++ b/drivers/hwtracing/coresight/coresight-cti-core.c
@@ -822,7 +822,6 @@ static void cti_device_release(struct device *dev)
 	struct cti_drvdata *ect_item, *ect_tmp;
 
 	mutex_lock(&ect_mutex);
-	cti_remove_conn_xrefs(drvdata);
 	cti_pm_release(drvdata);
 
 	/* remove from the list */
@@ -837,6 +836,18 @@ static void cti_device_release(struct device *dev)
 	if (drvdata->csdev_release)
 		drvdata->csdev_release(dev);
 }
+static int __exit cti_remove(struct amba_device *adev)
+{
+	struct cti_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	mutex_lock(&ect_mutex);
+	cti_remove_conn_xrefs(drvdata);
+	mutex_unlock(&ect_mutex);
+
+	coresight_unregister(drvdata->csdev);
+
+	return 0;
+}
 
 static int cti_probe(struct amba_device *adev, const struct amba_id *id)
 {
@@ -957,6 +968,8 @@ static const struct amba_id cti_ids[] = {
 	{ 0, 0},
 };
 
+MODULE_DEVICE_TABLE(amba, cti_ids);
+
 static struct amba_driver cti_driver = {
 	.drv = {
 		.name	= "coresight-cti",
@@ -964,6 +977,7 @@ static struct amba_driver cti_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe		= cti_probe,
+	.remove		= cti_remove,
 	.id_table	= cti_ids,
 };
 
@@ -986,3 +1000,7 @@ static void __exit cti_exit(void)
 
 module_init(cti_init);
 module_exit(cti_exit);
+
+MODULE_AUTHOR("Mike Leach <mike.leach@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight CTI Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 227e234a2470..3629b7885aca 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -75,6 +75,7 @@ coresight_find_csdev_by_fwnode(struct fwnode_handle *r_fwnode)
 	}
 	return csdev;
 }
+EXPORT_SYMBOL_GPL(coresight_find_csdev_by_fwnode);
 
 #ifdef CONFIG_OF
 static inline bool of_coresight_legacy_ep_is_input(struct device_node *ep)
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 546c97045afe..5aebdbe293f2 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -288,6 +288,7 @@ void coresight_set_assoc_ectdev_mutex(struct coresight_device *csdev,
 	csdev->ect_dev = ect_csdev;
 	mutex_unlock(&coresight_mutex);
 }
+EXPORT_SYMBOL_GPL(coresight_set_assoc_ectdev_mutex);
 
 static int coresight_enable_sink(struct coresight_device *csdev,
 				 u32 mode, void *data)
-- 
2.25.1

