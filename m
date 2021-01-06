Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE152EBC2F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 11:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbhAFKMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 05:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbhAFKMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 05:12:19 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87996C06134D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 02:11:39 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r3so1907615wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 02:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o0MmhDNA3JbSjnUwo4vbVyBUWMBScjtNa0FqK3mxVOs=;
        b=TLaT5tZspuVGJZFrMHC8bGl0qbSPO+ECMvHJ4TiDeg1q3v+PceZlD+8SPNhsysjBgk
         tBBRgoiXtApQIJCJ58HMcbM/XYmcMtFNoxP8ZHnRTZkutvAzI7aC4XV8hjWDuBw6tSm/
         TFhRoJ6uQxzrSJkhfBIjt+O3JsAh7PSY8SgUbN8gP8nWHcOp/uRcJrfcPTVRiBr9sMKe
         xZaN8cP9LJFbTTBVB7ZUudgGUNTaM+u1l7q7Kq2tMgh5wszhD6NuPMHnucvv+lXlTTwa
         zExSc9YfK5BD1Kk5r0B26T/9YW8Tr3SmHWwNkL6ZN3DnryVhPo11nkhsnR3DdtBEWd7L
         bwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o0MmhDNA3JbSjnUwo4vbVyBUWMBScjtNa0FqK3mxVOs=;
        b=QPZ8L2jLhIbRKu2x/muqlEdgO4hpYOLh3aTXtwtZzFI5Gpp8vhYIJaIVT/uBuVRDn5
         aATgzf0TCMk9aoTd+p1ptUL8tOC7yUfJkhQKhxP92lHh33azho5ZVcADeuWv2fiMxZ3O
         IBwxiwmH46XD6CmJxTMqECx/mQVqrwweuknTUClPdADDu9E0qxbCV/UXeht5Y9O6jfWQ
         OVvoK4TRVacHRWCubrvQGO3uQaFZ8TpbCx5AgK2/Bp1eVJ9GfoC/uALmyeevBqiwtnak
         w9M59DAPdyhA8TphqFsM4wlNOPYRpdDn4+MJrzHPoOKEscRsCS2ogP2C7eNfPUZMY4lF
         Q1hw==
X-Gm-Message-State: AOAM530JZxppUa0Ixm+0FqUO2ksCWuIqqSGOZxX+LfUp4j21AfzqFC9K
        tWaPmEnWapbWfLsrp2zGKE8JIg==
X-Google-Smtp-Source: ABdhPJw8NVN0Lxgf38SkFphNspwZgDglPoduNDrlf19AVkDO02vMAf1eEWYq48lSM6zhqccjQaleWg==
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr3417456wru.321.1609927898267;
        Wed, 06 Jan 2021 02:11:38 -0800 (PST)
Received: from localhost.localdomain (pop.92-184-102-148.mobile.abo.orange.fr. [92.184.102.148])
        by smtp.gmail.com with ESMTPSA id r16sm2635656wrx.36.2021.01.06.02.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 02:11:37 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-power@fi.rohmeurope.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] gpio: bd7xxxx: use helper variable for pdev->dev
Date:   Wed,  6 Jan 2021 11:11:33 +0100
Message-Id: <20210106101133.18379-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Using a helper local variable to store the address of &pdev->dev adds
to readability and allows us to avoid unnecessary line breaks.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-bd70528.c | 17 ++++++++---------
 drivers/gpio/gpio-bd71828.c | 15 +++++++--------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpio-bd70528.c b/drivers/gpio/gpio-bd70528.c
index 276a0fe6346d..397a50d6bc65 100644
--- a/drivers/gpio/gpio-bd70528.c
+++ b/drivers/gpio/gpio-bd70528.c
@@ -181,15 +181,15 @@ static int bd70528_gpio_get(struct gpio_chip *chip, unsigned int offset)
 
 static int bd70528_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct bd70528_gpio *bdgpio;
 	int ret;
 
-	bdgpio = devm_kzalloc(&pdev->dev, sizeof(*bdgpio),
-			      GFP_KERNEL);
+	bdgpio = devm_kzalloc(dev, sizeof(*bdgpio), GFP_KERNEL);
 	if (!bdgpio)
 		return -ENOMEM;
-	bdgpio->dev = &pdev->dev;
-	bdgpio->gpio.parent = pdev->dev.parent;
+	bdgpio->dev = dev;
+	bdgpio->gpio.parent = dev->parent;
 	bdgpio->gpio.label = "bd70528-gpio";
 	bdgpio->gpio.owner = THIS_MODULE;
 	bdgpio->gpio.get_direction = bd70528_get_direction;
@@ -202,16 +202,15 @@ static int bd70528_probe(struct platform_device *pdev)
 	bdgpio->gpio.ngpio = 4;
 	bdgpio->gpio.base = -1;
 #ifdef CONFIG_OF_GPIO
-	bdgpio->gpio.of_node = pdev->dev.parent->of_node;
+	bdgpio->gpio.of_node = dev->parent->of_node;
 #endif
-	bdgpio->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	bdgpio->regmap = dev_get_regmap(dev->parent, NULL);
 	if (!bdgpio->regmap)
 		return -ENODEV;
 
-	ret = devm_gpiochip_add_data(&pdev->dev, &bdgpio->gpio,
-				     bdgpio);
+	ret = devm_gpiochip_add_data(dev, &bdgpio->gpio, bdgpio);
 	if (ret)
-		dev_err(&pdev->dev, "gpio_init: Failed to add bd70528-gpio\n");
+		dev_err(dev, "gpio_init: Failed to add bd70528-gpio\n");
 
 	return ret;
 }
diff --git a/drivers/gpio/gpio-bd71828.c b/drivers/gpio/gpio-bd71828.c
index fcdcbb57c76d..c8e382b53f2f 100644
--- a/drivers/gpio/gpio-bd71828.c
+++ b/drivers/gpio/gpio-bd71828.c
@@ -97,15 +97,15 @@ static int bd71828_get_direction(struct gpio_chip *chip, unsigned int offset)
 
 static int bd71828_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct bd71828_gpio *bdgpio;
 
-	bdgpio = devm_kzalloc(&pdev->dev, sizeof(*bdgpio),
-			      GFP_KERNEL);
+	bdgpio = devm_kzalloc(dev, sizeof(*bdgpio), GFP_KERNEL);
 	if (!bdgpio)
 		return -ENOMEM;
 
-	bdgpio->dev = &pdev->dev;
-	bdgpio->gpio.parent = pdev->dev.parent;
+	bdgpio->dev = dev;
+	bdgpio->gpio.parent = dev->parent;
 	bdgpio->gpio.label = "bd71828-gpio";
 	bdgpio->gpio.owner = THIS_MODULE;
 	bdgpio->gpio.get_direction = bd71828_get_direction;
@@ -121,13 +121,12 @@ static int bd71828_probe(struct platform_device *pdev)
 	 * "gpio-reserved-ranges" and exclude them from control
 	 */
 	bdgpio->gpio.ngpio = 4;
-	bdgpio->gpio.of_node = pdev->dev.parent->of_node;
-	bdgpio->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	bdgpio->gpio.of_node = dev->parent->of_node;
+	bdgpio->regmap = dev_get_regmap(dev->parent, NULL);
 	if (!bdgpio->regmap)
 		return -ENODEV;
 
-	return devm_gpiochip_add_data(&pdev->dev, &bdgpio->gpio,
-				     bdgpio);
+	return devm_gpiochip_add_data(dev, &bdgpio->gpio, bdgpio);
 }
 
 static struct platform_driver bd71828_gpio = {
-- 
2.29.1

