Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781502B91C7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgKSLrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbgKSLmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:22 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6BBC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:20 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a186so4088872wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L3ryhnGewnr7eIys3VmJIaYRSd1ecA5Vwy/85+rKgRk=;
        b=Ob4aZfkgftWW3q5gZo5TeySgxImkZofRZ9hhpb5ZLAtOo2sLxuZRW6Zw4TVCM95Db5
         HSwITU4KUZjyqOxkQi9tfGfZSPVwN3C/qPNQl9WOIVxEP9LEfQmR5KJvhAOKc8Mro639
         Bz+o+PMskNIZHEW6f60UPDkvEU4TGIpKH0L4bJVsWCVfUjWF58JyZDDIeHneehN28VcE
         JUPcgY49vQKfPO9bCLYXBsV/8fTDPg+u5qy70iE6+InL/QvftneUgnF73mIa0AdeXGN9
         gl45rvpUkcJmmwmHMBbCsHcs0QeLni11l1WFzqy5miaCmefu9GPAynbBHdLxPzQfN9ys
         aq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L3ryhnGewnr7eIys3VmJIaYRSd1ecA5Vwy/85+rKgRk=;
        b=oLGws9uHfRyP/DYMiWEzAfle0OhEUtjXYGSxcyHpDwXj2FJpbcVXFXIfbU411Hr1+C
         1YvNR3C88Rz8ME45vhEBGKfp/Yj0MfG7GF3HuW1PSzdo1ajmzkALTSukmTTui6n1mLR6
         +xk2QJN7EiS7RnX60sjnHPV5LvrMlvzOwul/81/T4A15jKxC3u84AVp6XT3ZaOlJ/on/
         GRHMosPK2mWS0txme2mF8PjZN9cm1BdKkVifErSpH+xQmTU57lUVpDFh+9T/UwYRCE1d
         KOwcvMol7L1Mrs7wACGLGbnBBBbQHAvgR1uJQjiA6XiUZ0ZeggkxlIMFS6qCcuX2CKWD
         S2SQ==
X-Gm-Message-State: AOAM533fuRO3xpuDf9PM1yCA6smhGMurFh9pmpfsdrUUUQ1pC+zrejYd
        sAf4k5BAko3UkA04wTMsuutRxg==
X-Google-Smtp-Source: ABdhPJwPrLHDdDhh3WWCXMOaMD7C0O0sl/Qr+t6lZmvz3NSXZOTFB3Kk17GC2BPYxFnXhN+EpQc09w==
X-Received: by 2002:a1c:4055:: with SMTP id n82mr4437760wma.68.1605786139329;
        Thu, 19 Nov 2020 03:42:19 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:18 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 14/59] rtc: max8925: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:04 +0100
Message-Id: <20201119114149.4117-15-brgl@bgdev.pl>
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
 drivers/rtc/rtc-max8925.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-max8925.c b/drivers/rtc/rtc-max8925.c
index 64bb8ac6ef62..902403d2fb59 100644
--- a/drivers/rtc/rtc-max8925.c
+++ b/drivers/rtc/rtc-max8925.c
@@ -272,15 +272,13 @@ static int max8925_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	info->rtc_dev = devm_rtc_device_register(&pdev->dev, "max8925-rtc",
-					&max8925_rtc_ops, THIS_MODULE);
-	ret = PTR_ERR(info->rtc_dev);
-	if (IS_ERR(info->rtc_dev)) {
-		dev_err(&pdev->dev, "Failed to register RTC device: %d\n", ret);
-		return ret;
-	}
+	info->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(info->rtc_dev))
+		return PTR_ERR(info->rtc_dev);
 
-	return 0;
+	info->rtc_dev->ops = &max8925_rtc_ops;
+
+	return devm_rtc_register_device(info->rtc_dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.29.1

