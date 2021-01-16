Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713822F8E23
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbhAPRFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbhAPQaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 11:30:09 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C665AC0617B9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 06:35:47 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id m6so7381061pfm.6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 06:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MIQtIapRIp0F6KGA4i11eksKxFabN3a9TcdiJADnn40=;
        b=VlHkNU4y3eUV6kU1oNjtkuLD26lqPq/suzFXoj/Gbi+N8/CnB8hTzA02EcnCh+DkZX
         rcS5zsShPzNhftyks7DhDfLjw5rgs31C/sKQTaW+MpTyoVz5ELq7h5/LhBxufFymj1Hz
         qnQ+/OX+93OokqH2oU3EdpfHxCa4O8d3mES9fBDCXoc9fBzIKxUxIZiu2c7+4uLWyWGu
         it0LTqThkpNT03jtA0Fa6TedswWrtc6JEmI2jQp9XgIUMZ2JoFixd8vz7BYWOwvAUNup
         aiTzfhpnwz03RekAm2pkIUZuW57Uqdf7TVzTgfXB//Yr9TBe2sK48QPzP7cRMv3HzrJz
         pipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MIQtIapRIp0F6KGA4i11eksKxFabN3a9TcdiJADnn40=;
        b=OBeSu4hgR7xIRWnc/7suTtXU+l9FNz7PIfnb1ypMcCeWm5Bie5mjoGw2TGU+50WXPi
         NAksAZ9yk/E3e3oqNRl/Eu2jcN/1EkK0tokgs62390FxTy3MJzAmjp6G6YjpLieIcX9k
         6xxekAp8wTPg0am1lSIVIna7xFYuTE/gv8qMey9rgLrjgU4ar0/WERr1HIuNNEhmv5g7
         lwJmP31MHMfJmh9zRa0l603Af5y5X4BcSwNDuAAaWWSwTZrGMhY/Rk1PS9duwEaj9OBa
         289rf7XIYyT3AWf9Kw5yxJEUaNe2X+p/OLui6e8w2cuPGS/UUyF8GupjwH6FR4w1lMGg
         8dzw==
X-Gm-Message-State: AOAM532IER/tCD0P733pl2cS0DcUJRshLof7dWi2g/melCsDCOLw0hQw
        OcrY+os0D/zeUZU+q0rDbh4=
X-Google-Smtp-Source: ABdhPJxB6a7Rn9R97oYiKtDHrYVhFZ2IBNT1naurUUJvawlPxpG4xG/xgCT33woZ69Ra/6ds/vpJRQ==
X-Received: by 2002:a63:6305:: with SMTP id x5mr17384061pgb.216.1610807747158;
        Sat, 16 Jan 2021 06:35:47 -0800 (PST)
Received: from localhost.localdomain ([122.172.57.223])
        by smtp.gmail.com with ESMTPSA id v2sm10942072pgs.50.2021.01.16.06.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 06:35:46 -0800 (PST)
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
Subject: [PATCH v3] drm/bridge/tc358775: Fixes bus formats read
Date:   Sat, 16 Jan 2021 20:05:34 +0530
Message-Id: <20210116143534.21863-1-simhavcs@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- state->output_bus_cfg.format, memcpy and
  unsigned int used
- atomic_check removed
- video data input and output formats added
- bus formats read from drm_bridge_state.output_bus_cfg.format
  and .atomic_get_input_bus_fmts() instead of connector

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>

---
v1:
 * Laurent Pinchart review comments incorporated
   drm_bridge_state.output_bus_cfg.format
   instead of connector
v2:
 * Laurent Pinchart review comments incorporated
   atomic_check removed
   ivideo data input and output formats added

v3:
 * Laurent Pinchart review comments incorporated
   output_bus_fmt removed and using state->output_bus_cfg.format
   unsigned int i used
   memcpy used for input_fmts
---
 drivers/gpu/drm/bridge/tc358775.c | 71 +++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 2272adcc5b4a..a8998dd447ae 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -273,6 +273,19 @@ struct tc_data {
 	u8			bpc;
 };
 
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
+};
+
 static inline struct tc_data *bridge_to_tc(struct drm_bridge *b)
 {
 	return container_of(b, struct tc_data, bridge);
@@ -359,19 +372,6 @@ static void d2l_write(struct i2c_client *i2c, u16 addr, u32 val)
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
@@ -380,7 +380,8 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 	u32 val = 0;
 	u16 dsiclk, clkdiv, byteclk, t1, t2, t3, vsdelay;
 	struct drm_display_mode *mode;
-	struct drm_connector *connector = get_connector(bridge->encoder);
+	struct drm_bridge_state *state =
+			drm_priv_to_bridge_state(bridge->base.state);
 
 	mode = &bridge->encoder->crtc->state->adjusted_mode;
 
@@ -451,14 +452,13 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 	d2l_write(tc->i2c, LVPHY0, LV_PHY0_PRBS_ON(4) | LV_PHY0_ND(6));
 
 	dev_dbg(tc->dev, "bus_formats %04x bpc %d\n",
-		connector->display_info.bus_formats[0],
+		state->output_bus_cfg.format,
 		tc->bpc);
 	/*
 	 * Default hardware register settings of tc358775 configured
 	 * with MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA jeida-24 format
 	 */
-	if (connector->display_info.bus_formats[0] ==
-		MEDIA_BUS_FMT_RGB888_1X7X4_SPWG) {
+	if (state->output_bus_cfg.format == MEDIA_BUS_FMT_RGB888_1X7X4_SPWG) {
 		/* VESA-24 */
 		d2l_write(tc->i2c, LV_MX0003, LV_MX(LVI_R0, LVI_R1, LVI_R2, LVI_R3));
 		d2l_write(tc->i2c, LV_MX0407, LV_MX(LVI_R4, LVI_R7, LVI_R5, LVI_G0));
@@ -590,6 +590,39 @@ static int tc358775_parse_dt(struct device_node *np, struct tc_data *tc)
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
+	unsigned int i;
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
+	memcpy(input_fmts, tc_lvds_in_bus_fmts, sizeof(*input_fmts));
+
+	return input_fmts;
+}
+
 static int tc_bridge_attach(struct drm_bridge *bridge,
 			    enum drm_bridge_attach_flags flags)
 {
@@ -639,6 +672,10 @@ static int tc_bridge_attach(struct drm_bridge *bridge,
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
2.17.1

