Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABE8285282
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 21:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgJFTdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 15:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgJFTdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 15:33:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6B0C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 12:33:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 8D4FE29BD82
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        yongqiang.niu@mediatek.com, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        chunkuang.hu@kernel.org, CK Hu <ck.hu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 4/4] soc: mediatek: mmsys: Use an array for setting the routing registers
Date:   Tue,  6 Oct 2020 21:33:20 +0200
Message-Id: <20201006193320.405529-5-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006193320.405529-1-enric.balletbo@collabora.com>
References: <20201006193320.405529-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: CK Hu <ck.hu@mediatek.com>

Actually, setting the registers for routing, use multiple 'if-else' for different
routes, but this code would be more and more complicated while we
support more and more SoCs. Change that and use a table per SoC so the
code will be more portable and clear.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/soc/mediatek/mtk-mmsys.c | 393 +++++++++++++++++--------------
 1 file changed, 210 insertions(+), 183 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index da2de8f6969e..f00d6d08c9c5 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -42,39 +42,61 @@
 #define RDMA0_SOUT_DSI1				0x1
 #define RDMA0_SOUT_DSI2				0x4
 #define RDMA0_SOUT_DSI3				0x5
+#define RDMA0_SOUT_MASK				0x7
 #define RDMA1_SOUT_DPI0				0x2
 #define RDMA1_SOUT_DPI1				0x3
 #define RDMA1_SOUT_DSI1				0x1
 #define RDMA1_SOUT_DSI2				0x4
 #define RDMA1_SOUT_DSI3				0x5
+#define RDMA1_SOUT_MASK				0x7
 #define RDMA2_SOUT_DPI0				0x2
 #define RDMA2_SOUT_DPI1				0x3
 #define RDMA2_SOUT_DSI1				0x1
 #define RDMA2_SOUT_DSI2				0x4
 #define RDMA2_SOUT_DSI3				0x5
+#define RDMA2_SOUT_MASK				0x7
 #define DPI0_SEL_IN_RDMA1			0x1
 #define DPI0_SEL_IN_RDMA2			0x3
+#define DPI0_SEL_IN_MASK			0x3
 #define DPI1_SEL_IN_RDMA1			(0x1 << 8)
 #define DPI1_SEL_IN_RDMA2			(0x3 << 8)
+#define DPI1_SEL_IN_MASK			(0x3 << 8)
 #define DSI0_SEL_IN_RDMA1			0x1
 #define DSI0_SEL_IN_RDMA2			0x4
+#define DSI0_SEL_IN_MASK			0x7
 #define DSI1_SEL_IN_RDMA1			0x1
 #define DSI1_SEL_IN_RDMA2			0x4
+#define DSI1_SEL_IN_MASK			0x7
 #define DSI2_SEL_IN_RDMA1			(0x1 << 16)
 #define DSI2_SEL_IN_RDMA2			(0x4 << 16)
+#define DSI2_SEL_IN_MASK			(0x7 << 16)
 #define DSI3_SEL_IN_RDMA1			(0x1 << 16)
 #define DSI3_SEL_IN_RDMA2			(0x4 << 16)
+#define DSI3_SEL_IN_MASK			(0x7 << 16)
 #define COLOR1_SEL_IN_OVL1			0x1
 
 #define OVL_MOUT_EN_RDMA			0x1
 #define BLS_TO_DSI_RDMA1_TO_DPI1		0x8
 #define BLS_TO_DPI_RDMA1_TO_DSI			0x2
+#define BLS_RDMA1_DSI_DPI_MASK			0xf
 #define DSI_SEL_IN_BLS				0x0
 #define DPI_SEL_IN_BLS				0x0
+#define DPI_SEL_IN_MASK				0x1
 #define DSI_SEL_IN_RDMA				0x1
