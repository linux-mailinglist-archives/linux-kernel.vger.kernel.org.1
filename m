Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A752A440C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 12:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgKCLUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 06:20:13 -0500
Received: from inva021.nxp.com ([92.121.34.21]:41150 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbgKCLTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 06:19:18 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 84D7720096A;
        Tue,  3 Nov 2020 12:19:16 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 77F93200869;
        Tue,  3 Nov 2020 12:19:16 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B4F922033F;
        Tue,  3 Nov 2020 12:19:15 +0100 (CET)
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
Subject: [PATCH v5 07/14] dt-bindings: reset: imx8mp: Add hdmi blk_ctl reset IDs
Date:   Tue,  3 Nov 2020 13:18:19 +0200
Message-Id: <1604402306-5348-8-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604402306-5348-1-git-send-email-abel.vesa@nxp.com>
References: <1604402306-5348-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These will be used imx8mp for blk_ctl driver.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 include/dt-bindings/reset/imx8mp-reset.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/dt-bindings/reset/imx8mp-reset.h b/include/dt-bindings/reset/imx8mp-reset.h
index ba70248..eb9ed21 100644
--- a/include/dt-bindings/reset/imx8mp-reset.h
+++ b/include/dt-bindings/reset/imx8mp-reset.h
@@ -80,4 +80,16 @@
 
 #define IMX8MP_MEDIA_BLK_CTL_RESET_NUM			25
 
+#define IMX8MP_HDMI_BLK_CTL_HDMI_TX_RESET		0
+#define IMX8MP_HDMI_BLK_CTL_HDMI_PHY_RESET		1
+#define IMX8MP_HDMI_BLK_CTL_HDMI_PAI_RESET		2
+#define IMX8MP_HDMI_BLK_CTL_HDMI_PVI_RESET		3
+#define IMX8MP_HDMI_BLK_CTL_HDMI_TRNG_RESET		4
+#define IMX8MP_HDMI_BLK_CTL_IRQ_STEER_RESET		5
+#define IMX8MP_HDMI_BLK_CTL_HDMI_HDCP_RESET		6
+#define IMX8MP_HDMI_BLK_CTL_LCDIF_RESET			7
+
+#define IMX8MP_HDMI_BLK_CTL_RESET_NUM			8
+
+
 #endif
-- 
2.7.4

