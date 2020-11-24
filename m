Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DAE2C2E58
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390637AbgKXRUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:20:42 -0500
Received: from softboy.mntmn.com ([91.250.115.15]:59012 "EHLO
        softboy.mntmn.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390140AbgKXRUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:20:41 -0500
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Nov 2020 12:20:40 EST
From:   "Lukas F. Hartmann" <lukas@mntre.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 softboy.mntmn.com 5B16A720718
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mntre.com;
        s=mntremail; t=1606237969;
        bh=UEu8QDWrOSRJQOojTYBi65+7G2OU5JZ5f4MfrL5efs4=;
        h=From:To:Cc:Subject:Date:From;
        b=dixofOlgFN3BMeNmGaGzbvnWgAxoJfqMfxmQGjJlXm6NW6rNfIzUI0nUj1mVJoOpI
         s6Dui+LI4tSjA2/O6aQ5BEUoQ+nmtC29fz3yrj8ZGQB8iuHHEf8kBeCefUIdoGGuuk
         QgpYOEPaNk8WJ7vTtpuHL/OjHjz6HX4pn9iqlrKDxGBHsT2zBZ/87uMHrad0yEgMEe
         BQ+sxgKnumrAuomnP97wG3hRT3PS/dR/5pwr9WdPPfMudy04jRhYg78amxfZvwlwK0
         JVQu4qxE1Kb990gFE09o7bwA1LzzqL8Y4F1gyM+6z2X4asoVAEMdTuErwflzz8XaGE
         ubx5BaDwVnmkg==
To:     lukas@mntre.com
Cc:     agx@sigxcpu.org, laurentiu.palcu@nxp.com,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: nwl-dsi: fixup mode only for LCDIF input, not DCSS
Date:   Tue, 24 Nov 2020 18:12:17 +0100
Message-Id: <20201124171216.980628-1-lukas@mntre.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fixup of HSYNC and VSYNC should not be done when the input source is
DCSS, or internal display does not work on MNT Reform 2 (open hardware 
laptop based on NXP i.MX8M using DCSS->DSI->eDP for internal display).

Signed-off-by: Lukas F. Hartmann <lukas@mntre.com>
---
 drivers/gpu/drm/bridge/nwl-dsi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 66b67402f..6735ab2a2 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -807,10 +807,16 @@ static bool nwl_dsi_bridge_mode_fixup(struct drm_bridge *bridge,
 				      const struct drm_display_mode *mode,
 				      struct drm_display_mode *adjusted_mode)
 {
-	/* At least LCDIF + NWL needs active high sync */
-	adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
-	adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
+	struct device_node *remote;
+	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
+
+	remote = of_graph_get_remote_node(dsi->dev->of_node, 0,
+						NWL_DSI_ENDPOINT_LCDIF);
+	if (remote) {
+		/* At least LCDIF + NWL needs active high sync */
+		adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
+		adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
+	}

 	return true;
 }
--
2.28.0
