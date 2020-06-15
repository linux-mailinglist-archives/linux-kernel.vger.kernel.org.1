Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4D61FA180
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 22:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbgFOUb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 16:31:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37108 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731447AbgFOUbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:31:21 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E36792A2CF9
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        laurent.pinchart@ideasonboard.com, Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [RESEND PATCH v4 2/7] drm/bridge_connector: Set default status connected for eDP connectors
Date:   Mon, 15 Jun 2020 22:31:03 +0200
Message-Id: <20200615203108.786083-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615203108.786083-1-enric.balletbo@collabora.com>
References: <20200615203108.786083-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an eDP application, HPD is not required and on most bridge chips
useless. If HPD is not used, we need to set initial status as connected,
otherwise the connector created by the drm_bridge_connector API remains
in an unknown state.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/drm_bridge_connector.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
index c6994fe673f31..a58cbde59c34a 100644
--- a/drivers/gpu/drm/drm_bridge_connector.c
+++ b/drivers/gpu/drm/drm_bridge_connector.c
@@ -187,6 +187,7 @@ drm_bridge_connector_detect(struct drm_connector *connector, bool force)
 		case DRM_MODE_CONNECTOR_DPI:
 		case DRM_MODE_CONNECTOR_LVDS:
 		case DRM_MODE_CONNECTOR_DSI:
+		case DRM_MODE_CONNECTOR_eDP:
 			status = connector_status_connected;
 			break;
 		default:
-- 
2.27.0

