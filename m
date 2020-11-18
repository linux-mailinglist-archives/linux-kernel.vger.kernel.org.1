Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C99B2B7707
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 08:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgKRHgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 02:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgKRHgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 02:36:49 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD337C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 23:36:48 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p1so1076566wrf.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 23:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TxMFwICoqSoDfQzs3jsqy5jI9KXugvjuOIUzoSPn7sw=;
        b=MeiGjOycYQRvax6CHy7x3Y4Wf+6O9t9+QtYFZhhnb9vvmW/9wBcjj0y1ebXdjH7OYH
         7aWM3yowBk7JVppGEP+sW9CLrr2MFIxgDQ5x4cG6m2xLova2p14Z1XiZNryNGwKbX4Og
         /+qFaX2o0yH93yqfBf+sbT7H2Qst4NfLqNcY/X/0HJVoDGJI3nUEdO9zMZ4QBfrXADVd
         o8f1qxqdK3sFrA7d8/Dfl9PzUtG/taj+T5Rj40FwGV9k7gYHHcU+K4cPZLVdZ1yeEeD+
         x5BHLKnHO3Top/ofePs76r93i+3iHHKBcMeo2XcTmQrkRTyN3eouWkjG17S3KJugM2y6
         T1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TxMFwICoqSoDfQzs3jsqy5jI9KXugvjuOIUzoSPn7sw=;
        b=ZEm/vEfciy5F2x/gJX++9IXkTTYPxsvLy6jp5AUfA0xpMAVO2e4olI5jN1AtcRJg00
         5ipoDea1FdD+0knaMri2ce2IzGa4w6EZaKEWIWqUWYz5TGBQy9VIbRIj3IYNPhY0dKWw
         RtckFBhLkBA0Q90ZaeFkSYKllA7WIGYVZ8nG5CuSU9dTZdSmvw7OPWAf9l8pDP3rp0vo
         M1wipNvWgA1BEVotcpvN0nHfhBnQVjw0c3a6yAKhBbspslYC0evSyWebB0vafMomeaIn
         3mUSSnfAgBX4l4c2Xg2R2pNOcaw/tIDKgiv2rubLLTTR3jI95Dkbeqd+WZTi+I/Mp1DU
         I/1A==
X-Gm-Message-State: AOAM5321KgwzaAGLOwweUP+g4Jp/DTAPnmjIyFnrzSzt4TI9jfWk9GaM
        0yYmRhUu6oc+Gjwf/9nkOIrUnBSCX5Q=
X-Google-Smtp-Source: ABdhPJyphjpwFXiYA4Gv26cd4qztXYMrandfiV1H01O0JYvM9e98ShziejYLtgqnSczarbuzvR+kUA==
X-Received: by 2002:adf:de05:: with SMTP id b5mr3267420wrm.131.1605685007171;
        Tue, 17 Nov 2020 23:36:47 -0800 (PST)
Received: from rum-mikhail-dt.world.mentorg.com (nat-rum.mentorg.com. [139.181.33.34])
        by smtp.gmail.com with ESMTPSA id b14sm30188632wrq.47.2020.11.17.23.36.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 23:36:46 -0800 (PST)
From:   mdurnev@gmail.com
X-Google-Original-From: mikhail_durnev@mentor.com
To:     linux-kernel@vger.kernel.org
Cc:     mikhail_durnev@mentor.com, dri-devel@lists.freedesktop.org,
        noralf@tronnes.org
Subject: [PATCH 2/3] drm/tiny: Add driver for ili9341 with parallel bus
Date:   Wed, 18 Nov 2020 17:35:44 +1000
Message-Id: <1605684945-29727-3-git-send-email-mikhail_durnev@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605684945-29727-1-git-send-email-mikhail_durnev@mentor.com>
References: <1605684945-29727-1-git-send-email-mikhail_durnev@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikhail Durnev <mikhail_durnev@mentor.com>

MRB2801 display module [1] is an example of ILI9341 display that connects to
Intel 8080 parallel bus. Its connector is compatible with the ALIENTEK STM32
development board.

It can be used with the drm/mipi-dbi bus driver if the bus is emulated with
GPIO.

[1] http://www.lcdwiki.com/2.8inch_16BIT_Module_ILI9341_SKU:MRB2801

Signed-off-by: Mikhail Durnev <mikhail_durnev@mentor.com>
---
 drivers/gpu/drm/tiny/Kconfig        |  13 ++
 drivers/gpu/drm/tiny/Makefile       |   1 +
 drivers/gpu/drm/tiny/ili9341_gpio.c | 290 ++++++++++++++++++++++++++++++++++++
 3 files changed, 304 insertions(+)
 create mode 100644 drivers/gpu/drm/tiny/ili9341_gpio.c

diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index 2b6414f..e48e268 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -66,6 +66,19 @@ config TINYDRM_ILI9341
 
 	  If M is selected the module will be called ili9341.
 
+config TINYDRM_ILI9341_GPIO
+	tristate "DRM support for ILI9341 display panels with parallel bus interface over GPIO"
+	depends on DRM
+	select DRM_KMS_HELPER
+	select DRM_KMS_CMA_HELPER
+	select DRM_MIPI_DBI
+	select BACKLIGHT_CLASS_DEVICE
+	help
+	  DRM driver for the following Ilitek ILI9341 panels:
+	  * MRB2801 2.8" 240x320 TFT
+
+	  If M is selected the module will be called ili9341_gpio.
+
 config TINYDRM_ILI9486
 	tristate "DRM support for ILI9486 display panels"
 	depends on DRM && SPI
diff --git a/drivers/gpu/drm/tiny/Makefile b/drivers/gpu/drm/tiny/Makefile
index 6ae4e9e5..1ad2c0d 100644
--- a/drivers/gpu/drm/tiny/Makefile
+++ b/drivers/gpu/drm/tiny/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_DRM_GM12U320)		+= gm12u320.o
 obj-$(CONFIG_TINYDRM_HX8357D)		+= hx8357d.o
 obj-$(CONFIG_TINYDRM_ILI9225)		+= ili9225.o
 obj-$(CONFIG_TINYDRM_ILI9341)		+= ili9341.o
+obj-$(CONFIG_TINYDRM_ILI9341_GPIO)	+= ili9341_gpio.o
 obj-$(CONFIG_TINYDRM_ILI9486)		+= ili9486.o
 obj-$(CONFIG_TINYDRM_MI0283QT)		+= mi0283qt.o
 obj-$(CONFIG_TINYDRM_REPAPER)		+= repaper.o
