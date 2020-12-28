Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415182E3524
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 09:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgL1IiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 03:38:18 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:57804 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726282AbgL1IiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 03:38:17 -0500
X-UUID: b99e196d8dec4e1b8f7de2b2a85ae4be-20201228
X-UUID: b99e196d8dec4e1b8f7de2b2a85ae4be-20201228
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 524252414; Mon, 28 Dec 2020 16:37:17 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 28 Dec 2020 16:38:25 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 28 Dec 2020 16:38:23 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v3, 3/8] soc: mediatek: mmsys: add mt8183 function call for setting the routing registers
Date:   Mon, 28 Dec 2020 16:37:05 +0800
Message-ID: <1609144630-14721-4-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1609144630-14721-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1609144630-14721-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add mt8183 function call for setting the routing registers

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/soc/mediatek/mmsys/Makefile       |  1 +
 drivers/soc/mediatek/mmsys/mt8183-mmsys.c | 90 +++++++++++++++++++++++++++++++
 drivers/soc/mediatek/mmsys/mtk-mmsys.c    |  1 +
 include/linux/soc/mediatek/mtk-mmsys.h    |  1 +
 4 files changed, 93 insertions(+)
 create mode 100644 drivers/soc/mediatek/mmsys/mt8183-mmsys.c

diff --git a/drivers/soc/mediatek/mmsys/Makefile b/drivers/soc/mediatek/mmsys/Makefile
index ac03025..25eeb9e5 100644
--- a/drivers/soc/mediatek/mmsys/Makefile
+++ b/drivers/soc/mediatek/mmsys/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_MTK_MMSYS) += mt2701-mmsys.o
+obj-$(CONFIG_MTK_MMSYS) += mt8183-mmsys.o
 obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
diff --git a/drivers/soc/mediatek/mmsys/mt8183-mmsys.c b/drivers/soc/mediatek/mmsys/mt8183-mmsys.c
new file mode 100644
index 0000000..192b4ab
--- /dev/null
+++ b/drivers/soc/mediatek/mmsys/mt8183-mmsys.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2020 MediaTek Inc.
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/soc/mediatek/mtk-mmsys.h>
+
+#define DISP_OVL0_MOUT_EN		0xf00
+#define DISP_OVL0_2L_MOUT_EN		0xf04
+#define DISP_OVL1_2L_MOUT_EN		0xf08
+#define DISP_DITHER0_MOUT_EN		0xf0c
+#define DISP_PATH0_SEL_IN		0xf24
+#define DISP_DSI0_SEL_IN		0xf2c
+#define DISP_DPI0_SEL_IN		0xf30
+#define DISP_RDMA0_SOUT_SEL_IN		0xf50
+#define DISP_RDMA1_SOUT_SEL_IN		0xf54
+
+#define OVL0_MOUT_EN_OVL0_2L			BIT(4)
+#define OVL0_2L_MOUT_EN_DISP_PATH0		BIT(0)
+#define OVL1_2L_MOUT_EN_RDMA1			BIT(4)
+#define DITHER0_MOUT_IN_DSI0			BIT(0)
+#define DISP_PATH0_SEL_IN_OVL0_2L		0x1
+#define DSI0_SEL_IN_RDMA0			0x1
+#define DSI0_SEL_IN_RDMA1			0x3
+#define DPI0_SEL_IN_RDMA0			0x1
+#define DPI0_SEL_IN_RDMA1			0x2
+#define RDMA0_SOUT_COLOR0			0x1
+#define RDMA1_SOUT_DSI0				0x1
+
+static unsigned int mtk_mmsys_ddp_mout_en(enum mtk_ddp_comp_id cur,
+					  enum mtk_ddp_comp_id next,
+					  unsigned int *addr)
+{
+	unsigned int value;
+
+	if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_OVL_2L0) {
+		*addr = DISP_OVL0_MOUT_EN;
+		value = OVL0_MOUT_EN_OVL0_2L;
+	} else if (cur == DDP_COMPONENT_OVL_2L0 && next == DDP_COMPONENT_RDMA0) {
+		*addr = DISP_OVL0_2L_MOUT_EN;
+		value = OVL0_2L_MOUT_EN_DISP_PATH0;
+	} else if (cur == DDP_COMPONENT_OVL_2L1 && next == DDP_COMPONENT_RDMA1) {
+		*addr = DISP_OVL1_2L_MOUT_EN;
+		value = OVL1_2L_MOUT_EN_RDMA1;
+	} else if (cur == DDP_COMPONENT_DITHER && next == DDP_COMPONENT_DSI0) {
+		*addr = DISP_DITHER0_MOUT_EN;
+		value = DITHER0_MOUT_IN_DSI0;
+	} else {
+		value = 0;
+	}
+
+	return value;
+}
+
+static unsigned int mtk_mmsys_ddp_sel_in(enum mtk_ddp_comp_id cur,
+					 enum mtk_ddp_comp_id next,
+					 unsigned int *addr)
+{
+	unsigned int value;
+
+	if (cur == DDP_COMPONENT_OVL_2L0 && next == DDP_COMPONENT_RDMA0) {
+		*addr = DISP_PATH0_SEL_IN;
+		value = DISP_PATH0_SEL_IN_OVL0_2L;
+	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
+		*addr = DISP_DPI0_SEL_IN;
+		value = DPI0_SEL_IN_RDMA1;
+	} else {
+		value = 0;
+	}
+
+	return value;
+}
+
+static void mtk_mmsys_ddp_sout_sel(void __iomem *config_regs,
+				   enum mtk_ddp_comp_id cur,
+				   enum mtk_ddp_comp_id next)
+{
+	if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_COLOR0) {
+		writel_relaxed(RDMA0_SOUT_COLOR0, config_regs + DISP_RDMA0_SOUT_SEL_IN);
+	}
+}
+
+struct mtk_mmsys_conn_funcs mt8183_mmsys_funcs = {
+	.mout_en = mtk_mmsys_ddp_mout_en,
+	.sel_in = mtk_mmsys_ddp_sel_in,
+	.sout_sel = mtk_mmsys_ddp_sout_sel,
+};
diff --git a/drivers/soc/mediatek/mmsys/mtk-mmsys.c b/drivers/soc/mediatek/mmsys/mtk-mmsys.c
index c35bda1..dae665b 100644
--- a/drivers/soc/mediatek/mmsys/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mmsys/mtk-mmsys.c
@@ -42,6 +42,7 @@ struct mtk_mmsys_driver_data {
 
 static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
 	.clk_driver = "clk-mt8183-mm",
+	.funcs = &mt8183_mmsys_funcs,
 };
 
 struct mtk_mmsys {
diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
index 17e8b91..4b6c514 100644
--- a/include/linux/soc/mediatek/mtk-mmsys.h
+++ b/include/linux/soc/mediatek/mtk-mmsys.h
@@ -55,6 +55,7 @@ struct mtk_mmsys_conn_funcs {
 };
 
 extern struct mtk_mmsys_conn_funcs mt2701_mmsys_funcs;
+extern struct mtk_mmsys_conn_funcs mt8183_mmsys_funcs;
 
 void mtk_mmsys_ddp_connect(struct device *dev,
 			   enum mtk_ddp_comp_id cur,
-- 
1.8.1.1.dirty

