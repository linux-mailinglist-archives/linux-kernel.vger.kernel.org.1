Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0B420A9F2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 02:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgFZA4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 20:56:17 -0400
Received: from vps.xff.cz ([195.181.215.36]:45332 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgFZA4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 20:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593132968; bh=wLBTfvkPXA92DN0aPa1jL4zdt1fxD/3SPQM5mOVPwyY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=N5xMbVdHFKknjrdhPvC1BjB/SvOiGaLTR4EHg08ifBzEVjzR69mq2shPd/w1iLpiO
         wJB/7mrATY4n9vjxHgjwPtL1lTSZb6hJ8J0aO6JDi1XY9WwU/lTbz8EHr6D8MtFHFv
         weI+7Vz9h5WiixgyAaXayROEQW+UndJXFLJPqZyY=
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
Subject: [PATCH v5 10/13] drm/panel: st7703: Enter sleep after display off
Date:   Fri, 26 Jun 2020 02:55:58 +0200
Message-Id: <20200626005601.241022-11-megous@megous.com>
In-Reply-To: <20200626005601.241022-1-megous@megous.com>
References: <20200626005601.241022-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The datasheet suggests to issue sleep in after display off
as a part of the panel's shutdown sequence.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index 33611419059a..e771281eb547 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -394,8 +394,19 @@ static int st7703_disable(struct drm_panel *panel)
 {
 	struct st7703 *ctx = panel_to_st7703(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	int ret;
+
+	ret = mipi_dsi_dcs_set_display_off(dsi);
+	if (ret < 0)
+		DRM_DEV_ERROR(ctx->dev,
+			      "Failed to turn off the display: %d\n", ret);
 
-	return mipi_dsi_dcs_set_display_off(dsi);
+	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
+	if (ret < 0)
+		DRM_DEV_ERROR(ctx->dev,
+			      "Failed to enter sleep mode: %d\n", ret);
+
+	return 0;
 }
 
 static int st7703_unprepare(struct drm_panel *panel)
-- 
2.27.0

