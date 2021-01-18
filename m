Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC932F9AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 08:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733150AbhARHqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 02:46:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733029AbhARHpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 02:45:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4693022241;
        Mon, 18 Jan 2021 07:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610955914;
        bh=bYgf/YFtA+946ZX2rQaIc3huFC3KCph7nxAfe/RWicg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MUiDeikXth68DjYHsN30WwGw0y5IavBRVRSAbu5HN8Q1IgGfd5x3eLj0qcGFkJPYA
         8+aBjGwRwckYJfcV4b6S2yKPPIqrUhQxGXyr8DbuwNhn+IdWFjpSb63a0MRm/Y0zGm
         6UM8+Y8UaPvGY1Ot2yhqYCR7CbMq6/cWqq10Eq1KOmioM+VUZSNSMOL1jlhrO+HdQA
         qgDqjI6pOWpeRg08GpTis8bGDak+0D6um8y9Rx3Stz5UXUlh4qxOnOhbX/wibzFZ7D
         FuyvBh2LcJ1O+jKwJsrMfsTSAt4o30072OG3BvTCJm4LP3aEsPr/c7I2VOmYOEi2q+
         EiK7KX6kG5/mA==
Date:   Mon, 18 Jan 2021 15:45:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/3] arm64: dts: imx: Add i.mx8mm nitrogen8mm basic
 dts support
Message-ID: <20210118074507.GS28365@dragon>
References: <20210115210124.507282-1-adrien.grassein@gmail.com>
 <20210115210124.507282-3-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115210124.507282-3-adrien.grassein@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 10:01:23PM +0100, Adrien Grassein wrote:
