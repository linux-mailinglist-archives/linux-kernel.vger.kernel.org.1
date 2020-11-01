Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA2C2A1CCA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 10:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgKAJQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 04:16:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:52156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgKAJQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 04:16:33 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FEA321D40;
        Sun,  1 Nov 2020 09:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604222192;
        bh=JIuhINLCifrVA/vA+ij5+ON0MKl2JIOZ/y8TBt/teRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zX+bdx7p4ZR8/GaB7MFDU7+ujpUbA2N+6ZNqqdKSdQY1UO8303OvVIiOrgvXKAVAT
         aPBH0bmyPk9oDVE6IJSPt+OZiR/0DsgLZOE1f6UsvuE0nIzAyyC6znjOb8YcS3IuDs
         /8iU5P1SZgLL2g+upiwVZ37zJHnXlwf/9lYZxdgY=
Date:   Sun, 1 Nov 2020 17:16:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mkl@pengutronix.de
Subject: Re: [PATCH] arm64: dts: imx8mp-evk: add CAN support
Message-ID: <20201101091625.GL31601@dragon>
References: <1603693376-17206-1-git-send-email-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603693376-17206-1-git-send-email-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 02:22:56PM +0800, Joakim Zhang wrote:
> Add CAN device node and pinctrl on i.MX8MP evk board.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 62 ++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi    | 30 ++++++++++
>  2 files changed, 92 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> index ad66f1286d95..85aaed7dc4bc 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -33,6 +33,28 @@
>  		      <0x1 0x00000000 0 0xc0000000>;
>  	};
>  
> +	reg_can1_stby: regulator-can1-stby {
> +		compatible = "regulator-fixed";
> +		regulator-name = "can1-stby";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_flexcan1_reg>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio5 5 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_can2_stby: regulator-can2-stby {
> +		compatible = "regulator-fixed";
> +		regulator-name = "can2-stby";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_flexcan2_reg>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
>  	reg_usdhc2_vmmc: regulator-usdhc2 {
>  		compatible = "regulator-fixed";
>  		pinctrl-names = "default";
> @@ -45,6 +67,20 @@
>  	};
>  };
>  
> +&flexcan1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan1>;
> +	xceiver-supply = <&reg_can1_stby>;
> +	status = "okay";
> +};
> +
> +&flexcan2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan2>;
> +	xceiver-supply = <&reg_can2_stby>;
> +	status = "disabled";/* can2 pin conflict with pdm */
> +};
> +
>  &fec {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_fec>;
> @@ -144,6 +180,32 @@
>  		>;
>  	};
>  
> +	pinctrl_flexcan1: flexcan1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SPDIF_RX__CAN1_RX          0x154
> +			MX8MP_IOMUXC_SPDIF_TX__CAN1_TX          0x154
> +		>;
> +	};
> +
> +	pinctrl_flexcan2: flexcan2grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI5_MCLK__CAN2_RX         0x154
> +			MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX         0x154
> +		>;
> +	};
> +
> +	pinctrl_flexcan1_reg: flexcan1reggrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05  0x154   /* CAN1_STBY */
> +		>;
> +	};
> +
> +	pinctrl_flexcan2_reg: flexcan2reggrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27      0x154   /* CAN2_STBY */
> +		>;
> +	};
> +
>  	pinctrl_gpio_led: gpioledgrp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x19
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 6038f66aefc1..cc123a5e3f7e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -545,6 +545,36 @@
>  				status = "disabled";
>  			};
>  
> +			flexcan1: can@308c0000 {
> +				compatible = "fsl,imx8mp-flexcan", "fsl,imx6q-flexcan";
> +				reg = <0x308c0000 0x10000>;
> +				interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MP_CLK_IPG_ROOT>,
> +					 <&clk IMX8MP_CLK_CAN1_ROOT>;
> +				clock-names = "ipg", "per";
> +				assigned-clocks = <&clk IMX8MP_CLK_CAN1>;
> +				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_40M>;
> +				assigned-clock-rates = <40000000>;
> +				fsl,clk-source= /bits/ 8 <0>;

Missing space before '='.

> +				fsl,stop-mode = <&gpr 0x10 4>;
> +				status = "disabled";
> +			};
> +
> +			flexcan2: can@308d0000 {
> +				compatible = "fsl,imx8mp-flexcan", "fsl,imx6q-flexcan";
> +				reg = <0x308d0000 0x10000>;
> +				interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MP_CLK_IPG_ROOT>,
> +					 <&clk IMX8MP_CLK_CAN2_ROOT>;
> +				clock-names = "ipg", "per";
> +				assigned-clocks = <&clk IMX8MP_CLK_CAN2>;
> +				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_40M>;
> +				assigned-clock-rates = <40000000>;
> +				fsl,clk-source= /bits/ 8 <0>;

Ditto

Shawn

> +				fsl,stop-mode = <&gpr 0x10 5>;
> +				status = "disabled";
> +			};
> +
>  			crypto: crypto@30900000 {
>  				compatible = "fsl,sec-v4.0";
>  				#address-cells = <1>;
> -- 
> 2.17.1
> 
