Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9882DFC85
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 15:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgLUOC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 09:02:29 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:36336 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgLUOC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 09:02:28 -0500
Received: by mail-wr1-f48.google.com with SMTP id t16so11184583wra.3;
        Mon, 21 Dec 2020 06:02:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OYrNXIWJKG5ED2KKu9Om3ijK5pT2GBG2E9X3ZTb8yq0=;
        b=sIxG8FwZaDLZJN+t5u8DhvxN8Yx/oX7AuAcvb914gPmVae/drM9IqY1rQkMFdpXZUe
         MB/jt26+c+53hds15bBEAAK68oaRTEhXWaQB3icrmfPZPNTWyhpizCbUkXktF3/dB2ER
         ixgNDo7bdUXjTElBrUiYVIjP+C60gcYLUMv6bC+Zgk9GPesuE5owlvFTQAHCBY+Yaxcc
         oRXpARz3i8oxIEZTirTY62b72kOv2HHIryeERczTROjkScjAHJgXysRVuZ7f4jsyEPfZ
         lYEWqRFpW68Sa563ivAFdTjHn/armowCQ45/wiJ/jcgWJKVppoOKN43xdIHNNg5e7C2U
         tW/Q==
X-Gm-Message-State: AOAM532WVifRIxfvuw/aym7NA5e+Ef1j2uTBjNFyO7WRYfQtRx4qklJW
        LCWkE8PkxGjHjKSwyts021w=
X-Google-Smtp-Source: ABdhPJxWkgHcYDfVNYW87roK6nZ3Xk5DjPilEo1WaOB9cQ6XotwLS6rhHEhclWpc/ujQWWCK7X1X6A==
X-Received: by 2002:adf:e4ca:: with SMTP id v10mr19031168wrm.260.1608559305520;
        Mon, 21 Dec 2020 06:01:45 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id m11sm22656364wmi.16.2020.12.21.06.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 06:01:44 -0800 (PST)
Date:   Mon, 21 Dec 2020 15:01:42 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matteo Lisi <matteo.lisi@engicam.com>
Subject: Re: [PATCH v2 4/6] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
 C.TOUCH 2.0
Message-ID: <20201221140142.GD31176@kozik-lap>
References: <20201221113151.94515-1-jagan@amarulasolutions.com>
 <20201221113151.94515-5-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201221113151.94515-5-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 05:01:49PM +0530, Jagan Teki wrote:
> Engicam C.TOUCH 2.0 is an EDIMM compliant general purpose Carrier
> board.
> 
> Genaral features:
> - Ethernet 10/100
> - Wifi/BT
> - USB Type A/OTG
> - Audio Out
> - CAN
> - LVDS panel connector
> 
> i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.
> 
> i.Core MX8M Mini needs to mount on top of this Carrier board for
> creating complete i.Core MX8M Mini C.TOUCH 2.0 board.
> 
> Add support for it.
> 
> Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - enabled fec1 node
> - updated commit message
> - dropped engicam from filename since it aligned with imx6 engicam
>   dts files naming conventions.
> - add i2c nodes
> - fixed v1 comments
> 
>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
>  .../dts/freescale/imx8mm-engicam-common.dtsi  | 82 +++++++++++++++++++
>  .../dts/freescale/imx8mm-engicam-ctouch2.dtsi |  7 ++
>  .../freescale/imx8mm-icore-mx8mm-ctouch2.dts  | 21 +++++
>  4 files changed, 111 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 6f0777ee6cd6..8d49a2c74604 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -32,6 +32,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-ctouch2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-n801x-s.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-common.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-engicam-common.dtsi
> new file mode 100644
> index 000000000000..f7870efd9dab
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-common.dtsi
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2020 Engicam srl
> + * Copyright (c) 2020 Amarula Solutions(India)
> + */
> +
> +&fec1 {
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c4>;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
> +			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_i2c4: i2c4grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL		0x400001c3
> +			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA		0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
> +			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX	0x140
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_gpio: usdhc1gpiogrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6	0x41
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
> +		>;
> +	};
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};
> +
> +/* SD */
> +&usdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
> +	cd-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
> +	max-frequency = <50000000>;
> +	bus-width = <4>;
> +	no-1-8-v;
> +	pm-ignore-notify;
> +	keep-power-in-suspend;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi
> new file mode 100644
> index 000000000000..294df07289a2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2020 Engicam srl
> + * Copyright (c) 2020 Amarula Solutions(India)
> + */
> +
> +#include "imx8mm-engicam-common.dtsi"

The same as before - a DTSI file to include a DTSI. Remove it.

Best regards,
Krzysztof
