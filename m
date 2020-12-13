Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8522D90B1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 22:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406252AbgLMU7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 15:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406125AbgLMU73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 15:59:29 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BDEC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 12:58:49 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id c79so10740892pfc.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 12:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cV5HriR1prutNnEWeEh019pGge7+13bd6D41C4Ekd5Q=;
        b=OZcGbT8kwpS858URPvYH/hk8Cv8phVufS9o2lm7CkxBz1Cih9awW3p14u5teMd5ufj
         4hBi9+X5AP+KCZcHYl7IHZbKgzslSi+SmW0mihweJAPNsXt7x73YuA3APOTaYAsiILRA
         YbEx54eVOjX4NG/IVJHRJIOOLiEHKOMm1GBcyUm8rzoqV36ylmM31QvkOTsUKQX4xk6n
         fCjtHurago7mgqJaiBdLfnLLaaWVgOR7tcVgi1EoFjRuYBuLS/eE1VHTdawmJ8Qbk8JN
         Rx+FfRAnMvvBLLbblas3Lq1M57VO+G5xXZH4NPwUh1kDp2UcbqlwX8HxS5kkHTG7/ZaE
         VLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cV5HriR1prutNnEWeEh019pGge7+13bd6D41C4Ekd5Q=;
        b=fge0Zbi9yQiVGAk544BqQMT7tDQjJcB+QGvVOL350PYWRNE8+8WQt9LLKwmP51u624
         8iZf4+GpupTRAUFzJ5pQQZRTdsuhycqjWXCjsqov3k4T88Gp/MXi1zPgEkhLBvKuegKU
         Q9wAGGif6hjW3MI6W9W1HdeMKdXITQ0IOZ6hY4J+yoJYSAqxAGXKrgVdIzv4bSxJSe+Z
         ju7D38vuMC/zpdTRLoyarrKSXZs7xNkWiFTq9YYRQRj0McqC42mS29eBWd1C/5dxGc8Y
         HiLJOTR2FVaD8AKXvadP2/dc4Y/W7XlpR7wHGhHG4WjWDfCy1H3NDr8KF6YTMC1FxTrK
         325w==
X-Gm-Message-State: AOAM531TpLOFMnRYKyACy50jwPFp2QD9y07FKlTUPYb1Qf80wqf+JaAx
        RGU00xedlx1NcRZAb+bPWaBGA1jWyJluLtnd
X-Google-Smtp-Source: ABdhPJwxpMaX8CI0pTjsWTuCS+cpxcLlMYJe0TIdCEEetVT2dRtmQIxjBynqrcKzAEU/dAgYUDUb/g==
X-Received: by 2002:a63:e:: with SMTP id 14mr21327818pga.253.1607893128792;
        Sun, 13 Dec 2020 12:58:48 -0800 (PST)
Received: from glados.. ([2601:647:6000:3e5b::a27])
        by smtp.gmail.com with ESMTPSA id n5sm17720029pgm.29.2020.12.13.12.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 12:58:48 -0800 (PST)
From:   Thomas Hebb <tommyhebb@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrzej Hajda <a.hajda@samsung.com>
Cc:     Thomas Hebb <tommyhebb@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sandy Huang <hjc@rock-chips.com>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [RESEND PATCH] drm/rockchip: dsi: move all lane config except LCDC mux to bind()
Date:   Sun, 13 Dec 2020 12:58:45 -0800
Message-Id: <b2cba542d148f9f955469f6ff7ae0514b825b646.1607893119.git.tommyhebb@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we first enable the DSI encoder, we currently program some per-chip
configuration that we look up in rk3399_chip_data based on the device
tree compatible we match. This data configures various parameters of the
MIPI lanes, including on RK3399 whether DSI1 is slaved to DSI0 in a
dual-mode configuration. It also selects which LCDC (i.e. VOP) to scan
out from.

This causes a problem in RK3399 dual-mode configurations, though: panel
prepare() callbacks run before the encoder gets enabled and expect to be
able to write commands to the DSI bus, but the bus isn't fully
functional until the lane and master/slave configuration have been
programmed. As a result, dual-mode panels (and possibly others too) fail
to turn on when the rockchipdrm driver is initially loaded.

