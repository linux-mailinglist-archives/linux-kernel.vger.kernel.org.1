Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1892F079F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 15:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbhAJOqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 09:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbhAJOqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 09:46:17 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A09C061786;
        Sun, 10 Jan 2021 06:45:37 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id jx16so21029920ejb.10;
        Sun, 10 Jan 2021 06:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L+Gdu/utba1vSl0cJlmcxNBkTf8PrmI66g75m/WxT2E=;
        b=nkcazefaF1noHekoXeNl6YBpxKhsCTQvdhEU6W4iAdTPhI9PC+wiUHoQyMlG4rttrA
         Nfzavs4wnsEzJMUOJa+y2GGIAvMah5RFK1V3qbdirVuDF5NxpUaP3iUktU3w6zRF1xmE
         BroyisKCsCdfSBdthfq1HXqTp121B2w2SeopMOgF6zi9joiFwjRcJElqscLWjkxEh3vH
         9Et6PE3yvKwDTGPY4d0kW7BmRNUkVnG7hhapn1kE7GK9/014rpF4xPj/RuA08jQXCdhK
         f8nalNRyukeHDhdlrSRG04DmboPMY1NnFMnknssSUm2B26qQ97O15WAkPEfyUS3dIB2w
         S7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L+Gdu/utba1vSl0cJlmcxNBkTf8PrmI66g75m/WxT2E=;
        b=dO/MTqNKIWYI6LqZ1oAcieVXYW47yPXIr9hYknWVt04LfM3Lx/iKOaNF8s8RnIljZp
         YtlhGfvcZ57WXqwkowGxlXkRj929dCC4UMuG5L/aYPPqfTQI682ZddUqZLLr68sBdQFR
         ndPrXixwJ3IHXpCq5zw+02/R3pSsZNR/cy08aXwLqo1TOOJAJ31ztRlGDiKej0ohgOjw
         PINo4yHbkXx9H0xOy0viiLi0sod0BD7hfCJFw7sVFYni/lIRJoP+Fypi8YRclbgMC2w6
         pGG9PLaVMhk9yDyTSrZI6CAlrscqH8H+h1hdcaD9aM9dKC983Pd9QmxYhua501udNrM/
         JsUA==
X-Gm-Message-State: AOAM530lwT5Vue1FcBw1xGVWitRG+1pzXU5ERlHlg2W2QLIvreRXs9Ny
        y1V441aAWBCaDbrOZRSCtQj+8ttuR3uPFA==
X-Google-Smtp-Source: ABdhPJz+7gURiFOClRuxypxUcthB0fs7bYmcKDVZ2exbG/R+JlRMr7DQ7R6Qn+D2E6YSzT3awPL8gw==
X-Received: by 2002:a17:906:e093:: with SMTP id gh19mr8245258ejb.510.1610289935664;
        Sun, 10 Jan 2021 06:45:35 -0800 (PST)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k18sm6371787edx.18.2021.01.10.06.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jan 2021 06:45:35 -0800 (PST)
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: rk3328: Add Radxa ROCK Pi E
To:     Chen-Yu Tsai <wens@kernel.org>, Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
References: <20210110035846.9155-1-wens@kernel.org>
 <20210110035846.9155-4-wens@kernel.org>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <381648f9-d650-dddf-59e6-ef32d1e1bb43@gmail.com>
Date:   Sun, 10 Jan 2021 15:45:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210110035846.9155-4-wens@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

Some comments, have a look if it is useful...

On 1/10/21 4:58 AM, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Radxa ROCK Pi E is a router oriented SBC based on Rockchip's RK3328 SoC.
> As the official wiki page puts it, "E for Ethernets".
> 
> It features the RK3328 SoC, gigabit and fast Ethernet RJ45 ports, both
> directly served by Ethernet controllers in the SoC, a USB 3.0 host port,
> a power-only USB type-C port, a 3.5mm headphone jack for audio output,

