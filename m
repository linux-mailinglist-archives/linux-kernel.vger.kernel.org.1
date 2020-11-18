Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6101E2B78C7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 09:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgKRIaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:30:18 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:53542 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727566AbgKRIaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:30:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 50FC5FB04;
        Wed, 18 Nov 2020 09:29:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ScdGbqCgB9hZ; Wed, 18 Nov 2020 09:29:54 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 8A4DD4026C; Wed, 18 Nov 2020 09:29:53 +0100 (CET)
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
Subject: [PATCH v2 1/6] drm/panel: st7703: Use dev_err_probe
Date:   Wed, 18 Nov 2020 09:29:48 +0100
Message-Id: <36405038d93eb148f3e8ed8e5ea70de8e87afd78.1605688147.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605688147.git.agx@sigxcpu.org>
References: <cover.1605688147.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Less code and easier probe deferral debugging.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 24 +++++++------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index b30510b1696a..a2c303e5732c 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -530,10 +530,8 @@ static int st7703_probe(struct mipi_dsi_device *dsi)
 		return -ENOMEM;
 
 	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(ctx->reset_gpio)) {
-		dev_err(dev, "cannot get reset gpio\n");
-		return PTR_ERR(ctx->reset_gpio);
-	}
+	if (IS_ERR(ctx->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio), "Failed to get reset gpio\n");
 
 	mipi_dsi_set_drvdata(dsi, ctx);
 
@@ -545,19 +543,13 @@ static int st7703_probe(struct mipi_dsi_device *dsi)
 	dsi->lanes = ctx->desc->lanes;
 
 	ctx->vcc = devm_regulator_get(dev, "vcc");
-	if (IS_ERR(ctx->vcc)) {
-		ret = PTR_ERR(ctx->vcc);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to request vcc regulator: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(ctx->vcc))
+		return dev_err_probe(dev, PTR_ERR(ctx->vcc), "Failed to request vcc regulator\n");
+
 	ctx->iovcc = devm_regulator_get(dev, "iovcc");
-	if (IS_ERR(ctx->iovcc)) {
-		ret = PTR_ERR(ctx->iovcc);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to request iovcc regulator: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(ctx->iovcc))
+		return dev_err_probe(dev, PTR_ERR(ctx->iovcc),
+				     "Failed to request iovcc regulator\n");
 
 	drm_panel_init(&ctx->panel, dev, &st7703_drm_funcs,
 		       DRM_MODE_CONNECTOR_DSI);
-- 
2.29.2

