Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8841C29D6CA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbgJ1WSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:18:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731766AbgJ1WRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:45 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4745B24730;
        Wed, 28 Oct 2020 12:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603888852;
        bh=aMmK8dkncCk8JCZaSBOmzqM54G2+JyReFluBGnBJ4n4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S2/Yhyutt1q+j53hL9XhE++phjn2I8eQimIPDhmZyFBHZdjNWFkbX+BIJzICQB88+
         FvYzqUgjm+WhPQwHn1cj/B84bmssD1jwDCgB9xgZkb8EfPTao//ef2jsfc4pHyL13F
         Sh4Hjj6zfClFLJad46aLVYoodR+rr4lKL5BSb+iE=
Date:   Wed, 28 Oct 2020 20:40:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, bth@kamstrup.com
Subject: Re: [PATCH v3 2/2] ARM: dts: imx7: add support for kamstrup flex
 concentrator
Message-ID: <20201028124045.GL28755@dragon>
References: <20200923154024.11417-1-bruno.thomsen@gmail.com>
 <20200923154024.11417-2-bruno.thomsen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923154024.11417-2-bruno.thomsen@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 05:40:24PM +0200, Bruno Thomsen wrote:
> This adds support for the OMNIA Flex Concentrator product
> from Kamstrup A/S. It's providing radio mesh communication
> infrastructure for smart electricity meters.
> 
> Kamstrup OMNIA is a modular and scalable smart grid platform.
> 
> Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> ---
> Changes since version 2:
> - Found root cause of Ethernet PHY auto detect issue and created
>   a mdio patch series that resolves the issue.
>   https://lore.kernel.org/netdev/20200730195749.4922-1-bruno.thomsen@gmail.com/
> - Ethernet PHY reset is using new MDIO bus reset.
> - Ethernet PHY interrupt added.
> - Removed SION from a few GPIOs used for Ethernet PHY.
> 
> Changes since version 1:
> - Sorted labeling nodes.
> - Sorted pinctrl entries.
> - Removed deprecated fec phy reset properties.
> - Added mdio phy reset properties.
> - Disabled phy type auto detection and added note to commit message.
> - Fixed two comment typos.
> 
>  arch/arm/boot/dts/Makefile                    |   2 +
>  .../boot/dts/imx7d-flex-concentrator-mfg.dts  |  25 ++
>  arch/arm/boot/dts/imx7d-flex-concentrator.dts | 319 ++++++++++++++++++
>  3 files changed, 346 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dts
>  create mode 100644 arch/arm/boot/dts/imx7d-flex-concentrator.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4572db3fa5ae..15be5a2fe831 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -634,6 +634,8 @@ dtb-$(CONFIG_SOC_IMX7D) += \
>  	imx7d-colibri-emmc-aster.dtb \
>  	imx7d-colibri-emmc-eval-v3.dtb \
>  	imx7d-colibri-eval-v3.dtb \
> +	imx7d-flex-concentrator.dtb \
> +	imx7d-flex-concentrator-mfg.dtb \
>  	imx7d-mba7.dtb \
>  	imx7d-meerkat96.dtb \
>  	imx7d-nitrogen7.dtb \
> diff --git a/arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dts b/arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dts
> new file mode 100644
> index 000000000000..789f0837058f
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx7d-flex-concentrator-mfg.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for Kamstrup OMNIA Flex Concentrator in
> + * manufacturing/debugging mode.
> + *
> + * Copyright (C) 2020 Kamstrup A/S
> + * Author: Bruno Thomsen <bruno.thomsen@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "imx7d-flex-concentrator.dts"
> +
> +/ {
> +	model = "Kamstrup OMNIA Flex Concentrator - Manufacturing";
> +	compatible = "kam,imx7d-flex-concentrator-mfg", "kam,imx7d-flex-concentrator", "fsl,imx7d";

'make dtbs_check' reports the following issue:

    compatible: ['kam,imx7d-flex-concentrator-mfg', 'kam,imx7d-flex-concentrator', 'fsl,imx7d'] is too long

I think dropping 'kam,imx7d-flex-concentrator' should fix it.

> +
> +	chosen {
> +		stdout-path = &uart4;
> +	};
> +};
> +
> +&uart4 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx7d-flex-concentrator.dts b/arch/arm/boot/dts/imx7d-flex-concentrator.dts
> new file mode 100644
> index 000000000000..9f73c79253cb
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx7d-flex-concentrator.dts
> @@ -0,0 +1,319 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for Kamstrup OMNIA Flex Concentrator.
> + *
> + * Copyright (C) 2020 Kamstrup A/S
> + * Author: Bruno Thomsen <bruno.thomsen@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "imx7d-tqma7.dtsi"
> +
> +/* Some I2C devices on TQMa7 SoM are not mounted */
> +/delete-node/ &m24c64;
> +/delete-node/ &ds1339;
> +
> +/ {
> +	model = "Kamstrup OMNIA Flex Concentrator";
> +	compatible = "kam,imx7d-flex-concentrator", "fsl,imx7d";
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		/* 1024 MB - TQMa7D board configuration */
> +		reg = <0x80000000 0x40000000>;
> +	};
> +
> +	reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VBUS_USBOTG2";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio1 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_vref_1v8: regulator-vref-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC1V8_REF";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +		vin-supply = <&sw2_reg>;
> +	};
> +
> +	/*
> +	 * Human Machine Interface consists of 4 dual red/green LEDs.
> +	 * hmi-a-green is controlled directly by the switch-mode power supply.
> +	 * hmi-a-red is not used.
> +	 */
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_leds>;
> +
> +		hmi-b-red {

gpio-leds: 'hmi-b-green', 'hmi-b-red', 'hmi-c-green', 'hmi-c-red', 'hmi-d-green', 'hmi-d-red' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml

Shawn

> +			label = "hmi-b:red:provisioning";
> +			gpios = <&gpio3 6 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		hmi-b-green {
> +			label = "hmi-b:green:operation";
> +			gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		hmi-c-red {
> +			label = "hmi-c:red:mesh-error";
> +			gpios = <&gpio2 29 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		hmi-c-green {
> +			label = "hmi-c:green:mesh-activity";
> +			gpios = <&gpio2 30 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		hmi-d-red {
> +			label = "hmi-d:red:wan-down";
> +			gpios = <&gpio2 31 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		hmi-d-green {
> +			label = "hmi-d:green:ipsec-up";
> +			gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	/*
> +	 * Errata e10574 board restart workaround.
> +	 */
> +	gpio-restart {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_restart>;
> +		compatible = "gpio-restart";
> +		gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
> +		priority = <200>;
> +	};
> +};
> +
> +/*
> + * Analog signals
> + * ADC1_IN0: SMPS - 5V output monitor (voltage divider: 1/0.2806)
> + */
> +&adc1 {
> +	vref-supply = <&reg_vref_1v8>;
> +	status = "okay";
> +};
> +
> +&ecspi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi2>;
> +	num-chipselects = <1>;
> +	cs-gpios = <&gpio4 23 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +
> +	pcf2127: rtc@0 {
> +		compatible = "nxp,pcf2127";
> +		reg = <0>;
> +		spi-max-frequency = <2000000>;
> +	};
> +};
> +
> +&ecspi4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi4>;
> +	num-chipselects = <1>;
> +	cs-gpios = <&gpio3 3 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +
> +	/*
> +	 * ST chip maximum SPI clock frequency is 33 MHz.
> +	 *
> +	 * TCG specification - Section 6.4.1 Clocking:
> +	 * TPM shall support a SPI clock frequency range of 10-24 MHz.
> +	 */
> +	st33htph: tpm-tis@0 {
> +		compatible = "st,st33htpm-spi", "tcg,tpm_tis-spi";
> +		reg = <0>;
> +		spi-max-frequency = <24000000>;
> +	};
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet1>;
> +	phy-mode = "rmii";
> +	phy-handle = <&ethphy>;
> +	status = "okay";
> +
> +	/*
> +	 * MDIO bus reset is used to generate PHY device reset before
> +	 * Ethernet PHY type ID auto-detection. Otherwise this communication
> +	 * fails as device does not answer when recommended reset circuit
> +	 * is used.
> +	 */
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		reset-delay-us = <100000>;
> +		reset-post-delay-us = <500000>;
> +		reset-gpios = <&gpio7 15 GPIO_ACTIVE_LOW>;
> +
> +		/* Microchip/Micrel KSZ8081RNB */
> +		ethphy: ethernet-phy@1 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			interrupt-parent = <&gpio1>;
> +			interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
> +			reg = <1>;
> +		};
> +	};
> +};
> +
> +/*
> + * Detection signals for internal USB modules.
> + * Used for robust USB plug and play handling such as USB downstream port
> + * power-cycle and USB hub reset in case of misbehaving or crashed modules.
> + *
> + * SMPS - AC input monitor based on zero crossing.
> + * Used for last gasp notification.
> + */
> +&gpio3 {
> +	gpio-line-names = "", "", "", "", "", "", "", "",
> +	"", "", "", "", "smps-ac-monitor", "", "usb-hub-reset", "",
> +	"", "", "", "", "", "", "", "",
> +	"", "module-b-detection", "", "module-a-detection", "", "", "", "";
> +};
> +
> +/*
> + * Tamper IRQ trigger timestamp reading.
> + * Used for sealed cover opened/closed notification.
> + */
> +&gpio5 {
> +	gpio-line-names = "", "", "", "", "", "", "", "",
> +	"", "", "", "", "rtc-tamper-irq", "", "", "",
> +	"", "", "", "", "", "", "", "",
> +	"", "", "", "", "", "", "", "";
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_misc>;
> +
> +	pinctrl_ecspi2: ecspi2grp {
> +		fsl,pins = <
> +			MX7D_PAD_ECSPI2_MISO__ECSPI2_MISO		0x7c /* X2-15 */
> +			MX7D_PAD_ECSPI2_MOSI__ECSPI2_MOSI		0x74 /* X2-18 */
> +			MX7D_PAD_ECSPI2_SCLK__ECSPI2_SCLK		0x74 /* X2-13 */
> +			MX7D_PAD_ECSPI2_SS0__GPIO4_IO23			0x74 /* X2-20 */
> +			/* RTC - Tamper IRQ */
> +			MX7D_PAD_SD2_CLK__GPIO5_IO12			0x3c /* X1-92 */
> +		>;
> +	};
> +
> +	pinctrl_ecspi4: ecspi4grp {
> +		fsl,pins = <
> +			MX7D_PAD_LCD_CLK__ECSPI4_MISO			0x7c /* X2-72 */
> +			MX7D_PAD_LCD_ENABLE__ECSPI4_MOSI		0x74 /* X2-68 */
> +			MX7D_PAD_LCD_HSYNC__ECSPI4_SCLK			0x74 /* X2-76 */
> +			MX7D_PAD_LCD_VSYNC__GPIO3_IO3			0x74 /* X2-78 */
> +		>;
> +	};
> +
> +	pinctrl_enet1: enet1grp {
> +		fsl,pins = <
> +			MX7D_PAD_GPIO1_IO10__ENET1_MDIO			0x03 /* X2-48 */
> +			MX7D_PAD_GPIO1_IO11__ENET1_MDC			0x03 /* X2-46 */
> +			MX7D_PAD_ENET1_RGMII_TD0__ENET1_RGMII_TD0	0x71 /* X2-53 */
> +			MX7D_PAD_ENET1_RGMII_TD1__ENET1_RGMII_TD1	0x71 /* X2-55 */
> +			MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL	0x71 /* X2-61 */
> +			MX7D_PAD_ENET1_RGMII_RD0__ENET1_RGMII_RD0	0x79 /* X2-56 */
> +			MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1	0x79 /* X2-58 */
> +			MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x79 /* X2-64 */
> +			MX7D_PAD_ENET1_RGMII_RXC__ENET1_RX_ER		0x73 /* X2-52 */
> +			/* PHY reset: SRE_FAST, DSE_X1 */
> +			MX7D_PAD_ENET1_COL__GPIO7_IO15			0x00 /* X1-96 */
> +			/* Clock from PHY to MAC: 100kPU */
> +			MX7D_PAD_GPIO1_IO12__CCM_ENET_REF_CLK1		0x70 /* X3-4 */
> +			/* PHY interrupt: 100kPU, HYS */
> +			MX7D_PAD_GPIO1_IO09__GPIO1_IO9			0x78 /* X1-80 */
> +		>;
> +	};
> +
> +	pinctrl_leds: ledsgrp {
> +		fsl,pins = <
> +			MX7D_PAD_LCD_DATA01__GPIO3_IO6			0x14 /* X2-82 */
> +			MX7D_PAD_EPDC_BDR0__GPIO2_IO28			0x14 /* X1-82 */
> +			MX7D_PAD_EPDC_BDR1__GPIO2_IO29			0x14 /* X1-84 */
> +			MX7D_PAD_EPDC_PWR_COM__GPIO2_IO30		0x14 /* X1-86 */
> +			MX7D_PAD_EPDC_PWR_STAT__GPIO2_IO31		0x14 /* X1-88 */
> +			MX7D_PAD_UART2_TX_DATA__GPIO4_IO3		0x14 /* X1-90 */
> +		>;
> +	};
> +
> +	pinctrl_misc: miscgrp {
> +		fsl,pins = <
> +			/* Module A detection (low = present) */
> +			MX7D_PAD_LCD_DATA22__GPIO3_IO27			0x7c /* X2-105 */
> +			/* Module B detection (low = present) */
> +			MX7D_PAD_LCD_DATA20__GPIO3_IO25			0x7c /* X2-103 */
> +			/* SMPS - AC input monitor (high = failure) */
> +			MX7D_PAD_LCD_DATA07__GPIO3_IO12			0x7c /* X2-88 */
> +			/* USB - Hub reset */
> +			MX7D_PAD_LCD_DATA09__GPIO3_IO14			0x74 /* X2-92 */
> +		>;
> +	};
> +
> +	pinctrl_restart: restartgrp {
> +		fsl,pins = <
> +			MX7D_PAD_ENET1_TX_CLK__GPIO7_IO12	0x74 /* X1-94 */
> +		>;
> +	};
> +
> +	pinctrl_uart4: uart4grp {
> +		fsl,pins = <
> +			MX7D_PAD_SAI2_TX_SYNC__UART4_DCE_RX	0x7e /* X3-14 */
> +			MX7D_PAD_SAI2_TX_BCLK__UART4_DCE_TX	0x76 /* X3-16 */
> +		>;
> +	};
> +};
> +
> +&iomuxc_lpsr {
> +	pinctrl_usbotg2: usbotg2grp {
> +		fsl,pins = <
> +			MX7D_PAD_LPSR_GPIO1_IO06__USB_OTG2_OC	0x5c /* X3-11 */
> +			MX7D_PAD_LPSR_GPIO1_IO07__GPIO1_IO7	0x59 /* X3-9 */
> +		>;
> +	};
> +
> +};
> +
> +&uart4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart4>;
> +	assigned-clocks = <&clks IMX7D_UART4_ROOT_SRC>;
> +	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
> +};
> +
> +&usbotg2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbotg2>;
> +	vbus-supply = <&reg_usb_otg2_vbus>;
> +	srp-disable;
> +	hnp-disable;
> +	adp-disable;
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +/*
> + * External watchdog feature provided by pcf2127.
> + */
> +&wdog1 {
> +	status = "disabled";
> +};
> -- 
> 2.26.2
> 
