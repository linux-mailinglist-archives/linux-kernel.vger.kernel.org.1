Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244182329A8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 03:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgG3Bq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 21:46:57 -0400
Received: from crapouillou.net ([89.234.176.41]:46182 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgG3Bq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 21:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1596073595; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Od02ztwhZR7+HWXUOfeTO8vPkZfLIWEWfZjF8yhUdY=;
        b=VZwCyelQgx8HOfSNa9jbao/V+Qn0oyzT2z74fpKfZtkgt9GLGh+hK3EpktJZepLYrAnGSy
        CtC3SoqEuxKQAOHBsdAlFclxBuh8bEGrqp3PwnR054bOOkujWpDLPx3Y3xgYt655Og/kRV
        Vqizm968AX4OoRI2vELbh5rd2HyxtGo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     od@zcrc.me, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/3] drm/ingenic: ipu: Only enable clock when needed
Date:   Thu, 30 Jul 2020 03:46:26 +0200
Message-Id: <20200730014626.83895-4-paul@crapouillou.net>
In-Reply-To: <20200730014626.83895-1-paul@crapouillou.net>
References: <20200730014626.83895-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of keeping the IPU clock enabled constantly, enable and disable
it on demand, when the IPU plane is used.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-ipu.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c b/drivers/gpu/drm/ingenic/ingenic-ipu.c
index f4f0abcd6692..17e682cf1eba 100644
--- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
+++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
@@ -49,6 +49,7 @@ struct ingenic_ipu {
 	struct regmap *map;
 	struct clk *clk;
 	const struct soc_info *soc_info;
+	bool clk_enabled;
 
 	unsigned int num_w, num_h, denom_w, denom_h;
 
@@ -288,12 +289,23 @@ static void ingenic_ipu_plane_atomic_update(struct drm_plane *plane,
 	const struct drm_format_info *finfo;
 	u32 ctrl, stride = 0, coef_index = 0, format = 0;
 	bool needs_modeset, upscaling_w, upscaling_h;
+	int err;
 
 	if (!state || !state->fb)
 		return;
 
 	finfo = drm_format_info(state->fb->format->format);
 
+	if (!ipu->clk_enabled) {
+		err = clk_enable(ipu->clk);
+		if (err) {
+			dev_err(ipu->dev, "Unable to enable clock: %d\n", err);
+			return;
+		}
+
+		ipu->clk_enabled = true;
+	}
+
 	/* Reset all the registers if needed */
 	needs_modeset = drm_atomic_crtc_needs_modeset(state->crtc->state);
 	if (needs_modeset) {
@@ -578,6 +590,11 @@ static void ingenic_ipu_plane_atomic_disable(struct drm_plane *plane,
 	regmap_clear_bits(ipu->map, JZ_REG_IPU_CTRL, JZ_IPU_CTRL_CHIP_EN);
 
 	ingenic_drm_plane_disable(ipu->master, plane);
+
+	if (ipu->clk_enabled) {
+		clk_disable(ipu->clk);
+		ipu->clk_enabled = false;
+	}
 }
 
 static const struct drm_plane_helper_funcs ingenic_ipu_plane_helper_funcs = {
@@ -761,9 +778,9 @@ static int ingenic_ipu_bind(struct device *dev, struct device *master, void *d)
 	drm_object_attach_property(&plane->base, ipu->sharpness_prop,
 				   ipu->sharpness);
 
-	err = clk_prepare_enable(ipu->clk);
+	err = clk_prepare(ipu->clk);
 	if (err) {
-		dev_err(dev, "Unable to enable clock\n");
+		dev_err(dev, "Unable to prepare clock\n");
 		return err;
 	}
 
@@ -775,7 +792,7 @@ static void ingenic_ipu_unbind(struct device *dev,
 {
 	struct ingenic_ipu *ipu = dev_get_drvdata(dev);
 
-	clk_disable_unprepare(ipu->clk);
+	clk_unprepare(ipu->clk);
 }
 
 static const struct component_ops ingenic_ipu_ops = {
-- 
2.27.0

