Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4956E296C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461655AbgJWJor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:44:47 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:35589 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461640AbgJWJop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:44:45 -0400
Received: by mail-ej1-f65.google.com with SMTP id p5so1514034ejj.2;
        Fri, 23 Oct 2020 02:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B1d2F60z8dS4n1HEQQAApHlW3JfHv/Vhlxj9+gMTNHg=;
        b=OSAmRCfR1HJgoGLnSmjiWW1p6hYibA3Nay0kAnMJ+sSzB7h2l23ycqofHli+Lf4HZP
         dv6E29qpfq4zmvH3oVzuxHgWqmZLVNrnpLvEDCSBql1R3iKlTe1DtQFLMuEBpVezv6V0
         TXtK6dS0w2JQhr6YPSEtX/BzjPconLzlaEmXdt8ss9a5WEm1EhbiK1JCPaaNntNfepx6
         Kxlflt+CT6+CVrSWfLE125YyozdHBhl68GiB7OgoKWVXqSlXmz45yhHNt8pF+b+gTIz3
         H4nTOE7NKqHOEum8XqSUZWmZBQ16a7Hv0be+12m9W9qLn4CJMqgvS41vS7WVvoQg7lkb
         UvFQ==
X-Gm-Message-State: AOAM5314b6EBFiORqKCmRPY0W8fLmTET7ktQbT1ZdXJsQrSiH4H0SrmJ
        ZeKjf/dB0CxvyufpZafo9wo=
X-Google-Smtp-Source: ABdhPJzVHfPYoDPmwV3HnINGVFmqlSHXx14zaZ15MS5UxAkw9cVwc1JYzG+lZXWezCYy69mA4LsHOA==
X-Received: by 2002:a17:906:1643:: with SMTP id n3mr1061457ejd.459.1603446281807;
        Fri, 23 Oct 2020 02:44:41 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id n22sm507050eji.106.2020.10.23.02.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 02:44:40 -0700 (PDT)
