Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48B029632E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2902149AbgJVQ6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898385AbgJVQ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:58:05 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EEAC0613CE;
        Thu, 22 Oct 2020 09:58:04 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id n5so2356989ile.7;
        Thu, 22 Oct 2020 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0heAdzJAXu19yh+gYKVbFWBUqtlwBl7BMdIFJu9fVxM=;
        b=pZC+iTBQs8uaBVojP2dzv30Ma7QVWmdFnA8V41zWSqJLV4nE5Y7pD/MRJOr+WqkGGa
         h+kDs6sqXDIXzRggFYELYhXZjLqEx0L54I1V3eq4xoot4BYCAARbJsk28qqwcLjVNr7e
         W8O+KIje7rwAfWDD32RIT+CALJrv3IwQq3S7Jct2cbosPzcS+TPeq8Ye77rTeyoMN8hZ
         vBqPi7byA2XGl4a4AP8DfIdslR0eXgYlebgtgsXDB+UnBX5WHDyUUmfy5HP63RDapZy2
         mVM+0lX3/Ei4LmZIcXURxQBb+xmWhx/Zfx3OL6QoTOaSSVNCkd4Su3+5AMXcUc4Hj0t2
         KKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0heAdzJAXu19yh+gYKVbFWBUqtlwBl7BMdIFJu9fVxM=;
        b=Z70NQ5AKwRXSBbsdfuizyao2lEAlHom5jyCQM7R9xBImB8V87ysIbMwdftkdgxDt/j
         XiNUtsaMnVX2ktwXjElAmqJqxR2kZm84y/0uYmR44p/oiKOmUE3Ulm/efT8kLPiJ8+ka
         fD+eyyHzivbrzZyaKe7dDRpc2HzxUVYSetui3UJVT45ViA5JrczjKNGZOhaV3JgPbLcz
         Pyu1QURhh/PTlWZE8bhy4q82NW4K4bcbjmsMXSyol2LuEJHasY8Vr2USVKej32usvBCd
         kB4NJlEfrVfTLz8/LxIphZRYk7RqQrsMt429AWsJh7aM3J9LRVaeA13vMyXodE2HksEi
         fRwQ==
X-Gm-Message-State: AOAM53179h70WiMXhYGNI0u9FVtrTcrgX2aHsxbOwnabJb5q3+bU72dA
        c+v3JEQ4P6BfR1XoFmaEdFk=
X-Google-Smtp-Source: ABdhPJyPvwfVXXucVDL2B5S3ga5JNb31Q43eHUdVXLhFC9j21fNRLzY/3ZgGnxdF1rU2fPQuRI8tDg==
X-Received: by 2002:a92:d804:: with SMTP id y4mr2720374ilm.13.1603385884031;
        Thu, 22 Oct 2020 09:58:04 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:527:767:b750:2d3c])
        by smtp.gmail.com with ESMTPSA id s62sm1536778ili.2.2020.10.22.09.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 09:58:02 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx: Add Beacon i.MX8M Nano development kit
