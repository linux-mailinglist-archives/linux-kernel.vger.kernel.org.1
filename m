Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E835D2CC17A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbgLBP67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 10:58:59 -0500
Received: from relay1.mymailcheap.com ([144.217.248.102]:46056 "EHLO
        relay1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbgLBP66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:58:58 -0500
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay1.mymailcheap.com (Postfix) with ESMTPS id BBBAE3F202;
        Wed,  2 Dec 2020 15:57:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 99E812A365;
        Wed,  2 Dec 2020 10:57:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1606924644;
        bh=hwwPTfPgASBh+GzvSdqdfyG4H6+5mcf5VD1FvR13etU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UwIibVfxx5l4G9JUmsVJNJpdbqhFF+AvXIlVCqX7mafLa35l+qweHl9GIVRyP7/id
         3fcTTsFQ6Ho/kpiRdfefTBvWakcUFMRTCLuWsm+3GkXSa+cnnJkRLnwDS8d7JIZAaB
         CjlOABNj/+Oalpa7dp+sKPDtwS85IMUsuekBXk4M=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xOha9nIWUuj1; Wed,  2 Dec 2020 10:57:22 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Wed,  2 Dec 2020 10:57:22 -0500 (EST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 16CC340026;
        Wed,  2 Dec 2020 15:57:21 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="aDH0tLLz";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.162.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 38E9040026;
        Wed,  2 Dec 2020 15:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1606924631; bh=hwwPTfPgASBh+GzvSdqdfyG4H6+5mcf5VD1FvR13etU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aDH0tLLzbqdhMFNKFgzqZ0GUbB6cT2A4DHaZ5ba/GsxDM/ZTnFONojKwBBfVSAfuy
         aA5/bhKLKSx3X4U40OoHuNefBW9X7sLLS4mUkKioXY6jzOLAgivq4GhrHmdOqj2QcC
         Mv51rSBR/L0MMIf9PDwaa04A101eq3/HGVKSsIuo=
Message-ID: <138e642d404dde57996c679e504ffe3ce2f0cb7a.camel@aosc.io>
Subject: Re: [PATCH 8/8] arm64: dts: allwinner: Add OrangePi Zero 2 .dts
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Icenowy Zheng <icenowy@aosc.xyz>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Wed, 02 Dec 2020 23:57:02 +0800
In-Reply-To: <20201202135409.13683-9-andre.przywara@arm.com>
References: <20201202135409.13683-1-andre.przywara@arm.com>
         <20201202135409.13683-9-andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 16CC340026
X-Spamd-Result: default: False [1.40 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.162.181:received];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_TWELVE(0.00)[12];
         DBL_PROHIBIT(0.00)[0.0.0.36:email,0.0.0.1:email];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020-12-02星期三的 13:54 +0000，Andre Przywara写道：
> The OrangePi Zero 2 is a development board with the new H616 SoC.
> 
> It features the usual connectors used on those small boards, and
> comes
> with the AXP305, which seems to be compatible with the AXP805.
> 
> For more details see: http://linux-sunxi.org/Xunlong_Orange_Pi_Zero2
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../allwinner/sun50i-h616-orangepi-zero2.dts  | 228
> ++++++++++++++++++
>  2 files changed, 229 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-
> orangepi-zero2.dts
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile
> b/arch/arm64/boot/dts/allwinner/Makefile
> index 211d1e9d4701..0cf8299b1ce7 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -35,3 +35,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-
> plus.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-
> zero2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-
> zero2.dts
> new file mode 100644
> index 000000000000..814f5b4fec7c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> @@ -0,0 +1,228 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2020 Arm Ltd.
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	model = "OrangePi Zero2";
> +	compatible = "xunlong,orangepi-zero2", "allwinner,sun50i-h616";
> +
> +	aliases {
> +		ethernet0 = &emac0;
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		power {
> +			label = "orangepi:red:power";
> +			gpios = <&pio 2 13 GPIO_ACTIVE_HIGH>; /* PC13
> */
> +			default-state = "on";
> +		};
> +
> +		status {
> +			label = "orangepi:green:status";
> +			gpios = <&pio 2 12 GPIO_ACTIVE_HIGH>; /* PC12
> */
> +		};
> +	};
> +
> +	reg_vcc5v: vcc5v {
> +		/* board wide 5V supply directly from the USB-C socket
> */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_usb1_vbus: usb1-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb1-vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>; /* PC16 */
> +		status = "okay";
> +	};
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +/* USB 2 & 3 are on headers only. */
> +
> +&emac0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&ext_rgmii_pins>;
> +	phy-mode = "rgmii";
> +	phy-handle = <&ext_rgmii_phy>;
> +	phy-supply = <&reg_dcdce>;
> +	allwinner,rx-delay-ps = <3100>;
> +	allwinner,tx-delay-ps = <700>;
> +	status = "okay";
> +};
> +
> +&mdio {
> +	ext_rgmii_phy: ethernet-phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <1>;
> +	};
> +};
> +
> +&mmc0 {
> +	vmmc-supply = <&reg_dcdce>;
> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&ohci0 {
> +	status = "okay";
> +};
> +
> +&ohci1 {
> +	status = "okay";
> +};
> +
> +&r_i2c {
> +	status = "okay";
> +
> +	axp305: pmic@36 {
> +		compatible = "x-powers,axp305", "x-powers,axp805",
> +			     "x-powers,axp806";
> +		reg = <0x36>;
> +
> +		/* dummy interrupt to appease the driver for now */
> +		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-controller;
> +		#interrupt-cells = <1>;

Is dummy interrupt future-proof?

> +
> +		x-powers,self-working-mode;
> +		vina-supply = <&reg_vcc5v>;
> +		vinb-supply = <&reg_vcc5v>;
> +		vinc-supply = <&reg_vcc5v>;
> +		vind-supply = <&reg_vcc5v>;
> +		vine-supply = <&reg_vcc5v>;
> +		aldoin-supply = <&reg_vcc5v>;
> +		bldoin-supply = <&reg_vcc5v>;
> +		cldoin-supply = <&reg_vcc5v>;
> +
> +		regulators {
> +			reg_aldo1: aldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc-sys";
> +			};
> +
> +			reg_aldo2: aldo2 {
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc3v3-ext";
> +			};
> +
> +			reg_aldo3: aldo3 {
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc3v3-ext2";
> +			};
> +
> +			reg_bldo1: bldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc1v8";
> +			};
> +
> +			bldo2 {
> +				/* unused */
> +			};
> +
> +			bldo3 {
> +				/* unused */
> +			};
> +
> +			bldo4 {
> +				/* unused */
> +			};
> +
> +			cldo1 {
> +				/* reserved */
> +			};
> +
> +			cldo2 {
> +				/* unused */
> +			};
> +
> +			cldo3 {
> +				/* unused */
> +			};
> +
> +			reg_dcdca: dcdca {
> +				regulator-always-on;
> +				regulator-min-microvolt = <810000>;
> +				regulator-max-microvolt = <1080000>;
> +				regulator-name = "vdd-cpu";
> +			};
> +
> +			reg_dcdcc: dcdcc {
> +				regulator-always-on;
> +				regulator-min-microvolt = <810000>;
> +				regulator-max-microvolt = <1080000>;
> +				regulator-name = "vdd-gpu-sys";
> +			};
> +
> +			reg_dcdcd: dcdcd {
> +				regulator-always-on;
> +				regulator-min-microvolt = <1500000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-name = "vdd-dram";
> +			};
> +
> +			reg_dcdce: dcdce {
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc-eth-mmc";
> +			};
> +
> +			sw {
> +				/* unused */
> +			};
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_ph_pins>;
> +	status = "okay";
> +};
> +
> +&usbotg {
> +	dr_mode = "otg";

The board is locked to a UFP due to fixed resistor on CC. OTG is not
possible.

> +	status = "okay";
> +};
> +
> +&usbphy {
> +	usb0_vbus-supply = <&reg_vcc5v>;
> +	usb1_vbus-supply = <&reg_usb1_vbus>;
> +	status = "okay";
> +};
