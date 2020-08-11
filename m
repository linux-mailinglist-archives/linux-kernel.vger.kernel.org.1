Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6ED241415
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 02:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgHKAXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 20:23:16 -0400
Received: from crapouillou.net ([89.234.176.41]:38654 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbgHKAXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 20:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1597105373; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GktzCBVn5TL5skxl6f39MlCJqX9Y1dfzq1NIw7kCWEM=;
        b=eQqJ7WpMqyRcqSiOsp1qOfPwvIpBwnxypyTpdM7IrUu+Rb5HqnhXiQGu0RQyIjk8lR/Uqd
        w6XiTbUzQCzo0jJzHzIclAOViJxazw8Wj8KWvBdcK3JB+RieClX+xXueM0bNgN9iHe2qg1
        QqzLRjc/8xvnx+aWijegYWVFmCsj8Ns=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/5] drm/panel: simple: Convert sharp,ls020b1dd01d from timings to videomode
Date:   Tue, 11 Aug 2020 02:22:38 +0200
Message-Id: <20200811002240.55194-4-paul@crapouillou.net>
In-Reply-To: <20200811002240.55194-1-paul@crapouillou.net>
References: <20200811002240.55194-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Sharp LS020B1DD01D panel entry from using a struct
display_timing to using a struct drm_display_mode, as display_timing
seems to be the old and legacy format.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/panel/panel-simple.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 3787748b5bd0..60052976e616 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3382,22 +3382,24 @@ static const struct panel_desc sharp_lq123p1jx31 = {
 	},
 };
 
-static const struct display_timing sharp_ls020b1dd01d_timing = {
-	.pixelclock = { 2000000, 4200000, 5000000 },
-	.hactive = { 240, 240, 240 },
-	.hfront_porch = { 66, 66, 66 },
-	.hback_porch = { 1, 1, 1 },
-	.hsync_len = { 1, 1, 1 },
-	.vactive = { 160, 160, 160 },
-	.vfront_porch = { 52, 52, 52 },
-	.vback_porch = { 6, 6, 6 },
-	.vsync_len = { 10, 10, 10 },
-	.flags = DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW,
+static const struct drm_display_mode sharp_ls020b1dd01d_modes[] = {
+	{ /* 60 Hz */
+		.clock = 4200,
+		.hdisplay = 240,
+		.hsync_start = 240 + 66,
+		.hsync_end = 240 + 66 + 1,
+		.htotal = 240 + 66 + 1 + 1,
+		.vdisplay = 160,
+		.vsync_start = 160 + 52,
+		.vsync_end = 160 + 52 + 10,
+		.vtotal = 160 + 52 + 10 + 6,
+		.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC,
+	},
 };
 
 static const struct panel_desc sharp_ls020b1dd01d = {
-	.timings = &sharp_ls020b1dd01d_timing,
-	.num_timings = 1,
+	.modes = sharp_ls020b1dd01d_modes,
+	.num_modes = ARRAY_SIZE(sharp_ls020b1dd01d_modes),
 	.bpc = 6,
 	.size = {
 		.width = 42,
-- 
2.28.0

