Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A53F29970B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1793334AbgJZTdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:33:54 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60760 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1793143AbgJZTc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:32:58 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B4B4120089E;
        Mon, 26 Oct 2020 20:32:56 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A713D2003AE;
        Mon, 26 Oct 2020 20:32:56 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E53DA20308;
        Mon, 26 Oct 2020 20:32:55 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v4 04/14] dt-bindings: clock: imx8mp: Add media blk_ctl clock IDs
Date:   Mon, 26 Oct 2020 21:32:20 +0200
Message-Id: <1603740750-10385-5-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603740750-10385-1-git-send-email-abel.vesa@nxp.com>
References: <1603740750-10385-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These will be used by the imx8mp for blk_ctl driver.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 include/dt-bindings/clock/imx8mp-clock.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
index 5fc2c40..12632fa 100644
--- a/include/dt-bindings/clock/imx8mp-clock.h
+++ b/include/dt-bindings/clock/imx8mp-clock.h
@@ -396,4 +396,32 @@
 
 #define IMX8MP_CLK_AUDIO_BLK_CTL_END			59
 
+#define IMX8MP_CLK_MEDIA_BLK_CTL_MIPI_DSI_PCLK		0
+#define IMX8MP_CLK_MEDIA_BLK_CTL_MIPI_DSI_CLKREF	1
+#define IMX8MP_CLK_MEDIA_BLK_CTL_MIPI_CSI_PCLK		2
+#define IMX8MP_CLK_MEDIA_BLK_CTL_MIPI_CSI_ACLK		3
+#define IMX8MP_CLK_MEDIA_BLK_CTL_LCDIF_PIXEL		4
+#define IMX8MP_CLK_MEDIA_BLK_CTL_LCDIF_APB		5
+#define IMX8MP_CLK_MEDIA_BLK_CTL_ISI_PROC		6
+#define IMX8MP_CLK_MEDIA_BLK_CTL_ISI_APB		7
+#define IMX8MP_CLK_MEDIA_BLK_CTL_BUS_BLK		8
+#define IMX8MP_CLK_MEDIA_BLK_CTL_MIPI_CSI2_PCLK		9
+#define IMX8MP_CLK_MEDIA_BLK_CTL_MIPI_CSI2_ACLK		10
+#define IMX8MP_CLK_MEDIA_BLK_CTL_LCDIF2_PIXEL		11
+#define IMX8MP_CLK_MEDIA_BLK_CTL_LCDIF2_APB		12
+#define IMX8MP_CLK_MEDIA_BLK_CTL_ISP1_COR		13
+#define IMX8MP_CLK_MEDIA_BLK_CTL_ISP1_AXI		14
+#define IMX8MP_CLK_MEDIA_BLK_CTL_ISP1_AHB		15
+#define IMX8MP_CLK_MEDIA_BLK_CTL_ISP0_COR		16
+#define IMX8MP_CLK_MEDIA_BLK_CTL_ISP0_AXI		17
+#define IMX8MP_CLK_MEDIA_BLK_CTL_ISP0_AHB		18
+#define IMX8MP_CLK_MEDIA_BLK_CTL_DWE_COR		19
+#define IMX8MP_CLK_MEDIA_BLK_CTL_DWE_AXI		20
+#define IMX8MP_CLK_MEDIA_BLK_CTL_DWE_AHB		21
+#define IMX8MP_CLK_MEDIA_BLK_CTL_MIPI_DSI2		22
+#define IMX8MP_CLK_MEDIA_BLK_CTL_LCDIF_AXI		23
+#define IMX8MP_CLK_MEDIA_BLK_CTL_LCDIF2_AXI		24
+
+#define IMX8MP_CLK_MEDIA_BLK_CTL_END			25
+
 #endif
-- 
2.7.4

