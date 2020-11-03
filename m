Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DF62A40EA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 10:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgKCJ6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgKCJ6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:58:48 -0500
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06F4C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 01:58:47 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id A746D23F949;
        Tue,  3 Nov 2020 10:58:46 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.944
X-Spam-Level: 
X-Spam-Status: No, score=-2.944 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.044, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id A_tfO2_D3qju; Tue,  3 Nov 2020 10:58:44 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 9E26B23F3FE;
        Tue,  3 Nov 2020 10:58:43 +0100 (CET)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v6 02/25] auxdisplay: Introduce hd44780_common.[ch]
Date:   Tue,  3 Nov 2020 10:58:05 +0100
Message-Id: <20201103095828.515831-3-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103095828.515831-1-poeschel@lemonage.de>
References: <20201103095828.515831-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

There is some hd44780 specific code in charlcd and this code is used by
multiple drivers. To make charlcd independent from this device specific
code this has to be moved to a place where the multiple drivers can
share their common code. This common place is now introduced as
hd44780_common.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
Changes in v6:
- Fix Kconfig so that auxdisplay is now a submenu again

Changes in v5:
- Remove some unnecessary newlines

Changes in v3:
- Fix some typos
---
 drivers/auxdisplay/Kconfig          | 20 ++++++++++++++
 drivers/auxdisplay/Makefile         |  1 +
 drivers/auxdisplay/hd44780.c        | 43 +++++++++++++++++++----------
 drivers/auxdisplay/hd44780_common.c | 19 +++++++++++++
 drivers/auxdisplay/hd44780_common.h |  7 +++++
 drivers/auxdisplay/panel.c          | 18 ++++++++++--
 6 files changed, 91 insertions(+), 17 deletions(-)
 create mode 100644 drivers/auxdisplay/hd44780_common.c
 create mode 100644 drivers/auxdisplay/hd44780_common.h

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index 81757eeded68..aaf2d66357a1 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -16,10 +16,29 @@ menuconfig AUXDISPLAY
 
 if AUXDISPLAY
 
+config CHARLCD
+	tristate "Character LCD core support" if COMPILE_TEST
+	help
+	  This is the base system for character-based LCD displays.
+	  It makes no sense to have this alone, you select your display driver
+	  and if it needs the charlcd core, it will select it automatically.
+	  This is some character LCD core interface that multiple drivers can
+	  use.
+
+config HD44780_COMMON
+	tristate "Common functions for HD44780 (and compatibles) LCD displays" if COMPILE_TEST
+	help
+	  This is a module with the common symbols for HD44780 (and compatibles)
+	  displays. This is the code that multiple other modules use. It is not
+	  useful alone. If you have some sort of HD44780 compatible display,
+	  you very likely use this. It is selected automatically by selecting
+	  your concrete display.
+
 config HD44780
 	tristate "HD44780 Character LCD support"
 	depends on GPIOLIB || COMPILE_TEST
 	select CHARLCD
+	select HD44780_COMMON
 	help
 	  Enable support for Character LCDs using a HD44780 controller.
 	  The LCD is accessible through the /dev/lcd char device (10, 156).
@@ -168,6 +187,7 @@ menuconfig PARPORT_PANEL
 	tristate "Parallel port LCD/Keypad Panel support"
 	depends on PARPORT
 	select CHARLCD
+	select HD44780_COMMON
 	help
 	  Say Y here if you have an HD44780 or KS-0074 LCD connected to your
 	  parallel port. This driver also features 4 and 6-key keypads. The LCD
diff --git a/drivers/auxdisplay/Makefile b/drivers/auxdisplay/Makefile
index cf54b5efb07e..7e8a8c3eb3c3 100644
--- a/drivers/auxdisplay/Makefile
+++ b/drivers/auxdisplay/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_CHARLCD)		+= charlcd.o
+obj-$(CONFIG_HD44780_COMMON)	+= hd44780_common.o
 obj-$(CONFIG_ARM_CHARLCD)	+= arm-charlcd.o
 obj-$(CONFIG_KS0108)		+= ks0108.o
 obj-$(CONFIG_CFAG12864B)	+= cfag12864b.o cfag12864bfb.o
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 5982158557bb..271dba9cd108 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 
 #include "charlcd.h"
