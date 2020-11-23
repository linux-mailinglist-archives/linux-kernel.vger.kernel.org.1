Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8470C2C174A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 22:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgKWVFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 16:05:52 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:38642 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgKWVFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 16:05:52 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 204C0806FA;
        Mon, 23 Nov 2020 22:05:48 +0100 (CET)
Date:   Mon, 23 Nov 2020 22:05:46 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm: panel: add Khadas TS050 panel driver
Message-ID: <20201123210546.GB671311@ravnborg.org>
References: <20201123143354.295844-1-narmstrong@baylibre.com>
 <20201123143354.295844-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201123143354.295844-3-narmstrong@baylibre.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VafZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=8nJEP1OIZ-IA:10 a=IpJZQVW2AAAA:8 a=e5mUnYsNAAAA:8
        a=ZEZqCF8n_05vyPiGbpEA:9 a=wPNLvfGTeEIA:10 a=IawgGOuG5U0WyFbmm1f5:22
        a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil.

Looks good but a few comments in the following that needs some attention.

	Sam

On Mon, Nov 23, 2020 at 03:33:54PM +0100, Neil Armstrong wrote:
> This add support for the Khadas TS050 1080x1920 5" LCD DSI panel designed to work
> with the Khadas Edge-V, Captain, VIM3 and VIM3L Single Board Computers.
> It provides a MIPI DSI interface to the host, a built-in LED backlight
> and touch controller.
> 
> The init values was taken from the vendor source tree, comments were added to the
> know values but most of the init table is undocumented.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/panel/Kconfig              |  11 +
>  drivers/gpu/drm/panel/Makefile             |   1 +
>  drivers/gpu/drm/panel/panel-khadas-ts050.c | 876 +++++++++++++++++++++
>  3 files changed, 888 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-khadas-ts050.c
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index b4e021ea30f9..8fec45b2ce02 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -145,6 +145,17 @@ config DRM_PANEL_JDI_LT070ME05000
>  	  The panel has a 1200(RGB)×1920 (WUXGA) resolution and uses
>  	  24 bit per pixel.
>  
> +config DRM_PANEL_KHADAS_TS050
> +	tristate "Khadas TS050 panel"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Say Y here if you want to enable support for Khadas TS050 TFT-LCD
> +	  panel module. The panel has a 1080x1920 resolution and uses
> +	  24 bit RGB per pixel. It provides a MIPI DSI interface to
> +	  the host, a built-in LED backlight and touch controller.
> +
>  config DRM_PANEL_KINGDISPLAY_KD097D04
>  	tristate "Kingdisplay kd097d04 panel"
>  	depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index ebbf488c7eac..03496695e03f 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
>  obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) += panel-ilitek-ili9881c.o
>  obj-$(CONFIG_DRM_PANEL_INNOLUX_P079ZCA) += panel-innolux-p079zca.o
>  obj-$(CONFIG_DRM_PANEL_JDI_LT070ME05000) += panel-jdi-lt070me05000.o
> +obj-$(CONFIG_DRM_PANEL_KHADAS_TS050) += panel-khadas-ts050.o
>  obj-$(CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04) += panel-kingdisplay-kd097d04.o
>  obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W) += panel-leadtek-ltk050h3146w.o
>  obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829) += panel-leadtek-ltk500hd1829.o
> diff --git a/drivers/gpu/drm/panel/panel-khadas-ts050.c b/drivers/gpu/drm/panel/panel-khadas-ts050.c
> new file mode 100644
> index 000000000000..856fcad69306
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-khadas-ts050.c
> @@ -0,0 +1,876 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <video/mipi_display.h>
> +
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_print.h>
Panels do not use DRM_ or drm_ for logging, so this include is not
needed.

