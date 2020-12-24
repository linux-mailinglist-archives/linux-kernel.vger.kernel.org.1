Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1EA2E26AE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 13:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgLXMMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 07:12:14 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:37622 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgLXMMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 07:12:14 -0500
Received: by mail-wr1-f48.google.com with SMTP id i9so2017827wrc.4;
        Thu, 24 Dec 2020 04:11:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DLoG9as5T9MFSdlS0/mQuvxRzgC8ss+fwvRwXia+TiI=;
        b=jld6LSh3Lx+nBtmQaebmutoZtqAkDUlzEv/OjRafjhN5GW+CyOAR+ApOWl/Ux6m3VE
         mVQ/Xo1MC12RctOw+YENbGra9vv3uU4s3bZiSTxqTsGe1ReBG7ufiBHTl1COJAJRS+vV
         NpuIRojiRlzPS2HfyjZSo9OdBqPUeYKSvnNh6bfSYCOseLT0eq/YB4jHSGvRukPwN62S
         ta2qMozGzCHPvYfREknhqSu9x/f1DDf7jXjrBBmrK3HyJ/aWFAV5qODIRRQZ9WQHC4Zi
         QoQaCBYvfsned7K/zt42KqqB/2HTZtA7tQP0wj+nrgubE8pnFjF9vZWpD0xVIcxdJrqY
         kTzg==
X-Gm-Message-State: AOAM530Kxgq4hyXtL1uIJCM/8B5+69l41cE/Dve4nUxtMgFcgT/+zxAb
        vjNidmGViizWypEOB53q1+g=
X-Google-Smtp-Source: ABdhPJz/lZAFEOWKIewV3fyoyMT122b88AcfAyZ8J41YrHcHJo3+J1KvUfToNlzNH0H+0F2Fav3eLQ==
X-Received: by 2002:adf:db51:: with SMTP id f17mr34499195wrj.83.1608811890104;
        Thu, 24 Dec 2020 04:11:30 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id o74sm3588802wme.36.2020.12.24.04.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Dec 2020 04:11:29 -0800 (PST)
Date:   Thu, 24 Dec 2020 13:11:25 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: imx8mm: Add Gateworks IMX8MM Development
 Kits
Message-ID: <20201224121125.GC15628@kozik-lap>
References: <1608762196-29871-1-git-send-email-tharvey@gateworks.com>
 <1608762196-29871-2-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1608762196-29871-2-git-send-email-tharvey@gateworks.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 02:23:16PM -0800, Tim Harvey wrote:
> The Gateworks Venice GW71xx-0x/GW72xx-0x/GW73xx-0x are development
> kits comprised of a GW700x SoM and a Baseboard.
> 
> The GW700x SoM contains:
>  - IMX8MM SoC
>  - LPDDR4 DRAM
>  - eMMC FLASH
>  - Gateworks System Controller (eeprom/pushbutton/reset/voltage-monitor)
>  - GbE PHY connected to the IMX8MM FEC
>  - Power Management IC
> 
> The GW71xx Baseboard contains:
>  - 1x MiniPCIe Socket with USB2.0, PCIe, and SIM
>  - 1x RJ45 GbE (IMX8MM FEC)
>  - PCIe Clock generator
>  - GPS and accelerometer
>  - 1x USB 2.0 Front Panel connector
>  - wide range power supply
> 
> The GW72xx Baseboard contains:
>  - 2x MiniPCIe Socket with USB2.0, PCIe, and SIM
>  - 2x RJ45 GbE (IMX8MM FEC and LAN743x)
>  - 1x MicroSD connector
>  - 1x USB 2.0 Front Panel connector
>  - 1x SPI connector
>  - PCIe Clock generator
>  - GPS and accelerometer
>  - Media Expansion connector (MIPI-CSI/MIPI-DSI/GPIO/I2S)
>  - wide range power supply
> 
> The GW73xx Baseboard contains:
>  - 3x MiniPCIe Socket with USB2.0, PCIe, and SIM
>  - 2x RJ45 GbE (IMX8MM FEC and LAN743x)
>  - 1x MicroSD connector
>  - 1x USB 2.0 Front Panel connector
>  - 1x SPI connector
>  - WiFi/BT
>  - PCIe Clock generator
>  - GPS and accelerometer
>  - Media Expansion connector (MIPI-CSI/MIPI-DSI/GPIO/I2S)
>  - wide range power supply
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile             |   3 +
>  .../boot/dts/freescale/imx8mm-venice-gw700x.dtsi   | 482 +++++++++++++++++++++
>  .../boot/dts/freescale/imx8mm-venice-gw71xx-0x.dts |  19 +
>  .../boot/dts/freescale/imx8mm-venice-gw71xx.dtsi   | 186 ++++++++
>  .../boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts |  20 +
>  .../boot/dts/freescale/imx8mm-venice-gw72xx.dtsi   | 311 +++++++++++++
>  .../boot/dts/freescale/imx8mm-venice-gw73xx-0x.dts |  19 +
>  .../boot/dts/freescale/imx8mm-venice-gw73xx.dtsi   | 363 ++++++++++++++++
>  8 files changed, 1403 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index f8d5943..ecdd233 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -32,6 +32,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw71xx-0x.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-var-som-symphony.dtb

