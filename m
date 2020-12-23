Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3222E2285
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 23:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgLWWm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 17:42:56 -0500
Received: from lists.gateworks.com ([108.161.130.12]:40152 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgLWWmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 17:42:55 -0500
X-Greylist: delayed 1123 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Dec 2020 17:42:49 EST
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1ksCeX-0007gP-OO; Wed, 23 Dec 2020 22:30:41 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 2/2] arm64: dts: imx8mm: Add Gateworks IMX8MM Development Kits
Date:   Wed, 23 Dec 2020 14:23:16 -0800
Message-Id: <1608762196-29871-2-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608762196-29871-1-git-send-email-tharvey@gateworks.com>
References: <1608762196-29871-1-git-send-email-tharvey@gateworks.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gateworks Venice GW71xx-0x/GW72xx-0x/GW73xx-0x are development
kits comprised of a GW700x SoM and a Baseboard.

The GW700x SoM contains:
 - IMX8MM SoC
 - LPDDR4 DRAM
 - eMMC FLASH
 - Gateworks System Controller (eeprom/pushbutton/reset/voltage-monitor)
 - GbE PHY connected to the IMX8MM FEC
 - Power Management IC

The GW71xx Baseboard contains:
 - 1x MiniPCIe Socket with USB2.0, PCIe, and SIM
 - 1x RJ45 GbE (IMX8MM FEC)
 - PCIe Clock generator
 - GPS and accelerometer
 - 1x USB 2.0 Front Panel connector
 - wide range power supply

The GW72xx Baseboard contains:
 - 2x MiniPCIe Socket with USB2.0, PCIe, and SIM
 - 2x RJ45 GbE (IMX8MM FEC and LAN743x)
 - 1x MicroSD connector
 - 1x USB 2.0 Front Panel connector
 - 1x SPI connector
 - PCIe Clock generator
 - GPS and accelerometer
 - Media Expansion connector (MIPI-CSI/MIPI-DSI/GPIO/I2S)
 - wide range power supply

The GW73xx Baseboard contains:
 - 3x MiniPCIe Socket with USB2.0, PCIe, and SIM
 - 2x RJ45 GbE (IMX8MM FEC and LAN743x)
 - 1x MicroSD connector
 - 1x USB 2.0 Front Panel connector
 - 1x SPI connector
 - WiFi/BT
 - PCIe Clock generator
 - GPS and accelerometer
 - Media Expansion connector (MIPI-CSI/MIPI-DSI/GPIO/I2S)
 - wide range power supply

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 .../boot/dts/freescale/imx8mm-venice-gw700x.dtsi   | 482 +++++++++++++++++++++
 .../boot/dts/freescale/imx8mm-venice-gw71xx-0x.dts |  19 +
 .../boot/dts/freescale/imx8mm-venice-gw71xx.dtsi   | 186 ++++++++
 .../boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts |  20 +
 .../boot/dts/freescale/imx8mm-venice-gw72xx.dtsi   | 311 +++++++++++++
 .../boot/dts/freescale/imx8mm-venice-gw73xx-0x.dts |  19 +
 .../boot/dts/freescale/imx8mm-venice-gw73xx.dtsi   | 363 ++++++++++++++++
 8 files changed, 1403 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index f8d5943..ecdd233 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -32,6 +32,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw71xx-0x.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-var-som-symphony.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
