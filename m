Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99B22E772C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 09:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgL3Iqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 03:46:45 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:37257 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgL3Iqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 03:46:45 -0500
Received: by mail-ed1-f42.google.com with SMTP id cm17so14771031edb.4;
        Wed, 30 Dec 2020 00:46:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=atzMrohII3jc6jSiv6yXU1gRhfS8xyJKixK7fWDc8+w=;
        b=l6eHkkeEGZkyZfDLxR/jqIYh43dGsGrPogkYa2oPgZ5cuxv3Q30j7NR1qIq1iEccnl
         ua9qLWnOsGmUw+pmvjusJRLIfRBJm7m1x5msImLfaaMErDhKQTPxCTEWqEhYrn+5aNcX
         SWbQyIsRjPIMAKC2p3cpUbru/tniec5dH6G/u0QSQ3QhSG/klWdPyPyLd4jJImKYJQt8
         Z4WzAplLHolV80tp6DrKSz29ye1Hd+Vyb3WuIo1O4YJho8VfB5KPmFJ1hPcsyCTpTv/m
         ghhQmCe9ASjODPx2EZfyLvWo4dDlZUEZKu4S8+FoFriQ8nRLJuGrhz3z16MriE+96DyQ
         3P+w==
X-Gm-Message-State: AOAM5305YjCi7X2ajFEJ92wLdYU8Gq8LHyFzBQW+rNZ/Qnho1F1S7jkU
        ishUVDBnCVvXv8/zOilIXdU=
X-Google-Smtp-Source: ABdhPJy/FNNNoSUKnve8kn8LjLcNQg9nFv2mTfwWQZLBOssysnz1cuTRwNNYikwW04HSnUgqrZMzOw==
X-Received: by 2002:aa7:ca03:: with SMTP id y3mr50476341eds.87.1609317960958;
        Wed, 30 Dec 2020 00:46:00 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id j7sm19199258ejj.27.2020.12.30.00.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 00:45:59 -0800 (PST)
Date:   Wed, 30 Dec 2020 09:45:58 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] arm64: dts: imx8mm: Add Gateworks i.MX 8M Mini
 Development Kits
Message-ID: <20201230084558.GA9214@kozik-lap>
References: <1609201277-11162-1-git-send-email-tharvey@gateworks.com>
 <1609201277-11162-2-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1609201277-11162-2-git-send-email-tharvey@gateworks.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 04:21:17PM -0800, Tim Harvey wrote:
