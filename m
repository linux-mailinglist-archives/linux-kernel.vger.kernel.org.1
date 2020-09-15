Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C38B26A500
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgIOMVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgIOMTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:19:35 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B0FC061352
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:19:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w2so3164631wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xFKEais/JinAAfcewjMMwYVj5kDYRr5zvHtIDXxFhJI=;
        b=kJqKabpDzG9rY15A2JugDLVEZyD+xnHAuwwzhPNzsJQTuny/wge6/0BG4hjMI+Vk0G
         DgwH1VY0zEqetth/0kXEP6A0htecelpogpAl2X3yecDTcFFUbaRuhNBYUbWkZ1hUncpB
         /pf6g5quCmLXwO6iwt18TU9vsUUv6fM1k6S5jguq1pifkXN46sMiHFlB/b43Armc8zid
         6k2J7tMjOzg2d2gDvGrxZABDwo+tp3hugKpougqC8zYxBA7hcUY0n/FrTAuvGVGQcm/W
         aCO17yPy6z4nQ7ckry6QokqX+jk+1+Bwsqyej58yj9v3EPTglNdHSBvbXl0+1g2wkfm0
         PRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xFKEais/JinAAfcewjMMwYVj5kDYRr5zvHtIDXxFhJI=;
        b=tcgqgnIVOBau3738qOA/MCWuSBYEGjbkqs05b6FV5KboLbZwyA32gAI+Mf26Te/DBK
         xBj0o+iZb5lZHcve7Fs8oKKQJSHbia7Pwd8ffuScI3AMlcc8zXhCgsUJZY6oNKJNafmx
         D4DowSduz83JH54WHZjtedYlKP5b+TB7xinz/GWk4kGl2dPzqWClSSA+d96dpiS4zCak
         XEsCMwLK9WRzlgX/s2r5dW/RL1OulYyXM4WCN5Kulb9w5WKHTqf+rykuKXDaMYSMVtCb
         h866pljiPbwA+UGEU/NHAQeB10ICE40Tf7uUU+Ziv75UhCzSeSw7WBAVDkF9kssxKxGB
         7L2g==
X-Gm-Message-State: AOAM530Zv5LCJZADJ0k+1cDpijjijLzdz7T5rquBD/Fq1QGhR5JiTwfM
        rSEQN8gKRxdTQ/JP+xJG+pvdkQj7/1h8ZwtF
X-Google-Smtp-Source: ABdhPJzbl4xNPqEXZTtO5aVOs1q0PEHsokfzharZYkIYfXkmTC281eV2cDIStMZqcvhrXPDqqIVa9w==
X-Received: by 2002:a05:600c:2909:: with SMTP id i9mr4704279wmd.160.1600172362161;
        Tue, 15 Sep 2020 05:19:22 -0700 (PDT)
Received: from bender.baylibre.local (home.beaume.starnux.net. [82.236.8.43])
        by smtp.gmail.com with ESMTPSA id 2sm18271411wmf.25.2020.09.15.05.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 05:19:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v4 4/4] drm: panel: add TDO tl070wsh30 panel driver
Date:   Tue, 15 Sep 2020 14:19:12 +0200
Message-Id: <20200915121912.4347-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200915121912.4347-1-narmstrong@baylibre.com>
References: <20200915121912.4347-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the TDO TL070WSH30 TFT-LCD panel module.
The panel has a 1024×600 resolution and uses 24 bit RGB per pixel.
It provides a MIPI DSI interface to the host, a built-in LED backlight
and touch controller.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/panel/Kconfig                |  11 +
 drivers/gpu/drm/panel/Makefile               |   1 +
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 250 +++++++++++++++++++
 3 files changed, 262 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 8d97d07c5871..2d488a875b99 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -433,6 +433,17 @@ config DRM_PANEL_SONY_ACX565AKM
 	  Say Y here if you want to enable support for the Sony ACX565AKM
 	  800x600 3.5" panel (found on the Nokia N900).
 
+config DRM_PANEL_TDO_TL070WSH30
+	tristate "TDO TL070WSH30 DSI panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y here if you want to enable support for TDO TL070WSH30 TFT-LCD
+	  panel module. The panel has a 1024×600 resolution and uses
+	  24 bit RGB per pixel. It provides a MIPI DSI interface to
+	  the host, a built-in LED backlight and touch controller.
+
 config DRM_PANEL_TPO_TD028TTEC1
 	tristate "Toppoly (TPO) TD028TTEC1 panel driver"
 	depends on OF && SPI
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 15a4e7752951..35ee06a1b5c2 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7703) += panel-sitronix-st7703.o
 obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7789V) += panel-sitronix-st7789v.o
 obj-$(CONFIG_DRM_PANEL_SONY_ACX424AKP) += panel-sony-acx424akp.o
 obj-$(CONFIG_DRM_PANEL_SONY_ACX565AKM) += panel-sony-acx565akm.o
