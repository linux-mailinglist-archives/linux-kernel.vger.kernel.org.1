Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCFF1B90A5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 15:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgDZNdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 09:33:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgDZNdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 09:33:10 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A37D2071C;
        Sun, 26 Apr 2020 13:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587907988;
        bh=zhOlG8j2k9ooGL3hB98wIBmbEm7872tfTszggUSAgyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FvmpOCWheE0WmP5Ch9fkaEvI2RSAX/XMDp5ylbnM3b5IHzRrnA/KbL6/lIZAzmaOH
         GFXKQWmbf/258P19m0V80HbSdpI7gRM6iWHpwSpOX8/6IYZiuctldFxvzH+vPH1Wz8
         +92a0JDoJLFfsbvH2jidhphmdvAJ/DQHxM9WMVC4=
Date:   Sun, 26 Apr 2020 21:33:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Parthiban Nallathambi <parthiban@linumiz.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6ull: add MYiR MYS-6ULX SBC
Message-ID: <20200426133300.GE30501@dragon>
References: <20200408184351.135716-1-parthiban@linumiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408184351.135716-1-parthiban@linumiz.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 08:43:51PM +0200, Parthiban Nallathambi wrote:
> Add support for the MYiR imx6ULL based single board computer
> equipped with on board 256MB NAND & RAM. The board also
> provides expansion header for expansion board, but this
> commit adds only support for SBC.
> 
> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
> ---
>  arch/arm/boot/dts/Makefile                       |   1 +
>  arch/arm/boot/dts/imx6ull-myir-mys-6ulx-nand.dts |  19 ++
>  arch/arm/boot/dts/imx6ull-myir-mys-6ulx.dtsi     | 247 +++++++++++++++++++++++
>  3 files changed, 267 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6ull-myir-mys-6ulx-nand.dts
>  create mode 100644 arch/arm/boot/dts/imx6ull-myir-mys-6ulx.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index e8dd99201397..eab86051d782 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -612,6 +612,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
>  	imx6ull-14x14-evk.dtb \
>  	imx6ull-colibri-eval-v3.dtb \
>  	imx6ull-colibri-wifi-eval-v3.dtb \
> +	imx6ull-myir-mys-6ulx-nand.dtb \
>  	imx6ull-opos6uldev.dtb \
>  	imx6ull-phytec-segin-ff-rdk-nand.dtb \
>  	imx6ull-phytec-segin-ff-rdk-emmc.dtb \
> diff --git a/arch/arm/boot/dts/imx6ull-myir-mys-6ulx-nand.dts b/arch/arm/boot/dts/imx6ull-myir-mys-6ulx-nand.dts
> new file mode 100644
> index 000000000000..6eaba8a8d7a9
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ull-myir-mys-6ulx-nand.dts
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Linumiz
> + * Author: Parthiban Nallathambi <parthiban@linumiz.com>
> + */
> +
> +/dts-v1/;
> +#include "imx6ull.dtsi"
> +#include "imx6ull-myir-mys-6ulx.dtsi"
> +
> +/ {
> +	model = "MYiR i.MX6ULL MYS-6ULX Single Board Computer with NAND";
> +	compatible = "myir,imx6ul-mys-6ulx-nand", "myir,imx6ul-mys-6ulx",
> +		     "fsl,imx6ull";

Any new compatible needs to be documented.

> +};
> +
> +&gpmi {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx6ull-myir-mys-6ulx.dtsi b/arch/arm/boot/dts/imx6ull-myir-mys-6ulx.dtsi
> new file mode 100644
> index 000000000000..f0a514187c21
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ull-myir-mys-6ulx.dtsi
> @@ -0,0 +1,247 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Linumiz
> + * Author: Parthiban Nallathambi <parthiban@linumiz.com>
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pwm/pwm.h>
> +
> +/ {
> +	model = "MYiR MYS-6ULX Single Board Computer";
> +	compatible = "myir,imx6ull-mys-6ulx", "fsl,imx6ull";
> +
> +	chosen {
> +		stdout-path = &uart1;
> +	};
> +
> +	regulators: regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;

Drop the container node and put fixed regulator nodes directly under
root.  Suggest to use name schema below:

	regulator-xxx {
		...
	};

Shawn

> +
> +		vdd_5v: regulator@0 {
> +			compatible = "regulator-fixed";
> +			regulator-name = "VDD_5V";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		vdd_3v3: regulator@1 {
> +			compatible = "regulator-fixed";
> +			regulator-name = "VDD_3V3";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +			vin-supply = <&vdd_5v>;
> +		};
> +	};
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet1>;
> +	phy-mode = "rmii";
> +	phy-handle = <&ethphy0>;
> +	phy-supply = <&vdd_3v3>;
> +	status = "okay";
> +
> +	mdio: mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@0 {
> +			reg = <0>;
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			interrupt-parent = <&gpio5>;
> +			interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&clks IMX6UL_CLK_ENET_REF>;
> +			clock-names = "rmii-ref";
> +			status = "okay";
> +		};
> +	};
> +};
> +
> +&gpmi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpmi_nand>;
> +	nand-on-flash-bbt;
> +	status = "disabled";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usb_otg1_id>;
> +	dr_mode = "otg";
> +	status = "okay";
> +};
> +
> +&usbotg2 {
> +	dr_mode = "host";
> +	disable-over-current;
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	cd-gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
> +	no-1-8-v;
> +	keep-power-in-suspend;
> +	wakeup-source;
> +	vmmc-supply = <&vdd_3v3>;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
> +	bus-width = <8>;
> +	non-removable;
> +	keep-power-in-suspend;
> +	vmmc-supply = <&vdd_3v3>;
> +	status = "disabled";
> +};
> +
> +&iomuxc {
> +	pinctrl_enet1: enet1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_GPIO1_IO06__ENET1_MDIO	0x1b0b0
> +			MX6UL_PAD_GPIO1_IO07__ENET1_MDC		0x1b0b0
> +			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
> +			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
> +			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
> +			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b031
> +			MX6UL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_gpmi_nand: gpminandgrp {
> +		fsl,pins = <
> +			MX6UL_PAD_NAND_CLE__RAWNAND_CLE		0x0b0b1
> +			MX6UL_PAD_NAND_ALE__RAWNAND_ALE		0x0b0b1
> +			MX6UL_PAD_NAND_WP_B__RAWNAND_WP_B	0x0b0b1
> +			MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B	0x0b000
> +			MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B	0x0b0b1
> +			MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B	0x0b0b1
> +			MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B	0x0b0b1
> +			MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00	0x0b0b1
> +			MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01	0x0b0b1
> +			MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02	0x0b0b1
> +			MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03	0x0b0b1
> +			MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04	0x0b0b1
> +			MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05	0x0b0b1
> +			MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06	0x0b0b1
> +			MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07	0x0b0b1
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
> +			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_usb_otg1_id: usbotg1idgrp {
> +		fsl,pins = <
> +			MX6UL_PAD_GPIO1_IO00__ANATOP_OTG1_ID	0x17059
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x10059
> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
> +			MX6UL_PAD_UART1_RTS_B__GPIO1_IO19	0x17059
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
> +		fsl,pins = <
> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170b9
> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170b9
> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170b9
> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
> +		fsl,pins = <
> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170f9
> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170f9
> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170f9
> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x10069
> +			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x17059
> +			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x17059
> +			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x17059
> +			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x17059
> +			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x17059
> +			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x17059
> +			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x17059
> +			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x17059
> +			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x17059
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
> +		fsl,pins = <
> +			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100b9
> +			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170b9
> +			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170b9
> +			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170b9
> +			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170b9
> +			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170b9
> +			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x170b9
> +			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x170b9
> +			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x170b9
> +			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x170b9
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
> +		fsl,pins = <
> +			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100f9
> +			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170f9
> +			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170f9
> +			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170f9
> +			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170f9
> +			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170f9
> +			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x170f9
> +			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x170f9
> +			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x170f9
> +			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x170f9
> +		>;
> +	};
> +};
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
