Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6180A279B23
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 19:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbgIZRFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 13:05:52 -0400
Received: from crapouillou.net ([89.234.176.41]:39038 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgIZRFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 13:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1601139915; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fs6nZrhT2NW/y05hFByBzadKHeresrsAiPfaUZWMm3M=;
        b=lB8hZmY3dI8E00gqM6hpPs4kTzbd/nGT0NQT1ELgNIXaY30eBpHEaHOMFO/WSEzSvwbKW7
        aIon9WrIur1wXk0lT1uqpRMC/ydnXL8OZF+elU+092iX8GvAcp5C26LToEfUwIhDGedqS9
        pFV1npX3siwHr3ny4+PopO+JpcZYZ6Q=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 6/7] drm/ingenic: Add support for 30-bit modes
Date:   Sat, 26 Sep 2020 19:05:00 +0200
Message-Id: <20200926170501.1109197-7-paul@crapouillou.net>
In-Reply-To: <20200926170501.1109197-1-paul@crapouillou.net>
References: <20200926170501.1109197-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from the JZ4760 SoC, the primary and overlay planes support
30-bit pixel modes (10 bits per color component). Add support for these
in the ingenic-drm driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 8 ++++++++
 drivers/gpu/drm/ingenic/ingenic-drm.h     | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 48e88827f332..9e3122b42820 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -461,6 +461,9 @@ void ingenic_drm_plane_config(struct device *dev,
 		case DRM_FORMAT_XRGB8888:
 			ctrl |= JZ_LCD_OSDCTRL_BPP_18_24;
 			break;
+		case DRM_FORMAT_XRGB2101010:
+			ctrl |= JZ_LCD_OSDCTRL_BPP_30;
+			break;
 		}
 
 		regmap_update_bits(priv->map, JZ_REG_LCD_OSDCTRL,
@@ -479,6 +482,9 @@ void ingenic_drm_plane_config(struct device *dev,
 		case DRM_FORMAT_XRGB8888:
 			ctrl |= JZ_LCD_CTRL_BPP_18_24;
 			break;
+		case DRM_FORMAT_XRGB2101010:
+			ctrl |= JZ_LCD_CTRL_BPP_30;
+			break;
 		}
 
 		regmap_update_bits(priv->map, JZ_REG_LCD_CTRL,
@@ -1273,6 +1279,7 @@ static const u32 jz4770_formats_f1[] = {
 	DRM_FORMAT_XRGB1555,
 	DRM_FORMAT_RGB565,
 	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_XRGB2101010,
 };
 
 static const u32 jz4770_formats_f0[] = {
@@ -1280,6 +1287,7 @@ static const u32 jz4770_formats_f0[] = {
 	DRM_FORMAT_XRGB1555,
 	DRM_FORMAT_RGB565,
 	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_XRGB2101010,
 };
 
 static const struct jz_soc_info jz4740_soc_info = {
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

