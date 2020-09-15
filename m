Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1941B26A58A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgIOMtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:49:43 -0400
Received: from crapouillou.net ([89.234.176.41]:33022 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgIOMjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1600173514; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZAp/RBpkELKuzwDFGXtJ/YOyp65MA5kbEOUrTwgogrc=;
        b=NzvVhfNE9sKKL2YektrhMrA59RhdwamY+TRjwQsH6xg0Rcr6RwnutajzjgpYrKBSPM1XDM
        7GmcTMxCfOA/bj8kYj+VL+BYDBBrk/tp/I4eNy8xQGVbOgfxBndfP9CmaVxuu+Y1jzn6aS
        +B9WQwp4CxO+FFQbfTizRwsI9CExCOg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/3] drm/ingenic: Reset pixclock rate when parent clock rate changes
Date:   Tue, 15 Sep 2020 14:38:17 +0200
Message-Id: <20200915123818.13272-3-paul@crapouillou.net>
In-Reply-To: <20200915123818.13272-1-paul@crapouillou.net>
References: <20200915123818.13272-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Old Ingenic SoCs can overclock very well, up to +50% of their nominal
clock rate, whithout requiring overvolting or anything like that, just
by changing the rate of the main PLL. Unfortunately, all clocks on the
system are derived from that PLL, and when the PLL rate is updated, so
is our pixel clock.

To counter that issue, we make sure that the panel is in VBLANK before
the rate change happens, and we will then re-set the pixel clock rate
afterwards, once the PLL has been changed, to be as close as possible to
the pixel rate requested by the encoder.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 49 ++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index fb62869befdc..aa32660033d2 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -12,6 +12,7 @@
 #include <linux/dma-noncoherent.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -73,6 +74,9 @@ struct ingenic_drm {
 
 	bool panel_is_sharp;
 	bool no_vblank;
+	bool update_clk_rate;
+	struct mutex clk_mutex;
+	struct notifier_block clock_nb;
 };
 
 static bool ingenic_drm_cached_gem_buf;
@@ -115,6 +119,29 @@ static inline struct ingenic_drm *drm_crtc_get_priv(struct drm_crtc *crtc)
 	return container_of(crtc, struct ingenic_drm, crtc);
 }
 
+static inline struct ingenic_drm *drm_nb_get_priv(struct notifier_block *nb)
+{
+	return container_of(nb, struct ingenic_drm, clock_nb);
+}
+
+static int ingenic_drm_update_pixclk(struct notifier_block *nb,
+				     unsigned long action,
+				     void *data)
+{
+	struct ingenic_drm *priv = drm_nb_get_priv(nb);
+
+	switch (action) {
+	case PRE_RATE_CHANGE:
+		mutex_lock(&priv->clk_mutex);
+		priv->update_clk_rate = true;
+		drm_crtc_wait_one_vblank(&priv->crtc);
+		return NOTIFY_OK;
+	default:
+		mutex_unlock(&priv->clk_mutex);
+		return NOTIFY_OK;
+	}
+}
+
 static void ingenic_drm_crtc_atomic_enable(struct drm_crtc *crtc,
 					   struct drm_crtc_state *state)
 {
@@ -280,8 +307,14 @@ static void ingenic_drm_crtc_atomic_flush(struct drm_crtc *crtc,
 
 	if (drm_atomic_crtc_needs_modeset(state)) {
 		ingenic_drm_crtc_update_timings(priv, &state->mode);
+		priv->update_clk_rate = true;
+	}
 
+	if (priv->update_clk_rate) {
+		mutex_lock(&priv->clk_mutex);
 		clk_set_rate(priv->pix_clk, state->adjusted_mode.clock * 1000);
+		priv->update_clk_rate = false;
+		mutex_unlock(&priv->clk_mutex);
 	}
 
 	if (event) {
@@ -1046,16 +1079,28 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 	if (soc_info->has_osd)
 		regmap_write(priv->map, JZ_REG_LCD_OSDC, JZ_LCD_OSDC_OSDEN);
 
+	mutex_init(&priv->clk_mutex);
+	priv->clock_nb.notifier_call = ingenic_drm_update_pixclk;
+
+	parent_clk = clk_get_parent(priv->pix_clk);
+	ret = clk_notifier_register(parent_clk, &priv->clock_nb);
+	if (ret) {
+		dev_err(dev, "Unable to register clock notifier\n");
+		goto err_devclk_disable;
+	}
+
 	ret = drm_dev_register(drm, 0);
 	if (ret) {
 		dev_err(dev, "Failed to register DRM driver\n");
-		goto err_devclk_disable;
+		goto err_clk_notifier_unregister;
 	}
 
 	drm_fbdev_generic_setup(drm, 32);
 
 	return 0;
 
+err_clk_notifier_unregister:
+	clk_notifier_unregister(parent_clk, &priv->clock_nb);
 err_devclk_disable:
 	if (priv->lcd_clk)
 		clk_disable_unprepare(priv->lcd_clk);
@@ -1077,7 +1122,9 @@ static int compare_of(struct device *dev, void *data)
 static void ingenic_drm_unbind(struct device *dev)
 {
 	struct ingenic_drm *priv = dev_get_drvdata(dev);
+	struct clk *parent_clk = clk_get_parent(priv->pix_clk);
 
+	clk_notifier_unregister(parent_clk, &priv->clock_nb);
 	if (priv->lcd_clk)
 		clk_disable_unprepare(priv->lcd_clk);
 	clk_disable_unprepare(priv->pix_clk);
-- 
2.28.0

