Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7178D2AD666
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbgKJMeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730397AbgKJMeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:34:17 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77471C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 04:34:16 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h2so2848642wmm.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 04:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lQQN2ZXT/G4B3VsGNJyIkmXWhvmT1sWJqpvE2SPt6Is=;
        b=sV3UVxEXouoK63lYQ3sZ8dzWkxLMl3GBy4cA9l5fOi9UnJ7e2ZWBTsTS7IMQr8Ws7H
         KraWsioS8ciUm8VPNhI5vs8fpEzYIgmc4l+/ukScdTQtTPuGmmRAMFrL3u0KqgYFsW+l
         Kg69pZmfAlLceFCKcOoH3ZmZD4Doq7dO8/pwCUDwEi4Nzb9tSLHun4YXIPc97RdRqyAA
         ojYkq1bnFVeELxsqRRKxRwDJhmqG8pzzYKhRdGM2GR5uoHMTl1xQKJc1SNB2qZxpXrCd
         8n+nudelBCerotlnuDXJjLbQ49lCPgjEba3H7Ymwv0MGKLj41pL1vTrTMhdL/w0Jikse
         fFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lQQN2ZXT/G4B3VsGNJyIkmXWhvmT1sWJqpvE2SPt6Is=;
        b=LYJ2lDZduezTEOhwUNpt9JqE8E2zjrOi0EG3YK/XTV5qRGlyoOs8G6dXbY3ztORUde
         mFc7pxdFP8PvZCkNXlP2fGFEz28xeh03Eisd8Lc3bLZJrj+9Cf+07oynp/2JILY0srZs
         L/dGGeXU62PObyGAh39eWfSeOnCVNeFpIcIHOfLnCGUYU5z5XKWXkelZ2VwgtjL9keXq
         5rZ8cuD/zcKqvXpk0OV+RUcVVzP9TxdHzPUjlJtEj8/RehMQ0Ulr4JRvXxooBHGa9pry
         AjKeq4aERswSqm/xFTz5U0JF95Z4zVPjrnwiEE9NHOAIsVIFgSAgpRywKodnBCK4AGbq
         A0PA==
X-Gm-Message-State: AOAM531G/uAsFkzNmLxSJDN3tCUhhWCiZ1vJjUt3EPG8yJv4UtdaWLI5
        2CEtLwRG9FMUc74BwOnT2O8Mtg==
X-Google-Smtp-Source: ABdhPJwmFQn6uwkVRA6amIfnVciBMRYDqwjaxLrEq637PklqtLdfEcnYhTbbi12bVmMFTFpbQIZvMg==
X-Received: by 2002:a1c:35c7:: with SMTP id c190mr4553794wma.146.1605011655289;
        Tue, 10 Nov 2020 04:34:15 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id s8sm12942217wrn.33.2020.11.10.04.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 04:34:14 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        David Laight <David.Laight@aculab.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 3/7] gpio: exar: switch to a simpler IDA interface
Date:   Tue, 10 Nov 2020 13:34:02 +0100
Message-Id: <20201110123406.3261-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201110123406.3261-1-brgl@bgdev.pl>
References: <20201110123406.3261-1-brgl@bgdev.pl>
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

