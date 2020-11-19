Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A812B91DE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgKSLs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgKSLmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:09 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41D9C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:08 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 23so6074452wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oX6wcEul0SQXqQ5wOdLLxVTiARQ/rjlnKPOtwZUU778=;
        b=MtxraTQbcoCHWmLJQyRoIvqY9Xj23wL7HcHLDHXZuNMe7+62TC6IRHwBTzoUVV3sC+
         G0pR2P1t369D1KaL/rwNkbiEivfy1YwSmkCmoXJxwZJ1Ibyo+d7AmHPxvSGX9x/pXS8B
         WhYCFWCHuoU8eMXCkneT0OFaO6R5VK5EqsW6iw1AE7tsXaGQvRw+bjsFqVtOBHG70oT3
         mPmP6kBbCysG6IuB1l5veomQtxfEr3eQdeUKCsdtWmgSSmtUH+Ale9FcYxaTVY8LMiyU
         //Q8MS/q5ncZs1DoVmBeeQiVOHs5AvoYLREppR+XXkzsyPgMTw0JMqMOaNvyHbs7uIUa
         QK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oX6wcEul0SQXqQ5wOdLLxVTiARQ/rjlnKPOtwZUU778=;
        b=eU3yMwrme+33livhvLt859uleOQghmp3fxyWVoBT+agQbEjK+mBJqFQZCXeNMP7AMK
         jhHgQBht3SXv5a87J1mrRpXxsfJmxEZlCecJdpvDOp5yIOTWr0K6a0ZAXhwirsN99gtO
         dkYR/GbSvBbyRPrhUON7rxVcc2rBrEEv/lpxiWLoLOFq5uhXMyhJoDDxvrNayp3Si/Ak
         28EfGGdPwmWvfyL9nbE6c7ONzIxXWk/6pb2zTsHVFpr3hPDlosII6hmQ3TMt6Y8GmzLY
         nsoBQOinUq8E347q38gz2+atIqElp/F2iBysxu7oO4JxVYfSP8KY0uCLGp6vz6jAxuGf
         JxBg==
X-Gm-Message-State: AOAM530cyXPuw3xQyEcln4CWWLzAzvGNnILblDQYl0T5cuI0Xic3iTIi
        ZU0wAa+wA2LufjM6sy8UB5J2EQ==
X-Google-Smtp-Source: ABdhPJxEVDtM6HCbx8sZhEgbkPJ+ircYzKu6MDGjggNxNR5EU77JaJRWe2KO8BR0V/65PuDgtfoMqQ==
X-Received: by 2002:adf:f441:: with SMTP id f1mr9752545wrp.225.1605786127656;
        Thu, 19 Nov 2020 03:42:07 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id u23sm9745178wmc.32.2020.11.19.03.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:42:07 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 03/59] rtc: ds1390: stop using deprecated RTC API
Date:   Thu, 19 Nov 2020 12:40:53 +0100
Message-Id: <20201119114149.4117-4-brgl@bgdev.pl>
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
 drivers/rtc/rtc-ds1390.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-ds1390.c b/drivers/rtc/rtc-ds1390.c
index 66fc8617d07e..9e4d09eac323 100644
--- a/drivers/rtc/rtc-ds1390.c
+++ b/drivers/rtc/rtc-ds1390.c
@@ -203,14 +203,13 @@ static int ds1390_probe(struct spi_device *spi)
 	if (spi->dev.of_node)
 		ds1390_trickle_of_init(spi);
 
-	chip->rtc = devm_rtc_device_register(&spi->dev, "ds1390",
-					&ds1390_rtc_ops, THIS_MODULE);
-	if (IS_ERR(chip->rtc)) {
-		dev_err(&spi->dev, "unable to register device\n");
-		res = PTR_ERR(chip->rtc);
-	}
+	chip->rtc = devm_rtc_allocate_device(&spi->dev);
+	if (IS_ERR(chip->rtc))
+		return PTR_ERR(chip->rtc);
+
+	chip->rtc->ops = &ds1390_rtc_ops;
 
-	return res;
+	return devm_rtc_register_device(chip->rtc);
 }
 
 static const struct of_device_id ds1390_of_match[] = {
-- 
2.29.1

