Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C024216D72
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 15:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgGGNH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 09:07:28 -0400
Received: from crapouillou.net ([89.234.176.41]:45666 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgGGNH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 09:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1594127240; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YjUN5iHsuoX3i3c10PKFGKRySNFxu1qtYOPInkkgVzM=;
        b=RS5Z4PVVeEE7Cgt3y1X3NbDmFYU5FoyMgJGnNHJdGUWE3OcYWpyusZ2g0/UkBY6cyMr7vD
        +DZ3qzooRvYao2dY23C4RXNVdpFrTlUWcMJuw4q5lphm8ZQzoyGv/N7/R+QaSdxE04Vm9I
        DwYE1ozQrW0bJKMWbHsBP7QkwfUGL8Q=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] drm/panel-simple: Add 50 Hz mode to the Frida FRD350H54004 panel
Date:   Tue,  7 Jul 2020 15:07:07 +0200
Message-Id: <20200707130707.51843-2-paul@crapouillou.net>
In-Reply-To: <20200707130707.51843-1-paul@crapouillou.net>
References: <20200707130707.51843-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By changing the pixel clock and the length of the back porch, it is
possible to obtain a perfect 50 Hz refresh rate.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/panel/panel-simple.c | 43 +++++++++++++++++++---------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 1188d191076b..bebcc31e2484 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1692,23 +1692,38 @@ static const struct panel_desc foxlink_fl500wvr00_a0t = {
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 };
 
-static const struct drm_display_mode frida_frd350h54004_mode = {
-	.clock = 6000,
-	.hdisplay = 320,
-	.hsync_start = 320 + 44,
-	.hsync_end = 320 + 44 + 16,
-	.htotal = 320 + 44 + 16 + 20,
-	.vdisplay = 240,
-	.vsync_start = 240 + 2,
-	.vsync_end = 240 + 2 + 6,
-	.vtotal = 240 + 2 + 6 + 2,
-	.vrefresh = 60,
-	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+static const struct drm_display_mode frida_frd350h54004_modes[] = {
+	{ /* 60 Hz */
+		.clock = 6000,
+		.hdisplay = 320,
+		.hsync_start = 320 + 44,
+		.hsync_end = 320 + 44 + 16,
+		.htotal = 320 + 44 + 16 + 20,
+		.vdisplay = 240,
+		.vsync_start = 240 + 2,
+		.vsync_end = 240 + 2 + 6,
+		.vtotal = 240 + 2 + 6 + 2,
+		.vrefresh = 60,
+		.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+	},
+	{ /* 50 Hz */
+		.clock = 5400,
+		.hdisplay = 320,
+		.hsync_start = 320 + 56,
+		.hsync_end = 320 + 56 + 16,
+		.htotal = 320 + 56 + 16 + 40,
+		.vdisplay = 240,
+		.vsync_start = 240 + 2,
+		.vsync_end = 240 + 2 + 6,
+		.vtotal = 240 + 2 + 6 + 2,
+		.vrefresh = 50,
+		.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+	},
 };
 
 static const struct panel_desc frida_frd350h54004 = {
-	.modes = &frida_frd350h54004_mode,
-	.num_modes = 1,
+	.modes = frida_frd350h54004_modes,
+	.num_modes = ARRAY_SIZE(frida_frd350h54004_modes),
 	.bpc = 8,
 	.size = {
 		.width = 77,
-- 
2.27.0

