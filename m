Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE522D617F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391315AbgLJQMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:12:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:38770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388530AbgLJQLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:11:41 -0500
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH v2 01/12] drm/mediatek: Get CMDQ client register for all ddp component
Date:   Fri, 11 Dec 2020 00:10:39 +0800
Message-Id: <20201210161050.8460-2-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201210161050.8460-1-chunkuang.hu@kernel.org>
References: <20201210161050.8460-1-chunkuang.hu@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only OVL, RDMA,and WDMA get CMDQ client register information,
but all ddp component should work with CMDQ, so get this
information for all ddp component.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 29 +++++++++++----------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 3064eac1a750..cab53431ceec 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -506,6 +506,21 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 	if (IS_ERR(comp->clk))
 		return PTR_ERR(comp->clk);
 
+#if IS_REACHABLE(CONFIG_MTK_CMDQ)
+	if (of_address_to_resource(node, 0, &res) != 0) {
+		dev_err(dev, "Missing reg in %s node\n", node->full_name);
+		put_device(&larb_pdev->dev);
+		return -EINVAL;
+	}
+	comp->regs_pa = res.start;
+
+	ret = cmdq_dev_get_client_reg(dev, &cmdq_reg, 0);
+	if (ret)
+		dev_dbg(dev, "get mediatek,gce-client-reg fail!\n");
+	else
+		comp->subsys = cmdq_reg.subsys;
+#endif
+
 	/* Only DMA capable components need the LARB property */
 	comp->larb_dev = NULL;
 	if (type != MTK_DISP_OVL &&
@@ -531,20 +546,6 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 
 	comp->larb_dev = &larb_pdev->dev;
 
-#if IS_REACHABLE(CONFIG_MTK_CMDQ)
-	if (of_address_to_resource(node, 0, &res) != 0) {
-		dev_err(dev, "Missing reg in %s node\n", node->full_name);
-		put_device(&larb_pdev->dev);
-		return -EINVAL;
-	}
-	comp->regs_pa = res.start;
-
-	ret = cmdq_dev_get_client_reg(dev, &cmdq_reg, 0);
-	if (ret)
-		dev_dbg(dev, "get mediatek,gce-client-reg fail!\n");
-	else
-		comp->subsys = cmdq_reg.subsys;
-#endif
 	return 0;
 }
 
-- 
2.17.1

