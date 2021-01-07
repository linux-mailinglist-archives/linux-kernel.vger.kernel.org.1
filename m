Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BB02EC914
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 04:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbhAGDZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 22:25:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbhAGDZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:25:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8812122D01;
        Thu,  7 Jan 2021 03:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609989862;
        bh=wUb8j7RpfuFz4rp74nJMt84w4sTUzOQ2VBRT49zWgoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UQ4YATr6BSo8+VsYaU4MPGhiqmJQr8niJJV6khjDMWxAQgKhxQAS9MCINZ2iQS6CC
         Y8Aqd5ZMW6QblAFfMPech0rnI8/DQV+rtLwL3mL74cLi2T5JlcFSgr8BzijH1Gs/eY
         qyMNqTxkzfm4a0pSfFA7x5CV2e7TeZNpjnXHJ7+sao0ZxGqIb7oJd06tbQv+P1P6MB
         OBjsAKOj6SBjMqhqHsELtXV5ckswB5JorD9arWgQnn8j4Ah0oKLvI+BXtTNb5IvtR3
         nQ9jqOTpsbSBaEgMcEVvXtIWVCbIyMVBNT9Cn6hT7Keq4ES0Sazd0ZCYByoNMLAtEp
         RM4YhhLk7o1mg==
Date:   Thu, 7 Jan 2021 11:24:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 2/2] ARM: dts: add Protonic PRTI6G board
Message-ID: <20210107032412.GT4142@dragon>
References: <20201209130016.10431-1-o.rempel@pengutronix.de>
 <20201209130016.10431-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209130016.10431-2-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 02:00:16PM +0100, Oleksij Rempel wrote:
