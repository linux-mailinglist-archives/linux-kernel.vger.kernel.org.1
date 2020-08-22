Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FDB24E8DC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 18:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgHVQeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Aug 2020 12:34:01 -0400
Received: from crapouillou.net ([89.234.176.41]:48818 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728514AbgHVQd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 12:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1598113996; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ot+OLl2OehJoVZvVut+C5SEW82prMAhsTeEAtBLKr0=;
        b=F05LZ8vw/O2vponDBVKa7u+40ArVhvDhrTYRliwWVI2R0bL6deAttV/m/qL3LsCEPCtT0D
        Kg61W9YR6ySBEcef77IucE58hOct6lAAURRjCewGfSVkvCTV47tBdproMCrIVg6riAfoTq
        aPDOXQQRZeuOahsq/kNomfe9AK6fgBI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Noralf Tronnes <noralf@tronnes.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 6/6] drm/panel: Add Ilitek ILI9341 DBI panel driver
Date:   Sat, 22 Aug 2020 18:32:50 +0200
Message-Id: <20200822163250.63664-7-paul@crapouillou.net>
In-Reply-To: <20200822163250.63664-1-paul@crapouillou.net>
References: <20200822163250.63664-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is for the Ilitek ILI9341 based YX240QV29-T 2.4" 240x320 TFT
LCD panel from Adafruit.

v2: - Remove custom handling of backlight
    - Call drm_panel_disable() / drm_panel_unprepare() on module exit
    - drm_panel_add() is a void function now

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/panel/Kconfig                |   9 +
 drivers/gpu/drm/panel/Makefile               |   1 +
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c | 318 +++++++++++++++++++
 3 files changed, 328 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9341.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 45b003752d65..38c581e91986 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -105,6 +105,15 @@ config DRM_PANEL_ILITEK_IL9322
 	  Say Y here if you want to enable support for Ilitek IL9322
 	  QVGA (320x240) RGB, YUV and ITU-T BT.656 panels.
 
+config DRM_PANEL_ILITEK_ILI9341
+	tristate "Ilitek ILI9341 320x240 QVGA panels"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y here if you want to enable support for Ilitek IL9341
+	  QVGA (320x240) RGB, YUV and ITU-T BT.656 panels.
+
 config DRM_PANEL_ILITEK_ILI9881C
 	tristate "Ilitek ILI9881C-based panels"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index c01743cdc08b..d732c2b8a747 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_DRM_PANEL_ELIDA_KD35T133) += panel-elida-kd35t133.o
 obj-$(CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02) += panel-feixin-k101-im2ba02.o
 obj-$(CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D) += panel-feiyang-fy07024di26a30d.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
+obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9341) += panel-ilitek-ili9341.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) += panel-ilitek-ili9881c.o
 obj-$(CONFIG_DRM_PANEL_INNOLUX_P079ZCA) += panel-innolux-p079zca.o
 obj-$(CONFIG_DRM_PANEL_JDI_LT070ME05000) += panel-jdi-lt070me05000.o
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
new file mode 100644
index 000000000000..8f32edaac627
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DRM driver for Ilitek ILI9341 panels
+ *
+ * Copyright 2018 David Lechner <david@lechnology.com>
+ * Copyright 2020 Paul Cercueil <paul@crapouillou.net>
+ *
+ * Based on mi0283qt.c:
+ * Copyright 2016 Noralf Trønnes
+ */
+
+#include <linux/delay.h>
+#include <linux/dma-buf.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of_graph.h>
+#include <linux/property.h>
+#include <drm/drm_atomic_helper.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
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
+struct ili9341_pdata {
+	struct drm_display_mode mode;
+	unsigned int width_mm;
+	unsigned int height_mm;
+	unsigned int bus_type;
+	unsigned int lanes;
+};
+
+struct ili9341 {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi;
+	const struct ili9341_pdata *pdata;
+
+	struct gpio_desc	*reset_gpiod;
+	u32 rotation;
+};
+
+#define mipi_dcs_command(dsi, cmd, seq...) \
+({ \
+	u8 d[] = { seq }; \
+	mipi_dsi_dcs_write(dsi, cmd, d, ARRAY_SIZE(d)); \
+})
+
+static inline struct ili9341 *panel_to_ili9341(struct drm_panel *panel)
+{
+	return container_of(panel, struct ili9341, panel);
+}
+
+static int ili9341_prepare(struct drm_panel *panel)
+{
+	struct ili9341 *priv = panel_to_ili9341(panel);
+	struct mipi_dsi_device *dsi = priv->dsi;
+	u8 addr_mode;
+	int ret;
+
+	gpiod_set_value_cansleep(priv->reset_gpiod, 0);
+	usleep_range(20, 1000);
+	gpiod_set_value_cansleep(priv->reset_gpiod, 1);
+	msleep(120);
+
+	ret = mipi_dcs_command(dsi, MIPI_DCS_SOFT_RESET);
+	if (ret) {
+		dev_err(panel->dev, "Failed to send reset command: %d\n", ret);
+		return ret;
+	}
+
+	/* Wait 5ms after soft reset per MIPI DCS spec */
+	usleep_range(5000, 20000);
+
+	mipi_dcs_command(dsi, MIPI_DCS_SET_DISPLAY_OFF);
+
+	mipi_dcs_command(dsi, ILI9341_PWCTRLB, 0x00, 0xc1, 0x30);
+	mipi_dcs_command(dsi, ILI9341_PWRSEQ, 0x64, 0x03, 0x12, 0x81);
+	mipi_dcs_command(dsi, ILI9341_DTCTRLA, 0x85, 0x00, 0x78);
+	mipi_dcs_command(dsi, ILI9341_PWCTRLA, 0x39, 0x2c, 0x00, 0x34, 0x02);
+	mipi_dcs_command(dsi, ILI9341_PUMPCTRL, 0x20);
+	mipi_dcs_command(dsi, ILI9341_DTCTRLB, 0x00, 0x00);
+
+	/* Power Control */
+	mipi_dcs_command(dsi, ILI9341_PWCTRL1, 0x23);
+	mipi_dcs_command(dsi, ILI9341_PWCTRL2, 0x10);
+	/* VCOM */
+	mipi_dcs_command(dsi, ILI9341_VMCTRL1, 0x3e, 0x28);
+	mipi_dcs_command(dsi, ILI9341_VMCTRL2, 0x86);
+
+	/* Memory Access Control */
+	mipi_dcs_command(dsi, MIPI_DCS_SET_PIXEL_FORMAT, MIPI_DCS_PIXEL_FMT_16BIT);
+
+	/* Frame Rate */
+	mipi_dcs_command(dsi, ILI9341_FRMCTR1, 0x00, 0x1b);
+
+	/* Gamma */
+	mipi_dcs_command(dsi, ILI9341_EN3GAM, 0x00);
+	mipi_dcs_command(dsi, MIPI_DCS_SET_GAMMA_CURVE, 0x01);
+	mipi_dcs_command(dsi, ILI9341_PGAMCTRL,
+			 0x0f, 0x31, 0x2b, 0x0c, 0x0e, 0x08, 0x4e, 0xf1,
+			 0x37, 0x07, 0x10, 0x03, 0x0e, 0x09, 0x00);
+	mipi_dcs_command(dsi, ILI9341_NGAMCTRL,
+			 0x00, 0x0e, 0x14, 0x03, 0x11, 0x07, 0x31, 0xc1,
+			 0x48, 0x08, 0x0f, 0x0c, 0x31, 0x36, 0x0f);
+
+	/* DDRAM */
+	mipi_dcs_command(dsi, ILI9341_ETMOD, 0x07);
+
+	/* Display */
+	mipi_dcs_command(dsi, ILI9341_DISCTRL, 0x08, 0x82, 0x27, 0x00);
+	mipi_dcs_command(dsi, MIPI_DCS_EXIT_SLEEP_MODE);
+	msleep(100);
+
+	mipi_dcs_command(dsi, MIPI_DCS_SET_DISPLAY_ON);
+	msleep(100);
+
+	switch (priv->rotation) {
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
+	mipi_dcs_command(dsi, MIPI_DCS_SET_ADDRESS_MODE, addr_mode);
+
+	return 0;
+}
+
+static int ili9341_unprepare(struct drm_panel *panel)
+{
+	struct ili9341 *priv = panel_to_ili9341(panel);
+
+	mipi_dcs_command(priv->dsi, MIPI_DCS_SET_DISPLAY_OFF);
+
+	return 0;
+}
+
+static int ili9341_get_modes(struct drm_panel *panel,
+			     struct drm_connector *connector)
+{
+	struct ili9341 *priv = panel_to_ili9341(panel);
+	struct drm_display_mode *mode;
+	u32 format = MEDIA_BUS_FMT_RGB565_1X16;
+
+	mode = drm_mode_duplicate(connector->dev, &priv->pdata->mode);
+	if (!mode) {
+		dev_err(panel->dev, "failed to add mode %ux%u\n",
+			priv->pdata->mode.hdisplay, priv->pdata->mode.vdisplay);
+		return -ENOMEM;
+	}
+
+	drm_mode_set_name(mode);
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	drm_mode_probed_add(connector, mode);
+
+	connector->display_info.bpc = 8;
+	connector->display_info.width_mm = priv->pdata->width_mm;
+	connector->display_info.height_mm = priv->pdata->height_mm;
+
+	drm_display_info_set_bus_formats(&connector->display_info, &format, 1);
+	connector->display_info.bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE;
+
+	return 1;
+}
+
+static const struct drm_panel_funcs ili9341_funcs = {
+	.prepare	= ili9341_prepare,
+	.unprepare	= ili9341_unprepare,
+	.get_modes	= ili9341_get_modes,
+};
+
+static int ili9341_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct ili9341 *priv;
+	int ret;
+
+	/* See comment for mipi_dbi_spi_init() */
+	if (!dev->coherent_dma_mask) {
+		ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
+		if (ret) {
+			dev_warn(dev, "Failed to set dma mask %d\n", ret);
+			return ret;
+		}
+	}
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	mipi_dsi_set_drvdata(dsi, priv);
+	priv->dsi = dsi;
+
+	device_property_read_u32(dev, "rotation", &priv->rotation);
+
+	priv->pdata = device_get_match_data(dev);
+	if (!priv->pdata)
+		return -EINVAL;
+
+	drm_panel_init(&priv->panel, dev, &ili9341_funcs,
+		       DRM_MODE_CONNECTOR_DPI);
+
+	priv->reset_gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->reset_gpiod)) {
+		dev_err(dev, "Couldn't get our reset GPIO\n");
+		return PTR_ERR(priv->reset_gpiod);
+	}
+
+	ret = drm_panel_of_backlight(&priv->panel);
+	if (ret < 0) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get backlight handle\n");
+		return ret;
+	}
+
+	drm_panel_add(&priv->panel);
+
+	dsi->bus_type = priv->pdata->bus_type;
+	dsi->lanes = priv->pdata->lanes;
+	dsi->format = MIPI_DSI_FMT_RGB565;
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret) {
+		dev_err(dev, "Failed to attach DSI panel\n");
+		goto err_panel_remove;
+	}
+
+	ret = mipi_dsi_maybe_register_tiny_driver(dsi);
+	if (ret) {
+		dev_err(dev, "Failed to init TinyDRM driver\n");
+		goto err_mipi_dsi_detach;
+	}
+
+	return 0;
+
+err_mipi_dsi_detach:
+	mipi_dsi_detach(dsi);
+err_panel_remove:
+	drm_panel_remove(&priv->panel);
+	return ret;
+}
+
+static int ili9341_remove(struct mipi_dsi_device *dsi)
+{
+	struct ili9341 *priv = mipi_dsi_get_drvdata(dsi);
+
+	mipi_dsi_detach(dsi);
+	drm_panel_remove(&priv->panel);
+
+	drm_panel_disable(&priv->panel);
+	drm_panel_unprepare(&priv->panel);
+
+	return 0;
+}
+
+static const struct ili9341_pdata yx240qv29_pdata = {
+	.mode = { DRM_SIMPLE_MODE(240, 320, 37, 49) },
+	.width_mm = 0, // TODO
+	.height_mm = 0, // TODO
+	.bus_type = MIPI_DCS_BUS_TYPE_DBI_SPI_C3,
+	.lanes = 1,
+};
+
+static const struct of_device_id ili9341_of_match[] = {
+	{ .compatible = "adafruit,yx240qv29", .data = &yx240qv29_pdata },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ili9341_of_match);
+
+static struct mipi_dsi_driver ili9341_dsi_driver = {
+	.probe		= ili9341_probe,
+	.remove		= ili9341_remove,
+	.driver = {
+		.name		= "ili9341-dsi",
+		.of_match_table	= ili9341_of_match,
+	},
+};
+module_mipi_dsi_driver(ili9341_dsi_driver);
+
+MODULE_DESCRIPTION("Ilitek ILI9341 DRM panel driver");
+MODULE_AUTHOR("David Lechner <david@lechnology.com>");
+MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
+MODULE_LICENSE("GPL");
-- 
2.28.0

