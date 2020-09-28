Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0EB27B1FB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgI1Qfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgI1Qf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:27 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAB2C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:27 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d6so1507726pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z2CmOiUqIi3yzFuKU+bzyeukQxjbaPfmw7sLG+1ioBo=;
        b=BMR/O8qe2rXvmTvc0vLb+ZJea/fudMosPiGJcAui+t2ZRn578HzmIA5MS/kjTuwR6+
         khFkU9w7kBv4rCc14TyxBuPiMawXnsKmZu262ZRMK5f2kGulIDYZn97Z5G4Uh97GzPwk
         FIcMws2GFZP5pgukI8WVlpZ2VuK0FphAPtN++y3pZbyEXeJrWaFvQWSX7370fIKdHwx8
         uHQGBBdVTqUjWQfHRsInMtauh2EqJB2fOt83dBXdu3WmvAHyehYS2eRbEORSXWe3jOxz
         ZsKSD17zQ+a6SCxCvBibdzCGfcfshZpX2RxJSNbCQuKneyd3zZkQciJgXIRAtwymc1Ab
         rLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z2CmOiUqIi3yzFuKU+bzyeukQxjbaPfmw7sLG+1ioBo=;
        b=f7JSD/jjR6Z1a3v79HZ1tY3paUbw3PfrLlAUJ5s/Jvg0ePYaaWOvIU9i+ViLL8XZJu
         b7gcI8foeJGgds/wY6VilkJ2RNkcwlDt03Sj74aeMMobeKn5dEwVJhMW+908eB53XXEA
         UKWQn2bpiDy8gDUvH0rKiJJEBLxu7iRITF6+xq6PEGsRVaSS4ji2u+MP06NT7r/x9EV3
         9nQsIo9om7raxK4H3XJfzrF5Ifr3LUuCgt37su16z/SON0/+/0ckr9OTmZQvda8g0BMS
         LojcYZvEn+oLVPbw8/DA76dQGOYZRWTF6qrRm+FUY9OXf4PaPbXo66hqeRFuthXyZ/OS
         KxIg==
X-Gm-Message-State: AOAM530DqKEZRUPSqpJMaWxiATyWhpzrA+FbX3cSnETAk4n/iwoMmYWe
        yCDTolNM9nUQ3AvkYv2JrsuUBw==
X-Google-Smtp-Source: ABdhPJzqJs2a3ir5T2VTqKg6xAe6GuQu//NZjLFcieRxcCk962PEym3sNugg9IaixbV7as1OdqAlWQ==
X-Received: by 2002:a62:154b:0:b029:150:c091:7146 with SMTP id 72-20020a62154b0000b0290150c0917146mr220065pfv.80.1601310926652;
        Mon, 28 Sep 2020 09:35:26 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:26 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/25] coresight: etb: Allow etb to be built as a module
Date:   Mon, 28 Sep 2020 10:34:59 -0600
Message-Id: <20200928163513.70169-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@arm.com>

Allow to build coresight-etb10 as a module, for ease of development.

- Kconfig becomes a tristate, to allow =m
- add an etb_remove function, for module unload
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
 drivers/hwtracing/coresight/Kconfig           |  5 +++-
 drivers/hwtracing/coresight/coresight-etb10.c | 26 ++++++++++++++++++-
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index d6e107bbd30b..996d84a1edb8 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -57,13 +57,16 @@ config CORESIGHT_SINK_TPIU
 	  the on-board coresight memory can handle.
 
 config CORESIGHT_SINK_ETBV10
-	bool "Coresight ETBv1.0 driver"
+	tristate "Coresight ETBv1.0 driver"
 	depends on CORESIGHT_LINKS_AND_SINKS
 	help
 	  This enables support for the Embedded Trace Buffer version 1.0 driver
 	  that complies with the generic implementation of the component without
 	  special enhancement or added features.
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called coresight-etb10.
+
 config CORESIGHT_SOURCE_ETM3X
 	tristate "CoreSight Embedded Trace Macrocell 3.x driver"
 	depends on !ARM64
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 04ee9cda988d..248cc82c838e 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -801,6 +801,21 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
+static int __exit etb_remove(struct amba_device *adev)
+{
+	struct etb_drvdata *drvdata = dev_get_drvdata(&adev->dev);
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
 #ifdef CONFIG_PM
 static int etb_runtime_suspend(struct device *dev)
 {
@@ -835,6 +850,8 @@ static const struct amba_id etb_ids[] = {
 	{ 0, 0},
 };
 
+MODULE_DEVICE_TABLE(amba, etb_ids);
+
 static struct amba_driver etb_driver = {
 	.drv = {
 		.name	= "coresight-etb10",
@@ -844,6 +861,13 @@ static struct amba_driver etb_driver = {
 
 	},
 	.probe		= etb_probe,
+	.remove		= etb_remove,
 	.id_table	= etb_ids,
 };
-builtin_amba_driver(etb_driver);
+
+module_amba_driver(etb_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight Embedded Trace Buffer driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

