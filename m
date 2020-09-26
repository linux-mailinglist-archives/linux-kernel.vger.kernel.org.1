Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AE5279B24
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 19:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbgIZRGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 13:06:00 -0400
Received: from crapouillou.net ([89.234.176.41]:39190 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgIZRF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 13:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1601139916; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JuupkTNL/SpFvM4lzRBSLk4XJjrib7IUZxHJM7yYttU=;
        b=j+4H2HBFKhhMR4o5hpd8BcKwoZRQUL2/4fR5GCVHklZaqohu8BCjwZwpp/xpf2+YWq7YSU
        cZUqvncSKvCoCDdyiiS0klkeziw7DFFIwKVw2RFx1aFAecfbphGmqoWR2SweO532QP5fuP
        9pVQEgaj8gGvOoDVW1hS9+uZ3mC11Bk=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 7/7] drm/ingenic: Add support for 24-bit modes
Date:   Sat, 26 Sep 2020 19:05:01 +0200
Message-Id: <20200926170501.1109197-8-paul@crapouillou.net>
In-Reply-To: <20200926170501.1109197-1-paul@crapouillou.net>
References: <20200926170501.1109197-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from the JZ4725B SoC, the primary and overlay planes support
24-bit pixel modes (8 bits per color component, without dummy byte).
Add support for these in the ingenic-drm driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 8 ++++++++
 drivers/gpu/drm/ingenic/ingenic-drm.h     | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 9e3122b42820..c2b63533ed18 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -458,6 +458,9 @@ void ingenic_drm_plane_config(struct device *dev,
 		case DRM_FORMAT_RGB565:
 			ctrl |= JZ_LCD_OSDCTRL_BPP_15_16;
 			break;
+		case DRM_FORMAT_RGB888:
+			ctrl |= JZ_LCD_OSDCTRL_BPP_24_COMP;
+			break;
 		case DRM_FORMAT_XRGB8888:
 			ctrl |= JZ_LCD_OSDCTRL_BPP_18_24;
 			break;
@@ -479,6 +482,9 @@ void ingenic_drm_plane_config(struct device *dev,
 		case DRM_FORMAT_RGB565:
 			ctrl |= JZ_LCD_CTRL_BPP_15_16;
 			break;
+		case DRM_FORMAT_RGB888:
+			ctrl |= JZ_LCD_CTRL_BPP_24_COMP;
+			break;
 		case DRM_FORMAT_XRGB8888:
 			ctrl |= JZ_LCD_CTRL_BPP_18_24;
 			break;
@@ -1278,6 +1284,7 @@ static const u32 jz4725b_formats_f0[] = {
 static const u32 jz4770_formats_f1[] = {
 	DRM_FORMAT_XRGB1555,
 	DRM_FORMAT_RGB565,
+	DRM_FORMAT_RGB888,
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_XRGB2101010,
 };
@@ -1286,6 +1293,7 @@ static const u32 jz4770_formats_f0[] = {
 	DRM_FORMAT_C8,
 	DRM_FORMAT_XRGB1555,
 	DRM_FORMAT_RGB565,
+	DRM_FORMAT_RGB888,
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_XRGB2101010,
 };
diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.h b/drivers/gpu/drm/ingenic/ingenic-drm.h
index f05e18e6b6fa..ee3a892c0383 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.h
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.h
@@ -124,6 +124,7 @@
 #define JZ_LCD_CTRL_BPP_8			0x3
 #define JZ_LCD_CTRL_BPP_15_16			0x4
 #define JZ_LCD_CTRL_BPP_18_24			0x5
+#define JZ_LCD_CTRL_BPP_24_COMP			0x6
 #define JZ_LCD_CTRL_BPP_30			0x7
 #define JZ_LCD_CTRL_BPP_MASK			(JZ_LCD_CTRL_RGB555 | 0x7)
 
@@ -146,6 +147,7 @@
 #define JZ_LCD_OSDCTRL_CHANGE			BIT(3)
 #define JZ_LCD_OSDCTRL_BPP_15_16		0x4
 #define JZ_LCD_OSDCTRL_BPP_18_24		0x5
+#define JZ_LCD_OSDCTRL_BPP_24_COMP		0x6
 #define JZ_LCD_OSDCTRL_BPP_30			0x7
 #define JZ_LCD_OSDCTRL_BPP_MASK			(JZ_LCD_OSDCTRL_RGB555 | 0x7)
 
-- 
2.28.0

