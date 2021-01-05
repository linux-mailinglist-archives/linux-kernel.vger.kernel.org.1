Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F692EAC36
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbhAENpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbhAENpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:45:30 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177A6C06179E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 05:44:30 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t16so36240039wra.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 05:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MXWwO3xQMpsZXQIjSZeQSg/sLrhlY0LSBGkxq2KXeMs=;
        b=qghb7Qegw2BRCYZjH32sXzyp9c3+eJc0vVu8Js8hrvKyMj2PjLP+g10K9+8yx8nP1J
         y/JWW/8u4HaIo5N6CpWEUBYHRfCX9jEL2Se+HKIdl5XV+iwRXcgkcaJ/KBXWud3iA10q
         mcRVC8dw03LVbdO1DM2L7nmIe301zmu8AEhE7s+brBqFS/2YfT4XI5j9/YAOz2H5JTwJ
         sM+E9rmONSyRN7rjXRAh9JP2ImmMQjE2rxm0g3fpLCnhZSsMi5LwPtuCExZmp/0Yg5VQ
         FN0V0OZiJciQTxKBZrQCufNgIBqHWwL4wE1f+kh9ETvn5qjoBI5pyV09kSA754eN9h+6
         P+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MXWwO3xQMpsZXQIjSZeQSg/sLrhlY0LSBGkxq2KXeMs=;
        b=suEOsTwP8zZKUN2wMOuHgpKhjgzcKk/8OdCp5omiZN5oiGXNh3I4XmHYeNH6EGtHIM
         WFQszmKc8yFR+6+wArIl4MulWwKt2fX+Gz40nUsI2rY9ls0prJ17o0WduJftQWZHikUW
         G1UAnJc/oDXYnH2bWUIunX9QMcx/vQbWoKh/vZQqg4I5gsuecH+1/tkWaxBYmFII5h+4
         nZLRMJ78+Bkg/BeU6rIXgugk6CW/mID95kVwQrw7a6XerhAZeAp0do1I8VnJsdvLIqci
         nrqFl/+yyxOuin2IGQIIMqekATHpVyLuuEo2eHdr4PJPzuP1GPhmgooJLXeXxHdDjkJN
         VRsg==
X-Gm-Message-State: AOAM530FqaZgeKkwUBra/VxzFMULG54JflnD7KhVJ8JWoMrpnPFoodDi
        Az+nQPgYhpvL5n22VP8FQwlwvQ==
X-Google-Smtp-Source: ABdhPJybClqZS9KiB1ynCk/1tI9yl/cX6elGdTHsSDJ5TqLRsPoeYtviJgcO2KLU+PiVPw3GoOxVhw==
X-Received: by 2002:a5d:4307:: with SMTP id h7mr85638796wrq.353.1609854268850;
        Tue, 05 Jan 2021 05:44:28 -0800 (PST)
Received: from localhost.localdomain (pop.92-184-112-247.mobile.abo.orange.fr. [92.184.112.247])
        by smtp.gmail.com with ESMTPSA id h9sm93873772wre.24.2021.01.05.05.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 05:44:28 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] rtc: s5m: use devm_i2c_new_dummy_device()
Date:   Tue,  5 Jan 2021 14:44:24 +0100
Message-Id: <20210105134424.30632-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the managed variant of i2c_new_dummy_device() to shrink code and
remove the goto label.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-s5m.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index eb9dde4095a9..3432c6213b4c 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -760,7 +760,8 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	info->i2c = i2c_new_dummy_device(s5m87xx->i2c->adapter, RTC_I2C_ADDR);
+	info->i2c = devm_i2c_new_dummy_device(&pdev->dev, s5m87xx->i2c->adapter,
+					      RTC_I2C_ADDR);
 	if (IS_ERR(info->i2c)) {
 		dev_err(&pdev->dev, "Failed to allocate I2C for RTC\n");
 		return PTR_ERR(info->i2c);
@@ -768,10 +769,9 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 
 	info->regmap = devm_regmap_init_i2c(info->i2c, regmap_cfg);
 	if (IS_ERR(info->regmap)) {
-		ret = PTR_ERR(info->regmap);
 		dev_err(&pdev->dev, "Failed to allocate RTC register map: %d\n",
-				ret);
-		goto err;
+			ret);
+		return PTR_ERR(info->regmap);
 	}
 
 	info->dev = &pdev->dev;
@@ -781,10 +781,9 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 	if (s5m87xx->irq_data) {
 		info->irq = regmap_irq_get_virq(s5m87xx->irq_data, alarm_irq);
 		if (info->irq <= 0) {
-			ret = -EINVAL;
 			dev_err(&pdev->dev, "Failed to get virtual IRQ %d\n",
 				alarm_irq);
-			goto err;
+			return -EINVAL;
 		}
 	}
 
@@ -797,10 +796,8 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 	info->rtc_dev = devm_rtc_device_register(&pdev->dev, "s5m-rtc",
 						 &s5m_rtc_ops, THIS_MODULE);
 
-	if (IS_ERR(info->rtc_dev)) {
-		ret = PTR_ERR(info->rtc_dev);
-		goto err;
-	}
+	if (IS_ERR(info->rtc_dev))
+		return PTR_ERR(info->rtc_dev);
 
 	if (!info->irq) {
 		dev_info(&pdev->dev, "Alarm IRQ not available\n");
@@ -813,15 +810,10 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
 			info->irq, ret);
-		goto err;
+		return ret;
 	}
 
 	return 0;
-
-err:
-	i2c_unregister_device(info->i2c);
-
-	return ret;
 }
 
 static int s5m_rtc_remove(struct platform_device *pdev)
-- 
2.29.1

