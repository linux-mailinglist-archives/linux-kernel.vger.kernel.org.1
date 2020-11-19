Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F94C2B91CD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgKSLro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbgKSLmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:19 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F748C061A4F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:19 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id w24so6470129wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hcFVpN2LhvD71VSXEoptj+peb8gaYvZ6QlNRmI0brdI=;
        b=ppzWkeMBINnD8eNHi+4/Kuq6ipFcMuhnm8P+3ZkJtMCw1K29TIy/JpVgDupbgLuJfX
         NI0h+gRmCQSBfIxg2c+UhnGl6ChUe2edzzr4gfqo9wLIBqgDRPmpXObm4ynWxJ//8IX6
         eEn0htFSHZALnCExfZN5fLIjGxQS0LiEuJLt6626nJRBerJj/7oVnG6pzy037HX0Vf/r
         x5WSCDY3n8rvIuha/OdrK73yLSvzWXBNJECf9JGDEP/iCeUiowevmnRwfmHWeYfqxXPg
         B8s/LvClAnDiRK4cjR4nLzi49duKoRV3osGDBTuPwBd9zjykBMpQjDIBGuED0t6eH6oo
         TSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hcFVpN2LhvD71VSXEoptj+peb8gaYvZ6QlNRmI0brdI=;
        b=SfmJ0ICT4n0RqZcbIh6rkHoVS3SlJCr3c4EQpIikdtUDUnOAZc8VsW9LGc/Fnl7Ofh
         xUcX+Z0aBvwi1bdybIKbp/DsQBI19ipoVtTxelUheC5kRjj7/Ei6sZ5brfWu98bdFmjw
         QxkidB2M/rrKGyVktLbrh04bsZNFCxKYZTfEz7LxxQK/YrNPqjxXj4/zyMkao4ZZaADj
         KeuTIlKvvi50lcKzC42NP7JEbNmxKXaIvgNzexcsCXN+eo9VbPGwkntT+MPIkXGxUQwi
         xizxfHReLJpOe+yqLb2S8m4lvCoq3t6ekcYftsBdXLy035WtBLlpPRgoJoSzZGFND5H5
         DHkg==
X-Gm-Message-State: AOAM532i7EoPLC0KKUVkfWJX7elyzsDYm9hNR0EJiDYP/UifJIj8c4uX
        Ewcql8szNsfIDjdmfninBQdmHg==
X-Google-Smtp-Source: ABdhPJwjr/FIvvMw8TZHmw4gfXRSRpDK1unPRTIRxPJR+N/aBbO303TWwa4cVcvqrLY4HRAXDXeSPg==
X-Received: by 2002:a1c:c909:: with SMTP id f9mr3972485wmb.87.1605786138319;
        Thu, 19 Nov 2020 03:42:18 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:17 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 13/59] rtc: stm32: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:03 +0100
Message-Id: <20201119114149.4117-14-brgl@bgdev.pl>
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
 drivers/rtc/rtc-stm32.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index d774aa18f57a..9d6be4fa885d 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -795,14 +795,11 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rtc);
 
-	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
-						&stm32_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc->rtc_dev)) {
-		ret = PTR_ERR(rtc->rtc_dev);
-		dev_err(&pdev->dev, "rtc device registration failed, err=%d\n",
-			ret);
-		goto err;
-	}
+	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc->rtc_dev))
+		return PTR_ERR(rtc->rtc_dev);
+
+	rtc->rtc_dev->ops = &stm32_rtc_ops;
 
 	/* Handle RTC alarm interrupts */
 	ret = devm_request_threaded_irq(&pdev->dev, rtc->irq_alarm, NULL,
@@ -829,7 +826,12 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 			 (ver >> STM32_RTC_VERR_MINREV_SHIFT) & 0xF);
 	}
 
+	ret = devm_rtc_register_device(rtc->rtc_dev);
+	if (ret)
+		goto err;
+
 	return 0;
+
 err:
 	if (rtc->data->has_pclk)
 		clk_disable_unprepare(rtc->pclk);
-- 
2.29.1

