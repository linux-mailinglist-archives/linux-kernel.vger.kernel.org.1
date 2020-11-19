Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8272B916B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgKSLne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbgKSLnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:43:11 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506A1C061A4D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:43:09 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h21so6462689wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0GrbllWNlOi0aXzL8UKo7Ky/Zu/FqzuF2bHcZS29c2k=;
        b=hNUz8XkHmocpco9nnHC0gTQJ7r44zzeIxvkG6EQICbkwSL5gNVy1H3UBMt9ZMaNsjq
         3VXxQfoV6UDvXw1x6tBLEdwf/tO7cV+AF1ndCdTROKDxcmZ5+c03EV2+LsIWINGfukPK
         Ku0+/Wja9SMFmEBbupNrylCq8C+/lZHy4wbBpB62zrqaBnPck+K9cVrPndKwGfDdo4HB
         jJwdMWziGYceXyYCaeYzLhyURxBtWsgzCrpUU5JuyPcflZE0Hpy2Z30HH+XX90PF15QS
         iaFGLmG0A5s4LA2Zjwi3Zm4GXQhVNTezbyiM1cSd5sSgQNlwgvV/CvIDTmOhI9licOtV
         NyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0GrbllWNlOi0aXzL8UKo7Ky/Zu/FqzuF2bHcZS29c2k=;
        b=gUWVU2YQEum1teeY+wpI5I8PQcuxb3jYNz+JiB3rfVyadiO/ZpQJobbK6D9YWlEny5
         BE8cIfJ98GHM7Q5W5bafXcwkJNc9JDM2z92Wu9ZhIoGtVmhHteBFxncBb2+ZW0neHjZf
         y2gS4lunzCMviOfwi1uoG3tcAlTjpW0aOGPnDk06a4I0+yZy5oRsVMZ7OgnSwCSN8PB4
         5uenaPIL79jDGiJFwbGKfD4ZxJpOF593VcyGAD94xW22MlObFkdltfUsVbzsTAu/wcqE
         gAA23VAhjWM8ZQYKjOaXoPqKOGb1jU7pcsABNZwvZgaR8jOsY59lHuXMTO9uImmIX/L5
         Nbuw==
X-Gm-Message-State: AOAM533o8PgBlgk01uE2eetQ/DIjI+t1zxkwcdE87A5AMCLTITTEe51x
        wfQ3LAqiNbI2GLql9dKMYiotjA==
X-Google-Smtp-Source: ABdhPJxL/+GwdPD3F/9QcF+Gnxj3vmEy215nZrB2sXIZo+yqMFxANH21tdrvG4DWwVvRlCuiqVRLBg==
X-Received: by 2002:a7b:c77a:: with SMTP id x26mr4082286wmk.63.1605786188098;
        Thu, 19 Nov 2020 03:43:08 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:43:07 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 59/59] rtc: remove devm_rtc_device_register()
Date:   Thu, 19 Nov 2020 12:41:49 +0100
Message-Id: <20201119114149.4117-60-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201119114149.4117-1-brgl@bgdev.pl>
References: <20201119114149.4117-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

All users have been converted to using the devm_rtc_allocate_device() +
devm_rtc_register_device() pair. We can remove the deprecated interface.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/rtc/class.c                           | 36 -------------------
 include/linux/rtc.h                           |  4 ---
 3 files changed, 41 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index cd8b6e657b94..f22823af7265 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -412,7 +412,6 @@ RESET
   devm_reset_controller_register()
 
 RTC
-  devm_rtc_device_register()
   devm_rtc_allocate_device()
   devm_rtc_register_device()
   devm_rtc_nvmem_register()
diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index e6b44b7c4ad3..e192ea39ff3f 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -415,42 +415,6 @@ int __devm_rtc_register_device(struct module *owner, struct rtc_device *rtc)
 }
 EXPORT_SYMBOL_GPL(__devm_rtc_register_device);
 
-/**
- * devm_rtc_device_register - resource managed rtc_device_register()
- * @dev: the device to register
- * @name: the name of the device (unused)
- * @ops: the rtc operations structure
- * @owner: the module owner
- *
- * @return a struct rtc on success, or an ERR_PTR on error
- *
- * Managed rtc_device_register(). The rtc_device returned from this function
- * are automatically freed on driver detach.
- * This function is deprecated, use devm_rtc_allocate_device and
- * rtc_register_device instead
- */
-struct rtc_device *devm_rtc_device_register(struct device *dev,
-					    const char *name,
-					    const struct rtc_class_ops *ops,
-					    struct module *owner)
-{
-	struct rtc_device *rtc;
-	int err;
-
-	rtc = devm_rtc_allocate_device(dev);
-	if (IS_ERR(rtc))
-		return rtc;
-
-	rtc->ops = ops;
-
-	err = __devm_rtc_register_device(owner, rtc);
-	if (err)
-		return ERR_PTR(err);
-
-	return rtc;
-}
-EXPORT_SYMBOL_GPL(devm_rtc_device_register);
-
 static int __init rtc_init(void)
 {
 	rtc_class = class_create(THIS_MODULE, "rtc");
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 55e7beed066c..e3623446a9d7 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -150,10 +150,6 @@ struct rtc_device {
 #define RTC_TIMESTAMP_END_2199		7258118399LL /* 2199-12-31 23:59:59 */
 #define RTC_TIMESTAMP_END_9999		253402300799LL /* 9999-12-31 23:59:59 */
 
-extern struct rtc_device *devm_rtc_device_register(struct device *dev,
-					const char *name,
-					const struct rtc_class_ops *ops,
-					struct module *owner);
 struct rtc_device *devm_rtc_allocate_device(struct device *dev);
 int __devm_rtc_register_device(struct module *owner, struct rtc_device *rtc);
 
-- 
2.29.1

