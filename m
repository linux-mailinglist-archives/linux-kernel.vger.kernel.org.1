Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064DD2AD985
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732602AbgKJO5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731348AbgKJO4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:56:12 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDC1C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:56:10 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h62so3275682wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PfaggvFtdrOq7HMZ8nUir6KiglSCvEmyQ3kUEaGT+6M=;
        b=oH8PSeyxv2g2mkm6KifL0XdKT+rnspnOhbMzDwnzQm+pMPh1hvK7EOwAMzac79SqZK
         02bezL3Z26b5Y1QQInMat2eNtle5JTjAlMPuOmYYL9tIDPn8i/wV0kU/a76NDy1hQkYb
         i8OAz2nc+GlPheoFPrE3frOE7yBA/OWej0UIrmeftDJdeDPE6z5ldKOHMS319H2Xcp4S
         6Vrzkze/jhidKVPQpXUgmzS6ZAsFrfPzEHRLnVuBLTm/sR9bFvw9bxLF+imueoV1cy6i
         azs3f+c6EFu7MuIdUFVfMfdCndE6lYwqZdGE5oIg89LV8RIst4wl68eLeWZYMrvZzTkx
         nImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PfaggvFtdrOq7HMZ8nUir6KiglSCvEmyQ3kUEaGT+6M=;
        b=lPIwoq7HYYKEAsXyFdxR9tLqn6G8TAiFtp88l1gRiCmoouOcftzS0iPn7rMB82oWnN
         BO8KGP3UJ61+L7kVnvfKSyCSUAnW8Hj/6F2Mqh/mJDtnpLApEmGK/5IEpr3QX8xMURC5
         pXg1170Pk+jA5QM8IdSP2yVE6oVyXkHivgSizl5rG8ww/E9tfWGYpgPl94Y6BTGKCm9S
         j5uu6fY9B29ZZK0Q+F+ZdIr3Qc1f09qAkvkcypibS68m8cWr2yNHKU+Hez6hu51WSZvQ
         e2ZJvrEX5dIlqKiTFOuj8T8wY994uKwW4Q16FKRA1l8Nax99d/f5j15GbrxN3m2iY/JK
         ++kQ==
X-Gm-Message-State: AOAM533kXTWBe5yFMWQZqId+nEdecDH1H9e5CEsLlaOvtPfPYG504WLd
        BbHfL6PO0Ae8hDSZw7fIIRo/iA==
X-Google-Smtp-Source: ABdhPJw59JjHRG83+v/lXqJnyd7wHgrv1ByRW6rnrf5bN06bCOwu6mtyTnRWQB6aq876+beC9tOOPQ==
X-Received: by 2002:a1c:87:: with SMTP id 129mr87959wma.34.1605020169728;
        Tue, 10 Nov 2020 06:56:09 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id f17sm3261827wmf.41.2020.11.10.06.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 06:56:09 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        David Laight <David.Laight@aculab.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 4/7] gpio: exar: use a helper variable for &pdev->dev
Date:   Tue, 10 Nov 2020 15:55:49 +0100
Message-Id: <20201110145552.23024-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201110145552.23024-1-brgl@bgdev.pl>
References: <20201110145552.23024-1-brgl@bgdev.pl>
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

