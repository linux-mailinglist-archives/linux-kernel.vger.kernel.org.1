Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B82C280248
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbgJAPOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 11:14:39 -0400
Received: from mail-eopbgr30129.outbound.protection.outlook.com ([40.107.3.129]:21664
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732368AbgJAPOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:14:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncQ2Cu1N4+A2mAq7SrW0dYhcico8c+9Adj26Y6xUBjo3odtm4mVDQGJR2R49lonpFFGtXHOAukfmz/D6+jymQ6ol4ROhBnbFJRTLlibr9+GNp3YBCHC5PD1+7yoAa2aJr4hlGxAStcOHThZlNReAQM1CkEk6lpmVqijcJ3uO485IayNUFGWZKiVAAjEtrzXWXKEyMcPz2WknzPq/xa47eX+IWcJQ5DH1y0Z3GgRFTnsjWl8R52Gd7FeTcxL94XJRa/gfkcUWvGD4o55b4ZE1YNwh1QVLATzAGHvzhVr6F2xfFI/5LWDHPcXOb1ejXUMClWy0eJTs/UpkAZdzf/tc+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYHfJokBe+0gtFEDa3toAjhFSP1n9xX7946nWCugFRo=;
 b=k9b/Ih1RFPLs0vxgMw3tOC7uge4MSI0OcKyv8M7GYQ2EzwVGrGDDSpR4K7B2as1fX6APxxrVi41Xut3DHYyj/XbhADL1tRjySYhECx4GL5AS7hELH0n7U0oZakhaUhwfu+Aji0IJ04p6hRDhPIeLkkRpDtP9ct7F7jZZNxnDZnqTvVvkMwbKrozUyPbQpeMDs+mIPbGeuZx89LTj69HcltlB7jqiBMNJ5lq5k2388ukKP7/PZ153AeEvsbSnxTEWpWu/gUqVPb8py/wyBm0aHINpYWMEBflIWnKoVDhpMRDMnMQrZL3gE1H0ADaMYAoqzZvnn58/VZERVyitxxH1aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYHfJokBe+0gtFEDa3toAjhFSP1n9xX7946nWCugFRo=;
 b=FlpAo04wXcWe7Z+Qyknmm3WB3eMpkSzEsQHGAqbENuoZFxDBVUt7CCZvjw39io4lu2zJTVwA4OsTAS96R/rZvEKTGy1aibwVbkHAiCbGIcoUApSpkgdV+TiOGvXm4/5jabUcFNakW7JJJaHVplAutCnjfC7KaX7lt5oIIFqz4W4=
Authentication-Results: kemnade.info; dkim=none (message not signed)
 header.d=none;kemnade.info; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Thu, 1 Oct
 2020 15:14:34 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5%6]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 15:14:34 +0000
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Andreas Kemnade <andreas@kemnade.info>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: [PATCH v5 1/2] arm64: dts: Add the Kontron i.MX8M Mini SoMs and baseboards
Date:   Thu,  1 Oct 2020 17:13:37 +0200
Message-Id: <20201001151422.16028-1-frieder.schrempf@kontron.de>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [89.247.42.197]
X-ClientProxiedBy: AM5PR04CA0031.eurprd04.prod.outlook.com
 (2603:10a6:206:1::44) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fs-work.localdomain (89.247.42.197) by AM5PR04CA0031.eurprd04.prod.outlook.com (2603:10a6:206:1::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Thu, 1 Oct 2020 15:14:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d54a5772-fc8f-4357-5a4a-08d8661cb415
X-MS-TrafficTypeDiagnostic: AM0PR10MB2322:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR10MB2322B81170C52E762BF433D3E9300@AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xjX/HJZp0zU8PHkTan/nhfYlhsTkIu9UyyWBQGlPLqmS003BobgpQfDRwWoP7qhIf6c+dPTvCzOdr1RMrK0qYfa90L7Pu60J3UAZ6dGFQvGqhTW4eRzZOXsQ9djvK9slkKkFCTlpXMDtueuGvL6nvTFn/eF7Fk+bORUqTTSVtW5mX+79soBlrMC3/49WLt8V8HmiAXmbsUcguyhK8PHZvp6L+qhcBfLr5pnL/gLmfrOh7uZNpyh6P3+Fy4wFhplrDsfTSjHrdUqZG9x6fOWI2LmOgaewHwKX6HDGKHK6I5w0oMwOo8CJuSm6T3W2f3hmXBbt4Pt3LkrSyIVxsRjNP4hypPxmGyMK2+I79EcLGuLsy9F6wJAm23D+2LTVv7uKF5F5FJqQNha2IHQ2o+OkHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(6029001)(4636009)(366004)(396003)(39850400004)(136003)(376002)(346002)(8936002)(83380400001)(6486002)(478600001)(1076003)(956004)(2616005)(7416002)(2906002)(8676002)(6512007)(86362001)(36756003)(4326008)(16526019)(66476007)(5660300002)(66556008)(66946007)(30864003)(110136005)(26005)(316002)(186003)(52116002)(6506007)(921003)(473944003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 2dzZmkB9iRK2mdx5A+3OZBuEy1bwvbnn40TW6NocmGC3eA2IVeiIAp/2f7oR6fwjO1aCpikaHVQX7rFJ51frqoToAhz41oXHIEHwcXNu38gGyZ6HIRdYMRDyafM/JY1EmM3HwM3JcpGDQykjJCzQKK8H+/Z/iL127dFQ3YYsiHLAjk67N471GA48hgfBp4FdLM84uuLjaX7Ek+pIteb8dUwJtpzHIxSqDGNXyHJANpLm1ibV5k7z7Y2rZQpJxOiVe67/yfQdKYI8wtlhgpcCeSI2sEt2dy/bSZoJe88Jugef8745oTWp6y51ScDiOxoa8QoBdaBehysUDfJWTTQpSlSpb/EqVRGkQecwZa1oUfDtN8ILaJjwMFd0Da4Y0MSoMG4FpKPJBJSjwIkZg9sKTnV9BUs7kkzTfrXpoiVv6l5W8YsNasRLshdqHS5+aRIarCb2nWQVdUrUQt4TOsiURlMBsGlaTA5UazJ/9Yz0cohmwL0oesfFQybE5PSigDg/jkoYu7Pfnjaq9SVtTPjXk0Lz3vClAdlCHeRwbXegPaDbuvikwsD39U7fiHFOzKh5kSokcg0/dw9Pt+hjwoFRGJFrTUbfq1ns4iOw6t39/L/mjs4ICeQzeU5GdKxJVxXOzTqkTor9Oej5xWHEUbrqsA==
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d54a5772-fc8f-4357-5a4a-08d8661cb415
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 15:14:34.2898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBpIZUA3fD/7gN4ViTVBBgggxsfyqbVnNieUQbc0vUvr3vYKsIhN0eFS5oZ7E0P3K68a6N/PvCuGlOThXcU/Eh5A5TKxPjKLqQzAJfF2rTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2322
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Kontron Electronics GmbH offers small and powerful SoMs based on the
i.MX8M Mini SoC including PMIC, LPDDR4-RAM, eMMC and SPI NOR.

The matching baseboards have the same form factor and similar interfaces
as the other boards from the Kontron "Board-Line" family, including
SD card, 1G Ethernet, 100M Ethernet, USB Host/OTG, digital IOs, RS232,
RS485, CAN, LVDS or HDMI, RTC and much more.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v5:
* Add Makefile entry to build dtb

Changes for v4:
* Remove one more needless status property
* Use local-mac-address instead of mac-address
* Add missing pinctrl-names in PMIC node
* Fix interrupt flags in PMIC node
* Use lowercase regulator names
* Enable pullup for PMIC IRQ line
* Fix pinctrl grp names to match schema

Changes for v3:
* Remove needless status properties
* Remove needless regulator properties for reg_vdd_5v
* Use proper PHY reset properties in PHY node
* Use phy-connection-type instead of phy-mode
* Adjust PMIC node name and label
* Add over-current-active-low to usbotg1 node
* Remove redundant bus-width property from usdhc2 node
* Remove needless regulator-compatible from reg_vdd_snvs
* Set minimum voltage to 85mV for reg_vdd_snvs

Changes for v2:
* Make the licensing less strict (GPL-2.0+ OR MIT)
* Merge the SoM and baseboard DTs for N8010 and N8011 into one as
  they only differ in DDR and eMMC size.
* Change compatibles and model strings to "n810x" and "N8010X".
* Only use a common memory node that will be updated by the
  bootloader reflecting the detected DDR size.
* Improve naming for 16MHz CAN fixed oscillator and set
  "clock-output-names".
* Consistently use "reg_" prefix for regulators.
* Remove "userspi" node.
* Slightly improve commit message.
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mm-kontron-n801x-s.dts  | 322 ++++++++++++++++++
 .../freescale/imx8mm-kontron-n801x-som.dtsi   | 294 ++++++++++++++++
 3 files changed, 617 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index f8d59433af01..e43254f1294d 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -31,6 +31,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-n801x-s.dts
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
new file mode 100644
index 000000000000..d17abb515835
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2019 Kontron Electronics GmbH
+ */
+
+/dts-v1/;
+
+#include "imx8mm-kontron-n801x-som.dtsi"
+
+/ {
+	model = "Kontron i.MX8MM N801X S";
+	compatible = "kontron,imx8mm-n801x-s", "kontron,imx8mm-n801x-som", "fsl,imx8mm";
+
+	aliases {
+		ethernet1 = &usbnet;
+	};
+
+	/* fixed crystal dedicated to mcp2515 */
+	osc_can: clock-osc-can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <16000000>;
+		clock-output-names = "osc-can";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_led>;
+
+		led1 {
+			label = "led1";
+			gpios = <&gpio4 17 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led2 {
+			label = "led2";
+			gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
+		};
+
+		led3 {
+			label = "led3";
+			gpios = <&gpio4 18 GPIO_ACTIVE_LOW>;
+		};
+
+		led4 {
+			label = "led4";
+			gpios = <&gpio4 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led5 {
+			label = "led5";
+			gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led6 {
+			label = "led6";
+			gpios = <&gpio4 7 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	pwm-beeper {
+		compatible = "pwm-beeper";
+		pwms = <&pwm2 0 5000 0>;
+	};
+
+	reg_rst_eth2: regulator-rst-eth2 {
+		compatible = "regulator-fixed";
+		regulator-name = "rst-usb-eth2";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb_eth2>;
+		gpio = <&gpio3 2 GPIO_ACTIVE_LOW>;
+	};
+
+	reg_vdd_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+};
+
+&ecspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	can0: can@0 {
+		compatible = "microchip,mcp2515";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_can>;
+		clocks = <&osc_can>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
+		spi-max-frequency = <100000>;
+		vdd-supply = <&reg_vdd_3v3>;
+		xceiver-supply = <&reg_vdd_5v>;
+	};
+};
+
+&ecspi3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-connection-type = "rgmii";
+	phy-handle = <&ethphy>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethernet-phy@0 {
+			reg = <0>;
+			reset-assert-us = <100>;
+			reset-deassert-us = <100>;
+			reset-gpios = <&gpio4 27 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	status = "okay";
+
+	rtc@32 {
+		compatible = "epson,rx8900";
+		reg = <0x32>;
+	};
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	linux,rs485-enabled-at-boot-time;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&usbotg1 {
+	dr_mode = "otg";
+	over-current-active-low;
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	disable-over-current;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	usb1@1 {
+		compatible = "usb424,9514";
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbnet: usbether@1 {
+			compatible = "usb424,ec00";
+			reg = <1>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+		};
+	};
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	vmmc-supply = <&reg_vdd_3v3>;
+	vqmmc-supply = <&reg_nvcc_sd>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio>;
+
+	pinctrl_can: cangrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28		0x19
+		>;
+	};
+
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x82
+			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x82
+			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x82
+			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x19
+		>;
+	};
+
+	pinctrl_ecspi3: ecspi3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART2_RXD_ECSPI3_MISO		0x82
+			MX8MM_IOMUXC_UART1_TXD_ECSPI3_MOSI		0x82
+			MX8MM_IOMUXC_UART1_RXD_ECSPI3_SCLK		0x82
+			MX8MM_IOMUXC_UART2_TXD_GPIO5_IO25		0x19
+		>;
+	};
+
+	pinctrl_enet: enetgrp {
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
+			MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19 /* PHY RST */
+			MX8MM_IOMUXC_SAI2_TXC_GPIO4_IO25		0x19 /* ETH IRQ */
+		>;
+	};
+
+	pinctrl_gpio_led: gpioledgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16		0x19
+			MX8MM_IOMUXC_SAI1_RXD5_GPIO4_IO7		0x19
+			MX8MM_IOMUXC_SAI1_RXD6_GPIO4_IO8		0x19
+			MX8MM_IOMUXC_SAI1_RXD7_GPIO4_IO9		0x19
+			MX8MM_IOMUXC_SAI1_TXD5_GPIO4_IO17		0x19
+			MX8MM_IOMUXC_SAI1_TXD6_GPIO4_IO18		0x19
+			MX8MM_IOMUXC_SAI1_TXD7_GPIO4_IO19		0x19
+		>;
+	};
+
+	pinctrl_gpio: gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x19
+			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x19
+			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
+			MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x19
+			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x19
+			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8		0x19
+			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x19
+			MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x19
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c3
+			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x400001c3
+		>;
+	};
+
+	pinctrl_pwm2: pwm2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT			0x19
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x140
+			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x140
+			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B		0x140
+			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B		0x140
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x140
+			MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x140
+			MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x140
+			MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x140
+		>;
+	};
+
+	pinctrl_usb_eth2: usbeth2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_CE1_B_GPIO3_IO2		0x19
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x190
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d0
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d0
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
new file mode 100644
index 000000000000..d0456daefda8
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2019 Kontron Electronics GmbH
+ */
+
+#include "imx8mm.dtsi"
+
+/ {
+	model = "Kontron i.MX8MM N801X SoM";
+	compatible = "kontron,imx8mm-n801x-som", "fsl,imx8mm";
+
+	memory@40000000 {
+		device_type = "memory";
+		/*
+		 * There are multiple SoM flavors with different DDR sizes.
+		 * The smallest is 1GB. For larger sizes the bootloader will
+		 * update the reg property.
+		 */
+		reg = <0x0 0x40000000 0 0x80000000>;
+	};
+
+	chosen {
+		stdout-path = &uart3;
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&A53_1 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&A53_2 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&A53_3 {
+	cpu-supply = <&reg_vdd_arm>;
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
+	cs-gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	spi-flash@0 {
+		compatible = "mxicy,mx25r1635f", "jedec,spi-nor";
+		spi-max-frequency = <80000000>;
+		reg = <0>;
+	};
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pca9450: pmic@25 {
+		compatible = "nxp,pca9450a";
+		reg = <0x25>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+
+		regulators {
+			reg_vdd_soc: BUCK1 {
+				regulator-name = "buck1";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			reg_vdd_arm: BUCK2 {
+				regulator-name = "buck2";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <950000>;
+				regulator-boot-on;
+				regulator-ramp-delay = <3125>;
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <850000>;
+			};
+
+			reg_vdd_dram: BUCK3 {
+				regulator-name = "buck3";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_vdd_3v3: BUCK4 {
+				regulator-name = "buck4";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_vdd_1v8: BUCK5 {
+				regulator-name = "buck5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_nvcc_dram: BUCK6 {
+				regulator-name = "buck6";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_nvcc_snvs: LDO1 {
+				regulator-name = "ldo1";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_vdd_snvs: LDO2 {
+				regulator-name = "ldo2";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_vdda: LDO3 {
+				regulator-name = "ldo3";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_vdd_phy: LDO4 {
+				regulator-name = "ldo4";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_nvcc_sd: LDO5 {
+				regulator-name = "ldo5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+	};
+};
+
+&uart3 { /* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	vmmc-supply = <&reg_vdd_3v3>;
+	vqmmc-supply = <&reg_vdd_1v8>;
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
+			MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO		0x82
+			MX8MM_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI		0x82
+			MX8MM_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK		0x82
+			MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x19
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x400001c3
+			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x400001c3
+		>;
+	};
+
+	pinctrl_pmic: pmicgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x141
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX		0x140
+			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX		0x140
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK			0x190
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD			0x1d0
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x1d0
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x1d0
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x1d0
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x1d0
+			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x1d0
+			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x1d0
+			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x1d0
+			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x1d0
+			MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0x019
+			MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x190
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK			0x194
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD			0x1d4
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x1d4
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x1d4
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x1d4
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x1d4
+			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x1d4
+			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x1d4
+			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x1d4
+			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x1d4
+			MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0x019
+			MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x194
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK			0x196
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD			0x1d6
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x1d6
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x1d6
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x1d6
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x1d6
+			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x1d6
+			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x1d6
+			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x1d6
+			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x1d6
+			MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0x019
+			MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x196
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
+		>;
+	};
+};
-- 
2.17.1

