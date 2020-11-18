Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19732B78BC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 09:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgKRIaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:30:03 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:53512 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgKRIaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:30:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 5AA5CFB02;
        Wed, 18 Nov 2020 09:29:57 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kWA76rKSOx8C; Wed, 18 Nov 2020 09:29:55 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 9840843F6E; Wed, 18 Nov 2020 09:29:53 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen <allen.chen@ite.com.tw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] drm/panel: mantix: Allow to specify default mode for different panels
Date:   Wed, 18 Nov 2020 09:29:50 +0100
Message-Id: <2580dba34c95a8159c1bdfd07604fbb8dbd0ad8c.1605688147.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605688147.git.agx@sigxcpu.org>
References: <cover.1605688147.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can be used to use different modes for differnt panels via OF
device match.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../gpu/drm/panel/panel-mantix-mlaf057we51.c   | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
index 624d17b96a69..b057857165b0 100644
--- a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
+++ b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
@@ -9,6 +9,7 @@
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/regulator/consumer.h>
 
 #include <video/mipi_display.h>
@@ -34,6 +35,8 @@ struct mantix {
 	struct regulator *avdd;
 	struct regulator *avee;
 	struct regulator *vddi;
+
+	const struct drm_display_mode *default_mode;
 };
 
 static inline struct mantix *panel_to_mantix(struct drm_panel *panel)
@@ -187,7 +190,7 @@ static int mantix_prepare(struct drm_panel *panel)
 	return 0;
 }
 
-static const struct drm_display_mode default_mode = {
+static const struct drm_display_mode default_mode_mantix = {
 	.hdisplay    = 720,
 	.hsync_start = 720 + 45,
 	.hsync_end   = 720 + 45 + 14,
@@ -208,11 +211,11 @@ static int mantix_get_modes(struct drm_panel *panel,
 	struct mantix *ctx = panel_to_mantix(panel);
 	struct drm_display_mode *mode;
 
-	mode = drm_mode_duplicate(connector->dev, &default_mode);
+	mode = drm_mode_duplicate(connector->dev, ctx->default_mode);
 	if (!mode) {
 		dev_err(ctx->dev, "Failed to add mode %ux%u@%u\n",
-			default_mode.hdisplay, default_mode.vdisplay,
-			drm_mode_vrefresh(&default_mode));
+			ctx->default_mode->hdisplay, ctx->default_mode->vdisplay,
+			drm_mode_vrefresh(ctx->default_mode));
 		return -ENOMEM;
 	}
 
@@ -243,6 +246,7 @@ static int mantix_probe(struct mipi_dsi_device *dsi)
 	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
+	ctx->default_mode = of_device_get_match_data(dev);
 
 	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(ctx->reset_gpio)) {
@@ -293,8 +297,8 @@ static int mantix_probe(struct mipi_dsi_device *dsi)
 	}
 
 	dev_info(dev, "%ux%u@%u %ubpp dsi %udl - ready\n",
-		 default_mode.hdisplay, default_mode.vdisplay,
-		 drm_mode_vrefresh(&default_mode),
+		 ctx->default_mode->hdisplay, ctx->default_mode->vdisplay,
+		 drm_mode_vrefresh(ctx->default_mode),
 		 mipi_dsi_pixel_format_to_bpp(dsi->format), dsi->lanes);
 
 	return 0;
@@ -321,7 +325,7 @@ static int mantix_remove(struct mipi_dsi_device *dsi)
 }
 
 static const struct of_device_id mantix_of_match[] = {
-	{ .compatible = "mantix,mlaf057we51-x" },
+	{ .compatible = "mantix,mlaf057we51-x", .data = &default_mode_mantix },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mantix_of_match);
-- 
2.29.2

