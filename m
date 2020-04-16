Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BF01ACDF3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 18:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbgDPQoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 12:44:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42294 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbgDPQoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:44:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 340102A22F6
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org, sam@ravnborg.org,
        laurent.pinchart@ideasonboard.com,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] drm/bridge: ps8640: Let panel to set the connector type
Date:   Thu, 16 Apr 2020 18:44:04 +0200
Message-Id: <20200416164404.2418426-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416164404.2418426-1-enric.balletbo@collabora.com>
References: <20200416164404.2418426-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel connector type should be set by the panel not the bridge, so
remove the connector_type assignment.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/bridge/parade-ps8640.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 956b76e0a44d..13755d278db6 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -278,8 +278,6 @@ static int ps8640_probe(struct i2c_client *client)
 	if (!panel)
 		return -ENODEV;
 
-	panel->connector_type = DRM_MODE_CONNECTOR_eDP;
-
 	ps_bridge->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
 	if (IS_ERR(ps_bridge->panel_bridge))
 		return PTR_ERR(ps_bridge->panel_bridge);
-- 
2.25.1

