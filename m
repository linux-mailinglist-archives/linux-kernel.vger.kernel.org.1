Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A503276806
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 06:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgIXE5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 00:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgIXE5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 00:57:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775E8C0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 21:57:19 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kLJJd-0000c5-BJ; Thu, 24 Sep 2020 06:57:09 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kLJJd-000689-0x; Thu, 24 Sep 2020 06:57:09 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: [PATCH v2 2/2] ARM: dts: add Protonic WD3 board
Date:   Thu, 24 Sep 2020 06:57:06 +0200
Message-Id: <20200924045706.23496-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924045706.23496-1-o.rempel@pengutronix.de>
References: <20200924045706.23496-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Protonic WD3 is a proof of concept platform for tractor e-cockpit applications

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/Makefile          |   1 +
 arch/arm/boot/dts/imx6qp-prtwd3.dts | 553 ++++++++++++++++++++++++++++
 2 files changed, 554 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6qp-prtwd3.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0730cbfe13db..2355b43a0f4b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -578,6 +578,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6qp-nitrogen6_max.dtb \
 	imx6qp-nitrogen6_som2.dtb \
 	imx6qp-phytec-mira-rdk-nand.dtb \
+	imx6qp-prtwd3.dtb \
 	imx6qp-sabreauto.dtb \
 	imx6qp-sabresd.dtb \
 	imx6qp-tx6qp-8037.dtb \
