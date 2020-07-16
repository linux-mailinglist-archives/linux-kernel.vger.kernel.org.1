Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1230E22271B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 17:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgGPPgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 11:36:14 -0400
Received: from lists.gateworks.com ([108.161.130.12]:50015 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgGPPgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:36:13 -0400
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1jw5zG-0006b0-VC; Thu, 16 Jul 2020 15:39:55 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        rjones@gateworks.com
Cc:     linux-arm-kernel@lists.infradead.org,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v4] ARM: dts: imx6qdl-gw: add Gateworks System Controller support
Date:   Thu, 16 Jul 2020 08:35:55 -0700
Message-Id: <1594913755-5661-1-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592497149-22526-1-git-send-email-tharvey@gateworks.com>
References: <1592497149-22526-1-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Gateworks System Controller support to Gateworks Ventana boards:
- add dt bindings for GSC mfd driver and hwmon driver for ADC's and
  fan controllers.
- add dt bindings for gpio-keys driver for push-button and interrupt events

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v4:
 - add missing #address-cells to gw5912 gsc node to address dtc warning

v3:
 - change underscore to hyphen in node names
 - use generic node name for gsc_gpio nodes

v2:
 - use keycode bindings from linux-event-codes.h
 - fix gw5910 vdd_bat adc mode
 - fix gw5913 vdd_bat adc mode
---
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi | 153 +++++++++++++++++++++++++++++--
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 159 ++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 165 +++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 167 ++++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi | 147 ++++++++++++++++++++++++++++--
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi | 153 +++++++++++++++++++++++++++++--
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi | 141 +++++++++++++++++++++++++++-
 arch/arm/boot/dts/imx6qdl-gw560x.dtsi | 164 +++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi | 140 +++++++++++++++++++++++++++-
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi | 141 +++++++++++++++++++++++++++-
 arch/arm/boot/dts/imx6qdl-gw5907.dtsi | 142 ++++++++++++++++++++++++++++-
 arch/arm/boot/dts/imx6qdl-gw5910.dtsi | 160 +++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/imx6qdl-gw5912.dtsi | 148 +++++++++++++++++++++++++++++-
 arch/arm/boot/dts/imx6qdl-gw5913.dtsi | 153 ++++++++++++++++++++++++++++++-
 14 files changed, 2076 insertions(+), 57 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index 419a7cd..7705285 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -19,6 +20,53 @@
 		bootargs = "console=ttymxc1,115200";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		user-pb {
+			label = "user_pb";
+			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_0>;
+		};
+
+		user-pb1x {
+			label = "user_pb1x";
+			linux,code = <BTN_1>;
+			interrupt-parent = <&gsc>;
+			interrupts = <0>;
+		};
+
+		key-erased {
+			label = "key-erased";
+			linux,code = <BTN_2>;
+			interrupt-parent = <&gsc>;
+			interrupts = <1>;
+		};
+
+		eeprom-wp {
+			label = "eeprom_wp";
+			linux,code = <BTN_3>;
+			interrupt-parent = <&gsc>;
+			interrupts = <2>;
+		};
+
+		tamper {
+			label = "tamper";
+			linux,code = <BTN_4>;
+			interrupt-parent = <&gsc>;
+			interrupts = <5>;
+		};
+
+		switch-hold {
+			label = "switch_hold";
+			linux,code = <BTN_5>;
+			interrupt-parent = <&gsc>;
+			interrupts = <7>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -102,6 +150,103 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
+	gsc: gsc@20 {
+		compatible = "gw,gsc";
+		reg = <0x20>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		#size-cells = <0>;
+
+		adc {
+			compatible = "gw,gsc-adc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@0 {
+				gw,mode = <0>;
+				reg = <0x00>;
+				label = "temp";
+			};
+
+			channel@2 {
+				gw,mode = <1>;
+				reg = <0x02>;
+				label = "vdd_vin";
+			};
+
+			channel@5 {
+				gw,mode = <1>;
+				reg = <0x05>;
+				label = "vdd_3p3";
+			};
+
+			channel@8 {
+				gw,mode = <1>;
+				reg = <0x08>;
+				label = "vdd_bat";
+			};
+
+			channel@b {
+				gw,mode = <1>;
+				reg = <0x0b>;
+				label = "vdd_5p0";
+			};
+
+			channel@e {
+				gw,mode = <1>;
+				reg = <0xe>;
+				label = "vdd_arm";
+			};
+
+			channel@11 {
+				gw,mode = <1>;
+				reg = <0x11>;
+				label = "vdd_soc";
+			};
+
+			channel@14 {
+				gw,mode = <1>;
+				reg = <0x14>;
+				label = "vdd_3p0";
+			};
+
+			channel@17 {
+				gw,mode = <1>;
+				reg = <0x17>;
+				label = "vdd_1p5";
+			};
+
+			channel@1d {
+				gw,mode = <1>;
+				reg = <0x1d>;
+				label = "vdd_1p8";
+			};
+
+			channel@20 {
+				gw,mode = <1>;
+				reg = <0x20>;
+				label = "vdd_an1";
+			};
+
+			channel@23 {
+				gw,mode = <1>;
+				reg = <0x23>;
+				label = "vdd_2p5";
+			};
+		};
+	};
+
+	gsc_gpio: gpio@23 {
+		compatible = "nxp,pca9555";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gsc>;
+		interrupts = <4>;
+	};
+
 	eeprom1: eeprom@50 {
 		compatible = "atmel,24c02";
 		reg = <0x50>;
@@ -126,13 +271,6 @@
 		pagesize = <16>;
 	};
 
