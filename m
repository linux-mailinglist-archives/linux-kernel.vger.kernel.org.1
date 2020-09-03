Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DF025BC8D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 10:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgICIMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 04:12:34 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:41581 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728364AbgICICP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:15 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 43DA9C4E;
        Thu,  3 Sep 2020 04:02:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=k4qdYx2elgdUP
        0sfJWxtG0WskXqKIn4qDleAaUABh/o=; b=lp5lQp1iCTGyJPba34ahFtg9IMnNq
        3CQmdMhLfdT8rXta2RpGMo8vbBSHB/t5N+hhHdGQXN4Vh3qbvJaE7WpnH5HCoX/y
        eGcme/dpaCGCu6G3ZWpwZyjAfaWQjq4yanwXia5wFjN0DUo5Pj0zccJqdqfjCGR/
        l8r8rRg3l4yOpEXH0a7qCw4KC+W9Z6yokYUQVjF0U83yjvuv7qsjFhy+/9yHl20U
        4y8I2XhvgAYzciZHRysGtD3QGBV+/tZ7oRait8BJ17E1tapR7ywpfH/1U9MXKD36
        e9iUXSNoB62q/w3dowgWiYVsjEZFlDAe+3sL//Qpgbv9gYVe0+xWAOS7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=k4qdYx2elgdUP0sfJWxtG0WskXqKIn4qDleAaUABh/o=; b=ooE5lK0y
        EHJcbxhvLGcMx/OkndEsQdBz0t5DlxYWQIJdRF7wwDVsBoPkkCMlW8fWanM0B5td
        f1GifWthFuL1RfYjjdgy4lpQGU6SLB+FIlWYmgG+ovYeidhncdkzALg+2jYFoVzP
        9ZIEFyQOSHjuHETE3F/SC4ydMwJwnTvD/dDjZy6JE7BSogPcxcnyZi0659mPSSnr
        lVpwysrtPGUgz6EOSHby8AsFh+0RIaGP30GFd10BcWPHGj+yb5N4gEHSoR4Qpdar
        wvRg7bmjZLqb0+SuAhEksY8kJPLk+ow1Gc9ILjs+v6TALnbz1kDGIX3I2D4v1Nh1
        MtCzPIuBAO4f3g==
X-ME-Sender: <xms:AKNQX_VvpocJxU9uGoMOZUl6NAki2Uy6rrBgyX5_-SpSnsifVJX_0A>
    <xme:AKNQX3nlRT4W1tLKBzm6jMMro9oWNOThWcY9hq1XLAtoWmYVrSey0MLUR0jUFok8Q
    kKZt6XwZ-WHC7Zx3rM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeeine
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:AKNQX7bC2cB2H_VihOLGONWZGCm_wgN5TzNbYtk9Q9I7NqIcgcCdXg>
    <xmx:AKNQX6XXUlpBrzlTTiv5BlNOxpe7XkGwz7TRYT39sWZn89xZYx-xug>
    <xmx:AKNQX5nTYwEJBY_q76HgAqa5ZPLAezar5SthQadNHXIHCy73wz5ALA>
    <xmx:AKNQX_fIMKb_1691WbpHf95-hAxfpCtokR2MPDfN2-I5XUwNlIzq_OQEY-Y>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5088C328005A;
        Thu,  3 Sep 2020 04:02:08 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v5 10/80] drm/vc4: crtc: Rename HVS channel to output
Date:   Thu,  3 Sep 2020 10:00:42 +0200
Message-Id: <b7618bb17b1c435c5d6ce50bcde2fe9243281d02.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vc5, the HVS has 6 outputs and 3 FIFOs (or channels), with
pixelvalves each being assigned to a given output, but each output can
then be muxed to feed from multiple FIFOs.

Since vc4 had that entirely static, both were probably equivalent, but
since that changes, let's rename hvs_channel to hvs_output in the
vc4_crtc_data, since a pixelvalve is really connected to an output, and
not to a FIFO.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 8 ++++----
 drivers/gpu/drm/vc4/vc4_drv.h  | 4 ++--
 drivers/gpu/drm/vc4/vc4_hvs.c  | 2 +-
 drivers/gpu/drm/vc4/vc4_txp.c  | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index fdecaba77836..d3126fe04d9a 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -775,7 +775,7 @@ static const struct drm_crtc_helper_funcs vc4_crtc_helper_funcs = {
 
 static const struct vc4_pv_data bcm2835_pv0_data = {
 	.base = {
-		.hvs_channel = 0,
+		.hvs_output = 0,
 	},
 	.debugfs_name = "crtc0_regs",
 	.pixels_per_clock = 1,
@@ -787,7 +787,7 @@ static const struct vc4_pv_data bcm2835_pv0_data = {
 
 static const struct vc4_pv_data bcm2835_pv1_data = {
 	.base = {
-		.hvs_channel = 2,
+		.hvs_output = 2,
 	},
 	.debugfs_name = "crtc1_regs",
 	.pixels_per_clock = 1,
@@ -799,7 +799,7 @@ static const struct vc4_pv_data bcm2835_pv1_data = {
 
 static const struct vc4_pv_data bcm2835_pv2_data = {
 	.base = {
-		.hvs_channel = 1,
+		.hvs_output = 1,
 	},
 	.debugfs_name = "crtc2_regs",
 	.pixels_per_clock = 1,
@@ -862,7 +862,7 @@ int vc4_crtc_init(struct drm_device *drm, struct vc4_crtc *vc4_crtc,
 	drm_crtc_init_with_planes(drm, crtc, primary_plane, NULL,
 				  crtc_funcs, NULL);
 	drm_crtc_helper_add(crtc, crtc_helper_funcs);
-	vc4_crtc->channel = vc4_crtc->data->hvs_channel;
+	vc4_crtc->channel = vc4_crtc->data->hvs_output;
 	drm_mode_crtc_set_gamma_size(crtc, ARRAY_SIZE(vc4_crtc->lut_r));
 	drm_crtc_enable_color_mgmt(crtc, 0, false, crtc->gamma_size);
 
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index d80fc3bbb450..d1cf4c038180 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -447,8 +447,8 @@ to_vc4_encoder(struct drm_encoder *encoder)
 }
 
 struct vc4_crtc_data {
-	/* Which channel of the HVS this pixelvalve sources from. */
-	int hvs_channel;
+	/* Which output of the HVS this pixelvalve sources from. */
+	int hvs_output;
 };
 
 struct vc4_pv_data {
diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index abdb43c4cc10..365425d67f3f 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -419,7 +419,7 @@ void vc4_hvs_mode_set_nofb(struct drm_crtc *crtc)
 	struct drm_display_mode *mode = &crtc->state->adjusted_mode;
 	bool interlace = mode->flags & DRM_MODE_FLAG_INTERLACE;
 
-	if (vc4_crtc->data->hvs_channel == 2) {
+	if (vc4_crtc->data->hvs_output == 2) {
 		u32 dispctrl;
 		u32 dsp3_mux;
 
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index a7c3af0005a0..f39d9900d027 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -452,7 +452,7 @@ static irqreturn_t vc4_txp_interrupt(int irq, void *data)
 }
 
 static const struct vc4_crtc_data vc4_txp_crtc_data = {
-	.hvs_channel = 2,
+	.hvs_output = 2,
 };
 
 static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
-- 
git-series 0.9.1
