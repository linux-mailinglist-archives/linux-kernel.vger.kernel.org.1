Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F4526D516
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgIQHtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIQHtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:49:06 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A454CC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 00:49:06 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 16so1341149qkf.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 00:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZKJHKk7vG3da0ptMNHqr0ZH7librM+LR8T0+DdZdF4M=;
        b=ZXzXz46o2tHEdoZfj427WwyXF5XwFye1GOfw+mLenLLXV0ueZgYC1pcYj3lYMxGu3O
         u9Z21GE3b8lgMynuSLz0WpjzT2x6MzjDI8WCfQY7wND/MbNP3i14vroVqXAybUvtYC/I
         UiWcKbmcFNN664FeX5JQQHlbVfgav9HJTyuL8eExMXb8sbL5kr+E3JIuHlgaf9zt3NBN
         7rafP5yu1KT2YGTZUje00lgvuSRI5Em3InKyKKekVuUT2fIV0rcf6qvqNL+xKpB4nCgJ
         BBNAbkX1UEYNRCZgPH8TWGvArylDH4vm9B0sFqABcHnnDkI8EKlxiXyS1yIJpp+1BpV2
         q/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZKJHKk7vG3da0ptMNHqr0ZH7librM+LR8T0+DdZdF4M=;
        b=AEceAfJRU+T5J9TnpEg+cSIjTFzzW9X/IHZMIY19mJOPN2XdYEnPF9gxztV68lPkn7
         Ym3qd3/dTBhXGFfCy4+JtyFhspsGncz2USqWLodZqMwnizq8CRiVF+UWSxks8lzp00gZ
         BNQp0fYquX8byYB51HL8QGMuwRUAT2xnQgeRujiRAUWk++J22gXcWjNK6BFplnIjs/5r
         TFfUpt/3/Y4rT9bl9Paioyixudnn4/rWcbcGlGWtus/sG/4/Iz2xX4/jYhd5s8Z3TheM
         QUt9Fy/glSDihQFXFyY2iaMGvGNxKdn4Vmu+Nso9QuVx8OH1buzDNcLqrVUcyOLTq+ZQ
         DQcg==
X-Gm-Message-State: AOAM533zxkWy0pfuknvm2xacBahBprW3iRUwNE6Fjg1YD3PsGtVMjQCv
        mmnuMHrcko53asLr2pdXJLJ5Hw==
X-Google-Smtp-Source: ABdhPJzWJyaQQuiN+8cGiMTVoympH5kdMvCkREdE+9MOy1CGXfAhEUdzcOTU3OzLOUd2seVHXv5nBQ==
X-Received: by 2002:a37:9d84:: with SMTP id g126mr27322880qke.473.1600328945938;
        Thu, 17 Sep 2020 00:49:05 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-657-1-17-60.w109-210.abo.wanadoo.fr. [109.210.64.60])
        by smtp.gmail.com with ESMTPSA id q19sm3153736qtk.74.2020.09.17.00.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 00:49:05 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH next v2] gpiolib: check for parent device in devprop_gpiochip_set_names()
Date:   Thu, 17 Sep 2020 09:48:57 +0200
Message-Id: <20200917074857.6716-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

It's possible for a GPIO chip to not have a parent device (whose
properties we inspect for 'gpio-line-names'). In this case we should
simply return from devprop_gpiochip_set_names(). Add an appropriate
check for this use-case.

Fixes: 7cba1a4d5e16 ("gpiolib: generalize devprop_gpiochip_set_names() for device properties")
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
---
v1 -> v2:
- added a comment as requested by Andy

 drivers/gpio/gpiolib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index b7b608ef9e6b..dfcff5d24b18 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -375,6 +375,10 @@ static int devprop_gpiochip_set_names(struct gpio_chip *chip)
 	int ret, i;
 	int count;
 
+	/* GPIO chip may not have a parent device whose properties we inspect. */
+	if (!dev)
+		return 0;
+
 	count = device_property_string_array_count(dev, "gpio-line-names");
 	if (count < 0)
 		return 0;
-- 
2.26.1

