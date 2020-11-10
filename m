Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B4E2AD961
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbgKJO4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731016AbgKJO4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:56:09 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697FEC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:56:09 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h62so3275575wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lQQN2ZXT/G4B3VsGNJyIkmXWhvmT1sWJqpvE2SPt6Is=;
        b=mkdc4a/Vq0qaL8gzrCe8K5A2vQu2bDGUGNMOeokwa3SNxVFKN5NQ1nqgyL6x8vjDU8
         TvuapYnLvidxCywlQpqzHoeu4gxVV7vfXNY2Ic/IR6F4tiXAdA3mPbZhY8oe4J6rwOxf
         TQNXyX/nq2GamnXff5eUnNYIW6MHne+p9zLEdW3yLy/2ipXjMGCUXAfJIZCqDWly9sHe
         E6RvXY2WhYx0oRoJ1+yKG2LNdlWOe7RdvnuosyFREaL01OTliWHMlPZuZ7sgsD5uE5Bx
         YAFrzboacb/mr0AGHEOnho1mkb4I23ovwZzRrkW+gYhfJjXgrCqSK8ZyuxpwVoLXa2OJ
         uyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lQQN2ZXT/G4B3VsGNJyIkmXWhvmT1sWJqpvE2SPt6Is=;
        b=sdfHvk3HqQUypayVQ3268pSL5xJ3Ndxu+ADYadsZEc9P2Ox2WyWeq1xxzbyZLxOst5
         U9gQycX6C9AD+toF/MjbS8eyzavi/UaZAqX8b+oXBR501RFxQusgylXiy1ObUtmII+jt
         icN9Thd8mhd9PlJhrO/u9fqdYMru//WJzn+v9+AWpnQI0nk19Ewvta2LtVfZC0vFpktL
         IxFOZQGTIZGV3ffs5gc/w3hKKFvwttwS/urEOho4uswmseUsXe76lpu+7jlMdLkbNHS+
         /GK5Dz0HivLinFucvXEjJJXVZEEfHf+OOXHP034jUifsjd/5gRcvMHP5WqKLp8Ra3SX5
         mgGg==
X-Gm-Message-State: AOAM532uD0PWd+NpNyM+K13JrcXVjeUAys7bfR2MFqE63WpAGiQwXYjm
        nrxGByo9H0LdhTciolijvZS7rA==
X-Google-Smtp-Source: ABdhPJwhjmOoXzlfLdo6Htid2e6bfJNCrwZ7lF3zV1eOPcQ5phWcPfA0pn7jw10OizzBVSS79h2M7g==
X-Received: by 2002:a1c:5f45:: with SMTP id t66mr86249wmb.20.1605020168221;
        Tue, 10 Nov 2020 06:56:08 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id f17sm3261827wmf.41.2020.11.10.06.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 06:56:07 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        David Laight <David.Laight@aculab.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 3/7] gpio: exar: switch to a simpler IDA interface
Date:   Tue, 10 Nov 2020 15:55:48 +0100
Message-Id: <20201110145552.23024-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201110145552.23024-1-brgl@bgdev.pl>
References: <20201110145552.23024-1-brgl@bgdev.pl>
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

