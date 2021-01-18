Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432102F9A52
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 08:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbhARHDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 02:03:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbhARHD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 02:03:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 489C52231F;
        Mon, 18 Jan 2021 07:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610953368;
        bh=MCSVF1Y74zrStqoku6vsdRcyPqaVtI7qb+YwR/JrFUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cq0gc9h9md0+AFO2H1wHwGtpCUgbc9kJwaAfEVKOjMM010F4kDaHA1qymLTImhwoU
         VyuzGvOfferRv9KzX1+QhVxksjN16HgduN4MdG5P1XkRDtSBzv7sEyxixLrlrfWv2f
         uFP2Y7C0GnFOiLYpAKAhxaHfuEVThU6s0x02OVbhgJSnSnhNLrSdx+KY2qv1fh3jJ8
         Xok/J3eeww0JlurKFrna0eEStIRzyZaqUmXWPK0mE682ZzKspPBwJ+Iz4kqyBTFTJS
         frqzbdQgYTjY6S9xMwN+Ua6gHz5gqLqjyJhV4ZCn41YTMMysPDR9ixvKUT/G9L79U/
         ZOsHkyoHocYLg==
Date:   Mon, 18 Jan 2021 15:02:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, festevam@gmail.com, kernel@pengutronix.de,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        krzk@kernel.org, kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] arm64: dts: imx8mq-librem5: enable the LCD panel
Message-ID: <20210118070241.GL28365@dragon>
References: <20210112095151.4995-1-martin.kepplinger@puri.sm>
 <20210112095151.4995-7-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112095151.4995-7-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 10:51:48AM +0100, Martin Kepplinger wrote:
> This enables the Librem5's ft8006p based LCD panel driven by the
> imx8mq's Northwest Logic DSI IP core and mxsfb display controller.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  .../boot/dts/freescale/imx8mq-librem5.dtsi    | 51 ++++++++++++++++++-
>  1 file changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> index f77b51d3c132..440931f81c12 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> @@ -310,6 +310,17 @@
>  		>;
>  	};
>  
> +	pinctrl_dsirst: dsirstgrp {
> +		fsl,pins = <
> +			/* DSI_RST */
> +			MX8MQ_IOMUXC_ENET_RD3_GPIO1_IO29	0x83
> +			/* DSI_TE */
> +			MX8MQ_IOMUXC_ENET_RD2_GPIO1_IO28	0x83
> +			/* TP_RST */
> +			MX8MQ_IOMUXC_ENET_RX_CTL_GPIO1_IO24	0x83
> +		>;
> +	};
> +
>  	pinctrl_ecspi1: ecspigrp {
>  		fsl,pins = <
>  			MX8MQ_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI	0x83
> @@ -817,12 +828,12 @@
>  		compatible = "tps65132";
>  		reg = <0x3e>;
>  
> -		outp {
> +		reg_lcd_avdd: outp {
>  			regulator-name = "LCD_AVDD";
>  			vin-supply = <&reg_lcd_3v4>;
>  		};
>  
> -		outn {
> +		reg_lcd_avee: outn {
>  			regulator-name = "LCD_AVEE";
>  			vin-supply = <&reg_lcd_3v4>;
>  		};
> @@ -947,6 +958,42 @@
>  	};
>  };
>  
> +&lcdif {
> +	status = "okay";
> +};
> +
> +&mipi_dsi {
> +	status = "okay";
> +	#address-cells = <1>;
> +	#size-cells = <0>;

Please end property list with `status`.

> +
> +	lcd_panel: panel@0 {
> +		compatible = "mantix,mlaf057we51-x";
> +		reg = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_dsirst>;
> +		avdd-supply = <&reg_lcd_avdd>;
> +		avee-supply = <&reg_lcd_avee>;
> +		vddi-supply = <&reg_lcd_1v8>;
> +		backlight = <&backlight_dsi>;
> +		reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;

Have a newline between properties and child node.

> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&mipi_dsi_out>;
> +			};
> +		};
> +	};
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;

Ditto

Shawn

> +			mipi_dsi_out: endpoint {
> +				remote-endpoint = <&panel_in>;
> +			};
> +		};
> +	};
> +};
> +
>  &pgc_gpu {
>  	power-supply = <&buck3_reg>;
>  };
> -- 
> 2.20.1
> 
