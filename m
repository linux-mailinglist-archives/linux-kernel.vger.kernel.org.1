Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971342B9731
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgKSP41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:56:27 -0500
Received: from aposti.net ([89.234.176.197]:43944 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729084AbgKSP4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:56:25 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/3] drm/ingenic: Properly compute timings when using a 3x8-bit panel
Date:   Thu, 19 Nov 2020 15:55:58 +0000
Message-Id: <20201119155559.14112-3-paul@crapouillou.net>
In-Reply-To: <20201119155559.14112-1-paul@crapouillou.net>
References: <20201119155559.14112-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LCD controller expects timing values in dot-clock ticks, which is 3x
the timing values in pixels when using a 3x8-bit display; but it will
count the display area size in pixels either way. Go figure.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 998c63061fa8..0b2311b32b81 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -643,6 +643,7 @@ static int ingenic_drm_encoder_atomic_check(struct drm_encoder *encoder,
 					    struct drm_connector_state *conn_state)
 {
 	struct drm_display_info *info = &conn_state->connector->display_info;
+	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
 
 	if (info->num_bus_formats != 1)
 		return -EINVAL;
@@ -651,10 +652,22 @@ static int ingenic_drm_encoder_atomic_check(struct drm_encoder *encoder,
 		return 0;
 
 	switch (*info->bus_formats) {
+	case MEDIA_BUS_FMT_RGB888_3X8:
+		/*
+		 * The LCD controller expects timing values in dot-clock ticks,
+		 * which is 3x the timing values in pixels when using a 3x8-bit
+		 * display; but it will count the display area size in pixels
+		 * either way. Go figure.
+		 */
+		mode->crtc_clock = mode->clock * 3;
+		mode->crtc_hsync_start = mode->hsync_start * 3 - mode->hdisplay * 2;
+		mode->crtc_hsync_end = mode->hsync_end * 3 - mode->hdisplay * 2;
+		mode->crtc_hdisplay = mode->hdisplay;
+		mode->crtc_htotal = mode->htotal * 3 - mode->hdisplay * 2;
+		return 0;
 	case MEDIA_BUS_FMT_RGB565_1X16:
 	case MEDIA_BUS_FMT_RGB666_1X18:
 	case MEDIA_BUS_FMT_RGB888_1X24:
-	case MEDIA_BUS_FMT_RGB888_3X8:
 		return 0;
 	default:
 		return -EINVAL;
-- 
2.29.2

