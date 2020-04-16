Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8061AD1B5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 23:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgDPVHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 17:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgDPVHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:07:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF4EC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 14:07:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 4501F2A23DF
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, sam@ravnborg.org,
        laurent.pinchart@ideasonboard.com,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/bridge: panel: Return always an error pointer in drm_panel_bridge_add()
Date:   Thu, 16 Apr 2020 23:06:54 +0200
Message-Id: <20200416210654.2468805-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 89958b7cd955 ("drm/bridge: panel: Infer connector type from
panel by default"), drm_panel_bridge_add() and their variants can return
NULL and an error pointer. This is fine but none of the actual users of
the API are checking for the NULL value. Instead of change all the
users, seems reasonable to return an error pointer instead. So change
the returned value for those functions when the connector type is unknown.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/bridge/panel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 8461ee8304ba..7a3df0f319f3 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -166,7 +166,7 @@ static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
  *
  * The connector type is set to @panel->connector_type, which must be set to a
  * known type. Calling this function with a panel whose connector type is
- * DRM_MODE_CONNECTOR_Unknown will return NULL.
+ * DRM_MODE_CONNECTOR_Unknown will return ERR_PTR(-EINVAL).
  *
  * See devm_drm_panel_bridge_add() for an automatically managed version of this
  * function.
@@ -174,7 +174,7 @@ static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
 struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel)
 {
 	if (WARN_ON(panel->connector_type == DRM_MODE_CONNECTOR_Unknown))
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	return drm_panel_bridge_add_typed(panel, panel->connector_type);
 }
@@ -265,7 +265,7 @@ struct drm_bridge *devm_drm_panel_bridge_add(struct device *dev,
 					     struct drm_panel *panel)
 {
 	if (WARN_ON(panel->connector_type == DRM_MODE_CONNECTOR_Unknown))
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	return devm_drm_panel_bridge_add_typed(dev, panel,
 					       panel->connector_type);
-- 
2.25.1

