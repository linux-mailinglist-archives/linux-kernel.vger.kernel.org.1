Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F292F252908
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 10:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgHZIPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 04:15:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39516 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbgHZIPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:15:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 95E3929943E
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
Subject: [PATCH v2 4/5] drm/bridge: ps8640: Print an error if VDO control fails
Date:   Wed, 26 Aug 2020 10:15:25 +0200
Message-Id: <20200826081526.674866-5-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826081526.674866-1-enric.balletbo@collabora.com>
References: <20200826081526.674866-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print an error message inside ps8640_bridge_vdo_control() function when
it fails so we can simplify a bit the callers, they will only need to
check the error code.

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v2: None

 drivers/gpu/drm/bridge/parade-ps8640.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index ce3e8b2da8c9..9f7b7a9c53c5 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -82,8 +82,11 @@ static int ps8640_bridge_vdo_control(struct ps8640 *ps_bridge,
 	ret = i2c_smbus_write_i2c_block_data(client, PAGE3_SET_ADD,
 					     sizeof(vdo_ctrl_buf),
 					     vdo_ctrl_buf);
-	if (ret < 0)
+	if (ret < 0) {
+		DRM_ERROR("failed to %sable VDO: %d\n",
+			  ctrl == ENABLE ? "en" : "dis", ret);
 		return ret;
+	}
 
 	return 0;
 }
@@ -150,10 +153,8 @@ static void ps8640_pre_enable(struct drm_bridge *bridge)
 	}
 
 	ret = ps8640_bridge_vdo_control(ps_bridge, ENABLE);
-	if (ret) {
-		DRM_ERROR("failed to enable VDO: %d\n", ret);
+	if (ret)
 		goto err_regulators_disable;
-	}
 
 	/* Switch access edp panel's edid through i2c */
 	ret = i2c_smbus_write_byte_data(client, PAGE2_I2C_BYPASS,
@@ -175,9 +176,7 @@ static void ps8640_post_disable(struct drm_bridge *bridge)
 	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
 	int ret;
 
-	ret = ps8640_bridge_vdo_control(ps_bridge, DISABLE);
-	if (ret < 0)
-		DRM_ERROR("failed to disable VDO: %d\n", ret);
+	ps8640_bridge_vdo_control(ps_bridge, DISABLE);
 
 	gpiod_set_value(ps_bridge->gpio_reset, 1);
 	gpiod_set_value(ps_bridge->gpio_powerdown, 1);
-- 
2.28.0

