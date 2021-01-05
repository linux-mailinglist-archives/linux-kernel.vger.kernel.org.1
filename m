Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9128A2EADF9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 16:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbhAEPLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 10:11:11 -0500
Received: from tux.runtux.com ([176.9.82.136]:59740 "EHLO tux.runtux.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727155AbhAEPLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 10:11:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by tux.runtux.com (Postfix) with ESMTP id DDCB86F0C4;
        Tue,  5 Jan 2021 16:04:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
        by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tL9TIJz2gNfB; Tue,  5 Jan 2021 16:04:00 +0100 (CET)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
        (Authenticated sender: postmaster@runtux.com)
        by tux.runtux.com (Postfix) with ESMTPSA id 834A96EF52;
        Tue,  5 Jan 2021 16:04:00 +0100 (CET)
Received: by bee.priv.zoo (Postfix, from userid 1002)
        id 286D4473; Tue,  5 Jan 2021 16:04:00 +0100 (CET)
Date:   Tue, 5 Jan 2021 16:04:00 +0100
From:   Ralf Schlatterbeck <rsc@runtux.com>
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] auxdisplay: HD44780 connected to I2C via PCF8574
Message-ID: <20210105150400.j7hhxu5uextga5mz@runtux.com>
References: <20210105150124.dvlochv3qrp4wpre@runtux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105150124.dvlochv3qrp4wpre@runtux.com>
X-ray:  beware
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add HD44780 character display connected via I2C I/O expander.
Re-uses the high-level interface of the existing HD44780 driver.

Signed-off-by: Ralf Schlatterbeck <rsc@runtux.com>
---
 drivers/auxdisplay/Kconfig           |  14 +-
 drivers/auxdisplay/Makefile          |   1 +
 drivers/auxdisplay/hd44780-pcf8574.c | 207 +++++++++++++++++++++++++++
 3 files changed, 221 insertions(+), 1 deletion(-)
 create mode 100644 drivers/auxdisplay/hd44780-pcf8574.c

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index 81757eeded68..1e373783c90e 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -17,7 +17,7 @@ menuconfig AUXDISPLAY
 if AUXDISPLAY
 
 config HD44780
-	tristate "HD44780 Character LCD support"
+	tristate "HD44780 Character LCD support, parallel connection"
 	depends on GPIOLIB || COMPILE_TEST
 	select CHARLCD
 	help
@@ -27,6 +27,18 @@ config HD44780
 	  kernel and started at boot.
 	  If you don't understand what all this is about, say N.
 
+config HD44780_PCF8574
+	tristate "HD44780 Character LCD support, I2C-connection"
+	depends on I2C
+	select CHARLCD
+	help
+	  Enable support for Character LCDs using a HD44780 controller.
+	  The HD44780 is connected to an I2C bus via PCF8574 I/O expancer.
+	  The LCD is accessible through the /dev/lcd char device (10, 156).
+	  This code can either be compiled as a module, or linked into the
+	  kernel and started at boot.
+	  If you don't understand what all this is about, say N.
+
 config KS0108
 	tristate "KS0108 LCD Controller"
 	depends on PARPORT_PC
diff --git a/drivers/auxdisplay/Makefile b/drivers/auxdisplay/Makefile
index cf54b5efb07e..cf008ce28545 100644
--- a/drivers/auxdisplay/Makefile
+++ b/drivers/auxdisplay/Makefile
@@ -9,5 +9,6 @@ obj-$(CONFIG_KS0108)		+= ks0108.o
 obj-$(CONFIG_CFAG12864B)	+= cfag12864b.o cfag12864bfb.o
 obj-$(CONFIG_IMG_ASCII_LCD)	+= img-ascii-lcd.o
 obj-$(CONFIG_HD44780)		+= hd44780.o
+obj-$(CONFIG_HD44780_PCF8574)	+= hd44780-pcf8574.o
 obj-$(CONFIG_HT16K33)		+= ht16k33.o
 obj-$(CONFIG_PARPORT_PANEL)	+= panel.o
