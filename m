Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24281FA20D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 22:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbgFOUxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 16:53:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37452 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731643AbgFOUxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:53:34 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A7F0C2A20C5
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        laurent.pinchart@ideasonboard.com, sam@ravnborg.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 3/3] drm/bridge: ps8640: Rework power state handling
Date:   Mon, 15 Jun 2020 22:53:20 +0200
Message-Id: <20200615205320.790334-4-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615205320.790334-1-enric.balletbo@collabora.com>
References: <20200615205320.790334-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_edid() callback can be triggered anytime by an ioctl, i.e

  drm_mode_getconnector (ioctl)
    -> drm_helper_probe_single_connector_modes
       -> drm_bridge_connector_get_modes
          -> ps8640_bridge_get_edid

Actually if the bridge pre_enable() function was not called before
get_edid(), the driver will not be able to get the EDID properly and
display will not work until a second get_edid() call is issued and if
pre_enable() is called before. The side effect of this, for example, is
that you see anything when `Frecon` starts, neither the splash screen,
until the graphical session manager starts.

To fix this we need to make sure that all we need is enabled before
reading the EDID. This means the following:

1. If get_edid() is called before having the device powered we need to
   power on the device. In such case, the driver will power off again the
   device.

2. If get_edid() is called after having the device powered, all should
   just work. We added a powered flag in order to avoid recurrent calls
   to ps8640_bridge_poweron() and unneeded delays.

3. This seems to be specific for this device, but we need to make sure
   the panel is powered on before do a power on cycle on this device.
   Otherwise the device fails to retrieve the EDID.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/bridge/parade-ps8640.c | 79 ++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 9f7b7a9c53c52..ca651480891df 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -65,6 +65,7 @@ struct ps8640 {
 	struct regulator_bulk_data supplies[2];
 	struct gpio_desc *gpio_reset;
 	struct gpio_desc *gpio_powerdown;
+	bool powered;
 };
 
 static inline struct ps8640 *bridge_to_ps8640(struct drm_bridge *e)
@@ -91,13 +92,25 @@ static int ps8640_bridge_vdo_control(struct ps8640 *ps_bridge,
 	return 0;
 }
 
-static void ps8640_pre_enable(struct drm_bridge *bridge)
+static void ps8640_bridge_poweron(struct ps8640 *ps_bridge)
 {
-	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
 	struct i2c_client *client = ps_bridge->page[PAGE2_TOP_CNTL];
+	struct drm_bridge *panel;
 	unsigned long timeout;
 	int ret, status;
 
+	if (ps_bridge->powered)
+		return;
+
+	/*
+	 * That seems to be specific to this chip, and a weird behaviour, but
+	 * we need to call drm_panel_prepare before issuing a poweron cycle. If
+	 * we don't do this, the chip is not able to read properly the EDID.
+	 */
+	panel = ps_bridge->panel_bridge;
+	if (panel->funcs && panel->funcs->pre_enable)
+		panel->funcs->pre_enable(panel);
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(ps_bridge->supplies),
 				    ps_bridge->supplies);
 	if (ret < 0) {
@@ -164,6 +177,8 @@ static void ps8640_pre_enable(struct drm_bridge *bridge)
 		goto err_regulators_disable;
 	}
 
+	ps_bridge->powered = true;
+
 	return;
 
 err_regulators_disable:
@@ -171,12 +186,13 @@ static void ps8640_pre_enable(struct drm_bridge *bridge)
 			       ps_bridge->supplies);
 }
 
-static void ps8640_post_disable(struct drm_bridge *bridge)
+static void ps8640_bridge_poweroff(struct ps8640 *ps_bridge)
 {
-	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
+	struct drm_bridge *panel;
 	int ret;
 
-	ps8640_bridge_vdo_control(ps_bridge, DISABLE);
+	if (!ps_bridge->powered)
+		return;
 
 	gpiod_set_value(ps_bridge->gpio_reset, 1);
 	gpiod_set_value(ps_bridge->gpio_powerdown, 1);
@@ -184,6 +200,32 @@ static void ps8640_post_disable(struct drm_bridge *bridge)
 				     ps_bridge->supplies);
 	if (ret < 0)
 		DRM_ERROR("cannot disable regulators %d\n", ret);
+
+	panel = ps_bridge->panel_bridge;
+	if (panel->funcs && panel->funcs->post_disable)
+		panel->funcs->post_disable(panel);
+
+	ps_bridge->powered = false;
+}
+
+static void ps8640_pre_enable(struct drm_bridge *bridge)
+{
+	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
+	int ret;
+
+	ps8640_bridge_poweron(ps_bridge);
+
+	ret = ps8640_bridge_vdo_control(ps_bridge, DISABLE);
+	if (ret < 0)
+		ps8640_bridge_poweroff(ps_bridge);
+}
+
+static void ps8640_post_disable(struct drm_bridge *bridge)
+{
+	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
+
+	ps8640_bridge_vdo_control(ps_bridge, DISABLE);
+	ps8640_bridge_poweroff(ps_bridge);
 }
 
 static int ps8640_bridge_attach(struct drm_bridge *bridge,
@@ -249,9 +291,34 @@ static struct edid *ps8640_bridge_get_edid(struct drm_bridge *bridge,
 					   struct drm_connector *connector)
 {
 	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
+	bool poweroff = !ps_bridge->powered;
+	struct edid *edid;
+
+	/*
+	 * When we end calling get_edid() triggered by an ioctl, i.e
+	 *
+	 *   drm_mode_getconnector (ioctl)
+	 *     -> drm_helper_probe_single_connector_modes
+	 *        -> drm_bridge_connector_get_modes
+	 *           -> ps8640_bridge_get_edid
+	 *
+	 * We need to make sure that what we need is enabled before reading
+	 * EDID, for this chip, we need to do a full poweron, otherwise it will
+	 * fail.
+	 */
+	ps8640_bridge_poweron(ps_bridge);
 
-	return drm_get_edid(connector,
+	edid = drm_get_edid(connector,
 			    ps_bridge->page[PAGE0_DP_CNTL]->adapter);
+
+	/*
+	 * If we call the get_edid() function without having enabled the chip
+	 * before, return the chip to its original power state.
+	 */
+	if (poweroff)
+		ps8640_bridge_poweroff(ps_bridge);
+
+	return edid;
 }
 
 static const struct drm_bridge_funcs ps8640_bridge_funcs = {
-- 
2.27.0

