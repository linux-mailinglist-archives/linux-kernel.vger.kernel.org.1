Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DF92AE071
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 21:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbgKJUFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 15:05:49 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:44531 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731608AbgKJUFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 15:05:46 -0500
Received: from localhost.localdomain (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 9B9F0200004;
        Tue, 10 Nov 2020 20:05:42 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Yao <markyao0591@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH] drm/rockchip: Avoid uninitialized use of endpoint id in LVDS
Date:   Tue, 10 Nov 2020 21:04:30 +0100
Message-Id: <20201110200430.1713467-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the Rockchip DRM LVDS component driver, the endpoint id provided to
drm_of_find_panel_or_bridge is grabbed from the endpoint's reg property.

However, the property may be missing in the case of a single endpoint.
Initialize the endpoint_id variable to 0 to avoid using an
uninitialized variable in that case.

Fixes: 34cc0aa25456 ("drm/rockchip: Add support for Rockchip Soc LVDS")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index f292c6a6e20f..41edd0a421b2 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -544,7 +544,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 	struct device_node  *port, *endpoint;
 	int ret = 0, child_count = 0;
 	const char *name;
-	u32 endpoint_id;
+	u32 endpoint_id = 0;
 
 	lvds->drm_dev = drm_dev;
 	port = of_graph_get_port_by_id(dev->of_node, 1);
-- 
2.28.0

