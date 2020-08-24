Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526AB250922
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 21:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgHXTSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 15:18:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbgHXTSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:18:36 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7B7121741;
        Mon, 24 Aug 2020 19:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598296714;
        bh=nRGgGDVxXFKlZR2mj4QZ7lH82ek8TJUF7e6IkPdsI+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZCu9URDcpY4uSprRld40XGXQQ1c0UJot/S17seRBU0vpGs1Cu/yiW6p6RjESJ1jkW
         oUIsxq6tnlQNANMD6iulGbiLA5So57PfFuvvYvpOi41QhhET85RDnZvvIN3MdL1H6Z
         6iGug7hpfxscsyHKVtyyOCnvsYZ/PDhIcceNOlP8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v4 3/4] arm64: dts: imx8mm-var-som: Add Variscite VAR-SOM-MX8MM System on Module
Date:   Mon, 24 Aug 2020 21:18:18 +0200
Message-Id: <20200824191819.11057-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824191819.11057-1-krzk@kernel.org>
References: <20200824191819.11057-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DTSI of Variscite VAR-SOM-MX8MM System on Module in a basic version,
delivered with Variscite Symphony Evaluation kit.  This version comes
with:
 - 2 GB of RAM,
 - 16 GB eMMC,
 - Gigabit Ethernet PHY,
 - 802.11 ac/a/b/g/n WiFi with 4.2 Bluetooth (Cypress CYW43353),
 - CAN bus,
 - Audio codec (not yet configured in DTSI).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v3:
1. Correct SPI CS polarity,
2. Add suffix "grp" to all pin configuration nodes,
3. Remove unused pcie0grp.

Changes since v2:
1. Remove fsl,spi-num-chipselects,
2. Remove can node (not yet in mainline),
3. Use phy properties instead of deprecated phy-reset-xxx,
4. Remove orphaned pinctrl-names,
5. Use lowercase regulator names to match schema,
6. Use more specific regulator node names.

Changes since v1:
1. None
---
 .../boot/dts/freescale/imx8mm-var-som.dtsi    | 553 ++++++++++++++++++
 1 file changed, 553 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
new file mode 100644
index 000000000000..c371cb34b3f7
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
@@ -0,0 +1,553 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2019 NXP
+ * Copyright (C) 2020 Krzysztof Kozlowski <krzk@kernel.org>
+ */
+
+#include "imx8mm.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-MX8MM module";
+	compatible = "variscite,var-som-mx8mm", "fsl,imx8mm";
+
+	chosen {
+		stdout-path = &uart4;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0 0x80000000>;
+	};
+
+	reg_eth_phy: regulator-eth-phy {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_eth_phy>;
+		regulator-name = "eth_phy_pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&buck2_reg>;
+};
+
+&A53_1 {
+	cpu-supply = <&buck2_reg>;
+};
+
+&A53_2 {
+	cpu-supply = <&buck2_reg>;
+};
+
+&A53_3 {
+	cpu-supply = <&buck2_reg>;
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
+&ecspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	cs-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>,
+		   <&gpio1  0 GPIO_ACTIVE_LOW>;
+	/delete-property/ dmas;
+	/delete-property/ dma-names;
+	status = "okay";
+
+	/* Resistive touch controller */
+	touchscreen@0 {
+		reg = <0>;
+		compatible = "ti,ads7846";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_restouch>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+
+		spi-max-frequency = <1500000>;
+		pendown-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
+
+		ti,x-min = /bits/ 16 <125>;
+		touchscreen-size-x = /bits/ 16 <4008>;
+		ti,y-min = /bits/ 16 <282>;
+		touchscreen-size-y = /bits/ 16 <3864>;
+		ti,x-plate-ohms = /bits/ 16 <180>;
+		touchscreen-max-pressure = /bits/ 16 <255>;
+		touchscreen-average-samples = /bits/ 16 <10>;
+		ti,debounce-tol = /bits/ 16 <3>;
+		ti,debounce-rep = /bits/ 16 <1>;
+		ti,settle-delay-usec = /bits/ 16 <150>;
+		ti,keep-vref-on;
+		wakeup-source;
+	};
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy>;
+	phy-supply = <&reg_eth_phy>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethernet-phy@4 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <4>;
+			reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <10000>;
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pmic@4b {
+		compatible = "rohm,bd71847";
+		reg = <0x4b>;
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <8 GPIO_ACTIVE_LOW>;
+		rohm,reset-snvs-powered;
+
+		regulators {
+			buck1_reg: BUCK1 {
+				regulator-name = "buck1";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <1250>;
+			};
+
+			buck2_reg: BUCK2 {
+				regulator-name = "buck2";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <1250>;
+				rohm,dvs-run-voltage = <1000000>;
+				rohm,dvs-idle-voltage = <900000>;
+			};
+
+			buck3_reg: BUCK3 {
+				regulator-name = "buck3";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck4_reg: BUCK4 {
+				regulator-name = "buck4";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5_reg: BUCK5 {
+				regulator-name = "buck5";
+				regulator-min-microvolt = <1605000>;
+				regulator-max-microvolt = <1995000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6_reg: BUCK6 {
+				regulator-name = "buck6";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1_reg: LDO1 {
+				regulator-name = "ldo1";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <1900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2_reg: LDO2 {
+				regulator-name = "ldo2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3_reg: LDO3 {
+				regulator-name = "ldo3";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4_reg: LDO4 {
+				regulator-name = "ldo4";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5_reg: LDO5 {
+				regulator-compatible = "ldo5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo6_reg: LDO6 {
+				regulator-name = "ldo6";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	/* TODO: configure audio, as of now just put a placeholder */
+	wm8904: codec@1a {
+		compatible = "wlf,wm8904";
+		reg = <0x1a>;
+		status = "disabled";
+	};
+};
+
+&snvs_pwrkey {
+	status = "okay";
+};
+
+/* Bluetooth */
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	assigned-clocks = <&clk IMX8MM_CLK_UART2>;
+	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_80M>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+/* Console */
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+&usbotg1 {
+	dr_mode = "otg";
+	usb-role-switch;
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "otg";
+	usb-role-switch;
+	status = "okay";
+};
+
+/* WIFI */
+&usdhc1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	bus-width = <4>;
+	non-removable;
+	keep-power-in-suspend;
+	status = "okay";
+
+	brcmf: bcrmf@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+/* SD */
+&usdhc2 {
+	assigned-clocks = <&clk IMX8MM_CLK_USDHC2>;
+	assigned-clock-rates = <200000000>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	status = "okay";
+};
+
+/* eMMC */
+&usdhc3 {
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
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK		0x13
+			MX8MM_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI		0x13
+			MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO		0x13
+			MX8MM_IOMUXC_GPIO1_IO14_GPIO1_IO14		0x13
+			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x13
+		>;
+	};
+
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
+			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
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
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL		0x400001c3
+			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_pmic: pmicirqgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_DATA6_GPIO2_IO8	0x41
+		>;
+	};
+
+	pinctrl_reg_eth_phy: regethphygrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_DATA7_GPIO2_IO9	0x41
+		>;
+	};
+
+	pinctrl_restouch: restouchgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x1c0
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX	0x140
+			MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX	0x140
+			MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B	0x140
+			MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B	0x140
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
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x194
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d4
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d4
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d4
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d4
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d4
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x196
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d6
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d6
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d6
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d6
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d6
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10	0xc1
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
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x194
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x196
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d6
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d6
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d6
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d6
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
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
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
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
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
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
-- 
2.17.1

