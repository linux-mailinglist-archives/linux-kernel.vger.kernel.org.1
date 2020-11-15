Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055902B3190
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 01:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgKOAO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 19:14:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgKOAO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 19:14:27 -0500
Received: from DESKTOP-GFFITBK.localdomain (218-161-90-76.HINET-IP.hinet.net [218.161.90.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7992239D2;
        Sun, 15 Nov 2020 00:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605399266;
        bh=aFodP6QBgsn9xkYrio2coFUfOEugpYzOvzPkPjiijz4=;
        h=From:To:Cc:Subject:Date:From;
        b=ey5LMsHWOGuLxIFw7YVnb+bfMgjlg16qCiKGZDHQAJbRmq7Su1LHKYnDJCgOfXUS6
         PXXZd9LlW3wB78nNjrdOEbPKzs7VvbtKTRaJXeJlXvZ1PBkxLDEp7l97V7WZwJ4/w4
         67x+xF6/BYtdG13/jeY6rZk0OpHCZf2hVaHYkJcs=
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>,
        Bilal Wasim <bilalwasim676@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH] drm/mediatek: dsi: Calculate horizontal_backporch_byte by itself
Date:   Sun, 15 Nov 2020 08:14:03 +0800
Message-Id: <20201115001403.7833-1-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: CK Hu <ck.hu@mediatek.com>

Using vm->hfront_porch + vm->hback_porch to calculate
horizontal_backporch_byte would make it negtive, so
use horizontal_backporch_byte itself to make it positive.

Fixes: 35bf948f1edb ("drm/mediatek: dsi: Fix scrolling of panel with small hfp or hbp")

Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 53 ++++++++++--------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 4a188a942c38..2a64fdaed9a7 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -444,7 +444,10 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
 	u32 horizontal_sync_active_byte;
 	u32 horizontal_backporch_byte;
 	u32 horizontal_frontporch_byte;
+	u32 horizontal_front_back_byte;
+	u32 data_phy_cycles_byte;
 	u32 dsi_tmp_buf_bpp, data_phy_cycles;
+	u32 delta;
 	struct mtk_phy_timing *timing = &dsi->phy_timing;
 
 	struct videomode *vm = &dsi->vm;
@@ -474,42 +477,22 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
 	data_phy_cycles = timing->lpx + timing->da_hs_prepare +
 			  timing->da_hs_zero + timing->da_hs_exit;
 
-	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
-		if ((vm->hfront_porch + vm->hback_porch) * dsi_tmp_buf_bpp >
-		    data_phy_cycles * dsi->lanes + 18) {
-			horizontal_frontporch_byte =
-				vm->hfront_porch * dsi_tmp_buf_bpp -
-				(data_phy_cycles * dsi->lanes + 18) *
-				vm->hfront_porch /
-				(vm->hfront_porch + vm->hback_porch);
-
-			horizontal_backporch_byte =
-				horizontal_backporch_byte -
-				(data_phy_cycles * dsi->lanes + 18) *
-				vm->hback_porch /
-				(vm->hfront_porch + vm->hback_porch);
-		} else {
-			DRM_WARN("HFP less than d-phy, FPS will under 60Hz\n");
-			horizontal_frontporch_byte = vm->hfront_porch *
-						     dsi_tmp_buf_bpp;
-		}
+	delta = dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST ? 18 : 12;
+
+	horizontal_frontporch_byte = vm->hfront_porch * dsi_tmp_buf_bpp;
+	horizontal_front_back_byte = horizontal_frontporch_byte + horizontal_backporch_byte;
+	data_phy_cycles_byte = data_phy_cycles * dsi->lanes + delta;
+
+	if (horizontal_front_back_byte > data_phy_cycles_byte) {
+		horizontal_frontporch_byte -= data_phy_cycles_byte *
+					      horizontal_frontporch_byte /
+					      horizontal_front_back_byte;
+
+		horizontal_backporch_byte -= data_phy_cycles_byte *
+					     horizontal_backporch_byte /
+					     horizontal_front_back_byte;
 	} else {
-		if ((vm->hfront_porch + vm->hback_porch) * dsi_tmp_buf_bpp >
-		    data_phy_cycles * dsi->lanes + 12) {
-			horizontal_frontporch_byte =
-				vm->hfront_porch * dsi_tmp_buf_bpp -
-				(data_phy_cycles * dsi->lanes + 12) *
-				vm->hfront_porch /
-				(vm->hfront_porch + vm->hback_porch);
-			horizontal_backporch_byte = horizontal_backporch_byte -
-				(data_phy_cycles * dsi->lanes + 12) *
-				vm->hback_porch /
-				(vm->hfront_porch + vm->hback_porch);
-		} else {
-			DRM_WARN("HFP less than d-phy, FPS will under 60Hz\n");
-			horizontal_frontporch_byte = vm->hfront_porch *
-						     dsi_tmp_buf_bpp;
-		}
+		DRM_WARN("HFP + HBP less than d-phy, FPS will under 60Hz\n");
 	}
 
 	writel(horizontal_sync_active_byte, dsi->regs + DSI_HSA_WC);
-- 
2.17.1

