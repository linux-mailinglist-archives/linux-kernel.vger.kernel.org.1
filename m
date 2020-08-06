Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF54623DDAF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 19:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbgHFRMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 13:12:54 -0400
Received: from inva021.nxp.com ([92.121.34.21]:34522 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730214AbgHFRKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:10:06 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3CA68200878;
        Thu,  6 Aug 2020 13:55:11 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5FD21200869;
        Thu,  6 Aug 2020 13:55:07 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5255040252;
        Thu,  6 Aug 2020 13:55:02 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: imx6sll-evk: Add audio sound card node
Date:   Thu,  6 Aug 2020 19:50:29 +0800
Message-Id: <1596714629-16425-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audio sound card node, which depends on codec node,
SSI node, audmux node.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm/boot/dts/imx6sll-evk.dts | 74 +++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index 5ace9e6acf85..45bf5e61e960 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -132,6 +132,29 @@ panel_in: endpoint {
 			};
 		};
 	};
+
+	sound {
+		compatible = "fsl,imx6sl-evk-wm8962", "fsl,imx-audio-wm8962";
+		model = "wm8962-audio";
+		audio-cpu = <&ssi2>;
+		audio-codec = <&codec>;
+		audio-routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"Ext Spk", "SPKOUTL",
+			"Ext Spk", "SPKOUTR",
+			"AMIC", "MICBIAS",
+			"IN3R", "AMIC";
+		mux-int-port = <2>;
+		mux-ext-port = <3>;
+		hp-det-gpio = <&gpio4 24 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux3>;
+	status = "okay";
 };
 
 &cpu0 {
@@ -247,6 +270,27 @@ vgen6_reg: vgen6 {
 	};
 };
 
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	codec: wm8962@1a {
+		compatible = "wlf,wm8962";
+		reg = <0x1a>;
+		clocks = <&clks IMX6SLL_CLK_EXTERN_AUDIO>;
+		DCVDD-supply = <&vgen3_reg>;
+		DBVDD-supply = <&reg_aud3v>;
+		AVDD-supply = <&vgen3_reg>;
+		CPVDD-supply = <&vgen3_reg>;
+		MICVDD-supply = <&reg_aud3v>;
+		PLLVDD-supply = <&vgen3_reg>;
+		SPKVDD1-supply = <&reg_aud4v>;
+		SPKVDD2-supply = <&reg_aud4v>;
+	};
+};
+
 &lcdif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcd>;
@@ -273,6 +317,10 @@ &snvs_pwrkey {
 	status = "okay";
 };
 
+&ssi2 {
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -329,6 +377,25 @@ &wdog1 {
 };
 
 &iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_audmux3: audmux3grp {
+		fsl,pins = <
+			MX6SLL_PAD_AUD_TXC__AUD3_TXC		0x4130b0
+			MX6SLL_PAD_AUD_TXFS__AUD3_TXFS		0x4130b0
+			MX6SLL_PAD_AUD_TXD__AUD3_TXD		0x4110b0
+			MX6SLL_PAD_AUD_RXD__AUD3_RXD		0x4130b0
+			MX6SLL_PAD_AUD_MCLK__AUDIO_CLK_OUT	0x4130b0
+		>;
+	};
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX6SLL_PAD_GPIO4_IO24__GPIO4_IO24 0x17059 /* HP DETECT */
+		>;
+	};
+
 	pinctrl_reg_sd3_vmmc: sd3vmmcgrp {
 		fsl,pins = <
 			MX6SLL_PAD_KEY_COL6__GPIO4_IO04 0x17059
@@ -448,6 +515,13 @@ MX6SLL_PAD_I2C1_SDA__I2C1_SDA	 0x4001b8b1
 		>;
 	};
 
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6SLL_PAD_AUD_RXFS__I2C3_SCL  0x4041b8b1
+			MX6SLL_PAD_AUD_RXC__I2C3_SDA   0x4041b8b1
+		>;
+	};
+
 	pinctrl_lcd: lcdgrp {
 		fsl,pins = <
 			MX6SLL_PAD_LCD_DATA00__LCD_DATA00	0x79
-- 
2.27.0