> two LEDs, a 40-pin Raspberry Pi style GPIO header, and optional WiFi+BT
> and PoE header.
> 
> The board comes in multiple configurations, differing in the amount of
> onboard RAM, the level of WiFi+BT (none, 802.11n 2.4GHz, or 802.11ac
> 2.4 GHz & 5 GHz), and whether PoE is supported or not. These variants
> can all share the same device tree.
> 
> The USB 2.0 OTG controller is available on the 40-pin header. This is
> not enabled in the device tree, since it is possible to use it in a
> host-only configuration, or in OTG mode with an extra pin from the
> header as the ID pin.
> 
> The device tree is based on the one of the Rock64, with various parts
> modified to match the ROCK Pi E, and some parts updated to newer styles,
> such as the gmac2io node's mdio sub-node.
> 
> Add a new device tree file for the new board.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3328-rock-pi-e.dts    | 369 ++++++++++++++++++
>  2 files changed, 370 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 622d320ddd13..62d3abc17a24 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -11,6 +11,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-a1.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2s.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-rock64.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-rock-pi-e.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-roc-cc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-evb-act8846.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-geekbox.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
> new file mode 100644
> index 000000000000..7818d2e8180c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
> @@ -0,0 +1,369 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * (C) Copyright 2020 Chen-Yu Tsai <wens@csie.org>
> + *
> + * Based on ./rk3328-rock64.dts, which is
> + *
> + * Copyright (c) 2017 PINE64
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include "rk3328.dtsi"
> +
> +/ {
> +	model = "Radxa ROCK Pi E";
> +	compatible = "radxa,rockpi-e", "rockchip,rk3328";
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	gmac_clkin: external-gmac-clock {
> +		compatible = "fixed-clock";
> +		clock-frequency = <125000000>;
> +		clock-output-names = "gmac_clkin";
> +		#clock-cells = <0>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&led_pin>;
> +		pinctrl-names = "default";
> +
> +		led-0 {

> +			/* schematic say green but the actual thing is blue */

In rockpie-v1.2-20200427-sch.pdf this led is already called "LED_BLUE",
so comment maybe not needed anymore?

> +			color = <LED_COLOR_ID_BLUE>;
> +			gpios = <&gpio3 RK_PA5 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +		};> +	};
> +
> +	vcc_sd: sdmmc-regulator {
> +		compatible = "regulator-fixed";
> +		gpio = <&gpio0 RK_PD6 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sdmmc0m1_pin>;

> +		regulator-boot-on;
> +		regulator-name = "vcc_sd";

regulator-name above other regulator properties

regulator voltage missing
make things as complete as possible

from fixed-regulator.yaml:

description:
  Any property defined as part of the core regulator binding, defined in
  regulator.yaml, can also be used. However a fixed voltage regulator is
  expected to have the regulator-min-microvolt and regulator-max-microvolt
  to be the same.

> +		vin-supply = <&vcc_io>;
> +	};
> +

> +	vcc_host_5v: vcc-host-5v-regulator {
> +		compatible = "regulator-fixed";
> +		gpio = <&gpio3 RK_PA7 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb30_host_drv>;
> +		enable-active-high;
> +		regulator-name = "vcc_host_5v";

idem limits

> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc_sys>;
> +	};

For Heiko: ?? remove ??
usb3 has no support in mainline.
Regulators not in use are disabled.
For mainline this node has no use....

> +
> +	vcc_sys: vcc-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_sys";

> +		regulator-always-on;
> +		regulator-boot-on;

At the other regulators this is sort below the regulator limits.

> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	vcc_wifi: vcc-wifi-regulator {
> +		compatible = "regulator-fixed";
> +		gpio = <&gpio0 RK_PA0 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_en>;
> +		regulator-name = "vcc_wifi";

idem limits

> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc_io>;
> +	};
> +};
> +
> +&analog_sound {
> +	status = "okay";
> +};
> +
> +&codec {
> +	status = "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu2 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu3 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&emmc {
> +	bus-width = <8>;
> +	cap-mmc-highspeed;

> +	max-frequency = <150000000>;

remove
already defined in dtsi

> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_clk>, <&emmc_cmd>, <&emmc_bus8>;
> +	vmmc-supply = <&vcc_io>;
> +	vqmmc-supply = <&vcc18_emmc>;
> +	status = "okay";
> +};

////////////////////////
	emmc: mmc@ff520000 {
		compatible = "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc";
		reg = <0x0 0xff520000 0x0 0x4000>;
		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
		fifo-depth = <0x100>;
		max-frequency = <150000000>;
		status = "disabled";
	};
////////////////////////

