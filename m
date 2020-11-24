Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053932C20E6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbgKXJIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbgKXJIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:08:17 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638EFC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 01:08:15 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r17so21544363wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 01:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B1b+jVdwePCv4M1mPmwyNJ1RfeKS1JdotglRoInvOCY=;
        b=rdS/7jx1vWdFpunFebJeRKwg7EHT2Mz6aoQKlnPpnRV50jMbVEU5FTqnLDntAc39Y3
         JLZhIkugydWdEB3p/duKbviZ8YtiX4Fom8vtEFL3DOoX/VbM7l+WvtY+14DwpKuSnby4
         S/6jyHm3wvRueBJrE8iKzzX28ztu2wymeieFXZMhutPlkh+r7FnYgpdahNb4PzoibUlP
         iVkFx1bxOnbZ3neDyDUNGfe0MmnCZ2H+6390AF8ntAA56jHjIMbImbEPdCWTXd2eGQdY
         IvA9aILq8/qfM8XiqqX6yiaUFwGUpE8G/NvbyVmn7ytBaNW5qjv2/8NX4Phx3dCytrKd
         edEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=B1b+jVdwePCv4M1mPmwyNJ1RfeKS1JdotglRoInvOCY=;
        b=F/Q2p90oXeMwGSjbQLxAeUkQn1t4Xz4VCuzXrRb1kwSKFAyMw7zhKzrHI/fvbsHhNR
         ijGRA8sm7JZmpwbkxVOV2EysE5USOUcgh5pJA9w0idJOmsr2Trczv0dz4V7QUsoBfK59
         bMb7A4Jr9GRyx9SuqGqGIPO4Ll+HiVs8PPJSm1XwMVfhI4BN4RmrVgCD+r+MLyekIFOW
         g1p7ahAy982JM9Soauj1AYFJ00gTttYCE2xXuArNhoZ9q+ueGH0iQjsDSj4FzrCPUhRZ
         HBRxnSADEU7Zf5w6Vv5CP5P6Ya4UgvjS+dgEpurfHMwkqXwB06pLv8NLkb09COTqdF6V
         7jhw==
X-Gm-Message-State: AOAM5316oPLh42ApWUbQ8snA2qdP9zM0DARV+Ddp8t7A8rcTYfF5O1rj
        rHWU+rrMjSDJz9XRZTgJIfdXaQ==
X-Google-Smtp-Source: ABdhPJzQR2OoRRpEAn0sxgzghYSc2/u6qdYYJX9vgEfRO2gZxRSaZRQ2SZsXh/Pl+kTKaxPB9Ihzww==
X-Received: by 2002:adf:fd0e:: with SMTP id e14mr3941033wrr.119.1606208893819;
        Tue, 24 Nov 2020 01:08:13 -0800 (PST)
Received: from ?IPv6:2a01:e35:2ec0:82b0:51c1:5924:5e11:c21d? ([2a01:e35:2ec0:82b0:51c1:5924:5e11:c21d])
        by smtp.gmail.com with ESMTPSA id m7sm3987457wmc.22.2020.11.24.01.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 01:08:13 -0800 (PST)
Subject: Re: [PATCH 2/2] drm: panel: add Khadas TS050 panel driver
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20201123143354.295844-1-narmstrong@baylibre.com>
 <20201123143354.295844-3-narmstrong@baylibre.com>
 <20201123210546.GB671311@ravnborg.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <8812d17a-7b8f-d21b-3473-dd6989d2fdca@baylibre.com>
