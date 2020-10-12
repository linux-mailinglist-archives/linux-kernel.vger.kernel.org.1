Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7809C28AECB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgJLHIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 03:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgJLHIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:08:55 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BA8C0613CE;
        Mon, 12 Oct 2020 00:08:53 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so7774359wrv.7;
        Mon, 12 Oct 2020 00:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AMREtvhOn7qqF6QawQfbcnhqs/HiSCSaImA9Duzj7EQ=;
        b=uBDMwOv1m9XLQ2ZdwtF33YLnLz7xzkRQBv2hj66qHUrPk+QbuZty7MzYpCEWwmqCMk
         focDTULEAo8Vs95Yw4EQ9+IzZD9kmjpQ614lMm7J0AvD9jiltOGnc24smYhRbltcUiOD
         /P73fVgZQp2rJhf/wlwY+5Fwckce5Vg2+myw2XG4r9KxTr0OXWo2F6lSmvu2i3v7wbp0
         9lxpYHgO0InL8CgwltFXw4uMs4XQ0tl1+tju1AVSl+L3wYmDphEBmePmSdoC1z8m8ydI
         WREii1IU84xH7j9T/Hz4aio/Ts4tJsUL5g7NrNSa1QsXjSVP7H2/qzZinEO7POVzpHlx
         47ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AMREtvhOn7qqF6QawQfbcnhqs/HiSCSaImA9Duzj7EQ=;
        b=P7gaYUGTb1bEUrzllI4JvKtZgwvUdTCFSkNjCpB587PhzyJn4MzZWpJ+6P13C25gBz
         D1tzoVH6pnbYtq+YMAoB6z7W5BOiR22G5Ct995GbOZ4PBRHHiVLtqVPKwAnaNss81DA2
         s2cPTpfDIY9a9Z7qzTFdQwC1bzXdN0t1h+FSULmkkadehS9faKveH6TQPjFBjTVqOPdU
         /+9znj8c19wIUlRrANxE7/58lVNOFuvoFjLQF7nsw3Bow6AKsdOSTIu6Wr3Shzyj+/V+
         CoNZUvq2k3gIt7JObmcj7MdsUAOqOEzMPquEdsKDR1x5Uf/0R5jdFK+nKmO/Ro/ELDeV
         uO5w==
X-Gm-Message-State: AOAM530JLOaFWNMQjY4O/L/s1sG1mgOf5ucvqyO+RV3Z5M/PpVoiVH+H
        XK6sYQdiTQqBdAuvABco9c4=
X-Google-Smtp-Source: ABdhPJy1Uwk5/bz/w9BZX1Z5tgthbooFufpq6aTkPRhtc4V01ldwtd+Z98xpoRIvubl6ulh4Op43ng==
X-Received: by 2002:adf:ba4f:: with SMTP id t15mr27260706wrg.335.1602486532193;
        Mon, 12 Oct 2020 00:08:52 -0700 (PDT)
Received: from mamamia.internal (a89-183-93-7.net-htp.de. [89.183.93.7])
        by smtp.gmail.com with ESMTPSA id y7sm22519937wmg.40.2020.10.12.00.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 00:08:51 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: marvell: add DT for ESPRESSObin-Ultra
To:     Vladimir Vid <vladimir.vid@sartura.hr>, devicetree@vger.kernel.org
Cc:     tmn505@gmail.com, andrew@lunn.ch, jason@lakedaemon.net,
        gregory.clement@bootlin.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        sebastian.hesselbarth@gmail.com
References: <20201009152710.316047-1-vladimir.vid@sartura.hr>
From:   Andre Heider <a.heider@gmail.com>
Message-ID: <f911338f-17c1-bcbc-0ffd-a8b97de990d4@gmail.com>
Date:   Mon, 12 Oct 2020 09:08:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201009152710.316047-1-vladimir.vid@sartura.hr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

a few comments, all by just comparing this device tree to the other 
espressobin files.

On 09/10/2020 17:27, Vladimir Vid wrote:
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

This one isn't enabled, is it not working?

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
>   arch/arm64/boot/dts/marvell/Makefile          |   1 +
>   .../marvell/armada-3720-espressobin-ultra.dts | 242 ++++++++++++++++++
>   2 files changed, 243 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> 
> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
> index 3e5f2e7a040c..094f451fdd1d 100644
> --- a/arch/arm64/boot/dts/marvell/Makefile
> +++ b/arch/arm64/boot/dts/marvell/Makefile
> @@ -3,6 +3,7 @@
>   dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
>   dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
>   dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-emmc.dtb
> +dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-ultra.dtb
>   dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-v7.dtb
>   dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-v7-emmc.dtb
>   dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-turris-mox.dtb
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

the other espressobin boards use "Globalscale Marvell ESPRESSOBin 
Board", so maybe "Globalscale Marvell ESPRESSOBin Ultra Board"?

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

armada-3720-espressobin.dtsi additionally has:

	pinctrl-names = "default";
	pinctrl-0 = <&pcie_reset_pins &pcie_clkreq_pins>;
	reset-gpios = <&gpiosb 3 GPIO_ACTIVE_LOW>;

is it missing here?

> +};
> +
> +&sata {
> +	status = "okay";

also from armada-3720-espressobin.dtsi, missing?

	phys = <&comphy2 0>;
	phy-names = "sata-phy";

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

again from armada-3720-espressobin.dtsi, maybe use as-is to keep the 
differences to a minimum?

	non-removable;
	bus-width = <8>;
	mmc-ddr-1_8v;
	mmc-hs400-1_8v;
	marvell,xenon-emmc;
	marvell,xenon-tun-count = <9>;
	marvell,pad-type = "fixed-1-8v";

	pinctrl-names = "default";
	pinctrl-0 = <&mmc_pins>;

	#address-cells = <1>;
	#size-cells = <0>;
	mmccard: mmccard@0 {
		compatible = "mmc-card";
		reg = <0>;
	};

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

as Pali mentioned, that's more than just u-boot, the other espressobin 
device trees use "firmware" here.

> +				reg = <0x0 0x3e0000>;
> +			};
> +			partition@3e0000 {
> +				label = "hw-info";

any idea what's in there?

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

That node comes from armada-37xx.dtsi and has:

	phys = <&comphy0 0>, <&usb2_utmi_otg_phy>;
	phy-names = "usb3-phy", "usb2-utmi-otg-phy";

Are those supposed to be mixed?

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

I think that's not required here.

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

armada-3720-espressobin.dtsi has these too:

				phy-mode = "rgmii-id";
				fixed-link {
					speed = <1000>;
					full-duplex;
				};

Which matches with the &eth0 setup from above.

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
> 