Date:   Thu, 22 Oct 2020 11:57:50 -0500
Message-Id: <20201022165751.771695-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beacon Embeddedworks is launching a development kit based on the
i.MX8M Nano SoC.  The kit consists of a System on Module (SOM)
+ baseboard.  The SOM has the SoC, eMMC, and Ethernet. The baseboard
has an wm8962 audio CODEC, and a single USB OTG.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
Based on top of previous series found:
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=366931

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index c7890b622587..ab47b3b1de75 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -31,6 +31,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mn-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-var-som-symphony.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
new file mode 100644
index 000000000000..898715aa79b5
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2020 Compass Electronics Group, LLC
+ */
+
+/ {
+	leds {
+		compatible = "gpio-leds";
+
+		led0 {
+			label = "gen_led0";
+			gpios = <&pca6416_1 4 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led1 {
+			label = "gen_led1";
+			gpios = <&pca6416_1 5 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led2 {
+			label = "gen_led2";
+			gpios = <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led3 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_led3>;
+			label = "heartbeat";
+			gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	reg_audio: regulator-audio {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3_aud";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416_1 11 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usb_otg_vbus: regulator-usb {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&pinctrl_reg_usb_otg>;
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio4 29 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	sound {
+		compatible = "fsl,imx-audio-wm8962";
+		model = "wm8962-audio";
+		audio-cpu = <&sai3>;
+		audio-codec = <&wm8962>;
+		audio-routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"Ext Spk", "SPKOUTL",
+			"Ext Spk", "SPKOUTR",
+			"AMIC", "MICBIAS",
+			"IN3R", "AMIC";
+	};
+};
+
+&ecspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_espi2>;
+	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	eeprom@0 {
+		compatible = "microchip,at25160bn", "atmel,at25";
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+		spi-cpha;
+		spi-cpol;
+		pagesize = <32>;
+		size = <2048>;
+		address-width = <16>;
+	};
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	status = "okay";
+
+	pca6416_0: gpio@20 {
+		compatible = "nxp,pcal6416";
+		reg = <0x20>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6414>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pca6416_1: gpio@21 {
+		compatible = "nxp,pcal6416";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	wm8962: audio-codec@1a {
+		compatible = "wlf,wm8962";
+		reg = <0x1a>;
+		clocks = <&clk IMX8MN_CLK_SAI3_ROOT>;
+		clock-names = "xclk";
+		DCVDD-supply = <&reg_audio>;
+		DBVDD-supply = <&reg_audio>;
+		AVDD-supply = <&reg_audio>;
+		CPVDD-supply = <&reg_audio>;
+		MICVDD-supply = <&reg_audio>;
+		PLLVDD-supply = <&reg_audio>;
+		SPKVDD1-supply = <&reg_audio>;
+		SPKVDD2-supply = <&reg_audio>;
+		gpio-cfg = <
+			0x0000 /* 0:Default */
+			0x0000 /* 1:Default */
+			0x0000 /* 2:FN_DMICCLK */
+			0x0000 /* 3:Default */
+			0x0000 /* 4:FN_DMICCDAT */
+			0x0000 /* 5:Default */
+		>;
+	};
+};
+
+&easrc {
+	fsl,asrc-rate  = <48000>;
+	status = "okay";
+};
+
+&sai3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3>;
+	assigned-clocks = <&clk IMX8MN_CLK_SAI3>;
+	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
+&snvs_pwrkey {
+	status = "okay";
+};
+
+&uart2 { /* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	assigned-clocks = <&clk IMX8MN_CLK_UART3>;
+	assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_80M>;
+	status = "okay";
+};
+
+&usbotg1 {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	disable-over-current;
+	dr_mode="otg";
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+	bus-width = <4>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_espi2: espi2grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x82
+			MX8MN_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x82
+			MX8MN_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x82
+			MX8MN_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x41
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
+			MX8MN_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_I2C4_SCL_I2C4_SCL		0x400001c3
+			MX8MN_IOMUXC_I2C4_SDA_I2C4_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_led3: led3grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SAI3_RXFS_GPIO4_IO28	0x41
+		>;
+	};
+
+	pinctrl_pcal6414: pcal6414-gpiogrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19
+		>;
+	};
+
+	pinctrl_reg_usb_otg: reg-otggrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SAI3_RXC_GPIO4_IO29     0x19
+		>;
+	};
+
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC     0xd6
+			MX8MN_IOMUXC_SAI3_TXC_SAI3_TX_BCLK      0xd6
+			MX8MN_IOMUXC_SAI3_MCLK_SAI3_MCLK        0xd6
+			MX8MN_IOMUXC_SAI3_TXD_SAI3_TX_DATA0     0xd6
+			MX8MN_IOMUXC_SAI3_RXD_SAI3_RX_DATA0	0xd6
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
+			MX8MN_IOMUXC_UART2_TXD_UART2_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_ECSPI1_SCLK_UART3_DCE_RX	0x40
+			MX8MN_IOMUXC_ECSPI1_MOSI_UART3_DCE_TX	0x40
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SD2_CD_B_USDHC2_CD_B	0x41
+			MX8MN_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK	0x190
+			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD	0x1d0
+			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d0
+			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d0
+			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d0
+			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d0
+			MX8MN_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK	0x194
+			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD	0x1d4
+			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
+			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
+			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
+			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
+			MX8MN_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK	0x196
+			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD	0x1d6
+			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d6
+			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d6
+			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d6
+			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d6
+			MX8MN_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
new file mode 100644
index 000000000000..faa55d888065
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2020 Compass Electronics Group, LLC
+ */
+
+/dts-v1/;
+
+#include "imx8mn.dtsi"
+#include "imx8mn-beacon-som.dtsi"
+#include "imx8mn-beacon-baseboard.dtsi"
+
+/ {
+	model = "Beacon EmbeddedWorks i.MX8M Mini Development Kit";
+	compatible = "beacon,imx8mn-beacon-kit", "fsl,imx8mn";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
new file mode 100644
index 000000000000..a2ce036b37f3
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
@@ -0,0 +1,429 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2020 Compass Electronics Group, LLC
+ */
+
+/ {
+	usdhc1_pwrseq: usdhc1_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usdhc1_gpio>;
+		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
+		clocks = <&osc_32k>;
+		clock-names = "ext_clock";
+		post-power-on-delay-ms = <80>;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0 0x80000000>;
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
+/* DDR controller is running LPDDR at 800MHz which requires 0.95V */
+&a53_opp_table {
+	opp-1200000000 {
+		opp-microvolt = <950000>;
+	};
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
+		opp-800M {
+			opp-hz = /bits/ 64 <800000000>;
+		};
+	};
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
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
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
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
+				// BUCK5 in datasheet
+				regulator-name = "buck3";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck4_reg: BUCK4 {
+				// BUCK6 in datasheet
+				regulator-name = "buck4";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5_reg: BUCK5 {
+				// BUCK7 in datasheet
+				regulator-name = "buck5";
+				regulator-min-microvolt = <1605000>;
+				regulator-max-microvolt = <1995000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6_reg: BUCK6 {
+				// BUCK8 in datasheet
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
+				regulator-max-microvolt = <3300000>;
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
+	eeprom@50 {
+		compatible = "microchip,24c64", "atmel,24c64";
+		pagesize = <32>;
+		read-only;	/* Manufacturing EEPROM programmed at factory */
+		reg = <0x50>;
+	};
+
+	rtc@51 {
+		compatible = "nxp,pcf85263";
+		reg = <0x51>;
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	assigned-clocks = <&clk IMX8MN_CLK_UART1>;
+	assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_80M>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		shutdown-gpios = <&gpio2 6 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
+		device-wakeup-gpios = <&gpio2 7 GPIO_ACTIVE_HIGH>;
+		clocks = <&osc_32k>;
+		clock-names = "extclk";
+	};
+};
+
+&usdhc1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	bus-width = <4>;
+	non-removable;
+	cap-power-off-card;
+	pm-ignore-notify;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&usdhc1_pwrseq>;
+	status = "okay";
+
+	brcmf: bcrmf@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wlan>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host-wake";
+	};
+};
+
+&usdhc3 {
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
+			MX8MN_IOMUXC_ENET_MDC_ENET1_MDC		0x3
+			MX8MN_IOMUXC_ENET_MDIO_ENET1_MDIO	0x3
+			MX8MN_IOMUXC_ENET_TD3_ENET1_RGMII_TD3	0x1f
+			MX8MN_IOMUXC_ENET_TD2_ENET1_RGMII_TD2	0x1f
+			MX8MN_IOMUXC_ENET_TD1_ENET1_RGMII_TD1	0x1f
+			MX8MN_IOMUXC_ENET_TD0_ENET1_RGMII_TD0	0x1f
+			MX8MN_IOMUXC_ENET_RD3_ENET1_RGMII_RD3	0x91
+			MX8MN_IOMUXC_ENET_RD2_ENET1_RGMII_RD2	0x91
+			MX8MN_IOMUXC_ENET_RD1_ENET1_RGMII_RD1	0x91
+			MX8MN_IOMUXC_ENET_RD0_ENET1_RGMII_RD0	0x91
+			MX8MN_IOMUXC_ENET_TXC_ENET1_RGMII_TXC	0x1f
+			MX8MN_IOMUXC_ENET_RXC_ENET1_RGMII_RXC	0x91
+			MX8MN_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
+			MX8MN_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
+			MX8MN_IOMUXC_SAI2_RXC_GPIO4_IO22	0x19
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_I2C1_SCL_I2C1_SCL		0x400001c3
+			MX8MN_IOMUXC_I2C1_SDA_I2C1_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_I2C3_SCL_I2C3_SCL		0x400001c3
+			MX8MN_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_pmic: pmicirqgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x141
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_UART1_RXD_UART1_DCE_RX	0x140
+			MX8MN_IOMUXC_UART1_TXD_UART1_DCE_TX	0x140
+			MX8MN_IOMUXC_UART3_RXD_UART1_DCE_CTS_B	0x140
+			MX8MN_IOMUXC_UART3_TXD_UART1_DCE_RTS_B	0x140
+			MX8MN_IOMUXC_SD1_DATA4_GPIO2_IO6	0x19
+			MX8MN_IOMUXC_SD1_DATA5_GPIO2_IO7	0x19
+			MX8MN_IOMUXC_SD1_DATA6_GPIO2_IO8	0x19
+			MX8MN_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K	0x141
+		>;
+	};
+
+	pinctrl_usdhc1_gpio: usdhc1gpiogrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SD1_RESET_B_GPIO2_IO10	0x41
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
+			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
+			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
+			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
+			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
+			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK		0x194
+			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d4
+			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d4
+			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d4
+			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d4
+			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d4
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK		0x196
+			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d6
+			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d6
+			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d6
+			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d6
+			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d6
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_NAND_WE_B_USDHC3_CLK		0x190
+			MX8MN_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d0
+			MX8MN_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d0
+			MX8MN_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d0
+			MX8MN_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d0
+			MX8MN_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d0
+			MX8MN_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d0
+			MX8MN_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d0
+			MX8MN_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d0
+			MX8MN_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d0
+			MX8MN_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x190
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_NAND_WE_B_USDHC3_CLK		0x194
+			MX8MN_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d4
+			MX8MN_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d4
+			MX8MN_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d4
+			MX8MN_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d4
+			MX8MN_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d4
+			MX8MN_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d4
+			MX8MN_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d4
+			MX8MN_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d4
+			MX8MN_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d4
+			MX8MN_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x194
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_NAND_WE_B_USDHC3_CLK		0x196
+			MX8MN_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d6
+			MX8MN_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d6
+			MX8MN_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d6
+			MX8MN_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d6
+			MX8MN_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d6
+			MX8MN_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d6
+			MX8MN_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d6
+			MX8MN_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d6
+			MX8MN_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d6
+			MX8MN_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x196
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
+		>;
+	};
+
+	pinctrl_wlan: wlangrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SD1_DATA7_GPIO2_IO9		0x111
+		>;
+	};
+};
-- 
2.25.1