diff --git a/drivers/auxdisplay/hd44780-pcf8574.c b/drivers/auxdisplay/hd44780-pcf8574.c
new file mode 100644
index 000000000000..ffd9d604928b
--- /dev/null
+++ b/drivers/auxdisplay/hd44780-pcf8574.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * HD44780 Character LCD driver for Linux
+ * With PCF8574 I2C I/O Expander
+ *
+ * Copyright (C) 2020, Ralf Schlatterbeck <rsc@runtux.com>
+ */
+
+#define DEBUG
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/i2c.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+/*
+ * The display uses 4-bit mode (the I/O expander has only 8 bits)
+ * The control signals RS, R/W, E are on three bits and on many displays
+ * the backlight is on bit 3. The upper 4 bits are data.
+ */
+#define HD44780_RS_SHIFT	0
+#define HD44780_RW_SHIFT	1
+#define HD44780_E_SHIFT		2
+#define HD44780_BACKLIGHT_SHIFT	3
+
+#include "charlcd.h"
+
+struct hd44780 {
+	const struct i2c_client *i2c_client;
+	int backlight;
+};
+
+static void hd44780_backlight(struct charlcd *lcd, int on)
+{
+	struct hd44780 *hd = lcd->drvdata;
+	u8 b = BIT(HD44780_RW_SHIFT); /* Read-bit */
+
+	hd->backlight = on;
+	/* Note: We do not toggle the E-bit, display will ignore this */
+	b |= hd->backlight ? BIT(HD44780_BACKLIGHT_SHIFT) : 0;
+	(void)i2c_master_send(hd->i2c_client, &b, 1);
+}
+
+static int hd44780_send_nibble(struct hd44780 *hd, u8 outbyte)
+{
+	const struct i2c_client *i2c_client = hd->i2c_client;
+	u8 backlight = hd->backlight ? BIT(HD44780_BACKLIGHT_SHIFT) : 0;
+	u8 b = outbyte;
+	int err;
+	/*
+	 * Transfers first send the output byte with the E-bit 0
+	 * Then the spec says to wait for 20us, then we set the E-bit to 1
+	 * and wait for 40us, then reset the E-bit again.
+	 * A max-speed (400kbit/s) I2C transfer for a single byte will
+	 * already take 25us. So the first delay of 20us can be skipped.
+	 * The second delay becomes 40us - 25us = 15us.
+	 */
+	b = (outbyte & ~BIT(HD44780_E_SHIFT)) | backlight;
+	dev_dbg(&i2c_client->dev, "I2C send: 0x%x", b);
+	err = i2c_master_send(i2c_client, &b, 1);
+	if (err < 0)
+		goto errout;
+	b = (outbyte |  BIT(HD44780_E_SHIFT)) | backlight;
+	dev_dbg(&i2c_client->dev, "I2C send: 0x%x", b);
+	err = i2c_master_send(i2c_client, &b, 1);
+	if (err < 0)
+		goto errout;
+	udelay(15);
+	b = (outbyte & ~BIT(HD44780_E_SHIFT)) | backlight;
+	dev_dbg(&i2c_client->dev, "I2C send: 0x%x", b);
+	err = i2c_master_send(i2c_client, &b, 1);
+	if (err < 0)
+		goto errout;
+	return 0;
+errout:
+	dev_err(&i2c_client->dev, "Error sending to display: %d", err);
+	return err;
+}
+
+static void hd44780_write_cmd_raw_nibble(struct charlcd *lcd, int cmd)
+{
+	struct hd44780 *hd = lcd->drvdata;
+
+	(void)hd44780_send_nibble(hd, (cmd & 0x0F) << 4);
+	udelay(20);
+}
+
+/* Send a command to the LCD panel */
+static void hd44780_write_cmd(struct charlcd *lcd, int cmd)
+{
+	struct hd44780 *hd = lcd->drvdata;
+	int ret;
+
+	ret = hd44780_send_nibble(hd, (cmd & 0xF0));
+	if (ret)
+		return;
+	ret = hd44780_send_nibble(hd, (cmd << 4));
+	if (ret)
+		return;
+	/* The shortest command takes at least 120 us */
+	udelay(120);
+}
+
+/* Send data to the LCD panel */
+static void hd44780_write_data(struct charlcd *lcd, int data)
+{
+	struct hd44780 *hd = lcd->drvdata;
+	int ret;
+
+	ret = hd44780_send_nibble(hd, (data & 0xF0) | BIT(HD44780_RS_SHIFT));
+	if (ret)
+		return;
+	ret = hd44780_send_nibble(hd, (data << 4)   | BIT(HD44780_RS_SHIFT));
+	if (ret)
+		return;
+	/* The shortest data takes at least 45 us */
+	udelay(45);
+}
+
+static const struct charlcd_ops hd44780_ops = {
+	.write_cmd	= hd44780_write_cmd,
+	.write_cmd_raw4 = hd44780_write_cmd_raw_nibble,
+	.write_data	= hd44780_write_data,
+	.backlight      = hd44780_backlight,
+};
+
+static int hd44780_i2c_probe(struct i2c_client *client,
+			     const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct charlcd *lcd;
+	struct hd44780 *hd;
+
+	int ret;
+
+	lcd = charlcd_alloc(sizeof(*hd));
+	if (!lcd)
+		return -ENOMEM;
+
+	hd = lcd->drvdata;
+	hd->i2c_client = client;
+	hd->backlight = 1;
+
+	/* Required properties */
+	ret = device_property_read_u32(dev, "display-height-chars",
+				       &lcd->height);
+	if (ret)
+		goto fail;
+	ret = device_property_read_u32(dev, "display-width-chars", &lcd->width);
+	if (ret)
+		goto fail;
+
+	/*
+	 * On displays with more than two rows, the internal buffer width is
+	 * usually equal to the display width
+	 */
+	if (lcd->height > 2)
+		lcd->bwidth = lcd->width;
+
+	/* Optional properties */
+	device_property_read_u32(dev, "internal-buffer-width", &lcd->bwidth);
+
+	lcd->ifwidth = 4;
+	lcd->ops = &hd44780_ops;
+
+	ret = charlcd_register(lcd);
+	if (ret)
+		goto fail;
+	dev_info(&client->dev, "Found HD44780 display");
+
+	return 0;
+
+fail:
+	charlcd_free(lcd);
+	return ret;
+}
+
+static int hd44780_i2c_remove(struct i2c_client *client)
+{
+	struct charlcd *lcd = i2c_get_clientdata(client);
+
+	charlcd_unregister(lcd);
+
+	charlcd_free(lcd);
+	return 0;
+}
+
+static const struct of_device_id hd44780_of_match[] = {
+	{ .compatible = "hit,hd44780+nxp,pcf8575" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, hd44780_of_match);
+
+static struct i2c_driver hd44780_i2c_driver = {
+	.driver = {
+		.name = "hd44780+pcf8574",
+		.of_match_table = hd44780_of_match,
+	},
+	.probe = hd44780_i2c_probe,
+	.remove = hd44780_i2c_remove,
+};
+module_i2c_driver(hd44780_i2c_driver);
+
+MODULE_DESCRIPTION("HD44780 + PCF8574 I2C Character LCD driver");
+MODULE_AUTHOR("Ralf Schlatterbeck <rsc@runtux.com>");
+MODULE_LICENSE("GPL");
-- 
2.20.1
