Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3648222865
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 18:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgGPQj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 12:39:26 -0400
Received: from crapouillou.net ([89.234.176.41]:50330 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbgGPQjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1594917537; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I67TKVIY1e4ZkLqZjG9x1H1pYXC+YO1iY3ebFaSwTp8=;
        b=OekZQwf9XjY/0YNju7G0LwsIBszB8lEwnEDd7epaaC1MT8HNLrHPjUPoqJn633L3WVyGPi
        sz8kfqySUQ2I5vUSw9jm532nLstiMSRav9BkoeimMlyhV652Vg+N9q+M4Q4cHb0i9YrWpK
        Z7kOlA+hhAZzYgTlgO+iZnzHFD6G2a4=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 05/12] drm/ingenic: Add missing CR in debug strings
Date:   Thu, 16 Jul 2020 18:38:39 +0200
Message-Id: <20200716163846.174790-5-paul@crapouillou.net>
In-Reply-To: <20200716163846.174790-1-paul@crapouillou.net>
References: <20200716163846.174790-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you pass a string that is not terminated with a carriage return to
dev_err(), it will eventually be printed with a carriage return, but
not right away, since the kernel will wait for a pr_cont().

v2: New patch
v3: No change

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 30 +++++++++++------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 606d8acb0954..9e845234c7b5 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -623,14 +623,14 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base)) {
-		dev_err(dev, "Failed to get memory resource");
+		dev_err(dev, "Failed to get memory resource\n");
 		return PTR_ERR(base);
 	}
 
 	priv->map = devm_regmap_init_mmio(dev, base,
 					  &ingenic_drm_regmap_config);
 	if (IS_ERR(priv->map)) {
-		dev_err(dev, "Failed to create regmap");
+		dev_err(dev, "Failed to create regmap\n");
 		return PTR_ERR(priv->map);
 	}
 
@@ -641,21 +641,21 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 	if (soc_info->needs_dev_clk) {
 		priv->lcd_clk = devm_clk_get(dev, "lcd");
 		if (IS_ERR(priv->lcd_clk)) {
-			dev_err(dev, "Failed to get lcd clock");
+			dev_err(dev, "Failed to get lcd clock\n");
 			return PTR_ERR(priv->lcd_clk);
 		}
 	}
 
 	priv->pix_clk = devm_clk_get(dev, "lcd_pclk");
 	if (IS_ERR(priv->pix_clk)) {
-		dev_err(dev, "Failed to get pixel clock");
+		dev_err(dev, "Failed to get pixel clock\n");
 		return PTR_ERR(priv->pix_clk);
 	}
 
 	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0, &panel, &bridge);
 	if (ret) {
 		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get panel handle");
+			dev_err(dev, "Failed to get panel handle\n");
 		return ret;
 	}
 
@@ -684,7 +684,7 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 				       ARRAY_SIZE(ingenic_drm_primary_formats),
 				       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
 	if (ret) {
-		dev_err(dev, "Failed to register primary plane: %i", ret);
+		dev_err(dev, "Failed to register primary plane: %i\n", ret);
 		return ret;
 	}
 
@@ -693,7 +693,7 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 	ret = drm_crtc_init_with_planes(drm, &priv->crtc, &priv->primary,
 					NULL, &ingenic_drm_crtc_funcs, NULL);
 	if (ret) {
-		dev_err(dev, "Failed to init CRTC: %i", ret);
+		dev_err(dev, "Failed to init CRTC: %i\n", ret);
 		return ret;
 	}
 
@@ -705,25 +705,25 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 	ret = drm_simple_encoder_init(drm, &priv->encoder,
 				      DRM_MODE_ENCODER_DPI);
 	if (ret) {
-		dev_err(dev, "Failed to init encoder: %i", ret);
+		dev_err(dev, "Failed to init encoder: %i\n", ret);
 		return ret;
 	}
 
 	ret = drm_bridge_attach(&priv->encoder, bridge, NULL, 0);
 	if (ret) {
-		dev_err(dev, "Unable to attach bridge");
+		dev_err(dev, "Unable to attach bridge\n");
 		return ret;
 	}
 
 	ret = drm_irq_install(drm, irq);
 	if (ret) {
-		dev_err(dev, "Unable to install IRQ handler");
+		dev_err(dev, "Unable to install IRQ handler\n");
 		return ret;
 	}
 
 	ret = drm_vblank_init(drm, 1);
 	if (ret) {
-		dev_err(dev, "Failed calling drm_vblank_init()");
+		dev_err(dev, "Failed calling drm_vblank_init()\n");
 		return ret;
 	}
 
@@ -731,7 +731,7 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 
 	ret = clk_prepare_enable(priv->pix_clk);
 	if (ret) {
-		dev_err(dev, "Unable to start pixel clock");
+		dev_err(dev, "Unable to start pixel clock\n");
 		return ret;
 	}
 
@@ -746,20 +746,20 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 		 */
 		ret = clk_set_rate(priv->lcd_clk, parent_rate);
 		if (ret) {
-			dev_err(dev, "Unable to set LCD clock rate");
+			dev_err(dev, "Unable to set LCD clock rate\n");
 			goto err_pixclk_disable;
 		}
 
 		ret = clk_prepare_enable(priv->lcd_clk);
 		if (ret) {
-			dev_err(dev, "Unable to start lcd clock");
+			dev_err(dev, "Unable to start lcd clock\n");
 			goto err_pixclk_disable;
 		}
 	}
 
 	ret = drm_dev_register(drm, 0);
 	if (ret) {
-		dev_err(dev, "Failed to register DRM driver");
+		dev_err(dev, "Failed to register DRM driver\n");
 		goto err_devclk_disable;
 	}
 
-- 
2.27.0

