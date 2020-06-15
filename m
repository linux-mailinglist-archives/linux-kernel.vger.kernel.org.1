Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC711FA17F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 22:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731469AbgFOUbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 16:31:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37084 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgFOUbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:31:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C719A2A2CF7
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        laurent.pinchart@ideasonboard.com, Sam Ravnborg <sam@ravnborg.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Subject: [RESEND PATCH v4 1/7] drm/bridge: ps8640: Get the EDID from eDP control
Date:   Mon, 15 Jun 2020 22:31:02 +0200
Message-Id: <20200615203108.786083-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615203108.786083-1-enric.balletbo@collabora.com>
References: <20200615203108.786083-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PS8640 DSI-to-eDP bridge can retrieve the EDID, so implement the
.get_edid callback and set the flag to indicate the core to use it.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/bridge/parade-ps8640.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 4b099196afeba..13755d278db6d 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -242,8 +242,18 @@ static int ps8640_bridge_attach(struct drm_bridge *bridge,
 	return ret;
 }
 
+static struct edid *ps8640_bridge_get_edid(struct drm_bridge *bridge,
+					   struct drm_connector *connector)
+{
+	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
+
+	return drm_get_edid(connector,
+			    ps_bridge->page[PAGE0_DP_CNTL]->adapter);
+}
+
 static const struct drm_bridge_funcs ps8640_bridge_funcs = {
 	.attach = ps8640_bridge_attach,
+	.get_edid = ps8640_bridge_get_edid,
 	.post_disable = ps8640_post_disable,
 	.pre_enable = ps8640_pre_enable,
 };
@@ -294,6 +304,8 @@ static int ps8640_probe(struct i2c_client *client)
 
 	ps_bridge->bridge.funcs = &ps8640_bridge_funcs;
 	ps_bridge->bridge.of_node = dev->of_node;
+	ps_bridge->bridge.ops = DRM_BRIDGE_OP_EDID;
+	ps_bridge->bridge.type = DRM_MODE_CONNECTOR_eDP;
 
 	ps_bridge->page[PAGE0_DP_CNTL] = client;
 
-- 
2.27.0

