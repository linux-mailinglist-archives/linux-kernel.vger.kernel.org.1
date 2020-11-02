Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A9D2A22F2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 03:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgKBCRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 21:17:13 -0500
Received: from inva021.nxp.com ([92.121.34.21]:42614 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbgKBCRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 21:17:12 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5742520143B;
        Mon,  2 Nov 2020 03:17:10 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C8BA20146B;
        Mon,  2 Nov 2020 03:17:06 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8CD8A402DA;
        Mon,  2 Nov 2020 03:17:01 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] arm64: dts: imx8mq-evk: Add spdif sound card support
Date:   Mon,  2 Nov 2020 10:11:17 +0800
Message-Id: <1604283077-27012-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604283077-27012-1-git-send-email-shengjiu.wang@nxp.com>
References: <1604283077-27012-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two spdif IP on imx8mq, spdif1 is for normal
spdif device, spdif2 is for HDMI ARC interface.

Enable these spdif sound card in this patch.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2:
- remove undocument compatible string.

 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 38 ++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 48 ++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 2418cca00bc5..e4250812586b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -87,6 +87,21 @@ link_codec: simple-audio-card,codec {
 			clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
 		};
 	};
+
+	sound-spdif {
+		compatible = "fsl,imx-audio-spdif";
+		model = "imx-spdif";
+		spdif-controller = <&spdif1>;
+		spdif-out;
+		spdif-in;
+	};
+
+	sound-hdmi-arc {
+		compatible = "fsl,imx-audio-spdif";
+		model = "imx-hdmi-arc";
+		spdif-controller = <&spdif2>;
+		spdif-in;
+	};
 };
 
 &A53_0 {
@@ -336,6 +351,22 @@ &snvs_pwrkey {
 	status = "okay";
 };
 
+&spdif1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spdif1>;
+	assigned-clocks = <&clk IMX8MQ_CLK_SPDIF1>;
+	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	status = "okay";
+};
+
+&spdif2 {
+	assigned-clocks = <&clk IMX8MQ_CLK_SPDIF2>;
+	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -467,6 +498,13 @@ MX8MQ_IOMUXC_GPIO1_IO08_GPIO1_IO8       0xd6
 		>;
 	};
 
+	pinctrl_spdif1: spdif1grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SPDIF_TX_SPDIF1_OUT	0xd6
+			MX8MQ_IOMUXC_SPDIF_RX_SPDIF1_IN		0xd6
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX		0x49
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 49cc79246288..a841a023e8e0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -793,6 +793,30 @@ bus@30800000 { /* AIPS3 */
 			ranges = <0x30800000 0x30800000 0x400000>,
 				 <0x08000000 0x08000000 0x10000000>;
 
+			spdif1: spdif@30810000 {
+				compatible = "fsl,imx35-spdif";
+				reg = <0x30810000 0x10000>;
+				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_IPG_ROOT>, /* core */
+					<&clk IMX8MQ_CLK_25M>, /* rxtx0 */
+					<&clk IMX8MQ_CLK_SPDIF1>, /* rxtx1 */
+					<&clk IMX8MQ_CLK_DUMMY>, /* rxtx2 */
+					<&clk IMX8MQ_CLK_DUMMY>, /* rxtx3 */
+					<&clk IMX8MQ_CLK_DUMMY>, /* rxtx4 */
+					<&clk IMX8MQ_CLK_IPG_ROOT>, /* rxtx5 */
+					<&clk IMX8MQ_CLK_DUMMY>, /* rxtx6 */
+					<&clk IMX8MQ_CLK_DUMMY>, /* rxtx7 */
+					<&clk IMX8MQ_CLK_DUMMY>; /* spba */
+				clock-names = "core", "rxtx0",
+					      "rxtx1", "rxtx2",
+					      "rxtx3", "rxtx4",
+					      "rxtx5", "rxtx6",
+					      "rxtx7", "spba";
+				dmas = <&sdma1 8 18 0>, <&sdma1 9 18 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
 			ecspi1: spi@30820000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -862,6 +886,30 @@ uart2: serial@30890000 {
 				status = "disabled";
 			};
 
+			spdif2: spdif@308a0000 {
+				compatible = "fsl,imx35-spdif";
+				reg = <0x308a0000 0x10000>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_IPG_ROOT>, /* core */
+					<&clk IMX8MQ_CLK_25M>, /* rxtx0 */
+					<&clk IMX8MQ_CLK_SPDIF2>, /* rxtx1 */
+					<&clk IMX8MQ_CLK_DUMMY>, /* rxtx2 */
+					<&clk IMX8MQ_CLK_DUMMY>, /* rxtx3 */
+					<&clk IMX8MQ_CLK_DUMMY>, /* rxtx4 */
+					<&clk IMX8MQ_CLK_IPG_ROOT>, /* rxtx5 */
+					<&clk IMX8MQ_CLK_DUMMY>, /* rxtx6 */
+					<&clk IMX8MQ_CLK_DUMMY>, /* rxtx7 */
+					<&clk IMX8MQ_CLK_DUMMY>; /* spba */
+				clock-names = "core", "rxtx0",
+					      "rxtx1", "rxtx2",
+					      "rxtx3", "rxtx4",
+					      "rxtx5", "rxtx6",
+					      "rxtx7", "spba";
+				dmas = <&sdma1 16 18 0>, <&sdma1 17 18 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
 			sai2: sai@308b0000 {
 				#sound-dai-cells = <0>;
 				compatible = "fsl,imx8mq-sai";
-- 
2.27.0

