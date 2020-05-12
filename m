Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483141CFFFB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 23:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731184AbgELU7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 16:59:51 -0400
Received: from lists.gateworks.com ([108.161.130.12]:51278 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELU7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 16:59:51 -0400
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1jYc2a-0007Ai-WC; Tue, 12 May 2020 21:02:17 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] ARM: dts: imx6qdl-gw560x: add lsm9ds1 iio imu/magn support
Date:   Tue, 12 May 2020 13:59:37 -0700
Message-Id: <1589317177-8703-1-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one node for the accel/gyro i2c device and another for the separate
magnetometer device in the lsm9ds1.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw560x.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi b/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
index e8e36df..69ca70d 100644
--- a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
@@ -295,6 +295,15 @@
 		VDDIO-supply = <&reg_3p3v>;
 	};
 
+	magn@1c {
+		compatible = "st,lsm9ds1-magn";
+		reg = <0x1c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_mag>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <9 IRQ_TYPE_EDGE_RISING>;
+	};
+
 	tca8418: keypad@34 {
 		compatible = "ti,tca8418";
 		pinctrl-names = "default";
@@ -389,6 +398,16 @@
 			};
 		};
 	};
+
+	imu@6a {
+		compatible = "st,lsm9ds1-imu";
+		reg = <0x6a>;
+		st,drdy-int-pin = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_imu>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <6 IRQ_TYPE_LEVEL_HIGH>;
+	};
 };
 
 &i2c3 {
@@ -609,6 +628,12 @@
 		>;
 	};
 
+	pinctrl_imu: imugrp {
+		fsl,pins = <
+			MX6QDL_PAD_DISP0_DAT12__GPIO5_IO06	0x1b0b0
+		>;
+	};
+
 	pinctrl_keypad: keypadgrp {
 		fsl,pins = <
 			MX6QDL_PAD_DISP0_DAT17__GPIO5_IO11	0x0001b0b0 /* KEYPAD_IRQ# */
@@ -616,6 +641,12 @@
 		>;
 	};
 
+	pinctrl_mag: maggrp {
+		fsl,pins = <
+			MX6QDL_PAD_DISP0_DAT15__GPIO5_IO09	0x1b0b0
+		>;
+	};
+
 	pinctrl_pcie: pciegrp {
 		fsl,pins = <
 			MX6QDL_PAD_DISP0_DAT10__GPIO4_IO31	0x1b0b0    /* PCI_RST# */
-- 
2.7.4

