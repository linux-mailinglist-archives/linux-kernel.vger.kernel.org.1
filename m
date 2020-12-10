Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B5C2D616A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388064AbgLJQOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:14:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:39596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391234AbgLJQMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:12:24 -0500
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH v2 07/12] drm/mediatek: Use struct cmdq_client_reg to gather cmdq variable
Date:   Fri, 11 Dec 2020 00:10:45 +0800
Message-Id: <20201210161050.8460-8-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201210161050.8460-1-chunkuang.hu@kernel.org>
References: <20201210161050.8460-1-chunkuang.hu@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: CK Hu <ck.hu@mediatek.com>

struct cmdq_client_reg include subsys and offset, so use it to replace
these two variable.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 26 ++++++---------------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  4 ++--
 2 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 775bc37c4045..14371d5863ae 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -96,8 +96,8 @@ void mtk_ddp_write(struct cmdq_pkt *cmdq_pkt, unsigned int value,
 {
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	if (cmdq_pkt)
-		cmdq_pkt_write(cmdq_pkt, comp->subsys,
-			       comp->regs_pa + offset, value);
+		cmdq_pkt_write(cmdq_pkt, comp->cmdq_reg.subsys,
+			       comp->cmdq_reg.offset + offset, value);
 	else
 #endif
 		writel(value, regs + offset);
@@ -109,8 +109,8 @@ void mtk_ddp_write_relaxed(struct cmdq_pkt *cmdq_pkt, unsigned int value,
 {
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	if (cmdq_pkt)
-		cmdq_pkt_write(cmdq_pkt, comp->subsys,
-			       comp->regs_pa + offset, value);
+		cmdq_pkt_write(cmdq_pkt, comp->cmdq_reg.subsys,
+			       comp->cmdq_reg.offset + offset, value);
 	else
 #endif
 		writel_relaxed(value, regs + offset);
@@ -122,8 +122,8 @@ void mtk_ddp_write_mask(struct cmdq_pkt *cmdq_pkt, unsigned int value,
 {
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	if (cmdq_pkt) {
-		cmdq_pkt_write_mask(cmdq_pkt, comp->subsys,
-				    comp->regs_pa + offset, value, mask);
+		cmdq_pkt_write_mask(cmdq_pkt, comp->cmdq_reg.subsys,
+				    comp->cmdq_reg.offset + offset, value, mask);
 	} else {
 #endif
 		u32 tmp = readl(regs + offset);
@@ -558,10 +558,6 @@ int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
 	struct platform_device *comp_pdev;
 	enum mtk_ddp_comp_type type;
 	struct mtk_ddp_comp_dev *priv;
-#if IS_REACHABLE(CONFIG_MTK_CMDQ)
-	struct resource res;
-	struct cmdq_client_reg cmdq_reg;
-#endif
 	int ret;
 
 	if (comp_id < 0 || comp_id >= DDP_COMPONENT_ID_MAX)
@@ -591,17 +587,9 @@ int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
 	comp->dev = &comp_pdev->dev;
 
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
-	if (of_address_to_resource(node, 0, &res) != 0) {
-		dev_err(comp->dev, "Missing reg in %s node\n", node->full_name);
-		return -EINVAL;
-	}
-	comp->regs_pa = res.start;
-
-	ret = cmdq_dev_get_client_reg(comp->dev, &cmdq_reg, 0);
+	ret = cmdq_dev_get_client_reg(comp->dev, &comp->cmdq_reg, 0);
 	if (ret)
 		dev_dbg(comp->dev, "get mediatek,gce-client-reg fail!\n");
-	else
-		comp->subsys = cmdq_reg.subsys;
 #endif
 
 	/* Only DMA capable components need the LARB property */
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index e18299573d2b..621b07ef807e 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -7,6 +7,7 @@
 #define MTK_DRM_DDP_COMP_H
 
 #include <linux/io.h>
+#include <linux/soc/mediatek/mtk-cmdq.h>
 
 struct device;
 struct device_node;
@@ -102,8 +103,7 @@ struct mtk_ddp_comp {
 	struct device *larb_dev;
 	enum mtk_ddp_comp_id id;
 	const struct mtk_ddp_comp_funcs *funcs;
-	resource_size_t regs_pa;
-	u8 subsys;
+	struct cmdq_client_reg cmdq_reg;
 };
 
 static inline int mtk_ddp_comp_clk_enable(struct mtk_ddp_comp *comp)
-- 
2.17.1

