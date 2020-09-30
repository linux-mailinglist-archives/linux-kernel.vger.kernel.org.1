Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DD227F54A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 00:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbgI3Wk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 18:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731706AbgI3WkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 18:40:19 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60FCC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:40:17 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m13so3469852otl.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B02x+6qFwNDiIXaIKoI44hg6IcubNrceyp/h3OxHQCk=;
        b=pvuNi+rYQvKETQMj7zSc0bfZg6yS9Zp8P8S4T/PKj+puIOobsX5Z1Nzzl65f87gkA9
         im/rPs1hod0h9wkbw2lU4pCRBiwmEPmUvhAka/eJoW2OeRB0DssxlBRIu8sDK1/RY43I
         Ba+49Ea5gI7xrUAS+pfEKuKq/uG62mU3azpLkvq1n87G8yfFMcsx3w2EIddlchmXUNdq
         tkg8XziIHyG8lEArFLtAjMSC4+S0FDeq3n0NXc35Iz+4RitwKm/cw5v1YMx7e3sxMUun
         MhmjHHsqJ89NBiT1FP2v0mJ2hx19kZVr1JDLs7cl6Q3AcnfW1TRjBrsttqNuUPRgh3SR
         qcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B02x+6qFwNDiIXaIKoI44hg6IcubNrceyp/h3OxHQCk=;
        b=I3YfEZDp3Iq5vr9aq4fTs6YcKYFeRpJ7JKgNJq5iJbvVInUanyls5weNVX67m893GL
         KHhp+ZO/CcfzcS+Qi9mrDW1SX6KzTGZFVIL/kt08eDtu7WH+YXs36BLNbO868/eUqSP6
         6+rxX/oR8cg2vhSYIvhjRfzyN0YAWPnDdh53i/aWsA6uJalsctvIpq0QiUMbd4Lo5dAs
         LP0/yEvrmYlsOeOn7Lyqj4zqCxkah9vBOPqMqUO6s9oz2IUhfJlPxPFEFMY8dJ8msj0H
         2/btdh4QOcZs5/vV+rZjrHNNtG1lE0yBjHOiFUhvDt7uB709yVb8D+cXHU7TllozeOkn
         /sPw==
X-Gm-Message-State: AOAM5338OZwz+mY4L4mMoLEcJfg8ELCpU/YrPHmLQcRt4mOQhvQZbS/B
        Ti4cM+Y5RuBxkALXkYC433n3mA==
X-Google-Smtp-Source: ABdhPJyyUYdFUIRbOQaZ76Rcf6inMgqh+OduTBSq4tEoqVgrxjCXZsV/JDBpugHNdorkOd9eqdU/wA==
X-Received: by 2002:a05:6830:20d8:: with SMTP id z24mr2962682otq.3.1601505617097;
        Wed, 30 Sep 2020 15:40:17 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p8sm781364oot.29.2020.09.30.15.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 15:40:16 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/2] drm/bridge: ti-sn65dsi86: Expose backlight controls
Date:   Wed, 30 Sep 2020 17:35:32 -0500
Message-Id: <20200930223532.77755-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930223532.77755-1-bjorn.andersson@linaro.org>
References: <20200930223532.77755-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TI SN65DSI86 can be configured to generate a PWM pulse on GPIO4,
to be used to drive a backlight driver.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/bridge/Kconfig        |   1 +
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 143 +++++++++++++++++++++++++-
 2 files changed, 140 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 43271c21d3fc..eea310bd88e1 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -195,6 +195,7 @@ config DRM_TI_SN65DSI86
 	select REGMAP_I2C
 	select DRM_PANEL
 	select DRM_MIPI_DSI
+	select BACKLIGHT_CLASS_DEVICE
 	help
 	  Texas Instruments SN65DSI86 DSI to eDP Bridge driver
 
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 5b6e19ecbc84..41e24d0dbd18 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -68,6 +68,7 @@
 #define  SN_GPIO_MUX_OUTPUT			1
 #define  SN_GPIO_MUX_SPECIAL			2
 #define  SN_GPIO_MUX_MASK			0x3
+#define  SN_GPIO_MUX_SHIFT(gpio)		((gpio) * 2)
 #define SN_AUX_WDATA_REG(x)			(0x64 + (x))
 #define SN_AUX_ADDR_19_16_REG			0x74
 #define SN_AUX_ADDR_15_8_REG			0x75
@@ -86,6 +87,12 @@
 #define SN_ML_TX_MODE_REG			0x96
 #define  ML_TX_MAIN_LINK_OFF			0
 #define  ML_TX_NORMAL_MODE			BIT(0)