-	gpio: pca9555@23 {
-		compatible = "nxp,pca9555";
-		reg = <0x23>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	rtc: ds1672@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
@@ -387,6 +525,7 @@
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
 			MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
+			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x0001b0b0 /* GSC_IRQ# */
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 60563ff..9e5bec1 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -28,6 +29,53 @@
 		default-brightness-level = <7>;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		user-pb {
+			label = "user_pb";
+			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_0>;
+		};
+
+		user-pb1x {
+			label = "user_pb1x";
+			linux,code = <BTN_1>;
+			interrupt-parent = <&gsc>;
+			interrupts = <0>;
+		};
+
+		key-erased {
+			label = "key-erased";
+			linux,code = <BTN_2>;
+			interrupt-parent = <&gsc>;
+			interrupts = <1>;
+		};
+
+		eeprom-wp {
+			label = "eeprom_wp";
+			linux,code = <BTN_3>;
+			interrupt-parent = <&gsc>;
+			interrupts = <2>;
+		};
+
+		tamper {
+			label = "tamper";
+			linux,code = <BTN_4>;
+			interrupt-parent = <&gsc>;
+			interrupts = <5>;
+		};
+
+		switch-hold {
+			label = "switch_hold";
+			linux,code = <BTN_5>;
+			interrupt-parent = <&gsc>;
+			interrupts = <7>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -165,6 +213,109 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
+	gsc: gsc@20 {
+		compatible = "gw,gsc";
+		reg = <0x20>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		#size-cells = <0>;
+
+		adc {
+			compatible = "gw,gsc-adc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@0 {
+				gw,mode = <0>;
+				reg = <0x00>;
+				label = "temp";
+			};
+
+			channel@2 {
+				gw,mode = <1>;
+				reg = <0x02>;
+				label = "vdd_vin";
+			};
+
+			channel@5 {
+				gw,mode = <1>;
+				reg = <0x05>;
+				label = "vdd_3p3";
+			};
+
+			channel@8 {
+				gw,mode = <1>;
+				reg = <0x08>;
+				label = "vdd_bat";
+			};
+
+			channel@b {
+				gw,mode = <1>;
+				reg = <0x0b>;
+				label = "vdd_5p0";
+			};
+
+			channel@e {
+				gw,mode = <1>;
+				reg = <0xe>;
+				label = "vdd_arm";
+			};
+
+			channel@11 {
+				gw,mode = <1>;
+				reg = <0x11>;
+				label = "vdd_soc";
+			};
+
+			channel@14 {
+				gw,mode = <1>;
+				reg = <0x14>;
+				label = "vdd_3p0";
+			};
+
+			channel@17 {
+				gw,mode = <1>;
+				reg = <0x17>;
+				label = "vdd_1p5";
+			};
+
+			channel@1d {
+				gw,mode = <1>;
+				reg = <0x1d>;
+				label = "vdd_1p8";
+			};
+
+			channel@20 {
+				gw,mode = <1>;
+				reg = <0x20>;
+				label = "vdd_1p0";
+			};
+
+			channel@23 {
+				gw,mode = <1>;
+				reg = <0x23>;
+				label = "vdd_2p5";
+			};
+
+			channel@29 {
+				gw,mode = <1>;
+				reg = <0x29>;
+				label = "vdd_an1";
+			};
+		};
+	};
+
+	gsc_gpio: gpio@23 {
+		compatible = "nxp,pca9555";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gsc>;
+		interrupts = <4>;
+	};
+
 	eeprom1: eeprom@50 {
 		compatible = "atmel,24c02";
 		reg = <0x50>;
@@ -189,13 +340,6 @@
 		pagesize = <16>;
 	};
 
-	gpio: pca9555@23 {
-		compatible = "nxp,pca9555";
-		reg = <0x23>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	rtc: ds1672@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
@@ -504,6 +648,7 @@
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
 			MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
+			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0xb0b1
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 8942bec..7ea4fdd 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -28,6 +29,53 @@
 		default-brightness-level = <7>;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		user-pb {
+			label = "user_pb";
+			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_0>;
+		};
+
+		user-pb1x {
+			label = "user_pb1x";
+			linux,code = <BTN_1>;
+			interrupt-parent = <&gsc>;
+			interrupts = <0>;
+		};
+
+		key-erased {
+			label = "key-erased";
+			linux,code = <BTN_2>;
+			interrupt-parent = <&gsc>;
+			interrupts = <1>;
+		};
+
+		eeprom-wp {
+			label = "eeprom_wp";
+			linux,code = <BTN_3>;
+			interrupt-parent = <&gsc>;
+			interrupts = <2>;
+		};
+
+		tamper {
+			label = "tamper";
+			linux,code = <BTN_4>;
+			interrupt-parent = <&gsc>;
+			interrupts = <5>;
+		};
+
+		switch-hold {
+			label = "switch_hold";
+			linux,code = <BTN_5>;
+			interrupt-parent = <&gsc>;
+			interrupts = <7>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -158,6 +206,115 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
+	gsc: gsc@20 {
+		compatible = "gw,gsc";
+		reg = <0x20>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		#size-cells = <0>;
+
+		adc {
+			compatible = "gw,gsc-adc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@0 {
+				gw,mode = <0>;
+				reg = <0x00>;
+				label = "temp";
+			};
+
+			channel@2 {
+				gw,mode = <1>;
+				reg = <0x02>;
+				label = "vdd_vin";
+			};
+
+			channel@5 {
+				gw,mode = <1>;
+				reg = <0x05>;
+				label = "vdd_3p3";
+			};
+
+			channel@8 {
+				gw,mode = <1>;
+				reg = <0x08>;
+				label = "vdd_bat";
+			};
+
+			channel@b {
+				gw,mode = <1>;
+				reg = <0x0b>;
+				label = "vdd_5p0";
+			};
+
+			channel@e {
+				gw,mode = <1>;
+				reg = <0xe>;
+				label = "vdd_arm";
+			};
+
+			channel@11 {
+				gw,mode = <1>;
+				reg = <0x11>;
+				label = "vdd_soc";
+			};
+
+			channel@14 {
+				gw,mode = <1>;
+				reg = <0x14>;
+				label = "vdd_3p0";
+			};
+
+			channel@17 {
+				gw,mode = <1>;
+				reg = <0x17>;
+				label = "vdd_1p5";
+			};
+
+			channel@1d {
+				gw,mode = <1>;
+				reg = <0x1d>;
+				label = "vdd_1p8";
+			};
+
+			channel@20 {
+				gw,mode = <1>;
+				reg = <0x20>;
+				label = "vdd_1p0";
+			};
+
+			channel@23 {
+				gw,mode = <1>;
+				reg = <0x23>;
+				label = "vdd_2p5";
+			};
+
+			channel@26 {
+				gw,mode = <1>;
+				reg = <0x26>;
+				label = "vdd_gps";
+			};
+
+			channel@29 {
+				gw,mode = <1>;
+				reg = <0x29>;
+				label = "vdd_an1";
+			};
+		};
+	};
+
+	gsc_gpio: gpio@23 {
+		compatible = "nxp,pca9555";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gsc>;
+		interrupts = <4>;
+	};
+
 	eeprom1: eeprom@50 {
 		compatible = "atmel,24c02";
 		reg = <0x50>;
@@ -182,13 +339,6 @@
 		pagesize = <16>;
 	};
 
-	gpio: pca9555@23 {
-		compatible = "nxp,pca9555";
-		reg = <0x23>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	rtc: ds1672@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
@@ -486,6 +636,7 @@
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
 			MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
+			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0xb0b1
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index c40583d..0c19759 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/sound/fsl-imx-audmux.h>
 
 / {
@@ -29,6 +30,53 @@
 		default-brightness-level = <7>;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		user-pb {
+			label = "user_pb";
+			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_0>;
+		};
+
+		user-pb1x {
+			label = "user_pb1x";
+			linux,code = <BTN_1>;
+			interrupt-parent = <&gsc>;
+			interrupts = <0>;
+		};
+
+		key-erased {
+			label = "key-erased";
+			linux,code = <BTN_2>;
+			interrupt-parent = <&gsc>;
+			interrupts = <1>;
+		};
+
+		eeprom-wp {
+			label = "eeprom_wp";
+			linux,code = <BTN_3>;
+			interrupt-parent = <&gsc>;
+			interrupts = <2>;
+		};
+
+		tamper {
+			label = "tamper";
+			linux,code = <BTN_4>;
+			interrupt-parent = <&gsc>;
+			interrupts = <5>;
+		};
+
+		switch-hold {
+			label = "switch_hold";
+			linux,code = <BTN_5>;
+			interrupt-parent = <&gsc>;
+			interrupts = <7>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -195,6 +243,117 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
+	gsc: gsc@20 {
+		compatible = "gw,gsc";
+		reg = <0x20>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		adc {
+			compatible = "gw,gsc-adc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@0 {
+				gw,mode = <0>;
+				reg = <0x00>;
+				label = "temp";
+			};
+
+			channel@2 {
+				gw,mode = <1>;
+				reg = <0x02>;
+				label = "vdd_vin";
+			};
+
+			channel@5 {
+				gw,mode = <1>;
+				reg = <0x05>;
+				label = "vdd_3p3";
+			};
+
+			channel@8 {
+				gw,mode = <1>;
+				reg = <0x08>;
+				label = "vdd_bat";
+			};
+
+			channel@b {
+				gw,mode = <1>;
+				reg = <0x0b>;
+				label = "vdd_5p0";
+			};
+
+			channel@e {
+				gw,mode = <1>;
+				reg = <0xe>;
+				label = "vdd_arm";
+			};
+
+			channel@11 {
+				gw,mode = <1>;
+				reg = <0x11>;
+				label = "vdd_soc";
+			};
+
+			channel@14 {
+				gw,mode = <1>;
+				reg = <0x14>;
+				label = "vdd_3p0";
+			};
+
+			channel@17 {
+				gw,mode = <1>;
+				reg = <0x17>;
+				label = "vdd_1p5";
+			};
+
+			channel@1d {
+				gw,mode = <1>;
+				reg = <0x1d>;
+				label = "vdd_1p8";
+			};
+
+			channel@20 {
+				gw,mode = <1>;
+				reg = <0x20>;
+				label = "vdd_1p0";
+			};
+
+			channel@23 {
+				gw,mode = <1>;
+				reg = <0x23>;
+				label = "vdd_2p5";
+			};
+
+			channel@26 {
+				gw,mode = <1>;
+				reg = <0x26>;
+				label = "vdd_gps";
+			};
+		};
+
+		fan-controller@2c {
+			compatible = "gw,gsc-fan";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2c>;
+		};
+	};
+
+	gsc_gpio: gpio@23 {
+		compatible = "nxp,pca9555";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gsc>;
+		interrupts = <4>;
+	};
+
 	eeprom1: eeprom@50 {
 		compatible = "atmel,24c02";
 		reg = <0x50>;
@@ -219,13 +378,6 @@
 		pagesize = <16>;
 	};
 
-	gpio: pca9555@23 {
-		compatible = "nxp,pca9555";
-		reg = <0x23>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	rtc: ds1672@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
@@ -571,6 +723,7 @@
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
 			MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
+			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0xb0b1
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
index 8c33510..1516e2b 100644
--- a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
@@ -47,6 +47,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/media/tda1997x.h>
+#include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/sound/fsl-imx-audmux.h>
 
 / {
@@ -63,6 +64,53 @@
 		bootargs = "console=ttymxc1,115200";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		user-pb {
+			label = "user_pb";
+			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_0>;
+		};
+
+		user-pb1x {
+			label = "user_pb1x";
+			linux,code = <BTN_1>;
+			interrupt-parent = <&gsc>;
+			interrupts = <0>;
+		};
+
+		key-erased {
+			label = "key-erased";
+			linux,code = <BTN_2>;
+			interrupt-parent = <&gsc>;
+			interrupts = <1>;
+		};
+
+		eeprom-wp {
+			label = "eeprom_wp";
+			linux,code = <BTN_3>;
+			interrupt-parent = <&gsc>;
+			interrupts = <2>;
+		};
+
+		tamper {
+			label = "tamper";
+			linux,code = <BTN_4>;
+			interrupt-parent = <&gsc>;
+			interrupts = <5>;
+		};
+
+		switch-hold {
+			label = "switch_hold";
+			linux,code = <BTN_5>;
+			interrupt-parent = <&gsc>;
+			interrupts = <7>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -167,6 +215,97 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
+	gsc: gsc@20 {
+		compatible = "gw,gsc";
+		reg = <0x20>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		#size-cells = <0>;
+
+		adc {
+			compatible = "gw,gsc-adc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@0 {
+				gw,mode = <0>;
+				reg = <0x00>;
+				label = "temp";
+			};
+
+			channel@2 {
+				gw,mode = <1>;
+				reg = <0x02>;
+				label = "vdd_vin";
+			};
+
+			channel@5 {
+				gw,mode = <1>;
+				reg = <0x05>;
+				label = "vdd_3p3";
+			};
+
+			channel@8 {
+				gw,mode = <1>;
+				reg = <0x08>;
+				label = "vdd_bat";
+			};
+
+			channel@b {
+				gw,mode = <1>;
+				reg = <0x0b>;
+				label = "vdd_5p0";
+			};
+
+			channel@e {
+				gw,mode = <1>;
+				reg = <0xe>;
+				label = "vdd_arm";
+			};
+
+			channel@11 {
+				gw,mode = <1>;
+				reg = <0x11>;
+				label = "vdd_soc";
+			};
+
+			channel@14 {
+				gw,mode = <1>;
+				reg = <0x14>;
+				label = "vdd_3p0";
+			};
+
+			channel@17 {
+				gw,mode = <1>;
+				reg = <0x17>;
+				label = "vdd_1p5";
+			};
+
+			channel@1d {
+				gw,mode = <1>;
+				reg = <0x1d>;
+				label = "vdd_1p8a";
+			};
+
+			channel@20 {
+				gw,mode = <1>;
+				reg = <0x20>;
+				label = "vdd_1p0b";
+			};
+		};
+	};
+
+	gsc_gpio: gpio@23 {
+		compatible = "nxp,pca9555";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gsc>;
+		interrupts = <4>;
+	};
+
 	eeprom1: eeprom@50 {
 		compatible = "atmel,24c02";
 		reg = <0x50>;
@@ -191,13 +330,6 @@
 		pagesize = <16>;
 	};
 
-	gpio: pca9555@23 {
-		compatible = "nxp,pca9555";
-		reg = <0x23>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	rtc: ds1672@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
@@ -464,6 +596,7 @@
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
 			MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
+			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0xb0b1
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
index bb35971..0da6e6f 100644
--- a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -20,6 +21,53 @@
 		bootargs = "console=ttymxc1,115200";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		user-pb {
+			label = "user_pb";
+			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_0>;
+		};
+
+		user-pb1x {
+			label = "user_pb1x";
+			linux,code = <BTN_1>;
+			interrupt-parent = <&gsc>;
+			interrupts = <0>;
+		};
+
+		key-erased {
+			label = "key-erased";
+			linux,code = <BTN_2>;
+			interrupt-parent = <&gsc>;
+			interrupts = <1>;
+		};
+
+		eeprom-wp {
+			label = "eeprom_wp";
+			linux,code = <BTN_3>;
+			interrupt-parent = <&gsc>;
+			interrupts = <2>;
+		};
+
+		tamper {
+			label = "tamper";
+			linux,code = <BTN_4>;
+			interrupt-parent = <&gsc>;
+			interrupts = <5>;
+		};
+
+		switch-hold {
+			label = "switch_hold";
+			linux,code = <BTN_5>;
+			interrupt-parent = <&gsc>;
+			interrupts = <7>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -92,6 +140,103 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
+	gsc: gsc@20 {
+		compatible = "gw,gsc";
+		reg = <0x20>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		#size-cells = <0>;
+
+		adc {
+			compatible = "gw,gsc-adc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@0 {
+				gw,mode = <0>;
+				reg = <0x00>;
+				label = "temp";
+			};
+
+			channel@2 {
+				gw,mode = <1>;
+				reg = <0x02>;
+				label = "vdd_vin";
+			};
+
+			channel@5 {
+				gw,mode = <1>;
+				reg = <0x05>;
+				label = "vdd_3p3";
+			};
+
+			channel@8 {
+				gw,mode = <1>;
+				reg = <0x08>;
+				label = "vdd_bat";
+			};
+
+			channel@b {
+				gw,mode = <1>;
+				reg = <0x0b>;
+				label = "vdd_5p0";
+			};
+
+			channel@e {
+				gw,mode = <1>;
+				reg = <0xe>;
+				label = "vdd_arm";
+			};
+
+			channel@11 {
+				gw,mode = <1>;
+				reg = <0x11>;
+				label = "vdd_soc";
+			};
+
+			channel@14 {
+				gw,mode = <1>;
+				reg = <0x14>;
+				label = "vdd_3p0";
+			};
+
+			channel@17 {
+				gw,mode = <1>;
+				reg = <0x17>;
+				label = "vdd_1p5";
+			};
+
+			channel@1d {
+				gw,mode = <1>;
+				reg = <0x1d>;
+				label = "vdd_1p8";
+			};
+
+			channel@20 {
+				gw,mode = <1>;
+				reg = <0x20>;
+				label = "vdd_1p0";
+			};
+
+			channel@23 {
+				gw,mode = <1>;
+				reg = <0x23>;
+				label = "vdd_2p5";
+			};
+		};
+	};
+
+	gsc_gpio: gpio@23 {
+		compatible = "nxp,pca9555";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gsc>;
+		interrupts = <4>;
+	};
+
 	eeprom1: eeprom@50 {
 		compatible = "atmel,24c02";
 		reg = <0x50>;
@@ -116,13 +261,6 @@
 		pagesize = <16>;
 	};
 
-	gpio: pca9555@23 {
-		compatible = "nxp,pca9555";
-		reg = <0x23>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	rtc: ds1672@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
@@ -305,6 +443,7 @@
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
 			MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
+			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0xb0b1
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
index ee85031..db30de5 100644
--- a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
@@ -46,6 +46,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -61,6 +62,53 @@
 		stdout-path = &uart2;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		user-pb {
+			label = "user_pb";
+			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_0>;
+		};
+
+		user-pb1x {
+			label = "user_pb1x";
+			linux,code = <BTN_1>;
+			interrupt-parent = <&gsc>;
+			interrupts = <0>;
+		};
+
+		key-erased {
+			label = "key-erased";
+			linux,code = <BTN_2>;
+			interrupt-parent = <&gsc>;
+			interrupts = <1>;
+		};
+
+		eeprom-wp {
+			label = "eeprom_wp";
+			linux,code = <BTN_3>;
+			interrupt-parent = <&gsc>;
+			interrupts = <2>;
+		};
+
+		tamper {
+			label = "tamper";
+			linux,code = <BTN_4>;
+			interrupt-parent = <&gsc>;
+			interrupts = <5>;
+		};
+
+		switch-hold {
+			label = "switch_hold";
+			linux,code = <BTN_5>;
+			interrupt-parent = <&gsc>;
+			interrupts = <7>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -130,11 +178,101 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	gpio: pca9555@23 {
+	gsc: gsc@20 {
+		compatible = "gw,gsc";
+		reg = <0x20>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		#size-cells = <0>;
+
+		adc {
+			compatible = "gw,gsc-adc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@0 {
+				gw,mode = <0>;
+				reg = <0x00>;
+				label = "temp";
+			};
+
+			channel@2 {
+				gw,mode = <1>;
+				reg = <0x02>;
+				label = "vdd_vin";
+			};
+
+			channel@5 {
+				gw,mode = <1>;
+				reg = <0x05>;
+				label = "vdd_3p3";
+			};
+
+			channel@8 {
+				gw,mode = <1>;
+				reg = <0x08>;
+				label = "vdd_bat";
+			};
+
+			channel@b {
+				gw,mode = <1>;
+				reg = <0x0b>;
+				label = "vdd_5p0";
+			};
+
+			channel@e {
+				gw,mode = <1>;
+				reg = <0xe>;
+				label = "vdd_arm";
+			};
+
+			channel@11 {
+				gw,mode = <1>;
+				reg = <0x11>;
+				label = "vdd_soc";
+			};
+
+			channel@14 {
+				gw,mode = <1>;
+				reg = <0x14>;
+				label = "vdd_3p0";
+			};
+
+			channel@17 {
+				gw,mode = <1>;
+				reg = <0x17>;
+				label = "vdd_1p5";
+			};
+
+			channel@1d {
+				gw,mode = <1>;
+				reg = <0x1d>;
+				label = "vdd_1p8a";
+			};
+
+			channel@20 {
+				gw,mode = <1>;
+				reg = <0x20>;
+				label = "vdd_1p0b";
+			};
+
+			channel@26 {
+				gw,mode = <1>;
+				reg = <0x26>;
+				label = "vdd_an1";
+			};
+		};
+	};
+
+	gsc_gpio: gpio@23 {
 		compatible = "nxp,pca9555";
 		reg = <0x23>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupt-parent = <&gsc>;
+		interrupts = <4>;
 	};
 
 	eeprom1: eeprom@50 {
@@ -428,6 +566,7 @@
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
 			MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
+			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0xb0b1
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi b/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
index 69ca70d..940520f 100644
--- a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
@@ -88,6 +88,53 @@
 		default-on;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		user-pb {
+			label = "user_pb";
+			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_0>;
+		};
+
+		user-pb1x {
+			label = "user_pb1x";
+			linux,code = <BTN_1>;
+			interrupt-parent = <&gsc>;
+			interrupts = <0>;
+		};
+
+		key-erased {
+			label = "key-erased";
+			linux,code = <BTN_2>;
+			interrupt-parent = <&gsc>;
+			interrupts = <1>;
+		};
+
+		eeprom-wp {
+			label = "eeprom_wp";
+			linux,code = <BTN_3>;
+			interrupt-parent = <&gsc>;
+			interrupts = <2>;
+		};
+
+		tamper {
+			label = "tamper";
+			linux,code = <BTN_4>;
+			interrupt-parent = <&gsc>;
+			interrupts = <5>;
+		};
+
+		switch-hold {
+			label = "switch_hold";
+			linux,code = <BTN_5>;
+			interrupt-parent = <&gsc>;
+			interrupts = <7>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -243,6 +290,115 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
+	gsc: gsc@20 {
+		compatible = "gw,gsc";
+		reg = <0x20>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		#size-cells = <0>;
+
+		adc {
+			compatible = "gw,gsc-adc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@0 {
+				gw,mode = <0>;
+				reg = <0x00>;
+				label = "temp";
+			};
+
+			channel@2 {
+				gw,mode = <1>;
+				reg = <0x02>;
+				label = "vdd_vin";
+			};
+
+			channel@5 {
+				gw,mode = <1>;
+				reg = <0x05>;
+				label = "vdd_3p3";
+			};
+
+			channel@8 {
+				gw,mode = <1>;
+				reg = <0x08>;
+				label = "vdd_bat";
+			};
+
+			channel@b {
+				gw,mode = <1>;
+				reg = <0x0b>;
+				label = "vdd_5p0";
+			};
+
+			channel@e {
+				gw,mode = <1>;
+				reg = <0xe>;
+				label = "vdd_arm";
+			};
+
+			channel@11 {
+				gw,mode = <1>;
+				reg = <0x11>;
+				label = "vdd_soc";
+			};
+
+			channel@14 {
+				gw,mode = <1>;
+				reg = <0x14>;
+				label = "vdd_3p0";
+			};
+
+			channel@17 {
+				gw,mode = <1>;
+				reg = <0x17>;
+				label = "vdd_1p5";
+			};
+
+			channel@1d {
+				gw,mode = <1>;
+				reg = <0x1d>;
+				label = "vdd_1p8";
+			};
+
+			channel@20 {
+				gw,mode = <1>;
+				reg = <0x20>;
+				label = "vdd_an1";
+			};
+
+			channel@23 {
+				gw,mode = <1>;
+				reg = <0x23>;
+				label = "vdd_2p5";
+			};
+
+			channel@26 {
+				gw,mode = <1>;
+				reg = <0x26>;
+				label = "vdd_gps";
+			};
+
+			channel@29 {
+				gw,mode = <1>;
+				reg = <0x29>;
+				label = "vdd_an2";
+			};
+		};
+	};
+
+	gsc_gpio: gpio@23 {
+		compatible = "nxp,pca9555";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gsc>;
+		interrupts = <4>;
+	};
+
 	eeprom1: eeprom@50 {
 		compatible = "atmel,24c02";
 		reg = <0x50>;
@@ -267,13 +423,6 @@
 		pagesize = <16>;
 	};
 
-	pca9555: gpio@23 {
-		compatible = "nxp,pca9555";
-		reg = <0x23>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	ds1672: rtc@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
@@ -608,6 +757,7 @@
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
 			MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
+			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0xb0b1
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
index aee9221..0461085 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
@@ -46,6 +46,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
 
 / {
 	chosen {
@@ -71,6 +72,53 @@
 		default-brightness-level = <100>;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		user-pb {
+			label = "user_pb";
+			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_0>;
+		};
+
+		user-pb1x {
+			label = "user_pb1x";
+			linux,code = <BTN_1>;
+			interrupt-parent = <&gsc>;
+			interrupts = <0>;
+		};
+
+		key-erased {
+			label = "key-erased";
+			linux,code = <BTN_2>;
+			interrupt-parent = <&gsc>;
+			interrupts = <1>;
+		};
+
+		eeprom-wp {
+			label = "eeprom_wp";
+			linux,code = <BTN_3>;
+			interrupt-parent = <&gsc>;
+			interrupts = <2>;
+		};
+
+		tamper {
+			label = "tamper";
+			linux,code = <BTN_4>;
+			interrupt-parent = <&gsc>;
+			interrupts = <5>;
+		};
+
+		switch-hold {
+			label = "switch_hold";
+			linux,code = <BTN_5>;
+			interrupt-parent = <&gsc>;
+			interrupts = <7>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -183,11 +231,101 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	pca9555: gpio@23 {
+	gsc: gsc@20 {
+		compatible = "gw,gsc";
+		reg = <0x20>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		#size-cells = <0>;
+
+		adc {
+			compatible = "gw,gsc-adc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@0 {
+				gw,mode = <0>;
+				reg = <0x00>;
+				label = "temp";
+			};
+
+			channel@2 {
+				gw,mode = <1>;
+				reg = <0x02>;
+				label = "vdd_vin";
+			};
+
+			channel@5 {
+				gw,mode = <1>;
+				reg = <0x05>;
+				label = "vdd_3p3";
+			};
+
+			channel@8 {
+				gw,mode = <1>;
+				reg = <0x08>;
+				label = "vdd_bat";
+			};
+
+			channel@b {
+				gw,mode = <1>;
+				reg = <0x0b>;
+				label = "vdd_5p0";
+			};
+
+			channel@e {
+				gw,mode = <1>;
+				reg = <0xe>;
+				label = "vdd_arm";
+			};
+
+			channel@11 {
+				gw,mode = <1>;
+				reg = <0x11>;
+				label = "vdd_soc";
+			};
+
+			channel@14 {
+				gw,mode = <1>;
+				reg = <0x14>;
+				label = "vdd_3p0";
+			};
+
+			channel@17 {
+				gw,mode = <1>;
+				reg = <0x17>;
+				label = "vdd_1p5";
+			};
+
+			channel@1d {
+				gw,mode = <1>;
+				reg = <0x1d>;
+				label = "vdd_1p8";
+			};
+
+			channel@20 {
+				gw,mode = <1>;
+				reg = <0x20>;
+				label = "vdd_an1";
+			};
+
+			channel@23 {
+				gw,mode = <1>;
+				reg = <0x23>;
+				label = "vdd_2p5";
+			};
+		};
+	};
+
+	gsc_gpio: gpio@23 {
 		compatible = "nxp,pca9555";
 		reg = <0x23>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupt-parent = <&gsc>;
+		interrupts = <4>;
 	};
 
 	eeprom1: eeprom@50 {
diff --git a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
index 76d6cf5..e73090f 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
@@ -46,6 +46,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -68,6 +69,53 @@
 		default-brightness-level = <7>;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		user-pb {
+			label = "user_pb";
+			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_0>;
+		};
+
+		user-pb1x {
+			label = "user_pb1x";
+			linux,code = <BTN_1>;
+			interrupt-parent = <&gsc>;
+			interrupts = <0>;
+		};
+
+		key-erased {
+			label = "key-erased";
+			linux,code = <BTN_2>;
+			interrupt-parent = <&gsc>;
+			interrupts = <1>;
+		};
+
+		eeprom-wp {
+			label = "eeprom_wp";
+			linux,code = <BTN_3>;
+			interrupt-parent = <&gsc>;
+			interrupts = <2>;
+		};
+
+		tamper {
+			label = "tamper";
+			linux,code = <BTN_4>;
+			interrupt-parent = <&gsc>;
+			interrupts = <5>;
+		};
+
+		switch-hold {
+			label = "switch_hold";
+			linux,code = <BTN_5>;
+			interrupt-parent = <&gsc>;
+			interrupts = <7>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -205,11 +253,101 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	pca9555: gpio@23 {
+	gsc: gsc@20 {
+		compatible = "gw,gsc";
+		reg = <0x20>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		#size-cells = <0>;
+
+		adc {
+			compatible = "gw,gsc-adc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@0 {
+				gw,mode = <0>;
+				reg = <0x00>;
+				label = "temp";
+			};
+
+			channel@2 {
+				gw,mode = <1>;
+				reg = <0x02>;
+				label = "vdd_vin";
+			};
+
+			channel@5 {
+				gw,mode = <1>;
+				reg = <0x05>;
+				label = "vdd_3p3";
+			};
+
+			channel@8 {
+				gw,mode = <1>;
+				reg = <0x08>;
+				label = "vdd_bat";
+			};
+
+			channel@b {
+				gw,mode = <1>;
+				reg = <0x0b>;
+				label = "vdd_5p0";
+			};
+
+			channel@e {
+				gw,mode = <1>;
+				reg = <0xe>;
+				label = "vdd_arm";
+			};
+
+			channel@11 {
+				gw,mode = <1>;
+				reg = <0x11>;
+				label = "vdd_soc";
+			};
+
+			channel@14 {
+				gw,mode = <1>;
+				reg = <0x14>;
+				label = "vdd_3p0";
+			};
+
+			channel@17 {
+				gw,mode = <1>;
+				reg = <0x17>;
+				label = "vdd_1p5";
+			};
+
+			channel@1d {
+				gw,mode = <1>;
+				reg = <0x1d>;
+				label = "vdd_1p8";
+			};
+
+			channel@20 {
+				gw,mode = <1>;
+				reg = <0x20>;
+				label = "vdd_an1";
+			};
+
+			channel@23 {
+				gw,mode = <1>;
+				reg = <0x23>;
+				label = "vdd_2p5";
+			};
+		};
+	};
+
+	gsc_gpio: gpio@23 {
 		compatible = "nxp,pca9555";
 		reg = <0x23>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupt-parent = <&gsc>;
+		interrupts = <4>;
 	};
 
 	eeprom1: eeprom@50 {
@@ -503,6 +641,7 @@
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
 			MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
+			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x0001b0b0 /* GSC_IRQ# */
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw5907.dtsi b/arch/arm/boot/dts/imx6qdl-gw5907.dtsi
index 0bdebdd..b1ff7c8 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5907.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5907.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -19,6 +20,53 @@
 		stdout-path = &uart2;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		user-pb {
+			label = "user_pb";
+			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_0>;
+		};
+
+		user-pb1x {
+			label = "user_pb1x";
+			linux,code = <BTN_1>;
+			interrupt-parent = <&gsc>;
+			interrupts = <0>;
+		};
+
+		key-erased {
+			label = "key-erased";
+			linux,code = <BTN_2>;
+			interrupt-parent = <&gsc>;
+			interrupts = <1>;
+		};
+
+		eeprom-wp {
+			label = "eeprom_wp";
+			linux,code = <BTN_3>;
+			interrupt-parent = <&gsc>;
+			interrupts = <2>;
+		};
+
+		tamper {
+			label = "tamper";
+			linux,code = <BTN_4>;
+			interrupt-parent = <&gsc>;
+			interrupts = <5>;
+		};
+
+		switch-hold {
+			label = "switch_hold";
+			linux,code = <BTN_5>;
+			interrupt-parent = <&gsc>;
+			interrupts = <7>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -102,11 +150,101 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	gpio@23 {
+	gsc: gsc@20 {
+		compatible = "gw,gsc";
+		reg = <0x20>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		#size-cells = <0>;
+
+		adc {
+			compatible = "gw,gsc-adc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@0 {
+				gw,mode = <0>;
+				reg = <0x00>;
+				label = "temp";
+			};
+
+			channel@2 {
+				gw,mode = <1>;
+				reg = <0x02>;
+				label = "vdd_vin";
+			};
+
+			channel@5 {
+				gw,mode = <1>;
+				reg = <0x05>;
+				label = "vdd_3p3";
+			};
+
+			channel@8 {
+				gw,mode = <1>;
+				reg = <0x08>;
+				label = "vdd_bat";
+			};
+
+			channel@b {
+				gw,mode = <1>;
+				reg = <0x0b>;
+				label = "vdd_5p0";
+			};
+
+			channel@e {
+				gw,mode = <1>;
+				reg = <0xe>;
+				label = "vdd_arm";
+			};
+
+			channel@11 {
+				gw,mode = <1>;
+				reg = <0x11>;
+				label = "vdd_soc";
+			};
+
+			channel@14 {
+				gw,mode = <1>;
+				reg = <0x14>;
+				label = "vdd_3p0";
+			};
+
+			channel@17 {
+				gw,mode = <1>;
+				reg = <0x17>;
+				label = "vdd_1p5";
+			};
+
+			channel@1d {
+				gw,mode = <1>;
+				reg = <0x1d>;
+				label = "vdd_1p8";
+			};
+
+			channel@20 {
+				gw,mode = <1>;
+				reg = <0x20>;
+				label = "vdd_an1";
+			};
+
+			channel@23 {
+				gw,mode = <1>;
+				reg = <0x23>;
+				label = "vdd_2p5";
+			};
+		};
+	};
+
+	gsc_gpio: gpio@23 {
 		compatible = "nxp,pca9555";
 		reg = <0x23>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupt-parent = <&gsc>;
+		interrupts = <4>;
 	};
 
 	eeprom@50 {
@@ -133,7 +271,7 @@
 		pagesize = <16>;
 	};
 
-	rtc@68 {
+	ds1672@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-gw5910.dtsi b/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
index 0857de5..11f84ee 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -22,6 +23,53 @@
 		reg = <0x10000000 0x20000000>;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		user-pb {
+			label = "user_pb";
+			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_0>;
+		};
+
+		user-pb1x {
+			label = "user_pb1x";
+			linux,code = <BTN_1>;
+			interrupt-parent = <&gsc>;
+			interrupts = <0>;
+		};
+
+		key-erased {
+			label = "key-erased";
+			linux,code = <BTN_2>;
+			interrupt-parent = <&gsc>;
+			interrupts = <1>;
+		};
+
+		eeprom-wp {
+			label = "eeprom_wp";
+			linux,code = <BTN_3>;
+			interrupt-parent = <&gsc>;
+			interrupts = <2>;
+		};
+
+		tamper {
+			label = "tamper";
+			linux,code = <BTN_4>;
+			interrupt-parent = <&gsc>;
+			interrupts = <5>;
+		};
+
+		switch-hold {
+			label = "switch_hold";
+			linux,code = <BTN_5>;
+			interrupt-parent = <&gsc>;
+			interrupts = <7>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -111,11 +159,121 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	gpio@23 {
+	gsc: gsc@20 {
+		compatible = "gw,gsc";
+		reg = <0x20>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		#size-cells = <0>;
+
+		adc {
+			compatible = "gw,gsc-adc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@6 {
+				gw,mode = <0>;
+				reg = <0x06>;
+				label = "temp";
+			};
+
+			channel@8 {
+				gw,mode = <3>;
+				reg = <0x08>;
+				label = "vdd_bat";
+			};
+
+			channel@82 {
+				gw,mode = <2>;
+				reg = <0x82>;
+				label = "vdd_vin";
+				gw,voltage-divider-ohms = <22100 1000>;
+				gw,voltage-offset-microvolt = <800000>;
+			};
+
+			channel@84 {
+				gw,mode = <2>;
+				reg = <0x84>;
+				label = "vdd_5p0";
+				gw,voltage-divider-ohms = <22100 10000>;
+			};
+
+			channel@86 {
+				gw,mode = <2>;
+				reg = <0x86>;
+				label = "vdd_3p3";
+				gw,voltage-divider-ohms = <10000 10000>;
+			};
+
+			channel@88 {
+				gw,mode = <2>;
+				reg = <0x88>;
+				label = "vdd_2p5";
+				gw,voltage-divider-ohms = <10000 10000>;
+			};
+
+			channel@8c {
+				gw,mode = <2>;
+				reg = <0x8c>;
+				label = "vdd_3p0";
+			};
+
+			channel@8e {
+				gw,mode = <2>;
+				reg = <0x8e>;
+				label = "vdd_arm";
+			};
+
+			channel@90 {
+				gw,mode = <2>;
+				reg = <0x90>;
+				label = "vdd_soc";
+			};
+
+			channel@92 {
+				gw,mode = <2>;
+				reg = <0x92>;
+				label = "vdd_1p5";
+			};
+
+			channel@98 {
+				gw,mode = <2>;
+				reg = <0x98>;
+				label = "vdd_1p8";
+			};
+
+			channel@9a {
+				gw,mode = <2>;
+				reg = <0x9a>;
+				label = "vdd_1p0";
+				gw,voltage-divider-ohms = <10000 10000>;
+			};
+
+			channel@9c {
+				gw,mode = <2>;
+				reg = <0x9c>;
+				label = "vdd_an1";
+				gw,voltage-divider-ohms = <10000 10000>;
+			};
+
+			channel@a2 {
+				gw,mode = <2>;
+				reg = <0xa2>;
+				label = "vdd_gsc";
+				gw,voltage-divider-ohms = <10000 10000>;
+			};
+		};
+	};
+
+	gsc_gpio: gpio@23 {
 		compatible = "nxp,pca9555";
 		reg = <0x23>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupt-parent = <&gsc>;
+		interrupts = <4>;
 	};
 
 	eeprom@50 {
diff --git a/arch/arm/boot/dts/imx6qdl-gw5912.dtsi b/arch/arm/boot/dts/imx6qdl-gw5912.dtsi
index 8c57fd2..0a1ffff 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5912.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5912.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -20,6 +21,53 @@
 		stdout-path = &uart2;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		user-pb {
+			label = "user_pb";
+			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_0>;
+		};
+
+		user-pb1x {
+			label = "user_pb1x";
+			linux,code = <BTN_1>;
+			interrupt-parent = <&gsc>;
+			interrupts = <0>;
+		};
+
+		key-erased {
+			label = "key-erased";
+			linux,code = <BTN_2>;
+			interrupt-parent = <&gsc>;
+			interrupts = <1>;
+		};
+
+		eeprom-wp {
+			label = "eeprom_wp";
+			linux,code = <BTN_3>;
+			interrupt-parent = <&gsc>;
+			interrupts = <2>;
+		};
+
+		tamper {
+			label = "tamper";
+			linux,code = <BTN_4>;
+			interrupt-parent = <&gsc>;
+			interrupts = <5>;
+		};
+
+		switch-hold {
+			label = "switch_hold";
+			linux,code = <BTN_5>;
+			interrupt-parent = <&gsc>;
+			interrupts = <7>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -106,11 +154,109 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	gpio@23 {
+	gsc: gsc@20 {
+		compatible = "gw,gsc";
+		reg = <0x20>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		adc {
+			compatible = "gw,gsc-adc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@0 {
+				gw,mode = <0>;
+				reg = <0x00>;
+				label = "temp";
+			};
+
+			channel@2 {
+				gw,mode = <1>;
+				reg = <0x02>;
+				label = "vdd_vin";
+			};
+
+			channel@5 {
+				gw,mode = <1>;
+				reg = <0x05>;
+				label = "vdd_3p3";
+			};
+
+			channel@8 {
+				gw,mode = <1>;
+				reg = <0x08>;
+				label = "vdd_bat";
+			};
+
+			channel@b {
+				gw,mode = <1>;
+				reg = <0x0b>;
+				label = "vdd_5p0";
+			};
+
+			channel@e {
+				gw,mode = <1>;
+				reg = <0xe>;
+				label = "vdd_arm";
+			};
+
+			channel@11 {
+				gw,mode = <1>;
+				reg = <0x11>;
+				label = "vdd_soc";
+			};
+
+			channel@14 {
+				gw,mode = <1>;
+				reg = <0x14>;
+				label = "vdd_3p0";
+			};
+
+			channel@17 {
+				gw,mode = <1>;
+				reg = <0x17>;
+				label = "vdd_1p5";
+			};
+
+			channel@1d {
+				gw,mode = <1>;
+				reg = <0x1d>;
+				label = "vdd_1p8";
+			};
+
+			channel@20 {
+				gw,mode = <1>;
+				reg = <0x20>;
+				label = "vdd_1p0";
+			};
+
+			channel@23 {
+				gw,mode = <1>;
+				reg = <0x23>;
+				label = "vdd_2p5";
+			};
+		};
+
+		fan-controller@a {
+			compatible = "gw,gsc-fan";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0a>;
+		};
+	};
+
+	gsc_gpio: gpio@23 {
 		compatible = "nxp,pca9555";
 		reg = <0x23>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupt-parent = <&gsc>;
+		interrupts = <4>;
 	};
 
 	eeprom@50 {
diff --git a/arch/arm/boot/dts/imx6qdl-gw5913.dtsi b/arch/arm/boot/dts/imx6qdl-gw5913.dtsi
index 635c203..d62a8da 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5913.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5913.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -19,6 +20,53 @@
 		stdout-path = &uart2;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		user-pb {
+			label = "user_pb";
+			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_0>;
+		};
+
+		user-pb1x {
+			label = "user_pb1x";
+			linux,code = <BTN_1>;
+			interrupt-parent = <&gsc>;
+			interrupts = <0>;
+		};
+
+		key-erased {
+			label = "key-erased";
+			linux,code = <BTN_2>;
+			interrupt-parent = <&gsc>;
+			interrupts = <1>;
+		};
+
+		eeprom-wp {
+			label = "eeprom_wp";
+			linux,code = <BTN_3>;
+			interrupt-parent = <&gsc>;
+			interrupts = <2>;
+		};
+
+		tamper {
+			label = "tamper";
+			linux,code = <BTN_4>;
+			interrupt-parent = <&gsc>;
+			interrupts = <5>;
+		};
+
+		switch-hold {
+			label = "switch_hold";
+			linux,code = <BTN_5>;
+			interrupt-parent = <&gsc>;
+			interrupts = <7>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -87,11 +135,114 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	gpio@23 {
+	gsc: gsc@20 {
+		compatible = "gw,gsc";
+		reg = <0x20>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		#size-cells = <0>;
+
+		adc {
+			compatible = "gw,gsc-adc";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@6 {
+				gw,mode = <0>;
+				reg = <0x06>;
+				label = "temp";
+			};
+
+			channel@8 {
+				gw,mode = <3>;
+				reg = <0x08>;
+				label = "vdd_bat";
+			};
+
+			channel@82 {
+				gw,mode = <2>;
+				reg = <0x82>;
+				label = "vdd_vin";
+				gw,voltage-divider-ohms = <22100 1000>;
+				gw,voltage-offset-microvolt = <800000>;
+			};
+
+			channel@84 {
+				gw,mode = <2>;
+				reg = <0x84>;
+				label = "vdd_5p0";
+				gw,voltage-divider-ohms = <22100 10000>;
+			};
+
+			channel@86 {
+				gw,mode = <2>;
+				reg = <0x86>;
+				label = "vdd_3p3";
+				gw,voltage-divider-ohms = <10000 10000>;
+			};
+
+			channel@88 {
+				gw,mode = <2>;
+				reg = <0x88>;
+				label = "vdd_2p5";
+				gw,voltage-divider-ohms = <10000 10000>;
+			};
+
+			channel@8c {
+				gw,mode = <2>;
+				reg = <0x8c>;
+				label = "vdd_arm";
+			};
+
+			channel@8e {
+				gw,mode = <2>;
+				reg = <0x8e>;
+				label = "vdd_soc";
+			};
+
+			channel@90 {
+				gw,mode = <2>;
+				reg = <0x90>;
+				label = "vdd_1p5";
+			};
+
+			channel@92 {
+				gw,mode = <2>;
+				reg = <0x92>;
+				label = "vdd_1p0";
+			};
+
+			channel@98 {
+				gw,mode = <2>;
+				reg = <0x98>;
+				label = "vdd_3p0";
+			};
+
+			channel@9a {
+				gw,mode = <2>;
+				reg = <0x9a>;
+				label = "vdd_an1";
+				gw,voltage-divider-ohms = <10000 10000>;
+			};
+
+			channel@a2 {
+				gw,mode = <2>;
+				reg = <0xa2>;
+				label = "vdd_gsc";
+				gw,voltage-divider-ohms = <10000 10000>;
+			};
+		};
+	};
+
+	gsc_gpio: gpio@23 {
 		compatible = "nxp,pca9555";
 		reg = <0x23>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupt-parent = <&gsc>;
+		interrupts = <4>;
 	};
 
 	eeprom@50 {
-- 
2.7.4