+obj-$(CONFIG_DRM_PANEL_TDO_TL070WSH30) += panel-tdo-tl070wsh30.o
 obj-$(CONFIG_DRM_PANEL_TPO_TD028TTEC1) += panel-tpo-td028ttec1.o
 obj-$(CONFIG_DRM_PANEL_TPO_TD043MTEA1) += panel-tpo-td043mtea1.o
 obj-$(CONFIG_DRM_PANEL_TPO_TPG110) += panel-tpo-tpg110.o
diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
new file mode 100644
index 000000000000..820731be7147
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/mipi_display.h>
+
+#include <drm/drm_crtc.h>
+#include <drm/drm_device.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+
+struct tdo_tl070wsh30_panel {
+	struct drm_panel base;
+	struct mipi_dsi_device *link;
+
+	struct regulator *supply;
+	struct gpio_desc *reset_gpio;
+
+	bool prepared;
+};
+
+static inline
+struct tdo_tl070wsh30_panel *to_tdo_tl070wsh30_panel(struct drm_panel *panel)
+{
+	return container_of(panel, struct tdo_tl070wsh30_panel, base);
+}
+
+static int tdo_tl070wsh30_panel_prepare(struct drm_panel *panel)
+{
+	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = to_tdo_tl070wsh30_panel(panel);
+	int err;
+
+	if (tdo_tl070wsh30->prepared)
+		return 0;
+
+	err = regulator_enable(tdo_tl070wsh30->supply);
+	if (err < 0)
+		return err;
+
+	usleep_range(10000, 11000);
+
+	gpiod_set_value_cansleep(tdo_tl070wsh30->reset_gpio, 1);
+
+	usleep_range(10000, 11000);
+
+	gpiod_set_value_cansleep(tdo_tl070wsh30->reset_gpio, 0);
+
+	msleep(200);
+
+	err = mipi_dsi_dcs_exit_sleep_mode(tdo_tl070wsh30->link);
+	if (err < 0) {
+		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
+		regulator_disable(tdo_tl070wsh30->supply);
+		return err;
+	}
+
+	msleep(200);
+
+	err = mipi_dsi_dcs_set_display_on(tdo_tl070wsh30->link);
+	if (err < 0) {
+		dev_err(panel->dev, "failed to set display on: %d\n", err);
+		regulator_disable(tdo_tl070wsh30->supply);
+		return err;
+	}
+
+	msleep(20);
+
+	tdo_tl070wsh30->prepared = true;
+
+	return 0;
+}
+
+static int tdo_tl070wsh30_panel_unprepare(struct drm_panel *panel)
+{
+	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = to_tdo_tl070wsh30_panel(panel);
+	int err;
+
+	if (!tdo_tl070wsh30->prepared)
+		return 0;
+
+	err = mipi_dsi_dcs_set_display_off(tdo_tl070wsh30->link);
+	if (err < 0)
+		dev_err(panel->dev, "failed to set display off: %d\n", err);
+
+	usleep_range(10000, 11000);
+
+	err = mipi_dsi_dcs_enter_sleep_mode(tdo_tl070wsh30->link);
+	if (err < 0) {
+		dev_err(panel->dev, "failed to enter sleep mode: %d\n", err);
+		return err;
+	}
+
+	usleep_range(10000, 11000);
+
+	regulator_disable(tdo_tl070wsh30->supply);
+
+	tdo_tl070wsh30->prepared = false;
+
+	return 0;
+}
+
+static const struct drm_display_mode default_mode = {
+	.clock = 47250,
+	.hdisplay = 1024,
+	.hsync_start = 1024 + 46,
+	.hsync_end = 1024 + 46 + 80,
+	.htotal = 1024 + 46 + 80 + 100,
+	.vdisplay = 600,
+	.vsync_start = 600 + 5,
+	.vsync_end = 600 + 5 + 5,
+	.vtotal = 600 + 5 + 5 + 20,
+	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
+};
+
+static int tdo_tl070wsh30_panel_get_modes(struct drm_panel *panel,
+				       struct drm_connector *connector)
+{
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(connector->dev, &default_mode);
+	if (!mode) {
+		dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
+			default_mode.hdisplay, default_mode.vdisplay,
+			drm_mode_vrefresh(&default_mode));
+		return -ENOMEM;
+	}
+
+	drm_mode_set_name(mode);
+
+	drm_mode_probed_add(connector, mode);
+
+	connector->display_info.width_mm = 154;
+	connector->display_info.height_mm = 85;
+	connector->display_info.bpc = 8;
+
+	return 1;
+}
+
+static const struct drm_panel_funcs tdo_tl070wsh30_panel_funcs = {
+	.unprepare = tdo_tl070wsh30_panel_unprepare,
+	.prepare = tdo_tl070wsh30_panel_prepare,
+	.get_modes = tdo_tl070wsh30_panel_get_modes,
+};
+
+static const struct of_device_id tdo_tl070wsh30_of_match[] = {
+	{ .compatible = "tdo,tl070wsh30", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, tdo_tl070wsh30_of_match);
+
+static int tdo_tl070wsh30_panel_add(struct tdo_tl070wsh30_panel *tdo_tl070wsh30)
+{
+	struct device *dev = &tdo_tl070wsh30->link->dev;
+	int err;
+
+	tdo_tl070wsh30->supply = devm_regulator_get(dev, "power");
+	if (IS_ERR(tdo_tl070wsh30->supply))
+		return PTR_ERR(tdo_tl070wsh30->supply);
+
+	tdo_tl070wsh30->reset_gpio = devm_gpiod_get(dev, "reset",
+						    GPIOD_OUT_LOW);
+	if (IS_ERR(tdo_tl070wsh30->reset_gpio)) {
+		err = PTR_ERR(tdo_tl070wsh30->reset_gpio);
+		dev_dbg(dev, "failed to get reset gpio: %d\n", err);
+		return err;
+	}
+
+	drm_panel_init(&tdo_tl070wsh30->base, &tdo_tl070wsh30->link->dev,
+		       &tdo_tl070wsh30_panel_funcs, DRM_MODE_CONNECTOR_DSI);
+
+	err = drm_panel_of_backlight(&tdo_tl070wsh30->base);
+	if (err)
+		return err;
+
+	drm_panel_add(&tdo_tl070wsh30->base);
+
+	return 0;
+}
+
+static int tdo_tl070wsh30_panel_probe(struct mipi_dsi_device *dsi)
+{
+	struct tdo_tl070wsh30_panel *tdo_tl070wsh30;
+	int err;
+
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_LPM;
+
+	tdo_tl070wsh30 = devm_kzalloc(&dsi->dev, sizeof(*tdo_tl070wsh30),
+				    GFP_KERNEL);
+	if (!tdo_tl070wsh30)
+		return -ENOMEM;
+
+	mipi_dsi_set_drvdata(dsi, tdo_tl070wsh30);
+	tdo_tl070wsh30->link = dsi;
+
+	err = tdo_tl070wsh30_panel_add(tdo_tl070wsh30);
+	if (err < 0)
+		return err;
+
+	return mipi_dsi_attach(dsi);
+}
+
+static int tdo_tl070wsh30_panel_remove(struct mipi_dsi_device *dsi)
+{
+	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = mipi_dsi_get_drvdata(dsi);
+	int err;
+
+	err = mipi_dsi_detach(dsi);
+	if (err < 0)
+		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
+
+	drm_panel_remove(&tdo_tl070wsh30->base);
+	drm_panel_disable(&tdo_tl070wsh30->base);
+	drm_panel_unprepare(&tdo_tl070wsh30->base);
+
+	return 0;
+}
+
+static void tdo_tl070wsh30_panel_shutdown(struct mipi_dsi_device *dsi)
+{
+	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = mipi_dsi_get_drvdata(dsi);
+
+	drm_panel_disable(&tdo_tl070wsh30->base);
+	drm_panel_unprepare(&tdo_tl070wsh30->base);
+}
+
+static struct mipi_dsi_driver tdo_tl070wsh30_panel_driver = {
+	.driver = {
+		.name = "panel-tdo-tl070wsh30",
+		.of_match_table = tdo_tl070wsh30_of_match,
+	},
+	.probe = tdo_tl070wsh30_panel_probe,
+	.remove = tdo_tl070wsh30_panel_remove,
+	.shutdown = tdo_tl070wsh30_panel_shutdown,
+};
+module_mipi_dsi_driver(tdo_tl070wsh30_panel_driver);
+
+MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
+MODULE_DESCRIPTION("TDO TL070WSH30 panel driver");
+MODULE_LICENSE("GPL v2");
-- 
2.22.0