Date:   Tue, 24 Nov 2020 10:08:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201123210546.GB671311@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 23/11/2020 22:05, Sam Ravnborg wrote:
> Hi Neil.
> 
> Looks good but a few comments in the following that needs some attention.
> 
> 	Sam
> 
> On Mon, Nov 23, 2020 at 03:33:54PM +0100, Neil Armstrong wrote:
>> This add support for the Khadas TS050 1080x1920 5" LCD DSI panel designed to work
>> with the Khadas Edge-V, Captain, VIM3 and VIM3L Single Board Computers.
>> It provides a MIPI DSI interface to the host, a built-in LED backlight
>> and touch controller.
>>
>> The init values was taken from the vendor source tree, comments were added to the
>> know values but most of the init table is undocumented.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/gpu/drm/panel/Kconfig              |  11 +
>>  drivers/gpu/drm/panel/Makefile             |   1 +
>>  drivers/gpu/drm/panel/panel-khadas-ts050.c | 876 +++++++++++++++++++++
>>  3 files changed, 888 insertions(+)
>>  create mode 100644 drivers/gpu/drm/panel/panel-khadas-ts050.c
>>
>> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
>> index b4e021ea30f9..8fec45b2ce02 100644
>> --- a/drivers/gpu/drm/panel/Kconfig
>> +++ b/drivers/gpu/drm/panel/Kconfig
>> @@ -145,6 +145,17 @@ config DRM_PANEL_JDI_LT070ME05000
>>  	  The panel has a 1200(RGB)×1920 (WUXGA) resolution and uses
>>  	  24 bit per pixel.
>>  
>> +config DRM_PANEL_KHADAS_TS050
>> +	tristate "Khadas TS050 panel"
>> +	depends on OF
>> +	depends on DRM_MIPI_DSI
>> +	depends on BACKLIGHT_CLASS_DEVICE
>> +	help
>> +	  Say Y here if you want to enable support for Khadas TS050 TFT-LCD
>> +	  panel module. The panel has a 1080x1920 resolution and uses
>> +	  24 bit RGB per pixel. It provides a MIPI DSI interface to
>> +	  the host, a built-in LED backlight and touch controller.
>> +
>>  config DRM_PANEL_KINGDISPLAY_KD097D04
>>  	tristate "Kingdisplay kd097d04 panel"
>>  	depends on OF
>> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
>> index ebbf488c7eac..03496695e03f 100644
>> --- a/drivers/gpu/drm/panel/Makefile
>> +++ b/drivers/gpu/drm/panel/Makefile
>> @@ -13,6 +13,7 @@ obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
>>  obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) += panel-ilitek-ili9881c.o
>>  obj-$(CONFIG_DRM_PANEL_INNOLUX_P079ZCA) += panel-innolux-p079zca.o
>>  obj-$(CONFIG_DRM_PANEL_JDI_LT070ME05000) += panel-jdi-lt070me05000.o
>> +obj-$(CONFIG_DRM_PANEL_KHADAS_TS050) += panel-khadas-ts050.o
>>  obj-$(CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04) += panel-kingdisplay-kd097d04.o
>>  obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W) += panel-leadtek-ltk050h3146w.o
>>  obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829) += panel-leadtek-ltk500hd1829.o
>> diff --git a/drivers/gpu/drm/panel/panel-khadas-ts050.c b/drivers/gpu/drm/panel/panel-khadas-ts050.c
>> new file mode 100644
>> index 000000000000..856fcad69306
>> --- /dev/null
>> +++ b/drivers/gpu/drm/panel/panel-khadas-ts050.c
>> @@ -0,0 +1,876 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2020 BayLibre, SAS
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/regulator/consumer.h>
>> +
>> +#include <video/mipi_display.h>
>> +
>> +#include <drm/drm_crtc.h>
>> +#include <drm/drm_device.h>
>> +#include <drm/drm_mipi_dsi.h>
>> +#include <drm/drm_modes.h>
>> +#include <drm/drm_panel.h>
>> +#include <drm/drm_print.h>
> Panels do not use DRM_ or drm_ for logging, so this include is not
> needed.

Ok forgot to remove this

