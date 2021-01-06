Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084D32EC540
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 21:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbhAFUlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 15:41:03 -0500
Received: from mailoutvs33.siol.net ([185.57.226.224]:55610 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727396AbhAFUlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 15:41:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 55370522E20;
        Wed,  6 Jan 2021 21:40:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gR7vxRChIE9O; Wed,  6 Jan 2021 21:40:16 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id B8CD4522E39;
        Wed,  6 Jan 2021 21:40:16 +0100 (CET)
Received: from kista.localdomain (cpe-86-58-58-53.static.triera.net [86.58.58.53])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id D70F3522E20;
        Wed,  6 Jan 2021 21:40:15 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        paul.kocialkowski@bootlin.com, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: [PATCH v3] drm/sun4i: de2: Reimplement plane z position setting logic
Date:   Wed,  6 Jan 2021 21:46:30 +0100
Message-Id: <20210106204630.1800284-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

To set blending channel order register software needs to know state and
position of each channel, which impossible at plane commit stage.

Move this procedure to atomic_flush stage, where all necessary informatio=
n
is available.

Fixes: f88c5ee77496 ("drm/sun4i: Implement zpos for DE2")
Fixes: d8b3f454dab4 ("drm/sun4i: sun8i: Avoid clearing blending order at =
each atomic commit")
Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
[rebased, addressed comments]
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 57 +++++++++++++++++++++-----
 drivers/gpu/drm/sun4i/sun8i_mixer.h    |  5 +++
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 42 +++----------------
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 42 +++----------------
 4 files changed, 64 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
index 5b42cf25cc86..d2153b10b08d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -250,6 +250,50 @@ int sun8i_mixer_drm_format_to_hw(u32 format, u32 *hw=
_format)
=20
 static void sun8i_mixer_commit(struct sunxi_engine *engine)
 {
+	struct sun8i_mixer *mixer =3D engine_to_sun8i_mixer(engine);
+	int channel_by_zpos[SUN8I_MIXER_MAX_CHANNELS];
+	u32 base =3D sun8i_blender_base(mixer);
+	u32 route =3D 0, pipe_ctl =3D 0;
+	unsigned int channel_count;
+	int i, j;
+
+	channel_count =3D mixer->cfg->vi_num + mixer->cfg->ui_num;
+
+	DRM_DEBUG_DRIVER("Update blender routing\n");
+
+	for (i =3D 0; i < SUN8I_MIXER_MAX_CHANNELS; i++)
+		channel_by_zpos[i] =3D -1;
+
+	for (i =3D 0; i < channel_count; i++)	{
+		int zpos =3D mixer->channel_zpos[i];
+
+		if (zpos >=3D 0 && zpos < channel_count)
+			channel_by_zpos[zpos] =3D i;
+	}
+
+	j =3D 0;
+	for (i =3D 0; i < channel_count; i++) {
+		int ch =3D channel_by_zpos[i];
+
+		if (ch >=3D 0) {
+			pipe_ctl |=3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(j);
+			route |=3D ch << SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(j);
+			j++;
+		}
+	}
+
+	/*
+	 * Set fill color of bottom plane to black. Generally not needed
+	 * except when VI plane is at bottom (zpos =3D 0) and enabled.
+	 */
+	pipe_ctl |=3D SUN8I_MIXER_BLEND_PIPE_CTL_FC_EN(0);
+
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_BLEND_PIPE_CTL(base), pipe_ctl);
+
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_BLEND_ROUTE(base), route);
+
 	DRM_DEBUG_DRIVER("Committing changes\n");
=20
 	regmap_write(engine->regs, SUN8I_MIXER_GLOBAL_DBUFF,
@@ -479,23 +523,16 @@ static int sun8i_mixer_bind(struct device *dev, str=
uct device *master,
 	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_BKCOLOR(base),
 		     SUN8I_MIXER_BLEND_COLOR_BLACK);
=20
-	/*
-	 * Set fill color of bottom plane to black. Generally not needed
-	 * except when VI plane is at bottom (zpos =3D 0) and enabled.
-	 */
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_PIPE_CTL(base),
-		     SUN8I_MIXER_BLEND_PIPE_CTL_FC_EN(0));
 	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ATTR_FCOLOR(base, 0)=
,
 		     SUN8I_MIXER_BLEND_COLOR_BLACK);