diff --git a/arch/arm/boot/dts/imx6qp-prtwd3.dts b/arch/arm/boot/dts/imx6qp-prtwd3.dts
new file mode 100644
index 000000000000..1957d5686dee
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qp-prtwd3.dts
@@ -0,0 +1,553 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2018 Protonic Holland
+ */
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include "imx6qp.dtsi"
+
+/ {
+	model = "Protonic WD3 board";
+	compatible = "prt,prtwd3", "fsl,imx6qp";
+
+	chosen {
+		stdout-path = &uart4;
+	};
+
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0x20000000>;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	clock_ksz8081: clock-ksz8081 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+	};
+
+	clock_ksz9031: clock-ksz9031 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
+	clock_mcp25xx: clock-mcp25xx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <20000000>;
+	};
+
+	clock_sja1105: clock-sja1105 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
+	mdio {
+		compatible = "virtual,mdio-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_mdio>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpios = <&gpio5 6 GPIO_ACTIVE_HIGH
+			 &gpio5 7 GPIO_ACTIVE_HIGH>;
+
+		/* Microchip KSZ8081 */
+		usbeth_phy: ethernet-phy@3 {
+			reg = <0x3>;
+
+			interrupts-extended = <&gpio5 12 IRQ_TYPE_LEVEL_LOW>;
+			reset-gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <500>;
+			reset-deassert-us = <1000>;
+			clocks = <&clock_ksz8081>;
+			clock-names = "rmii-ref";
+			micrel,led-mode = <0>;
+		};
+
+		tja1102_phy0: ethernet-phy@4 {
+			compatible = "ethernet-phy-id0180.dc80";
+			reg = <0x4>;
+
+			interrupts-extended = <&gpio5 8 IRQ_TYPE_LEVEL_LOW>;
+			reset-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <20>;
+			reset-deassert-us = <2000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			tja1102_phy1: ethernet-phy@5 {
+				reg = <0x5>;
+
+				interrupts-extended = <&gpio5 8 IRQ_TYPE_LEVEL_LOW>;
+			};
+		};
+	};
+
+	reg_5v0: regulator-5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_otg_vbus: regulator-otg-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "otg-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	usdhc2_wifi_pwrseq: usdhc2-wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wifi_npd>;
+		reset-gpios = <&gpio6 10 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1>;
+	xceiver-supply = <&reg_5v0>;
+	status = "okay";
+};
+
+&ecspi2 {
+	cs-gpios = <&gpio2 26 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	status = "okay";
+
+	switch@0 {
+		compatible = "nxp,sja1105q";
+		reg = <0>;
+		spi-max-frequency = <4000000>;
+		spi-rx-delay-us = <1>;
+		spi-tx-delay-us = <1>;
+		spi-cpha;
+
+		reset-gpios = <&gpio5 5 GPIO_ACTIVE_LOW>;
+
+		clocks = <&clock_sja1105>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				label = "usb";
+				phy-handle = <&usbeth_phy>;
+				phy-mode = "rmii";
+			};
+
+			port@1 {
+				reg = <1>;
+				label = "t1slave";
+				phy-handle = <&tja1102_phy1>;
+				phy-mode = "rmii";
+			};
+
+			port@2 {
+				reg = <2>;
+				label = "t1master";
+				phy-handle = <&tja1102_phy0>;
+				phy-mode = "rmii";
+
+			};
+
+			port@3 {
+				reg = <3>;
+				label = "rj45";
+				phy-handle = <&rgmii_phy>;
+				phy-mode = "rgmii-id";
+			};
+
+			port@4 {
+				reg = <4>;
+				label = "cpu";
+				ethernet = <&fec>;
+				phy-mode = "rgmii-id";
+
+				fixed-link {
+					speed = <100>;
+					full-duplex;
+				};
+			};
+		};
+	};
+};
+
+&ecspi3 {
+	cs-gpios = <&gpio4 24 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	status = "okay";
+
+	can@0 {
+		compatible = "microchip,mcp25xxfd";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_can2>;
+		reg = <0>;
+		clocks = <&clock_mcp25xx>;
+		spi-max-frequency = <5000000>;
+		interrupts-extended = <&gpio4 25 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	status = "okay";
+
+	phy-mode = "rgmii";
+
+	fixed-link {
+		speed = <100>;
+		full-duplex;
+	};
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* Microchip KSZ9031 */
+		rgmii_phy: ethernet-phy@2 {
+			reg = <2>;
+
+			interrupts-extended = <&gpio1 28 IRQ_TYPE_EDGE_FALLING>;
+			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <1000>;
+
+			clocks = <&clock_ksz9031>;
+		};
+	};
+};
+
+&gpio1 {
+	gpio-line-names =
+		"", "SD1_CD", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "PHY3_RESET", "", "", "PHY3_INT", "", "", "";
+};
+
+&gpio2 {
+	gpio-line-names =
+		"", "", "", "", "", "", "", "",
+		"REV_ID0", "REV_ID1", "REV_ID2", "REV_ID3", "BOARD_ID3",
+			"BOARD_ID0", "BOARD_ID1", "BOARD_ID2",
+		"", "", "", "", "", "", "", "",
+		"", "", "ECSPI2_SS0", "", "", "", "", "";
+};
+
+&gpio3 {
+	gpio-line-names =
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "USB_OTG_OC", "USB_OTG_PWR", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio4 {
+	gpio-line-names =
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "CAN1_SR", "CAN2_SR", "", "",
+		"", "", "", "", "", "", "", "",
+		"ECSPI3_SS0", "CANFD_INT", "USB_ETH_RESET", "", "", "", "", "";
+};
+
+&gpio5 {
+	gpio-line-names =
+		"", "", "", "", "", "SW_RESET", "", "",
+		"PHY12_INT", "PHY12_RESET", "PHY12_EN", "PHY0_RESET",
+			"PHY0_INT", "", "", "",
+		"", "", "DISP1_EN", "DISP1_LR", "DISP1_TS_IRQ", "LVDS1_PD",
+			"", "",
+		"", "LVDS1_INT", "", "", "DISP0_LR", "DISP0_TS_IRQ",
+			"DISP0_EN", "CAM_GPIO0";
+};
+
+&gpio6 {
+	gpio-line-names =
+		"LVDS0_INT", "LVDS0_PD", "CAM_INT", "CAM_GPIO1", "CAM_PD",
+			"CAM_LOCK", "", "POWER_TG",
+		"POWER_VSEL", "", "WLAN_REG_ON", "USB_ETH_CHG", "", "",
+			"USB_ETH_CHG_ID0", "USB_ETH_CHG_ID1",
+		"USB_ETH_CHG_ID2", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	/* additional i2c devices are added automatically by the boot loader */
+};
+
+&i2c3 {
+	adc@49 {
+		compatible = "ti,ads1015";
+		reg = <0x49>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* VIN */
+		channel@4 {
+			reg = <4>;
+			ti,gain = <1>;
+			ti,datarate = <3>;
+		};
+
+		/* VBUS */
+		channel@5 {
+			reg = <5>;
+			ti,gain = <1>;
+			ti,datarate = <3>;
+		};
+
+		/* ICHG */
+		channel@6 {
+			reg = <6>;
+			ti,gain = <1>;
+			ti,datarate = <3>;
+		};
+
+		channel@7 {
+			reg = <7>;
+			ti,gain = <1>;
+			ti,datarate = <3>;
+		};
+	};
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+&usbotg {
+	vbus-supply = <&reg_otg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	phy_type = "utmi";
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+&usbphynop1 {
+	status = "disabled";
+};
+
+&usbphynop2 {
+	status = "disabled";
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	cd-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+	no-1-8-v;
+	disable-wp;
+	cap-sd-highspeed;
+	no-mmc;
+	no-sdio;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	no-1-8-v;
+	non-removable;
+	mmc-pwrseq = <&usdhc2_wifi_pwrseq>;
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	brcmf: bcrmf@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	bus-width = <8>;
+	no-1-8-v;
+	non-removable;
+	no-sd;
+	no-sdio;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_can1: can1grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX		0x1b000
+			MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX		0x3008
+			/* CAN1_SR */
+			MX6QDL_PAD_KEY_COL3__GPIO4_IO12			0x13008
+		>;
+	};
+
+	pinctrl_can2: can2grp {
+		fsl,pins = <
+			/* CAN2_nINT */
+			MX6QDL_PAD_DISP0_DAT4__GPIO4_IO25		0x1b0b1
+			/* CAN2_SR */
+			MX6QDL_PAD_KEY_ROW3__GPIO4_IO13			0x13070
+		>;
+	};
+
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_OE__ECSPI2_MISO			0x100b1
+			MX6QDL_PAD_EIM_CS0__ECSPI2_SCLK			0x100b1
+			MX6QDL_PAD_EIM_CS1__ECSPI2_MOSI			0x100b1
+			MX6QDL_PAD_EIM_RW__GPIO2_IO26			0x000b1
+		>;
+	};
+
+	pinctrl_ecspi3: ecspi3grp {
+		fsl,pins = <
+			MX6QDL_PAD_DISP0_DAT0__ECSPI3_SCLK		0x100b1
+			MX6QDL_PAD_DISP0_DAT1__ECSPI3_MOSI		0x100b1
+			MX6QDL_PAD_DISP0_DAT2__ECSPI3_MISO		0x100b1
+			/* CS */
+			MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24		0x000b1
+		>;
+	};
+
+	pinctrl_enet: enetgrp {
+		fsl,pins = <
+			MX6QDL_PAD_RGMII_RXC__RGMII_RXC			0x1b030
+			MX6QDL_PAD_RGMII_RD0__RGMII_RD0			0x1b030
+			MX6QDL_PAD_RGMII_RD1__RGMII_RD1			0x1b030
+			MX6QDL_PAD_RGMII_RD2__RGMII_RD2			0x1b030
+			MX6QDL_PAD_RGMII_RD3__RGMII_RD3			0x1b030
+			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL		0x1b030
+			MX6QDL_PAD_RGMII_TXC__RGMII_TXC			0x10030
+			MX6QDL_PAD_RGMII_TD0__RGMII_TD0			0x10030
+			MX6QDL_PAD_RGMII_TD1__RGMII_TD1			0x10030
+			MX6QDL_PAD_RGMII_TD2__RGMII_TD2			0x10030
+			MX6QDL_PAD_RGMII_TD3__RGMII_TD3			0x10030
+			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL		0x10030
+
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO			0x10030
+			MX6QDL_PAD_ENET_MDC__ENET_MDC			0x10030
+
+			/* Configure clock provider for RGMII ref clock */
+			MX6QDL_PAD_GPIO_16__ENET_REF_CLK		0x4001b0b0
+			/* Configure clock consumer for RGMII ref clock */
+			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK		0x10030
+
+			/* SJA1105Q switch reset */
+			MX6QDL_PAD_DISP0_DAT11__GPIO5_IO05		0x10030
+
+			/* phy3/rgmii_phy reset */
+			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25		0x10030
+			/* phy3/rgmii_phy int */
+			MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28		0x40010000
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA			0x4001f8b1
+			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL			0x4001f8b1
+		>;
+	};
+
+	pinctrl_mdio: mdiogrp {
+		fsl,pins = <
+			/* phy0/usbeth_phy reset */
+			MX6QDL_PAD_DISP0_DAT17__GPIO5_IO11		0x10030
+			/* phy0/usbeth_phy int */
+			MX6QDL_PAD_DISP0_DAT18__GPIO5_IO12		0x100b1
+
+			/* phy12/tja1102_phy0 reset */
+			MX6QDL_PAD_DISP0_DAT15__GPIO5_IO09		0x10030
+			/* phy12/tja1102_phy0 int */
+			MX6QDL_PAD_DISP0_DAT14__GPIO5_IO08		0x100b1
+			/* phy12/tja1102_phy0 enable. Set 100K pull-up */
+			MX6QDL_PAD_DISP0_DAT16__GPIO5_IO10		0x1f030
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA		0x1b0b1
+			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA		0x1b0b1
+		>;
+	};
+
+	pinctrl_usbotg: usbotggrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D21__USB_OTG_OC			0x1b0b0
+			MX6QDL_PAD_EIM_D22__GPIO3_IO22			0x1b0b0
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__SD1_CMD			0x170f9
+			MX6QDL_PAD_SD1_CLK__SD1_CLK			0x100f9
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0			0x170f9
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1			0x170f9
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2			0x170f9
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3			0x170f9
+			MX6QDL_PAD_GPIO_1__GPIO1_IO01			0x1b0b0
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD2_CMD__SD2_CMD			0x170b9
+			MX6QDL_PAD_SD2_CLK__SD2_CLK			0x100b9
+			MX6QDL_PAD_SD2_DAT0__SD2_DATA0			0x170b9
+			MX6QDL_PAD_SD2_DAT1__SD2_DATA1			0x170b9
+			MX6QDL_PAD_SD2_DAT2__SD2_DATA2			0x170b9
+			MX6QDL_PAD_SD2_DAT3__SD2_DATA3			0x170b9
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_CMD__SD3_CMD			0x17099
+			MX6QDL_PAD_SD3_CLK__SD3_CLK			0x10099
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0			0x17099
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1			0x17099
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2			0x17099
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3			0x17099
+			MX6QDL_PAD_SD3_DAT4__SD3_DATA4			0x17099
+			MX6QDL_PAD_SD3_DAT5__SD3_DATA5			0x17099
+			MX6QDL_PAD_SD3_DAT6__SD3_DATA6			0x17099
+			MX6QDL_PAD_SD3_DAT7__SD3_DATA7			0x17099
+			MX6QDL_PAD_SD3_RST__SD3_RESET			0x1b0b1
+		>;
+	};
+
+	pinctrl_wifi_npd: wifinpd {
+		fsl,pins = <
+			/* WL_REG_ON */
+			MX6QDL_PAD_NANDF_RB0__GPIO6_IO10		0x13069
+		>;
+	};
+};
-- 
2.28.0

