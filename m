Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA6E2A6DF1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbgKDTbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731548AbgKDTbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:31:06 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B586C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:31:05 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 33so12506969wrl.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SyfsPFMi1Ol5bHDdeg25EiAHS6gH8P7QyAg8QmJ1Sho=;
        b=oji3YSQN0WvH6hSwnCdoH+Q3Da9CXUQwMm1VLJ1RaK1rHoeYeRpu1xM7QlPvyUS2UX
         zG7bFYiqklzWXlzX3lNBWhR6iDfnEPCH7EgUJTzuKQhThjLlx0Q/iiVTbWN99lLn3q8Y
         DgL7ZjUnnrWM98w1NnBplb8qdRxFNg06PBVYjIClricuAnRgAtylBs0jNhoydweSAGGP
         gEcSoyuUM4R0jlkA8FO6O/GgEsi88htn3ejCJ3/ieMmOwQuI6EQwKQvTXNJCfFittQGl
         f/tb7cAnU3H6ff/kt17ewinFRlTJogsRzVofi3heGGnbKlH+aEOSzBG5oLJApG1bvvkA
         Bhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyfsPFMi1Ol5bHDdeg25EiAHS6gH8P7QyAg8QmJ1Sho=;
        b=cFnH4H9+S4konNLvEpFqKwtqkKxBsLQu/ugFQziaOCkCflp57upkIA9DadD+uFlemi
         tldMC5YQSFmv/wzbWuLn7pXUf0gfB4+lN2sBTfnRl7ntbIWOBQE2+age+5r4xKR3z4od
         qYKAkUrMbEbMnXnGe/JjW5GhTNfRsXZ8EgonZMioJlH2ADRBAD0U5Zx10xX+mBZEw/ry
         YoogA4Du2zQpR+5GTbk0fOdTr0EDAdH6BVtDxi1TssAU34JNIxyVEfrJ8eyKjLnRIUta
         q5Fbsaa0Imd1GA+R4R70SVZSmoZ6QgdUk1VpyiYhm9+gbi61MsvApiBVxtxaj5NnSdE9
         SQjQ==
X-Gm-Message-State: AOAM532A8usXc4VF2u6Amno2meYmL/bRqawcRzd10fMC7auUiW360fAG
        Quhs3HfZFzNgCkgQU6R2zkuC9g==
X-Google-Smtp-Source: ABdhPJzkirtxNi2CRcNJeilD4kxMLO1YF0VjZBrbmGbH4/HTs0pdCvfOr9uTCAf4fJEtr5wJP0aYLA==
X-Received: by 2002:adf:fc83:: with SMTP id g3mr33802908wrr.200.1604518264314;
        Wed, 04 Nov 2020 11:31:04 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id m12sm4051671wrs.92.2020.11.04.11.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:31:03 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RFT PATCH v2 6/8] gpio: exar: unduplicate address and offset computation
Date:   Wed,  4 Nov 2020 20:30:49 +0100
Message-Id: <20201104193051.32236-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104193051.32236-1-brgl@bgdev.pl>
References: <20201104193051.32236-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Provide and use helpers for calculating the register address and bit
offset instead of hand coding it in every function.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-exar.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index db366d85b6b4..28b0b4b5fa35 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -33,6 +33,26 @@ struct exar_gpio_chip {
 	unsigned int first_pin;
 };
 
+static unsigned int
+exar_offset_to_sel_addr(struct exar_gpio_chip *exar_gpio, unsigned int offset)
+{
+	return (offset + exar_gpio->first_pin) / 8 ? EXAR_OFFSET_MPIOSEL_HI
+						   : EXAR_OFFSET_MPIOSEL_LO;
+}
+
+static unsigned int
+exar_offset_to_lvl_addr(struct exar_gpio_chip *exar_gpio, unsigned int offset)
+{
+	return (offset + exar_gpio->first_pin) / 8 ? EXAR_OFFSET_MPIOLVL_HI
+						   : EXAR_OFFSET_MPIOLVL_LO;
+}
+
+static unsigned int
+exar_offset_to_bit(struct exar_gpio_chip *exar_gpio, unsigned int offset)
+{
+	return (offset + exar_gpio->first_pin) % 8;
+}
+
 static void exar_update(struct gpio_chip *chip, unsigned int reg, int val,
 			unsigned int offset)
 {
@@ -52,9 +72,8 @@ static int exar_set_direction(struct gpio_chip *chip, int direction,
 			      unsigned int offset)
 {
 	struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
-	unsigned int addr = (offset + exar_gpio->first_pin) / 8 ?
-		EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
-	unsigned int bit  = (offset + exar_gpio->first_pin) % 8;
+	unsigned int addr = exar_offset_to_sel_addr(exar_gpio, offset);
+	unsigned int bit = exar_offset_to_bit(exar_gpio, offset);
 
 	exar_update(chip, addr, direction, bit);
 	return 0;
@@ -75,9 +94,8 @@ static int exar_get(struct gpio_chip *chip, unsigned int reg)
 static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
 {
 	struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
-	unsigned int addr = (offset + exar_gpio->first_pin) / 8 ?
-		EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
-	unsigned int bit  = (offset + exar_gpio->first_pin) % 8;
+	unsigned int addr = exar_offset_to_sel_addr(exar_gpio, offset);
+	unsigned int bit = exar_offset_to_bit(exar_gpio, offset);
 
 	if (exar_get(chip, addr) & BIT(bit))
 		return GPIO_LINE_DIRECTION_IN;
@@ -88,9 +106,8 @@ static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
 static int exar_get_value(struct gpio_chip *chip, unsigned int offset)
 {
 	struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
-	unsigned int addr = (offset + exar_gpio->first_pin) / 8 ?
-		EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
-	unsigned int bit  = (offset + exar_gpio->first_pin) % 8;
+	unsigned int addr = exar_offset_to_lvl_addr(exar_gpio, offset);
+	unsigned int bit = exar_offset_to_bit(exar_gpio, offset);
 
 	return !!(exar_get(chip, addr) & BIT(bit));
 }
@@ -99,9 +116,8 @@ static void exar_set_value(struct gpio_chip *chip, unsigned int offset,
 			   int value)
 {
 	struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
-	unsigned int addr = (offset + exar_gpio->first_pin) / 8 ?
-		EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
-	unsigned int bit  = (offset + exar_gpio->first_pin) % 8;
+	unsigned int addr = exar_offset_to_lvl_addr(exar_gpio, offset);
+	unsigned int bit = exar_offset_to_bit(exar_gpio, offset);
 
 	exar_update(chip, addr, value, bit);
 }
-- 
2.29.1

