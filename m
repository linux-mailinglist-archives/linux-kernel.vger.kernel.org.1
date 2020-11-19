Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9062B91A7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgKSLqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgKSLmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:36 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256C6C061A55
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:36 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so6110707wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7sFDBY8NFgSrBPGsM8ew5WsVZCDINYo4g5kLDPAfJkA=;
        b=xGfLs4mxK02lPzqm4ffl9a/3ufy3xjEIpiUoNEr8ckaxb4uvNujPSMZ3jRcz0ZfS+L
         0xGvS29d0nmsqW7nwx4YHxb7+iTChnZ/6epkYTs2dcUSPiLA5ZaCEgdMejkd1uStYz4G
         NtJvWJufOllHIhj6NtBB+DoZPM27pW4uQmrdzyOM557LCqm26vcKu2cog8IWMRo1TdZy
         4xe0n6oMrUE4gvrmN8I6yGZkWRIy3uhCbG4Z8Nabxcj5I6wYLQKjiG2hHDjNJav71rKl
         4HOO0owb15MDiwLVlowYQK52JM+tjadwfCEBFNBX+jk+7/OC+gFFSpdqxfJtUhrxIkUE
         LHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7sFDBY8NFgSrBPGsM8ew5WsVZCDINYo4g5kLDPAfJkA=;
        b=Stc3E4zkhQS9QUr8CJRT0el18tvZxgFJ+KApcB+3D+eMfho4IJOGqgpTVTm0HRSINE
         kTZyfFhWjFbECE/iHxy9+EyzRCiYsgQ3zBjKe0SHJcPfUFiilXQsY/VHA2ak0UZboQ7m
         h8CLmfvLdPgYrTOr3M+BEpGyo28+1fUybJhB9IQbznAaYCvYay74pZBkA2ZVC8SqkJBv
         o6W/jbgW7BUPT0rpn4V8TRyG8XA9MOtCPZIkVRb0ZQTNSTY7GhLttE65v3gFt8j5gaOS
         otGfFNpBxs7KHHZdEwZ2VrPHlwilXAGiuGs0UhvYHLoqjPHH0QGGuqqo5zq7b9sfw92n
         7wOQ==
X-Gm-Message-State: AOAM532CsQoB9z6PBUIvY6KAoJkwioy81/h0bb3/NPnbPgumTWFTGloZ
        eOyO3SWZe6WLl9iDSB5x1HnsUA==
X-Google-Smtp-Source: ABdhPJz7K6S0S8ROxnWt2UPE0HSB4dVL+thFLdrmlwHeP3lzjSdR5hBs7C71543UM65c+AR44AhuUA==
X-Received: by 2002:adf:f246:: with SMTP id b6mr9310634wrp.238.1605786154980;
        Thu, 19 Nov 2020 03:42:34 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:34 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 29/59] rtc: twl: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:19 +0100
Message-Id: <20201119114149.4117-30-brgl@bgdev.pl>
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
 drivers/rtc/rtc-twl.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index c24d1e18f56c..5caf8900b6cd 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -562,13 +562,11 @@ static int twl_rtc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, twl_rtc);
 	device_init_wakeup(&pdev->dev, 1);
 
-	twl_rtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-					&twl_rtc_ops, THIS_MODULE);
-	if (IS_ERR(twl_rtc->rtc)) {
-		dev_err(&pdev->dev, "can't register RTC device, err %ld\n",
-			PTR_ERR(twl_rtc->rtc));
+	twl_rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(twl_rtc->rtc))
 		return PTR_ERR(twl_rtc->rtc);
-	}
+
+	twl_rtc->rtc->ops = &twl_rtc_ops;
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					twl_rtc_interrupt,
@@ -579,7 +577,7 @@ static int twl_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return 0;
+	return devm_rtc_register_device(twl_rtc->rtc);
 }
 
 /*
-- 
2.29.1

