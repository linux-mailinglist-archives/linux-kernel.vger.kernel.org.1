Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEF6298F00
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1776602AbgJZOTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:19:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39071 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781113AbgJZOS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:18:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id y12so12771995wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 07:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PfaggvFtdrOq7HMZ8nUir6KiglSCvEmyQ3kUEaGT+6M=;
        b=YAWhsTanq/1g+up13sBNiIpkFwByGGbKUZyad3NsIgJ7Z2tft8n7yZEV8KEen/1bzh
         wlb14wfGYsh21vjIY/7eTpZBB8ikjYnQc8atuAxqLcgScx3GkxtSS0nNcyvL59UYi+Cv
         4R4pJTkh3qp22yFUj48kUpvSfRVEwiBE7LHSIyOgq5+xr8yYzAoQNNLLUGSctBAX5bBG
         9GkhX3dJwRfaPm79/AluWfEHdgHYEcfdH5UyTC1hYCzUEV7dKYjt/VOSRL9ItJMAwvVG
         Cayw2v3z4nTa6FdmznzkJ7UZi5KV0TNWXr/PzaXONwGPZ/1XeDQArriv+dyFAY+D9e6a
         D6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PfaggvFtdrOq7HMZ8nUir6KiglSCvEmyQ3kUEaGT+6M=;
        b=YxoBJHLvmke81CtbXkWPEDagdrPujx2haLxmGP6Hjoa8ztgC5BS7xtffAl/Ip6e7Ev
         f6o8RpcrlMQx541ZLM6+Gxawa/DaErJ/fZTNophmJ1KrhpigC2WvUQmPjJSsxYjZQ/jh
         ja3qzrVdWwlBQ/NaXhROJFOrliFwUMp8wXGniaYF9zHiKttPM08sBPl/au4gfD90oC5u
         PhjRpodkqZhdO1UWSzysLpPOQdeJg4DsCi0exU9zQi58eRGl9kQ1MKnYjeQ7rWSO3X7P
         LJTFSiKEosNhA/Tl60Boskbk1kd88v1QEz8zEV29jMfuYB3twGiYED0Pta60fFZlrslo
         LKUg==
X-Gm-Message-State: AOAM531TTmnJylb/ftzks2y5UwLt5iu2f8hkm9KJh4qDAme4vIjMB1tt
        mABuwqukVPee6jpmSl516iCTHQ==
X-Google-Smtp-Source: ABdhPJwoPOaWPitDMZQa4yCzAq/8OszWEHAj5/I4X2rm1V6T/IkG87/TkyaXzgLiAyfIvpOwqCba/w==
X-Received: by 2002:adf:93c1:: with SMTP id 59mr17886759wrp.369.1603721934172;
        Mon, 26 Oct 2020 07:18:54 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id e15sm21920841wro.13.2020.10.26.07.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 07:18:53 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4/7] gpio: exar: use a helper variable for &pdev->dev
Date:   Mon, 26 Oct 2020 15:18:36 +0100
Message-Id: <20201026141839.28536-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201026141839.28536-1-brgl@bgdev.pl>
References: <20201026141839.28536-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

It's more elegant to use a helper local variable to store the address
of the underlying struct device than to dereference pdev everywhere. It
also has the benefit of avoiding unnecessary line breaks.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-exar.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index 752e8437ff80..db366d85b6b4 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -120,7 +120,8 @@ static int exar_direction_input(struct gpio_chip *chip, unsigned int offset)
 
 static int gpio_exar_probe(struct platform_device *pdev)
 {
-	struct pci_dev *pcidev = to_pci_dev(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct pci_dev *pcidev = to_pci_dev(dev->parent);
 	struct exar_gpio_chip *exar_gpio;
 	u32 first_pin, ngpios;
 	void __iomem *p;
@@ -134,16 +135,15 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	if (!p)
 		return -ENOMEM;
 
-	ret = device_property_read_u32(&pdev->dev, "exar,first-pin",
-				       &first_pin);
+	ret = device_property_read_u32(dev, "exar,first-pin", &first_pin);
 	if (ret)
 		return ret;
 
-	ret = device_property_read_u32(&pdev->dev, "ngpios", &ngpios);
+	ret = device_property_read_u32(dev, "ngpios", &ngpios);
 	if (ret)
 		return ret;
 
-	exar_gpio = devm_kzalloc(&pdev->dev, sizeof(*exar_gpio), GFP_KERNEL);
+	exar_gpio = devm_kzalloc(dev, sizeof(*exar_gpio), GFP_KERNEL);
 	if (!exar_gpio)
 		return -ENOMEM;
 
@@ -157,7 +157,7 @@ static int gpio_exar_probe(struct platform_device *pdev)
 
 	sprintf(exar_gpio->name, "exar_gpio%d", index);
 	exar_gpio->gpio_chip.label = exar_gpio->name;
-	exar_gpio->gpio_chip.parent = &pdev->dev;
+	exar_gpio->gpio_chip.parent = dev;
 	exar_gpio->gpio_chip.direction_output = exar_direction_output;
 	exar_gpio->gpio_chip.direction_input = exar_direction_input;
 	exar_gpio->gpio_chip.get_direction = exar_get_direction;
@@ -169,8 +169,7 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	exar_gpio->index = index;
 	exar_gpio->first_pin = first_pin;
 
-	ret = devm_gpiochip_add_data(&pdev->dev,
-				     &exar_gpio->gpio_chip, exar_gpio);
+	ret = devm_gpiochip_add_data(dev, &exar_gpio->gpio_chip, exar_gpio);
 	if (ret)
 		goto err_destroy;
 
-- 
2.29.1

