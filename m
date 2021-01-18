Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC8C2F9D63
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389877AbhARLBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:01:01 -0500
Received: from comms.puri.sm ([159.203.221.185]:59730 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389536AbhARK4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:56:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id D6D4DDFD5D;
        Mon, 18 Jan 2021 02:55:13 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fvJqm1Yvo45o; Mon, 18 Jan 2021 02:55:12 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, krzk@kernel.org,
        kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 6/9] arm64: dts: imx8mq-librem5: enable the LCD panel
Date:   Mon, 18 Jan 2021 11:54:22 +0100
Message-Id: <20210118105425.425-7-martin.kepplinger@puri.sm>
In-Reply-To: <20210118105425.425-1-martin.kepplinger@puri.sm>
References: <20210118105425.425-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables the Librem5's ft8006p based LCD panel driven by the
imx8mq's Northwest Logic DSI IP core and mxsfb display controller.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 .../boot/dts/freescale/imx8mq-librem5.dtsi    | 53 ++++++++++++++++++-
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index f77b51d3c132..bf86402cda30 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -310,6 +310,17 @@
 		>;
 	};
 
+	pinctrl_dsirst: dsirstgrp {
+		fsl,pins = <
+			/* DSI_RST */
+			MX8MQ_IOMUXC_ENET_RD3_GPIO1_IO29	0x83
+			/* DSI_TE */
+			MX8MQ_IOMUXC_ENET_RD2_GPIO1_IO28	0x83
+			/* TP_RST */
+			MX8MQ_IOMUXC_ENET_RX_CTL_GPIO1_IO24	0x83
+		>;
+	};
+
 	pinctrl_ecspi1: ecspigrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI	0x83
@@ -817,12 +828,12 @@
 		compatible = "tps65132";
 		reg = <0x3e>;
 
-		outp {
+		reg_lcd_avdd: outp {
 			regulator-name = "LCD_AVDD";
 			vin-supply = <&reg_lcd_3v4>;
 		};
 
-		outn {
+		reg_lcd_avee: outn {
 			regulator-name = "LCD_AVEE";
 			vin-supply = <&reg_lcd_3v4>;
 		};
@@ -947,6 +958,44 @@
 	};
 };
 
+&lcdif {
+	status = "okay";
+};
+
+&mipi_dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	lcd_panel: panel@0 {
+		compatible = "mantix,mlaf057we51-x";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_dsirst>;
+		avdd-supply = <&reg_lcd_avdd>;
+		avee-supply = <&reg_lcd_avee>;
+		vddi-supply = <&reg_lcd_1v8>;
+		backlight = <&backlight_dsi>;
+		reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&mipi_dsi_out>;
+			};
+		};
+	};
+
+	ports {
+		port@1 {
+			reg = <1>;
+
+			mipi_dsi_out: endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
+};
+
 &pgc_gpu {
 	power-supply = <&buck3_reg>;
 };
-- 
2.20.1

