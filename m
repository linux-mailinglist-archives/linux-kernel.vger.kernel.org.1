Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480612C2E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390735AbgKXRW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:22:27 -0500
Received: from softboy.mntmn.com ([91.250.115.15]:59956 "EHLO
        softboy.mntmn.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731584AbgKXRW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:22:27 -0500
From:   "Lukas F. Hartmann" <lukas@mntre.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 softboy.mntmn.com E7CF4720718
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mntre.com;
        s=mntremail; t=1606238545;
        bh=zWxM/wxXWXl9FNzLuVjGFhUbHvK5lFkGbM6Pl961KgU=;
        h=From:To:Cc:Subject:Date:From;
        b=ThUchsg5n4mz41zZSdrdKILEWwpBeTFFZRTMU2wxLJJ6yg0mVZaE/ShjsOGRXa7Id
         xJAg4vICce5tROWr+djCh2n8zQUi1kv7gZXDCNMlXhZkK77tTPVXaVLYyzCLnr0dNB
         rh50WYbwhnoDS6jKR2mm/NbnGG9xelzvCiKNxtmrryCXPURU895JJCD+UT0oIqJD3y
         WS/5jfAd49DTRmY6LL5Ynrdaj+Ws1XTmlwXO+HKoMWY8herjaTVMbOJWW3x+UFZuPe
         lsBZ/BYJKMxESiVeSp9QcQK4t9FrCntv0SqmVpybji4EIYHWv5K+UTeTDOrdJCnJyO
         +a77IkpJn4DGA==
To:     lukas@mntre.com
Cc:     agx@sigxcpu.org, laurentiu.palcu@nxp.com,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC] dcss: fix attaching to sn56dsi86 bridge
Date:   Tue, 24 Nov 2020 18:19:57 +0100
Message-Id: <20201124171956.981307-1-lukas@mntre.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sn56dsi86 DSI to eDP bridge driver does not support attaching
without a drm connector. This patch makes the attachment work. Required
for the display chain in MNT Reform 2.0 (DCSS->NWL DSI->SN56DSI86->EDP).

Signed-off-by: Lukas F. Hartmann <lukas@mntre.com>
---
 drivers/gpu/drm/imx/dcss/dcss-kms.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-kms.c b/drivers/gpu/drm/imx/dcss/dcss-kms.c
index 135a62366..4967f828b 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-kms.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-kms.c
@@ -82,6 +82,7 @@ static int dcss_kms_bridge_connector_init(struct dcss_kms_dev *kms)
 	struct drm_crtc *crtc = (struct drm_crtc *)&kms->crtc;
 	struct drm_panel *panel;
 	struct drm_bridge *bridge;
+	struct drm_connector_list_iter iter;
 	int ret;

 	ret = drm_of_find_panel_or_bridge(ddev->dev->of_node, 0, 0,
@@ -104,19 +105,19 @@ static int dcss_kms_bridge_connector_init(struct dcss_kms_dev *kms)
 		return ret;
 	}

-	ret = drm_bridge_attach(encoder, bridge, NULL,
-				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	ret = drm_bridge_attach(encoder, bridge, NULL, 0);
 	if (ret < 0) {
 		dev_err(ddev->dev, "Unable to attach bridge %pOF\n",
 			bridge->of_node);
 		return ret;
 	}

-	kms->connector = drm_bridge_connector_init(ddev, encoder);
-	if (IS_ERR(kms->connector)) {
-		dev_err(ddev->dev, "Unable to create bridge connector.\n");
-		return PTR_ERR(kms->connector);
-	}
+	/*
+	 * This hack to look up the connector is copied from mxsfb.
+	 */
+	drm_connector_list_iter_begin(ddev, &iter);
+	kms->connector = drm_connector_list_iter_next(&iter);
+	drm_connector_list_iter_end(&iter);

 	drm_connector_attach_encoder(kms->connector, encoder);

--
2.28.0
