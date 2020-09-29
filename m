Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0809F27C1EE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgI2KKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbgI2KKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:10:25 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0883C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 03:10:23 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k15so4674956wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 03:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WG5zf7DvZQOhoUaWAWxCAUvO9e/SXwl5eObguJAORVY=;
        b=2LoGJ8yszSO9fl3T0PyqgH5dQ/VJ+zpmH4mLhSSOEMQK5TeNrtVPQRzwzwbxBkLW7J
         HJUWKvpWCJj9zS6PkVb+20w6Q4GjxJeofFRLj9JTpJ+6j4p7Rq+f2rJ3iUuvd2LKevCN
         4Wa4fZW3rgK2yChkdxN9KQTiKP6V5TMMXPRlsriVCdf/8QmKVv+TmrOlce/fhyHUw8Ez
         2RhHJGWzIQ9l+UL03A1/fgLBP3h/NrXbxlFehKRAXxqjZzxJWNIARUNNX8qPorlSgFRN
         3NPNv2oAxGkhBoOsoQJLpDLfYp6tLL3qmvt4dfQqd46c4XNfQImFOj2mps2kgUA5wT8K
         z4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WG5zf7DvZQOhoUaWAWxCAUvO9e/SXwl5eObguJAORVY=;
        b=HmGXnHL5BrysBwoD4sEAMjnQf9IX2fAO+uKiydisnG+lvoLkfPYRvXO9ubHeu6S/Iu
         g/5Hu34sBMu/jKSs3A5/V/ReTnn7YqUn95LYI3um1nlqqW+H3XWIl0NG+G9y0WeskuoD
         gdjHjjtog+2zF1U7AUkIO2wfnUtKI66ZmDBBkTLovna7P2U8uEDrplB4lV+S5IulGCAx
         H1gdeWkhlMEtJ0DaYHAipqk2qo5zkogOUtLtiFliQjhd2bYSTmAanvcjsXSo8b4rkZ/1
         0SrV7lDdAdGP6MqtKLe+nPuqEXHu38kHr9oyshtbJbwSYbvQOQiQwkzBW2WOk62Q8r6C
         wZAw==
X-Gm-Message-State: AOAM533glsN7nNk7lwshATkxTJCQC81FnChKDj4ySQaA1zC8C7cQeQ5r
        JrSY8cKJkLTxdcV8alGMhYqSlw==
X-Google-Smtp-Source: ABdhPJw8O3X676rw4vniTLN5qe+I8t/BMSRgbYRyw4A3jOc7H2ziiWxoZPkP827QAfX/q+YnEUdbhQ==
X-Received: by 2002:a5d:554c:: with SMTP id g12mr3411577wrw.294.1601374222677;
        Tue, 29 Sep 2020 03:10:22 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-68-189.w109-210.abo.wanadoo.fr. [109.210.51.189])
        by smtp.gmail.com with ESMTPSA id x19sm3380680wmj.48.2020.09.29.03.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 03:10:22 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 07/10] gpio: mockup: increase the number of supported device properties
Date:   Tue, 29 Sep 2020 12:10:01 +0200
Message-Id: <20200929101004.20288-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200929101004.20288-1-brgl@bgdev.pl>
References: <20200929101004.20288-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The driver actually supports 4 properties but we only ever set up up to
three. This will change however in upcoming patches so increase the
number of really (as in: the number the property array can hold)
supported properties to 4.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index de778b52f355..856ba5da1e8c 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -29,8 +29,8 @@
  * of GPIO lines.
  */
 #define GPIO_MOCKUP_MAX_RANGES	(GPIO_MOCKUP_MAX_GC * 2)
-/* Maximum of three properties + the sentinel. */
-#define GPIO_MOCKUP_MAX_PROP	4
+/* Maximum of four properties + the sentinel. */
+#define GPIO_MOCKUP_MAX_PROP	5
 
 /*
  * struct gpio_pin_status - structure describing a GPIO status
-- 
2.26.1

