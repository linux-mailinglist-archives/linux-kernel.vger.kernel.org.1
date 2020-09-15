Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6192026A581
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgIOMrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:47:16 -0400
Received: from crapouillou.net ([89.234.176.41]:32970 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbgIOMis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1600173513; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R6QRmVC9IGMmK/RvDiFcTI+4dg6MCIZq0bMFbjxQgnw=;
        b=mObs+zx6dqBMLlcih6tsjEsrZ/vvkBUzMkx/VLMZwTulgbcZTSr2EaxheOhgqjW7khkxwP
        Pr7qVkzOD+xm8klFEH6mOMypErDVt8PHuKp9nIRSdejwk2NpwvMCgBxPdb90prgPmry38T
        Cf+mipO9Hyc8MtHH4VFF8PbEVW6kSA4=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/3] drm/ingenic: Add support for 30-bit modes
Date:   Tue, 15 Sep 2020 14:38:16 +0200
Message-Id: <20200915123818.13272-2-paul@crapouillou.net>
In-Reply-To: <20200915123818.13272-1-paul@crapouillou.net>
References: <20200915123818.13272-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from the JZ4760 SoC, the primary and overlay planes support
30-bit pixel modes (10 bits per color component). Add support for these
in the ingenic-drm driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 41 +++++++++++++++++------
 drivers/gpu/drm/ingenic/ingenic-drm.h     |  1 +
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 937d080f5d06..fb62869befdc 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -49,6 +49,8 @@ struct jz_soc_info {
 	bool needs_dev_clk;
 	bool has_osd;
 	unsigned int max_width, max_height;
+	const u32 *formats;
+	unsigned int num_formats;
 };
 
 struct ingenic_drm {
@@ -73,12 +75,6 @@ struct ingenic_drm {
 	bool no_vblank;
 };
 
-static const u32 ingenic_drm_primary_formats[] = {
-	DRM_FORMAT_XRGB1555,
-	DRM_FORMAT_RGB565,
-	DRM_FORMAT_XRGB8888,
-};
-
 static bool ingenic_drm_cached_gem_buf;
 module_param_named(cached_gem_buffers, ingenic_drm_cached_gem_buf, bool, 0400);
 MODULE_PARM_DESC(cached_gem_buffers,
@@ -411,6 +407,9 @@ void ingenic_drm_plane_config(struct device *dev,
 		case DRM_FORMAT_XRGB8888:
 			ctrl |= JZ_LCD_OSDCTRL_BPP_18_24;
 			break;
+		case DRM_FORMAT_XRGB2101010:
+			ctrl |= JZ_LCD_OSDCTRL_BPP_30;
+			break;
 		}
 
 		regmap_update_bits(priv->map, JZ_REG_LCD_OSDCTRL,
@@ -426,6 +425,9 @@ void ingenic_drm_plane_config(struct device *dev,
 		case DRM_FORMAT_XRGB8888:
 			ctrl |= JZ_LCD_CTRL_BPP_18_24;
 			break;
+		case DRM_FORMAT_XRGB2101010:
+			ctrl |= JZ_LCD_CTRL_BPP_30;
+			break;
 		}
 
 		regmap_update_bits(priv->map, JZ_REG_LCD_CTRL,
@@ -894,8 +896,8 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 
 	ret = drm_universal_plane_init(drm, &priv->f1, 1,
 				       &ingenic_drm_primary_plane_funcs,
-				       ingenic_drm_primary_formats,
-				       ARRAY_SIZE(ingenic_drm_primary_formats),
+				       priv->soc_info->formats,
+				       priv->soc_info->num_formats,
 				       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
 	if (ret) {
 		dev_err(dev, "Failed to register plane: %i\n", ret);
@@ -919,8 +921,8 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 
 		ret = drm_universal_plane_init(drm, &priv->f0, 1,
 					       &ingenic_drm_primary_plane_funcs,
-					       ingenic_drm_primary_formats,
-					       ARRAY_SIZE(ingenic_drm_primary_formats),
+					       priv->soc_info->formats,
+					       priv->soc_info->num_formats,
 					       NULL, DRM_PLANE_TYPE_OVERLAY,
 					       NULL);
 		if (ret) {
@@ -1121,11 +1123,26 @@ static int ingenic_drm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const u32 jz4740_formats[] = {
+	DRM_FORMAT_XRGB1555,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_XRGB8888,
+};
+
+static const u32 jz4770_formats[] = {
+	DRM_FORMAT_XRGB1555,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_XRGB2101010,
+};
+
 static const struct jz_soc_info jz4740_soc_info = {
 	.needs_dev_clk = true,
 	.has_osd = false,
 	.max_width = 800,
 	.max_height = 600,
+	.formats = jz4740_formats,
+	.num_formats = ARRAY_SIZE(jz4740_formats),
 };
 
 static const struct jz_soc_info jz4725b_soc_info = {
@@ -1133,6 +1150,8 @@ static const struct jz_soc_info jz4725b_soc_info = {
 	.has_osd = true,
 	.max_width = 800,
 	.max_height = 600,
+	.formats = jz4740_formats,
+	.num_formats = ARRAY_SIZE(jz4740_formats),
 };
 
 static const struct jz_soc_info jz4770_soc_info = {
@@ -1140,6 +1159,8 @@ static const struct jz_soc_info jz4770_soc_info = {
 	.has_osd = true,
 	.max_width = 1280,
 	.max_height = 720,
+	.formats = jz4770_formats,
+	.num_formats = ARRAY_SIZE(jz4770_formats),
 };
 
 static const struct of_device_id ingenic_drm_of_match[] = {
diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.h b/drivers/gpu/drm/ingenic/ingenic-drm.h
index df99f0f75d39..f05e18e6b6fa 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.h
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.h
@@ -124,6 +124,7 @@
 #define JZ_LCD_CTRL_BPP_8			0x3
 #define JZ_LCD_CTRL_BPP_15_16			0x4
 #define JZ_LCD_CTRL_BPP_18_24			0x5
+#define JZ_LCD_CTRL_BPP_30			0x7
 #define JZ_LCD_CTRL_BPP_MASK			(JZ_LCD_CTRL_RGB555 | 0x7)
 
 #define JZ_LCD_CMD_SOF_IRQ			BIT(31)
-- 
2.28.0