Date:   Fri, 23 Oct 2020 11:44:37 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx: Add Beacon i.MX8M Nano development kit
Message-ID: <20201023094437.GB42872@kozik-lap>
References: <20201022165751.771695-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201022165751.771695-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 11:57:50AM -0500, Adam Ford wrote:
> Beacon Embeddedworks is launching a development kit based on the
> i.MX8M Nano SoC.  The kit consists of a System on Module (SOM)
> + baseboard.  The SOM has the SoC, eMMC, and Ethernet. The baseboard
> has an wm8962 audio CODEC, and a single USB OTG.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> Based on top of previous series found:
> https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=366931
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index c7890b622587..ab47b3b1de75 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -31,6 +31,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mn-beacon-kit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-var-som-symphony.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
> new file mode 100644
> index 000000000000..898715aa79b5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
> @@ -0,0 +1,313 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2020 Compass Electronics Group, LLC
> + */
> +
> +/ {
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led0 {

led-0

> +			label = "gen_led0";
> +			gpios = <&pca6416_1 4 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		led1 {
> +			label = "gen_led1";
> +			gpios = <&pca6416_1 5 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		led2 {
> +			label = "gen_led2";
> +			gpios = <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		led3 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_led3>;
> +			label = "heartbeat";
> +			gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	reg_audio: regulator-audio {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3v3_aud";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&pca6416_1 11 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VSD_3V3";

lowercase name please to match everything else.

> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_usb_otg_vbus: regulator-usb {
> +		compatible = "regulator-fixed";
> +		pinctrl-0 = <&pinctrl_reg_usb_otg>;

pinctrl-names... and test whether it really works after this change.
Without it the pinctrl was probably not applied.

> +		regulator-name = "usb_otg_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio4 29 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	sound {
> +		compatible = "fsl,imx-audio-wm8962";
> +		model = "wm8962-audio";
> +		audio-cpu = <&sai3>;
> +		audio-codec = <&wm8962>;
> +		audio-routing =
> +			"Headphone Jack", "HPOUTL",
> +			"Headphone Jack", "HPOUTR",
> +			"Ext Spk", "SPKOUTL",
> +			"Ext Spk", "SPKOUTR",
> +			"AMIC", "MICBIAS",
> +			"IN3R", "AMIC";
> +	};
> +};
> +
> +&ecspi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_espi2>;
> +	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +
> +	eeprom@0 {
> +		compatible = "microchip,at25160bn", "atmel,at25";
> +		reg = <0>;
> +		spi-max-frequency = <5000000>;
> +		spi-cpha;
> +		spi-cpol;
> +		pagesize = <32>;
> +		size = <2048>;
> +		address-width = <16>;
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";

Can you document why you keep empty bus enabled?

> +};
> +
> +&i2c4 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c4>;
> +	status = "okay";
> +
> +	pca6416_0: gpio@20 {
> +		compatible = "nxp,pcal6416";
> +		reg = <0x20>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pcal6414>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	pca6416_1: gpio@21 {
> +		compatible = "nxp,pcal6416";
> +		reg = <0x21>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	wm8962: audio-codec@1a {
> +		compatible = "wlf,wm8962";
> +		reg = <0x1a>;
> +		clocks = <&clk IMX8MN_CLK_SAI3_ROOT>;
> +		clock-names = "xclk";
> +		DCVDD-supply = <&reg_audio>;
> +		DBVDD-supply = <&reg_audio>;
> +		AVDD-supply = <&reg_audio>;
> +		CPVDD-supply = <&reg_audio>;
> +		MICVDD-supply = <&reg_audio>;
> +		PLLVDD-supply = <&reg_audio>;
> +		SPKVDD1-supply = <&reg_audio>;
> +		SPKVDD2-supply = <&reg_audio>;
> +		gpio-cfg = <
> +			0x0000 /* 0:Default */
> +			0x0000 /* 1:Default */
> +			0x0000 /* 2:FN_DMICCLK */
> +			0x0000 /* 3:Default */
> +			0x0000 /* 4:FN_DMICCDAT */
> +			0x0000 /* 5:Default */
> +		>;
> +	};
> +};
> +
> +&easrc {
> +	fsl,asrc-rate  = <48000>;
> +	status = "okay";
> +};
> +
> +&sai3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai3>;
> +	assigned-clocks = <&clk IMX8MN_CLK_SAI3>;
> +	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates = <24576000>;
> +	fsl,sai-mclk-direction-output;
> +	status = "okay";
> +};
> +
> +&snvs_pwrkey {
> +	status = "okay";
> +};
> +
> +&uart2 { /* console */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	assigned-clocks = <&clk IMX8MN_CLK_UART3>;
> +	assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_80M>;
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	vbus-supply = <&reg_usb_otg_vbus>;
> +	disable-over-current;
> +	dr_mode="otg";
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
> +	bus-width = <4>;
> +	vmmc-supply = <&reg_usdhc2_vmmc>;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_espi2: espi2grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x82
> +			MX8MN_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x82
> +			MX8MN_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x82
> +			MX8MN_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x41
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
> +			MX8MN_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_i2c4: i2c4grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_I2C4_SCL_I2C4_SCL		0x400001c3
> +			MX8MN_IOMUXC_I2C4_SDA_I2C4_SDA		0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_led3: led3grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SAI3_RXFS_GPIO4_IO28	0x41
> +		>;
> +	};
> +
> +	pinctrl_pcal6414: pcal6414-gpiogrp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19
> +		>;
> +	};
> +
> +	pinctrl_reg_usb_otg: reg-otggrp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SAI3_RXC_GPIO4_IO29     0x19
> +		>;
> +	};
> +
> +	pinctrl_sai3: sai3grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC     0xd6
> +			MX8MN_IOMUXC_SAI3_TXC_SAI3_TX_BCLK      0xd6
> +			MX8MN_IOMUXC_SAI3_MCLK_SAI3_MCLK        0xd6
> +			MX8MN_IOMUXC_SAI3_TXD_SAI3_TX_DATA0     0xd6
> +			MX8MN_IOMUXC_SAI3_RXD_SAI3_RX_DATA0	0xd6
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
> +			MX8MN_IOMUXC_UART2_TXD_UART2_DCE_TX	0x140
> +		>;
> +	};
> +
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_ECSPI1_SCLK_UART3_DCE_RX	0x40
> +			MX8MN_IOMUXC_ECSPI1_MOSI_UART3_DCE_TX	0x40
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SD2_CD_B_USDHC2_CD_B	0x41
> +			MX8MN_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK	0x190
> +			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD	0x1d0
> +			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d0
> +			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d0
> +			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d0
> +			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d0
> +			MX8MN_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK	0x194
> +			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD	0x1d4
> +			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
> +			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
> +			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
> +			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
> +			MX8MN_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK	0x196
> +			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD	0x1d6
> +			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d6
> +			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d6
> +			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d6
> +			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d6
> +			MX8MN_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
> +		>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
> new file mode 100644
> index 000000000000..faa55d888065
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2020 Compass Electronics Group, LLC
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mn.dtsi"
> +#include "imx8mn-beacon-som.dtsi"
> +#include "imx8mn-beacon-baseboard.dtsi"

Why do you need baseboard as DTSI? Is is separate than kit? Judging by
contents look like just empty/fake DTS and the baseboard should be the
DTS.

Another hint: Baseboard also does not have its compatible, so it cannot
exist in real life separate from the development kit...

> +
> +/ {
> +	model = "Beacon EmbeddedWorks i.MX8M Mini Development Kit";
> +	compatible = "beacon,imx8mn-beacon-kit", "fsl,imx8mn";

Undocumented compatible.

> +
> +	chosen {
> +		stdout-path = &uart2;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
> new file mode 100644
> index 000000000000..a2ce036b37f3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
> @@ -0,0 +1,429 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2020 Compass Electronics Group, LLC
> + */
> +
> +/ {
> +	usdhc1_pwrseq: usdhc1_pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usdhc1_gpio>;
> +		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
> +		clocks = <&osc_32k>;
> +		clock-names = "ext_clock";
> +		post-power-on-delay-ms = <80>;
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000 0 0x80000000>;
> +	};
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&buck2_reg>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&buck2_reg>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&buck2_reg>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&buck2_reg>;
> +};

Empty line please.

Best regards,
Krzysztof