=20
 	plane_cnt =3D mixer->cfg->vi_num + mixer->cfg->ui_num;
-	for (i =3D 0; i < plane_cnt; i++)
+	for (i =3D 0; i < plane_cnt; i++) {
+		mixer->channel_zpos[i] =3D -1;
 		regmap_write(mixer->engine.regs,
 			     SUN8I_MIXER_BLEND_MODE(base, i),
 			     SUN8I_MIXER_BLEND_MODE_DEF);
-
-	regmap_update_bits(mixer->engine.regs, SUN8I_MIXER_BLEND_PIPE_CTL(base)=
,
-			   SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK, 0);
+	}
=20
 	return 0;
=20
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/=
sun8i_mixer.h
index 7576b523fdbb..7b378d6e4dd9 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -12,6 +12,8 @@
=20
 #include "sunxi_engine.h"
=20
+#define SUN8I_MIXER_MAX_CHANNELS		5
+
 #define SUN8I_MIXER_SIZE(w, h)			(((h) - 1) << 16 | ((w) - 1))
 #define SUN8I_MIXER_COORD(x, y)			((y) << 16 | (x))
=20
@@ -179,6 +181,9 @@ struct sun8i_mixer {
=20
 	struct clk			*bus_clk;
 	struct clk			*mod_clk;
+
+	/* -1 means that layer is disabled */
+	int channel_zpos[SUN8I_MIXER_MAX_CHANNELS];
 };
=20
 static inline struct sun8i_mixer *
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_ui_layer.c
index 816ad4ce8996..9f82e7c33e90 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -24,12 +24,10 @@
 #include "sun8i_ui_scaler.h"
=20
 static void sun8i_ui_layer_enable(struct sun8i_mixer *mixer, int channel=
,
-				  int overlay, bool enable, unsigned int zpos,
-				  unsigned int old_zpos)
+				  int overlay, bool enable, unsigned int zpos)
 {
-	u32 val, bld_base, ch_base;
+	u32 val, ch_base;
=20
-	bld_base =3D sun8i_blender_base(mixer);
 	ch_base =3D sun8i_channel_base(mixer, channel);
=20
 	DRM_DEBUG_DRIVER("%sabling channel %d overlay %d\n",
@@ -44,32 +42,7 @@ static void sun8i_ui_layer_enable(struct sun8i_mixer *=
mixer, int channel,
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overlay),
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
=20
-	if (!enable || zpos !=3D old_zpos) {
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
-				   SUN8I_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
-				   0);
-
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_ROUTE(bld_base),
-				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
-				   0);
-	}
-
-	if (enable) {
-		val =3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
-
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
-				   val, val);
-
-		val =3D channel << SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(zpos);
-
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_ROUTE(bld_base),
-				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(zpos),
-				   val);
-	}
+	mixer->channel_zpos[channel] =3D enable ? zpos : -1;
 }
=20
 static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int ch=
annel,
@@ -267,11 +240,9 @@ static void sun8i_ui_layer_atomic_disable(struct drm=
_plane *plane,
 					  struct drm_plane_state *old_state)
 {
 	struct sun8i_ui_layer *layer =3D plane_to_sun8i_ui_layer(plane);
-	unsigned int old_zpos =3D old_state->normalized_zpos;
 	struct sun8i_mixer *mixer =3D layer->mixer;
=20
-	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay, false, 0,
-			      old_zpos);
+	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay, false, 0);
 }
=20
 static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