new file mode 100644
index 00000000..7e1b96b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
@@ -0,0 +1,482 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2020 Gateworks Corporation
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/net/ti-dp83867.h>
+
+/ {
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0 0x80000000>;
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		user_pb {
+			label = "user_pb";
+			gpios = <&gsc_gpio 2 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_0>;
+		};
+
+		user_pb1x {
+			label = "user_pb1x";
+			linux,code = <BTN_1>;
+			interrupt-parent = <&gsc>;
+			interrupts = <0>;
+		};
+
+		key_erased {
+			label = "key-erased";
+			linux,code = <BTN_2>;
+			interrupt-parent = <&gsc>;
+			interrupts = <1>;
+		};
+
+		eeprom_wp {
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
+		switch_hold {
+			label = "switch_hold";
+			linux,code = <BTN_5>;
+			interrupt-parent = <&gsc>;
+			interrupts = <7>;
+		};
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&buck3_reg>;
+};
+
+&A53_1 {
+	cpu-supply = <&buck3_reg>;
+};
+
+&A53_2 {
+	cpu-supply = <&buck3_reg>;
+};
+
+&A53_3 {
+	cpu-supply = <&buck3_reg>;
+};
+
+&ddrc {
+	operating-points-v2 = <&ddrc_opp_table>;
+
+	ddrc_opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp-25M {
+			opp-hz = /bits/ 64 <25000000>;
+		};
+
+		opp-100M {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+
+		opp-750M {
+			opp-hz = /bits/ 64 <750000000>;
+		};
+	};
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	gsc: gsc@20 {
+		compatible = "gw,gsc";
+		reg = <0x20>;
+		pinctrl-0 = <&pinctrl_gsc>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <6 GPIO_ACTIVE_LOW>;
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
+			channel@6 {
+				gw,mode = <0>;
+				reg = <0x06>;
+				label = "temp";
+			};
+
+			channel@8 {
+				gw,mode = <1>;
+				reg = <0x08>;
+				label = "vdd_bat";
+			};
+
+			channel@16 {
+				gw,mode = <4>;
+				reg = <0x16>;
+				label = "fan_tach";
+			};
+
+			channel@82 {
+				gw,mode = <2>;
+				reg = <0x82>;
+				label = "vdd_vin";
+				gw,voltage-divider-ohms = <22100 1000>;
+			};
+
+			channel@84 {
+				gw,mode = <2>;
+				reg = <0x84>;
+				label = "vdd_adc1";
+				gw,voltage-divider-ohms = <10000 10000>;
+			};
+
+			channel@86 {
+				gw,mode = <2>;
+				reg = <0x86>;
+				label = "vdd_adc2";
+				gw,voltage-divider-ohms = <10000 10000>;
+			};
+
+			channel@88 {
+				gw,mode = <2>;
+				reg = <0x88>;
+				label = "vdd_dram";
+			};
+
+			channel@8c {
+				gw,mode = <2>;
+				reg = <0x8c>;
+				label = "vdd_1p2";
+			};
+
+			channel@8e {
+				gw,mode = <2>;
+				reg = <0x8e>;
+				label = "vdd_1p0";
+			};
+
+			channel@90 {
+				gw,mode = <2>;
+				reg = <0x90>;
+				label = "vdd_2p5";
+				gw,voltage-divider-ohms = <10000 10000>;
+			};
+
+			channel@92 {
+				gw,mode = <2>;
+				reg = <0x92>;
+				label = "vdd_3p3";
+				gw,voltage-divider-ohms = <10000 10000>;
+			};
+
+			channel@98 {
+				gw,mode = <2>;
+				reg = <0x98>;
+				label = "vdd_0p95";
+			};
+
+			channel@9a {
+				gw,mode = <2>;
+				reg = <0x9a>;
+				label = "vdd_1p8";
+			};
+
+			channel@a2 {
+				gw,mode = <2>;
+				reg = <0xa2>;
+				label = "vdd_gsc";
+				gw,voltage-divider-ohms = <10000 10000>;
+			};
+		};
+
+		fan-controller@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "gw,gsc-fan";
+			reg = <0x0a>;
+		};
+	};
+
+	gsc_gpio: pca9555@23 {
+		compatible = "nxp,pca9555";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gsc>;
+		interrupts = <4>;
+	};
+
+	eeprom@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+
+	eeprom@51 {
+		compatible = "atmel,24c02";
+		reg = <0x51>;
+		pagesize = <16>;
+	};
+
+	eeprom@52 {
+		compatible = "atmel,24c32";
+		reg = <0x52>;
+		pagesize = <32>;
+	};
+
+	eeprom@53 {
+		compatible = "atmel,24c32";
+		reg = <0x53>;
+		pagesize = <32>;
+	};
+
+	pmic@69 {
+		compatible = "mps,mp5416";
+		reg = <0x69>;
+
+		regulators {
+			buck1 {
+				regulator-name = "vdd_0p95";
+				regulator-min-microvolt = <805000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-max-microamp = <2500000>;
+				regulator-boot-on;
+			};
+
+			buck2 {
+				regulator-name = "vdd_soc";
+				regulator-min-microvolt = <805000>;
+				regulator-max-microvolt = <900000>;
+				regulator-max-microamp = <1000000>;
+				regulator-boot-on;
+			};
+
+			buck3_reg: buck3 {
+				regulator-name = "vdd_arm";
+				regulator-min-microvolt = <805000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-max-microamp = <2200000>;
+				regulator-boot-on;
+			};
+
+			buck4 {
+				regulator-name = "vdd_1p8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-max-microamp = <500000>;
+				regulator-boot-on;
+			};
+
+			ldo1 {
+				regulator-name = "nvcc_snvs_1p8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-max-microamp = <300000>;
+				regulator-boot-on;
+			};
+
+			ldo2 {
+				regulator-name = "vdd_snvs_0p8";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-boot-on;
+			};
+
+			ldo3 {
+				regulator-name = "vdd_0p95";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-boot-on;
+			};
+
+			ldo4 {
+				regulator-name = "vdd_1p8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+			};
+		};
+	};
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	eeprom@52 {
+		compatible = "atmel,24c32";
+		reg = <0x52>;
+		pagesize = <32>;
+	};
+};
+
+&uart2 { /* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&usdhc3 { /* eMMC */
+	assigned-clocks = <&clk IMX8MM_CLK_USDHC3_ROOT>;
+	assigned-clock-rates = <400000000>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x3
+			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3
+			MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
+			MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
+			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
+			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
+			MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
+			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
+			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
+			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
+			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
+			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
+			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
+			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
+			MX8MM_IOMUXC_NAND_ALE_GPIO3_IO0			0x19
+		>;
+	};
+
+	pinctrl_gsc: gscirq {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_DATA4_GPIO2_IO6	0x159
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL		0x400001c3
+			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA		0x400001c3
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
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
+			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK	0x190
+			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD	0x1d0
+			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0	0x1d0
+			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1	0x1d0
+			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2	0x1d0
+			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3	0x1d0
+			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4	0x1d0
+			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5	0x1d0
+			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6	0x1d0
+			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7	0x1d0
+			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE	0x190
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK	0x194
+			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD	0x1d4
+			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0	0x1d4
+			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1	0x1d4
+			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2	0x1d4
+			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3	0x1d4
+			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4	0x1d4
+			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5	0x1d4
+			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6	0x1d4
+			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7	0x1d4
+			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE	0x194
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK	0x196
+			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD	0x1d6
+			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0	0x1d6
+			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1	0x1d6
+			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2	0x1d6
+			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3	0x1d6
+			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4	0x1d6
+			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5	0x1d6
+			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6	0x1d6
+			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7	0x1d6
+			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE	0x196
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B	0xc6
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dts
new file mode 100644
index 00000000..3f88c4a
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2020 Gateworks Corporation
+ */
+
+/dts-v1/;
+
+#include "imx8mm.dtsi"
+#include "imx8mm-venice-gw700x.dtsi"
+#include "imx8mm-venice-gw71xx.dtsi"
+
+/ {
+	model = "Gateworks Venice GW71xx-0x i.MX8MM Development Kit";
+	compatible = "gw,imx8mm-gw71xx-0x", "fsl,imx8mm";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
new file mode 100644
index 00000000..a4eeb0d
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2020 Gateworks Corporation
+ */
+
+/ {
+	aliases {
+		usb0 = &usbotg1;
+		usb1 = &usbotg2;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		user1 { /* GRN */
+			label = "user1";
+			gpios = <&gpio5 5 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+		};
+
+		user2 { /* RED */
+			label = "user2";
+			gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	pps {
+		compatible = "pps-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pps>;
+		gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+	};
+
+	reg_usb_otg1_vbus: regulator-usb-otg1 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usb1_en>;
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg1_vbus";
+		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+};
+
+&ecspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	accel@19 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_accel>;
+		compatible = "st,lis2de12";
+		reg = <0x19>;
+		st,drdy-int-pin = <1>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "INT1";
+	};
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+};
+
+&sai3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3>;
+	assigned-clocks = <&clk IMX8MM_CLK_SAI3>;
+	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
+
+&usbotg1 {
+	dr_mode = "otg";
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_TX_GPIO5_IO3		0x40000041 /* PLUG_TEST */
+			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6	0x40000041 /* PCI_USBSEL */
+			MX8MM_IOMUXC_SAI1_RXD5_GPIO4_IO7	0x40000041 /* PCIE_WDIS# */
+			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7	0x40000041 /* DIO0 */
+			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9	0x40000041 /* DIO1 */
+			MX8MM_IOMUXC_SAI1_RXD1_GPIO4_IO3	0x40000041 /* DIO2 */
+			MX8MM_IOMUXC_SAI1_RXD2_GPIO4_IO4	0x40000041 /* DIO2 */
+		>;
+	};
+
+	pinctrl_accel: accelirq {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_RXD3_GPIO4_IO5	0x159
+		>;
+	};
+
+	pinctrl_gpio_leds: gpioledgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5	0x19
+			MX8MM_IOMUXC_SPDIF_RX_GPIO5_IO4		0x19
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL		0x400001c3
+			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_pps: ppsgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x41
+		>;
+	};
+
+	pinctrl_reg_usb1_en: regusb1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12	0x41
+			MX8MM_IOMUXC_GPIO1_IO13_USB1_OTG_OC	0x41
+		>;
+	};
+
+	pinctrl_spi2: spi2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0xd6
+			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI	0xd6
+			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0xd6
+			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13	0xd6
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
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts
new file mode 100644
index 00000000..b1e7540
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2020 Gateworks Corporation
+ */
+
+/dts-v1/;
+
+#include "imx8mm.dtsi"
+#include "imx8mm-venice-gw700x.dtsi"
+#include "imx8mm-venice-gw72xx.dtsi"
+
+/ {
+	model = "Gateworks Venice GW72xx-0x i.MX8MM Development Kit";
+	compatible = "gw,imx8mm-gw72xx-0x", "fsl,imx8mm";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+};
+
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
new file mode 100644
index 00000000..3fb0213
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2020 Gateworks Corporation
+ */
+
+/ {
+	aliases {
+		usb0 = &usbotg1;
+		usb1 = &usbotg2;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		user1 { /* GRN */
+			label = "user1";
+			gpios = <&gpio5 5 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+		};
+
+		user2 { /* RED */
+			label = "user2";
+			gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	pps {
+		compatible = "pps-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pps>;
+		gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reg_usb_otg1_vbus: regulator-usb-otg1 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usb1_en>;
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg1_vbus";
+		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_usb_otg2_vbus: regulator-usb-otg2 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usb2_en>;
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg2_vbus";
+		gpio = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+};
+
+&ecspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	accel@19 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_accel>;
+		compatible = "st,lis2de12";
+		reg = <0x19>;
+		st,drdy-int-pin = <1>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "INT1";
+	};
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+};
+
+&sai3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3>;
+	assigned-clocks = <&clk IMX8MM_CLK_SAI3>;
+	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart2 { /* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>,<&pinctrl_uart2_gpio>;
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+&usbotg1 {
+	dr_mode = "otg";
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	vbus-supply = <&reg_usb_otg2_vbus>;
+	status = "okay";
+};
+
+&usdhc2 { /* microSD */
+	assigned-clocks = <&clk IMX8MM_CLK_USDHC2>;
+	assigned-clock-rates = <200000000>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	vmmc-supply = <&reg_3p3v>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_TX_GPIO5_IO3		0x40000041 /* PLUG_TEST */
+			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6	0x40000041 /* PCI_USBSEL */
+			MX8MM_IOMUXC_SAI1_RXD5_GPIO4_IO7	0x40000041 /* PCIE_WDIS# */
+			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7	0x40000041 /* DIO0 */
+			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9	0x40000041 /* DIO1 */
+		>;
+	};
+
+	pinctrl_accel: accelirq {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_RXD3_GPIO4_IO5	0x159
+		>;
+	};
+
+	pinctrl_gpio_leds: gpioledgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5	0x19
+			MX8MM_IOMUXC_SPDIF_RX_GPIO5_IO4		0x19
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL		0x400001c3
+			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_pps: ppsgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x41
+		>;
+	};
+
+	pinctrl_reg_usb1_en: regusb1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12	0x41
+			MX8MM_IOMUXC_GPIO1_IO13_USB1_OTG_OC	0x41
+		>;
+	};
+
+	pinctrl_reg_usb2_en: regusb2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8	0x41
+		>;
+	};
+
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC     0xd6
+			MX8MM_IOMUXC_SAI3_TXC_SAI3_TX_BCLK      0xd6
+			MX8MM_IOMUXC_SAI3_MCLK_SAI3_MCLK        0xd6
+			MX8MM_IOMUXC_SAI3_TXD_SAI3_TX_DATA0     0xd6
+			MX8MM_IOMUXC_SAI3_RXD_SAI3_RX_DATA0	0xd6
+		>;
+	};
+
+	pinctrl_spi2: spi2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0xd6
+			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI	0xd6
+			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0xd6
+			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13	0xd6
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
+	pinctrl_uart2_gpio: uart2grpgpio {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0	0x40000104 /*TERM*/
+			MX8MM_IOMUXC_SAI1_RXFS_GPIO4_IO0	0x40000104 /*RS485*/
+			MX8MM_IOMUXC_SAI1_RXD0_GPIO4_IO2	0x40000104 /*HALF*/
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX	0x140
+			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART4_RXD_UART4_DCE_RX	0x140
+			MX8MM_IOMUXC_UART4_TXD_UART4_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x190
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d0
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d0
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d0
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d0
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d0
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x194
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x196
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d6
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d6
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d6
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d6
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2grpgpio {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12	0x1c4
+			MX8MM_IOMUXC_SD2_RESET_B_USDHC2_RESET_B	0x1d0
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dts
new file mode 100644
index 00000000..6905437
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2020 Gateworks Corporation
+ */
+
+/dts-v1/;
+
+#include "imx8mm.dtsi"
+#include "imx8mm-venice-gw700x.dtsi"
+#include "imx8mm-venice-gw73xx.dtsi"
+
+/ {
+	model = "Gateworks Venice GW73xx-0x i.MX8MM Development Kit";
+	compatible = "gw,imx8mm-gw73xx-0x", "fsl,imx8mm";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
new file mode 100644
index 00000000..8096e4b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2020 Gateworks Corporation
+ */
+
+/ {
+	aliases {
+		usb0 = &usbotg1;
+		usb1 = &usbotg2;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		user1 { /* GRN */
+			label = "user1";
+			gpios = <&gpio5 5 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+		};
+
+		user2 { /* RED */
+			label = "user2";
+			gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	pps {
+		compatible = "pps-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pps>;
+		gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "1P8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reg_usb_otg1_vbus: regulator-usb-otg1 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usb1_en>;
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg1_vbus";
+		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_usb_otg2_vbus: regulator-usb-otg2 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usb2_en>;
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg2_vbus";
+		gpio = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_wifi_en: regulator-wifi-en {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_wl>;
+		compatible = "regulator-fixed";
+		regulator-name = "wl";
+		gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <100>;
+		enable-active-high;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&ecspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	accel@19 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_accel>;
+		compatible = "st,lis2de12";
+		reg = <0x19>;
+		st,drdy-int-pin = <1>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "INT1";
+	};
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+};
+
+&sai3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3>;
+	assigned-clocks = <&clk IMX8MM_CLK_SAI3>;
+	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart2 { /* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>,<&pinctrl_uart2_gpio>;
+};
+
+&uart3 { /* bluetooth HCI */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>,<&pinctrl_bten>;
+	cts-gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
+	rts-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4330-bt";
+		shutdown-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+&usbotg1 {
+	dr_mode = "otg";
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	vbus-supply = <&reg_usb_otg2_vbus>;
+	status = "okay";
+};
+
+&usdhc1 { /* SDIO WiFi */
+	assigned-clocks = <&clk IMX8MM_CLK_USDHC1>;
+	assigned-clock-rates = <50000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	bus-width = <4>;
+	non-removable;
+	vmmc-supply = <&reg_wifi_en>;
+	status = "okay";
+};
+
+&usdhc2 { /* microSD */
+	assigned-clocks = <&clk IMX8MM_CLK_USDHC2>;
+	assigned-clock-rates = <200000000>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	vmmc-supply = <&reg_3p3v>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_TX_GPIO5_IO3		0x40000041 /* PLUG_TEST */
+			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6	0x40000041 /* PCI_USBSEL */
+			MX8MM_IOMUXC_SAI1_RXD5_GPIO4_IO7	0x40000041 /* PCIE_WDIS# */
+			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7	0x40000041 /* DIO0 */
+			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9	0x40000041 /* DIO1 */
+		>;
+	};
+
+	pinctrl_accel: accelirq {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_RXD3_GPIO4_IO5	0x159
+		>;
+	};
+
+	pinctrl_bten: btengrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x41
+		>;
+	};
+
+	pinctrl_gpio_leds: gpioledgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5	0x19
+			MX8MM_IOMUXC_SPDIF_RX_GPIO5_IO4		0x19
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL		0x400001c3
+			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_pps: ppsgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x41
+		>;
+	};
+
+	pinctrl_reg_wl: regwlgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5	0x41
+		>;
+	};
+
+	pinctrl_reg_usb1_en: regusb1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12	0x41
+			MX8MM_IOMUXC_GPIO1_IO13_USB1_OTG_OC	0x41
+		>;
+	};
+
+	pinctrl_reg_usb2_en: regusb2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8	0x41
+		>;
+	};
+
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC     0xd6
+			MX8MM_IOMUXC_SAI3_TXC_SAI3_TX_BCLK      0xd6
+			MX8MM_IOMUXC_SAI3_MCLK_SAI3_MCLK        0xd6
+			MX8MM_IOMUXC_SAI3_TXD_SAI3_TX_DATA0     0xd6
+			MX8MM_IOMUXC_SAI3_RXD_SAI3_RX_DATA0	0xd6
+		>;
+	};
+
+	pinctrl_spi2: spi2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0xd6
+			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI	0xd6
+			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0xd6
+			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13	0xd6
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
+	pinctrl_uart2_gpio: uart2grpgpio {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0	0x40000104 /*TERM*/
+			MX8MM_IOMUXC_SAI1_RXFS_GPIO4_IO0	0x40000104 /*RS485*/
+			MX8MM_IOMUXC_SAI1_RXD0_GPIO4_IO2	0x40000104 /*HALF*/
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX	0x140
+			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX	0x140
+			MX8MM_IOMUXC_ECSPI1_MISO_GPIO5_IO8	0x140
+			MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9	0x140
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART4_RXD_UART4_DCE_RX	0x140
+			MX8MM_IOMUXC_UART4_TXD_UART4_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x190
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d0
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d0
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d0
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d0
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d0
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x194
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x196
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d6
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d6
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d6
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d6
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2grpgpio {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12	0x1c4
+			MX8MM_IOMUXC_SD2_RESET_B_USDHC2_RESET_B	0x1d0
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
+		>;
+	};
+};
-- 
2.7.4

