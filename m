Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5140B2E0A71
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgLVNMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:12:06 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:56699 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727369AbgLVNME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:12:04 -0500
X-UUID: 9dee40ecd3ce4f858cd5bb7347f1846e-20201222
X-UUID: 9dee40ecd3ce4f858cd5bb7347f1846e-20201222
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 729848550; Tue, 22 Dec 2020 21:10:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v6 20/22] clk: mediatek: Add MT8192 scp adsp clock support
Date:   Tue, 22 Dec 2020 21:09:45 +0800
Message-ID: <1608642587-15634-21-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1608642587-15634-1-git-send-email-weiyi.lu@mediatek.com>
References: <1608642587-15634-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8192 scp adsp clock provider

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/clk/mediatek/Kconfig               |  6 ++++
 drivers/clk/mediatek/Makefile              |  1 +
 drivers/clk/mediatek/clk-mt8192-scp_adsp.c | 50 ++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8192-scp_adsp.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index aba662f..1009e1f 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -551,6 +551,12 @@ config COMMON_CLK_MT8192_MSDC
 	help
 	  This driver supports MediaTek MT8192 msdc and msdc_top clocks.
 
+config COMMON_CLK_MT8192_SCP_ADSP
+	bool "Clock driver for MediaTek MT8192 scp_adsp"
+	depends on COMMON_CLK_MT8192
+	help
+	  This driver supports MediaTek MT8192 scp_adsp clocks.
+
 config COMMON_CLK_MT8516
 	bool "Clock driver for MediaTek MT8516"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 8e4e343..a336fe7 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -77,5 +77,6 @@ obj-$(CONFIG_COMMON_CLK_MT8192_MDPSYS) += clk-mt8192-mdp.o
 obj-$(CONFIG_COMMON_CLK_MT8192_MFGCFG) += clk-mt8192-mfg.o
 obj-$(CONFIG_COMMON_CLK_MT8192_MMSYS) += clk-mt8192-mm.o
 obj-$(CONFIG_COMMON_CLK_MT8192_MSDC) += clk-mt8192-msdc.o
+obj-$(CONFIG_COMMON_CLK_MT8192_SCP_ADSP) += clk-mt8192-scp_adsp.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8192-scp_adsp.c b/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
new file mode 100644
index 0000000..4bc2403
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
@@ -0,0 +1,50 @@
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
+static const struct mtk_gate_regs scp_adsp_cg_regs = {
+	.set_ofs = 0x180,
+	.clr_ofs = 0x180,
+	.sta_ofs = 0x180,
+};
+
+#define GATE_SCP_ADSP(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &scp_adsp_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
+
+static const struct mtk_gate scp_adsp_clks[] = {
+	GATE_SCP_ADSP(CLK_SCP_ADSP_AUDIODSP, "scp_adsp_audiodsp", "adsp_sel", 0),
+};
+
+static const struct mtk_clk_desc scp_adsp_desc = {
+	.clks = scp_adsp_clks,
+	.num_clks = ARRAY_SIZE(scp_adsp_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8192_scp_adsp[] = {
+	{
+		.compatible = "mediatek,mt8192-scp_adsp",
+		.data = &scp_adsp_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8192_scp_adsp_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8192-scp_adsp",
+		.of_match_table = of_match_clk_mt8192_scp_adsp,
+	},
+};
+
+builtin_platform_driver(clk_mt8192_scp_adsp_drv);
-- 
1.8.1.1.dirty

