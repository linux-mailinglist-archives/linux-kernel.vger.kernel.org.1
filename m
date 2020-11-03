Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B16F2A440F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 12:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgKCLUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 06:20:19 -0500
Received: from inva021.nxp.com ([92.121.34.21]:41112 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728437AbgKCLTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 06:19:17 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B15B6200741;
        Tue,  3 Nov 2020 12:19:15 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A4D8E200869;
        Tue,  3 Nov 2020 12:19:15 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id EA89B2033F;
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
Subject: [PATCH v5 06/14] dt-bindings: clock: imx8mp: Add hdmi blk_ctl clock IDs
Date:   Tue,  3 Nov 2020 13:18:18 +0200
Message-Id: <1604402306-5348-7-git-send-email-abel.vesa@nxp.com>
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
 include/dt-bindings/clock/imx8mp-clock.h | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
index 12632fa..de7d522 100644
--- a/include/dt-bindings/clock/imx8mp-clock.h
+++ b/include/dt-bindings/clock/imx8mp-clock.h
@@ -424,4 +424,44 @@
 
 #define IMX8MP_CLK_MEDIA_BLK_CTL_END			25
 
+#define IMX8MP_CLK_HDMI_BLK_CTL_GLOBAL_APB_CLK		0
+#define IMX8MP_CLK_HDMI_BLK_CTL_GLOBAL_B_CLK		1
+#define IMX8MP_CLK_HDMI_BLK_CTL_GLOBAL_REF266M_CLK	2
+#define IMX8MP_CLK_HDMI_BLK_CTL_GLOBAL_XTAL24M_CLK	3
+#define IMX8MP_CLK_HDMI_BLK_CTL_GLOBAL_XTAL32K_CLK	4
+#define IMX8MP_CLK_HDMI_BLK_CTL_GLOBAL_TX_PIX_CLK	5
+#define IMX8MP_CLK_HDMI_BLK_CTL_IRQS_STEER_CLK		6
+#define IMX8MP_CLK_HDMI_BLK_CTL_NOC_HDMI_CLK		7
+#define IMX8MP_CLK_HDMI_BLK_CTL_NOC_HDCP_CLK		8
+#define IMX8MP_CLK_HDMI_BLK_CTL_LCDIF_APB_CLK		9
+#define IMX8MP_CLK_HDMI_BLK_CTL_LCDIF_B_CLK		10
+#define IMX8MP_CLK_HDMI_BLK_CTL_LCDIF_PDI_CLK		11
+#define IMX8MP_CLK_HDMI_BLK_CTL_LCDIF_PIX_CLK		12
+#define IMX8MP_CLK_HDMI_BLK_CTL_LCDIF_SPU_CLK		13
+#define IMX8MP_CLK_HDMI_BLK_CTL_FDCC_REF_CLK		14
+#define IMX8MP_CLK_HDMI_BLK_CTL_HRV_MWR_APB_CLK		15
+#define IMX8MP_CLK_HDMI_BLK_CTL_HRV_MWR_B_CLK		16
+#define IMX8MP_CLK_HDMI_BLK_CTL_HRV_MWR_CEA_CLK		17
+#define IMX8MP_CLK_HDMI_BLK_CTL_VSFD_CEA_CLK		18
+#define IMX8MP_CLK_HDMI_BLK_CTL_TX_HPI_CLK		19
+#define IMX8MP_CLK_HDMI_BLK_CTL_TX_APB_CLK		20
+#define IMX8MP_CLK_HDMI_BLK_CTL_TX_CEC_CLK		21
+#define IMX8MP_CLK_HDMI_BLK_CTL_TX_ESM_CLK		22
+#define IMX8MP_CLK_HDMI_BLK_CTL_TX_GPA_CLK		23
+#define IMX8MP_CLK_HDMI_BLK_CTL_TX_PIXEL_CLK		24
+#define IMX8MP_CLK_HDMI_BLK_CTL_TX_SFR_CLK		25
+#define IMX8MP_CLK_HDMI_BLK_CTL_TX_SKP_CLK		26
+#define IMX8MP_CLK_HDMI_BLK_CTL_TX_PREP_CLK		27
+#define IMX8MP_CLK_HDMI_BLK_CTL_TX_PHY_APB_CLK		28
+#define IMX8MP_CLK_HDMI_BLK_CTL_TX_PHY_INT_CLK		29
+#define IMX8MP_CLK_HDMI_BLK_CTL_TX_SEC_MEM_CLK		30
+#define IMX8MP_CLK_HDMI_BLK_CTL_TX_TRNG_SKP_CLK		31
+#define IMX8MP_CLK_HDMI_BLK_CTL_TX_VID_LINK_PIX_CLK	32
+#define IMX8MP_CLK_HDMI_BLK_CTL_TX_TRNG_APB_CLK		33
+#define IMX8MP_CLK_HDMI_BLK_CTL_HTXPHY_CLK_SEL		34
+#define IMX8MP_CLK_HDMI_BLK_CTL_LCDIF_CLK_SEL		35
+#define IMX8MP_CLK_HDMI_BLK_CTL_TX_PIPE_CLK_SEL		36
+
+#define IMX8MP_CLK_HDMI_BLK_CTL_END			37
+
 #endif
-- 
2.7.4

