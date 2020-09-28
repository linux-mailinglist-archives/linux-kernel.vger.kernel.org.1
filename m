Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C2A27B20E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgI1Qgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgI1Qf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:29 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7EFC0613D4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:28 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 7so1307643pgm.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XaJPe7K+ZjHgHfXIN2qEoYr/QyZph8mHXWNbLeRPwdw=;
        b=wthzh4Pad4X5FxEjptnGzLoiFt/kjnaJISlMrfOG4+cU0QLHDj4oI53F5kzusDUwmv
         4RV1Gpx4+IAYC1x4tiXM99rEJUoh/JFQMkdGiNWRIWcC1RYbIunyeGOBz8yex6NCou1f
         wvmppI2n7plE3FY34fQ5TkD8L3Q9+UQzegByyl8N9uZueTHB3HS4rSiuc1vJLLCW9sCr
         Re+UytA4k2pB62HyLVEFSwJFu2By8B2r8AD4uMqiWTzJVZ879PCD4qVakWK4F2zffR/i
         r0P/pz7HIR0KcfQ9u+pPV3fvm+qxXW6BvVuz6z3jE4WY2e4tOJy/0657j5XFUVgDhT6h
         Tg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XaJPe7K+ZjHgHfXIN2qEoYr/QyZph8mHXWNbLeRPwdw=;
        b=PS6M5S51TUS5vYjhJ8b1TeTjJf2l0/swGcJct2kqQPkSBGdE5r/yhSOzCcgRgqs8ED
         D9aQ8K8RdNeNz79KqfStlGpHU8D90C6sAM8sP3FsrQkeKZRk2R0359znTaZJjooqxW4z
         2jKzgKt5GBAP8byBgRtulbVSSXtH+++gtqt8/RmwRga6r80rm2Qw0tkQ7LchZHttnqr0
         +zZLGv0x2pqtE5YtFvxr+K9uZAsrlbm89yZa/HuyzsUFbwsihwbjQYWB9FQwL+adf17z
         0OUhRQ5tuCqt0QSKtNCFxzPQFrX+Vh7zQa0M81hin9ovSQTV5f8OlbYzANbGvcJLk4+u
         zVbg==
X-Gm-Message-State: AOAM5325wL5lZ7o+46wcrUZhnwU4Maxd+4YdMzEIp0E7WFTgCPZW60ZH
        qVlLDRvCevbEr/m7B44XdZEQHUtOhJgVrg==
X-Google-Smtp-Source: ABdhPJz/QrA7wRRqiwNKrbNLcc+XS4F92IDbxzxfrd+pLXb0loh+r/vzqzVXnakXoDlRdQ0NDSuIQA==
X-Received: by 2002:a17:902:7e0d:b029:d2:8ceb:ea4b with SMTP id b13-20020a1709027e0db02900d28cebea4bmr303249plm.59.1601310927714;
        Mon, 28 Sep 2020 09:35:27 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:27 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/25] coresight: tpiu: Allow tpiu to be built as a module
Date:   Mon, 28 Sep 2020 10:35:00 -0600
Message-Id: <20200928163513.70169-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@arm.com>

Allow to build coresight-tpiu as a module, for ease of development.

- Kconfig becomes a tristate, to allow =m
- add a tpiu_remove function, for module unload
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
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig          |  5 ++++-
 drivers/hwtracing/coresight/coresight-tpiu.c | 20 +++++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 996d84a1edb8..8fd9887fb03b 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -46,7 +46,7 @@ config CORESIGHT_CATU
 	   mode where the address is not translated.
 
 config CORESIGHT_SINK_TPIU
-	bool "Coresight generic TPIU driver"
+	tristate "Coresight generic TPIU driver"
 	depends on CORESIGHT_LINKS_AND_SINKS
 	help
 	  This enables support for the Trace Port Interface Unit driver,
@@ -56,6 +56,9 @@ config CORESIGHT_SINK_TPIU
 	  connected to an external host for use case capturing more traces than
 	  the on-board coresight memory can handle.
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called coresight-tpiu.
+
 config CORESIGHT_SINK_ETBV10
 	tristate "Coresight ETBv1.0 driver"
 	depends on CORESIGHT_LINKS_AND_SINKS
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index f8583e4032a6..566c57e03596 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -173,6 +173,15 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	return PTR_ERR(drvdata->csdev);
 }
 
+static int __exit tpiu_remove(struct amba_device *adev)
+{
+	struct tpiu_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	coresight_unregister(drvdata->csdev);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int tpiu_runtime_suspend(struct device *dev)
 {
@@ -216,6 +225,8 @@ static const struct amba_id tpiu_ids[] = {
 	{ 0, 0},
 };
 
+MODULE_DEVICE_TABLE(amba, tpiu_ids);
+
 static struct amba_driver tpiu_driver = {
 	.drv = {
 		.name	= "coresight-tpiu",
@@ -224,6 +235,13 @@ static struct amba_driver tpiu_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe		= tpiu_probe,
+	.remove         = tpiu_remove,
 	.id_table	= tpiu_ids,
 };
-builtin_amba_driver(tpiu_driver);
+
+module_amba_driver(tpiu_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight TPIU (Trace Port Interface Unit) driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

