Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91C72F2BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392793AbhALJzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:55:06 -0500
Received: from comms.puri.sm ([159.203.221.185]:34830 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392885AbhALJyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:54:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 2DFCADFE0E;
        Tue, 12 Jan 2021 01:53:21 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KpMppWquF1s7; Tue, 12 Jan 2021 01:53:20 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, catalin.marinas@arm.com,
        will@kernel.org, krzk@kernel.org, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH 6/9] arm64: dts: imx8mq-librem5: enable the LCD panel
Date:   Tue, 12 Jan 2021 10:51:48 +0100
Message-Id: <20210112095151.4995-7-martin.kepplinger@puri.sm>
In-Reply-To: <20210112095151.4995-1-martin.kepplinger@puri.sm>
References: <20210112095151.4995-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables the Librem5's ft8006p based LCD panel driven by the
imx8mq's Northwest Logic DSI IP core and mxsfb display controller.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 .../boot/dts/freescale/imx8mq-librem5.dtsi    | 51 ++++++++++++++++++-
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index f77b51d3c132..440931f81c12 100644
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
@@ -947,6 +958,42 @@
 	};
 };
 
+&lcdif {
+	status = "okay";
+};
+
+&mipi_dsi {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
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