@@ -279,12 +250,11 @@ static void sun8i_ui_layer_atomic_update(struct drm=
_plane *plane,
 {
 	struct sun8i_ui_layer *layer =3D plane_to_sun8i_ui_layer(plane);
 	unsigned int zpos =3D plane->state->normalized_zpos;
-	unsigned int old_zpos =3D old_state->normalized_zpos;
 	struct sun8i_mixer *mixer =3D layer->mixer;
=20
 	if (!plane->state->visible) {
 		sun8i_ui_layer_enable(mixer, layer->channel,
-				      layer->overlay, false, 0, old_zpos);
+				      layer->overlay, false, 0);
 		return;
 	}
=20
@@ -295,7 +265,7 @@ static void sun8i_ui_layer_atomic_update(struct drm_p=
lane *plane,
 	sun8i_ui_layer_update_buffer(mixer, layer->channel,
 				     layer->overlay, plane);
 	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay,
-			      true, zpos, old_zpos);
+			      true, zpos);
 }
=20
 static const struct drm_plane_helper_funcs sun8i_ui_layer_helper_funcs =3D=
 {
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
index 76393fc976fe..c8c418fb906b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -18,12 +18,10 @@
 #include "sun8i_vi_scaler.h"
=20
 static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int channel=
,
-				  int overlay, bool enable, unsigned int zpos,
-				  unsigned int old_zpos)
+				  int overlay, bool enable, unsigned int zpos)
 {
-	u32 val, bld_base, ch_base;
+	u32 val, ch_base;
=20
-	bld_base =3D sun8i_blender_base(mixer);
 	ch_base =3D sun8i_channel_base(mixer, channel);
=20
 	DRM_DEBUG_DRIVER("%sabling VI channel %d overlay %d\n",
@@ -38,32 +36,7 @@ static void sun8i_vi_layer_enable(struct sun8i_mixer *=
mixer, int channel,
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay),
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN, val);
=20
-	if (!enable || zpos !=3D old_zpos) {
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
-				   SUN8I_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
-				   0);
-
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_ROUTE(bld_base),
-				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
-				   0);
-	}
-
-	if (enable) {
-		val =3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
-
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
-				   val, val);
-
-		val =3D channel << SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(zpos);
-
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_ROUTE(bld_base),
-				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(zpos),
-				   val);
-	}
+	mixer->channel_zpos[channel] =3D enable ? zpos : -1;
 }
=20
 static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int ch=
annel,
@@ -370,11 +343,9 @@ static void sun8i_vi_layer_atomic_disable(struct drm=
_plane *plane,
 					  struct drm_plane_state *old_state)
 {
 	struct sun8i_vi_layer *layer =3D plane_to_sun8i_vi_layer(plane);
-	unsigned int old_zpos =3D old_state->normalized_zpos;
 	struct sun8i_mixer *mixer =3D layer->mixer;
=20
-	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay, false, 0,
-			      old_zpos);
+	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay, false, 0);
 }
=20
 static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
@@ -382,12 +353,11 @@ static void sun8i_vi_layer_atomic_update(struct drm=
_plane *plane,
 {
 	struct sun8i_vi_layer *layer =3D plane_to_sun8i_vi_layer(plane);
 	unsigned int zpos =3D plane->state->normalized_zpos;
-	unsigned int old_zpos =3D old_state->normalized_zpos;
 	struct sun8i_mixer *mixer =3D layer->mixer;
=20
 	if (!plane->state->visible) {
 		sun8i_vi_layer_enable(mixer, layer->channel,
-				      layer->overlay, false, 0, old_zpos);
+				      layer->overlay, false, 0);
 		return;
 	}
=20
@@ -398,7 +368,7 @@ static void sun8i_vi_layer_atomic_update(struct drm_p=
lane *plane,
 	sun8i_vi_layer_update_buffer(mixer, layer->channel,
 				     layer->overlay, plane);
 	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay,
-			      true, zpos, old_zpos);
+			      true, zpos);
 }
=20
 static const struct drm_plane_helper_funcs sun8i_vi_layer_helper_funcs =3D=
 {
--=20
2.30.0

