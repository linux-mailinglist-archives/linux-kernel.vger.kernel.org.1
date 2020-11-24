Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1170E2C2E7D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390840AbgKXR0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:26:43 -0500
Received: from softboy.mntmn.com ([91.250.115.15]:34498 "EHLO
        softboy.mntmn.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390825AbgKXR0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:26:43 -0500
From:   "Lukas F. Hartmann" <lukas@mntre.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 softboy.mntmn.com A45C4720EE6
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mntre.com;
        s=mntremail; t=1606238800;
        bh=sMffCRC8t+pVcO6WbR04nkC1P/SDITAOk+2n+2D+EGg=;
        h=From:To:Cc:Subject:Date:From;
        b=QAKTCw8n2obR9UHANnvm8VhoMSBiqe+vsHOY0yp785hxcjZ0nCvt9RM9gzYMySAvd
         ynyQp4rNLA1zC+QtibDBOICDCwrsIAqaj5HQCXYkrewU92P9O9E20HjfWbCiLpGkVE
         OUR2bws5hkLvYarRGkqC+voJSu3jOnJC2tq1posC5FssgvxofC9RhWWpA/I8iqJkbs
         3pmPk3wInhwZ8QY6O8BlqB9Zc0yvXyAS8iY+xv4iNEZggMOyi+4OqRrRVsk4PhGeTe
         o8VqON5W9V++UQrdiR4dzzWatrTzhMlCJOlu6H3OonPMUrnQyBJDEXSTHp+QFmeaIJ
         Nh82Im9OTQXWw==
To:     lukas@mntre.com
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] panel-simple: add Innolux N125HCE-GN1
Date:   Tue, 24 Nov 2020 18:26:04 +0100
Message-Id: <20201124172604.981746-1-lukas@mntre.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Innolux N125HCE-GN1 display is used in the MNT Reform 2.0 laptop,
attached via eDP to a SN65DSI86 MIPI-DSI to eDP bridge.

Signed-off-by: Lukas F. Hartmann <lukas@mntre.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 2be358fb4..774acab52 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2263,6 +2263,31 @@ static const struct panel_desc innolux_n116bge = {
 	},
 };
 
+static const struct drm_display_mode innolux_n125hce_gn1_mode = {
+	.clock = 162000,
+	.hdisplay = 1920,
+	.hsync_start = 1920 + 40,
+	.hsync_end = 1920 + 40 + 40,
+	.htotal = 1920 + 40 + 40 + 80,
+	.vdisplay = 1080,
+	.vsync_start = 1080 + 4,
+	.vsync_end = 1080 + 4 + 4,
+	.vtotal = 1080 + 4 + 4 + 24,
+};
+
+static const struct panel_desc innolux_n125hce_gn1 = {
+	.modes = &innolux_n125hce_gn1_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 276,
+		.height = 155,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DATA_MSB_TO_LSB,
+	.connector_type = DRM_MODE_CONNECTOR_eDP,
+};
+
 static const struct drm_display_mode innolux_n156bge_l21_mode = {
 	.clock = 69300,
 	.hdisplay = 1366,
@@ -4092,6 +4117,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "innolux,n116bge",
 		.data = &innolux_n116bge,
+	}, {
+		.compatible = "innolux,n125hce-gn1",
+		.data = &innolux_n125hce_gn1,
 	}, {
 		.compatible = "innolux,n156bge-l21",
 		.data = &innolux_n156bge_l21,
-- 
2.28.0

