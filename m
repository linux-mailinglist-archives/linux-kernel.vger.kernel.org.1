Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1282CC2A0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgLBQo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:44:26 -0500
Received: from foss.arm.com ([217.140.110.172]:44850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728470AbgLBQoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:44:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 541671063;
        Wed,  2 Dec 2020 08:43:38 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55CE63F718;
        Wed,  2 Dec 2020 08:43:36 -0800 (PST)
Subject: Re: [PATCH 8/8] arm64: dts: allwinner: Add OrangePi Zero 2 .dts
To:     Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Icenowy Zheng <icenowy@aosc.xyz>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20201202135409.13683-1-andre.przywara@arm.com>
 <20201202135409.13683-9-andre.przywara@arm.com>
 <138e642d404dde57996c679e504ffe3ce2f0cb7a.camel@aosc.io>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <4b2a99dc-08ae-1a2d-43f8-bc07b3c93ace@arm.com>
Date:   Wed, 2 Dec 2020 16:43:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <138e642d404dde57996c679e504ffe3ce2f0cb7a.camel@aosc.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2020 15:57, Icenowy Zheng wrote:
> 在 2020-12-02星期三的 13:54 +0000，Andre Przywara写道：
>> The OrangePi Zero 2 is a development board with the new H616 SoC.
>>
>> It features the usual connectors used on those small boards, and
>> comes
>> with the AXP305, which seems to be compatible with the AXP805.
>>
>> For more details see: http://linux-sunxi.org/Xunlong_Orange_Pi_Zero2
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>>  .../allwinner/sun50i-h616-orangepi-zero2.dts  | 228
>> ++++++++++++++++++
>>  2 files changed, 229 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-
>> orangepi-zero2.dts
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/Makefile
>> b/arch/arm64/boot/dts/allwinner/Makefile
>> index 211d1e9d4701..0cf8299b1ce7 100644
>> --- a/arch/arm64/boot/dts/allwinner/Makefile
>> +++ b/arch/arm64/boot/dts/allwinner/Makefile
>> @@ -35,3 +35,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-
>> plus.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
>> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-
>> zero2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-
>> zero2.dts
>> new file mode 100644
>> index 000000000000..814f5b4fec7c
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
>> @@ -0,0 +1,228 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
>> +/*
>> + * Copyright (C) 2020 Arm Ltd.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "sun50i-h616.dtsi"
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +/ {
>> +	model = "OrangePi Zero2";
>> +	compatible = "xunlong,orangepi-zero2", "allwinner,sun50i-h616";
>> +
>> +	aliases {
>> +		ethernet0 = &emac0;
>> +		serial0 = &uart0;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +
>> +		power {
>> +			label = "orangepi:red:power";
>> +			gpios = <&pio 2 13 GPIO_ACTIVE_HIGH>; /* PC13
>> */
>> +			default-state = "on";
>> +		};
>> +
>> +		status {
>> +			label = "orangepi:green:status";
>> +			gpios = <&pio 2 12 GPIO_ACTIVE_HIGH>; /* PC12
>> */
>> +		};
>> +	};
>> +
>> +	reg_vcc5v: vcc5v {
>> +		/* board wide 5V supply directly from the USB-C socket
>> */
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc-5v";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-always-on;
>> +	};
>> +
>> +	reg_usb1_vbus: usb1-vbus {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "usb1-vbus";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		enable-active-high;
>> +		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>; /* PC16 */
>> +		status = "okay";
>> +	};
>> +};
>> +
>> +&ehci0 {
>> +	status = "okay";
>> +};
>> +
>> +&ehci1 {
>> +	status = "okay";
>> +};
>> +
>> +/* USB 2 & 3 are on headers only. */
>> +
>> +&emac0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&ext_rgmii_pins>;
>> +	phy-mode = "rgmii";
>> +	phy-handle = <&ext_rgmii_phy>;
>> +	phy-supply = <&reg_dcdce>;
>> +	allwinner,rx-delay-ps = <3100>;
>> +	allwinner,tx-delay-ps = <700>;
>> +	status = "okay";
>> +};
>> +
>> +&mdio {
>> +	ext_rgmii_phy: ethernet-phy@1 {
>> +		compatible = "ethernet-phy-ieee802.3-c22";
>> +		reg = <1>;
>> +	};
>> +};
>> +
>> +&mmc0 {
>> +	vmmc-supply = <&reg_dcdce>;
>> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
>> +	bus-width = <4>;
>> +	status = "okay";
>> +};
>> +
>> +&ohci0 {
>> +	status = "okay";
>> +};
>> +
>> +&ohci1 {
>> +	status = "okay";
>> +};
>> +
>> +&r_i2c {
>> +	status = "okay";
>> +
>> +	axp305: pmic@36 {
>> +		compatible = "x-powers,axp305", "x-powers,axp805",
>> +			     "x-powers,axp806";
>> +		reg = <0x36>;
>> +
>> +		/* dummy interrupt to appease the driver for now */
>> +		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-controller;
>> +		#interrupt-cells = <1>;
> 
> Is dummy interrupt future-proof?

No, it's just a placeholder. The whole interrupt controller story isn't
fully clear yet, the BSP DTS mentions one, but I didn't have time to
investigate this yet. There is no NMI pad anymore, but an NMI IRQ number
in this GIC table. The OPi Zero2 does not connect the AXP's IRQ pin to
anything.

I haven't checked the AXP driver yet, maybe it just needs to accept no
interrupts?

>> +
>> +		x-powers,self-working-mode;
>> +		vina-supply = <&reg_vcc5v>;
>> +		vinb-supply = <&reg_vcc5v>;
>> +		vinc-supply = <&reg_vcc5v>;
>> +		vind-supply = <&reg_vcc5v>;
>> +		vine-supply = <&reg_vcc5v>;
>> +		aldoin-supply = <&reg_vcc5v>;
>> +		bldoin-supply = <&reg_vcc5v>;
>> +		cldoin-supply = <&reg_vcc5v>;
>> +
>> +		regulators {
>> +			reg_aldo1: aldo1 {
>> +				regulator-always-on;
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-name = "vcc-sys";
>> +			};
>> +
>> +			reg_aldo2: aldo2 {
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-name = "vcc3v3-ext";
>> +			};
>> +
>> +			reg_aldo3: aldo3 {
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-name = "vcc3v3-ext2";
>> +			};
>> +
>> +			reg_bldo1: bldo1 {
>> +				regulator-always-on;
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-name = "vcc1v8";
>> +			};
>> +
>> +			bldo2 {
>> +				/* unused */
>> +			};
>> +
>> +			bldo3 {
>> +				/* unused */
>> +			};
>> +
>> +			bldo4 {
>> +				/* unused */
>> +			};
>> +
>> +			cldo1 {
>> +				/* reserved */
>> +			};
>> +
>> +			cldo2 {
>> +				/* unused */
>> +			};
>> +
>> +			cldo3 {
>> +				/* unused */
>> +			};
>> +
>> +			reg_dcdca: dcdca {
>> +				regulator-always-on;
>> +				regulator-min-microvolt = <810000>;
>> +				regulator-max-microvolt = <1080000>;
>> +				regulator-name = "vdd-cpu";
>> +			};
>> +
>> +			reg_dcdcc: dcdcc {
>> +				regulator-always-on;
>> +				regulator-min-microvolt = <810000>;
>> +				regulator-max-microvolt = <1080000>;
>> +				regulator-name = "vdd-gpu-sys";
>> +			};
>> +
>> +			reg_dcdcd: dcdcd {
>> +				regulator-always-on;
>> +				regulator-min-microvolt = <1500000>;
>> +				regulator-max-microvolt = <1500000>;
>> +				regulator-name = "vdd-dram";
>> +			};
>> +
>> +			reg_dcdce: dcdce {
>> +				regulator-boot-on;
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-name = "vcc-eth-mmc";
>> +			};
>> +
>> +			sw {
>> +				/* unused */
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&uart0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart0_ph_pins>;
>> +	status = "okay";
>> +};
>> +
>> +&usbotg {
>> +	dr_mode = "otg";
> 
> The board is locked to a UFP due to fixed resistor on CC. OTG is not
> possible.

Ah, good point, I forgot to check this (not yet familiar with USB-C so
much). Makes some sense, since this is the primary power connector as well.

Cheers,
Andre

> 
>> +	status = "okay";
>> +};
>> +
>> +&usbphy {
>> +	usb0_vbus-supply = <&reg_vcc5v>;
>> +	usb1_vbus-supply = <&reg_usb1_vbus>;
>> +	status = "okay";
>> +};

