Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E7E2AD29C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 10:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgKJJjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 04:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgKJJjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 04:39:25 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C764C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 01:39:24 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a3so1006805wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 01:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZLUaWFTByQWu6s5ZS8hX5AOyEXEz1LfB4bMODRqx2s=;
        b=yqQV0dlIIVbfxAvTSByGngssmwgZ5aAs7eLkR5Tvv7rkbWYIEeTmEdmWk/z19MqCH3
         EYphXRLLq5OA8GRrsm95G7If/3mmKYqMhyt3++eHQbp2AnFrpupRXJHhGJF79px8b8k1
         LxdUnpuJeZiWmLSVnxgPx4kgqpcrwiCt+W7tPSMLsdjSe+KsBq0U+90VvGbaFoVZ8ula
         f6FaOKT93el9a4gd6i0AAI/++cxbanc1SrojAWgAC8hxS3wy2Z3gjRJUeTb9oihJYSFp
         nUwsD2/KCTReCZC5gGTpLn7uXZ2cwsMmU+8e2lNQITB9vTYqRgNUs0rIetyCGOi32lXC
         0Nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZLUaWFTByQWu6s5ZS8hX5AOyEXEz1LfB4bMODRqx2s=;
        b=tO6HkWf54ZH1FL38SqOkI0TaYBhcInnvvuaQbglQM+X8HEQtEBfC+/ZZDTE8/4i+qM
         IuEDvM3IrJcm5lmr3ss5aMxrVGmC6o5gUb/EQDL/mra00Jlf8MNbzNPNCw4eZ2+7siMq
         N/Nxbczo51E/LKvf4kkJSQJ9Hm3HNGOa5exqm96eCCrZXTR1FcnSzSvmDuYJcjMqWAWH
         XrBv0klSpt7u94sUJrPs/EDyfzaulWcWOpXDMT+7fDvVvBm8FG24s1mfYcGQaXG5NLzt
         rQ/o/ss+YIgYVvb6Fy5HP7jy2VXwUe3dqOULasGH64e1z8hj2S/NUx4Q9pz2NOUdv6ak
         EJLg==
X-Gm-Message-State: AOAM531KHOPmcfq7PRvAcYwSqDgAiFuQ+m4N2dBpdGKktb495O5h0F4O
        gcBz/gDYrvWC0paxRtxuHaCENQ==
X-Google-Smtp-Source: ABdhPJz2Xn6qn8iV1vth7Tf8U+Dr7aNqxdYL78ciDMNIMkUPTuYih94NjVQArEPsc8GzCKlMTQfPqA==
X-Received: by 2002:a1c:b387:: with SMTP id c129mr3949884wmf.66.1605001163321;
        Tue, 10 Nov 2020 01:39:23 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id d3sm16279143wre.91.2020.11.10.01.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 01:39:22 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] gpiolib: devres: shrink devm_gpiochip_add_data_with_key()
Date:   Tue, 10 Nov 2020 10:39:21 +0100
Message-Id: <20201110093921.3731-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

If all we want to manage is a single pointer, there's no need to
manually allocate and add a new devres. We can simply use
devm_add_action_or_reset() and shrink the code by a good bit.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib-devres.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib-devres.c b/drivers/gpio/gpiolib-devres.c
index 7dbce4c4ebdf..0a292dd3e2a6 100644
--- a/drivers/gpio/gpiolib-devres.c
+++ b/drivers/gpio/gpiolib-devres.c
@@ -479,9 +479,9 @@ void devm_gpio_free(struct device *dev, unsigned int gpio)
 }
 EXPORT_SYMBOL_GPL(devm_gpio_free);
 
-static void devm_gpio_chip_release(struct device *dev, void *res)
+static void devm_gpio_chip_release(void *data)
 {
-	struct gpio_chip *gc = *(struct gpio_chip **)res;
+	struct gpio_chip *gc = data;
 
 	gpiochip_remove(gc);
 }
@@ -507,23 +507,12 @@ int devm_gpiochip_add_data_with_key(struct device *dev, struct gpio_chip *gc, vo
 				    struct lock_class_key *lock_key,
 				    struct lock_class_key *request_key)
 {
-	struct gpio_chip **ptr;
 	int ret;
 
-	ptr = devres_alloc(devm_gpio_chip_release, sizeof(*ptr),
-			     GFP_KERNEL);
-	if (!ptr)
-		return -ENOMEM;
-
 	ret = gpiochip_add_data_with_key(gc, data, lock_key, request_key);
-	if (ret < 0) {
-		devres_free(ptr);
+	if (ret < 0)
 		return ret;
-	}
 
-	*ptr = gc;
-	devres_add(dev, ptr);
-
-	return 0;
+	return devm_add_action_or_reset(dev, devm_gpio_chip_release, gc);
 }
 EXPORT_SYMBOL_GPL(devm_gpiochip_add_data_with_key);
-- 
2.29.1