+#include "hd44780_common.h"
 
 enum hd44780_pin {
 	/* Order does matter due to writing to GPIO array subsets! */
@@ -179,8 +180,9 @@ static int hd44780_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	unsigned int i, base;
 	struct charlcd *lcd;
+	struct hd44780_common *hdc;
 	struct hd44780 *hd;
-	int ifwidth, ret;
+	int ifwidth, ret = -ENOMEM;
 
 	/* Required pins */
 	ifwidth = gpiod_count(dev, "data");
@@ -198,31 +200,39 @@ static int hd44780_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	hdc = hd44780_common_alloc();
+	if (!hdc)
+		return -ENOMEM;
+
 	lcd = charlcd_alloc(sizeof(struct hd44780));
 	if (!lcd)
-		return -ENOMEM;
+		goto fail1;
 
-	hd = lcd->drvdata;
+	hd = kzalloc(sizeof(struct hd44780), GFP_KERNEL);
+	if (!hd)
+		goto fail2;
 
+	hdc->hd44780 = hd;
+	lcd->drvdata = hdc;
 	for (i = 0; i < ifwidth; i++) {
 		hd->pins[base + i] = devm_gpiod_get_index(dev, "data", i,
 							  GPIOD_OUT_LOW);
 		if (IS_ERR(hd->pins[base + i])) {
 			ret = PTR_ERR(hd->pins[base + i]);
-			goto fail;
+			goto fail3;
 		}
 	}
 
 	hd->pins[PIN_CTRL_E] = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
 	if (IS_ERR(hd->pins[PIN_CTRL_E])) {
 		ret = PTR_ERR(hd->pins[PIN_CTRL_E]);
-		goto fail;
+		goto fail3;
 	}
 
 	hd->pins[PIN_CTRL_RS] = devm_gpiod_get(dev, "rs", GPIOD_OUT_HIGH);
 	if (IS_ERR(hd->pins[PIN_CTRL_RS])) {
 		ret = PTR_ERR(hd->pins[PIN_CTRL_RS]);
-		goto fail;
+		goto fail3;
 	}
 
 	/* Optional pins */
@@ -230,24 +240,24 @@ static int hd44780_probe(struct platform_device *pdev)
 							GPIOD_OUT_LOW);
 	if (IS_ERR(hd->pins[PIN_CTRL_RW])) {
 		ret = PTR_ERR(hd->pins[PIN_CTRL_RW]);
-		goto fail;
+		goto fail3;
 	}
 
 	hd->pins[PIN_CTRL_BL] = devm_gpiod_get_optional(dev, "backlight",
 							GPIOD_OUT_LOW);
 	if (IS_ERR(hd->pins[PIN_CTRL_BL])) {
 		ret = PTR_ERR(hd->pins[PIN_CTRL_BL]);
-		goto fail;
+		goto fail3;
 	}
 
 	/* Required properties */
 	ret = device_property_read_u32(dev, "display-height-chars",
 				       &lcd->height);
 	if (ret)
-		goto fail;
+		goto fail3;
 	ret = device_property_read_u32(dev, "display-width-chars", &lcd->width);
 	if (ret)
-		goto fail;
+		goto fail3;
 
 	/*
 	 * On displays with more than two rows, the internal buffer width is
@@ -264,13 +274,17 @@ static int hd44780_probe(struct platform_device *pdev)
 
 	ret = charlcd_register(lcd);
 	if (ret)
-		goto fail;
+		goto fail3;
 
 	platform_set_drvdata(pdev, lcd);
 	return 0;
 
-fail:
-	charlcd_free(lcd);
+fail3:
+	kfree(hd);
+fail2:
+	kfree(lcd);
+fail1:
+	kfree(hdc);
 	return ret;
 }
 
@@ -278,9 +292,10 @@ static int hd44780_remove(struct platform_device *pdev)
 {
 	struct charlcd *lcd = platform_get_drvdata(pdev);
 
+	kfree(lcd->drvdata);
 	charlcd_unregister(lcd);
 
-	charlcd_free(lcd);
+	kfree(lcd);
 	return 0;
 }
 
diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
new file mode 100644
index 000000000000..2fdea29d6a8f
--- /dev/null
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include "hd44780_common.h"
+
+struct hd44780_common *hd44780_common_alloc(void)
+{
+	struct hd44780_common *hd;
+
+	hd = kzalloc(sizeof(*hd), GFP_KERNEL);
+	if (!hd)
+		return NULL;
+
+	return hd;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_alloc);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
new file mode 100644
index 000000000000..974868f7529c
--- /dev/null
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+struct hd44780_common {
+	void *hd44780;
+};
+
+struct hd44780_common *hd44780_common_alloc(void);
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index de623ae219f1..c3a60e190a7a 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -56,6 +56,7 @@
 #include <linux/uaccess.h>
 
 #include "charlcd.h"
+#include "hd44780_common.h"
 
 #define LCD_MAXBYTES		256	/* max burst write */
 
@@ -895,10 +896,20 @@ static const struct charlcd_ops charlcd_tilcd_ops = {
 static void lcd_init(void)
 {
 	struct charlcd *charlcd;
+	struct hd44780_common *hdc;
+
+	hdc = hd44780_common_alloc();
+	if (!hdc)
+		return;
 
 	charlcd = charlcd_alloc(0);
-	if (!charlcd)
+	if (!charlcd) {
+		kfree(hdc);
 		return;
+	}
+
+	hdc->hd44780 = &lcd;
+	charlcd->drvdata = hdc;
 
 	/*
 	 * Init lcd struct with load-time values to preserve exact
@@ -1620,7 +1631,7 @@ static void panel_attach(struct parport *port)
 	if (lcd.enabled)
 		charlcd_unregister(lcd.charlcd);
 err_unreg_device:
-	charlcd_free(lcd.charlcd);
+	kfree(lcd.charlcd);
 	lcd.charlcd = NULL;
 	parport_unregister_device(pprt);
 	pprt = NULL;
@@ -1647,7 +1658,8 @@ static void panel_detach(struct parport *port)
 	if (lcd.enabled) {
 		charlcd_unregister(lcd.charlcd);
 		lcd.initialized = false;
-		charlcd_free(lcd.charlcd);
+		kfree(lcd.charlcd->drvdata);
+		kfree(lcd.charlcd);
 		lcd.charlcd = NULL;
 	}
 
-- 
2.28.0

