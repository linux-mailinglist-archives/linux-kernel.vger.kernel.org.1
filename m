Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118E42B9732
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgKSP4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:56:34 -0500
Received: from aposti.net ([89.234.176.197]:43960 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729107AbgKSP4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:56:32 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/3] drm/ingenic: Add support for serial 8-bit delta-RGB panels
Date:   Thu, 19 Nov 2020 15:55:59 +0000
Message-Id: <20201119155559.14112-4-paul@crapouillou.net>
In-Reply-To: <20201119155559.14112-1-paul@crapouillou.net>
References: <20201119155559.14112-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for 24-bit panels that are connected through a 8-bit bus and
use delta-RGB, which means a RGB pixel ordering on odd lines, and a GBR
pixel ordering on even lines.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c |  7 ++++++-
 drivers/gpu/drm/ingenic/ingenic-drm.h     | 14 ++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 0b2311b32b81..fdce8a8f276a 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -589,7 +589,7 @@ static void ingenic_drm_encoder_atomic_mode_set(struct drm_encoder *encoder,
 	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
 	struct drm_connector *conn = conn_state->connector;
 	struct drm_display_info *info = &conn->display_info;
-	unsigned int cfg;
+	unsigned int cfg, rgbcfg = 0;
 
 	priv->panel_is_sharp = info->bus_flags & DRM_BUS_FLAG_SHARP_SIGNALS;
 
@@ -626,6 +626,9 @@ static void ingenic_drm_encoder_atomic_mode_set(struct drm_encoder *encoder,
 			case MEDIA_BUS_FMT_RGB888_1X24:
 				cfg |= JZ_LCD_CFG_MODE_GENERIC_24BIT;
 				break;
+			case MEDIA_BUS_FMT_RGB888_3X8_DELTA:
+				rgbcfg = JZ_LCD_RGBC_EVEN_GBR | JZ_LCD_RGBC_ODD_RGB;
+				fallthrough;
 			case MEDIA_BUS_FMT_RGB888_3X8:
 				cfg |= JZ_LCD_CFG_MODE_8BIT_SERIAL;
 				break;
@@ -636,6 +639,7 @@ static void ingenic_drm_encoder_atomic_mode_set(struct drm_encoder *encoder,
 	}
 
 	regmap_write(priv->map, JZ_REG_LCD_CFG, cfg);
+	regmap_write(priv->map, JZ_REG_LCD_RGBC, rgbcfg);
 }
 
 static int ingenic_drm_encoder_atomic_check(struct drm_encoder *encoder,
@@ -653,6 +657,7 @@ static int ingenic_drm_encoder_atomic_check(struct drm_encoder *encoder,
 
 	switch (*info->bus_formats) {
 	case MEDIA_BUS_FMT_RGB888_3X8:
+	case MEDIA_BUS_FMT_RGB888_3X8_DELTA:
 		/*
 		 * The LCD controller expects timing values in dot-clock ticks,
 		 * which is 3x the timing values in pixels when using a 3x8-bit
diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.h b/drivers/gpu/drm/ingenic/ingenic-drm.h
index 9b48ce02803d..1b4347f7f084 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.h
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.h
@@ -31,6 +31,7 @@
 #define JZ_REG_LCD_SA1				0x54
 #define JZ_REG_LCD_FID1				0x58
 #define JZ_REG_LCD_CMD1				0x5C
+#define JZ_REG_LCD_RGBC				0x90
 #define JZ_REG_LCD_OSDC				0x100
 #define JZ_REG_LCD_OSDCTRL			0x104
 #define JZ_REG_LCD_OSDS				0x108
@@ -138,6 +139,19 @@
 #define JZ_LCD_STATE_SOF_IRQ			BIT(4)
 #define JZ_LCD_STATE_DISABLED			BIT(0)
 
+#define JZ_LCD_RGBC_ODD_RGB			(0x0 << 4)
+#define JZ_LCD_RGBC_ODD_RBG			(0x1 << 4)
+#define JZ_LCD_RGBC_ODD_GRB			(0x2 << 4)
+#define JZ_LCD_RGBC_ODD_GBR			(0x3 << 4)
+#define JZ_LCD_RGBC_ODD_BRG			(0x4 << 4)
+#define JZ_LCD_RGBC_ODD_BGR			(0x5 << 4)
+#define JZ_LCD_RGBC_EVEN_RGB			(0x0 << 0)
+#define JZ_LCD_RGBC_EVEN_RBG			(0x1 << 0)
+#define JZ_LCD_RGBC_EVEN_GRB			(0x2 << 0)
+#define JZ_LCD_RGBC_EVEN_GBR			(0x3 << 0)
+#define JZ_LCD_RGBC_EVEN_BRG			(0x4 << 0)
+#define JZ_LCD_RGBC_EVEN_BGR			(0x5 << 0)
+
 #define JZ_LCD_OSDC_OSDEN			BIT(0)
 #define JZ_LCD_OSDC_F0EN			BIT(3)
 #define JZ_LCD_OSDC_F1EN			BIT(4)
-- 
2.29.2

