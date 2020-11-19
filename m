Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6D02B972E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgKSP4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:56:21 -0500
Received: from aposti.net ([89.234.176.197]:43920 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729080AbgKSP4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:56:19 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/3] drm/ingenic: Compute timings according to adjusted_mode->crtc_*
Date:   Thu, 19 Nov 2020 15:55:57 +0000
Message-Id: <20201119155559.14112-2-paul@crapouillou.net>
In-Reply-To: <20201119155559.14112-1-paul@crapouillou.net>
References: <20201119155559.14112-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adjusted_mode->crtc_* fields contain the values adjusted for the
hardware, and are the ones that should be written to the registers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 368bfef8b340..998c63061fa8 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -190,15 +190,15 @@ static void ingenic_drm_crtc_update_timings(struct ingenic_drm *priv,
 {
 	unsigned int vpe, vds, vde, vt, hpe, hds, hde, ht;
 
-	vpe = mode->vsync_end - mode->vsync_start;
-	vds = mode->vtotal - mode->vsync_start;
-	vde = vds + mode->vdisplay;
-	vt = vde + mode->vsync_start - mode->vdisplay;
+	vpe = mode->crtc_vsync_end - mode->crtc_vsync_start;
+	vds = mode->crtc_vtotal - mode->crtc_vsync_start;
+	vde = vds + mode->crtc_vdisplay;
+	vt = vde + mode->crtc_vsync_start - mode->crtc_vdisplay;
 
-	hpe = mode->hsync_end - mode->hsync_start;
-	hds = mode->htotal - mode->hsync_start;
-	hde = hds + mode->hdisplay;
-	ht = hde + mode->hsync_start - mode->hdisplay;
+	hpe = mode->crtc_hsync_end - mode->crtc_hsync_start;
+	hds = mode->crtc_htotal - mode->crtc_hsync_start;
+	hde = hds + mode->crtc_hdisplay;
+	ht = hde + mode->crtc_hsync_start - mode->crtc_hdisplay;
 
 	regmap_write(priv->map, JZ_REG_LCD_VSYNC,
 		     0 << JZ_LCD_VSYNC_VPS_OFFSET |
@@ -333,7 +333,7 @@ static void ingenic_drm_crtc_atomic_flush(struct drm_crtc *crtc,
 	struct drm_pending_vblank_event *event = crtc_state->event;
 
 	if (drm_atomic_crtc_needs_modeset(crtc_state)) {
-		ingenic_drm_crtc_update_timings(priv, &crtc_state->mode);
+		ingenic_drm_crtc_update_timings(priv, &crtc_state->adjusted_mode);
 		priv->update_clk_rate = true;
 	}
 
-- 
2.29.2

