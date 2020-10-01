Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA6427FF9C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbgJAM5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:57:31 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:40313 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731952AbgJAM5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:57:31 -0400
Received: by mail-ej1-f68.google.com with SMTP id p15so7896362ejm.7;
        Thu, 01 Oct 2020 05:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v295ehXfegG0OSaqTmxZ8wr/xupuMjEZ/t93GBHccT4=;
        b=ebi5OIykMNAX9vyene3oQlLQJmGXtilaNFFabRm5Ui4qgnF8YwGoUBBwm1Hqz2ISm7
         AfQUFTXEwVEnio4uqoDSTVz6LHaHBDSRqLCdgJa2LQtOzVMcY3CsNfg18bnVz2pXMGP1
         WC54BO0MeQqoe67YECvYqhcwI6x0qc3r+7+jWEYTvfjGqCNjF/9zltV3bIjjaCl2Kh04
         YtrAT3GFtqIOh8UwvFY2aTqSlMYaNe7+RGinlGPLw8NNWKp5chlWlt1omrYHr8bT0zKI
         qOZ6oYxe27OhE8ety5jadGVO9pOTKsx221eWtAJ2Ej9L8/C7Rqkk/nfjP0QfURjCuE5S
         aYeg==
X-Gm-Message-State: AOAM531H6ZkPp2HVk4w2QpY/4CrlltbZHZueW8U5IBFHhAJFvP/f5b+A
        Vr6tL+12Bdmx2I5GLFRAYSA=
X-Google-Smtp-Source: ABdhPJwWqNHDWcXsDL9jFyPFSONKnPscIXRTH0U9bCajfL+KT1c4IG+H+nzE47ghIeYwRdYyy/m1mw==
X-Received: by 2002:a17:906:d7ab:: with SMTP id pk11mr7910702ejb.472.1601557045846;
        Thu, 01 Oct 2020 05:57:25 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id z17sm4116687edi.90.2020.10.01.05.57.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Oct 2020 05:57:24 -0700 (PDT)
Date:   Thu, 1 Oct 2020 14:57:22 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Li Yang <leoyang.li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?utf-8?Q?S=C3=A9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] arm64: dts: Add the Kontron i.MX8M Mini SoMs and
 baseboards
