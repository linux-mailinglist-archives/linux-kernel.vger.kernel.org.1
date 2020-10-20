Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23176293917
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 12:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388385AbgJTKYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 06:24:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51229 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387515AbgJTKYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 06:24:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id d81so1215671wmc.1;
        Tue, 20 Oct 2020 03:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iv7Ma+yXNDD5dFPiw4GTSteoUC4I2TeiUkAGCTk6tG0=;
        b=NuaIE5rCwjtV8U4aiYnV3mipVac1z7M8qHs1kJUsInqKW7kCLHuPY8++pHOEprR9mx
         rkwJFfffQYP9mWCPnK5JtketPITBg3hAxSgVEc9OKfEsV88flz1daUQGMz/u9mgFKECf
         Gn5AH/CrzjAsgR0F4/jf2M8lTE9araZiL7cihLwQ9PCtgD0+kA2yo+f53gY+WOZ3h4w8
         DUr9U+0VyDTcF5wflW/tumEW0CbkQ8PPGC7ZF3MhlSw02Gl4lx0ecwQgt4c8DzP0WhVh
         fTXKZluoyYWA5tY5hg64MyuG3asmp/Lqnd//oqw+bIt5WfloObSxCDouxnt/vwRpKN4Y
         XPEQ==
X-Gm-Message-State: AOAM532sirGT5Hms6b1c0oflNZb2K2UrVz1H5dxLci89FcKNX4446LNf
        Jr1jk2Phyz0H0PQLi6441Ec=
X-Google-Smtp-Source: ABdhPJw3FRrobHh6vmzHD2nJ67/+Bte6kSWAsX5tWFSVBbx2M5tob3/WUUtadp94+cQQ41q3rnSuMw==
X-Received: by 2002:a7b:c387:: with SMTP id s7mr2157776wmj.52.1603189442642;
        Tue, 20 Oct 2020 03:24:02 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id o184sm2011577wmo.37.2020.10.20.03.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 03:24:01 -0700 (PDT)
Date:   Tue, 20 Oct 2020 12:23:55 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Robin van der Gracht <robin@protonic.nl>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 3/3] ARM: dts: add Van der Laan LANMCU board
Message-ID: <20201020102355.GB118941@kozik-lap>
References: <20201015090924.6185-1-o.rempel@pengutronix.de>
 <20201015090924.6185-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201015090924.6185-4-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 11:09:24AM +0200, Oleksij Rempel wrote:
