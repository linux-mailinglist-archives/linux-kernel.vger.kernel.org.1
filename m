Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AD5245CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 09:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgHQHCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 03:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbgHQHBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:01:38 -0400
Received: from localhost.localdomain (unknown [194.230.155.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBEC420829;
        Mon, 17 Aug 2020 07:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597647697;
        bh=sWr5BlRQl6s3o7d2mLErnXOGBfnTByTMDXgwOW4m/5U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mDpEUXkE8mY29H67MXCsKFFAkXuGpfyfh8Qh1vJaNxqU8KxiINQemgyRmT9kYDqXI
         s8pbs2zNqGEdjg3dImlKJCIsZspSkp0O7D81MLqLvmxfdCjIioymgTUypiFocT3FLB
         /BfMDBNijOA1Xms6bkItm3PA8Urt4c8l28Fp6Hpc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/4] arm64: dts: imx8mm-var-som-symphony: Add Variscite Symphony board with VAR-SOM-MX8MM
Date:   Mon, 17 Aug 2020 09:01:20 +0200
Message-Id: <20200817070120.4937-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817070120.4937-1-krzk@kernel.org>
References: <20200817070120.4937-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DTS for Variscite Symphony evaluation kit with VAR-SOM-MX8MM
System on Module.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Remove duplicated "leds" node,
2. Fix heartbeat to active low,
3. Add nxp,ptn5150 extcon.
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mm-var-som-symphony.dts | 248 ++++++++++++++++++
 2 files changed, 249 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index a39f0a1723e0..dcfb8750cd78 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -29,6 +29,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
new file mode 100644
index 000000000000..2d3c30ac5e04
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2020 Krzysztof Kozlowski <krzk@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "imx8mm-var-som.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-MX8MM Symphony evaluation board";
+	compatible = "variscite,var-som-mx8mm-symphony", "variscite,var-som-mx8mm", "fsl,imx8mm";
+
+	reg_usdhc2_vmmc: regulator-1 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usb_otg2_vbus: regulator-2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usb_otg2_vbus>;
+		regulator-name = "usb_otg2_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		back {
+			label = "Back";
+			gpios = <&pca9534 1 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_BACK>;
+		};
+
+		home {
+			label = "Home";
+			gpios = <&pca9534 2 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOME>;
+		};
+
+		menu {
+			label = "Menu";
+			gpios = <&pca9534 3 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_MENU>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		heartbeat {
+			label = "Heartbeat";
+			gpios = <&pca9534 0 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&ethphy {
+	reset-gpios = <&pca9534 5 GPIO_ACTIVE_HIGH>;
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	pca9534: gpio@20 {
+		compatible = "nxp,pca9534";
+		reg = <0x20>;
+		gpio-controller;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pca9534>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+		#gpio-cells = <2>;
+		wakeup-source;
+
+		/* USB 3.0 OTG (usbotg1) / SATA port switch, set to USB 3.0 */
+		usb3-sata-sel-hog {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "usb3_sata_sel";
+		};
+
+		som-vselect-hog {
+			gpio-hog;
+			gpios = <6 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "som_vselect";
+		};
+
+		enet-sel-hog {
+			gpio-hog;
+			gpios = <7 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "enet_sel";
+		};
+	};
+
+	extcon_usbotg1: typec@3d {
+		compatible = "nxp,ptn5150";
+		reg = <0x3d>;
+		int-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ptn5150>;
+		status = "okay";
+	};
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	/* Capacitive touch controller */
+	ft5x06_ts: touchscreen@38 {
+		compatible = "edt,edt-ft5406";
+		reg = <0x38>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_captouch>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <4 GPIO_ACTIVE_HIGH>;
+
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
+
+	rtc@68 {
+		compatible = "dallas,ds1337";
+		reg = <0x68>;
+		wakeup-source;
+	};
+};
+
+/* Header */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+/* Header */
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
+
+&usbotg1 {
+	disable-over-current;
+	extcon = <&extcon_usbotg1>, <&extcon_usbotg1>;
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	vbus-supply = <&reg_usb_otg2_vbus>;
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	disable-over-current;
+	/delete-property/ usb-role-switch;
+	/*
+	 * FIXME: having USB2 enabled hangs the boot just after:
+	 * [    1.943365] ci_hdrc ci_hdrc.1: EHCI Host Controller
+	 * [    1.948287] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 1
+	 * [    1.971006] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
+	 * [    1.977203] hub 1-0:1.0: USB hub found
+	 * [    1.980987] hub 1-0:1.0: 1 port detected
+	 */
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+
+	pinctrl_captouch: captouchgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_RX_GPIO5_IO4		0x16
+		>;
+	};
+
+	pinctrl_gpio_led: gpioledgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16	0x19
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
+			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_pca9534: pca9534grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7	0x16
+		>;
+	};
+
+	pinctrl_ptn5150: ptn5150grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11	0x16
+		>;
+	};
+
+	pinctrl_reg_usb_otg2_vbus: regusbotg2vbusgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI3_TXD_GPIO5_IO1		0x16
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART1_RXD_UART1_DCE_RX	0x140
+			MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX	0x140
+			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX	0x140
+		>;
+	};
+};
-- 
2.17.1

