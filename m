Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C77D2B91CE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgKSLrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbgKSLmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:19 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E3AC061A4E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:17 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u12so6156225wrt.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2yNpy/proxW4Hb+nFB5pPJfVOfJDXZ+qUUNtolqrB1I=;
        b=yjyUxObzb7k0OTA+7LiUIucY9q6pxV+jcTeC1uCYErFaTbF14qmhZGA7VbaO/UBtD+
         Z8DyWyj/zHpx3ibVHev8mx43hMZhoAVDH2AfDky6f0NOG/PiS2yHPkxjxIS2zfWwaxeW
         3ggwRSn/i8GV9l20iDp99zsmMg9h9R98LjHnkIHsskyNLlN7bVbdv6j9Jpaqh0qfZUIH
         3satMkbvqIgp/cinEc0qaBnq92r74jHay0Z+EbYaLQuxFxC/OAbSaI/6owH73bVROngf
         N1exWVmMkw+GF1boM80LmBruu/bZR9/aCtLuc590yGkAkInCxfAsy0W05nU8IKh99ift
         YeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2yNpy/proxW4Hb+nFB5pPJfVOfJDXZ+qUUNtolqrB1I=;
        b=CI8tUHegjYfeRugFUbfRJaOPzCURSO0F5dwq3k0zP00ngew/Fhaqu8SURD539JqkM8
         oqRCgZgfq8Y1moDQtSE4gBre7ZUDp9AbTtnBZlk0Bc4PeUY0OM8LTC58aZhP/IIuI3tW
         TfFUbJ+CpBAF0kMn9WFs02fveyJqZQdP2wApaH84kHt2zAzuZ6dlFOQF+8RFQHt44QYH
         gs3fkdjn4tMr066hR0sJYGy0FK9YwY71syZVx+7h65hf7HL1J8W55PJrEidjZAIJaryt
         9rI801btUzreQIXH+XYMmtfsYnVO9AYD3l645vmPbwYO41FWsLjxAKmPKbw2IZSkbmwN
         i8Tw==
X-Gm-Message-State: AOAM532FbQQor83AjQsfaqfvuJFcCFMucpeUG9eq1IhGhKZjx9F2CaFR
        YKTCuGqmgm+oxoIdaInH8ntEcw==
X-Google-Smtp-Source: ABdhPJxE1aWjd7WWS/Z4VPzsIceqq8O+NZH80eTZ0OJSE3daXmLzToJN5X/V9VKfi08MKFW+qosczg==
X-Received: by 2002:adf:f7ce:: with SMTP id a14mr9725549wrq.294.1605786136347;
        Thu, 19 Nov 2020 03:42:16 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:15 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 11/59] rtc: efi: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:01 +0100
Message-Id: <20201119114149.4117-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201119114149.4117-1-brgl@bgdev.pl>
References: <20201119114149.4117-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

devm_rtc_device_register() is deprecated. Use devm_rtc_allocate_device()
and devm_rtc_register_device() pair instead.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-efi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
index edb64debd173..47e79a54ecae 100644
--- a/drivers/rtc/rtc-efi.c
+++ b/drivers/rtc/rtc-efi.c
@@ -261,15 +261,15 @@ static int __init efi_rtc_probe(struct platform_device *dev)
 	if (efi.get_time(&eft, &cap) != EFI_SUCCESS)
 		return -ENODEV;
 
-	rtc = devm_rtc_device_register(&dev->dev, "rtc-efi", &efi_rtc_ops,
-					THIS_MODULE);
+	rtc = devm_rtc_allocate_device(&dev->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
+	rtc->ops = &efi_rtc_ops;
 	rtc->uie_unsupported = 1;
 	platform_set_drvdata(dev, rtc);
 
-	return 0;
+	return devm_rtc_register_device(rtc);
 }
 
 static struct platform_driver efi_rtc_driver = {
-- 
2.29.1