Message-ID: <20201001125722.GA6082@kozik-lap>
References: <20201001120717.13027-1-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201001120717.13027-1-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 02:06:58PM +0200, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Kontron Electronics GmbH offers small and powerful SoMs based on the
> i.MX8M Mini SoC including PMIC, LPDDR4-RAM, eMMC and SPI NOR.
> 
> The matching baseboards have the same form factor and similar interfaces
> as the other boards from the Kontron "Board-Line" family, including
> SD card, 1G Ethernet, 100M Ethernet, USB Host/OTG, digital IOs, RS232,
> RS485, CAN, LVDS or HDMI, RTC and much more.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
> Changes for v3:
> * Remove needless status properties
> * Remove needless regulator properties for reg_vdd_5v
> * Use proper PHY reset properties in PHY node
> * Use phy-connection-type instead of phy-mode
> * Adjust PMIC node name and label
> * Add over-current-active-low to usbotg1 node
> * Remove redundant bus-width property from usdhc2 node
> * Remove needless regulator-compatible from reg_vdd_snvs
> * Set minimum voltage to 85mV for reg_vdd_snvs
> 
> Changes for v2:
> * Make the licensing less strict (GPL-2.0+ OR MIT)
> * Merge the SoM and baseboard DTs for N8010 and N8011 into one as
>   they only differ in DDR and eMMC size.
> * Change compatibles and model strings to "n810x" and "N8010X".
> * Only use a common memory node that will be updated by the
>   bootloader reflecting the detected DDR size.
> * Improve naming for 16MHz CAN fixed oscillator and set
>   "clock-output-names".
> * Consistently use "reg_" prefix for regulators.
> * Remove "userspi" node.
> * Slightly improve commit message.
> ---
>  .../dts/freescale/imx8mm-kontron-n801x-s.dts  | 323 ++++++++++++++++++
>  .../freescale/imx8mm-kontron-n801x-som.dtsi   | 293 ++++++++++++++++
>  2 files changed, 616 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
> new file mode 100644
> index 000000000000..389e735b2880
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
> @@ -0,0 +1,323 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Copyright (C) 2019 Kontron Electronics GmbH
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mm-kontron-n801x-som.dtsi"
> +
> +/ {
> +	model = "Kontron i.MX8MM N801X S";
> +	compatible = "kontron,imx8mm-n801x-s", "kontron,imx8mm-n801x-som", "fsl,imx8mm";
> +
> +	aliases {
> +		ethernet1 = &usbnet;
> +	};
> +
> +	/* fixed crystal dedicated to mcp2515 */
> +	osc_can: clock-osc-can {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <16000000>;
> +		clock-output-names = "osc-can";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_led>;
> +
> +		led1 {
> +			label = "led1";
> +			gpios = <&gpio4 17 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led2 {
> +			label = "led2";
> +			gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led3 {
> +			label = "led3";
> +			gpios = <&gpio4 18 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led4 {
> +			label = "led4";
> +			gpios = <&gpio4 8 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led5 {
> +			label = "led5";
> +			gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led6 {
> +			label = "led6";
> +			gpios = <&gpio4 7 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	pwm-beeper {
> +		compatible = "pwm-beeper";
> +		pwms = <&pwm2 0 5000 0>;
> +	};
> +
> +	reg_rst_eth2: regulator-rst-eth2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "rst-usb-eth2";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usb_eth2>;
> +		gpio = <&gpio3 2 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	reg_vdd_5v: regulator-5v {

Why do you need it if it cannot be controlled? The CAN driver should use
dummy regulator in absence of real one.

> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd-5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +};
> +
> +&ecspi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi2>;
> +	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +
> +	can0: can@0 {
> +		compatible = "microchip,mcp2515";
> +		reg = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_can>;
> +		clocks = <&osc_can>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
> +		spi-max-frequency = <100000>;
> +		vdd-supply = <&reg_vdd_3v3>;
> +		xceiver-supply = <&reg_vdd_5v>;
> +		status = "okay";

Status should not be needed as it is a default for new nodes.

> +	};
> +};
> +
> +&ecspi3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi3>;
> +	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet>;
> +	phy-connection-type = "rgmii";
> +	phy-handle = <&ethphy>;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy: ethernet-phy@0 {
> +			reg = <0>;
> +			reset-assert-us = <100>;
> +			reset-deassert-us = <100>;
> +			reset-gpios = <&gpio4 27 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +&i2c4 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c4>;
> +	status = "okay";
> +
> +	rtc@32 {
> +		compatible = "epson,rx8900";
> +		reg = <0x32>;
> +	};
> +};
> +
> +&pwm2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm2>;
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	linux,rs485-enabled-at-boot-time;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	dr_mode = "otg";
> +	over-current-active-low;
> +	status = "okay";
> +};
> +
> +&usbotg2 {
> +	dr_mode = "host";
> +	disable-over-current;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	usb1@1 {
> +		compatible = "usb424,9514";
> +		reg = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		usbnet: usbether@1 {
> +			compatible = "usb424,ec00";
> +			reg = <1>;
> +			mac-address = [ 00 00 00 00 00 00 ];

I think you want here local-mac-address (to be filled by U-Boot).
mac-address has slightly different meaning in dtschema.

> +		};
> +	};
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	vmmc-supply = <&reg_vdd_3v3>;
> +	vqmmc-supply = <&reg_nvcc_sd>;
> +	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpio>;
> +
> +	pinctrl_can: cangrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28		0x19
> +		>;
> +	};
> +
> +	pinctrl_ecspi2: ecspi2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x82
> +			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x82
> +			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x82
> +			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x19
> +		>;
> +	};
> +
> +	pinctrl_ecspi3: ecspi3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_UART2_RXD_ECSPI3_MISO		0x82
> +			MX8MM_IOMUXC_UART1_TXD_ECSPI3_MOSI		0x82
> +			MX8MM_IOMUXC_UART1_RXD_ECSPI3_SCLK		0x82
> +			MX8MM_IOMUXC_UART2_TXD_GPIO5_IO25		0x19
> +		>;
> +	};
> +
> +	pinctrl_enet: enetgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x3
> +			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3
> +			MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
> +			MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
> +			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
> +			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
> +			MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
> +			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
> +			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
> +			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
> +			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
> +			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
> +			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
> +			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
> +			MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19 /* PHY RST */
> +			MX8MM_IOMUXC_SAI2_TXC_GPIO4_IO25		0x19 /* ETH IRQ */
> +		>;
> +	};
> +
> +	pinctrl_gpio_led: gpioledgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16		0x19
> +			MX8MM_IOMUXC_SAI1_RXD5_GPIO4_IO7		0x19
> +			MX8MM_IOMUXC_SAI1_RXD6_GPIO4_IO8		0x19
> +			MX8MM_IOMUXC_SAI1_RXD7_GPIO4_IO9		0x19
> +			MX8MM_IOMUXC_SAI1_TXD5_GPIO4_IO17		0x19
> +			MX8MM_IOMUXC_SAI1_TXD6_GPIO4_IO18		0x19
> +			MX8MM_IOMUXC_SAI1_TXD7_GPIO4_IO19		0x19
> +		>;
> +	};
> +
> +	pinctrl_gpio: gpiogrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x19
> +			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x19
> +			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
> +			MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x19
> +			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x19
> +			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8		0x19
> +			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x19
> +			MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x19
> +		>;
> +	};
> +
> +	pinctrl_i2c4: i2c4grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c3
> +			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_pwm2: pwm2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT			0x19
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x140
> +			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x140
> +			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B		0x140
> +			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B		0x140
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x140
> +			MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x140
> +			MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x140
> +			MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x140
> +		>;
> +	};
> +
> +	pinctrl_usb_eth2: usbeth2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_NAND_CE1_B_GPIO3_IO2		0x19
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x190
> +			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d0
> +			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d0
> +			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
> +			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
> +			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
> +			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
> +		>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> new file mode 100644
> index 000000000000..5c6a660f4395
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> @@ -0,0 +1,293 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Copyright (C) 2019 Kontron Electronics GmbH
> + */
> +
> +#include "imx8mm.dtsi"
> +
> +/ {
> +	model = "Kontron i.MX8MM N801X SoM";
> +	compatible = "kontron,imx8mm-n801x-som", "fsl,imx8mm";
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		/*
> +		 * There are multiple SoM flavors with different DDR sizes.
> +		 * The smallest is 1GB. For larger sizes the bootloader will
> +		 * update the reg property.
> +		 */
> +		reg = <0x0 0x40000000 0 0x80000000>;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart3;
> +	};
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&reg_vdd_arm>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&reg_vdd_arm>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&reg_vdd_arm>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&reg_vdd_arm>;
> +};
> +
> +&ddrc {
> +	operating-points-v2 = <&ddrc_opp_table>;
> +
> +	ddrc_opp_table: opp-table {
> +		compatible = "operating-points-v2";
> +
> +		opp-25M {
> +			opp-hz = /bits/ 64 <25000000>;
> +		};
> +
> +		opp-100M {
> +			opp-hz = /bits/ 64 <100000000>;
> +		};
> +
> +		opp-750M {
> +			opp-hz = /bits/ 64 <750000000>;
> +		};
> +	};
> +};
> +
> +&ecspi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi1>;
> +	cs-gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +
> +	spi-flash@0 {
> +		compatible = "mxicy,mx25r1635f", "jedec,spi-nor";
> +		spi-max-frequency = <80000000>;
> +		reg = <0>;
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	pca9450: pmic@25 {
> +		compatible = "nxp,pca9450a";
> +		reg = <0x25>;
> +		pinctrl-0 = <&pinctrl_pmic>;

I guess this was copied from the same sources as other DTS. :) You need
pinctrl-names, otherwise it won't work.

> +		interrupt-parent = <&gpio1>;
> +		interrupts = <0 GPIO_ACTIVE_LOW>;

Same as in other boards, wrong flag. I guess this is IRQ_TYPE_LEVEL_LOW.

I was fixing this recently in all boards (most already in next).

> +
> +		regulators {
> +			reg_vdd_soc: BUCK1 {
> +				regulator-name = "BUCK1";

All regulator names should be lowercase, as dtschema asks. Node names
can stay uppercase, although I guess it would be better to have them
lower as it is also naming convention for device tree.

> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			reg_vdd_arm: BUCK2 {
> +				regulator-name = "BUCK2";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-boot-on;
> +				regulator-ramp-delay = <3125>;
> +				nxp,dvs-run-voltage = <950000>;
> +				nxp,dvs-standby-voltage = <850000>;
> +			};
> +
> +			reg_vdd_dram: BUCK3 {
> +				regulator-name = "BUCK3";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_vdd_3v3: BUCK4 {
> +				regulator-name = "BUCK4";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_vdd_1v8: BUCK5 {
> +				regulator-name = "BUCK5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_nvcc_dram: BUCK6 {
> +				regulator-name = "BUCK6";
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_nvcc_snvs: LDO1 {
> +				regulator-name = "LDO1";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_vdd_snvs: LDO2 {
> +				regulator-name = "LDO2";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_vdda: LDO3 {
> +				regulator-name = "LDO3";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_vdd_phy: LDO4 {
> +				regulator-name = "LDO4";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_nvcc_sd: LDO5 {
> +				regulator-name = "LDO5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +		};
> +	};
> +};
> +
> +&uart3 { /* console */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	vmmc-supply = <&reg_vdd_3v3>;
> +	vqmmc-supply = <&reg_vdd_1v8>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&wdog1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdog>;
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_ecspi1: ecspi1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO		0x82
> +			MX8MM_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI		0x82
> +			MX8MM_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK		0x82
> +			MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x19
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x400001c3
> +			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_pmic: pmicgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x41

Missing pull up.

> +		>;
> +	};
> +
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX		0x140
> +			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX		0x140
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK			0x190
> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD			0x1d0
> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x1d0
> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x1d0
> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x1d0
> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x1d0
> +			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x1d0
> +			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x1d0
> +			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x1d0
> +			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x1d0
> +			MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0x019
> +			MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x190
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {

Put "grp" at the end of node name, so for example"usdhc1-100mhzgrp".
Here and below. Naming enforced by dtschema.

> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK			0x194
> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD			0x1d4
> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x1d4
> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x1d4
> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x1d4
> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x1d4
> +			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x1d4
> +			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x1d4
> +			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x1d4
> +			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x1d4
> +			MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0x019
> +			MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x194
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {

Best regards,
Krzysztof
