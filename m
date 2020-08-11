Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF5B24141B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 02:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgHKAXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 20:23:22 -0400
Received: from crapouillou.net ([89.234.176.41]:38676 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbgHKAXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 20:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1597105374; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PaKv81WQbkYK27ko6vcwQCQZgJ0sxMpHG+hYhPbwT7U=;
        b=xsvpiWDblQ9dyB62tybIa/UxD+yAnd9rVZoM1NyT9g+USATMdDyShZ33QlYICi+xgRd8ly
        uzH7hdUDbGuRBsG3kcvCZi4Yn50uIe06hRA0hnIR+flyYnN1LgwrUqYbye3WSLXgxhbuKy
        YzkDR4hM+tFEJ2ss7ZvSQ13PM+qhNa4=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/5] drm/panel: simple: Tweak timings of sharp,ls020b1dd01d for perfect 60Hz
Date:   Tue, 11 Aug 2020 02:22:39 +0200
Message-Id: <20200811002240.55194-5-paul@crapouillou.net>
In-Reply-To: <20200811002240.55194-1-paul@crapouillou.net>
References: <20200811002240.55194-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the video mode in order to obtain a perfect 60.00 Hz frame rate
using a 3 MHz pixel clock.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/panel/panel-simple.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 60052976e616..4aee7eca6ded 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3384,15 +3384,15 @@ static const struct panel_desc sharp_lq123p1jx31 = {
 
 static const struct drm_display_mode sharp_ls020b1dd01d_modes[] = {
 	{ /* 60 Hz */
-		.clock = 4200,
+		.clock = 3000,
 		.hdisplay = 240,
-		.hsync_start = 240 + 66,
-		.hsync_end = 240 + 66 + 1,
-		.htotal = 240 + 66 + 1 + 1,
+		.hsync_start = 240 + 8,
+		.hsync_end = 240 + 8 + 1,
+		.htotal = 240 + 8 + 1 + 1,
 		.vdisplay = 160,
-		.vsync_start = 160 + 52,
-		.vsync_end = 160 + 52 + 10,
-		.vtotal = 160 + 52 + 10 + 6,
+		.vsync_start = 160 + 24,
+		.vsync_end = 160 + 24 + 10,
+		.vtotal = 160 + 24 + 10 + 6,
 		.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC,
 	},
 };
-- 
2.28.0