diff --git a/drivers/gpu/drm/tiny/ili9341_gpio.c b/drivers/gpu/drm/tiny/ili9341_gpio.c
new file mode 100644
index 0000000..de8a63b8
--- /dev/null
+++ b/drivers/gpu/drm/tiny/ili9341_gpio.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DRM driver for Ilitek ILI9341 panels with parallel bus interface
+ *
+ * Copyright 2020 Mikhail Durnev <mikhail_durnev@mentor.com>
+ *
+ * Based on ili9341.c:
+ * Copyright 2018 David Lechner <david@lechnology.com>
+ *
+ * Based on mi0283qt.c:
+ * Copyright 2016 Noralf Trønnes
+ */
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_mipi_dbi.h>
+#include <drm/drm_modeset_helper.h>
+#include <video/mipi_display.h>
+
+#define ILI9341_FRMCTR1		0xb1
+#define ILI9341_DISCTRL		0xb6
+#define ILI9341_ETMOD		0xb7
+
+#define ILI9341_PWCTRL1		0xc0
+#define ILI9341_PWCTRL2		0xc1
+#define ILI9341_VMCTRL1		0xc5
+#define ILI9341_VMCTRL2		0xc7
+#define ILI9341_PWCTRLA		0xcb
+#define ILI9341_PWCTRLB		0xcf
+
+#define ILI9341_PGAMCTRL	0xe0
+#define ILI9341_NGAMCTRL	0xe1
+#define ILI9341_DTCTRLA		0xe8
+#define ILI9341_DTCTRLB		0xea
+#define ILI9341_PWRSEQ		0xed
+
+#define ILI9341_EN3GAM		0xf2
+#define ILI9341_PUMPCTRL	0xf7
+
+#define ILI9341_MADCTL_BGR	BIT(3)
+#define ILI9341_MADCTL_MV	BIT(5)
+#define ILI9341_MADCTL_MX	BIT(6)
+#define ILI9341_MADCTL_MY	BIT(7)
+
+static void yx240qv29_enable(struct drm_simple_display_pipe *pipe,
+			     struct drm_crtc_state *crtc_state,
+			     struct drm_plane_state *plane_state)
+{
+	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(pipe->crtc.dev);
+	struct mipi_dbi *dbi = &dbidev->dbi;
+	u8 addr_mode;
+	int ret, idx;
+
+	if (!drm_dev_enter(pipe->crtc.dev, &idx))
+		return;
+
+	DRM_DEBUG_KMS("\n");
+
+	ret = mipi_dbi_poweron_conditional_reset(dbidev);
+	if (ret < 0)
+		goto out_exit;
+	if (ret == 1)
+		goto out_enable;
+
+	mipi_dbi_command(dbi, MIPI_DCS_SET_DISPLAY_OFF);
+
+	mipi_dbi_command(dbi, ILI9341_PWCTRLB, 0x00, 0xc1, 0x30);
+	mipi_dbi_command(dbi, ILI9341_PWRSEQ, 0x64, 0x03, 0x12, 0x81);
+	mipi_dbi_command(dbi, ILI9341_DTCTRLA, 0x85, 0x00, 0x78);
+	mipi_dbi_command(dbi, ILI9341_PWCTRLA, 0x39, 0x2c, 0x00, 0x34, 0x02);
+	mipi_dbi_command(dbi, ILI9341_PUMPCTRL, 0x20);
+	mipi_dbi_command(dbi, ILI9341_DTCTRLB, 0x00, 0x00);
+
+	/* Power Control */
+	mipi_dbi_command(dbi, ILI9341_PWCTRL1, 0x23);
+	mipi_dbi_command(dbi, ILI9341_PWCTRL2, 0x10);
+	/* VCOM */
+	mipi_dbi_command(dbi, ILI9341_VMCTRL1, 0x3e, 0x28);
+	mipi_dbi_command(dbi, ILI9341_VMCTRL2, 0x86);
+
+	/* Memory Access Control */
+	mipi_dbi_command(dbi, MIPI_DCS_SET_PIXEL_FORMAT, MIPI_DCS_PIXEL_FMT_16BIT);
+
+	/* Frame Rate */
+	mipi_dbi_command(dbi, ILI9341_FRMCTR1, 0x00, 0x1b);
+
+	/* Gamma */
+	mipi_dbi_command(dbi, ILI9341_EN3GAM, 0x00);
+	mipi_dbi_command(dbi, MIPI_DCS_SET_GAMMA_CURVE, 0x01);
+	mipi_dbi_command(dbi, ILI9341_PGAMCTRL,
+			 0x0f, 0x31, 0x2b, 0x0c, 0x0e, 0x08, 0x4e, 0xf1,
+			 0x37, 0x07, 0x10, 0x03, 0x0e, 0x09, 0x00);
+	mipi_dbi_command(dbi, ILI9341_NGAMCTRL,
+			 0x00, 0x0e, 0x14, 0x03, 0x11, 0x07, 0x31, 0xc1,
+			 0x48, 0x08, 0x0f, 0x0c, 0x31, 0x36, 0x0f);
+
+	/* DDRAM */
+	mipi_dbi_command(dbi, ILI9341_ETMOD, 0x07);
+
+	/* Display */
+	mipi_dbi_command(dbi, ILI9341_DISCTRL, 0x08, 0x82, 0x27, 0x00);
+	mipi_dbi_command(dbi, MIPI_DCS_EXIT_SLEEP_MODE);
+	msleep(100);
+
+	mipi_dbi_command(dbi, MIPI_DCS_SET_DISPLAY_ON);
+	msleep(100);
+
+out_enable:
+	switch (dbidev->rotation) {
+	default:
+		addr_mode = ILI9341_MADCTL_MX;
+		break;
+	case 90:
+		addr_mode = ILI9341_MADCTL_MV;
+		break;
+	case 180:
+		addr_mode = ILI9341_MADCTL_MY;
+		break;
+	case 270:
+		addr_mode = ILI9341_MADCTL_MV | ILI9341_MADCTL_MY |
+			    ILI9341_MADCTL_MX;
+		break;
+	}
+	addr_mode |= ILI9341_MADCTL_BGR;
+	mipi_dbi_command(dbi, MIPI_DCS_SET_ADDRESS_MODE, addr_mode);
+	mipi_dbi_enable_flush(dbidev, crtc_state, plane_state);
+out_exit:
+	drm_dev_exit(idx);
+}
+
+static const struct drm_simple_display_pipe_funcs ili9341gpio_pipe_funcs = {
+	.enable = yx240qv29_enable,
+	.disable = mipi_dbi_pipe_disable,
+	.update = mipi_dbi_pipe_update,
+	.prepare_fb = drm_gem_fb_simple_display_pipe_prepare_fb,
+};
+
+static const struct drm_display_mode yx240qv29_mode = {
+	DRM_SIMPLE_MODE(240, 320, 37, 49),
+};
+
+DEFINE_DRM_GEM_CMA_FOPS(ili9341gpio_fops);
+
+static struct drm_driver ili9341gpio_driver = {
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
+	.fops			= &ili9341gpio_fops,
+	.release		= mipi_dbi_release,
+	DRM_GEM_CMA_VMAP_DRIVER_OPS,
+	.debugfs_init		= mipi_dbi_debugfs_init,
+	.name			= "ili9341gpio",
+	.desc			= "Ilitek ILI9341",
+	.date			= "20201114",
+	.major			= 1,
+	.minor			= 0,
+};
+
+static const struct of_device_id ili9341gpio_of_match[] = {
+	{ .compatible = "ronbo,mrb2801" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ili9341gpio_of_match);
+
+static int ili9341gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mipi_dbi_dev *dbidev;
+	struct drm_device *drm;
+	struct mipi_dbi *dbi;
+	struct gpio_desc *dc;
+	struct gpio_desc *wr;
+	struct gpio_descs *db;
+	u32 rotation = 0;
+	u32 wr_delays[2] = {15, 60};
+	int ret;
+
+	dbidev = kzalloc(sizeof(*dbidev), GFP_KERNEL);
+	if (!dbidev)
+		return -ENOMEM;
+
+	dbi = &dbidev->dbi;
+	drm = &dbidev->drm;
+	ret = devm_drm_dev_init(dev, drm, &ili9341gpio_driver);
+	if (ret) {
+		kfree(dbidev);
+		return ret;
+	}
+
+	drm_mode_config_init(drm);
+
+	dbi->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(dbi->reset)) {
+		DRM_DEV_ERROR(dev, "Failed to get gpio 'reset'\n");
+		return PTR_ERR(dbi->reset);
+	}
+
+	dc = devm_gpiod_get(dev, "dc", GPIOD_OUT_HIGH);
+	if (IS_ERR(dc)) {
+		DRM_DEV_ERROR(dev, "Failed to get gpio 'dc'\n");
+		return PTR_ERR(dc);
+	}
+
+	wr = devm_gpiod_get(dev, "wr", GPIOD_OUT_HIGH);
+	if (IS_ERR(wr)) {
+		DRM_DEV_ERROR(dev, "Failed to get gpio 'wr'\n");
+		return PTR_ERR(wr);
+	}
+
+	db = devm_gpiod_get_array(dev, "db", GPIOD_OUT_LOW);
+	if (IS_ERR(db)) {
+		DRM_DEV_ERROR(dev, "Failed to get gpio 'db'\n");
+		return PTR_ERR(db);
+	}
+	if (db->ndescs != 16 && db->ndescs != 8) {
+		/*
+		 * The data bus can be either 8 or 16 bits wide.
+		 * ILI9341 can work with 6, 8, 9, 16, and 18-bit parallel interfaces,
+		 * but the MRB2801 board supports only 8 or 16-bit interfaces.
+		 */
+		DRM_DEV_ERROR(dev, "Wrong number of bits in gpio 'db': %u\n", db->ndescs);
+		return PTR_ERR(db);
+	}
+
+	dbidev->backlight = devm_of_find_backlight(dev);
+	if (IS_ERR(dbidev->backlight))
+		return PTR_ERR(dbidev->backlight);
+
+	device_property_read_u32(dev, "rotation", &rotation);
+
+	device_property_read_u32_array(dev, "wr-up-down-delays", wr_delays, 2);
+
+	ret = mipi_dbi_gpio_init(dbi, dc, wr, db, wr_delays[0], wr_delays[1]);
+	if (ret)
+		return ret;
+
+	ret = mipi_dbi_dev_init(dbidev, &ili9341gpio_pipe_funcs, &yx240qv29_mode, rotation);
+	if (ret)
+		return ret;
+
+	drm_mode_config_reset(drm);
+
+	ret = drm_dev_register(drm, 0);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, drm);
+
+	drm_fbdev_generic_setup(drm, 0);
+
+	return 0;
+}
+
+static int ili9341gpio_remove(struct platform_device *pdev)
+{
+	struct drm_device *drm = platform_get_drvdata(pdev);
+
+	drm_dev_unplug(drm);
+	drm_atomic_helper_shutdown(drm);
+
+	return 0;
+}
+
+static void ili9341gpio_shutdown(struct platform_device *pdev)
+{
+	drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
+}
+
+static struct platform_driver ili9341gpio_platform_driver = {
+	.driver = {
+		.name = "ili9341gpio",
+		.of_match_table = ili9341gpio_of_match,
+	},
+	.probe = ili9341gpio_probe,
+	.remove = ili9341gpio_remove,
+	.shutdown = ili9341gpio_shutdown,
+};
+module_platform_driver(ili9341gpio_platform_driver);
+
+MODULE_DESCRIPTION("Ilitek ILI9341 8/16-bit DRM driver");
+MODULE_AUTHOR("Mikhail Durnev <mikhail_durnev@mentor.com>");
+MODULE_LICENSE("GPL");
-- 
2.7.4

