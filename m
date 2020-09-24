Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AEA277031
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgIXLj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbgIXLiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:38:54 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF65C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 04:38:54 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d4so3174442wmd.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 04:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GvwtjhQCT62SYD+p95TQrRZLwK1iHvfvwiDgAUHz68Q=;
        b=vYnow2xo4MYAUf/BsQL3RQk7QB/rzmXGEs65ivwKMagzOf9IdjsWnroM4ll5Fr4k9t
         rpb5kNVC9Y4lUpbKJPZwp8zR8H/a4IIgkj6ehpG13bgwesam7LscKUz/wuF8pbhT0hPQ
         roUyq0wDT1iCuTcUHMl0/cTP3TSYMdNCfkC5HurdRDalG/FvookPRU71/7hmfV8RTe3p
         D5ZcQ3YQcLpsDp/stNL0L2xL5OvIo9/AxUawIka0BQoet1uEywxCiNYsQFIPRwrwJ6/c
         Ta0IjLq3U4SE+mg54TFXeVOyTonMIHf7UqRGEkwL428eKSR4NDakKkzlt+uG2LekdIhc
         GRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GvwtjhQCT62SYD+p95TQrRZLwK1iHvfvwiDgAUHz68Q=;
        b=CjA+jB75H+mLKgfApeu0ivgNjk+Om51QKUv1uaNlO4jPmrFM6fY3QJ4CedM/FUzKTX
         EvSfyaD5YT6YEcLRcpu3DZJQQypuBEqqXUD6m05EbtRWchEky3bB3XlITTCr+TzPh/RR
         TP70RB3ftf1qEp/dxgDWhzs6/9j5e3yNsdcojwd+6pSHfEkGMMl/1peRKFnqnkug72nJ
         PskX1oFukcCO6eFR4tb3TmTonM4RImHNIzv58TBpYBGM7ztaan2p/G0PN8p6HmdG8HiU
         xu4sOr/ivREODir/RO9sorAzhJIcefURhL7qMZ8ZCvPKUToVKfQBC0KEcY29H+dzXOk6
         UW3w==
X-Gm-Message-State: AOAM532KW87A6UoORBdFtgVGNaEvtus0h0UIIwvVotKBF4NtHhnvDp7R
        Hm8uV3Jl5yuN62nH4J9oKQT6Ww==
X-Google-Smtp-Source: ABdhPJyjqo45RuWdGkVSIpCBr8Qh6l0l2Gm7090fg4NRKWDcIXqa6i4PZS88V2nY8ytF/Vh5mGnjPg==
X-Received: by 2002:a7b:c4d3:: with SMTP id g19mr4458961wmk.165.1600947532906;
        Thu, 24 Sep 2020 04:38:52 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id y207sm3390133wmc.17.2020.09.24.04.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 04:38:52 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4/9] gpio: mockup: use KBUILD_MODNAME
Date:   Thu, 24 Sep 2020 13:38:37 +0200
Message-Id: <20200924113842.11670-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200924113842.11670-1-brgl@bgdev.pl>
References: <20200924113842.11670-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Drop the definition for the driver name. Let's use KBUILD_MODNAME for
the log format and use the "gpio-mockup" value directly in the only
place where it's relevant: in the name of the device.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index c5092773afd8..90a1d6c2775f 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -21,7 +21,6 @@
 
 #include "gpiolib.h"
 
-#define GPIO_MOCKUP_NAME	"gpio-mockup"
 #define GPIO_MOCKUP_MAX_GC	10
 /*
  * We're storing two values per chip: the GPIO base and the number
@@ -31,7 +30,7 @@
 /* Maximum of three properties + the sentinel. */
 #define GPIO_MOCKUP_MAX_PROP	4
 
-#define gpio_mockup_err(...)	pr_err(GPIO_MOCKUP_NAME ": " __VA_ARGS__)
+#define gpio_mockup_err(...)	pr_err(KBUILD_MODNAME ": " __VA_ARGS__)
 
 /*
  * struct gpio_pin_status - structure describing a GPIO status
@@ -500,7 +499,7 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 
 static struct platform_driver gpio_mockup_driver = {
 	.driver = {
-		.name = GPIO_MOCKUP_NAME,
+		.name = "gpio-mockup",
 	},
 	.probe = gpio_mockup_probe,
 };
@@ -572,7 +571,7 @@ static int __init gpio_mockup_init(void)
 			properties[prop++] = PROPERTY_ENTRY_BOOL(
 						"named-gpio-lines");
 
-		pdevinfo.name = GPIO_MOCKUP_NAME;
+		pdevinfo.name = "gpio-mockup";
 		pdevinfo.id = i;
 		pdevinfo.properties = properties;
 
-- 
2.26.1

