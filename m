Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5631A27B202
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgI1Qfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgI1Qft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:49 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2964EC0613DB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:41 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x22so1495398pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AVDy3lRo4u1kGXdA37uwPHSMumdxyJ4pvdoLnVCsqbY=;
        b=pge0/L761dyNtWA4WDPXGSZbSwCT/Ryl0UdBFpMdClcdiKMZB89vZ4PWlEprve+IX5
         I7ULlMjTBwCrsBOg0Szv0qk8r9wSX8dRuKOaRbBPoCHt43PfLvykFzRTLj/qErjHT1+I
         MUAZ3pZRRTY4Xf38pkn+fMsEPnvAF0SMerGfUSMpkeHfWsWXcq+49XRg+PdUGbvnvq/o
         Sq9arFcnxujH8HZR0NkZOBlZnEh4mIToPJLc4nHUuMyWezaYLViXlG4BizlImFpnxYi6
         9ony3nNaO2irh5l7c8H05tF7THJjvWX/USuVzO5hQTw2LIK7aUJTUx6JTxb8hurdruLa
         Zk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AVDy3lRo4u1kGXdA37uwPHSMumdxyJ4pvdoLnVCsqbY=;
        b=tGc+vgTieBGf0xcr7t562aYScjqTpKUI7v7o3zX3HmAnuBuP9FItF1dcjWbJRpLiuN
         TrMHe8P5o/KNkPd1GHgKgw2/BLcCppkXJTlufULoCNLDX3ykefPn2rLIUAtqoRWSsmXb
         UfbAex6yRWCM3pwD3Nz9Jd2zZWRN5fFihEre0I5V9OgnMwIuq9TqTePuhelaYG3yni6v
         9MGk38OymmXwd+f8ZwoqB9N3EqihDmWXuEWKzmbXsm6VPDIh+9jw0znFMbeyiNrNeaxf
         TIHA29emxxeD2fZ0fKlI7idFZmsQWBVgLq+s4jqa5Un5c5ko06Z1ELi+J3OFsSbh2ftA
         5T+w==
X-Gm-Message-State: AOAM5317zKwbbaLttDd5Fa78OBMnpF9Wz7rUpKF8mzr4rREXMtd43wYD
        8bJNYRSmRZEMskkHPCG5VhLcqXajkHD0TA==
X-Google-Smtp-Source: ABdhPJzC2AVxkr4GIVfKLPkRrx1h28700LxyGtFJT5WmLM/uhXvVg1nFsbegBW1atTv5whas/rUECg==
X-Received: by 2002:a62:1dcb:0:b029:13e:d13d:a131 with SMTP id d194-20020a621dcb0000b029013ed13da131mr213756pfd.25.1601310940715;
        Mon, 28 Sep 2020 09:35:40 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:40 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/25] coresight: core: Allow the coresight core driver to be built as a module
Date:   Mon, 28 Sep 2020 10:35:12 -0600
Message-Id: <20200928163513.70169-25-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

Enhance coresight developer's efficiency to debug coresight drivers.
- Kconfig becomes a tristate, to allow =m
- append -core to source file name to allow module to
  be called coresight by the Makefile
- modules can have only one init/exit, so we add the etm_perf
  register/unregister function calls to the core init/exit
  functions.
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
 drivers/hwtracing/coresight/Kconfig           |  5 ++-
 drivers/hwtracing/coresight/Makefile          |  5 ++-
 .../{coresight.c => coresight-core.c}         | 42 ++++++++++++++-----
 .../hwtracing/coresight/coresight-etm-perf.c  |  8 +++-
 .../hwtracing/coresight/coresight-etm-perf.h  |  3 ++
 5 files changed, 48 insertions(+), 15 deletions(-)
 rename drivers/hwtracing/coresight/{coresight.c => coresight-core.c} (98%)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index dfe407cde262..c1198245461d 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -3,7 +3,7 @@
 # Coresight configuration
 #
 menuconfig CORESIGHT
-	bool "CoreSight Tracing Support"
+	tristate "CoreSight Tracing Support"
 	depends on ARM || ARM64
 	depends on OF || ACPI
 	select ARM_AMBA
@@ -15,6 +15,9 @@ menuconfig CORESIGHT
 	  specification and configure the right series of components when a
 	  trace source gets enabled.
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called coresight.
+
 if CORESIGHT
 config CORESIGHT_LINKS_AND_SINKS
 	tristate "CoreSight Link and Sink drivers"
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 27034bd4d3c7..f20e357758d1 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -2,8 +2,9 @@
 #
 # Makefile for CoreSight drivers.
 #
-obj-$(CONFIG_CORESIGHT) += coresight.o coresight-etm-perf.o \
-			   coresight-platform.o coresight-sysfs.o
+obj-$(CONFIG_CORESIGHT) += coresight.o
+coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
+		coresight-sysfs.o
 obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
 coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
 		      coresight-tmc-etr.o
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight-core.c
similarity index 98%
rename from drivers/hwtracing/coresight/coresight.c
rename to drivers/hwtracing/coresight/coresight-core.c
index 5aebdbe293f2..6994c1309b2b 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1452,16 +1452,6 @@ int coresight_timeout(void __iomem *addr, u32 offset, int position, int value)
 }
 EXPORT_SYMBOL_GPL(coresight_timeout);
 
-struct bus_type coresight_bustype = {
-	.name	= "coresight",
-};
-
-static int __init coresight_init(void)
-{
-	return bus_register(&coresight_bustype);
-}
-postcore_initcall(coresight_init);
-
 /*
  * coresight_release_platform_data: Release references to the devices connected
  * to the output port of this device.
@@ -1670,3 +1660,35 @@ char *coresight_alloc_device_name(struct coresight_dev_list *dict,
 	return name;
 }
 EXPORT_SYMBOL_GPL(coresight_alloc_device_name);
+
+struct bus_type coresight_bustype = {
+	.name	= "coresight",
+};
+
+static int __init coresight_init(void)
+{
+	int ret;
+
+	ret = bus_register(&coresight_bustype);
+	if (ret)
+		return ret;
+
+	ret = etm_perf_init();
+	if (ret)
+		bus_unregister(&coresight_bustype);
+
+	return ret;
+}
+
+static void __exit coresight_exit(void)
+{
+	etm_perf_exit();
+	bus_unregister(&coresight_bustype);
+}
+
+module_init(coresight_init);
+module_exit(coresight_exit);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight tracer driver");
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 47894a0dcf5e..c2c9b127d074 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -599,7 +599,7 @@ void etm_perf_del_symlink_sink(struct coresight_device *csdev)
 	csdev->ea = NULL;
 }
 
-static int __init etm_perf_init(void)
+int __init etm_perf_init(void)
 {
 	int ret;
 
@@ -626,4 +626,8 @@ static int __init etm_perf_init(void)
 
 	return ret;
 }
-device_initcall(etm_perf_init);
+
+void __exit etm_perf_exit(void)
+{
+	perf_pmu_unregister(&etm_pmu);
+}
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 05f89723e282..3e4f2ad5e193 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -82,4 +82,7 @@ static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
 
 #endif /* CONFIG_CORESIGHT */
 
+int __init etm_perf_init(void);
+void __exit etm_perf_exit(void);
+
 #endif
-- 
2.25.1