> The Gateworks Venice GW71xx-0x/GW72xx-0x/GW73xx-0x are development
> kits comprised of a GW700x SoM and a Baseboard. Future SoM's such
> as the GW701x will create additional combinations.
> 
> The GW700x SoM contains:
>  - i.MX 8M Mini SoC
>  - LPDDR4 DRAM
>  - eMMC FLASH
>  - Gateworks System Controller (eeprom/pushbutton/reset/voltage-monitor)
>  - GbE PHY connected to the i.MX 8M Mini FEC
>  - Power Management IC
> 
> The GW71xx Baseboard contains:
>  - 1x MiniPCIe Socket with USB2.0, PCIe, and SIM
>  - 1x RJ45 GbE (i.MX 8M Mini FEC)
>  - I/O connector with 1x-SPI/1x-I2C/1x-UART/4x-GPIO signals
>  - PCIe Clock generator
>  - GPS and accelerometer
>  - 1x USB 2.0 Front Panel connector
>  - wide range power supply
> 
> The GW72xx Baseboard contains:
>  - 2x MiniPCIe Socket with USB2.0, PCIe, and SIM
>  - 2x RJ45 GbE (i.MX 8M Mini FEC and LAN743x)
>  - 1x MicroSD connector
>  - 1x USB 2.0 Front Panel connector
>  - 1x SPI connector
>  - 1x Serial connector supporting 2x-UART or 1x-UART configured as 1 of:
>    RS232 w/ flow-controll, RS485, RS422
>  - PCIe Clock generator
>  - GPS and accelerometer
>  - Media Expansion connector (MIPI-CSI/MIPI-DSI/GPIO/I2S)
>  - I/O connector with 2x-ADC,2x-GPIO,1x-UART,1x-I2C
>  - wide range power supply
> 
> The GW73xx Baseboard contains:
>  - 3x MiniPCIe Socket with USB2.0, PCIe, and SIM
>  - 2x RJ45 GbE (i.MX 8M Mini FEC and LAN743x)
>  - 1x MicroSD connector
>  - 1x USB 2.0 Front Panel connector
>  - 1x SPI connector
>  - 1x Serial connector supporting 2x-UART or 1x-UART configured as 1 of:
>    RS232 w/ flow-controll, RS485, RS422
>  - WiFi/BT
>  - PCIe Clock generator
>  - GPS and accelerometer
>  - Media Expansion connector (MIPI-CSI/MIPI-DSI/GPIO/I2S)
>  - I/O connector with 2x-ADC,2x-GPIO,1x-UART,1x-I2C
>  - wide range power supply
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v3:
>  - fix gpio controller node name
>  - add rtc node to SoM
>  - add pmic pinctrl to SoM
>  - fixed compatible string for SoM eeprom's
> 
> v2:
>  - fix i.MX 8M Mini name in commit log
>  - consistent use of underscore vs hyphen in labels
>  - fix gsc interrupt type
>  - fix iomux group node names
>  - fix led-controller bindings:
>    (use correct node names, color, function and remove label)
>  - use accelerometer node name vs accel
>  - remove sai3 from gw71xx baseboard
>  - added serial connector description to commit message
>  - added I/O connector description to commit message
>  - removed unnecessary #address-cells/#size-cells from gpio-keys node
> ---
>  arch/arm64/boot/dts/freescale/Makefile             |   3 +
>  .../boot/dts/freescale/imx8mm-venice-gw700x.dtsi   | 495 +++++++++++++++++++++
>  .../boot/dts/freescale/imx8mm-venice-gw71xx-0x.dts |  19 +
>  .../boot/dts/freescale/imx8mm-venice-gw71xx.dtsi   | 182 ++++++++
>  .../boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts |  20 +
>  .../boot/dts/freescale/imx8mm-venice-gw72xx.dtsi   | 316 +++++++++++++
>  .../boot/dts/freescale/imx8mm-venice-gw73xx-0x.dts |  19 +
>  .../boot/dts/freescale/imx8mm-venice-gw73xx.dtsi   | 368 +++++++++++++++
>  8 files changed, 1422 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index f8d5943..ecdd233 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -32,6 +32,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw71xx-0x.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-var-som-symphony.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
> new file mode 100644
> index 00000000..bc63525
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
> @@ -0,0 +1,495 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2020 Gateworks Corporation
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/net/ti-dp83867.h>
> +
> +/ {
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000 0 0x80000000>;
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +
> +		user_pb {

I was hoping you will unify it to the proper one (as you already have in
other parts of this patch), so let's be more specific - the node names
use hyphens, not underscores. This applies also to gpio_keys, so
gpio-keys.

> +			label = "user_pb";
> +			gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
> +			linux,code = <BTN_0>;
> +		};
> +
> +		user_pb1x {
> +			label = "user_pb1x";
> +			linux,code = <BTN_1>;
> +			interrupt-parent = <&gsc>;
> +			interrupts = <0>;
> +		};
> +
> +		key_erased {
> +			label = "key_erased";
> +			linux,code = <BTN_2>;
> +			interrupt-parent = <&gsc>;
> +			interrupts = <1>;
> +		};
> +
> +		eeprom_wp {
> +			label = "eeprom_wp";
> +			linux,code = <BTN_3>;
> +			interrupt-parent = <&gsc>;
> +			interrupts = <2>;
> +		};
> +
> +		tamper {
> +			label = "tamper";
> +			linux,code = <BTN_4>;
> +			interrupt-parent = <&gsc>;
> +			interrupts = <5>;
> +		};
> +
> +		switch_hold {
> +			label = "switch_hold";
> +			linux,code = <BTN_5>;
> +			interrupt-parent = <&gsc>;
> +			interrupts = <7>;
> +		};
> +	};
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&buck3_reg>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&buck3_reg>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&buck3_reg>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&buck3_reg>;
> +};
> +
> +&ddrc {
> +	operating-points-v2 = <&ddrc_opp_table>;
> +
> +	ddrc_opp_table: opp-table {
> +		compatible = "operating-points-v2";
> +
> +		opp-25M {
> +			opp-hz = /bits/ 64 <25000000>;
> +		};
> +
> +		opp-100M {
> +			opp-hz = /bits/ 64 <100000000>;
> +		};
> +
> +		opp-750M {
> +			opp-hz = /bits/ 64 <750000000>;
> +		};
> +	};
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec1>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy0>;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +			tx,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +			rx,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	gsc: gsc@20 {
> +		compatible = "gw,gsc";
> +		reg = <0x20>;
> +		pinctrl-0 = <&pinctrl_gsc>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		adc {
> +			compatible = "gw,gsc-adc";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			channel@6 {
> +				gw,mode = <0>;
> +				reg = <0x06>;
> +				label = "temp";
> +			};
> +
> +			channel@8 {
> +				gw,mode = <1>;
> +				reg = <0x08>;
> +				label = "vdd_bat";
> +			};
> +
> +			channel@16 {
> +				gw,mode = <4>;
> +				reg = <0x16>;
> +				label = "fan_tach";
> +			};
> +
> +			channel@82 {
> +				gw,mode = <2>;
> +				reg = <0x82>;
> +				label = "vdd_vin";
> +				gw,voltage-divider-ohms = <22100 1000>;
> +			};
> +
> +			channel@84 {
> +				gw,mode = <2>;
> +				reg = <0x84>;
> +				label = "vdd_adc1";
> +				gw,voltage-divider-ohms = <10000 10000>;
> +			};
> +
> +			channel@86 {
> +				gw,mode = <2>;
> +				reg = <0x86>;
> +				label = "vdd_adc2";
> +				gw,voltage-divider-ohms = <10000 10000>;
> +			};
> +
> +			channel@88 {
> +				gw,mode = <2>;
> +				reg = <0x88>;
> +				label = "vdd_dram";
> +			};
> +
> +			channel@8c {
> +				gw,mode = <2>;
> +				reg = <0x8c>;
> +				label = "vdd_1p2";
> +			};
> +
> +			channel@8e {
> +				gw,mode = <2>;
> +				reg = <0x8e>;
> +				label = "vdd_1p0";
> +			};
> +
> +			channel@90 {
> +				gw,mode = <2>;
> +				reg = <0x90>;
> +				label = "vdd_2p5";
> +				gw,voltage-divider-ohms = <10000 10000>;
> +			};
> +
> +			channel@92 {
> +				gw,mode = <2>;
> +				reg = <0x92>;
> +				label = "vdd_3p3";
> +				gw,voltage-divider-ohms = <10000 10000>;
> +			};
> +
> +			channel@98 {
> +				gw,mode = <2>;
> +				reg = <0x98>;
> +				label = "vdd_0p95";
> +			};
> +
> +			channel@9a {
> +				gw,mode = <2>;
> +				reg = <0x9a>;
> +				label = "vdd_1p8";
> +			};
> +
> +			channel@a2 {
> +				gw,mode = <2>;
> +				reg = <0xa2>;
> +				label = "vdd_gsc";
> +				gw,voltage-divider-ohms = <10000 10000>;
> +			};
> +		};
> +
> +		fan-controller@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "gw,gsc-fan";
> +			reg = <0x0a>;
> +		};
> +	};
> +
> +	gpio: gpio@23 {
> +		compatible = "nxp,pca9555";
> +		reg = <0x23>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-parent = <&gsc>;
> +		interrupts = <4>;
> +	};
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c02";
> +		reg = <0x50>;
> +		pagesize = <16>;
> +	};
> +
> +	eeprom@51 {
> +		compatible = "atmel,24c02";
> +		reg = <0x51>;
> +		pagesize = <16>;
> +	};
> +
> +	eeprom@52 {
> +		compatible = "atmel,24c02";
> +		reg = <0x52>;
> +		pagesize = <16>;
> +	};
> +
> +	eeprom@53 {
> +		compatible = "atmel,24c02";
> +		reg = <0x53>;
> +		pagesize = <16>;
> +	};
> +
> +	rtc@68 {
> +		compatible = "dallas,ds1672";
> +		reg = <0x68>;
> +	};
> +
> +	pmic@69 {
> +		compatible = "mps,mp5416";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		reg = <0x69>;
> +
> +		regulators {
> +			buck1 {
> +				regulator-name = "vdd_0p95";
> +				regulator-min-microvolt = <805000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-max-microamp = <2500000>;
> +				regulator-boot-on;
> +			};
> +
> +			buck2 {
> +				regulator-name = "vdd_soc";
> +				regulator-min-microvolt = <805000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-max-microamp = <1000000>;
> +				regulator-boot-on;
> +			};
> +
> +			buck3_reg: buck3 {
> +				regulator-name = "vdd_arm";
> +				regulator-min-microvolt = <805000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-max-microamp = <2200000>;
> +				regulator-boot-on;
> +			};
> +
> +			buck4 {
> +				regulator-name = "vdd_1p8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-max-microamp = <500000>;
> +				regulator-boot-on;
> +			};
> +
> +			ldo1 {
> +				regulator-name = "nvcc_snvs_1p8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-max-microamp = <300000>;
> +				regulator-boot-on;
> +			};
> +
> +			ldo2 {
> +				regulator-name = "vdd_snvs_0p8";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <800000>;
> +				regulator-boot-on;
> +			};
> +
> +			ldo3 {
> +				regulator-name = "vdd_0p95";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <800000>;
> +				regulator-boot-on;
> +			};
> +
> +			ldo4 {
> +				regulator-name = "vdd_1p8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	eeprom@52 {
> +		compatible = "atmel,24c32";
> +		reg = <0x52>;
> +		pagesize = <32>;
> +	};
> +};
> +
> +&uart2 { /* console */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};
> +
> +&usdhc3 { /* eMMC */
> +	assigned-clocks = <&clk IMX8MM_CLK_USDHC3_ROOT>;
> +	assigned-clock-rates = <400000000>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&wdog1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdog>;
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_fec1: fec1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x3
> +			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3
> +			MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
> +			MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
> +			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
> +			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
> +			MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
> +			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
> +			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
> +			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
> +			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
> +			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
> +			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
> +			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
> +			MX8MM_IOMUXC_NAND_ALE_GPIO3_IO0			0x19
> +		>;
> +	};
> +
> +	pinctrl_gsc: gscgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD1_DATA4_GPIO2_IO6	0x159
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL		0x400001c3
> +			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA		0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
> +			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_pmic: pmicgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x41
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
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK	0x190
> +			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD	0x1d0
> +			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0	0x1d0
> +			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1	0x1d0
> +			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2	0x1d0
> +			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3	0x1d0
> +			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4	0x1d0
> +			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5	0x1d0
> +			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6	0x1d0
> +			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7	0x1d0
> +			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE	0x190
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK	0x194
> +			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD	0x1d4
> +			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0	0x1d4
> +			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1	0x1d4
> +			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2	0x1d4
> +			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3	0x1d4
> +			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4	0x1d4
> +			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5	0x1d4
> +			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6	0x1d4
> +			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7	0x1d4
> +			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE	0x194
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK	0x196
> +			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD	0x1d6
> +			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0	0x1d6
> +			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1	0x1d6
> +			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2	0x1d6
> +			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3	0x1d6
> +			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4	0x1d6
> +			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5	0x1d6
> +			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6	0x1d6
> +			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7	0x1d6
> +			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE	0x196
> +		>;
> +	};
> +
> +	pinctrl_wdog: wdoggrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B	0xc6
> +		>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dts
> new file mode 100644
> index 00000000..3f88c4a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dts
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2020 Gateworks Corporation
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mm.dtsi"
> +#include "imx8mm-venice-gw700x.dtsi"
> +#include "imx8mm-venice-gw71xx.dtsi"
> +
> +/ {
> +	model = "Gateworks Venice GW71xx-0x i.MX8MM Development Kit";
> +	compatible = "gw,imx8mm-gw71xx-0x", "fsl,imx8mm";
> +
> +	chosen {
> +		stdout-path = &uart2;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
> new file mode 100644
> index 00000000..5460c71
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2020 Gateworks Corporation
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	aliases {
> +		usb0 = &usbotg1;
> +		usb1 = &usbotg2;
> +	};
> +
> +	led-controller {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_leds>;
> +
> +		led-0 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&gpio5 5 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led-1 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_RED>;
> +			gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	pps {
> +		compatible = "pps-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pps>;
> +		gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
> +		status = "okay";
> +	};
> +
> +	reg_usb_otg1_vbus: regulator-usb-otg1 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usb1_en>;
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_otg1_vbus";
> +		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +};
> +
> +&ecspi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi2>;
> +	cs-gpios = <&gpio5 13 GPIO_ACTIVE_HIGH>;
> +	status = "okay";

The information about this used on a header should be here, as a
comment. You can leave it in commit msg, but this place is more
important.

> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	accelerometer@19 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_accel>;
> +		compatible = "st,lis2de12";
> +		reg = <0x19>;
> +		st,drdy-int-pin = <1>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "INT1";
> +	};
> +};
> +
> +&i2c3 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";

