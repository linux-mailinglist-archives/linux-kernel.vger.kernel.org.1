Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF92A2B9156
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgKSLm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbgKSLmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:42 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DD8C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:41 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 1so6467566wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vI2JrcKgFTn0iKJdVDHi03drXi2TcqJyERbRZaifsU8=;
        b=dGKC6zvTc7FcB95UQX+uLV0Rf01hI32cRkRdIoQdk2wOJfkEem3vaDAOZp+cYxHzvJ
         rj0qEkrG/9mGqdWR8C0A9EKv9FulhZZnCeHsg925vl10QchpcLTAl7mzbg1jJsnb2ucl
         QaCW7H7uXYMPUp1LT5tKtGs/V1Fata5mD4qgm33lPyLXujuNROkwfoWRl5bXycjTTgAb
         WfRas+qFfoPcflfceFUr+iO/BrYiI+snYiob4ntT38NwsHGUQtjIMO5cSNiXEQlmE+vg
         Fef3wzNrU2/h5xjBgDE3Vo6mP8SWFfwjm4Sijc7+sWSS2VhVM1WswZZgd22TyBe6H4NS
         oaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vI2JrcKgFTn0iKJdVDHi03drXi2TcqJyERbRZaifsU8=;
        b=nPfqyErsS3D7XzgY9ePO8TkYVkVwz7RZo3DayDEF7U5/VvVX+p+j6HBIqimrmCKCkk
         uIPur1lfCljv7AE7IRjXPkE37geQvQ1AtSkUnd2fmfxsJMQ6rMpVqJa5QGBoHFmqrxXp
         mgzhvFR/18v/NATbbpE8n1TLSaF5SDsFOLsAApr2HVw6q9P2RJpmUkNBPPtzM2bnm+yj
         rIrVK1T8JQWxUtmEDS2tfL/aR/7HuTSt/EQr23W00QyKxHZyr6zWKkGfra9dGZnPGnM1
         TzlYu8vTA2Tcy9+zmkicAPM+c5Z2wF9s7jpepetR9LTju/oFU6SgrxQ0dvfGFWf75LxT
         sR3A==
X-Gm-Message-State: AOAM532GGT1bUgg6mkuFL93lVC+R4afiuh1iceopyg+4nuCunePjGF/a
        mf9/2I7wysbeQXpRQYl/QWWI7dvrH5hdRw==
X-Google-Smtp-Source: ABdhPJxZS4HSClTug++tlF9uML8NOkvt/AOXR0qLP0qJj75THEuKDXvYja/sHAaVGcGsezisp5yTXA==
X-Received: by 2002:a7b:c11a:: with SMTP id w26mr4302326wmi.78.1605786160286;
        Thu, 19 Nov 2020 03:42:40 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:39 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 34/59] rtc: max6900: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:41:24 +0100
Message-Id: <20201119114149.4117-35-brgl@bgdev.pl>
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
 drivers/rtc/rtc-max6900.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-max6900.c b/drivers/rtc/rtc-max6900.c
index ab60f13fa3ef..a3b0ed26a8c7 100644
--- a/drivers/rtc/rtc-max6900.c
+++ b/drivers/rtc/rtc-max6900.c
@@ -207,14 +207,14 @@ max6900_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
 
-	rtc = devm_rtc_device_register(&client->dev, max6900_driver.driver.name,
-					&max6900_rtc_ops, THIS_MODULE);
+	rtc = devm_rtc_allocate_device(&client->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
 
+	rtc->ops = &max6900_rtc_ops;
 	i2c_set_clientdata(client, rtc);
 
-	return 0;
+	return devm_rtc_register_device(rtc);
 }
 
 static const struct i2c_device_id max6900_id[] = {
-- 
2.29.1

