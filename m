Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA85B2A3DCA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 08:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgKCHjH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Nov 2020 02:39:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38169 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgKCHjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 02:39:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id h62so6935027wme.3;
        Mon, 02 Nov 2020 23:39:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bXuOa5KbndwxymZMhvdD2xbY7A2ognK9fHBfraWla5A=;
        b=rPpjewIAbYcTSCakUEvD6eQmvPf9KnMO+huuTxnh8AlUvqDPHq/oQY9oFeBmGnB3/0
         hTkzY6wDpHPdkl0c7/tDyyOw1SmpxltvNEBiPJ3opiRp/VMlTg7x6s1ZDkK+PhqqOB+v
         8uOaxT4xsEoP2zj09+PaPy4jWhKQ60pYz4RgMlnYiyv2c9nkhnhxLfgBOaEewhsvpjaV
         H4yNYhhDINRFl21VScBdZ0NMLGGz0uq9HDJWefx6qKpu3Nt5lEWa9Ly+s006OpRWCtOk
         ii4s65EuB7jNpQCYrZujDK5wcwPQTican2i94AM7NNjrRkZ2HxfiMIeKJfsv1lHYU093
         vRvw==
X-Gm-Message-State: AOAM5329YM2GGjeabwGTJ97QOeuIzGoLRcXF7UcjFCvbKu7ip7hH+1l/
        DQZblrdIY4Y2NiJ/W3cVwxc=
X-Google-Smtp-Source: ABdhPJwm22tojRgKDZZZBLNhCz/qUtsvSpAEOhnfV4hVAerCMO+ZDaweHjRmryHMGGwQ17X7zMAjeg==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr2096786wmp.187.1604389144305;
        Mon, 02 Nov 2020 23:39:04 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id a185sm1983713wmf.24.2020.11.02.23.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 23:39:03 -0800 (PST)
Date:   Tue, 3 Nov 2020 08:39:01 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
Subject: Re: [PATCH V2] arm64: dts: imx8mp-evk: add CAN support
Message-ID: <20201103073901.GA3599@kozik-lap>
References: <20201102021634.6480-1-qiangqing.zhang@nxp.com>
 <20201102082853.GB6152@kozik-lap>
 <DB8PR04MB6795A0C0D6F33721311945DCE6110@DB8PR04MB6795.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <DB8PR04MB6795A0C0D6F33721311945DCE6110@DB8PR04MB6795.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 01:23:12AM +0000, Joakim Zhang wrote:
> 
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > Sent: 2020年11月2日 16:29
> > To: Joakim Zhang <qiangqing.zhang@nxp.com>
> > Cc: shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> > dl-linux-imx <linux-imx@nxp.com>; devicetree@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > mkl@pengutronix.de
> > Subject: Re: [PATCH V2] arm64: dts: imx8mp-evk: add CAN support
> > 
> > On Mon, Nov 02, 2020 at 10:16:34AM +0800, Joakim Zhang wrote:
> > > Add CAN device node and pinctrl on i.MX8MP evk board.
> > >
> > > Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> > > ---
> > > ChangeLogs:
> > > V1->V2:
> > > 	* add missing space before '=',
> > > 	fsl,clk-source= /bits/ 8 <0> -> fsl,clk-source = /bits/ 8 <0>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 62
> > ++++++++++++++++++++
> > >  arch/arm64/boot/dts/freescale/imx8mp.dtsi    | 30 ++++++++++
> > >  2 files changed, 92 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > > b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > > index 908b92bb4dcd..b10dce8767a4 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > > @@ -33,6 +33,28 @@
> > >  		      <0x1 0x00000000 0 0xc0000000>;
> > >  	};
> > >
> > > +	reg_can1_stby: regulator-can1-stby {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "can1-stby";
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&pinctrl_flexcan1_reg>;
> > > +		regulator-min-microvolt = <3300000>;
> > > +		regulator-max-microvolt = <3300000>;
> > > +		gpio = <&gpio5 5 GPIO_ACTIVE_HIGH>;
> > > +		enable-active-high;
> > > +	};
> > > +
> > > +	reg_can2_stby: regulator-can2-stby {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "can2-stby";
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&pinctrl_flexcan2_reg>;
> > > +		regulator-min-microvolt = <3300000>;
> > > +		regulator-max-microvolt = <3300000>;
> > > +		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
> > > +		enable-active-high;
> > > +	};
> > > +
> > >  	reg_usdhc2_vmmc: regulator-usdhc2 {
> > >  		compatible = "regulator-fixed";
> > >  		pinctrl-names = "default";
> > > @@ -45,6 +67,20 @@
> > >  	};
> > >  };
> > >
> > > +&flexcan1 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&pinctrl_flexcan1>;
> > > +	xceiver-supply = <&reg_can1_stby>;
> > > +	status = "okay";
> > > +};
> > > +
> > > +&flexcan2 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&pinctrl_flexcan2>;
> > > +	xceiver-supply = <&reg_can2_stby>;
> > > +	status = "disabled";/* can2 pin conflict with pdm */ };
> > > +
> > >  &fec {
> > >  	pinctrl-names = "default";
> > >  	pinctrl-0 = <&pinctrl_fec>;
> > > @@ -144,6 +180,32 @@
> > >  		>;
> > >  	};
> > >
> > > +	pinctrl_flexcan1: flexcan1grp {
> > > +		fsl,pins = <
> > > +			MX8MP_IOMUXC_SPDIF_RX__CAN1_RX          0x154
> > > +			MX8MP_IOMUXC_SPDIF_TX__CAN1_TX          0x154
> > > +		>;
> > > +	};
> > > +
> > > +	pinctrl_flexcan2: flexcan2grp {
> > > +		fsl,pins = <
> > > +			MX8MP_IOMUXC_SAI5_MCLK__CAN2_RX         0x154
> > > +			MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX         0x154
> > > +		>;
> > > +	};
> > > +
> > > +	pinctrl_flexcan1_reg: flexcan1reggrp {
> > > +		fsl,pins = <
> > > +			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05  0x154   /*
> > CAN1_STBY */
> > > +		>;
> > > +	};
> > > +
> > > +	pinctrl_flexcan2_reg: flexcan2reggrp {
> > > +		fsl,pins = <
> > > +			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27      0x154
> > /* CAN2_STBY */
> > > +		>;
> > > +	};
> > > +
> > >  	pinctrl_gpio_led: gpioledgrp {
> > >  		fsl,pins = <
> > >  			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x19
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > index 479312293036..ecccfbb4f5ad 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > > @@ -552,6 +552,36 @@
> > >  				status = "disabled";
> > >  			};
> > >
> > > +			flexcan1: can@308c0000 {
> > > +				compatible = "fsl,imx8mp-flexcan", "fsl,imx6q-flexcan";
> > 
> > Undocumented compatible in
> > Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> 
> Hi Krzsztof,
> 
> Yes, I will resend the patch after below patch goes into mainline. Thanks.
> https://www.spinics.net/lists/linux-can/msg04896.html

Thanks for the link. It's all good and there is no need to resend
because your compatible is mentioned there.

Best regards,
Krzysztof
