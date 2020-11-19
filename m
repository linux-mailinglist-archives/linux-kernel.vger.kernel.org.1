Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143AC2B91BB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgKSLqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgKSLm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:28 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33C2C061A4C
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:27 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id x13so647453wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5jLlhaqcjZtUi2XSYi/w3c6s2gmD9+AYyfxPfYRnm3E=;
        b=Ux7x83Hvqok64lXjzrgtvSNcvKlJb/xEIcGl/UpSxD/Lxm1kOELRKY3KJWFH6qlD4W
         +3bvT7jlboKDnk3ozw7C/h8ICi9M2yWpwdCzkIhm6KENsualakV05Dz6fO56TsTIU1Ru
         iLRZh5TV5ynl7WYr9RRgSuRnbpFS/rCVYMgg3vKu0tSYTjMYFFDqi8Hlri+Hap3zIrd0
         DcOFol25nt93simGqT1SBK6UexlutyiAG135UR4AJYAlGkIRony6ioFGWT71HFJma9Bj
         Ka0u1PoybbceFgdh0Aywgp7ecsLYhxGY/I3bWfGBaZh1dvWytuLiDmXOJUu6BacJ8XF1
         smxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5jLlhaqcjZtUi2XSYi/w3c6s2gmD9+AYyfxPfYRnm3E=;
        b=Oh62JDu4wWeAiEwFlx75mShpzvMsOXPlNXhyLrcJXE+7brDgPcPjlPv36/gIC2pBA/
         8UZwYO5L8KxW7QaXEyRivrXBPhfKoHiz0ZEBVub3DMSg3SBCH2p4hM2BIiOgzK5ctCZN
         zPXk5JaFskQh7lEuNjrC0z8xg6br7+K0Z5jzS9mbynuuXZjaFBIjPWA9LkdFTNM5gnY+
         LTxrG2qxdiBEXh3nV4RpwsJawoEVXtgOG3q91eVzf9C7Gq/wqZBjVT7MecSHl88av32l
         eIzsjk/Zx1TaYxyA1lOJ6GneYkMFopMlWmscvlkzkpAgzd5CZF+120nPnnUFkXSY+e7M
         HFcw==
X-Gm-Message-State: AOAM531HPp3zSWvkOp4UeLPvFoghyCOPfDm98tmcYiSUMtqt7jNz5Ph3
        RP3dq2HDnB6GpTBIgKB2YH+9Mg==
X-Google-Smtp-Source: ABdhPJyUZMPLjwLOcYLytwviNJziftjWzxUVU8DFUJPMmDOJOZb1ykeDdsqkz+FmdWXDPT2A2Ri1GA==
X-Received: by 2002:a05:600c:2886:: with SMTP id g6mr4162962wmd.110.1605786146518;
        Thu, 19 Nov 2020 03:42:26 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:26 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 21/59] rtc: s5m: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:11 +0100
Message-Id: <20201119114149.4117-22-brgl@bgdev.pl>
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
 drivers/rtc/rtc-s5m.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 3432c6213b4c..0ddd3f445943 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -793,27 +793,27 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	info->rtc_dev = devm_rtc_device_register(&pdev->dev, "s5m-rtc",
-						 &s5m_rtc_ops, THIS_MODULE);
-
+	info->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(info->rtc_dev))
 		return PTR_ERR(info->rtc_dev);
 
-	if (!info->irq) {
-		dev_info(&pdev->dev, "Alarm IRQ not available\n");
-		return 0;
-	}
+	info->rtc_dev->ops = &s5m_rtc_ops;
 
-	ret = devm_request_threaded_irq(&pdev->dev, info->irq, NULL,
-					s5m_rtc_alarm_irq, 0, "rtc-alarm0",
-					info);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
-			info->irq, ret);
-		return ret;
+	if (info->irq) {
+		ret = devm_request_threaded_irq(&pdev->dev, info->irq, NULL,
+						s5m_rtc_alarm_irq, 0,
+						"rtc-alarm0", info);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"Failed to request alarm IRQ: %d: %d\n",
+				info->irq, ret);
+			return ret;
+		}
+	} else {
+		dev_info(&pdev->dev, "Alarm IRQ not available\n");
 	}
 
-	return 0;
+	return devm_rtc_register_device(info->rtc_dev);
 }
 
 static int s5m_rtc_remove(struct platform_device *pdev)
-- 
2.29.1