+#define DSI_SEL_IN_MASK				0x1
+
+struct mtk_mmsys_routes {
+	u32 from_comp;
+	u32 to_comp;
+	u32 addr;
+	u32 mask;
+	u32 val;
+};
 
 struct mtk_mmsys_driver_data {
 	const char *clk_driver;
+	const struct mtk_mmsys_routes *routes;
+	const unsigned int num_routes;
 };
 
 static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
@@ -93,10 +115,6 @@ static const struct mtk_mmsys_driver_data mt6797_mmsys_driver_data = {
 	.clk_driver = "clk-mt6797-mm",
 };
 
-static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
-	.clk_driver = "clk-mt8173-mm",
-};
-
 static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
 	.clk_driver = "clk-mt8183-mm",
 };
@@ -106,180 +124,192 @@ struct mtk_mmsys {
 	const struct mtk_mmsys_driver_data *data;
 };
 
-static unsigned int mtk_mmsys_ddp_mout_en(enum mtk_ddp_comp_id cur,
-					  enum mtk_ddp_comp_id next,
-					  unsigned int *addr)
-{
-	unsigned int value;
-
-	if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_COLOR0) {
-		*addr = DISP_REG_CONFIG_DISP_OVL0_MOUT_EN;
-		value = OVL0_MOUT_EN_COLOR0;
-	} else if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_RDMA0) {
-		*addr = DISP_REG_CONFIG_DISP_OVL_MOUT_EN;
-		value = OVL_MOUT_EN_RDMA;
-	} else if (cur == DDP_COMPONENT_OD0 && next == DDP_COMPONENT_RDMA0) {
-		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
-		value = OD_MOUT_EN_RDMA0;
-	} else if (cur == DDP_COMPONENT_UFOE && next == DDP_COMPONENT_DSI0) {
-		*addr = DISP_REG_CONFIG_DISP_UFOE_MOUT_EN;
-		value = UFOE_MOUT_EN_DSI0;
-	} else if (cur == DDP_COMPONENT_OVL1 && next == DDP_COMPONENT_COLOR1) {
-		*addr = DISP_REG_CONFIG_DISP_OVL1_MOUT_EN;
-		value = OVL1_MOUT_EN_COLOR1;
-	} else if (cur == DDP_COMPONENT_GAMMA && next == DDP_COMPONENT_RDMA1) {
-		*addr = DISP_REG_CONFIG_DISP_GAMMA_MOUT_EN;
-		value = GAMMA_MOUT_EN_RDMA1;
-	} else if (cur == DDP_COMPONENT_OD1 && next == DDP_COMPONENT_RDMA1) {
-		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
-		value = OD1_MOUT_EN_RDMA1;
-	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DPI0) {
-		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
-		value = RDMA0_SOUT_DPI0;
-	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DPI1) {
-		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
-		value = RDMA0_SOUT_DPI1;
-	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI1) {
-		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
-		value = RDMA0_SOUT_DSI1;
-	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI2) {
-		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
-		value = RDMA0_SOUT_DSI2;
-	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI3) {
-		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
-		value = RDMA0_SOUT_DSI3;
-	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI1) {
-		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
-		value = RDMA1_SOUT_DSI1;
-	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI2) {
-		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
-		value = RDMA1_SOUT_DSI2;
-	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI3) {
-		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
-		value = RDMA1_SOUT_DSI3;
-	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
-		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
-		value = RDMA1_SOUT_DPI0;
-	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI1) {
-		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
-		value = RDMA1_SOUT_DPI1;
-	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI0) {
-		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
-		value = RDMA2_SOUT_DPI0;
-	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI1) {
-		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
-		value = RDMA2_SOUT_DPI1;
-	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI1) {
-		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
-		value = RDMA2_SOUT_DSI1;
-	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI2) {
-		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
-		value = RDMA2_SOUT_DSI2;
-	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI3) {
-		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
-		value = RDMA2_SOUT_DSI3;
-	} else {
-		value = 0;
-	}
-
-	return value;
-}
-
-static unsigned int mtk_mmsys_ddp_sel_in(enum mtk_ddp_comp_id cur,
-					 enum mtk_ddp_comp_id next,
-					 unsigned int *addr)
-{
-	unsigned int value;
-
-	if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_COLOR0) {
-		*addr = DISP_REG_CONFIG_DISP_COLOR0_SEL_IN;
-		value = COLOR0_SEL_IN_OVL0;
-	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
-		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
-		value = DPI0_SEL_IN_RDMA1;
-	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI1) {
-		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
-		value = DPI1_SEL_IN_RDMA1;
-	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI0) {
-		*addr = DISP_REG_CONFIG_DSIE_SEL_IN;
-		value = DSI0_SEL_IN_RDMA1;
-	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI1) {
-		*addr = DISP_REG_CONFIG_DSIO_SEL_IN;
-		value = DSI1_SEL_IN_RDMA1;
-	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI2) {
-		*addr = DISP_REG_CONFIG_DSIE_SEL_IN;
-		value = DSI2_SEL_IN_RDMA1;
-	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI3) {
-		*addr = DISP_REG_CONFIG_DSIO_SEL_IN;
-		value = DSI3_SEL_IN_RDMA1;
-	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI0) {
-		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
-		value = DPI0_SEL_IN_RDMA2;
-	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI1) {
-		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
-		value = DPI1_SEL_IN_RDMA2;
-	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI0) {
-		*addr = DISP_REG_CONFIG_DSIE_SEL_IN;
-		value = DSI0_SEL_IN_RDMA2;
-	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI1) {
-		*addr = DISP_REG_CONFIG_DSIO_SEL_IN;
-		value = DSI1_SEL_IN_RDMA2;
-	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI2) {
-		*addr = DISP_REG_CONFIG_DSIE_SEL_IN;
-		value = DSI2_SEL_IN_RDMA2;
-	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI3) {
-		*addr = DISP_REG_CONFIG_DSIE_SEL_IN;
-		value = DSI3_SEL_IN_RDMA2;
-	} else if (cur == DDP_COMPONENT_OVL1 && next == DDP_COMPONENT_COLOR1) {
-		*addr = DISP_REG_CONFIG_DISP_COLOR1_SEL_IN;
-		value = COLOR1_SEL_IN_OVL1;
-	} else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
-		*addr = DISP_REG_CONFIG_DSI_SEL;
-		value = DSI_SEL_IN_BLS;
-	} else {
-		value = 0;
+static const struct mtk_mmsys_routes mt8173_mmsys_routing_table[] = {
+	{
+		DDP_COMPONENT_BLS, DDP_COMPONENT_DSI0,
+		DISP_REG_CONFIG_OUT_SEL,
+		BLS_RDMA1_DSI_DPI_MASK, BLS_TO_DSI_RDMA1_TO_DPI1
+	}, {
+		DDP_COMPONENT_BLS, DDP_COMPONENT_DSI0,
+		DISP_REG_CONFIG_DSI_SEL,
+		DSI_SEL_IN_MASK, DSI_SEL_IN_BLS
+	}, {
+		DDP_COMPONENT_BLS, DDP_COMPONENT_DPI0,
+		DISP_REG_CONFIG_OUT_SEL,
+		BLS_RDMA1_DSI_DPI_MASK, BLS_TO_DPI_RDMA1_TO_DSI
+	}, {
+		DDP_COMPONENT_BLS, DDP_COMPONENT_DPI0,
+		DISP_REG_CONFIG_DSI_SEL,
+		DSI_SEL_IN_MASK, DSI_SEL_IN_RDMA
+	}, {
+		DDP_COMPONENT_BLS, DDP_COMPONENT_DPI0,
+		DISP_REG_CONFIG_DPI_SEL,
+		DPI_SEL_IN_MASK, DPI_SEL_IN_BLS
+	}, {
+		DDP_COMPONENT_GAMMA, DDP_COMPONENT_RDMA1,
+		DISP_REG_CONFIG_DISP_GAMMA_MOUT_EN,
+		GAMMA_MOUT_EN_RDMA1, GAMMA_MOUT_EN_RDMA1
+	}, {
+		DDP_COMPONENT_OD0, DDP_COMPONENT_RDMA0,
+		DISP_REG_CONFIG_DISP_OD_MOUT_EN,
+		OD_MOUT_EN_RDMA0, OD_MOUT_EN_RDMA0
+	}, {
+		DDP_COMPONENT_OD1, DDP_COMPONENT_RDMA1,
+		DISP_REG_CONFIG_DISP_OD_MOUT_EN,
+		OD1_MOUT_EN_RDMA1, OD1_MOUT_EN_RDMA1
+	}, {
+		DDP_COMPONENT_OVL0, DDP_COMPONENT_COLOR0,
+		DISP_REG_CONFIG_DISP_OVL0_MOUT_EN,
+		OVL0_MOUT_EN_COLOR0, OVL0_MOUT_EN_COLOR0
+	}, {
+		DDP_COMPONENT_OVL0, DDP_COMPONENT_COLOR0,
+		DISP_REG_CONFIG_DISP_COLOR0_SEL_IN,
+		COLOR0_SEL_IN_OVL0, COLOR0_SEL_IN_OVL0
+	}, {
+		DDP_COMPONENT_OVL0, DDP_COMPONENT_RDMA0,
+		DISP_REG_CONFIG_DISP_OVL_MOUT_EN,
+		OVL_MOUT_EN_RDMA, OVL_MOUT_EN_RDMA
+	}, {
+		DDP_COMPONENT_OVL1, DDP_COMPONENT_COLOR1,
+		DISP_REG_CONFIG_DISP_OVL1_MOUT_EN,
+		OVL1_MOUT_EN_COLOR1, OVL1_MOUT_EN_COLOR1
+	}, {
+		DDP_COMPONENT_OVL1, DDP_COMPONENT_COLOR1,
+		DISP_REG_CONFIG_DISP_COLOR1_SEL_IN,
+		COLOR1_SEL_IN_OVL1, COLOR1_SEL_IN_OVL1
+	}, {
+		DDP_COMPONENT_RDMA0, DDP_COMPONENT_DPI0,
+		DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN,
+		RDMA0_SOUT_MASK, RDMA0_SOUT_DPI0
+	}, {
+		DDP_COMPONENT_RDMA0, DDP_COMPONENT_DPI1,
+		DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN,
+		RDMA0_SOUT_MASK, RDMA0_SOUT_DPI1
+	}, {
+		DDP_COMPONENT_RDMA0, DDP_COMPONENT_DSI1,
+		DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN,
+		RDMA0_SOUT_MASK, RDMA0_SOUT_DSI1
+	}, {
+		DDP_COMPONENT_RDMA0, DDP_COMPONENT_DSI2,
+		DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN,
+		RDMA0_SOUT_MASK, RDMA0_SOUT_DSI2
+	}, {
+		DDP_COMPONENT_RDMA0, DDP_COMPONENT_DSI3,
+		DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN,
+		RDMA0_SOUT_MASK, RDMA0_SOUT_DSI3
+	}, {
+		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DPI0,
+		DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN,
+		RDMA1_SOUT_MASK, RDMA1_SOUT_DPI0
+	}, {
+		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DPI0,
+		DISP_REG_CONFIG_DPI_SEL_IN,
+		DPI0_SEL_IN_MASK, DPI0_SEL_IN_RDMA1
+	}, {
+		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DPI1,
+		DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN,
+		RDMA1_SOUT_MASK, RDMA1_SOUT_DPI1
+	}, {
+		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DPI1,
+		DISP_REG_CONFIG_DPI_SEL_IN,
+		DPI1_SEL_IN_MASK, DPI1_SEL_IN_RDMA1
+	}, {
+		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DSI0,
+		DISP_REG_CONFIG_DSIE_SEL_IN,
+		DSI0_SEL_IN_MASK, DSI0_SEL_IN_RDMA1
+	}, {
+		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DSI1,
+		DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN,
+		RDMA1_SOUT_MASK, RDMA1_SOUT_DSI1
+	}, {
+		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DSI1,
+		DISP_REG_CONFIG_DSIO_SEL_IN,
+		DSI1_SEL_IN_MASK, DSI1_SEL_IN_RDMA1
+	}, {
+		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DSI2,
+		DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN,
+		RDMA1_SOUT_MASK, RDMA1_SOUT_DSI2
+	}, {
+		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DSI2,
+		DISP_REG_CONFIG_DSIE_SEL_IN,
+		DSI2_SEL_IN_MASK, DSI2_SEL_IN_RDMA1
+	}, {
+		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DSI3,
+		DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN,
+		RDMA1_SOUT_MASK, RDMA1_SOUT_DSI3
+	}, {
+		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DSI3,
+		DISP_REG_CONFIG_DSIO_SEL_IN,
+		DSI3_SEL_IN_MASK, DSI3_SEL_IN_RDMA1
+	}, {
+		DDP_COMPONENT_RDMA2, DDP_COMPONENT_DPI0,
+		DISP_REG_CONFIG_DISP_RDMA2_SOUT,
+		RDMA2_SOUT_MASK, RDMA2_SOUT_DPI0
+	}, {
+		DDP_COMPONENT_RDMA2, DDP_COMPONENT_DPI0,
+		DISP_REG_CONFIG_DPI_SEL_IN,
+		DPI0_SEL_IN_MASK, DPI0_SEL_IN_RDMA2
+	}, {
+		DDP_COMPONENT_RDMA2, DDP_COMPONENT_DPI1,
+		DISP_REG_CONFIG_DISP_RDMA2_SOUT,
+		RDMA2_SOUT_MASK, RDMA2_SOUT_DPI1
+	}, {
+		DDP_COMPONENT_RDMA2, DDP_COMPONENT_DPI1,
+		DISP_REG_CONFIG_DPI_SEL_IN,
+		DPI1_SEL_IN_MASK, DPI1_SEL_IN_RDMA2
+	}, {
+		DDP_COMPONENT_RDMA2, DDP_COMPONENT_DSI0,
+		DISP_REG_CONFIG_DSIE_SEL_IN,
+		DSI0_SEL_IN_MASK, DSI0_SEL_IN_RDMA2
+	}, {
+		DDP_COMPONENT_RDMA2, DDP_COMPONENT_DSI1,
+		DISP_REG_CONFIG_DISP_RDMA2_SOUT,
+		RDMA2_SOUT_MASK, RDMA2_SOUT_DSI1
+	}, {
+		DDP_COMPONENT_RDMA2, DDP_COMPONENT_DSI1,
+		DISP_REG_CONFIG_DSIO_SEL_IN,
+		DSI1_SEL_IN_MASK, DSI1_SEL_IN_RDMA2
+	}, {
+		DDP_COMPONENT_RDMA2, DDP_COMPONENT_DSI2,
+		DISP_REG_CONFIG_DISP_RDMA2_SOUT,
+		RDMA2_SOUT_MASK, RDMA2_SOUT_DSI2
+	}, {
+		DDP_COMPONENT_RDMA2, DDP_COMPONENT_DSI2,
+		DISP_REG_CONFIG_DSIE_SEL_IN,
+		DSI2_SEL_IN_MASK, DSI2_SEL_IN_RDMA2
+	}, {
+		DDP_COMPONENT_RDMA2, DDP_COMPONENT_DSI3,
+		DISP_REG_CONFIG_DISP_RDMA2_SOUT,
+		RDMA2_SOUT_MASK, RDMA2_SOUT_DSI3
+	}, {
+		DDP_COMPONENT_RDMA2, DDP_COMPONENT_DSI3,
+		DISP_REG_CONFIG_DSIO_SEL_IN,
+		DSI3_SEL_IN_MASK, DSI3_SEL_IN_RDMA2
 	}
+};
 
-	return value;
-}
-
-static void mtk_mmsys_ddp_sout_sel(void __iomem *config_regs,
-				   enum mtk_ddp_comp_id cur,
-				   enum mtk_ddp_comp_id next)
-{
-	if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
-		writel_relaxed(BLS_TO_DSI_RDMA1_TO_DPI1,
-			       config_regs + DISP_REG_CONFIG_OUT_SEL);
-	} else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DPI0) {
-		writel_relaxed(BLS_TO_DPI_RDMA1_TO_DSI,
-			       config_regs + DISP_REG_CONFIG_OUT_SEL);
-		writel_relaxed(DSI_SEL_IN_RDMA,
-			       config_regs + DISP_REG_CONFIG_DSI_SEL);
-		writel_relaxed(DPI_SEL_IN_BLS,
-			       config_regs + DISP_REG_CONFIG_DPI_SEL);
-	}
-}
+static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
+	.clk_driver = "clk-mt8173-mm",
+	.routes = mt8173_mmsys_routing_table,
+	.num_routes = ARRAY_SIZE(mt8173_mmsys_routing_table),
+};
 
 void mtk_mmsys_ddp_connect(struct device *dev,
 			   enum mtk_ddp_comp_id cur,
 			   enum mtk_ddp_comp_id next)
 {
 	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
-	unsigned int addr, value, reg;
-
-	value = mtk_mmsys_ddp_mout_en(cur, next, &addr);
-	if (value) {
-		reg = readl_relaxed(mmsys->regs + addr) | value;
-		writel_relaxed(reg, mmsys->regs + addr);
-	}
-
-	mtk_mmsys_ddp_sout_sel(mmsys->regs, cur, next);
-
-	value = mtk_mmsys_ddp_sel_in(cur, next, &addr);
-	if (value) {
-		reg = readl_relaxed(mmsys->regs + addr) | value;
-		writel_relaxed(reg, mmsys->regs + addr);
-	}
+	const struct mtk_mmsys_routes *routes = mmsys->data->routes;
+	u32 reg;
+	int i;
+
+	for (i = 0; i < mmsys->data->num_routes; i++)
+		if (cur == routes[i].from_comp && next == routes[i].to_comp) {
+			reg = readl(mmsys->regs + routes[i].addr);
+			reg &= ~routes[i].mask;
+			reg |= routes[i].val;
+			writel(reg, mmsys->regs + routes[i].addr);
+		}
 }
 EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_connect);
 
@@ -288,19 +318,16 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
 			      enum mtk_ddp_comp_id next)
 {
 	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
-	unsigned int addr, value, reg;
-
-	value = mtk_mmsys_ddp_mout_en(cur, next, &addr);
-	if (value) {
-		reg = readl_relaxed(mmsys->regs + addr) & ~value;
-		writel_relaxed(reg, mmsys->regs + addr);
-	}
-
-	value = mtk_mmsys_ddp_sel_in(cur, next, &addr);
-	if (value) {
-		reg = readl_relaxed(mmsys->regs + addr) & ~value;
-		writel_relaxed(reg, mmsys->regs + addr);
-	}
+	const struct mtk_mmsys_routes *routes = mmsys->data->routes;
+	u32 reg;
+	int i;
+
+	for (i = 0; i < mmsys->data->num_routes; i++)
+		if (cur == routes[i].from_comp && next == routes[i].to_comp) {
+			reg = readl(mmsys->regs + routes[i].addr);
+			reg &= ~routes[i].mask;
+			writel(reg, mmsys->regs + routes[i].addr);
+		}
 }
 EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
 
-- 
2.28.0