> Van der Laan LANMCU is a module for the food storage rooms to control
> proper gas composition.
> 
> Co-Developed-by: Robin van der Gracht <robin@protonic.nl>
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  arch/arm/boot/dts/Makefile          |   1 +
>  arch/arm/boot/dts/imx6dl-lanmcu.dts | 469 ++++++++++++++++++++++++++++
>  2 files changed, 470 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-lanmcu.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 2289a28c0ff6..dc2543a7b7e9 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -447,6 +447,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6dl-icore.dtb \
>  	imx6dl-icore-mipi.dtb \
>  	imx6dl-icore-rqs.dtb \
> +	imx6dl-lanmcu.dtb \
>  	imx6dl-mamoj.dtb \
>  	imx6dl-nit6xlite.dtb \
>  	imx6dl-nitrogen6x.dtb \
> diff --git a/arch/arm/boot/dts/imx6dl-lanmcu.dts b/arch/arm/boot/dts/imx6dl-lanmcu.dts
> new file mode 100644
> index 000000000000..36c029dcc832
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-lanmcu.dts
> @@ -0,0 +1,469 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Protonic Holland
> + * Copyright (c) 2020 Oleksij Rempel <kernel@pengutronix.de>, Pengutronix
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include "imx6dl.dtsi"
> +
> +/ {
> +	model = "Van der Laan LANMCU";
> +	compatible = "vdl,lanmcu", "fsl,imx6dl";
> +
> +	chosen {
> +		stdout-path = &uart4;
> +	};
> +
> +	clock_ksz8081: clock-ksz8081 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <50000000>;
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm1 0 5000000 0>;
> +		brightness-levels = <0 1000>;
> +		num-interpolated-steps = <20>;
> +		default-brightness-level = <19>;
> +	};
> +
> +	display {
> +		compatible = "fsl,imx-parallel-display";
> +		pinctrl-0 = <&pinctrl_ipu1_disp>;
> +		pinctrl-names = "default";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +
> +			display_in: endpoint {
> +				remote-endpoint = <&ipu1_di0_disp0>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +
> +			display_out: endpoint {
> +				remote-endpoint = <&panel_in>;
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_leds>;
> +
> +		led-debug {

led-0 (dt spec naming requirement, upcomming dtschema as well) and add a
label if you want it to be nicely labeled for user-space.

> +			function = LED_FUNCTION_STATUS;
> +			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	panel {
> +		compatible = "edt,etm0700g0bdh6";
> +		backlight = <&backlight>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&display_out>;
> +			};
> +		};
> +	};
> +
> +	reg_otg_vbus: regulator-otg-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "otg-vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	usdhc2_wifi_pwrseq: usdhc2-wifi-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_wifi_npd>;
> +		reset-gpios = <&gpio6 10 GPIO_ACTIVE_LOW>;
> +	};
> +
> +};
> +
> +&can1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_can1>;
> +	status = "okay";
> +};
> +
> +&can2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_can2>;
> +	status = "okay";
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet>;
> +	phy-mode = "rmii";
> +	clocks = <&clks IMX6QDL_CLK_ENET>,
> +		 <&clks IMX6QDL_CLK_ENET>,
> +		 <&clock_ksz8081>;
> +	clock-names = "ipg", "ahb", "ptp";
> +	phy-handle = <&rgmii_phy>;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* Microchip KSZ8081RNA PHY */
> +		rgmii_phy: ethernet-phy@0 {
> +			reg = <0>;
> +			interrupts-extended = <&gpio5 23 IRQ_TYPE_LEVEL_LOW>;
> +			reset-gpios = <&gpio5 22 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <10000>;
> +			reset-deassert-us = <300>;
> +		};
> +	};
> +};
> +
> +&gpio1 {
> +	gpio-line-names =
> +		"", "SD1_CD", "", "", "", "", "", "",
> +		"DEBUG_0", "BL_PWM", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "ENET_LED_GREEN",
> +		"", "", "", "", "", "", "", "";
> +};
> +
> +&gpio3 {
> +	gpio-line-names =
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "TS_INT", "USB_OTG1_OC", "USB_OTG1_PWR", "",
> +		"", "", "", "", "UART2_CTS", "", "UART3_CTS", "";
> +};
> +
> +&gpio5 {
> +	gpio-line-names =
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "ENET_RST", "ENET_INT",
> +		"", "", "I2C1_SDA", "I2C1_SCL", "", "", "", "";
> +};
> +
> +&gpio6 {
> +	gpio-line-names =
> +		"", "", "", "", "", "", "", "",
> +		"", "", "WLAN_REG_ON", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "";
> +};
> +
> +&gpio7 {
> +	gpio-line-names =
> +		"", "", "", "", "", "", "", "",
> +		"EMMC_RST", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "";
> +};
> +
> +&i2c1 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	/* additional i2c devices are added automatically by the boot loader */
> +};
> +
> +&i2c3 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	touchscreen@38 {
> +		compatible = "edt,edt-ft5406";
> +		reg = <0x38>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_ts_edt>;
> +		interrupts-extended = <&gpio3 20 IRQ_TYPE_EDGE_FALLING>;
> +
> +		touchscreen-size-x = <1792>;
> +		touchscreen-size-y = <1024>;
> +
> +		touchscreen-fuzz-x = <0>;
> +		touchscreen-fuzz-y = <0>;
> +
> +		/* Touch screen calibration */
> +		threshold = <50>;
> +		gain = <5>;
> +		offset = <10>;
> +	};
> +
> +	rtc@51 {
> +		compatible = "nxp,pcf8563";
> +		reg = <0x51>;
> +	};
> +};
> +
> +&ipu1_di0_disp0 {
> +	remote-endpoint = <&display_in>;
> +};
> +
> +&pwm1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm1>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	linux,rs485-enabled-at-boot-time;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	linux,rs485-enabled-at-boot-time;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart4>;
> +	status = "okay";
> +};
> +
> +&usbotg {
> +	vbus-supply = <&reg_otg_vbus>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbotg>;
> +	phy_type = "utmi";
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	cd-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
> +	no-1-8-v;
> +	disable-wp;
> +	cap-sd-highspeed;
> +	no-mmc;
> +	no-sdio;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	no-1-8-v;
> +	non-removable;
> +	mmc-pwrseq = <&usdhc2_wifi_pwrseq>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	brcmf: bcrmf@1 {

node name "wifi"? Or "wifi-bt"? DT spec requires nodes to have more or
less generic names.

Best regards,
Krzysztof