> +
> +struct khadas_ts050_panel {
> +	struct drm_panel base;
> +	struct mipi_dsi_device *link;
> +
> +	struct regulator *supply;
> +	struct gpio_desc *reset_gpio;
> +	struct gpio_desc *enable_gpio;
> +
> +	bool prepared;
> +	bool enabled;
> +};
> +
> +struct khadas_ts050_panel_cmd {
> +	u8 cmd;
> +	u8 data;
> +};
> +
> +/* Only the CMD1 User Command set is documented */
> +static const struct khadas_ts050_panel_cmd init_code[] = {
> +	/* Select Unknown CMD Page (Undocumented) */
> +	{0xff, 0xee},
...
> +	{0xd4, 0x04}, /* RGBMIPICTRL: VSYNC front porch = 4 */
> +};
> +
> +static inline
> +struct khadas_ts050_panel *to_khadas_ts050_panel(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct khadas_ts050_panel, base);
> +}
> +
> +static int khadas_ts050_panel_prepare(struct drm_panel *panel)
> +{
> +	struct khadas_ts050_panel *khadas_ts050 = to_khadas_ts050_panel(panel);
> +	int err, regulator_err;
> +	unsigned int i;
> +
> +	if (khadas_ts050->prepared)
> +		return 0;
> +
> +	gpiod_set_value_cansleep(khadas_ts050->enable_gpio, 0);
> +
> +	err = regulator_enable(khadas_ts050->supply);
> +	if (err < 0)
> +		return err;
> +
> +	gpiod_set_value_cansleep(khadas_ts050->enable_gpio, 1);
> +
> +	msleep(60);
> +
> +	gpiod_set_value_cansleep(khadas_ts050->reset_gpio, 1);
> +
> +	usleep_range(10000, 11000);
> +
> +	gpiod_set_value_cansleep(khadas_ts050->reset_gpio, 0);
> +
> +	/* Select CMD2 page 4 (Undocumented) */
> +	mipi_dsi_dcs_write(khadas_ts050->link, 0xff, (u8[]){ 0x05 }, 1);
> +
> +	/* Reload CMD1: Don't reload default value to register */
> +	mipi_dsi_dcs_write(khadas_ts050->link, 0xfb, (u8[]){ 0x01 }, 1);
> +
> +	mipi_dsi_dcs_write(khadas_ts050->link, 0xc5, (u8[]){ 0x01 }, 1);
> +
> +	msleep(100);
> +
> +	for (i = 0; i < ARRAY_SIZE(init_code); i++) {
> +		err = mipi_dsi_dcs_write(khadas_ts050->link,
> +					 init_code[i].cmd,
> +					 &init_code[i].data, 1);
> +		if (err < 0) {
> +			dev_err(panel->dev, "failed write cmds: %d\n", err);
> +			goto poweroff;
> +		}
> +	}
> +
> +	err = mipi_dsi_dcs_exit_sleep_mode(khadas_ts050->link);
> +	if (err < 0) {
> +		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
> +		goto poweroff;
> +	}
> +
> +	msleep(120);
> +
> +	/* Select CMD1 */
> +	mipi_dsi_dcs_write(khadas_ts050->link, 0xff, (u8[]){ 0x00 }, 1);
> +
> +	err = mipi_dsi_dcs_set_tear_on(khadas_ts050->link,
> +				       MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> +	if (err < 0) {
> +		dev_err(panel->dev, "failed to set tear on: %d\n", err);
> +		goto poweroff;
> +	}
> +
> +
> +	err = mipi_dsi_dcs_set_display_on(khadas_ts050->link);
> +	if (err < 0) {
> +		dev_err(panel->dev, "failed to set display on: %d\n", err);
> +		goto poweroff;
> +	}
> +
> +	usleep_range(10000, 11000);
> +
> +	khadas_ts050->prepared = true;
> +
> +	return 0;
> +
> +poweroff:
> +	gpiod_set_value_cansleep(khadas_ts050->enable_gpio, 0);

gpiod_set_value_cansleep(khadas_ts050->reset_gpio, 1);
??
So panel is left in reset mode.
> +
> +	regulator_err = regulator_disable(khadas_ts050->supply);
> +	if (regulator_err)
> +		dev_err(panel->dev, "failed to disable regulator: %d\n", regulator_err);
This check is not really of any value and can be dropped.

> +
> +	return err;
> +}
> +
> +static int khadas_ts050_panel_unprepare(struct drm_panel *panel)
> +{
> +	struct khadas_ts050_panel *khadas_ts050 = to_khadas_ts050_panel(panel);
> +	int err;
> +
> +	if (!khadas_ts050->prepared)
> +		return 0;
> +
> +	err = mipi_dsi_dcs_enter_sleep_mode(khadas_ts050->link);
> +	if (err < 0) {
> +		dev_err(panel->dev, "failed to enter sleep mode: %d\n", err);
> +		return err;
Hmm, even if we fail here or below the panel is no longer prepared.
I think it would be better to set prepared to false unconditionally.

Many panel drivers get this wrong.


> +	}
> +
> +	msleep(150);
> +
> +	gpiod_set_value_cansleep(khadas_ts050->enable_gpio, 0);
> +
> +	err = regulator_disable(khadas_ts050->supply);
> +	if (err < 0)
> +		return err;
> +
> +	khadas_ts050->prepared = false;
> +
> +	return 0;
> +}
> +
> +static int khadas_ts050_panel_enable(struct drm_panel *panel)
> +{
> +	struct khadas_ts050_panel *khadas_ts050 = to_khadas_ts050_panel(panel);
> +
> +	if (khadas_ts050->enabled)
> +		return 0;
No need for the check - just set it to true.
> +
> +	khadas_ts050->enabled = true;
> +
> +	return 0;
> +}
> +
> +static int khadas_ts050_panel_disable(struct drm_panel *panel)
> +{
> +	struct khadas_ts050_panel *khadas_ts050 = to_khadas_ts050_panel(panel);
> +	int err;
> +
> +	if (!khadas_ts050->enabled)
> +		return 0;
> +
> +	err = mipi_dsi_dcs_set_display_off(khadas_ts050->link);
> +	if (err < 0)
> +		dev_err(panel->dev, "failed to set display off: %d\n", err);
> +
> +	usleep_range(10000, 11000);
> +
> +	khadas_ts050->enabled = false;
> +
> +	return 0;
> +}
> +
> +static const struct drm_display_mode default_mode = {
> +	.clock = 120000,
> +	.hdisplay = 1088,
> +	.hsync_start = 1088 + 104,
> +	.hsync_end = 1088 + 104 + 4,
> +	.htotal = 1088 + 104 + 4 + 127,
> +	.vdisplay = 1920,
> +	.vsync_start = 1920 + 4,
> +	.vsync_end = 1920 + 4 + 2,
> +	.vtotal = 1920 + 4 + 2 + 3,
> +	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> +};
> +
> +static int khadas_ts050_panel_get_modes(struct drm_panel *panel,
> +				       struct drm_connector *connector)
> +{
> +	struct drm_display_mode *mode;
> +
> +	mode = drm_mode_duplicate(connector->dev, &default_mode);
> +	if (!mode) {
> +		dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
> +			default_mode.hdisplay, default_mode.vdisplay,
> +			drm_mode_vrefresh(&default_mode));
> +		return -ENOMEM;
> +	}
> +
> +	drm_mode_set_name(mode);
> +
> +	drm_mode_probed_add(connector, mode);
> +
> +	connector->display_info.width_mm = 64;
> +	connector->display_info.height_mm = 118;
> +	connector->display_info.bpc = 8;
> +
> +	return 1;
> +}
> +
> +static const struct drm_panel_funcs khadas_ts050_panel_funcs = {
> +	.prepare = khadas_ts050_panel_prepare,
> +	.unprepare = khadas_ts050_panel_unprepare,
> +	.enable = khadas_ts050_panel_enable,
> +	.disable = khadas_ts050_panel_disable,
> +	.get_modes = khadas_ts050_panel_get_modes,
> +};
> +
> +static const struct of_device_id khadas_ts050_of_match[] = {
> +	{ .compatible = "khadas,ts050", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, khadas_ts050_of_match);
> +
> +static int khadas_ts050_panel_add(struct khadas_ts050_panel *khadas_ts050)
> +{
> +	struct device *dev = &khadas_ts050->link->dev;
> +	int err;
> +
> +	khadas_ts050->supply = devm_regulator_get(dev, "power");
> +	if (IS_ERR(khadas_ts050->supply))
> +		return PTR_ERR(khadas_ts050->supply);
Use return dev_err_probbe(dev, PTR_ERR(khadas_ts050->supply), "failed to get power supply");


> +
> +	khadas_ts050->reset_gpio = devm_gpiod_get(dev, "reset",
> +						   GPIOD_OUT_LOW);
> +	if (IS_ERR(khadas_ts050->reset_gpio)) {
> +		err = PTR_ERR(khadas_ts050->reset_gpio);
> +		dev_dbg(dev, "failed to get reset gpio: %d\n", err);
> +		return err;
Likewise - use return dev_err_probe(...);

> +
> +	khadas_ts050->enable_gpio = devm_gpiod_get(dev, "enable",
> +						   GPIOD_OUT_HIGH);
> +	if (IS_ERR(khadas_ts050->enable_gpio)) {
> +		err = PTR_ERR(khadas_ts050->enable_gpio);
> +		dev_dbg(dev, "failed to get enable gpio: %d\n", err);
> +		return err;
> +	}
dev_err_probe()

> +
> +	drm_panel_init(&khadas_ts050->base, &khadas_ts050->link->dev,
> +		       &khadas_ts050_panel_funcs, DRM_MODE_CONNECTOR_DSI);
> +
> +	err = drm_panel_of_backlight(&khadas_ts050->base);
> +	if (err)
> +		return err;
> +
> +	drm_panel_add(&khadas_ts050->base);
> +
> +	return 0;
> +}
> +
> +static int khadas_ts050_panel_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct khadas_ts050_panel *khadas_ts050;
> +	int err;
> +
> +	dsi->lanes = 4;
> +	dsi->format = MIPI_DSI_FMT_RGB888;
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> +			  MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_EOT_PACKET;
> +
> +	khadas_ts050 = devm_kzalloc(&dsi->dev, sizeof(*khadas_ts050),
> +				    GFP_KERNEL);
> +	if (!khadas_ts050)
> +		return -ENOMEM;
> +
> +	mipi_dsi_set_drvdata(dsi, khadas_ts050);
> +	khadas_ts050->link = dsi;
> +
> +	err = khadas_ts050_panel_add(khadas_ts050);
> +	if (err < 0)
> +		return err;
> +
> +	return mipi_dsi_attach(dsi);
> +}
> +
> +static int khadas_ts050_panel_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct khadas_ts050_panel *khadas_ts050 = mipi_dsi_get_drvdata(dsi);
> +	int err;
> +
> +	err = mipi_dsi_detach(dsi);
> +	if (err < 0)
> +		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
> +
> +	drm_panel_remove(&khadas_ts050->base);
> +	drm_panel_disable(&khadas_ts050->base);
> +	drm_panel_unprepare(&khadas_ts050->base);
> +
> +	return 0;
> +}
> +
> +static void khadas_ts050_panel_shutdown(struct mipi_dsi_device *dsi)
> +{
> +	struct khadas_ts050_panel *khadas_ts050 = mipi_dsi_get_drvdata(dsi);
> +
> +	drm_panel_disable(&khadas_ts050->base);
> +	drm_panel_unprepare(&khadas_ts050->base);
> +}
> +
> +static struct mipi_dsi_driver khadas_ts050_panel_driver = {
> +	.driver = {
> +		.name = "panel-khadas-ts050",
> +		.of_match_table = khadas_ts050_of_match,
> +	},
> +	.probe = khadas_ts050_panel_probe,
> +	.remove = khadas_ts050_panel_remove,
> +	.shutdown = khadas_ts050_panel_shutdown,
> +};
> +module_mipi_dsi_driver(khadas_ts050_panel_driver);
> +
> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
> +MODULE_DESCRIPTION("Khadas TS050 panel driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