> Tested with a basic Build Root configuration booting from sdcard.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../dts/freescale/imx8mm-nitrogen8mm_rev2.dts | 415 ++++++++++++++++++
>  2 files changed, 416 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 38559943c15d..398b5cb4f3e2 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -49,6 +49,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-devkit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-r2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-r3.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-nitrogen.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-nitrogen8mm_rev2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-phanbell.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-pico-pi.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-thor96.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts
> new file mode 100644
> index 000000000000..e89fbf512f9e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts
> @@ -0,0 +1,415 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree file for Boundary Devices i.MX8MMini Nitrogen8MM Rev2 board.
> + * Adrien Grassein <adrien.grassein@gmail.com.com>
> + */
> +/dts-v1/;
> +#include "imx8mm.dtsi"
> +
> +/ {
> +	model = "Boundary Devices i.MX8MMini Nitrogen8MM Rev2";
> +	compatible = "boundary,imx8mm-nitrogen8mm", "fsl,imx8mm";
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&reg_sw3>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&reg_sw3>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&reg_sw3>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&reg_sw3>;
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec1>;
> +

Unnecessary newline.

> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy0>;
> +	fsl,magic-packet;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;

Have a newline between properties and child node.

> +		ethphy0: ethernet-phy@4 {
> +			compatible = "ethernet-phy-id004d.d072",
> +				"ethernet-phy-ieee802.3-c22";
> +			reg = <4>;
> +			interrupts-extended = <&gpio3 16 IRQ_TYPE_LEVEL_LOW>;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	pinctrl-1 = <&pinctrl_i2c1_1>;
> +	scl-gpios = <&gpio5 14 GPIO_OPEN_DRAIN>;
> +	sda-gpios = <&gpio5 15 GPIO_OPEN_DRAIN>;
> +	status = "okay";
> +
> +	pmic@8 {
> +		compatible = "nxp,pf8121a";
> +		reg = <0x8>;
> +		status = "okay";

Unnecessary `status`.

> +
> +		regulators {
> +		    reg_ldo1: ldo1 {
> +				regulator-min-microvolt = <1500000>;
> +				regulator-max-microvolt = <5000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_ldo2: ldo2 {
> +				regulator-min-microvolt = <1500000>;
> +				regulator-max-microvolt = <5000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_ldo3: ldo3 {
> +				regulator-min-microvolt = <1500000>;
> +				regulator-max-microvolt = <5000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_ldo4: ldo4 {
> +				regulator-min-microvolt = <1500000>;
> +				regulator-max-microvolt = <5000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_buck1: buck1 {
> +				regulator-min-microvolt = <400000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_buck2: buck2 {
> +				regulator-min-microvolt = <400000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_sw3: buck3 {
> +				regulator-min-microvolt = <400000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_buck4: buck4 {
> +				regulator-min-microvolt = <400000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_buck5: buck5 {
> +				regulator-min-microvolt = <400000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_buck6: buck6 {
> +				regulator-min-microvolt = <400000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_buck7: buck7 {
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_vsnvs: vsnvs {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c3 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	pinctrl-1 = <&pinctrl_i2c3_1>;
> +	scl-gpios = <&gpio5 18 GPIO_OPEN_DRAIN>;
> +	sda-gpios = <&gpio5 19 GPIO_OPEN_DRAIN>;
> +	status = "okay";
> +
> +	i2cmux@70 {
> +		compatible = "nxp,pca9540";
> +		reg = <0x70>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c3@0 {

No number suffix in node name.

> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;

Newline.

> +			rtc@68 {
> +				compatible = "microcrystal,rv4162";
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_i2c3a_rv4162>;
> +				reg = <0x68>;
> +				interrupts-extended = <&gpio4 22 IRQ_TYPE_LEVEL_LOW>;
> +				wakeup-source;
> +			};
> +		};
> +	};
> +};
> +
> +/* console */
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	assigned-clocks = <&clk IMX8MM_CLK_UART2>;
> +	assigned-clock-parents = <&clk IMX8MM_CLK_24M>;
> +	status = "okay";
> +};
> +
> +/* eMMC */
> +&usdhc1 {
> +	bus-width = <8>;
> +	sdhci-caps-mask = <0x80000000 0x0>;
> +	non-removable;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	status = "okay";
> +};
> +
> +/* sdcard */
> +&usdhc2 {
> +	bus-width = <4>;
> +	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
> +	status = "okay";
> +	vqmmc-supply = <&reg_ldo2>;

Let's end properties with `status`.

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
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	pinctrl_fec1: fec1grp {
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
> +			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16		0x159
> +		>;
> +	};
> +
> +	pinctrl_hog: hoggrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3 0x09
> +			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8 0x09
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL 0x400001c3
> +			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA 0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_i2c1_1: i2c1-1grp {

Meaningless `_1` suffix.

> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C1_SCL_GPIO5_IO14 0x400001c3
> +			MX8MM_IOMUXC_I2C1_SDA_GPIO5_IO15 0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL 0x400001c3
> +			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA 0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_i2c3_1: i2c3-1grp {

Ditto

Shawn

> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C3_SCL_GPIO5_IO18 0x400001c3
> +			MX8MM_IOMUXC_I2C3_SDA_GPIO5_IO19 0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_i2c3a_rv4162: i2c3a-rv4162grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22 0x1c0
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX 0x140
> +			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX 0x140
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
> +			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4	0x1d0
> +			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5	0x1d0
> +			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6	0x1d0
> +			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7	0x1d0
> +			MX8MM_IOMUXC_SD1_RESET_B_GPIO2_IO10	0x141
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1-100mhz-grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x194
> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d4
> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d4
> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d4
> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d4
> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d4
> +			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4	0x1d4
> +			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5	0x1d4
> +			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6	0x1d4
> +			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7	0x1d4
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1-200mhz-grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x196
> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d6
> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d6
> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d6
> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d6
> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d6
> +			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4	0x1d6
> +			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5	0x1d6
> +			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6	0x1d6
> +			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7	0x1d6
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x190
> +			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d0
> +			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d0
> +			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d0
> +			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d0
> +			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d0
> +			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12	0x1c4
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2-100mhz-grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x194
> +			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
> +			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
> +			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
> +			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
> +			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2-200mhz-grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x196
> +			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6
> +			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d6
> +			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d6
> +			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d6
> +			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d6
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x190
> +			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d0
> +			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d0
> +			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d0
> +			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d0
> +			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d0
> +			MX8MM_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K	0x03
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_100mhz: usdhc3-100mhz-grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK	0x194
> +			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD	0x1d4
> +			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0	0x1d4
> +			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1	0x1d4
> +			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2	0x1d4
> +			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3	0x1d4
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_200mhz: usdhc3-200mhz-grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK	0x196
> +			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD	0x1d6
> +			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0	0x1d6
> +			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1	0x1d6
> +			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2	0x1d6
> +			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3	0x1d6
> +		>;
> +	};
> +
> +	pinctrl_wdog: wdoggrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B 0x140
> +		>;
> +	};
> +};
> -- 
> 2.25.1
> 
