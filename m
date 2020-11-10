Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BB12AD967
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbgKJO43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731550AbgKJO4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:56:14 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453ABC061A04
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:56:14 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 23so2175634wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IQh6Jo5zoHL7/3I5hGMlwjltjV3kz9H+4fZOBa3eDu8=;
        b=dHlBKlolnhqDQUiW04dQgyoqrmqH4sPOBeDpM+s/gEPkY9Fd552NUSYcptJJCPHOk7
         ak6DPDgZ5pgdVJQ/LlxjCMqrETWDnz1Y7QPIM/e/6v1f06k3U9v/uRj+QnuruoU8yik6
         PE22kni59Wt8ooHuvyLlSYaG2BA1AzVYuV/k9Msd3cXyFcO36UvvKC2iJ93qmhYZqJ8c
         u/d3Hzxfa9QaHfJENsmfkiN5nWIPx8HU88R5Adok4gUIHTbKghxsZyS2DjR8iotznRqN
         iXawjQznG4Enn1JEOuPZnXvZiPQeqfJvKZYeFkGdYYOfFiSgCy0b7A9tV7fkCBnfwsgV
         WUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IQh6Jo5zoHL7/3I5hGMlwjltjV3kz9H+4fZOBa3eDu8=;
        b=OTpUblq3hCXWDR0/NIPjMrDs3wT1upan+FOXqQIblr//bv5xiS8jsYRsDyNMkb9WM1
         MbyacA1DWp7mozM/9XPA0A/d+csy2Jv/zHFu4CEvL5J+BxxOUFUE2aNHoeeklg3tE/UH
         vYojJWvyU7kZnya3YZ7Fhsity05vMsTOaastJTYa5ndoRy4ry2StGAowMj94InMlpbvL
         LfPWA6lnul8sIqBkUoheWu6Esn1B85+uT7LSlyEVLMnpq5581QLRsVwnV+EqGHiQBqfK
         L+yPix6v2eMmRVNMpR8TB82dT2GoQ6K4e6bQ9r2Zvjjr7Xn8XZoOYCy5RwINHt/vFWOt
         562A==
X-Gm-Message-State: AOAM533T8/0LDDE6LhUSEF4rmJeYivIMJeZ0FbA0tyaggKHXVFbb95zE
        5+BFVC10H/tyz1Vgh4pNrKtxCQ==
X-Google-Smtp-Source: ABdhPJzHAt9kZO/l5er2IvaDzk5nsY8wRTuZO4a5c5akLJXdSs7Q4ajjgdyStZuZs6jxse0ZVMn6lg==
X-Received: by 2002:a1c:9e12:: with SMTP id h18mr42650wme.11.1605020173067;
        Tue, 10 Nov 2020 06:56:13 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id f17sm3261827wmf.41.2020.11.10.06.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 06:56:12 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        David Laight <David.Laight@aculab.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 7/7] gpio: exar: use devm action for freeing the IDA and drop remove()
Date:   Tue, 10 Nov 2020 15:55:52 +0100
Message-Id: <20201110145552.23024-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201110145552.23024-1-brgl@bgdev.pl>
References: <20201110145552.23024-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We can simplify the error path in probe() and drop remove() entirely if
we provide a devm action for freeing the device ID.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-exar.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index 2fdca872c7c0..d37de78247a6 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -111,6 +111,13 @@ static int exar_direction_input(struct gpio_chip *chip, unsigned int offset)
 	return 0;
 }
 
+static void exar_devm_ida_free(void *data)
+{
+	struct exar_gpio_chip *exar_gpio = data;
+
+	ida_free(&ida_index, exar_gpio->index);
+}
+
 static const struct regmap_config exar_regmap_config = {
 	.name		= "exar-gpio",
 	.reg_bits	= 16,
@@ -158,6 +165,10 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	if (index < 0)
 		return index;
 
+	ret = devm_add_action_or_reset(dev, exar_devm_ida_free, exar_gpio);
+	if (ret)
+		return ret;
+
 	sprintf(exar_gpio->name, "exar_gpio%d", index);
 	exar_gpio->gpio_chip.label = exar_gpio->name;
 	exar_gpio->gpio_chip.parent = dev;
@@ -173,29 +184,15 @@ static int gpio_exar_probe(struct platform_device *pdev)
 
 	ret = devm_gpiochip_add_data(dev, &exar_gpio->gpio_chip, exar_gpio);
 	if (ret)
-		goto err_destroy;
+		return ret;
 
 	platform_set_drvdata(pdev, exar_gpio);
 
-	return 0;
-
-err_destroy:
-	ida_free(&ida_index, index);
-	return ret;
-}
-
-static int gpio_exar_remove(struct platform_device *pdev)
-{
-	struct exar_gpio_chip *exar_gpio = platform_get_drvdata(pdev);
-
-	ida_free(&ida_index, exar_gpio->index);
-
 	return 0;
 }
 
 static struct platform_driver gpio_exar_driver = {
 	.probe	= gpio_exar_probe,
-	.remove	= gpio_exar_remove,
 	.driver	= {
 		.name = DRIVER_NAME,
 	},
-- 
2.29.1