> +
> +&gmac2io {
> +	assigned-clocks = <&cru SCLK_MAC2IO>, <&cru SCLK_MAC2IO_EXT>;
> +	assigned-clock-parents = <&gmac_clkin>, <&gmac_clkin>;
> +	clock_in_out = "input";
> +	phy-handle = <&rtl8211e>;
> +	phy-mode = "rgmii";
> +	phy-supply = <&vcc_io>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmiim1_pins>;
> +	snps,aal;
> +	snps,rxpbl = <0x4>;
> +	snps,txpbl = <0x4>;
> +	tx_delay = <0x26>;
> +	rx_delay = <0x11>;
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		rtl8211e: ethernet-phy@1 {
> +			reg = <1>;
> +			pinctrl-0 = <&eth_phy_int_pin>, <&eth_phy_reset_pin>;
> +			pinctrl-names = "default";
> +			interrupt-parent = <&gpio1>;
> +			interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
> +			reset-assert-us = <10000>;
> +			reset-deassert-us = <50000>;
> +			reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +&gmac2phy {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&fephyled_linkm1>, <&fephyled_rxm1>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +
> +	rk805: pmic@18 {
> +		compatible = "rockchip,rk805";
> +		reg = <0x18>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;

> +		#clock-cells = <1>;

all thing that start with "#" down the list

> +		clock-output-names = "xin32k", "rk805-clkout2";
> +		gpio-controller;

> +		#gpio-cells = <2>;

idem

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_int_l>;
> +		rockchip,system-power-controller;
> +		wakeup-source;
> +
> +		vcc1-supply = <&vcc_sys>;
> +		vcc2-supply = <&vcc_sys>;
> +		vcc3-supply = <&vcc_sys>;
> +		vcc4-supply = <&vcc_sys>;
> +		vcc5-supply = <&vcc_io>;
> +		vcc6-supply = <&vcc_sys>;
> +
> +		regulators {
> +			vdd_log: DCDC_REG1 {
> +				regulator-name = "vdd_log";
> +				regulator-min-microvolt = <712500>;
> +				regulator-max-microvolt = <1450000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1000000>;
> +				};
> +			};
> +
> +			vdd_arm: DCDC_REG2 {
> +				regulator-name = "vdd_arm";
> +				regulator-min-microvolt = <712500>;
> +				regulator-max-microvolt = <1450000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <950000>;
> +				};
> +			};
> +
> +			vcc_ddr: DCDC_REG3 {
> +				regulator-name = "vcc_ddr";
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcc_io: DCDC_REG4 {
> +				regulator-name = "vcc_io";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vcc_18: LDO_REG1 {
> +				regulator-name = "vcc_18";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vcc18_emmc: LDO_REG2 {
> +				regulator-name = "vcc18_emmc";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vdd_10: LDO_REG3 {
> +				regulator-name = "vdd_10";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1000000>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2s1 {
> +	status = "okay";
> +};
> +
> +&io_domains {
> +	pmuio-supply = <&vcc_io>;
> +	vccio1-supply = <&vcc_io>;
> +	vccio2-supply = <&vcc18_emmc>;
> +	vccio3-supply = <&vcc_io>;
> +	vccio4-supply = <&vcc_io>;
> +	vccio5-supply = <&vcc_io>;
> +	vccio6-supply = <&vcc_io>;
> +	status = "okay";
> +};
> +
> +&pinctrl {

> +	ethernet-phy {

gmac2io

phy / ethernet-phy is a reserved node name
use something else

make ARCH=arm64 dtbs_check

/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dt.yaml: ethernet-phy:
'reg' is a required property
	From schema: Documentation/devicetree/bindings/net/ethernet-phy.yaml


> +		eth_phy_int_pin: eth-phy-int-pin {
> +			rockchip,pins = <1 RK_PD0 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +
> +		eth_phy_reset_pin: eth-phy-reset-pin {
> +			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +	};
> +
> +	leds {
> +		led_pin: led-pin {
> +			rockchip,pins = <3 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pmic {
> +		pmic_int_l: pmic-int-l {
> +			rockchip,pins = <2 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +

> +	usb3 {

usb

Last numbers in nodenames are more related to the sort order then to
capabillity.
ie: mmc0, mmc1
All usb pin related things here.

> +		usb30_host_drv: usb30-host-drv {
> +			rockchip,pins = <3 RK_PA7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	wifi {
> +		wifi_en: wifi-en {
> +			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&sdmmc {
> +	bus-width = <4>;

> +	cap-mmc-highspeed;

remove
micro SD only

> +	cap-sd-highspeed;
> +	disable-wp;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc0_clk>, <&sdmmc0_cmd>, <&sdmmc0_dectn>, <&sdmmc0_bus4>;
> +	vmmc-supply = <&vcc_sd>;
> +	status = "okay";
> +};
> +

> +&saradc {
> +	vref-supply = <&vcc_18>;
> +	status = "okay";
> +};

What happened to the recovery key from the schematic?

> +
> +&tsadc {
> +	status = "okay";
> +};
> +
> +&u2phy {
> +	status = "okay";
> +};
> +
> +&u2phy_host {
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&usb_host0_ehci {
> +	status = "okay";
> +};
> 

