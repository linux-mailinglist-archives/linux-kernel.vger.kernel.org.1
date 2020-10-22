Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB914295885
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 08:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503368AbgJVGqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 02:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409780AbgJVGqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 02:46:04 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A70C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 23:46:04 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id m3so463192pjf.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 23:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=c453qtYp4+kqUNar4yPQ33bHiMSGU/Heqv+afQDk3IE=;
        b=oksaLU8/d0ArYDNg/+kQD3NHCn//UP6sXaTQKAsy2hqzNvy/Xq/bYha9JeLMQEYxVI
         YmefwxuerXdpx3ibgs30i9xpeHxGM4+6NsEu6fLiCofzQTfumduvqNplzS4gILXd7MCe
         QY3Z81Yzb8+qHLIFofDMDi6dPo/aR4Sl4DLSekGHLIwGF1RboCVgeFASD+taTS05CQ67
         rvPaBtbz1faSangS77JbnrZBvLohVxdmkk1r399WtnjtiFgWTlS3xduy4Un6uabLiM00
         g4FBYEIZH92EkiRo12CohZD76zPoM8U5fAA5VdXo6SLEEOyARd2lod4MPXeQ/8eAhkwT
         mjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c453qtYp4+kqUNar4yPQ33bHiMSGU/Heqv+afQDk3IE=;
        b=P7Ey3SW7xlYME32bZoDE+dHbCY2OKMAdNuB4KaBJIxUx+bfqR30orb4zUw/Kba5M0b
         XztBf8+O2DhEyRSvi7n6BSgoTwL7ye+t526cHierPkUa2S5Fet0h/ucJyyJe00ReZzqw
         BLvSgBuCSVtQBndiGMSu2l6RmbuAiRSPVB1ZyPH+UNciQHAA1FyvsBSZDEFL3XK8Udua
         ebMapYA2vnPvYFohlQxg5wOgNYfJk3hOQB0r2QG+7IB87/mvHwGzf3Byz2S+bYh5qOdU
         oeBg9RBXZix/htpWm8JorItaT9c3fV1nnM6cOlbYBNhL67kqpv1fU1wE9owjN4Hfvxua
         bh1w==
X-Gm-Message-State: AOAM533KQMsl8ilDEuPPaY4trrcR9wyPUn6tU4edomtGL/gNcd1QpR1P
        pVDQvD/+YCB8UJ3r4B5oV1A=
X-Google-Smtp-Source: ABdhPJwjP9cQ7BIJoNY9u9mraCOYWvPRfG2ImbEE9Ew69vpO5f/aYwqasGZPWnzSg0IQSjqwBfDYGQ==
X-Received: by 2002:a17:90a:b38f:: with SMTP id e15mr1075003pjr.226.1603349163608;
        Wed, 21 Oct 2020 23:46:03 -0700 (PDT)
Received: from inforce-server-Z9PE-D8-WS.routereb3c90.com ([106.51.138.45])
        by smtp.gmail.com with ESMTPSA id m22sm816004pfk.214.2020.10.21.23.46.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2020 23:46:03 -0700 (PDT)
From:   Vinay Simha BN <simhavcs@gmail.com>
Cc:     Vinay Simha BN <simhavcs@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RESEND v2] drm/bridge/tc358775: Fixes bus formats read
Date:   Thu, 22 Oct 2020 12:15:47 +0530
Message-Id: <1603349147-3495-1-git-send-email-simhavcs@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- atomic_check removed
- video data input and output formats added
- bus formats read from drm_bridge_state.output_bus_cfg.format
  and .atomic_get_input_bus_fmts() instead of connector

Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>

---
v1:
 * Laurent Pinchart review comments incorporated
   drm_bridge_state.output_bus_cfg.format
   instead of connector
v2:
 * Laurent Pinchart review comments incorporated
   atomic_check removed
   video data input and output formats added
---
 drivers/gpu/drm/bridge/tc358775.c | 75 ++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 2272adc..cc27570 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -271,6 +271,20 @@ struct tc_data {
 	struct gpio_desc	*stby_gpio;
 	u8			lvds_link; /* single-link or dual-link */
 	u8			bpc;
+	u32			output_bus_fmt;
+};
+
+static const u32 tc_lvds_in_bus_fmts[] = {
+	MEDIA_BUS_FMT_RGB565_1X16,
+	MEDIA_BUS_FMT_RGB666_1X18,
+	MEDIA_BUS_FMT_RGB666_1X24_CPADHI,
+	MEDIA_BUS_FMT_RBG888_1X24,
+};
+
+static const u32 tc_lvds_out_bus_fmts[] = {
+	MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,
+	MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
 };
 
 static inline struct tc_data *bridge_to_tc(struct drm_bridge *b)
