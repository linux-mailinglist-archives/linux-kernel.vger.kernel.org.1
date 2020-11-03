Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B802A37D5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 01:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgKCAeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 19:34:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:43464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgKCAeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 19:34:44 -0500
Received: from DESKTOP-GFFITBK.localdomain (218-161-90-76.HINET-IP.hinet.net [218.161.90.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7170122275;
        Tue,  3 Nov 2020 00:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604363683;
        bh=gbZH1psqQVOfFYRVGDfdWFHWQcwRxb/FRqAHy3ZGQ1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZTTBc4Y5TGlRxb+5S6Q1/vj2Hlz7rIRnb7gHHRYaTSTEJt0h5g2YIrPEfSfZ7EDq
         QIaAgSyYiIG17bu4uIWJfdDnxw22nTfVodvBrm4ra4p83tKgRQxDTi2KFVgh9Pkckd
         62qI8QkxKkOyCwaOO9AsSeKbJ4Ou2x96rwJXxEfE=
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 01/11] drm/mediatek: Get CMDQ client register for all ddp component
Date:   Tue,  3 Nov 2020 08:34:12 +0800
Message-Id: <20201103003422.17838-2-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201103003422.17838-1-chunkuang.hu@kernel.org>
References: <20201103003422.17838-1-chunkuang.hu@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only OVL, RDMA,and WDMA get CMDQ client register information,
but all ddp component should work with CMDQ, so get this
information for all ddp component.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 28 ++++++++++-----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 8eba44be3a8a..c17c0e4c030f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -506,6 +506,20 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 	if (IS_ERR(comp->clk))
 		return PTR_ERR(comp->clk);
 
+#if IS_REACHABLE(CONFIG_MTK_CMDQ)
+	if (of_address_to_resource(node, 0, &res) != 0) {
+		dev_err(dev, "Missing reg in %s node\n", node->full_name);
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
@@ -531,20 +545,6 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 
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