Because the LCDC mux is the only thing we don't know until enable time
(and is the only thing that can ever change), we can actually move most
of the initialization to bind() and get it out of the way early. That's
what this change does. (Rockchip's 4.4 BSP kernel does it in mode_set(),
which also avoids the issue, but bind() seems like the more correct
place to me.)

Tested on a Google Scarlet board (Acer Chromebook Tab 10), which has a
Kingdisplay KD097D04 dual-mode panel. Prior to this change, the panel's
backlight would turn on but no image would appear when initially loading
rockchipdrm. If I kept rockchipdrm loaded and reloaded the panel driver,
it would come on. With this change, the panel successfully turns on
during initial rockchipdrm load as expected.

Fixes: 2d4f7bdafd70 ("drm/rockchip: dsi: migrate to use dw-mipi-dsi bridge driver")
Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
---
Resending since I wasn't subscribed to dri-devel

 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 36 ++++++++++++++-----
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index ce044db8c97e..d0c9610ad220 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -691,13 +691,8 @@ static const struct dw_mipi_dsi_phy_ops dw_mipi_dsi_rockchip_phy_ops = {
 	.get_timing = dw_mipi_dsi_phy_get_timing,
 };
 
-static void dw_mipi_dsi_rockchip_config(struct dw_mipi_dsi_rockchip *dsi,
-					int mux)
+static void dw_mipi_dsi_rockchip_config(struct dw_mipi_dsi_rockchip *dsi)
 {
-	if (dsi->cdata->lcdsel_grf_reg)
-		regmap_write(dsi->grf_regmap, dsi->cdata->lcdsel_grf_reg,
-			mux ? dsi->cdata->lcdsel_lit : dsi->cdata->lcdsel_big);
-
 	if (dsi->cdata->lanecfg1_grf_reg)
 		regmap_write(dsi->grf_regmap, dsi->cdata->lanecfg1_grf_reg,
 					      dsi->cdata->lanecfg1);
@@ -711,6 +706,13 @@ static void dw_mipi_dsi_rockchip_config(struct dw_mipi_dsi_rockchip *dsi,
 					      dsi->cdata->enable);
 }
 
+static void dw_mipi_dsi_rockchip_set_lcdsel(struct dw_mipi_dsi_rockchip *dsi,
+					    int mux)
+{
+	regmap_write(dsi->grf_regmap, dsi->cdata->lcdsel_grf_reg,
+		mux ? dsi->cdata->lcdsel_lit : dsi->cdata->lcdsel_big);
+}
+
 static int
 dw_mipi_dsi_encoder_atomic_check(struct drm_encoder *encoder,
 				 struct drm_crtc_state *crtc_state,
@@ -766,9 +768,9 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
 		return;
 	}
 
-	dw_mipi_dsi_rockchip_config(dsi, mux);
+	dw_mipi_dsi_rockchip_set_lcdsel(dsi, mux);
 	if (dsi->slave)
-		dw_mipi_dsi_rockchip_config(dsi->slave, mux);
+		dw_mipi_dsi_rockchip_set_lcdsel(dsi->slave, mux);
 
 	clk_disable_unprepare(dsi->grf_clk);
 }
@@ -922,6 +924,24 @@ static int dw_mipi_dsi_rockchip_bind(struct device *dev,
 		return ret;
 	}
 
+	/*
+	 * With the GRF clock running, write lane and dual-mode configurations
+	 * that won't change immediately. If we waited until enable() to do
+	 * this, things like panel preparation would not be able to send
+	 * commands over DSI.
+	 */
+	ret = clk_prepare_enable(dsi->grf_clk);
+	if (ret) {
+		DRM_DEV_ERROR(dsi->dev, "Failed to enable grf_clk: %d\n", ret);
+		return ret;
+	}
+
+	dw_mipi_dsi_rockchip_config(dsi);
+	if (dsi->slave)
+		dw_mipi_dsi_rockchip_config(dsi->slave);
+
+	clk_disable_unprepare(dsi->grf_clk);
+
 	ret = rockchip_dsi_drm_create_encoder(dsi, drm_dev);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "Failed to create drm encoder\n");
-- 
2.29.2

