Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E382A261A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgKBI3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 03:29:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40116 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbgKBI27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:28:59 -0500
Received: by mail-wm1-f65.google.com with SMTP id k18so8587916wmj.5;
        Mon, 02 Nov 2020 00:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hlHTf3Iy5UoM0K8uLC/hLMz2YcBjX/2Xy68U5kPZPeU=;
        b=URKmBJSW2yeXhz6kb4b7srNiXhwNM6Gp+vyGB8oqAsqfO/SpakNIprnwqhOHSOyqpM
         DVUKHJEkayS9FOcyohx+R7FREhGtVZeFgPi1EzWQZ/ZJrZ6A/YuHglvaeJ6q4kCGn3ba
         5euk6WuSW+4hf4kq8mqthroFgkf/WjzCoADJ77+MeHWbQHIQfF0X+8DR09/tBt0sN0KL
         W2AykSnXHC2ju5yirugmDnfLEOJbyhRRIOBvv1x4yAXYdKhNqCCYPshQZKxPjoMFzYcE
         mHtBOgK3Nn5Egvxk7liDVSi7NbE0cdHcXl0uHMTDgQRhJXaiUPQVfWwmehBbtO4hVyXC
         wrOg==
X-Gm-Message-State: AOAM532Z8Qvr2audJPYJMUwX+ozhmYnmfR6aZa3B+kzZY56P7Rj9eupC
        Yuy9noxR0UKsk5kCLNtUikg=
X-Google-Smtp-Source: ABdhPJyScERyc9CX7goUu5qPR/vKFptB9tCjM0pnlV5B0fPdzLPBqMsThFmlV+WCVd7m1QvU60ykwg==
X-Received: by 2002:a1c:b346:: with SMTP id c67mr16146659wmf.105.1604305736162;
        Mon, 02 Nov 2020 00:28:56 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id u3sm21488204wrq.19.2020.11.02.00.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 00:28:54 -0800 (PST)
Date:   Mon, 2 Nov 2020 09:28:53 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mkl@pengutronix.de
Subject: Re: [PATCH V2] arm64: dts: imx8mp-evk: add CAN support
Message-ID: <20201102082853.GB6152@kozik-lap>
References: <20201102021634.6480-1-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201102021634.6480-1-qiangqing.zhang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 10:16:34AM +0800, Joakim Zhang wrote:
> Add CAN device node and pinctrl on i.MX8MP evk board.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
> ChangeLogs:
> V1->V2:
> 	* add missing space before '=',
> 	fsl,clk-source= /bits/ 8 <0> -> fsl,clk-source = /bits/ 8 <0>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 62 ++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi    | 30 ++++++++++
>  2 files changed, 92 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> index 908b92bb4dcd..b10dce8767a4 100644
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
> index 479312293036..ecccfbb4f5ad 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -552,6 +552,36 @@
>  				status = "disabled";
>  			};
>  
> +			flexcan1: can@308c0000 {
> +				compatible = "fsl,imx8mp-flexcan", "fsl,imx6q-flexcan";

Undocumented compatible in Documentation/devicetree/bindings/net/can/fsl-flexcan.txt

Best regards,
Krzysztof

> +				reg = <0x308c0000 0x10000>;
> +				interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MP_CLK_IPG_ROOT>,
> +					 <&clk IMX8MP_CLK_CAN1_ROOT>;
> +				clock-names = "ipg", "per";
> +				assigned-clocks = <&clk IMX8MP_CLK_CAN1>;
> +				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_40M>;
> +				assigned-clock-rates = <40000000>;
> +				fsl,clk-source = /bits/ 8 <0>;
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
> +				fsl,clk-source = /bits/ 8 <0>;
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
