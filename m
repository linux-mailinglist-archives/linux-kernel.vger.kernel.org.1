Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7A7294CEB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442522AbgJUMk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:40:57 -0400
Received: from inva020.nxp.com ([92.121.34.13]:46510 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440455AbgJUMk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:40:56 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 77F491A0C22;
        Wed, 21 Oct 2020 14:40:54 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6AF851A0C2B;
        Wed, 21 Oct 2020 14:40:54 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 9B9A2203A1;
        Wed, 21 Oct 2020 14:40:53 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 1/2] clk: imx: composite-8m: Add DRAM clock registration variant
Date:   Wed, 21 Oct 2020 15:40:42 +0300
Message-Id: <1603284043-27059-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603284043-27059-1-git-send-email-abel.vesa@nxp.com>
References: <1603284043-27059-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The switch between parents for dram_apb and dram_alt is done in EL3,
so lets mark the mux and divider as read only with the CLK_DIVIDER_READ_ONLY
and CLK_MUX_READ_ONLY flags.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-composite-8m.c | 7 +++++++
 drivers/clk/imx/clk.h              | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 2c309e3..c3231eb 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -211,6 +211,13 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 		div->width = PCG_PREDIV_WIDTH;
 		divider_ops = &imx8m_clk_composite_divider_ops;
 		mux_ops = &imx8m_clk_composite_mux_ops;
+	} else if (composite_flags & IMX_COMPOSITE_DRAM) {
+		div->shift = PCG_PREDIV_SHIFT;
+		div->width = PCG_PREDIV_WIDTH;
+		div->flags = CLK_DIVIDER_READ_ONLY;
+		mux->flags = CLK_MUX_READ_ONLY;
+		divider_ops = &clk_divider_ops;
+		mux_ops = &clk_mux_ops;
 	} else {
 		div->shift = PCG_PREDIV_SHIFT;
 		div->width = PCG_PREDIV_WIDTH;
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 3b796b3..70c57d2 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -535,6 +535,7 @@ struct clk_hw *imx_clk_hw_cpu(const char *name, const char *parent_name,
 
 #define IMX_COMPOSITE_CORE	BIT(0)
 #define IMX_COMPOSITE_BUS	BIT(1)
+#define IMX_COMPOSITE_DRAM	BIT(2)
 
 struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 					    const char * const *parent_names,
@@ -565,6 +566,11 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 		ARRAY_SIZE(parent_names), reg, 0, \
 		flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
 
+#define __imx8m_clk_hw_composite_dram(name, parent_names, reg, flags) \
+	imx8m_clk_hw_composite_flags(name, parent_names, \
+		ARRAY_SIZE(parent_names), reg, IMX_COMPOSITE_DRAM, \
+		flags | CLK_GET_RATE_NOCACHE | CLK_OPS_PARENT_ENABLE)
+
 #define __imx8m_clk_composite(name, parent_names, reg, flags) \
 	to_clk(__imx8m_clk_hw_composite(name, parent_names, reg, flags))
 
-- 
2.7.4

