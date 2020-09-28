Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A29227AC0B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgI1KmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgI1KmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:42:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F977C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:42:10 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g4so753355wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NLkzILStzwcX5lWd3OZiiqerlwq7qQv7m5/oV3taC7k=;
        b=WFDjseGUVlezz/bmtsAMRVQxh6txWCSr4tDGr+HrSe0GebeYy9FkDETLABW3zzPeEH
         SDptFyV5Q5RJcuam/uANjyJuO6Mizn84OrLr+MYrLT9K3cJ4W2qzrUVMgMVVUpQoppTC
         ahFvBd/cJGMtW3ui+g2LUydunm9/zJOXHJisCapohQtinTyMeyeUNzxJ1rmLV8KLbHpE
         psr1T/h2/dcELUuht7ocskjnfbZuJRbqlXJfF1Yn+9//0wB7MgnudfCPE+pq9pJTwsBG
         6fHZ1hFjIQAL+pKMGkNxFq2PWgcvSzKvaOKlrg54XKyc2KgYjhyHCZDORVHXzhEvOPeo
         ikCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NLkzILStzwcX5lWd3OZiiqerlwq7qQv7m5/oV3taC7k=;
        b=g6n6IxihPxUrf5qfv4aBS5X4xsuqQ6PYEyulOxfmzuRQ4Amw8aUBNt2G+BKqiSS5GP
         zvBAkMjkbTr1RSZYkNbox0iQNPq813x5IcXKOuXi51tUR93F1/IEGdVT2GYpnUVPB+kt
         6LxgwwUZCcNZkv6aceAHCYWlQjN/6R2rLT9pgqNloAklTRJxehj0NUaLV4DgUzPDgV+t
         xF22WnKd6NhQNUDWhBl7X1esQ+u9D4XFp8Q/y3XcTltBWp1fMvi5MjEet7FsEo11hxHW
         hPMPiNjRskMCrKUk2WB7Rs2Ex7VNniBB12eT4F/m3/uOAOLPtN93k0st/vaQNg5yO4E/
         2fxA==
X-Gm-Message-State: AOAM530E/nkHxIxZfFxjchCEdEXAUt1ZTui2Ibff0N1ozKRfQWTpafPM
        yy46XohY1UdSm0iB3B2q2qc3nA==
X-Google-Smtp-Source: ABdhPJx13KAAjVjH5El6zXYhK7NIg8cBZH4ORAyd17YH4P10hU6QzRfN0h4l+JoyeW/WOsJSdTHGJQ==
X-Received: by 2002:a5d:414b:: with SMTP id c11mr916082wrq.181.1601289729043;
        Mon, 28 Sep 2020 03:42:09 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id f14sm939258wrt.53.2020.09.28.03.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 03:42:08 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 8/9] gpio: mockup: use the generic 'gpio-line-names' property
Date:   Mon, 28 Sep 2020 12:41:54 +0200
Message-Id: <20200928104155.7385-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200928104155.7385-1-brgl@bgdev.pl>
References: <20200928104155.7385-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

GPIO line names are currently created by the driver from the chip label.
We'll want to support custom formats for line names (for instance: to
name all lines the same) for user-space tests so create them in the
module init function and pass them to the driver using the standard
'gpio-line-names' property.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 70 +++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 32 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 5b2686f9e07d..47b7de6d5ab1 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/string_helpers.h>
 #include <linux/uaccess.h>
 
 #include "gpiolib.h"
@@ -374,29 +375,6 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
 	}
 }
 
-static int gpio_mockup_name_lines(struct device *dev,
-				  struct gpio_mockup_chip *chip)
-{
-	struct gpio_chip *gc = &chip->gc;
-	char **names;
-	int i;
-
-	names = devm_kcalloc(dev, gc->ngpio, sizeof(char *), GFP_KERNEL);
-	if (!names)
-		return -ENOMEM;
-
-	for (i = 0; i < gc->ngpio; i++) {
-		names[i] = devm_kasprintf(dev, GFP_KERNEL,
-					  "%s-%d", gc->label, i);
-		if (!names[i])
-			return -ENOMEM;
-	}
-
-	gc->names = (const char *const *)names;
-
-	return 0;
-}
-
 static void gpio_mockup_dispose_mappings(void *data)
 {
 	struct gpio_mockup_chip *chip = data;
@@ -464,12 +442,6 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 	for (i = 0; i < gc->ngpio; i++)
 		chip->lines[i].dir = GPIO_LINE_DIRECTION_IN;
 
-	if (device_property_read_bool(dev, "named-gpio-lines")) {
-		rv = gpio_mockup_name_lines(dev, chip);
-		if (rv)
-			return rv;
-	}
-
 	chip->irq_sim_domain = devm_irq_domain_create_sim(dev, NULL,
 							  gc->ngpio);
 	if (IS_ERR(chip->irq_sim_domain))
@@ -510,6 +482,27 @@ static void gpio_mockup_unregister_pdevs(void)
 	}
 }
 
+static __init char **gpio_mockup_make_line_names(const char *label,
+						 unsigned int num_lines)
+{
+	unsigned int i;
+	char **names;
+
+	names = kcalloc(num_lines + 1, sizeof(char *), GFP_KERNEL);
+	if (!names)
+		return NULL;
+
+	for (i = 0; i < num_lines; i++) {
+		names[i] = kasprintf(GFP_KERNEL, "%s-%u", label, i);
+		if (!names[i]) {
+			kfree_strarray(names, i);
+			return NULL;
+		}
+	}
+
+	return names;
+}
+
 static int __init gpio_mockup_init(void)
 {
 	struct property_entry properties[GPIO_MOCKUP_MAX_PROP];
@@ -517,6 +510,7 @@ static int __init gpio_mockup_init(void)
 	struct platform_device_info pdevinfo;
 	struct platform_device *pdev;
 	char chip_label[32];
+	char **line_names;
 	u16 ngpio;
 
 	if ((gpio_mockup_num_ranges < 2) ||
@@ -549,6 +543,7 @@ static int __init gpio_mockup_init(void)
 		memset(properties, 0, sizeof(properties));
 		memset(&pdevinfo, 0, sizeof(pdevinfo));
 		prop = 0;
+		line_names = NULL;
 
 		snprintf(chip_label, sizeof(chip_label),
 			 "gpio-mockup-%c", i + 'A');
@@ -564,15 +559,26 @@ static int __init gpio_mockup_init(void)
 				 : gpio_mockup_range_ngpio(i) - base;
 		properties[prop++] = PROPERTY_ENTRY_U16("nr-gpios", ngpio);
 
-		if (gpio_mockup_named_lines)
-			properties[prop++] = PROPERTY_ENTRY_BOOL(
-						"named-gpio-lines");
+		if (gpio_mockup_named_lines) {
+			line_names = gpio_mockup_make_line_names(chip_label,
+								 ngpio);
+			if (!line_names) {
+				platform_driver_unregister(&gpio_mockup_driver);
+				gpio_mockup_unregister_pdevs();
+				return -ENOMEM;
+			}
+
+			properties[prop++] = PROPERTY_ENTRY_STRING_ARRAY_LEN(
+						"gpio-line-names",
+						line_names, ngpio);
+		}
 
 		pdevinfo.name = "gpio-mockup";
 		pdevinfo.id = i;
 		pdevinfo.properties = properties;
 
 		pdev = platform_device_register_full(&pdevinfo);
+		kfree_strarray(line_names, ngpio);
 		if (IS_ERR(pdev)) {
 			pr_err("error registering device");
 			platform_driver_unregister(&gpio_mockup_driver);
-- 
2.26.1