The same

> +};
> +
> +&uart1 { /* GPS */

Put comment in its own line, e.g. before this.

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&uart3 { /* I/O connector */

The same.

All these comments apply to further files as well.

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	dr_mode = "otg";
> +	vbus-supply = <&reg_usb_otg1_vbus>;
> +	status = "okay";
> +};
> +
> +&usbotg2 {
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	pinctrl_hog: hoggrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SPDIF_TX_GPIO5_IO3		0x40000041 /* PLUG_TEST */
> +			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6	0x40000041 /* PCI_USBSEL */
> +			MX8MM_IOMUXC_SAI1_RXD5_GPIO4_IO7	0x40000041 /* PCIE_WDIS# */
> +			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7	0x40000041 /* DIO0 */
> +			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9	0x40000041 /* DIO1 */
> +			MX8MM_IOMUXC_SAI1_RXD1_GPIO4_IO3	0x40000041 /* DIO2 */
> +			MX8MM_IOMUXC_SAI1_RXD2_GPIO4_IO4	0x40000041 /* DIO2 */
> +		>;
> +	};
> +
> +	pinctrl_accel: accelgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI1_RXD3_GPIO4_IO5	0x159
> +		>;
> +	};
> +
> +	pinctrl_gpio_leds: gpioledgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5	0x19
> +			MX8MM_IOMUXC_SPDIF_RX_GPIO5_IO4		0x19
> +		>;
> +	};
> +
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL		0x400001c3
> +			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_pps: ppsgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x41
> +		>;
> +	};
> +
> +	pinctrl_reg_usb1_en: regusb1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12	0x41
> +			MX8MM_IOMUXC_GPIO1_IO13_USB1_OTG_OC	0x41
> +		>;
> +	};
> +
> +	pinctrl_spi2: spi2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0xd6
> +			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI	0xd6
> +			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0xd6
> +			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13	0xd6
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_UART1_RXD_UART1_DCE_RX	0x140
> +			MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX	0x140
> +		>;
> +	};
> +
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX	0x140
> +			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX	0x140
> +		>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts
> new file mode 100644
> index 00000000..b1e7540
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2020 Gateworks Corporation
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mm.dtsi"
> +#include "imx8mm-venice-gw700x.dtsi"
> +#include "imx8mm-venice-gw72xx.dtsi"
> +
> +/ {
> +	model = "Gateworks Venice GW72xx-0x i.MX8MM Development Kit";
> +	compatible = "gw,imx8mm-gw72xx-0x", "fsl,imx8mm";
> +
> +	chosen {
> +		stdout-path = &uart2;
> +	};
> +};
> +
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
> new file mode 100644
> index 00000000..59811fd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
> @@ -0,0 +1,316 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2020 Gateworks Corporation
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	aliases {
> +		usb0 = &usbotg1;
> +		usb1 = &usbotg2;
> +	};
> +
> +	led-controller {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_leds>;
> +
> +		led-0 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&gpio5 5 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led-1 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_RED>;
> +			gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	pps {
> +		compatible = "pps-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pps>;
> +		gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
> +		status = "okay";
> +	};
> +
> +	reg_3p3v: regulator-3p3v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3P3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_usb_otg1_vbus: regulator-usb-otg1 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usb1_en>;
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_otg1_vbus";
> +		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	reg_usb_otg2_vbus: regulator-usb-otg2 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usb2_en>;
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_otg2_vbus";
> +		gpio = <&gpio1 8 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +};
> +
> +&ecspi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi2>;
> +	cs-gpios = <&gpio5 13 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	accelerometer@19 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_accel>;
> +		compatible = "st,lis2de12";
> +		reg = <0x19>;
> +		st,drdy-int-pin = <1>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "INT1";
> +	};
> +};
> +
> +&i2c3 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +};
> +
> +&sai3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai3>;
> +	assigned-clocks = <&clk IMX8MM_CLK_SAI3>;
> +	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates = <24576000>;
> +	status = "okay";
> +};
> +
> +&uart1 { /* GPS */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&uart2 { /* console */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>,<&pinctrl_uart2_gpio>;

Space after comma.

Best regards,
Krzysztof