> Protonic PRTI6G is a reference platform for industrial, safety critical
> applications
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  arch/arm/boot/dts/Makefile          |   1 +
>  arch/arm/boot/dts/imx6ul-prti6g.dts | 356 ++++++++++++++++++++++++++++
>  2 files changed, 357 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6ul-prti6g.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d15442a464a3..c0c5ac48d8ef 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -634,6 +634,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
>  	imx6ul-pico-pi.dtb \
>  	imx6ul-phytec-segin-ff-rdk-emmc.dtb \
>  	imx6ul-phytec-segin-ff-rdk-nand.dtb \
> +	imx6ul-prti6g.dtb \
>  	imx6ul-tx6ul-0010.dtb \
>  	imx6ul-tx6ul-0011.dtb \
>  	imx6ul-tx6ul-mainboard.dtb \
> diff --git a/arch/arm/boot/dts/imx6ul-prti6g.dts b/arch/arm/boot/dts/imx6ul-prti6g.dts
> new file mode 100644
> index 000000000000..183d9c8a88a0
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ul-prti6g.dts
> @@ -0,0 +1,356 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright (c) 2016 Protonic Holland
> + * Copyright (c) 2020 Oleksij Rempel <kernel@pengutronix.de>, Pengutronix
> + */
> +
> +/dts-v1/;
> +#include "imx6ul.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "Protonic PRTI6G Board";
> +	compatible = "prt,prti6g", "fsl,imx6ul";
> +
> +	chosen {
> +		stdout-path = &uart1;
> +	};
> +
> +	clock_ksz8081_in: clock-ksz8081-in {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <25000000>;
> +	};
> +
> +	clock_ksz8081_out: clock-ksz8081-out {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <50000000>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_leds>;
> +
> +		led-0 {
> +			label = "debug0";
> +			gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	reg_3v2: regulator-3v2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3v2";
> +		regulator-min-microvolt = <3200000>;
> +		regulator-max-microvolt = <3200000>;
> +	};
> +};
> +
> +&can1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_can1>;
> +	status = "okay";
> +};
> +
> +&can2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_can2>;
> +	status = "okay";
> +};
> +
> +&ecspi1 {
> +	cs-gpios = <&gpio4 26 GPIO_ACTIVE_LOW>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi1>;
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <20000000>;
> +	};
> +};
> +
> +&ecspi2 {
> +	cs-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi2>;
> +	status = "okay";
> +
> +	spi@0 {
> +		compatible = "spidev";
> +		reg = <0>;
> +		spi-max-frequency = <1000000>;
> +	};
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_eth1>;
> +	phy-mode = "rmii";
> +	phy-handle = <&rmii_phy>;
> +	clocks = <&clks IMX6UL_CLK_ENET>,
> +		 <&clks IMX6UL_CLK_ENET_AHB>,
> +		 <&clks IMX6UL_CLK_ENET_PTP>,
> +		 <&clock_ksz8081_out>;
> +	clock-names = "ipg", "ahb", "ptp",
> +		      "enet_clk_ref";
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* Microchip KSZ8081RNA PHY */
> +		rmii_phy: ethernet-phy@0 {
> +			reg = <0>;
> +			interrupts-extended = <&gpio5 1 IRQ_TYPE_LEVEL_LOW>;
> +			reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <10000>;
> +			reset-deassert-us = <300>;
> +			clocks = <&clock_ksz8081_in>;
> +			clock-names = "rmii-ref";
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	clock-frequency = <100000>;
> +	status = "okay";
> +
> +	/* additional i2c devices are added automatically by the boot loader */
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	clock-frequency = <100000>;
> +	status = "okay";
> +
> +	adc@49 {
> +		compatible = "ti,ads1015";
> +		reg = <0x49>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		channel@4 {
> +			reg = <4>;
> +			ti,gain = <3>;
> +			ti,datarate = <3>;
> +		};
> +
> +		channel@5 {
> +			reg = <5>;
> +			ti,gain = <3>;
> +			ti,datarate = <3>;
> +		};
> +
> +		channel@6 {
> +			reg = <6>;
> +			ti,gain = <3>;
> +			ti,datarate = <3>;
> +		};
> +
> +		channel@7 {
> +			reg = <7>;
> +			ti,gain = <3>;
> +			ti,datarate = <3>;
> +		};
> +	};
> +
> +	rtc@51 {
> +		compatible = "nxp,pcf8563";
> +		reg = <0x51>;
> +	};
> +
> +	temperature-sensor@70 {
> +		compatible = "ti,tmp103";
> +		reg = <0x70>;
> +	};
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	cd-gpios = <&gpio4 12 GPIO_ACTIVE_LOW>;
> +	vmmc-supply = <&reg_3v2>;
> +	no-1-8-v;
> +	disable-wp;
> +	cap-sd-highspeed;
> +	no-mmc;
> +	no-sdio;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	bus-width = <8>;
> +	no-1-8-v;
> +	non-removable;
> +	no-sd;
> +	no-sdio;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	pinctrl_hog: hoggrp {
> +		fsl,pins = <
> +			/* HW revision detect */
> +			/* REV_ID0 */
> +			MX6UL_PAD_ENET2_RX_DATA0__GPIO2_IO08		0x1b0b0
> +			/* REV_ID1 */
> +			MX6UL_PAD_ENET2_RX_DATA1__GPIO2_IO09		0x1b0b0
> +			/* REV_ID2 */
> +			MX6UL_PAD_ENET2_RX_EN__GPIO2_IO10		0x1b0b0
> +			/* REV_ID3 */
> +			MX6UL_PAD_ENET2_TX_DATA0__GPIO2_IO11		0x1b0b0
> +			/* BOARD_ID0 */
> +			MX6UL_PAD_ENET2_TX_EN__GPIO2_IO13		0x1b0b0
> +			/* BOARD_ID1 */
> +			MX6UL_PAD_ENET2_TX_CLK__GPIO2_IO14		0x1b0b0
> +			/* BOARD_ID2 */
> +			MX6UL_PAD_ENET2_RX_ER__GPIO2_IO15		0x1b0b0
> +			/* BOARD_ID3 */
> +			MX6UL_PAD_ENET2_TX_DATA1__GPIO2_IO12		0x1b0b0
> +			/* Safety controller IO */
> +			/* WAKE_SC */
> +			MX6UL_PAD_SNVS_TAMPER6__GPIO5_IO06		0x1b0b0
> +			/* PROGRAM_SC */
> +			MX6UL_PAD_SNVS_TAMPER7__GPIO5_IO07		0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_leds: ledsgrp {
> +		fsl,pins = <
> +			MX6UL_PAD_NAND_DQS__GPIO4_IO16			0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX		0x1b0b1
> +			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX		0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD			0x070b1
> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK			0x07099
> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0		0x070b1
> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1		0x070b1
> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2		0x070b1
> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3		0x070b1
> +			/* SD1 CD */
> +			MX6UL_PAD_NAND_READY_B__GPIO4_IO12		0x170b0
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX6UL_PAD_NAND_WE_B__USDHC2_CMD			0x170f9
> +			MX6UL_PAD_NAND_RE_B__USDHC2_CLK			0x100f9
> +			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0		0x170f9
> +			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1		0x170f9
> +			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2		0x170f9
> +			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3		0x170f9
> +			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4		0x170f9
> +			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5		0x170f9
> +			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6		0x170f9
> +			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7		0x170f9
> +			MX6UL_PAD_NAND_ALE__USDHC2_RESET_B		0x170b0
> +		>;
> +	};
> +
> +	pinctrl_ecspi1: ecspi1grp {

Try to keep these pinctrl entries sort alphabetically.

Shawn

> +		fsl,pins = <
> +			MX6UL_PAD_CSI_DATA04__ECSPI1_SCLK		0x0b0b0
> +			MX6UL_PAD_CSI_DATA05__GPIO4_IO26		0x000b1
> +			MX6UL_PAD_CSI_DATA06__ECSPI1_MOSI		0x0b0b0
> +			MX6UL_PAD_CSI_DATA07__ECSPI1_MISO		0x0b0b0
> +		>;
> +	};
> +
> +	pinctrl_ecspi2: ecspi2grp {
> +		fsl,pins = <
> +			MX6UL_PAD_CSI_DATA00__ECSPI2_SCLK		0x0b0b0
> +			MX6UL_PAD_CSI_DATA01__GPIO4_IO22		0x000b1
> +			MX6UL_PAD_CSI_DATA02__ECSPI2_MOSI		0x0b0b0
> +			MX6UL_PAD_CSI_DATA03__ECSPI2_MISO		0x0b0b0
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_CSI_MCLK__I2C1_SDA		0x4001b8b0
> +			MX6UL_PAD_CSI_PIXCLK__I2C1_SCL		0x4001b8b0
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			MX6UL_PAD_CSI_VSYNC__I2C2_SDA		0x4001b8b0
> +			MX6UL_PAD_CSI_HSYNC__I2C2_SCL		0x4001b8b0
> +		>;
> +	};
> +
> +	pinctrl_eth1: eth1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_GPIO1_IO07__ENET1_MDC			0x1b0b0
> +			MX6UL_PAD_GPIO1_IO06__ENET1_MDIO		0x100b0
> +			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00		0x1b0b0
> +			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01		0x1b0b0
> +			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN		0x100b0
> +			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER		0x1b0b0
> +			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN		0x1b0b0
> +			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00		0x1b0b0
> +			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01		0x1b0b0
> +			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1		0x1b000
> +			/* PHY ENET1_RST */
> +			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00		0x00880
> +			/* PHY ENET1_IRQ */
> +			MX6UL_PAD_SNVS_TAMPER1__GPIO5_IO01		0x00880
> +		>;
> +	};
> +
> +	pinctrl_can1: can1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART3_CTS_B__FLEXCAN1_TX		0x0b0b0
> +			MX6UL_PAD_UART3_RTS_B__FLEXCAN1_RX		0x0b0b0
> +			/* SR */
> +			MX6UL_PAD_SNVS_TAMPER3__GPIO5_IO03		0x0b0b0
> +			/* TERM */
> +			MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04		0x0b0b0
> +			/* nSMBALERT */
> +			MX6UL_PAD_SNVS_TAMPER2__GPIO5_IO02		0x0b0b0
> +		>;
> +	};
> +
> +	pinctrl_can2: flexcan2grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART2_CTS_B__FLEXCAN2_TX		0x0b0b0
> +			MX6UL_PAD_UART2_RTS_B__FLEXCAN2_RX		0x0b0b0
> +			/* SR */
> +			MX6UL_PAD_SNVS_TAMPER5__GPIO5_IO05		0x0b0b0
> +		>;
> +	};
> +};
> -- 
> 2.29.2
> 