> 
>> +
>> +struct khadas_ts050_panel {
>> +	struct drm_panel base;
>> +	struct mipi_dsi_device *link;
>> +
>> +	struct regulator *supply;
>> +	struct gpio_desc *reset_gpio;
>> +	struct gpio_desc *enable_gpio;
>> +
>> +	bool prepared;
>> +	bool enabled;
>> +};
>> +
>> +struct khadas_ts050_panel_cmd {
>> +	u8 cmd;
>> +	u8 data;
>> +};
>> +
>> +/* Only the CMD1 User Command set is documented */
>> +static const struct khadas_ts050_panel_cmd init_code[] = {
>> +	/* Select Unknown CMD Page (Undocumented) */
>> +	{0xff, 0xee},
> ...
>> +	{0xd4, 0x04}, /* RGBMIPICTRL: VSYNC front porch = 4 */
>> +};
>> +
>> +static inline
>> +struct khadas_ts050_panel *to_khadas_ts050_panel(struct drm_panel *panel)
>> +{
>> +	return container_of(panel, struct khadas_ts050_panel, base);
>> +}
>> +
>> +static int khadas_ts050_panel_prepare(struct drm_panel *panel)
>> +{
>> +	struct khadas_ts050_panel *khadas_ts050 = to_khadas_ts050_panel(panel);
>> +	int err, regulator_err;
>> +	unsigned int i;
>> +
>> +	if (khadas_ts050->prepared)
>> +		return 0;
>> +
>> +	gpiod_set_value_cansleep(khadas_ts050->enable_gpio, 0);
>> +
>> +	err = regulator_enable(khadas_ts050->supply);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	gpiod_set_value_cansleep(khadas_ts050->enable_gpio, 1);
>> +
>> +	msleep(60);
>> +
>> +	gpiod_set_value_cansleep(khadas_ts050->reset_gpio, 1);
>> +
>> +	usleep_range(10000, 11000);
>> +
>> +	gpiod_set_value_cansleep(khadas_ts050->reset_gpio, 0);
>> +
>> +	/* Select CMD2 page 4 (Undocumented) */
>> +	mipi_dsi_dcs_write(khadas_ts050->link, 0xff, (u8[]){ 0x05 }, 1);
>> +
>> +	/* Reload CMD1: Don't reload default value to register */
>> +	mipi_dsi_dcs_write(khadas_ts050->link, 0xfb, (u8[]){ 0x01 }, 1);
>> +
>> +	mipi_dsi_dcs_write(khadas_ts050->link, 0xc5, (u8[]){ 0x01 }, 1);
>> +
>> +	msleep(100);
>> +
>> +	for (i = 0; i < ARRAY_SIZE(init_code); i++) {
>> +		err = mipi_dsi_dcs_write(khadas_ts050->link,
>> +					 init_code[i].cmd,
>> +					 &init_code[i].data, 1);
>> +		if (err < 0) {
>> +			dev_err(panel->dev, "failed write cmds: %d\n", err);
>> +			goto poweroff;
>> +		}
>> +	}
>> +
>> +	err = mipi_dsi_dcs_exit_sleep_mode(khadas_ts050->link);
>> +	if (err < 0) {
>> +		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
>> +		goto poweroff;
>> +	}
>> +
>> +	msleep(120);
>> +
>> +	/* Select CMD1 */
>> +	mipi_dsi_dcs_write(khadas_ts050->link, 0xff, (u8[]){ 0x00 }, 1);
>> +
>> +	err = mipi_dsi_dcs_set_tear_on(khadas_ts050->link,
>> +				       MIPI_DSI_DCS_TEAR_MODE_VBLANK);
>> +	if (err < 0) {
>> +		dev_err(panel->dev, "failed to set tear on: %d\n", err);
>> +		goto poweroff;
>> +	}
>> +
>> +
>> +	err = mipi_dsi_dcs_set_display_on(khadas_ts050->link);
>> +	if (err < 0) {
>> +		dev_err(panel->dev, "failed to set display on: %d\n", err);
>> +		goto poweroff;
>> +	}
>> +
>> +	usleep_range(10000, 11000);
>> +
>> +	khadas_ts050->prepared = true;
>> +
>> +	return 0;
>> +
>> +poweroff:
>> +	gpiod_set_value_cansleep(khadas_ts050->enable_gpio, 0);
> 
> gpiod_set_value_cansleep(khadas_ts050->reset_gpio, 1);
> ??
> So panel is left in reset mode.

Indeed, forgot this one

>> +
>> +	regulator_err = regulator_disable(khadas_ts050->supply);
>> +	if (regulator_err)
>> +		dev_err(panel->dev, "failed to disable regulator: %d\n", regulator_err);
> This check is not really of any value and can be dropped.

ok

> 
>> +
>> +	return err;
>> +}
>> +
>> +static int khadas_ts050_panel_unprepare(struct drm_panel *panel)
>> +{
>> +	struct khadas_ts050_panel *khadas_ts050 = to_khadas_ts050_panel(panel);
>> +	int err;
>> +
>> +	if (!khadas_ts050->prepared)
>> +		return 0;
>> +
>> +	err = mipi_dsi_dcs_enter_sleep_mode(khadas_ts050->link);
>> +	if (err < 0) {
>> +		dev_err(panel->dev, "failed to enter sleep mode: %d\n", err);
>> +		return err;
> Hmm, even if we fail here or below the panel is no longer prepared.
> I think it would be better to set prepared to false unconditionally.
> 
> Many panel drivers get this wrong.

ok

> 
> 
>> +	}
>> +
>> +	msleep(150);
>> +
>> +	gpiod_set_value_cansleep(khadas_ts050->enable_gpio, 0);
>> +
>> +	err = regulator_disable(khadas_ts050->supply);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	khadas_ts050->prepared = false;
>> +
>> +	return 0;
>> +}
>> +
>> +static int khadas_ts050_panel_enable(struct drm_panel *panel)
>> +{
>> +	struct khadas_ts050_panel *khadas_ts050 = to_khadas_ts050_panel(panel);
>> +
>> +	if (khadas_ts050->enabled)
>> +		return 0;
> No need for the check - just set it to true.

ok

>> +
>> +	khadas_ts050->enabled = true;
>> +
>> +	return 0;
>> +}
>> +
>> +static int khadas_ts050_panel_disable(struct drm_panel *panel)
>> +{
>> +	struct khadas_ts050_panel *khadas_ts050 = to_khadas_ts050_panel(panel);
>> +	int err;
>> +
>> +	if (!khadas_ts050->enabled)
>> +		return 0;
>> +
>> +	err = mipi_dsi_dcs_set_display_off(khadas_ts050->link);
>> +	if (err < 0)
>> +		dev_err(panel->dev, "failed to set display off: %d\n", err);
>> +
>> +	usleep_range(10000, 11000);
>> +
>> +	khadas_ts050->enabled = false;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct drm_display_mode default_mode = {
>> +	.clock = 120000,
>> +	.hdisplay = 1088,
>> +	.hsync_start = 1088 + 104,
>> +	.hsync_end = 1088 + 104 + 4,
>> +	.htotal = 1088 + 104 + 4 + 127,
>> +	.vdisplay = 1920,
>> +	.vsync_start = 1920 + 4,
>> +	.vsync_end = 1920 + 4 + 2,
>> +	.vtotal = 1920 + 4 + 2 + 3,
>> +	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
>> +};
>> +
>> +static int khadas_ts050_panel_get_modes(struct drm_panel *panel,
>> +				       struct drm_connector *connector)
>> +{
>> +	struct drm_display_mode *mode;
>> +
>> +	mode = drm_mode_duplicate(connector->dev, &default_mode);
>> +	if (!mode) {
>> +		dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
>> +			default_mode.hdisplay, default_mode.vdisplay,
>> +			drm_mode_vrefresh(&default_mode));
>> +		return -ENOMEM;
>> +	}
>> +
>> +	drm_mode_set_name(mode);
>> +
>> +	drm_mode_probed_add(connector, mode);
>> +
>> +	connector->display_info.width_mm = 64;
>> +	connector->display_info.height_mm = 118;
>> +	connector->display_info.bpc = 8;
>> +
>> +	return 1;
>> +}
>> +
>> +static const struct drm_panel_funcs khadas_ts050_panel_funcs = {
>> +	.prepare = khadas_ts050_panel_prepare,
>> +	.unprepare = khadas_ts050_panel_unprepare,
>> +	.enable = khadas_ts050_panel_enable,
>> +	.disable = khadas_ts050_panel_disable,
>> +	.get_modes = khadas_ts050_panel_get_modes,
>> +};
>> +
>> +static const struct of_device_id khadas_ts050_of_match[] = {
>> +	{ .compatible = "khadas,ts050", },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, khadas_ts050_of_match);
>> +
>> +static int khadas_ts050_panel_add(struct khadas_ts050_panel *khadas_ts050)
>> +{
>> +	struct device *dev = &khadas_ts050->link->dev;
>> +	int err;
>> +
>> +	khadas_ts050->supply = devm_regulator_get(dev, "power");
>> +	if (IS_ERR(khadas_ts050->supply))
>> +		return PTR_ERR(khadas_ts050->supply);
> Use return dev_err_probbe(dev, PTR_ERR(khadas_ts050->supply), "failed to get power supply");

ok

> 
> 
>> +
>> +	khadas_ts050->reset_gpio = devm_gpiod_get(dev, "reset",
>> +						   GPIOD_OUT_LOW);
>> +	if (IS_ERR(khadas_ts050->reset_gpio)) {
>> +		err = PTR_ERR(khadas_ts050->reset_gpio);
>> +		dev_dbg(dev, "failed to get reset gpio: %d\n", err);
>> +		return err;
> Likewise - use return dev_err_probe(...);
> 
>> +
>> +	khadas_ts050->enable_gpio = devm_gpiod_get(dev, "enable",
>> +						   GPIOD_OUT_HIGH);
>> +	if (IS_ERR(khadas_ts050->enable_gpio)) {
>> +		err = PTR_ERR(khadas_ts050->enable_gpio);
>> +		dev_dbg(dev, "failed to get enable gpio: %d\n", err);
>> +		return err;
>> +	}
> dev_err_probe()
> 
>> +
>> +	drm_panel_init(&khadas_ts050->base, &khadas_ts050->link->dev,
>> +		       &khadas_ts050_panel_funcs, DRM_MODE_CONNECTOR_DSI);
>> +
>> +	err = drm_panel_of_backlight(&khadas_ts050->base);
>> +	if (err)
>> +		return err;
>> +
>> +	drm_panel_add(&khadas_ts050->base);
>> +
>> +	return 0;
>> +}
>> +
>> +static int khadas_ts050_panel_probe(struct mipi_dsi_device *dsi)
>> +{
>> +	struct khadas_ts050_panel *khadas_ts050;
>> +	int err;
>> +
>> +	dsi->lanes = 4;
>> +	dsi->format = MIPI_DSI_FMT_RGB888;
>> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
>> +			  MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_EOT_PACKET;
>> +
>> +	khadas_ts050 = devm_kzalloc(&dsi->dev, sizeof(*khadas_ts050),
>> +				    GFP_KERNEL);
>> +	if (!khadas_ts050)
>> +		return -ENOMEM;
>> +
>> +	mipi_dsi_set_drvdata(dsi, khadas_ts050);
>> +	khadas_ts050->link = dsi;
>> +
>> +	err = khadas_ts050_panel_add(khadas_ts050);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	return mipi_dsi_attach(dsi);
>> +}
>> +
>> +static int khadas_ts050_panel_remove(struct mipi_dsi_device *dsi)
>> +{
>> +	struct khadas_ts050_panel *khadas_ts050 = mipi_dsi_get_drvdata(dsi);
>> +	int err;
>> +
>> +	err = mipi_dsi_detach(dsi);
>> +	if (err < 0)
>> +		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
>> +
>> +	drm_panel_remove(&khadas_ts050->base);
>> +	drm_panel_disable(&khadas_ts050->base);
>> +	drm_panel_unprepare(&khadas_ts050->base);
>> +
>> +	return 0;
>> +}
>> +
>> +static void khadas_ts050_panel_shutdown(struct mipi_dsi_device *dsi)
>> +{
>> +	struct khadas_ts050_panel *khadas_ts050 = mipi_dsi_get_drvdata(dsi);
>> +
>> +	drm_panel_disable(&khadas_ts050->base);
>> +	drm_panel_unprepare(&khadas_ts050->base);
>> +}
>> +
>> +static struct mipi_dsi_driver khadas_ts050_panel_driver = {
>> +	.driver = {
>> +		.name = "panel-khadas-ts050",
>> +		.of_match_table = khadas_ts050_of_match,
>> +	},
>> +	.probe = khadas_ts050_panel_probe,
>> +	.remove = khadas_ts050_panel_remove,
>> +	.shutdown = khadas_ts050_panel_shutdown,
>> +};
>> +module_mipi_dsi_driver(khadas_ts050_panel_driver);
>> +
>> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
>> +MODULE_DESCRIPTION("Khadas TS050 panel driver");
>> +MODULE_LICENSE("GPL v2");
>> -- 
>> 2.25.1
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel

Thanks for the review!

Neil
