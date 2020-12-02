Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A232CC210
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbgLBQUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:20:03 -0500
Received: from mailoutvs27.siol.net ([185.57.226.218]:49931 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726307AbgLBQUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:20:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 27D2C520F6E;
        Wed,  2 Dec 2020 17:19:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5p1W-PFuE6VR; Wed,  2 Dec 2020 17:19:18 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 7DB75520EBA;
        Wed,  2 Dec 2020 17:19:18 +0100 (CET)
Received: from kista.localnet (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id EB525520F6E;
        Wed,  2 Dec 2020 17:19:17 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.xyz>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: Re: [PATCH 8/8] arm64: dts: allwinner: Add OrangePi Zero 2 .dts
Date:   Wed, 02 Dec 2020 17:25:29 +0100
Message-ID: <1774678.MeMAzNTZAJ@kista>
In-Reply-To: <20201202160702.rdigwtcv3avil4n3@gilmour>
References: <20201202135409.13683-1-andre.przywara@arm.com> <20201202135409.13683-9-andre.przywara@arm.com> <20201202160702.rdigwtcv3avil4n3@gilmour>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 02. december 2020 ob 17:07:02 CET je Maxime Ripard napisal(a):
> On Wed, Dec 02, 2020 at 01:54:09PM +0000, Andre Przywara wrote:
> > The OrangePi Zero 2 is a development board with the new H616 SoC.
> > 
> > It features the usual connectors used on those small boards, and comes
> > with the AXP305, which seems to be compatible with the AXP805.
> > 
> > For more details see: http://linux-sunxi.org/Xunlong_Orange_Pi_Zero2
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
> >  .../allwinner/sun50i-h616-orangepi-zero2.dts  | 228 ++++++++++++++++++
> >  2 files changed, 229 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-
zero2.dts
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/
allwinner/Makefile
> > index 211d1e9d4701..0cf8299b1ce7 100644
> > --- a/arch/arm64/boot/dts/allwinner/Makefile
> > +++ b/arch/arm64/boot/dts/allwinner/Makefile
> > @@ -35,3 +35,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-
plus.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
> > +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts 
b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> > new file mode 100644
> > index 000000000000..814f5b4fec7c
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> > @@ -0,0 +1,228 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > +/*
> > + * Copyright (C) 2020 Arm Ltd.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "sun50i-h616.dtsi"
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +/ {
> > +	model = "OrangePi Zero2";
> > +	compatible = "xunlong,orangepi-zero2", "allwinner,sun50i-h616";
> 
> This needs to be documented too
> 
> > +	aliases {
> > +		ethernet0 = &emac0;
> > +		serial0 = &uart0;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = "serial0:115200n8";
> > +	};
> > +
> > +	leds {
> > +		compatible = "gpio-leds";
> > +
> > +		power {
> > +			label = "orangepi:red:power";
> > +			gpios = <&pio 2 13 GPIO_ACTIVE_HIGH>; /* 
PC13 */
> > +			default-state = "on";
> > +		};
> > +
> > +		status {
> > +			label = "orangepi:green:status";
> > +			gpios = <&pio 2 12 GPIO_ACTIVE_HIGH>; /* 
PC12 */
> > +		};
> 
> Those node names don't follow the led binding convention
> 
> > +	};
> > +
> > +	reg_vcc5v: vcc5v {
> > +		/* board wide 5V supply directly from the USB-C socket 
*/
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc-5v";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		regulator-always-on;
> > +	};
> > +
> > +	reg_usb1_vbus: usb1-vbus {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "usb1-vbus";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		enable-active-high;
> > +		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>; /* PC16 */
> > +		status = "okay";
> > +	};
> > +};
> > +
> > +&ehci0 {
> > +	status = "okay";
> > +};
> > +
> > +&ehci1 {
> > +	status = "okay";
> > +};
> > +
> > +/* USB 2 & 3 are on headers only. */
> > +
> > +&emac0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&ext_rgmii_pins>;
> > +	phy-mode = "rgmii";
> > +	phy-handle = <&ext_rgmii_phy>;
> > +	phy-supply = <&reg_dcdce>;
> > +	allwinner,rx-delay-ps = <3100>;
> > +	allwinner,tx-delay-ps = <700>;
> > +	status = "okay";
> > +};
> > +
> > +&mdio {
> > +	ext_rgmii_phy: ethernet-phy@1 {
> > +		compatible = "ethernet-phy-ieee802.3-c22";
> > +		reg = <1>;
> > +	};
> > +};
> > +
> > +&mmc0 {
> > +	vmmc-supply = <&reg_dcdce>;
> > +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> > +	bus-width = <4>;
> > +	status = "okay";
> > +};
> > +
> > +&ohci0 {
> > +	status = "okay";
> > +};
> > +
> > +&ohci1 {
> > +	status = "okay";
> > +};
> > +
> > +&r_i2c {
> > +	status = "okay";
> > +
> > +	axp305: pmic@36 {
> > +		compatible = "x-powers,axp305", "x-powers,axp805",
> > +			     "x-powers,axp806";
> > +		reg = <0x36>;
> > +
> > +		/* dummy interrupt to appease the driver for now */
> > +		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-controller;
> > +		#interrupt-cells = <1>;
> > +
> > +		x-powers,self-working-mode;
> > +		vina-supply = <&reg_vcc5v>;
> > +		vinb-supply = <&reg_vcc5v>;
> > +		vinc-supply = <&reg_vcc5v>;
> > +		vind-supply = <&reg_vcc5v>;
> > +		vine-supply = <&reg_vcc5v>;
> > +		aldoin-supply = <&reg_vcc5v>;
> > +		bldoin-supply = <&reg_vcc5v>;
> > +		cldoin-supply = <&reg_vcc5v>;
> > +
> > +		regulators {
> > +			reg_aldo1: aldo1 {
> > +				regulator-always-on;
> > +				regulator-min-microvolt = 
<3300000>;
> > +				regulator-max-microvolt = 
<3300000>;
> > +				regulator-name = "vcc-sys";
> > +			};
> > +
> > +			reg_aldo2: aldo2 {
> > +				regulator-min-microvolt = 
<3300000>;
> > +				regulator-max-microvolt = 
<3300000>;
> > +				regulator-name = "vcc3v3-ext";
> > +			};
> > +
> > +			reg_aldo3: aldo3 {
> > +				regulator-min-microvolt = 
<3300000>;
> > +				regulator-max-microvolt = 
<3300000>;
> > +				regulator-name = "vcc3v3-ext2";
> > +			};
> > +
> > +			reg_bldo1: bldo1 {
> > +				regulator-always-on;
> > +				regulator-min-microvolt = 
<1800000>;
> > +				regulator-max-microvolt = 
<1800000>;
> > +				regulator-name = "vcc1v8";
> > +			};
> > +
> > +			bldo2 {
> > +				/* unused */
> > +			};
> > +
> > +			bldo3 {
> > +				/* unused */
> > +			};
> > +
> > +			bldo4 {
> > +				/* unused */
> > +			};
> > +
> > +			cldo1 {
> > +				/* reserved */
> > +			};
> > +
> > +			cldo2 {
> > +				/* unused */
> > +			};
> > +
> > +			cldo3 {
> > +				/* unused */
> > +			};
> > +
> > +			reg_dcdca: dcdca {
> > +				regulator-always-on;
> > +				regulator-min-microvolt = 
<810000>;
> > +				regulator-max-microvolt = 
<1080000>;
> > +				regulator-name = "vdd-cpu";
> > +			};
> > +
> > +			reg_dcdcc: dcdcc {
> > +				regulator-always-on;
> > +				regulator-min-microvolt = 
<810000>;
> > +				regulator-max-microvolt = 
<1080000>;
> > +				regulator-name = "vdd-gpu-sys";
> > +			};
> > +
> > +			reg_dcdcd: dcdcd {
> > +				regulator-always-on;
> > +				regulator-min-microvolt = 
<1500000>;
> > +				regulator-max-microvolt = 
<1500000>;
> > +				regulator-name = "vdd-dram";
> > +			};
> > +
> > +			reg_dcdce: dcdce {
> > +				regulator-boot-on;
> > +				regulator-min-microvolt = 
<3300000>;
> > +				regulator-max-microvolt = 
<3300000>;
> > +				regulator-name = "vcc-eth-mmc";
> > +			};
> > +
> > +			sw {
> > +				/* unused */
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&uart0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&uart0_ph_pins>;
> > +	status = "okay";
> > +};
> > +
> > +&usbotg {
> > +	dr_mode = "otg";
> > +	status = "okay";
> > +};
> > +
> > +&usbphy {
> > +	usb0_vbus-supply = <&reg_vcc5v>;
> > +	usb1_vbus-supply = <&reg_usb1_vbus>;
> > +	status = "okay";
> > +};
> 
> Did you really test it as OTG without an ID pin?

As stated in cover letter, USB doesn't work yet. USB related nodes, both here 
and DTSI should be dropped until they work.

Best regards,
Jernej


