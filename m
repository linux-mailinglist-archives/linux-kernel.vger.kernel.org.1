Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA23288CEC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 17:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389275AbgJIPh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 11:37:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388473AbgJIPh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:37:56 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 827F522251;
        Fri,  9 Oct 2020 15:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602257875;
        bh=tK9gzBuNPbzcDcd6oEtAuD+BlU4Yqk+5F+n7gbDPk/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X7hRdBiZltvlio2KU0lytUAoHGU1vibZEzJXrsHiKX8ZLDncrr0QoGDoUOPnjgWbJ
         MzJtVoIjEtDVsrSAspDcIcZ0gG/VE7U0BzdNR3MICKcfE9vpBgwVv/Jh2EHBQ4jEl7
         qRun77tenwuffBQ62z0nVsyFAI0/6I719aZM3p8g=
Received: by pali.im (Postfix)
        id 519D2515; Fri,  9 Oct 2020 17:37:53 +0200 (CEST)
Date:   Fri, 9 Oct 2020 17:37:53 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Vladimir Vid <vladimir.vid@sartura.hr>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tmn505@gmail.com,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        andrew@lunn.ch, jason@lakedaemon.net, robh+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: add DT for ESPRESSObin-Ultra
Message-ID: <20201009153753.mpf6vr6ih2il6zhb@pali>
References: <20201009152710.316047-1-vladimir.vid@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009152710.316047-1-vladimir.vid@sartura.hr>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Friday 09 October 2020 17:27:10 Vladimir Vid wrote:
> This adds support for ESPRESSObin-Ultra from Globalscale.
> 
> Specifications are similar to the base ESPRESSObin board, with main
> difference being being WAN port with PoE capability and 2 additional ethernet ports.

Cannot you in this case include armada-3720-espressobin.dtsi and write
only differences into DTS ultra file to reduce definitions?

Currently there are pending patches for espressobin DTS files to
simplify them and use common include file as much as possible to
de-duplicate same parts.

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
>  arch/arm64/boot/dts/marvell/Makefile          |   1 +
>  .../marvell/armada-3720-espressobin-ultra.dts | 242 ++++++++++++++++++
>  2 files changed, 243 insertions(+)
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
> index 000000000000..25d10b628e77
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> @@ -0,0 +1,242 @@
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
> +#include <dt-bindings/gpio/gpio.h>
> +#include "armada-372x.dtsi"
> +
> +/ {
> +	model = "Marvell Armada 3720 ESPRESSOBin-Ultra";
> +	compatible = "globalscale,espressobin-ultra", "marvell,armada3720",
> +		     "marvell,armada3710";
> +
> +	aliases {
> +		ethernet0 = &eth0;
> +		/* for dsa slave device */
> +		ethernet1 = &switch0port1;
> +		ethernet2 = &switch0port2;
> +		ethernet3 = &switch0port3;
> +		ethernet4 = &switch0port4;
> +		ethernet5 = &switch0port5;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
> +	};
> +
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
> +&pcie0 {
> +	status = "okay";
> +};
> +
> +&sata {
> +	status = "okay";
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
> +
> +&spi0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi_quad_pins>;
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <108000000>;
> +		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <4>;
> +		m25p,fast-read;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition@0 {
> +				label = "u-boot";

Looks like this is incorrect as on Armada 3720 at the beginning of the
nor must be stored Marvell wtmi/secure firmware which is running on
Cortex M3 processor. For sure there cannot be u-boot. Also on A3720 is
u-boot loaded by ARM trusted firmware therefore I doubt that u-boot is
stored at offset zero.

I guess that on offset zero is stored concatenated binary of Marvell
secure firmware for M3, ARM trusted firmware (for main CPU) and U-Boot.
Can you verify it? In this case I would just call this partition as
"firmware" to indicate what is stored here.

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
> +&uart0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_pins>;
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
> +	status = "okay";
> +	usb-phy = <&usb3_phy>;
> +};
> +
> +&usb2 {
> +	status = "okay";
> +};
> +
> +&eth0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmii_pins>;
> +	phy-mode = "rgmii-id";
> +
> +	fixed-link {
> +		speed = <1000>;
> +		full-duplex;
> +	};
> +};
> +
> +&mdio {
> +	status = "okay";
> +
> +	extphy: ethernet-phy@0 {
> +		reg = <1>;
> +	};
> +
> +	switch0: switch0@1 {
> +		compatible = "marvell,mv88e6085";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <3>;
> +
> +		dsa,member = <0 0>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			switch0port0: port@0 {
> +				reg = <0>;
> +				label = "cpu";
> +				ethernet = <&eth0>;
> +			};
> +
> +			switch0port1: port@1 {
> +				reg = <1>;
> +				label = "lan0";
> +				phy-handle = <&switch0phy1>;
> +			};
> +
> +			switch0port2: port@2 {
> +				reg = <2>;
> +				label = "lan1";
> +				phy-handle = <&switch0phy2>;
> +			};
> +
> +			switch0port3: port@3 {
> +				reg = <3>;
> +				label = "lan2";
> +				phy-handle = <&switch0phy3>;
> +			};
> +
> +			switch0port4: port@4 {
> +				reg = <4>;
> +				label = "lan3";
> +				phy-handle = <&switch0phy4>;
> +			};
> +
> +			switch0port5: port@5 {
> +				reg = <5>;
> +				label = "wan";
> +				phy-handle = <&extphy>;
> +				phy-mode = "sgmii";
> +			};
> +		};
> +
> +		mdio {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			switch0phy1: switch0phy1@11 {
> +				reg = <0x11>;
> +			};
> +			switch0phy2: switch0phy2@12 {
> +				reg = <0x12>;
> +			};
> +			switch0phy3: switch0phy3@13 {
> +				reg = <0x13>;
> +			};
> +			switch0phy4: switch0phy4@14 {
> +				reg = <0x14>;
> +			};
> +		};
> +	};
> +};
> -- 
> 2.27.0
> 
