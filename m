Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5D727AC09
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgI1KmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgI1KmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:42:03 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138EEC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:42:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w2so603524wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BgQC3n53i35n7GC4c6lOV6W434EKfBGkaRy/2vzORco=;
        b=g25S92GzFTtlvrXh1qKrS/Vwlmclx80rOqSPIoXFYXySdro3WbP05KxXTAPR6v3exM
         ktTM+IJme5cRnb4LbYPLmz1mXORBY7M91DOyzGSbReyWETCpIyAfMA1stxJJLtDtxYak
         OdXu930qd9y3kFxYNsvMaDZN1sUYXRasTgjeflLvqROirlEIEi47pdPrdolGMO9W2Mfl
         saNiCjsYw3hpDcf052MHVKMu6/CP3RWUrd42qbQ+WEMUe49rppw728yuoFN9a1iTi/25
         EGAsht8jzipIbdyIVTys8PMyYmtjgtrJjoL3DwTLRgFqB4fNUsT6bnABqUL1G+AtQitg
         uhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BgQC3n53i35n7GC4c6lOV6W434EKfBGkaRy/2vzORco=;
        b=PgipVQelAkvWisKazWz7f5llHtGJT3zVdsHCcW44vnn2uPhcVq7CJzrKYVtuAPmxvn
         wfl2D7DzHO6zfnrnkGTf3ud1e+kZsM4/9odkFwtjCs0uuGpIiHFgnGg8uo3PQ9+tF6g0
         3cPmBAbSCBzHy+IjmSx9S6TfZgJFQ1998UgvzZgAfi7Me8eu+PGSj9qneLKFDl/CmtLS
         uj7t87wCQXGWEOziwdPNbGqlsIC+XtPU8QnKuFpMiGZKpLYWx8OueL3OmgXfdYSCetMY
         3JeGa+imV89LKf/m/s6NVsbU56KYRjAVyHKHZLHJU+SgMsYl1Vji2Qk8CcEP+E8/IPH9
         aWBw==
X-Gm-Message-State: AOAM531vPTzoKsv+6+QqbW8wOA9dhoCiriCZ/GnA1oMfN1apLQR7aQBr
        29QspqmZF3nl0iuj0JlwJEmnZg==
X-Google-Smtp-Source: ABdhPJzuoHu8hiPRyruz0R0GxX7FPtBX6BtsAj+v2MOxtfNzI1H20bJDYnfNZISzWIcqTHi2x057Ug==
X-Received: by 2002:a1c:544c:: with SMTP id p12mr963978wmi.170.1601289721775;
        Mon, 28 Sep 2020 03:42:01 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id f14sm939258wrt.53.2020.09.28.03.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 03:42:01 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 2/9] Documentation: gpio: add documentation for gpio-mockup
Date:   Mon, 28 Sep 2020 12:41:48 +0200
Message-Id: <20200928104155.7385-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200928104155.7385-1-brgl@bgdev.pl>
References: <20200928104155.7385-1-brgl@bgdev.pl>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

