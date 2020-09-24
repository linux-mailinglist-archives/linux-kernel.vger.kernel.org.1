Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318AA277028
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgIXLjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbgIXLjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:39:04 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D124C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 04:39:04 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so3472686wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 04:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JGub3DzXhL7AkkI6iK+SL+4zKCGwxV6kIyrPE4bsyiY=;
        b=SLT/EHgSLvugpIfJOPkw+tO2fR6eaV03IDkcCh6puDqsCE52mI4xx0iLXRzlVE212Y
         fXQKbrNW5b+CmVuRwvmZDpea6wVt1//t3OsdZLK8hyBNmtdfF5tdzQu18bxQ8484fG+g
         q8z02hAuqdAFa3c0IqYMDagSBFatcLaQ4JH9+ervHXzTvKQ6tQMvnu3wB6r3bwcXOdtv
         NdcDNeoCNHhEJNhULzeFSz1KUXGmtf4CanAp6tTlEdDE82lLUEr+ixR3oP3vj+i+ZgYU
         EZbYqXG/scstrg6SqDGri3qay6PS+OLK+7lX5drQd3UgOv2DvQ9KtgIrsqe0UkOrStmD
         7lVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JGub3DzXhL7AkkI6iK+SL+4zKCGwxV6kIyrPE4bsyiY=;
        b=jgE9ThDVX/glNk2VkswPLw74UcRJYba1w0PJiKkQNQ9VdteATsT3D5o6rZCgiC5I+j
         gaovauiiYt7s0hbUcS9/uFJW8yxhILmzsKR9v3xNFQ1PUQ2UTeoLPYumid3Uq38ENkMe
         CYGaUFMSl33jdatmPTUU8DgEB6hK8GGOWYAH9bJRKp7EOY4BgOsvg1BmLHWUWJE+8xT5
         XGL8iRD987VnUbmaNOYj22aElEuKGzIkTIYVHq/dfKI+z+BiVPcnwgiGIIzjwP5+DPnb
         Phvk/nU/kaVxYGpyNyosAPrynFx4Jctc/O0Odnm8wQQDLfDYcInZ+qVQGuQU+cMHVdQz
         cJdQ==
X-Gm-Message-State: AOAM531AKYDPAQNLhrQ60U4YcwrTQpub7CWwfXUuPLxVvOqX+Z0PSS4F
        mDW1TDR32fVSUPOF7MuBHVnkBg==
X-Google-Smtp-Source: ABdhPJwRRHKuPOnQPU5XvgVnwnnUf+lAuiTXOzt+of8grtjvRhvSYM0OgF6GJfQq0ans8+65ykY0pg==
X-Received: by 2002:adf:84c3:: with SMTP id 61mr4568421wrg.131.1600947543143;
        Thu, 24 Sep 2020 04:39:03 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id y207sm3390133wmc.17.2020.09.24.04.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 04:39:02 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 9/9] gpio: mockup: refactor the module init function
Date:   Thu, 24 Sep 2020 13:38:42 +0200
Message-Id: <20200924113842.11670-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200924113842.11670-1-brgl@bgdev.pl>
References: <20200924113842.11670-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Let's move the code preparing the device properties into a separate
routine. This has the advantage of simplifying the error handling and
makes the indentation less deep.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 96 +++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 47 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index c35fd05de395..e2285f4330dd 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -503,16 +503,59 @@ static __init char **gpio_mockup_make_line_names(const char *label,
 	return names;
 }
 
