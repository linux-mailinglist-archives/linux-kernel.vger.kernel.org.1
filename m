Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D232986DB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 07:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770384AbgJZG2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 02:28:39 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60036 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1770376AbgJZG2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 02:28:38 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9502E201880;
        Mon, 26 Oct 2020 07:28:36 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B185F201734;
        Mon, 26 Oct 2020 07:28:32 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DA1D540314;
        Mon, 26 Oct 2020 07:28:27 +0100 (CET)
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mkl@pengutronix.de, Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH] arm64: dts: imx8mp-evk: add CAN support
Date:   Mon, 26 Oct 2020 14:22:56 +0800
Message-Id: <1603693376-17206-1-git-send-email-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CAN device node and pinctrl on i.MX8MP evk board.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 62 ++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi    | 30 ++++++++++
 2 files changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index ad66f1286d95..85aaed7dc4bc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -33,6 +33,28 @@
 		      <0x1 0x00000000 0 0xc0000000>;
 	};
 
+	reg_can1_stby: regulator-can1-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "can1-stby";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan1_reg>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio5 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_can2_stby: regulator-can2-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "can2-stby";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan2_reg>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -45,6 +67,20 @@
 	};
 };
 
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_can1_stby>;
+	status = "okay";
+};
+
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_can2_stby>;
+	status = "disabled";/* can2 pin conflict with pdm */
+};
+
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
@@ -144,6 +180,32 @@
 		>;
 	};
 
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_RX__CAN1_RX          0x154
+			MX8MP_IOMUXC_SPDIF_TX__CAN1_TX          0x154
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_MCLK__CAN2_RX         0x154
+			MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX         0x154
+		>;
+	};
+
+	pinctrl_flexcan1_reg: flexcan1reggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05  0x154   /* CAN1_STBY */
+		>;
+	};
+
+	pinctrl_flexcan2_reg: flexcan2reggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27      0x154   /* CAN2_STBY */
+		>;
+	};
+
 	pinctrl_gpio_led: gpioledgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x19
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 6038f66aefc1..cc123a5e3f7e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -545,6 +545,36 @@
 				status = "disabled";
 			};
 
+			flexcan1: can@308c0000 {
+				compatible = "fsl,imx8mp-flexcan", "fsl,imx6q-flexcan";
+				reg = <0x308c0000 0x10000>;
+				interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MP_CLK_IPG_ROOT>,
+					 <&clk IMX8MP_CLK_CAN1_ROOT>;
+				clock-names = "ipg", "per";
+				assigned-clocks = <&clk IMX8MP_CLK_CAN1>;
+				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_40M>;
+				assigned-clock-rates = <40000000>;
+				fsl,clk-source= /bits/ 8 <0>;
+				fsl,stop-mode = <&gpr 0x10 4>;
+				status = "disabled";
+			};
+
+			flexcan2: can@308d0000 {
+				compatible = "fsl,imx8mp-flexcan", "fsl,imx6q-flexcan";
+				reg = <0x308d0000 0x10000>;
+				interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MP_CLK_IPG_ROOT>,
+					 <&clk IMX8MP_CLK_CAN2_ROOT>;
+				clock-names = "ipg", "per";
+				assigned-clocks = <&clk IMX8MP_CLK_CAN2>;
+				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_40M>;
+				assigned-clock-rates = <40000000>;
+				fsl,clk-source= /bits/ 8 <0>;
+				fsl,stop-mode = <&gpr 0x10 5>;
+				status = "disabled";
+			};
+
 			crypto: crypto@30900000 {
 				compatible = "fsl,sec-v4.0";
 				#address-cells = <1>;
-- 
2.17.1

