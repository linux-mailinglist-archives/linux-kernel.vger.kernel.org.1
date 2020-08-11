Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D0324141C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 02:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgHKAX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 20:23:29 -0400
Received: from crapouillou.net ([89.234.176.41]:38698 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbgHKAX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 20:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1597105374; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8AQMkbmdhOguOVhFrlhaDMnBpKno97BYw594g3hdJ4U=;
        b=crs9kUCotubhHCSrMtCvBxvgzCbzdCHdDYhpIvJW/4kWWOMuBYlgBtWyR/772iRZ4+fGBY
        0TNhg8koRNG1EIluSegEYHKteqp2f9Rlf672emmaFZY+seE7xlL1TAHDv1nBE4GOqtnMvd
        UWBL7r/ShCQhOGskMna2MW5NZ62IK78=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 5/5] drm/panel: simple: Add 50Hz mode for sharp,ls020b1dd01d
Date:   Tue, 11 Aug 2020 02:22:40 +0200
Message-Id: <20200811002240.55194-6-paul@crapouillou.net>
In-Reply-To: <20200811002240.55194-1-paul@crapouillou.net>
References: <20200811002240.55194-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a perfect 50.00 Hz frame rate mode to the list of available modes
for the Sharp LS020B1DD01D panel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/panel/panel-simple.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 4aee7eca6ded..1cf63582b5a2 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3383,6 +3383,18 @@ static const struct panel_desc sharp_lq123p1jx31 = {
 };
 
 static const struct drm_display_mode sharp_ls020b1dd01d_modes[] = {
+	{ /* 50 Hz */
+		.clock = 3000,
+		.hdisplay = 240,
+		.hsync_start = 240 + 58,
+		.hsync_end = 240 + 58 + 1,
+		.htotal = 240 + 58 + 1 + 1,
+		.vdisplay = 160,
+		.vsync_start = 160 + 24,
+		.vsync_end = 160 + 24 + 10,
+		.vtotal = 160 + 24 + 10 + 6,
+		.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC,
+	},
 	{ /* 60 Hz */
 		.clock = 3000,
 		.hdisplay = 240,
-- 
2.28.0

