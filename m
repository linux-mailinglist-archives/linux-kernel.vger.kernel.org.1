Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698D9285281
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 21:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgJFTde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 15:33:34 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38200 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgJFTdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 15:33:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9C5F5296573
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        yongqiang.niu@mediatek.com, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        chunkuang.hu@kernel.org, CK Hu <ck.hu@mediatek.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/4] soc / drm: mediatek: Move DDP component defines into mtk-mmsys.h
Date:   Tue,  6 Oct 2020 21:33:17 +0200
Message-Id: <20201006193320.405529-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006193320.405529-1-enric.balletbo@collabora.com>
References: <20201006193320.405529-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

MMSYS is the driver which controls the routing of these DDP components,
so the definition of the mtk_ddp_comp_id enum should be placed in mtk-mmsys.h

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
This patch was previously part of another series, but has no
dependencies and can be applied independently. As the latest version
sent is from two months ago, I resent this patch because the next patches
of this series depends on it to apply cleanly.

[1] https://patchwork.kernel.org/patch/11706243

 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 34 +--------------------
 drivers/soc/mediatek/mtk-mmsys.c            |  4 +--
 include/linux/soc/mediatek/mtk-mmsys.h      | 33 ++++++++++++++++++++
 3 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index debe36395fe7..161201fe5179 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -7,6 +7,7 @@
 #define MTK_DRM_DDP_COMP_H
 
 #include <linux/io.h>
+#include <linux/soc/mediatek/mtk-mmsys.h>
 
 struct device;
 struct device_node;
@@ -35,39 +36,6 @@ enum mtk_ddp_comp_type {
 	MTK_DDP_COMP_TYPE_MAX,
 };
 
-enum mtk_ddp_comp_id {
-	DDP_COMPONENT_AAL0,
-	DDP_COMPONENT_AAL1,
-	DDP_COMPONENT_BLS,
-	DDP_COMPONENT_CCORR,
-	DDP_COMPONENT_COLOR0,
-	DDP_COMPONENT_COLOR1,
-	DDP_COMPONENT_DITHER,
-	DDP_COMPONENT_DPI0,
-	DDP_COMPONENT_DPI1,
-	DDP_COMPONENT_DSI0,
-	DDP_COMPONENT_DSI1,
-	DDP_COMPONENT_DSI2,
-	DDP_COMPONENT_DSI3,
-	DDP_COMPONENT_GAMMA,
-	DDP_COMPONENT_OD0,
-	DDP_COMPONENT_OD1,
-	DDP_COMPONENT_OVL0,
-	DDP_COMPONENT_OVL_2L0,
-	DDP_COMPONENT_OVL_2L1,
-	DDP_COMPONENT_OVL1,
-	DDP_COMPONENT_PWM0,
-	DDP_COMPONENT_PWM1,
-	DDP_COMPONENT_PWM2,
-	DDP_COMPONENT_RDMA0,
-	DDP_COMPONENT_RDMA1,
-	DDP_COMPONENT_RDMA2,
-	DDP_COMPONENT_UFOE,
-	DDP_COMPONENT_WDMA0,
-	DDP_COMPONENT_WDMA1,
-	DDP_COMPONENT_ID_MAX,
-};
-
 struct mtk_ddp_comp;
 struct cmdq_pkt;
 struct mtk_ddp_comp_funcs {
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index a55f25511173..36ad66bb221b 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -5,13 +5,11 @@
  */
 
 #include <linux/device.h>
+#include <linux/io.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/soc/mediatek/mtk-mmsys.h>
 
-#include "../../gpu/drm/mediatek/mtk_drm_ddp.h"
-#include "../../gpu/drm/mediatek/mtk_drm_ddp_comp.h"
-
 #define DISP_REG_CONFIG_DISP_OVL0_MOUT_EN	0x040
 #define DISP_REG_CONFIG_DISP_OVL1_MOUT_EN	0x044
 #define DISP_REG_CONFIG_DISP_OD_MOUT_EN		0x048
diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
index 7bab5d9a3d31..2228bf6133da 100644
--- a/include/linux/soc/mediatek/mtk-mmsys.h
+++ b/include/linux/soc/mediatek/mtk-mmsys.h
@@ -9,6 +9,39 @@
 enum mtk_ddp_comp_id;
 struct device;
 
+enum mtk_ddp_comp_id {
+	DDP_COMPONENT_AAL0,
+	DDP_COMPONENT_AAL1,
+	DDP_COMPONENT_BLS,
+	DDP_COMPONENT_CCORR,
+	DDP_COMPONENT_COLOR0,
+	DDP_COMPONENT_COLOR1,
+	DDP_COMPONENT_DITHER,
+	DDP_COMPONENT_DPI0,
+	DDP_COMPONENT_DPI1,
+	DDP_COMPONENT_DSI0,
+	DDP_COMPONENT_DSI1,
+	DDP_COMPONENT_DSI2,
+	DDP_COMPONENT_DSI3,
+	DDP_COMPONENT_GAMMA,
+	DDP_COMPONENT_OD0,
+	DDP_COMPONENT_OD1,
+	DDP_COMPONENT_OVL0,
+	DDP_COMPONENT_OVL_2L0,
+	DDP_COMPONENT_OVL_2L1,
+	DDP_COMPONENT_OVL1,
+	DDP_COMPONENT_PWM0,
+	DDP_COMPONENT_PWM1,
+	DDP_COMPONENT_PWM2,
+	DDP_COMPONENT_RDMA0,
+	DDP_COMPONENT_RDMA1,
+	DDP_COMPONENT_RDMA2,
+	DDP_COMPONENT_UFOE,
+	DDP_COMPONENT_WDMA0,
+	DDP_COMPONENT_WDMA1,
+	DDP_COMPONENT_ID_MAX,
+};
+
 void mtk_mmsys_ddp_connect(struct device *dev,
 			   enum mtk_ddp_comp_id cur,
 			   enum mtk_ddp_comp_id next);
-- 
2.28.0

