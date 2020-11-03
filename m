Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAA82A37E3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 01:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbgKCAe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 19:34:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727432AbgKCAey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 19:34:54 -0500
Received: from DESKTOP-GFFITBK.localdomain (218-161-90-76.HINET-IP.hinet.net [218.161.90.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E26E223BD;
        Tue,  3 Nov 2020 00:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604363694;
        bh=HbuatlSyvwmzO4j/6WIksCn8cA+kxvt/2rktXwWL9uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XITDO58TpzTlrfMv5Xjieto0YEzROzUDOviHDWY0R//hnPiFleQGIvHgNYMqpP5oS
         gS6T8EjHA+Lwm3JxR7xKHEmabKliP6Ib18fHssdcPl5a9syT7ZSgd6VGoTmad6bRg8
         H9VIlVWeqr7++yBj7qEwU05tjLHuJBdQcKKhKL+I=
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 06/11] drm/mediatek: Use struct cmdq_client_reg to gather cmdq variable
Date:   Tue,  3 Nov 2020 08:34:17 +0800
Message-Id: <20201103003422.17838-7-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201103003422.17838-1-chunkuang.hu@kernel.org>
References: <20201103003422.17838-1-chunkuang.hu@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: CK Hu <ck.hu@mediatek.com>

struct cmdq_client_reg include subsys and offset, so use it to replace
these two variable.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 24 ++++++---------------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  4 ++--
 2 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 27daff9458d6..bf166b032fca 100644
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
@@ -537,8 +537,6 @@ int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
 	struct platform_device *larb_pdev;
 	struct mtk_ddp_comp_dev *priv;
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
-	struct resource res;
-	struct cmdq_client_reg cmdq_reg;
 	int ret;
 #endif
 
@@ -569,17 +567,9 @@ int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
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
 
 	if (comp_id == DDP_COMPONENT_COLOR0 ||
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

