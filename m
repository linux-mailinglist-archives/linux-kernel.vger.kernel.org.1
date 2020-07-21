Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BBF228BEC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 00:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgGUW3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 18:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgGUW3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 18:29:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F0EC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 15:29:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so28497wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 15:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YjoK068xYYI7JA+9KS/v5ZylU9LwMSUUbo/ucAlYEPg=;
        b=0l7buidFzv+ayEbJEb75DkhvcyOLreC8KLeWXKQlVXACHTpsCQnYUOkpAHJsJcnCc/
         ulkaiYARA8FZfDqMAuyyWXZ0OTwkm4rPBDQkRsaD6nRmNbDVNlMtURXoCqoVYdMlnLJG
         GQjHfQV0fpF4+MvmVJpMPfv0k8i9k+Y9LwhVIrZBiIG7i3o1XY/iylI4eCvFA0bjVGxw
         WJ04+S4AC3GG68MVQQ6Lt9+tu+b8yR/nEhydyKuhPr9bSEsVaEIEOTIqEEyU9mjI/fLm
         jK0F5y2m2tVznVwYB5cIqwmtQP5MMZW70EzJLBncW0gyxEiTr3KgNJg5z4nWIRHGG8/J
         ADCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YjoK068xYYI7JA+9KS/v5ZylU9LwMSUUbo/ucAlYEPg=;
        b=Y0tEl8Ywh8wqfgaNOVEfWuVzcEHPJoXvF26nH+tVIL308BwD5dMLCMho84df+eTavm
         oc9Ya0QNpUI4gH6XuXyGiqSrcc+LBtOTthTTqpmg251LtoxR+2bvWYB+wKwjUIMo7r76
         31989hvlDOI6gjAnj6ciD4vMf8mcDZu8lapVXyltg6Fo3+WI3ON/KNXuX5Xr2/Ph8feW
         ZExYMuH/uFYsgA8kMJ5vhATf0uTSG1h1dlfL7zlok3pU+yWmUfmBG4dqom0TV5oUqYQG
         QJ0sSf38kmV9r3ggeuTqU9VAtIIcIsebszhwanT0CBl0AnIvVpAfuRmAgkwa47mBQIhX
         RNyQ==
X-Gm-Message-State: AOAM5338ZQwzA6ivZ5EFGCujIpMHEgFcNRg3liKAWcxomD/f65x/0oot
        FMzNm5pWkZDdOmCz3ps+Y1PZvQ==
X-Google-Smtp-Source: ABdhPJzsT0LvEgdkuonv+hl4lMIi0wGHa6O+5uUVVx/KAcLUwygW7f77i+4LAZD5EyBIqbtaCSuH0g==
X-Received: by 2002:adf:dfd0:: with SMTP id q16mr2767760wrn.60.1595370584930;
        Tue, 21 Jul 2020 15:29:44 -0700 (PDT)
Received: from localhost.localdomain (172.red-80-27-177.dynamicip.rima-tde.net. [80.27.177.172])
        by smtp.gmail.com with ESMTPSA id n16sm4824114wmc.40.2020.07.21.15.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 15:29:44 -0700 (PDT)
From:   Drew Fustini <drew@beagleboard.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>
Cc:     Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v4] pinctrl: core: print gpio in pins debugfs file
Date:   Wed, 22 Jul 2020 00:28:53 +0200
Message-Id: <20200721222851.2075891-1-drew@beagleboard.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is a gpio range mapping for the pin, then print out the gpio
chip and line index for the pin in the debugfs 'pins' file with the
format: "[line-index]:[gpio-label]"

Here is an example output on the BeagleBoard.org PocketBeagle (AM3358):
/sys/kernel/debug/pinctrl/44e10800.pinmux-pinctrl-single/pins

pin 25 (PIN25) 25:gpio-32-63 44e10864 00000037 pinctrl-single 
pin 26 (PIN26) 26:gpio-32-63 44e10868 00000037 pinctrl-single 
pin 27 (PIN27) 27:gpio-32-63 44e1086c 00000037 pinctrl-single 
pin 28 (PIN28) 0:N/A 44e10870 00000036 pinctrl-single 
pin 29 (PIN29) 0:N/A 44e10874 00000006 pinctrl-single 
pin 30 (PIN30) 28:gpio-32-63 44e10878 00000027 pinctrl-single 
pin 31 (PIN31) 29:gpio-32-63 44e1087c 00000037 pinctrl-single 
pin 32 (PIN32) 30:gpio-32-63 44e10880 00000037 pinctrl-single 
pin 33 (PIN33) 31:gpio-32-63 44e10884 00000037 pinctrl-single 
pin 34 (PIN34) 0:gpio-64-95 44e10888 00000037 pinctrl-single 
pin 35 (PIN35) 1:gpio-64-95 44e1088c 00000037 pinctrl-single 

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Suggested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Drew Fustini <drew@beagleboard.org>
---
 drivers/pinctrl/core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

v4 change:
- can format to be integer first as Andy suggested it will make parsing
  easier

v3 change:
- gpio column is now gpiochip label and line index

v2 changes:
- print 'NA' if pin does not have a GPIO number
- change gpio_num from unsigned to unsigned int per checkpatch


diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 821242bb4b16..39e74cdf5c7d 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -27,6 +27,7 @@
 #include <linux/pinctrl/machine.h>
 
 #ifdef CONFIG_GPIOLIB
+#include "../gpio/gpiolib.h"
 #include <asm-generic/gpio.h>
 #endif
 
@@ -1601,6 +1602,9 @@ static int pinctrl_pins_show(struct seq_file *s, void *what)
 	struct pinctrl_dev *pctldev = s->private;
 	const struct pinctrl_ops *ops = pctldev->desc->pctlops;
 	unsigned i, pin;
+	struct pinctrl_gpio_range *range;
+	unsigned int gpio_num;
+	struct gpio_chip *chip;
 
 	seq_printf(s, "registered pins: %d\n", pctldev->desc->npins);
 
@@ -1618,6 +1622,23 @@ static int pinctrl_pins_show(struct seq_file *s, void *what)
 
 		seq_printf(s, "pin %d (%s) ", pin, desc->name);
 
+#ifdef CONFIG_GPIOLIB
+		gpio_num = 0;
+		list_for_each_entry(range, &pctldev->gpio_ranges, node) {
+			if ((pin >= range->pin_base) &&
+			    (pin < (range->pin_base + range->npins))) {
+				gpio_num = range->base + (pin - range->pin_base);
+				break;
+			}
+		}
+		chip = gpio_to_chip(gpio_num);
+		if (chip && chip->gpiodev && chip->gpiodev->base)
+			seq_printf(s, "%u:%s ", gpio_num -
+				chip->gpiodev->base, chip->label);
+		else
+			seq_puts(s, "0:N/A ");
+#endif
+
 		/* Driver-specific info per pin */
 		if (ops->pin_dbg_show)
 			ops->pin_dbg_show(pctldev, s, pin);
-- 
2.25.1

