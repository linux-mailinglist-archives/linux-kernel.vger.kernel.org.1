Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3132A4413
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 12:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgKCLUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 06:20:23 -0500
Received: from inva020.nxp.com ([92.121.34.13]:38264 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbgKCLTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 06:19:17 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E7AE91A0600;
        Tue,  3 Nov 2020 12:19:14 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DA9F41A0984;
        Tue,  3 Nov 2020 12:19:14 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 292A62033F;
        Tue,  3 Nov 2020 12:19:14 +0100 (CET)
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
Subject: [PATCH v5 05/14] dt-bindings: reset: imx8mp: Add media blk_ctl reset IDs
Date:   Tue,  3 Nov 2020 13:18:17 +0200
Message-Id: <1604402306-5348-6-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604402306-5348-1-git-send-email-abel.vesa@nxp.com>
References: <1604402306-5348-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These will be used by the imx8mp for blk_ctl driver.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 include/dt-bindings/reset/imx8mp-reset.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/dt-bindings/reset/imx8mp-reset.h b/include/dt-bindings/reset/imx8mp-reset.h
index 6c7f17f..ba70248 100644
--- a/include/dt-bindings/reset/imx8mp-reset.h
+++ b/include/dt-bindings/reset/imx8mp-reset.h
@@ -52,4 +52,32 @@
 
 #define IMX8MP_AUDIO_BLK_CTL_RESET_NUM		2
 
+#define IMX8MP_MEDIA_BLK_CTL_RESET_MIPI_DSI_PCLK	0
+#define IMX8MP_MEDIA_BLK_CTL_RESET_MIPI_DSI_CLKREF	1
+#define IMX8MP_MEDIA_BLK_CTL_RESET_MIPI_CSI_PCLK	2
+#define IMX8MP_MEDIA_BLK_CTL_RESET_MIPI_CSI_ACLK	3
+#define IMX8MP_MEDIA_BLK_CTL_RESET_LCDIF_PIXEL		4
+#define IMX8MP_MEDIA_BLK_CTL_RESET_LCDIF_APB		5
+#define IMX8MP_MEDIA_BLK_CTL_RESET_ISI_PROC		6
+#define IMX8MP_MEDIA_BLK_CTL_RESET_ISI_APB		7
+#define IMX8MP_MEDIA_BLK_CTL_RESET_BUS_BLK		8
+#define IMX8MP_MEDIA_BLK_CTL_RESET_MIPI_CSI2_PCLK	9
+#define IMX8MP_MEDIA_BLK_CTL_RESET_MIPI_CSI2_ACLK	10
+#define IMX8MP_MEDIA_BLK_CTL_RESET_LCDIF2_PIXEL		11
+#define IMX8MP_MEDIA_BLK_CTL_RESET_LCDIF2_APB		12
+#define IMX8MP_MEDIA_BLK_CTL_RESET_ISP1_COR		13
+#define IMX8MP_MEDIA_BLK_CTL_RESET_ISP1_AXI		14
+#define IMX8MP_MEDIA_BLK_CTL_RESET_ISP1_AHB		15
+#define IMX8MP_MEDIA_BLK_CTL_RESET_ISP0_COR		16
+#define IMX8MP_MEDIA_BLK_CTL_RESET_ISP0_AXI		17
+#define IMX8MP_MEDIA_BLK_CTL_RESET_ISP0_AHB		18
+#define IMX8MP_MEDIA_BLK_CTL_RESET_DWE_COR		19
+#define IMX8MP_MEDIA_BLK_CTL_RESET_DWE_AXI		20
+#define IMX8MP_MEDIA_BLK_CTL_RESET_DWE_AHB		21
+#define IMX8MP_MEDIA_BLK_CTL_RESET_MIPI_DSI2		22
+#define IMX8MP_MEDIA_BLK_CTL_RESET_LCDIF_AXI		23
+#define IMX8MP_MEDIA_BLK_CTL_RESET_LCDIF2_AXI		24
+
+#define IMX8MP_MEDIA_BLK_CTL_RESET_NUM			25
+
 #endif
-- 
2.7.4

