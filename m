Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5712989F8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 11:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768921AbgJZKEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 06:04:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391593AbgJZJyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 05:54:10 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4FD52087C;
        Mon, 26 Oct 2020 09:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603706049;
        bh=hreaVvnt+U1PFCi0QIABXsOnQuEkNKqJ/KyzQCAUOC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u1FtUd1n+AU2L3TQTvBJZIWjGH2bkz8tsfhrFJ1onw+kQRapnDmKC+E8/fEOcBjIm
         d2bqirQ10oYSRUr0g0y21B/Hh53BFyUKygj5LO+++91yG7G/ZxExoiYvkX1iHwECpJ
         rniitZDFeh5SJhYB07OmP4W4mfzhftUWl8hfzUuc=
Received: by pali.im (Postfix)
        id 5163DA4B; Mon, 26 Oct 2020 10:54:06 +0100 (CET)
Date:   Mon, 26 Oct 2020 10:54:06 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Vladimir Vid <vladimir.vid@sartura.hr>
Cc:     devicetree@vger.kernel.org, a.heider@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tmn505@gmail.com, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        robh+dt@kernel.org
Subject: Re: [PATCH v2] arm64: dts: marvell: add DT for ESPRESSObin-Ultra
Message-ID: <20201026095406.2ulhjsvg7he2xuoq@pali>
References: <20201023162110.265857-1-vladimir.vid@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023162110.265857-1-vladimir.vid@sartura.hr>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Friday 23 October 2020 18:21:11 Vladimir Vid wrote:
> This adds support for ESPRESSObin-Ultra from Globalscale.
> 
> Specifications are similar to the base ESPRESSObin board, with main
> difference being being WAN port with PoE capability and 2 additional ethernet ports.
> 
> Full specifications:
> 
> 1x Marvell 64 bit Dual Core ARM A53 Armada 3700 SOC clocked up to 1.2Ghz
> 1x Topaz 6341 Networking Switch
> 1GB DDR4
> 8GB eMMC
> 1x WAN with 30W POE
> 4x Gb LAN
> 1x RTC Clock and battery
> 1x DC Jack
> 1x USB 3.0 Type A
> 1x USB 2.0 Type A
> 1x SIM NanoSIM card Slot
> 1x Power Button
> 4x LED
> 1x Reset button
> 1x microUSB for UART
> 1x M.2 2280 slot for memory
> 1x 2x2 802.11ac Wi-Fi
> 1x MiniPCIE slot for Wi-Fi (PCIe interface)
> 
> Signed-off-by: Vladimir Vid <vladimir.vid@sartura.hr>
> ---
> 
> v2 changes:
> 
> - added armada-3720-espressobin.dtsi include and updated dts
> - updated model name
> - renamed first partition from 'u-boot' to 'firmware' 
> - disabled usb3 node for the moment as it include usb2 references
> 
> ---
>  arch/arm64/boot/dts/marvell/Makefile          |   1 +
>  .../marvell/armada-3720-espressobin-ultra.dts | 161 ++++++++++++++++++
>  2 files changed, 162 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> 
> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
> index 3e5f2e7a040c..094f451fdd1d 100644
> --- a/arch/arm64/boot/dts/marvell/Makefile
> +++ b/arch/arm64/boot/dts/marvell/Makefile
> @@ -3,6 +3,7 @@
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-emmc.dtb
> +dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-ultra.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-v7.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-v7-emmc.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-turris-mox.dtb
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> new file mode 100644
> index 000000000000..87aaf620a171
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree file for ESPRESSObin-Ultra board.
> + * Copyright (C) 2019 Globalscale technologies, Inc.
> + *
> + * Jason Hung <jhung@globalscaletechnologies.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "armada-3720-espressobin.dtsi"
> +
> +/ {
> +	model = "Globalscale Marvell ESPRESSOBin Ultra Board";
> +	compatible = "globalscale,espressobin-ultra", "marvell,armada3720",
> +		     "marvell,armada3710";
> +

You are missing there aliases section for correct MAC address assignment
from bootloader. See:

https://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git/tree/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi?h=for-next
https://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git/tree/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts?h=for-next

> +	reg_usb3_vbus: usb3-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb3-vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		gpio = <&gpionb 19 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	usb3_phy: usb3-phy {
> +		compatible = "usb-nop-xceiv";
> +		vcc-supply = <&reg_usb3_vbus>;
> +	};
> +
> +	gpio-leds {
> +		pinctrl-names = "default";
> +		compatible = "gpio-leds";
> +		/* No assigned functions to the LEDs by default */
> +		led1 {
> +			label = "ebin-ultra:blue:led1";
> +			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
> +		};
> +		led2 {
> +			label = "ebin-ultra:green:led2";
> +			gpios = <&gpionb 12 GPIO_ACTIVE_LOW>;
> +		};
> +		led3 {
> +			label = "ebin-ultra:red:led3";
> +			gpios = <&gpionb 13 GPIO_ACTIVE_LOW>;
> +		};
> +		led4 {
> +			label = "ebin-ultra:yellow:led4";
> +			gpios = <&gpionb 14 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +&sdhci0 {
> +	status = "okay";
> +	non-removable;
> +	bus-width = <8>;
> +	mmc-ddr-1_8v;
> +	mmc-hs400-1_8v;
> +	marvell,pad-type = "fixed-1-8v";
> +};

This sdhci0 node looks like duplication of what is in include DTS file
armada-3720-espressobin.dtsi. So it is really needed to specify it also
again in armada-3720-espressobin-ultra.dts?

> +
> +&sdhci1 {
> +	status = "disabled";
> +};
> +
> +&spi0 {
> +	flash@0 {
> +		spi-max-frequency = <108000000>;
> +		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <4>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition@0 {
> +				label = "firmware";
> +				reg = <0x0 0x3e0000>;
> +			};
> +			partition@3e0000 {
> +				label = "hw-info";
> +				reg = <0x3e0000 0x10000>;
> +				read-only;
> +			};
> +			partition@3f0000 {
> +				label = "u-boot-env";
> +				reg = <0x3f0000 0x10000>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +
> +	clock-frequency = <100000>;
> +
> +	rtc@51 {
> +		compatible = "nxp,pcf8563";
> +		reg = <0x51>;
> +	};
> +};
> +
> +&usb3 {
> +	usb-phy = <&usb3_phy>;
> +	status = "disabled";
> +};
> +
> +&mdio {
> +	extphy: ethernet-phy@0 {
> +		reg = <1>;
> +	};
> +};
> +
> +&switch0 {
> +	reg = <3>;
> +
> +	ports {
> +		port@1	{
> +			reg = <1>;
> +			label = "lan0";
> +			phy-handle = <&switch0phy0>;
> +		};
> +
> +		port@2 {
> +			reg = <2>;
> +			label = "lan1";
> +			phy-handle = <&switch0phy1>;
> +		};
> +
> +		port@3 {
> +			reg = <3>;
> +			label = "lan2";
> +			phy-handle = <&switch0phy2>;
> +		};
> +
> +		port@4 {
> +			reg = <4>;
> +			label = "lan3";
> +			phy-handle = <&switch0phy3>;
> +		};
> +
> +		port@5 {
> +			reg = <5>;
> +			label = "wan";
> +			phy-handle = <&extphy>;
> +			phy-mode = "sgmii";
> +		};
> +	};
> +
> +	mdio {
> +		switch0phy3: switch0phy3@14 {
> +			reg = <0x14>;
> +		};
> +	};
> +};
> -- 
> 2.27.0
> 