(...)

I have few more thoughts below.

> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
> new file mode 100644
> index 00000000..a4eeb0d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2020 Gateworks Corporation
> + */
> +
> +/ {
> +	aliases {
> +		usb0 = &usbotg1;
> +		usb1 = &usbotg2;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_leds>;
> +
> +		user1 { /* GRN */
> +			label = "user1";
> +			gpios = <&gpio5 5 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		user2 { /* RED */
> +			label = "user2";
> +			gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	pps {
> +		compatible = "pps-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pps>;
> +		gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
> +		status = "okay";
> +	};
> +
> +	reg_usb_otg1_vbus: regulator-usb-otg1 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usb1_en>;
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_otg1_vbus";
> +		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +};
> +
> +&ecspi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi2>;
> +	cs-gpios = <&gpio5 13 GPIO_ACTIVE_HIGH>;
> +	status = "okay";

Why is it enabled? What's here?

> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	accel@19 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_accel>;
> +		compatible = "st,lis2de12";
> +		reg = <0x19>;
> +		st,drdy-int-pin = <1>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "INT1";
> +	};
> +};
> +
> +&i2c3 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";

Why is it enabled? What's here?

> +};
> +
> +&sai3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai3>;
> +	assigned-clocks = <&clk IMX8MM_CLK_SAI3>;
> +	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates = <24576000>;
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	status = "okay";
> +};

Why both UARTs are enabled on the Carrier? The console is UART2.

Best regards,
Krzysztof

> +
> +&usbotg1 {
> +	dr_mode = "otg";
> +	vbus-supply = <&reg_usb_otg1_vbus>;
> +	status = "okay";
> +};
> +
> +&usbotg2 {
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	pinctrl_hog: hoggrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SPDIF_TX_GPIO5_IO3		0x40000041 /* PLUG_TEST */
> +			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6	0x40000041 /* PCI_USBSEL */
> +			MX8MM_IOMUXC_SAI1_RXD5_GPIO4_IO7	0x40000041 /* PCIE_WDIS# */
> +			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7	0x40000041 /* DIO0 */
> +			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9	0x40000041 /* DIO1 */
> +			MX8MM_IOMUXC_SAI1_RXD1_GPIO4_IO3	0x40000041 /* DIO2 */
> +			MX8MM_IOMUXC_SAI1_RXD2_GPIO4_IO4	0x40000041 /* DIO2 */
> +		>;
> +	};
> +
> +	pinctrl_accel: accelirq {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI1_RXD3_GPIO4_IO5	0x159
> +		>;
> +	};
> +
> +	pinctrl_gpio_leds: gpioledgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5	0x19
> +			MX8MM_IOMUXC_SPDIF_RX_GPIO5_IO4		0x19
> +		>;
> +	};
> +
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL		0x400001c3
> +			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_pps: ppsgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x41
> +		>;
> +	};
> +
> +	pinctrl_reg_usb1_en: regusb1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12	0x41
> +			MX8MM_IOMUXC_GPIO1_IO13_USB1_OTG_OC	0x41
> +		>;
> +	};
> +
> +	pinctrl_spi2: spi2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0xd6
> +			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI	0xd6
> +			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0xd6
> +			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13	0xd6
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_UART1_RXD_UART1_DCE_RX	0x140
> +			MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX	0x140
> +		>;
> +	};
> +
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX	0x140
> +			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX	0x140
> +		>;
> +	};
> +};
