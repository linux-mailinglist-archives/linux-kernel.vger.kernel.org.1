Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDFA2A6DF2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbgKDTbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731485AbgKDTbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:31:04 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B93EC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:31:02 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k10so21982247wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lQQN2ZXT/G4B3VsGNJyIkmXWhvmT1sWJqpvE2SPt6Is=;
        b=LOZfyrxq/o6RODMOyrU+qZOvySfL8SOerWyuvitpANZum1b/dHHL5T9VTGrvED/P7v
         SJbnq0ng7zQf0JTXyCeHdNGalGpL9J76qP6TXFf2rzvAysdIjIvvRGN3FtALlw7o1ijQ
         0qasCP7/Nz27WzdkvNctsAdGHcnR7M6UweKTyFp3NIeONAdb8rcGAyYTlCYTRJswfdPU
         altYpiuR03HPGxJkkfXZ/caBPmrcGskefyx1wHlgGeGHjP6XkSRn8imRRy89Yi2MSftH
         gM4lP6jXoigGMQf/THIJfmcaZZIpspe1JfYLS2RNKeS88LnI8LDVBEEm/9uqk7EGNw8X
         JNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lQQN2ZXT/G4B3VsGNJyIkmXWhvmT1sWJqpvE2SPt6Is=;
        b=AbVJwm1Djc5yqzjFVNG6ePEKIpiM+5gSQ/YlNegcPZIbre2eqeJNtJpOv1wDDIGhJ5
         wzDu2S4zE5JedcCbb1zetQKTpszFMlvUtknY17XztHcjn/vc7vpfUl1xXCHUfOTLi2aW
         D+iSpVJZbXFOwXkzSP+D5vW92jcjRaWkA8IC403XTUtTxHgrDt/H7lCeQ+h3FLNnpYhi
         KP47bD5K+/FqqtF1btFd4tt0uuUa9PPBiF3f7Hd+FW0aw5wHb/28cQB+JmOgtkx7Wmjd
         6cs+K0ngkxGO9ISre1j9S+6ioJcNUlWG/nchFf9qffIFxWNAHhtjXMyH94CtfsKVAgT/
         pQbA==
X-Gm-Message-State: AOAM533rY/JBMZS/hqF1zQL+Y+3cqG+dUX3eyWSZtPFJMLpEiRb2RWAM
        ukdaKygnFZlNgrQfIV3vj3Z0BQ==
X-Google-Smtp-Source: ABdhPJzmTo8yA7ign+6yiLlNRhedMA3K+hOB2l+5S9JH8N4LOgtiSZUZ5B6M4pznPp3esfra16yrwA==
X-Received: by 2002:a5d:698e:: with SMTP id g14mr32482428wru.232.1604518261207;
        Wed, 04 Nov 2020 11:31:01 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id m12sm4051671wrs.92.2020.11.04.11.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:31:00 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 4/8] gpio: exar: switch to a simpler IDA interface
Date:   Wed,  4 Nov 2020 20:30:47 +0100
Message-Id: <20201104193051.32236-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104193051.32236-1-brgl@bgdev.pl>
References: <20201104193051.32236-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We don't need to specify any ranges when allocating IDs so we can switch
to ida_alloc() and ida_free() instead of the ida_simple_ counterparts.

ida_simple_get(ida, 0, 0, gfp) is equivalent to
ida_alloc_range(ida, 0, UINT_MAX, gfp) which is equivalent to
ida_alloc(ida, gfp). Note: IDR will never actually allocate an ID
larger than INT_MAX.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-exar.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index 1941ae533418..752e8437ff80 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -149,7 +149,7 @@ static int gpio_exar_probe(struct platform_device *pdev)
 
 	mutex_init(&exar_gpio->lock);
 
-	index = ida_simple_get(&ida_index, 0, 0, GFP_KERNEL);
+	index = ida_alloc(&ida_index, GFP_KERNEL);
 	if (index < 0) {
 		ret = index;
 		goto err_mutex_destroy;
@@ -179,7 +179,7 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	return 0;
 
 err_destroy:
-	ida_simple_remove(&ida_index, index);
+	ida_free(&ida_index, index);
 err_mutex_destroy:
 	mutex_destroy(&exar_gpio->lock);
 	return ret;
@@ -189,7 +189,7 @@ static int gpio_exar_remove(struct platform_device *pdev)
 {
 	struct exar_gpio_chip *exar_gpio = platform_get_drvdata(pdev);
 
-	ida_simple_remove(&ida_index, exar_gpio->index);
+	ida_free(&ida_index, exar_gpio->index);
 	mutex_destroy(&exar_gpio->lock);
 
 	return 0;
-- 
2.29.1

