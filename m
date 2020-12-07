Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB482D0CE7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgLGJVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:21:19 -0500
Received: from inva021.nxp.com ([92.121.34.21]:44450 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgLGJVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:21:18 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C35F42009A6;
        Mon,  7 Dec 2020 10:20:30 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AF60F200D5F;
        Mon,  7 Dec 2020 10:20:26 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4E963402D0;
        Mon,  7 Dec 2020 10:20:21 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     shengjiu.wang@gmail.com
Subject: [PATCH 3/3] arm64: dts: imx8mn-evk: Add sound-spdif card nodes
Date:   Mon,  7 Dec 2020 17:12:36 +0800
Message-Id: <1607332356-13431-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607332356-13431-1-git-send-email-shengjiu.wang@nxp.com>
References: <1607332356-13431-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sound-spdif card nodes which are supported on imx8mn-evk board.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 1d2c399eabea..a0dddba2e561 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -67,6 +67,14 @@ sound-wm8524 {
 			"Line Out Jack", "LINEVOUTL",
 			"Line Out Jack", "LINEVOUTR";
 	};
+
+	sound-spdif {
+		compatible = "fsl,imx-audio-spdif";
+		model = "imx-spdif";
+		spdif-controller = <&spdif1>;
+		spdif-out;
+		spdif-in;
+	};
 };
 
 &easrc {
@@ -164,6 +172,15 @@ &snvs_pwrkey {
 	status = "okay";
 };
 
+&spdif1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spdif1>;
+	assigned-clocks = <&clk IMX8MN_CLK_SPDIF1>;
+	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	status = "okay";
+};
+
 &uart2 { /* console */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
@@ -300,6 +317,13 @@ MX8MN_IOMUXC_SAI3_TXD_SAI3_TX_DATA0     0xd6
 		>;
 	};
 
+	pinctrl_spdif1: spdif1grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SPDIF_TX_SPDIF1_OUT	0xd6
+			MX8MN_IOMUXC_SPDIF_RX_SPDIF1_IN		0xd6
+		>;
+	};
+
 	pinctrl_typec1: typec1grp {
 		fsl,pins = <
 			MX8MN_IOMUXC_SD1_STROBE_GPIO2_IO11	0x159
-- 
2.27.0

