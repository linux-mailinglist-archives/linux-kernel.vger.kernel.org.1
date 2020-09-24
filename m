Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0475C277018
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgIXLi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgIXLiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:38:54 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4B0C0613D7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 04:38:52 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w2so3196302wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 04:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wWev9UkO42jRbRsY5byu55gJ732xfhhQhwpq7S9JN7M=;
        b=T1YaoAImjSA161NmXY3XnIg49iksszJrPF7tIuhTP6ZjQyLkCtUpCIVYPuM7B5gDtP
         Eg3r8IJ05CSZzfhRTwA/pLsKI3xrHBgyD2apE5cHKuFnn25nkfmaMBAyAYiOWzlUKWth
         c3aT7cK/pyohmnLEKswYslvDsnt8tlOHlpQy2lz/TU7kQKYkvUHFT2spgiiDSWWaBpUx
         QavhMnjVSjHbPIB//Jvm621BvjHbGi4+i2felScgwDggQP5orDoulnqo0naDgqdOT6pP
         gHP3EvWXmadO3h7Lb2p0rJQkv2bnb8FtTmy2Imir1TslvCtFXv8xURbZrQs8mg440P3g
         RbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWev9UkO42jRbRsY5byu55gJ732xfhhQhwpq7S9JN7M=;
        b=i97ZoKEYSXLhPH4peE6HfJtZoQcxtvEHzMOmYnUFrLLVXJ3GJ4Zjz/eTmiaBT8kDzd
         PqqXMp2f7ytn6jk6n8+lkmI9z6tScqm06m0CPoGVDqTs/f9pPgktUwjE2G8C01AxeEin
         2A7CYtLZbDhF12QQXe+lYqUsglwDpHjQkqF13eSmLBfIzBqtEAAmypBJ9Ui274ccU5RE
         KcEDRFJBAmO5qzNABli/s/BizSFtPLxhgMikbZZsrUQZXIuWy286fxwcGNQMJ5SROgep
         dhRmPuou2RWQlHBoCoSxikaWTYr7OjFkGKvI4rXT6E3G+x0+8+8yV3g3Ljbq1JzFqiCj
         qIXw==
X-Gm-Message-State: AOAM532SdnG59RsF/ESuEleZzR5soLigYuWWYt5lKkvCBGJ7k15f7i6H
        lfjY45eSeRUdSne4bjJZBwgIig==
X-Google-Smtp-Source: ABdhPJwrt2MlBcTP0XgtXva4MaqZyVUSBZvDLONbzEc0v8hoFE43xWtvMIUuy+87Tt9DMBZB+1SbQg==
X-Received: by 2002:a1c:1902:: with SMTP id 2mr4588867wmz.26.1600947530739;
        Thu, 24 Sep 2020 04:38:50 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id y207sm3390133wmc.17.2020.09.24.04.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 04:38:50 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/9] Documentation: gpio: add documentation for gpio-mockup
Date:   Thu, 24 Sep 2020 13:38:35 +0200
Message-Id: <20200924113842.11670-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200924113842.11670-1-brgl@bgdev.pl>
References: <20200924113842.11670-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There's some documentation for gpio-mockup's debugfs interface in the
driver's source but it's not much. Add proper documentation for this
testing module.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../admin-guide/gpio/gpio-mockup.rst          | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/admin-guide/gpio/gpio-mockup.rst

diff --git a/Documentation/admin-guide/gpio/gpio-mockup.rst b/Documentation/admin-guide/gpio/gpio-mockup.rst
new file mode 100644
index 000000000000..9fa1618b3adc
--- /dev/null
+++ b/Documentation/admin-guide/gpio/gpio-mockup.rst
@@ -0,0 +1,50 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+GPIO Testing Driver
+===================
+
+The GPIO Testing Driver (gpio-mockup) provides a way to create simulated GPIO
+chips for testing purposes. The lines exposed by these chips can be accessed
+using the standard GPIO character device interface as well as manipulated
+using the dedicated debugfs directory structure.
+
+Creating simulated chips using module params
+--------------------------------------------
+
+When loading the gpio-mockup driver a number of parameters can be passed to the
+module.
+
+    gpio_mockup_ranges
+
+        This parameter takes an argument in the form of an array of integer
+        pairs. Each pair defines the base GPIO number (if any) and the number
+        of lines exposed by the chip. If the base GPIO is -1, the gpiolib
+        will assign it automatically.
+
+        Example: gpio_mockup_ranges=-1,8,-1,16,405,4
+
+        The line above creates three chips. The first one will expose 8 lines,
+        the second 16 and the third 4. The base GPIO for the third chip is set
+        to 405 while for two first chips it will be assigned automatically.
+
+    gpio_named_lines
+
+        This parameter doesn't take any arguments. It lets the driver know that
+        GPIO lines exposed by it should be named.
+
+        The name format is: gpio-mockup-X-Y where X is mockup chip's ID
+        and Y is the line offset.
+
+Manipulating simulated lines
+----------------------------
+
+Each mockup chip creates its own subdirectory in /sys/kernel/debug/gpio-mockup/.
+The directory is named after the chip's label. A symlink is also created, named
+after the chip's name, which points to the label directory.
+
+Inside each subdirectory, there's a separate attribute for each GPIO line. The
+name of the attribute represents the line's offset in the chip.
+
+Reading from a line attribute returns the current value. Writing to it (0 or 1)
+changes the configuration of the simulated pull-up/pull-down resistor
+(1 - pull-up, 0 - pull-down).
-- 
2.26.1