-static int __init gpio_mockup_init(void)
+static int __init gpio_mockup_register_chip(int idx)
 {
 	struct property_entry properties[GPIO_MOCKUP_MAX_PROP];
-	int i, prop, num_chips, err = 0, base;
 	struct platform_device_info pdevinfo;
 	struct platform_device *pdev;
+	char **line_names = NULL;
 	char chip_label[32];
-	char **line_names;
+	int prop = 0, base;
 	u16 ngpio;
 
+	memset(properties, 0, sizeof(properties));
+	memset(&pdevinfo, 0, sizeof(pdevinfo));
+
+	snprintf(chip_label, sizeof(chip_label), "gpio-mockup-%c", idx + 'A');
+	properties[prop++] = PROPERTY_ENTRY_STRING("chip-label", chip_label);
+
+	base = gpio_mockup_range_base(idx);
+	if (base >= 0)
+		properties[prop++] = PROPERTY_ENTRY_U32("gpio-base", base);
+
+	ngpio = base < 0 ? gpio_mockup_range_ngpio(idx)
+			 : gpio_mockup_range_ngpio(idx) - base;
+	properties[prop++] = PROPERTY_ENTRY_U16("nr-gpios", ngpio);
+
+	if (gpio_mockup_named_lines) {
+		line_names = gpio_mockup_make_line_names(chip_label, ngpio);
+		if (!line_names)
+			return -ENOMEM;
+
+		properties[prop++] = PROPERTY_ENTRY_STRING_ARRAY_LEN(
+					"gpio-line-names", line_names, ngpio);
+	}
+
+	pdevinfo.name = "gpio-mockup";
+	pdevinfo.id = idx;
+	pdevinfo.properties = properties;
+
+	pdev = platform_device_register_full(&pdevinfo);
+	kfree_strarray(line_names, line_names ? ngpio : 0);
+	if (IS_ERR(pdev)) {
+		pr_err("error registering device");
+		return PTR_ERR(pdev);
+	}
+
+	gpio_mockup_pdevs[idx] = pdev;
+
+	return 0;
+}
+
+static int __init gpio_mockup_init(void)
+{
+	int i, num_chips, err;
+
 	if ((gpio_mockup_num_ranges < 2) ||
 	    (gpio_mockup_num_ranges % 2) ||
 	    (gpio_mockup_num_ranges > GPIO_MOCKUP_MAX_RANGES))
@@ -540,54 +583,13 @@ static int __init gpio_mockup_init(void)
 	}
 
 	for (i = 0; i < num_chips; i++) {
-		memset(properties, 0, sizeof(properties));
-		memset(&pdevinfo, 0, sizeof(pdevinfo));
-		prop = 0;
-		line_names = NULL;
-
-		snprintf(chip_label, sizeof(chip_label),
-			 "gpio-mockup-%c", i + 'A');
-		properties[prop++] = PROPERTY_ENTRY_STRING("chip-label",
-							   chip_label);
-
-		base = gpio_mockup_range_base(i);
-		if (base >= 0)
-			properties[prop++] = PROPERTY_ENTRY_U32("gpio-base",
-								base);
-
-		ngpio = base < 0 ? gpio_mockup_range_ngpio(i)
-				 : gpio_mockup_range_ngpio(i) - base;
-		properties[prop++] = PROPERTY_ENTRY_U16("nr-gpios", ngpio);
-
-		if (gpio_mockup_named_lines) {
-			line_names = gpio_mockup_make_line_names(chip_label,
-								 ngpio);
-			if (!line_names) {
-				platform_driver_unregister(&gpio_mockup_driver);
-				gpio_mockup_unregister_pdevs();
-				return -ENOMEM;
-			}
-
-			properties[prop++] = PROPERTY_ENTRY_STRING_ARRAY_LEN(
-						"gpio-line-names",
-						line_names, ngpio);
-		}
-
-		pdevinfo.name = "gpio-mockup";
-		pdevinfo.id = i;
-		pdevinfo.properties = properties;
-
-		pdev = platform_device_register_full(&pdevinfo);
-		kfree_strarray(line_names, line_names ? ngpio : 0);
-		if (IS_ERR(pdev)) {
-			pr_err("error registering device");
+		err = gpio_mockup_register_chip(i);
+		if (err) {
 			platform_driver_unregister(&gpio_mockup_driver);
 			gpio_mockup_unregister_pdevs();
 			debugfs_remove_recursive(gpio_mockup_dbg_dir);
-			return PTR_ERR(pdev);
+			return err;
 		}
-
-		gpio_mockup_pdevs[i] = pdev;
 	}
 
 	return 0;
-- 
2.26.1

