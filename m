Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EF6210966
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 12:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgGAKb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 06:31:57 -0400
Received: from vps.xff.cz ([195.181.215.36]:42460 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729991AbgGAKbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593599492; bh=io8IIDWW5fH3zfZMutivNOdZXhTkjY8qZHk7MdbKacI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=gy45UMG7npGE5n3k3wmTIWyxBRnS3RNnq0zN/QhbfTZmzOZWPdJVXclVZhxc62Mfg
         z5y2m6G1YbAGjR3ctVxjMOrpB/CG2my9Ihja8LqpIP3zJOnDb2B6YGd5EMERsJ6trQ
         0jvtNZsoedRGwUBKixGUQ2eaYfGGyRFi9JGH+XN4=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>
Cc:     Ondrej Jirman <megous@megous.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Subject: [PATCH v6 07/13] drm/panel: st7703: Move code specific to jh057n closer together
Date:   Wed,  1 Jul 2020 12:31:20 +0200
Message-Id: <20200701103126.1512615-8-megous@megous.com>
In-Reply-To: <20200701103126.1512615-1-megous@megous.com>
References: <20200701103126.1512615-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's better than having it spread around the driver.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 50 +++++++++----------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index 08cbc316266c..d03aab10cfef 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -153,6 +153,31 @@ static int jh057n_init_sequence(struct st7703 *ctx)
 	return 0;
 }
 
+static const struct drm_display_mode jh057n00900_mode = {
+	.hdisplay    = 720,
+	.hsync_start = 720 + 90,
+	.hsync_end   = 720 + 90 + 20,
+	.htotal	     = 720 + 90 + 20 + 20,
+	.vdisplay    = 1440,
+	.vsync_start = 1440 + 20,
+	.vsync_end   = 1440 + 20 + 4,
+	.vtotal	     = 1440 + 20 + 4 + 12,
+	.vrefresh    = 60,
+	.clock	     = 75276,
+	.flags	     = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+	.width_mm    = 65,
+	.height_mm   = 130,
+};
+
+struct st7703_panel_desc jh057n00900_panel_desc = {
+	.mode = &jh057n00900_mode,
+	.lanes = 4,
+	.mode_flags = MIPI_DSI_MODE_VIDEO |
+		MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_VIDEO_SYNC_PULSE,
+	.format = MIPI_DSI_FMT_RGB888,
+	.init_sequence = jh057n_init_sequence,
+};
+
 static int st7703_enable(struct drm_panel *panel)
 {
 	struct st7703 *ctx = panel_to_st7703(panel);
@@ -226,31 +251,6 @@ static int st7703_prepare(struct drm_panel *panel)
 	return ret;
 }
 
-static const struct drm_display_mode jh057n00900_mode = {
-	.hdisplay    = 720,
-	.hsync_start = 720 + 90,
-	.hsync_end   = 720 + 90 + 20,
-	.htotal	     = 720 + 90 + 20 + 20,
-	.vdisplay    = 1440,
-	.vsync_start = 1440 + 20,
-	.vsync_end   = 1440 + 20 + 4,
-	.vtotal	     = 1440 + 20 + 4 + 12,
-	.vrefresh    = 60,
-	.clock	     = 75276,
-	.flags	     = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
-	.width_mm    = 65,
-	.height_mm   = 130,
-};
-
-struct st7703_panel_desc jh057n00900_panel_desc = {
-	.mode = &jh057n00900_mode,
-	.lanes = 4,
-	.mode_flags = MIPI_DSI_MODE_VIDEO |
-		MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_VIDEO_SYNC_PULSE,
-	.format = MIPI_DSI_FMT_RGB888,
-	.init_sequence = jh057n_init_sequence,
-};
-
 static int st7703_get_modes(struct drm_panel *panel,
 			    struct drm_connector *connector)
 {
-- 
2.27.0

