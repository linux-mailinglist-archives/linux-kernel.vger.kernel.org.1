Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED512D0CE5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgLGJVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:21:18 -0500
Received: from inva021.nxp.com ([92.121.34.21]:44434 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgLGJVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:21:17 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A7EEE200128;
        Mon,  7 Dec 2020 10:20:29 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9500B2009A6;
        Mon,  7 Dec 2020 10:20:25 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CBDF9402C7;
        Mon,  7 Dec 2020 10:20:19 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     shengjiu.wang@gmail.com
Subject: [PATCH 2/3] arm64: dts: imx8mn-evk: Add sound-wm8524 card nodes
Date:   Mon,  7 Dec 2020 17:12:35 +0800
Message-Id: <1607332356-13431-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607332356-13431-1-git-send-email-shengjiu.wang@nxp.com>
References: <1607332356-13431-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sound-wm8524 card nodes which are supported on imx8mn-evk board.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 76d042a4cf09..1d2c399eabea 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -46,6 +46,32 @@ ir-receiver {
 		pinctrl-0 = <&pinctrl_ir>;
 		linux,autosuspend-period = <125>;
 	};
+
+	wm8524: audio-codec {
+		#sound-dai-cells = <0>;
+		compatible = "wlf,wm8524";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_wlf>;
+		wlf,mute-gpios = <&gpio5 21 GPIO_ACTIVE_LOW>;
+		clocks = <&clk IMX8MN_CLK_SAI3_ROOT>;
+		clock-names = "mclk";
+	};
+
+	sound-wm8524 {
+		compatible = "fsl,imx-audio-wm8524";
+		model = "wm8524-audio";
+		audio-cpu = <&sai3>;
+		audio-codec = <&wm8524>;
+		audio-asrc = <&easrc>;
+		audio-routing =
+			"Line Out Jack", "LINEVOUTL",
+			"Line Out Jack", "LINEVOUTR";
+	};
+};
+
+&easrc {
+	fsl,asrc-rate  = <48000>;
+	status = "okay";
 };
 
 &fec1 {
@@ -124,6 +150,16 @@ pca6416: gpio@20 {
 	};
 };
 
+&sai3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3>;
+	assigned-clocks = <&clk IMX8MN_CLK_SAI3>;
+	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -210,6 +246,12 @@ MX8MN_IOMUXC_NAND_READY_B_GPIO3_IO16	0x19
 		>;
 	};
 
+	pinctrl_gpio_wlf: gpiowlfgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_I2C4_SDA_GPIO5_IO21	0xd6
+		>;
+	};
+
 	pinctrl_ir: irgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_GPIO1_IO13_GPIO1_IO13              0x4f
@@ -249,6 +291,15 @@ MX8MN_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
 		>;
 	};
 
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC     0xd6
+			MX8MN_IOMUXC_SAI3_TXC_SAI3_TX_BCLK      0xd6
+			MX8MN_IOMUXC_SAI3_MCLK_SAI3_MCLK        0xd6
+			MX8MN_IOMUXC_SAI3_TXD_SAI3_TX_DATA0     0xd6
+		>;
+	};
+
 	pinctrl_typec1: typec1grp {
 		fsl,pins = <
 			MX8MN_IOMUXC_SD1_STROBE_GPIO2_IO11	0x159
-- 
2.27.0