+#define SN_PWM_PRE_DIV_REG			0xA0
+#define SN_BACKLIGHT_SCALE_REG			0xA1
+#define SN_BACKLIGHT_REG			0xA3
+#define SN_PWM_CTL_REG				0xA5
+#define  SN_PWM_ENABLE				BIT(1)
+#define  SN_PWM_INVERT				BIT(0)
 #define SN_AUX_CMD_STATUS_REG			0xF4
 #define  AUX_IRQ_STATUS_AUX_RPLY_TOUT		BIT(3)
 #define  AUX_IRQ_STATUS_AUX_SHORT		BIT(5)
@@ -155,6 +162,8 @@ struct ti_sn_bridge {
 	struct gpio_chip		gchip;
 	DECLARE_BITMAP(gchip_output, SN_NUM_GPIOS);
 #endif
+	u32				brightness;
+	u32				max_brightness;
 };
 
 static const struct regmap_range ti_sn_bridge_volatile_ranges[] = {
@@ -173,6 +182,18 @@ static const struct regmap_config ti_sn_bridge_regmap_config = {
 	.cache_type = REGCACHE_NONE,
 };
 
+static void ti_sn_bridge_read_u16(struct ti_sn_bridge *pdata,
+				  unsigned int reg, u16 *val)
+{
+	unsigned int high;
+	unsigned int low;
+
+	regmap_read(pdata->regmap, reg, &low);
+	regmap_read(pdata->regmap, reg + 1, &high);
+
+	*val = high << 8 | low;
+}
+
 static void ti_sn_bridge_write_u16(struct ti_sn_bridge *pdata,
 				   unsigned int reg, u16 val)
 {
@@ -180,6 +201,50 @@ static void ti_sn_bridge_write_u16(struct ti_sn_bridge *pdata,
 	regmap_write(pdata->regmap, reg + 1, val >> 8);
 }
 
+static int ti_sn_backlight_update(struct ti_sn_bridge *pdata)
+{
+	unsigned int pre_div;
+
+	if (!pdata->max_brightness)
+		return 0;
+
+	/* Enable PWM on GPIO4 */
+	regmap_update_bits(pdata->regmap, SN_GPIO_CTRL_REG,
+			   SN_GPIO_MUX_MASK << SN_GPIO_MUX_SHIFT(4 - 1),
+			   SN_GPIO_MUX_SPECIAL << SN_GPIO_MUX_SHIFT(4 - 1));
+
+	if (pdata->brightness) {
+		/* Set max brightness */
+		ti_sn_bridge_write_u16(pdata, SN_BACKLIGHT_SCALE_REG, pdata->max_brightness);
+
+		/* Set brightness */
+		ti_sn_bridge_write_u16(pdata, SN_BACKLIGHT_REG, pdata->brightness);
+
+		/*
+		 * The PWM frequency is derived from the refclk as:
+		 * PWM_FREQ = REFCLK_FREQ / (PWM_PRE_DIV * BACKLIGHT_SCALE + 1)
+		 *
+		 * A hand wavy estimate based on 12MHz refclk and 500Hz desired
+		 * PWM frequency gives us a pre_div resulting in a PWM
+		 * frequency of between 500 and 1600Hz, depending on the actual
+		 * refclk rate.
+		 *
+		 * One is added to avoid high BACKLIGHT_SCALE values to produce
+		 * a pre_div of 0 - which cancels out the large BACKLIGHT_SCALE
+		 * value.
+		 */
+		pre_div = 12000000 / (500 * pdata->max_brightness) + 1;
+		regmap_write(pdata->regmap, SN_PWM_PRE_DIV_REG, pre_div);
+
+		/* Enable PWM */
+		regmap_update_bits(pdata->regmap, SN_PWM_CTL_REG, SN_PWM_ENABLE, SN_PWM_ENABLE);
+	} else {
+		regmap_update_bits(pdata->regmap, SN_PWM_CTL_REG, SN_PWM_ENABLE, 0);
+	}
+
+	return 0;
+}
+
 static int __maybe_unused ti_sn_bridge_resume(struct device *dev)
 {
 	struct ti_sn_bridge *pdata = dev_get_drvdata(dev);
@@ -193,7 +258,7 @@ static int __maybe_unused ti_sn_bridge_resume(struct device *dev)
 
 	gpiod_set_value(pdata->enable_gpio, 1);
 
-	return ret;
+	return ti_sn_backlight_update(pdata);
 }
 
 static int __maybe_unused ti_sn_bridge_suspend(struct device *dev)
@@ -1010,7 +1075,7 @@ static int ti_sn_bridge_gpio_direction_input(struct gpio_chip *chip,
 					     unsigned int offset)
 {
 	struct ti_sn_bridge *pdata = gpiochip_get_data(chip);
-	int shift = offset * 2;
+	int shift = SN_GPIO_MUX_SHIFT(offset);
 	int ret;
 
 	if (!test_and_clear_bit(offset, pdata->gchip_output))
@@ -1038,7 +1103,7 @@ static int ti_sn_bridge_gpio_direction_output(struct gpio_chip *chip,
 					      unsigned int offset, int val)
 {
 	struct ti_sn_bridge *pdata = gpiochip_get_data(chip);
-	int shift = offset * 2;
+	int shift = SN_GPIO_MUX_SHIFT(offset);
 	int ret;
 
 	if (test_and_set_bit(offset, pdata->gchip_output))
@@ -1073,12 +1138,17 @@ static const char * const ti_sn_bridge_gpio_names[SN_NUM_GPIOS] = {
 
 static int ti_sn_setup_gpio_controller(struct ti_sn_bridge *pdata)
 {
+	int ngpio = SN_NUM_GPIOS;
 	int ret;
 
 	/* Only init if someone is going to use us as a GPIO controller */
 	if (!of_property_read_bool(pdata->dev->of_node, "gpio-controller"))
 		return 0;
 
+	/* If GPIO4 is used for backlight, reduce number of gpios */
+	if (pdata->max_brightness)
+		ngpio--;
+
 	pdata->gchip.label = dev_name(pdata->dev);
 	pdata->gchip.parent = pdata->dev;
 	pdata->gchip.owner = THIS_MODULE;
@@ -1092,7 +1162,7 @@ static int ti_sn_setup_gpio_controller(struct ti_sn_bridge *pdata)
 	pdata->gchip.set = ti_sn_bridge_gpio_set;
 	pdata->gchip.can_sleep = true;
 	pdata->gchip.names = ti_sn_bridge_gpio_names;
-	pdata->gchip.ngpio = SN_NUM_GPIOS;
+	pdata->gchip.ngpio = ngpio;
 	pdata->gchip.base = -1;
 	ret = devm_gpiochip_add_data(pdata->dev, &pdata->gchip, pdata);
 	if (ret)
@@ -1159,6 +1229,65 @@ static void ti_sn_bridge_parse_lanes(struct ti_sn_bridge *pdata,
 	pdata->ln_polrs = ln_polrs;
 }
 
+static int ti_sn_backlight_update_status(struct backlight_device *bl)
+{
+	struct ti_sn_bridge *pdata = bl_get_data(bl);
+	int brightness = bl->props.brightness;
+
+	if (bl->props.power != FB_BLANK_UNBLANK ||
+	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
+	    bl->props.state & BL_CORE_FBBLANK) {
+		pdata->brightness = 0;
+	}
+
+	pdata->brightness = brightness;
+
+	return ti_sn_backlight_update(pdata);
+}
+
+static int ti_sn_backlight_get_brightness(struct backlight_device *bl)
+{
+	struct ti_sn_bridge *pdata = bl_get_data(bl);
+	u16 val;
+
+	ti_sn_bridge_read_u16(pdata, SN_BACKLIGHT_REG, &val);
+
+	return val;
+}
+
+const struct backlight_ops ti_sn_backlight_ops = {
+	.update_status = ti_sn_backlight_update_status,
+	.get_brightness = ti_sn_backlight_get_brightness,
+};
+
+static int ti_sn_backlight_init(struct ti_sn_bridge *pdata)
+{
+	struct backlight_properties props = {};
+	struct backlight_device	*bl;
+	struct device *dev = pdata->dev;
+	struct device_node *np = dev->of_node;
+	int ret;
+
+	ret = of_property_read_u32(np, "ti,backlight-scale", &pdata->max_brightness);
+	if (ret == -EINVAL) {
+		return 0;
+	} else if (ret || pdata->max_brightness >= 0xffff) {
+		DRM_ERROR("invalid max-brightness\n");
+		return -EINVAL;
+	}
+
+	props.type = BACKLIGHT_RAW;
+	props.max_brightness = pdata->max_brightness;
+	bl = devm_backlight_device_register(dev, "sn65dsi86", dev, pdata,
+					    &ti_sn_backlight_ops, &props);
+	if (IS_ERR(bl)) {
+		DRM_ERROR("failed to register backlight device\n");
+		return PTR_ERR(bl);
+	}
+
+	return 0;
+}
+
 static int ti_sn_bridge_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
@@ -1224,6 +1353,12 @@ static int ti_sn_bridge_probe(struct i2c_client *client,
 
 	pm_runtime_enable(pdata->dev);
 
+	ret = ti_sn_backlight_init(pdata);
+	if (ret) {
+		pm_runtime_disable(pdata->dev);
+		return ret;
+	}
+
 	ret = ti_sn_setup_gpio_controller(pdata);
 	if (ret) {
 		pm_runtime_disable(pdata->dev);
-- 
2.28.0

