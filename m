Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C39D2CC3EB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgLBRe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:34:58 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34825 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgLBRe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:34:57 -0500
Received: by mail-ed1-f68.google.com with SMTP id u19so4885696edx.2;
        Wed, 02 Dec 2020 09:34:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wJ6pUuszJDg/47iz5wDAOfG7BM1jFUEnOUHSofHoz8M=;
        b=a/hJ2x6j+o4u3aZwp3jOl80aSnfiUS3IpExNZG1OTsg7uHLucQ7E9HvuJ1IYBvEeQr
         G0jjtjfAX4uUxH0j6k/VyG+fAkhLneiRJQk5Vu2C+rSSZ5/1/3AgvYqTNHNLpJNk2Dbu
         NGbjyIZCw57AR9AYWPYMMq9kmvHZPm2xL61hJz0qX86bEwJznojfn/KwIsk0dfvEaXSM
         mEkV1CL3E1CQhYy2qudtB44/g4d3iNFvS/SowWzgSivL+y8976gUPpTi/DTZUq8ffHZR
         SB/sSSz54zhOZTSE2JryVekoxvFKd3X0aNtxtUM8A9/BTvyHpN9niiMAw+UlMtAVhKgs
         5TnQ==
X-Gm-Message-State: AOAM532KE2xI/3B0WjKqDvY6b173OXCOaaPiKkC2ZEPAR2paV4YYOnsQ
        UGcLnllkTcnJ2Ju8qE8f9tY=
X-Google-Smtp-Source: ABdhPJyj/UsZcMRfLFtkUtRT+m8m5Qx2cYcD57OETZKHIiL/OArK75vx3xcijSo8QnmHb4ZyH8FozA==
X-Received: by 2002:aa7:d459:: with SMTP id q25mr988138edr.279.1606930448646;
        Wed, 02 Dec 2020 09:34:08 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id k17sm378283ejj.1.2020.12.02.09.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 09:34:07 -0800 (PST)
Date:   Wed, 2 Dec 2020 19:34:05 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH 04/10] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
 SOM
Message-ID: <20201202173405.GD3490@kozik-lap>
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
 <20201202121241.109952-5-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202121241.109952-5-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 05:42:35PM +0530, Jagan Teki wrote:
> i.Core MX8M Mini is an EDIMM SOM based on NXP i.MX8MM from Engicam.

s/SOM/SoM/

> 
> General features:
> - NXP i.MX8MM

i.MX 8M Mini
as named by NXP:
https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/i-mx-applications-processors/i-mx-8-processors/i-mx-8m-mini-arm-cortex-a53-cortex-m4-audio-voice-video:i.MX8MMINI

> - Up to 2GB LDDR4
> - 8/16GB eMMC
> - Gigabit Ethernet
> - USB 2.0 Host/OTG
> - PCIe Gen2 interface
> - I2S
> - MIPI DSI to LVDS
> - rest of i.MX8MM features

Ditto

> 
> i.Core MX8M Mini needs to mount on top of Engicam baseboards for
> creating complete platform boards.
> 
> Possible baseboards are,
> - EDIMM2.2
> - C.TOUCH 2.0

Don't describe baseboards. You add here only SoM.

> 
> Add support for it.
> 
> Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../freescale/imx8mm-engicam-icore-mx8mm.dtsi | 209 ++++++++++++++++++
>  1 file changed, 209 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm.dtsi
> new file mode 100644
> index 000000000000..b87917c40587
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm.dtsi
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2018 NXP
> + * Copyright (c) 2019 Engicam srl
> + * Copyright (c) 2020 Amarula Solutons(India)
> + */
> +
> +/ {

Missing "model".

> +	compatible = "engicam,icore-mx8mm", "fsl,imx8mm";
> +};
> +

No memory node? Isn't the memory a property of SoM?

> +&A53_0 {
> +	cpu-supply = <&reg_buck4>;
> +};

Supplies for the other cores.

> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	pf8100@8 {

Node name should describe generic class of a device, so probably you
wanted here "pmic".

> +		compatible = "nxp,pf8x00";
> +		reg = <0x08>;
> +
> +		regulators {
> +			reg_ldo1: ldo1 {
> +				regulator-always-on;
> +				regulator-boot-on;

First min/max constraints. Then always-on and boot-on properties.

> +				regulator-max-microvolt = <5000000>;
> +				regulator-min-microvolt = <1500000>;
> +			};
> +
> +			reg_ldo2: ldo2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <5000000>;
> +				regulator-min-microvolt = <1500000>;
> +			};
> +
> +			reg_ldo3: ldo3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <5000000>;
> +				regulator-min-microvolt = <1500000>;
> +			};
> +
> +			reg_ldo4: ldo4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <5000000>;
> +				regulator-min-microvolt = <1500000>;
> +			};
> +
> +			reg_buck1: buck1 {
> +				fsl,ilim-ma = <4500>;

Where is this property documented?

> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-min-microvolt =  <400000>;
> +			};
> +
> +			reg_buck2: buck2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-min-microvolt =  <400000>;
> +			};
> +
> +			reg_buck3: buck3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-min-microvolt =  <400000>;
> +			};
> +
> +			reg_buck4: buck4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-min-microvolt =  <400000>;
> +				fast-slew = <1>;

Where is this property documented?

> +			};
> +
> +			reg_buck5: buck5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-min-microvolt =  <400000>;
> +			};
> +
> +			reg_buck6: buck6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-min-microvolt =  <400000>;
> +			};
> +
> +			reg_buck7: buck7 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-min-microvolt = <3300000>;
> +			};
> +
> +			reg_vsnvs: vsnvs {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-min-microvolt = <1800000>;
> +			};
> +		};
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL		0x400001c3
> +			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA		0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {

Not used.

> +		fsl,pins = <
> +			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
> +			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX	0x140
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_gpio: usdhc1grpgpio {

This should complain on bindings check. Please run dtbs_check. The "grp"
should be a suffix in node name, so "usdhc1gpiogrp".

> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6	0x41
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {

Not used.

Best regards,
Krzysztof