@@ -359,19 +373,6 @@ static void d2l_write(struct i2c_client *i2c, u16 addr, u32 val)
 			ret, addr);
 }
 
-/* helper function to access bus_formats */
-static struct drm_connector *get_connector(struct drm_encoder *encoder)
-{
-	struct drm_device *dev = encoder->dev;
-	struct drm_connector *connector;
-
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head)
-		if (connector->encoder == encoder)
-			return connector;
-
-	return NULL;
-}
-
 static void tc_bridge_enable(struct drm_bridge *bridge)
 {
 	struct tc_data *tc = bridge_to_tc(bridge);
@@ -380,7 +381,10 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 	u32 val = 0;
 	u16 dsiclk, clkdiv, byteclk, t1, t2, t3, vsdelay;
 	struct drm_display_mode *mode;
-	struct drm_connector *connector = get_connector(bridge->encoder);
+	struct drm_bridge_state *state =
+			drm_priv_to_bridge_state(bridge->base.state);
+
+	tc->output_bus_fmt = state->output_bus_cfg.format;
 
 	mode = &bridge->encoder->crtc->state->adjusted_mode;
 
@@ -451,14 +455,13 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 	d2l_write(tc->i2c, LVPHY0, LV_PHY0_PRBS_ON(4) | LV_PHY0_ND(6));
 
 	dev_dbg(tc->dev, "bus_formats %04x bpc %d\n",
-		connector->display_info.bus_formats[0],
+		tc->output_bus_fmt,
 		tc->bpc);
 	/*
 	 * Default hardware register settings of tc358775 configured
 	 * with MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA jeida-24 format
 	 */
-	if (connector->display_info.bus_formats[0] ==
-		MEDIA_BUS_FMT_RGB888_1X7X4_SPWG) {
+	if (tc->output_bus_fmt == MEDIA_BUS_FMT_RGB888_1X7X4_SPWG) {
 		/* VESA-24 */
 		d2l_write(tc->i2c, LV_MX0003, LV_MX(LVI_R0, LVI_R1, LVI_R2, LVI_R3));
 		d2l_write(tc->i2c, LV_MX0407, LV_MX(LVI_R4, LVI_R7, LVI_R5, LVI_G0));
@@ -590,6 +593,40 @@ static int tc358775_parse_dt(struct device_node *np, struct tc_data *tc)
 	return 0;
 }
 
+static u32 *
+tc_bridge_get_input_bus_fmts(struct drm_bridge *bridge,
+			     struct drm_bridge_state *bridge_state,
+			     struct drm_crtc_state *crtc_state,
+			     struct drm_connector_state *conn_state,
+			     u32 output_fmt,
+			     unsigned int *num_input_fmts)
+{
+	u32 *input_fmts = NULL;
+	u8 i;
+
+	*num_input_fmts = 0;
+
+	for (i = 0 ; i < ARRAY_SIZE(tc_lvds_out_bus_fmts) ; ++i) {
+		if (output_fmt == tc_lvds_out_bus_fmts[i])
+			break;
+	}
+
+	if (i == ARRAY_SIZE(tc_lvds_out_bus_fmts))
+		return NULL;
+
+	*num_input_fmts = ARRAY_SIZE(tc_lvds_in_bus_fmts);
+
+	input_fmts = kcalloc(*num_input_fmts, ARRAY_SIZE(tc_lvds_in_bus_fmts),
+			     GFP_KERNEL);
+	if (!input_fmts)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(tc_lvds_in_bus_fmts); ++i)
+		input_fmts[i] = tc_lvds_in_bus_fmts[i];
+
+	return input_fmts;
+}
+
 static int tc_bridge_attach(struct drm_bridge *bridge,
 			    enum drm_bridge_attach_flags flags)
 {
@@ -639,6 +676,10 @@ static int tc_bridge_attach(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs tc_bridge_funcs = {
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_get_input_bus_fmts = tc_bridge_get_input_bus_fmts,
 	.attach = tc_bridge_attach,
 	.pre_enable = tc_bridge_pre_enable,
 	.enable = tc_bridge_enable,
-- 
2.7.4

