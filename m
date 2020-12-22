Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DB82E0A51
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgLVNKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:10:45 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:33856 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726942AbgLVNKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:10:41 -0500
X-UUID: b65b71287c344d9d914365da072b8845-20201222
X-UUID: b65b71287c344d9d914365da072b8845-20201222
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 396414513; Tue, 22 Dec 2020 21:09:55 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Dec 2020 21:09:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Dec 2020 21:09:51 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v6 19/22] clk: mediatek: Add MT8192 msdc clock support
Date:   Tue, 22 Dec 2020 21:09:44 +0800
Message-ID: <1608642587-15634-20-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1608642587-15634-1-git-send-email-weiyi.lu@mediatek.com>
References: <1608642587-15634-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8192 msdc and msdc top clock providers

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/clk/mediatek/Kconfig           |  6 +++
 drivers/clk/mediatek/Makefile          |  1 +
 drivers/clk/mediatek/clk-mt8192-msdc.c | 85 ++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8192-msdc.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index bc92611..aba662f 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -545,6 +545,12 @@ config COMMON_CLK_MT8192_MMSYS
 	help
 	  This driver supports MediaTek MT8192 mmsys clocks.
 
+config COMMON_CLK_MT8192_MSDC
+	bool "Clock driver for MediaTek MT8192 msdc"
+	depends on COMMON_CLK_MT8192
+	help
+	  This driver supports MediaTek MT8192 msdc and msdc_top clocks.
+
 config COMMON_CLK_MT8516
 	bool "Clock driver for MediaTek MT8516"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 838bb01..8e4e343 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -76,5 +76,6 @@ obj-$(CONFIG_COMMON_CLK_MT8192_IPESYS) += clk-mt8192-ipe.o
 obj-$(CONFIG_COMMON_CLK_MT8192_MDPSYS) += clk-mt8192-mdp.o
 obj-$(CONFIG_COMMON_CLK_MT8192_MFGCFG) += clk-mt8192-mfg.o
 obj-$(CONFIG_COMMON_CLK_MT8192_MMSYS) += clk-mt8192-mm.o
+obj-$(CONFIG_COMMON_CLK_MT8192_MSDC) += clk-mt8192-msdc.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8192-msdc.c b/drivers/clk/mediatek/clk-mt8192-msdc.c
new file mode 100644
index 0000000..0fb8d01
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8192-msdc.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (c) 2020 MediaTek Inc.
+// Author: Weiyi Lu <weiyi.lu@mediatek.com>
+
+#include <linux/clk-provider.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mt8192-clk.h>
+
+static const struct mtk_gate_regs msdc_cg_regs = {
+	.set_ofs = 0xb4,
+	.clr_ofs = 0xb4,
+	.sta_ofs = 0xb4,
+};
+
+static const struct mtk_gate_regs msdc_top_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x0,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_MSDC(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &msdc_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+#define GATE_MSDC_TOP(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &msdc_top_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+static const struct mtk_gate msdc_clks[] = {
+	GATE_MSDC(CLK_MSDC_AXI_WRAP, "msdc_axi_wrap", "axi_sel", 22),
+};
+
+static const struct mtk_gate msdc_top_clks[] = {
+	GATE_MSDC_TOP(CLK_MSDC_TOP_AES_0P, "msdc_top_aes_0p", "aes_msdcfde_sel", 0),
+	GATE_MSDC_TOP(CLK_MSDC_TOP_SRC_0P, "msdc_top_src_0p", "infra_msdc0_src", 1),
+	GATE_MSDC_TOP(CLK_MSDC_TOP_SRC_1P, "msdc_top_src_1p", "infra_msdc1_src", 2),
+	GATE_MSDC_TOP(CLK_MSDC_TOP_SRC_2P, "msdc_top_src_2p", "infra_msdc2_src", 3),
+	GATE_MSDC_TOP(CLK_MSDC_TOP_P_MSDC0, "msdc_top_p_msdc0", "axi_sel", 4),
+	GATE_MSDC_TOP(CLK_MSDC_TOP_P_MSDC1, "msdc_top_p_msdc1", "axi_sel", 5),
+	GATE_MSDC_TOP(CLK_MSDC_TOP_P_MSDC2, "msdc_top_p_msdc2", "axi_sel", 6),
+	GATE_MSDC_TOP(CLK_MSDC_TOP_P_CFG, "msdc_top_p_cfg", "axi_sel", 7),
+	GATE_MSDC_TOP(CLK_MSDC_TOP_AXI, "msdc_top_axi", "axi_sel", 8),
+	GATE_MSDC_TOP(CLK_MSDC_TOP_H_MST_0P, "msdc_top_h_mst_0p", "infra_msdc0", 9),
+	GATE_MSDC_TOP(CLK_MSDC_TOP_H_MST_1P, "msdc_top_h_mst_1p", "infra_msdc1", 10),
+	GATE_MSDC_TOP(CLK_MSDC_TOP_H_MST_2P, "msdc_top_h_mst_2p", "infra_msdc2", 11),
+	GATE_MSDC_TOP(CLK_MSDC_TOP_MEM_OFF_DLY_26M, "msdc_top_mem_off_dly_26m", "clk26m", 12),
+	GATE_MSDC_TOP(CLK_MSDC_TOP_32K, "msdc_top_32k", "clk32k", 13),
+	GATE_MSDC_TOP(CLK_MSDC_TOP_AHB2AXI_BRG_AXI, "msdc_top_ahb2axi_brg_axi", "axi_sel", 14),
+};
+
+static const struct mtk_clk_desc msdc_desc = {
+	.clks = msdc_clks,
+	.num_clks = ARRAY_SIZE(msdc_clks),
+};
+
+static const struct mtk_clk_desc msdc_top_desc = {
+	.clks = msdc_top_clks,
+	.num_clks = ARRAY_SIZE(msdc_top_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8192_msdc[] = {
+	{
+		.compatible = "mediatek,mt8192-msdc",
+		.data = &msdc_desc,
+	}, {
+		.compatible = "mediatek,mt8192-msdc_top",
+		.data = &msdc_top_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8192_msdc_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8192-msdc",
+		.of_match_table = of_match_clk_mt8192_msdc,
+	},
+};
+
+builtin_platform_driver(clk_mt8192_msdc_drv);
-- 
1.8.1.1.dirty

