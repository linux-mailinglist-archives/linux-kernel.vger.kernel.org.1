Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAA625DE57
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 17:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgIDPtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 11:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgIDPrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:47:02 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D227EC061262
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:46:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so7207636wrp.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BFcXvT/mBks59Nbsnk6JiwVK+tMFpXxn+PeH1sXkPcs=;
        b=BmXQtsk/lNSK1NhzOpnVddLfxGsT8P0H9ClEgPxJpE8hkw4Ul/zwqczzS70BALZS8n
         vUW5AfqeO8+ikYrSu/35Ybp7/e/CjukugK16RO2+ZRrxjWbQ+6bTdhe0MJedMJxCczcx
         87b+KiHycu6GRF+fkYgMryzrI/mI+X58xNIT8iWekGrHZrpJ5hLX9OnjMr4cj4t3eUxX
         wSZUpjgrh5l+Uhnbt4iDGr0J5la/xLfUcYhiu+0lj8jj61KujeIQqqZRmaS/rdRnkhUi
         77/rijdpdD7LjPcI3LBVuEcAx0/sSZUJi07rSLSpvBU48UQsIdpK7sjEORTMAhaUC1ZA
         29Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BFcXvT/mBks59Nbsnk6JiwVK+tMFpXxn+PeH1sXkPcs=;
        b=sZ78DEUfP93BujiOsmQ40CqhyFQ8swbetyY7xcZJ+R4ZYCcPUdBuBn7RZjG8f86atu
         eUlCboM0bOQCctvUeCUiekMgfpsuZXEQDlxbpyNmU3/gENE7wrnJvQOfh0LOiIqhuFD0
         YlKyWv6DYGPZZ7OKZlwyfwCbpPQg6MzHgA1N0GsxuPodmvIu6eKK9BDL3iR2agVNXTTO
         BZcLPjOGLvFuaGUQcQ6wxdu+x1Ck+cKymUoH+0xZOTef6XH1/jEdSBLUt1u2F5q6DuYW
         43oB/AENIeIC7g/QT5GA69wnFLzTlvLGnMP1EdFDu3JaCSZkpdFx3iscMAJ1XSpet3v1
         3fkQ==
X-Gm-Message-State: AOAM533j55/uniITdIhnPFdUGFtRXD3iS+PbKFwE9aU/5Q7lNEwfawzg
        kjnBayG6yANHbgg9pfvPR81Pag==
X-Google-Smtp-Source: ABdhPJxqVtqimUn/AOziI4okr5k6W+CeptUTEmSCRZWc/9G1FoORHyIyNXxgkGRVZJUKwoP2mlGlAw==
X-Received: by 2002:adf:9ed4:: with SMTP id b20mr8360307wrf.206.1599234406494;
        Fri, 04 Sep 2020 08:46:46 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q4sm11983375wru.65.2020.09.04.08.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:46:46 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 13/23] gpio: mockup: pass the chip label as device property
Date:   Fri,  4 Sep 2020 17:45:37 +0200
Message-Id: <20200904154547.3836-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200904154547.3836-1-brgl@bgdev.pl>
References: <20200904154547.3836-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

While we do check the "chip-name" property in probe(), we never actually
use it. Let's pass the chip label to the driver using device properties
as we'll want to allow users to define their own once dynamically
created chips are supported.

The property is renamed to "chip-label" to not cause any confusion with
the actual chip name which is of the form: "gpiochipX".

If the "chip-label" property is missing, let's do what most devices in
drivers/gpio/ do and use dev_name().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index e8a19a28ed13..ce83f1df1933 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -433,21 +433,14 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 	if (rv)
 		return rv;
 
-	rv = device_property_read_string(dev, "chip-name", &name);
+	rv = device_property_read_string(dev, "chip-label", &name);
 	if (rv)
-		name = NULL;
+		name = dev_name(dev);
 
 	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
-	if (!name) {
-		name = devm_kasprintf(dev, GFP_KERNEL,
-				      "%s-%c", pdev->name, pdev->id + 'A');
-		if (!name)
-			return -ENOMEM;
-	}
-
 	mutex_init(&chip->lock);
 
 	gc = &chip->gc;
@@ -534,6 +527,7 @@ static void gpio_mockup_unregister_devices(void)
 static int __init gpio_mockup_init(void)
 {
 	struct property_entry properties[GPIO_MOCKUP_MAX_PROP];
+	char chip_label[GPIO_MOCKUP_LABEL_SIZE];
 	struct gpio_mockup_device *mockup_dev;
 	int i, prop, num_chips, err = 0, base;
 	struct platform_device_info pdevinfo;
@@ -570,6 +564,11 @@ static int __init gpio_mockup_init(void)
 		memset(&pdevinfo, 0, sizeof(pdevinfo));
 		prop = 0;
 
+		snprintf(chip_label, sizeof(chip_label),
+			 "gpio-mockup-%c", i + 'A');
+		properties[prop++] = PROPERTY_ENTRY_STRING("chip-label",
+							   chip_label);
+
 		base = gpio_mockup_range_base(i);
 		if (base >= 0)
 			properties[prop++] = PROPERTY_ENTRY_U32("gpio-base",
-- 
2.26.1

