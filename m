Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EF42CC1A2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387534AbgLBQF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:05:56 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:51385 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727132AbgLBQF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:05:56 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 986F45802D9;
        Wed,  2 Dec 2020 11:05:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Dec 2020 11:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=yAIkQ8fKMzM5uO6+aNXKilzzafK
        eIlum6E1669v5tzc=; b=tFLI2VJmTAbpA+JuXPMAdy055/6kgXpt09nS/iUMcAU
        bmKXBFcP/qO+qBpJNPpCBBmwIm/I4jMe3rrr+QNEZL6lkj5mzcWU3zVk5DJFEZzA
        j2yQr7/H4iFN4GnlxbuB1TKArLnNxU/tf9FldFnx18jgRpLcSfoSdKYcsTr/rYCz
        I07XRJ+l3DtIetQym+QYKRPDmeaC+47blAaEwgvV6qCC8sLtqDFCrOdGHS2MyLN3
        YcKCkx1jKHXfVttoDhF4SDpEqovcmgbQd9J6ARtabbyUM/8g9Eoj/8cuOqOSSJDK
        FaBGf7WnX1WMIFEmw8d3jl9T2T59MBJcmacSCrL4ZYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=yAIkQ8
        fKMzM5uO6+aNXKilzzafKeIlum6E1669v5tzc=; b=gAr/wrLCZaqMWxH6Dg1XW8
        rdxDoUuAr4b/7TC6IBhW0fAHX55QcUcn+93uCC7sM5/2874GE90lygQUM7gvlpEB
        Gv48iPqHiwsbufp3BIxs5x2Bw98leYy7KnHNg2cEq6d5uPbIHtlUQh7r/eoh0ze5
        qlfu33gRpqGM3Ck+I6A7aCE8eiCjVQoo7Da2Be78+uXxcCwVRuF/OuS1Dcdc4R/A
        QOu1rorCE7k+7QGyLf5KH/bQl7X3X2EOdiGrkJ79DFf1HxxiLpmQme2o5uNdgg2D
        kn+EF2J44W3yw9p7BQ9eXvDok+Ajxcvrq1nl3WoF4JlR85W/lJNwLlnbnPbbE38g
        ==
X-ME-Sender: <xms:MrvHX1uKsxQ3t13WG3dAbeKbZQoOkeao-Kh_YeRfF4h_g3znVugtLA>
    <xme:MrvHXz_KQt9VOeTYf3cQSlpRI4doK4QNSGxgQsh-hpwinOsrsjIyKHYj7BYacrdPb
    QnLi32Sfc9q9Wg1nIM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeigedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:MrvHXxFOU4cT2cveqGMphAH9K8wq15V3lXEuqyy_LEvHzvnXhNTayQ>
    <xmx:MrvHX6RC_se6aTies_obPe0PFTe6oV5n0l8bX_dAv-zCR4MpixzT3g>
    <xmx:MrvHX3tuSEJkDaSlwA2_EmMNXu7f25KJOja_q00vEqzMK_GBEpeUIQ>
    <xmx:NLvHX0aLBAHxQyHz_jH9CJH0vm9i_DXpscEsTLLtjfIXu6Vg-_ZVOQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3F1691080063;
        Wed,  2 Dec 2020 11:05:06 -0500 (EST)
Date:   Wed, 2 Dec 2020 17:05:04 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 7/8] arm64: dts: allwinner: Add Allwinner H616 .dtsi file
Message-ID: <20201202160504.klxbpqgagra4uxeh@gilmour>
References: <20201202135409.13683-1-andre.przywara@arm.com>
 <20201202135409.13683-8-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3mfoptda66u5dqyw"
Content-Disposition: inline
In-Reply-To: <20201202135409.13683-8-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3mfoptda66u5dqyw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 02, 2020 at 01:54:08PM +0000, Andre Przywara wrote:
> This (relatively) new SoC is similar to the H6, but drops the (broken)
> PCIe support and the USB 3.0 controller. It also gets the management
> controller removed, which in turn removes *some*, but not all of the
> devices formerly dedicated to the ARISC (CPUS).
> There does not seem to be an external interrupt controller anymore, so
> no external interrupts through an NMI pin. The AXP driver needs to learn
> living with that.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 704 ++++++++++++++++++
>  1 file changed, 704 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-h616.dtsi
> new file mode 100644
> index 000000000000..dcffbfdcd26b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> @@ -0,0 +1,704 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// Copyright (C) 2020 Arm Ltd.
> +// based on the H6 dtsi, which is:
> +//   Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/sun50i-h616-ccu.h>
> +#include <dt-bindings/clock/sun50i-h6-r-ccu.h>
> +#include <dt-bindings/reset/sun50i-h616-ccu.h>
> +#include <dt-bindings/reset/sun50i-h6-r-ccu.h>
> +
> +/ {
> +	interrupt-parent =3D <&gic>;
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible =3D "arm,cortex-a53";
> +			device_type =3D "cpu";
> +			reg =3D <0>;
> +			enable-method =3D "psci";
> +			clocks =3D <&ccu CLK_CPUX>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			compatible =3D "arm,cortex-a53";
> +			device_type =3D "cpu";
> +			reg =3D <1>;
> +			enable-method =3D "psci";
> +			clocks =3D <&ccu CLK_CPUX>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			compatible =3D "arm,cortex-a53";
> +			device_type =3D "cpu";
> +			reg =3D <2>;
> +			enable-method =3D "psci";
> +			clocks =3D <&ccu CLK_CPUX>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			compatible =3D "arm,cortex-a53";
> +			device_type =3D "cpu";
> +			reg =3D <3>;
> +			enable-method =3D "psci";
> +			clocks =3D <&ccu CLK_CPUX>;
> +		};
> +	};
> +
> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		/* 512KiB reserved for ARM Trusted Firmware (BL31) */
> +		secmon_reserved: secmon@40000000 {
> +			reg =3D <0x0 0x40000000 0x0 0x80000>;
> +			no-map;
> +		};
> +	};

I'm not sure why that node is there, the previous SoCs didn't have it?
Shouldn't ATF patch it itself?

> +	osc24M: osc24M_clk {
> +		#clock-cells =3D <0>;
> +		compatible =3D "fixed-clock";
> +		clock-frequency =3D <24000000>;
> +		clock-output-names =3D "osc24M";
> +	};
> +
> +	pmu {
> +		compatible =3D "arm,cortex-a53-pmu";
> +		interrupts =3D <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity =3D <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> +	};
> +
> +	psci {
> +		compatible =3D "arm,psci-0.2";
> +		method =3D "smc";
> +	};
> +
> +	timer {
> +		compatible =3D "arm,armv8-timer";
> +		arm,no-tick-in-suspend;

This was tested with crust I assume?

> +		interrupts =3D <GIC_PPI 13
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 14
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 11
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 10
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +	};
> +
> +	soc {
> +		compatible =3D "simple-bus";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges =3D <0x0 0x0 0x0 0x40000000>;
> +
> +		syscon: syscon@3000000 {
> +			compatible =3D "allwinner,sun50i-h616-system-control",

That compatible isn't documented

> +				     "allwinner,sun50i-a64-system-control";
> +			reg =3D <0x03000000 0x1000>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			ranges;
> +
> +			sram_c: sram@28000 {
> +				compatible =3D "mmio-sram";
> +				reg =3D <0x00028000 0x30000>;
> +				#address-cells =3D <1>;
> +				#size-cells =3D <1>;
> +				ranges =3D <0 0x00028000 0x30000>;
> +			};
> +
> +			sram_c1: sram@1a00000 {
> +				compatible =3D "mmio-sram";
> +				reg =3D <0x01a00000 0x200000>;
> +				#address-cells =3D <1>;
> +				#size-cells =3D <1>;
> +				ranges =3D <0 0x01a00000 0x200000>;
> +
> +				ve_sram: sram-section@0 {
> +					compatible =3D "allwinner,sun50i-h616-sram-c1",

Ditto

> +						     "allwinner,sun4i-a10-sram-c1";
> +					reg =3D <0x000000 0x200000>;
> +				};
> +			};
> +		};
> +
> +		ccu: clock@3001000 {
> +			compatible =3D "allwinner,sun50i-h616-ccu";

Ditto

> +			reg =3D <0x03001000 0x1000>;
> +			clocks =3D <&osc24M>, <&rtc 0>, <&rtc 2>;
> +			clock-names =3D "hosc", "losc", "iosc";
> +			#clock-cells =3D <1>;
> +			#reset-cells =3D <1>;
> +		};
> +
> +		watchdog: watchdog@30090a0 {
> +			compatible =3D "allwinner,sun50i-h616-wdt",

Ditto. I guess you can just run checkpatch there, it will let you know
all the ones that aren't documented :)

> +				     "allwinner,sun6i-a31-wdt";
> +			reg =3D <0x030090a0 0x20>;
> +			interrupts =3D <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&osc24M>;
> +			status =3D "disabled";
> +		};
> +
> +		pio: pinctrl@300b000 {
> +			compatible =3D "allwinner,sun50i-h616-pinctrl";
> +			reg =3D <0x0300b000 0x400>;
> +			interrupts =3D <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_APB1>, <&osc24M>, <&rtc 0>;
> +			clock-names =3D "apb", "hosc", "losc";
> +			gpio-controller;
> +			#gpio-cells =3D <3>;
> +			interrupt-controller;
> +			#interrupt-cells =3D <3>;
> +
> +			ext_rgmii_pins: rgmii-pins {
> +				pins =3D "PI0", "PI1", "PI2", "PI3", "PI4",
> +				       "PI5", "PI7", "PI8", "PI9", "PI10",
> +				       "PI11", "PI12", "PI13", "PI14", "PI15",
> +				       "PI16";
> +				function =3D "emac0";
> +				drive-strength =3D <40>;
> +			};
> +
> +			i2c0_pins: i2c0-pins {
> +				pins =3D "PI6", "PI7";
> +				function =3D "i2c0";
> +			};
> +
> +			i2c3_pins_a: i2c1-pins-a {

I guess you meant i2c3 in the node name?

The pin groups with multiple options also are supposed to have the pin
bank instead of the _a or _b suffix, so i2c3_ph_pins=20

> +				pins =3D "PH4", "PH5";
> +				function =3D "i2c3";
> +			};
> +
> +			ir_rx_pin: ir_rx_pin {
> +				pins =3D "PH10";
> +				function =3D "ir_rx";
> +			};
> +
> +			mmc0_pins: mmc0-pins {
> +				pins =3D "PF0", "PF1", "PF2", "PF3",
> +				       "PF4", "PF5";
> +				function =3D "mmc0";
> +				drive-strength =3D <30>;
> +				bias-pull-up;
> +			};
> +
> +			mmc1_pins: mmc1-pins {
> +				pins =3D "PG0", "PG1", "PG2", "PG3",
> +				       "PG4", "PG5";
> +				function =3D "mmc1";
> +				drive-strength =3D <30>;
> +				bias-pull-up;
> +			};
> +
> +			mmc2_pins: mmc2-pins {
> +				pins =3D "PC0", "PC1", "PC5", "PC6",
> +				       "PC8", "PC9", "PC10", "PC11",
> +				       "PC13", "PC14", "PC15", "PC16";
> +				function =3D "mmc2";
> +				drive-strength =3D <30>;
> +				bias-pull-up;
> +			};
> +
> +			spi0_pins: spi0-pins {
> +				pins =3D "PC0", "PC2", "PC3", "PC4";
> +				function =3D "spi0";
> +			};
> +
> +			spi1_pins: spi1-pins {
> +				pins =3D "PH6", "PH7", "PH8";
> +				function =3D "spi1";
> +			};
> +
> +			spi1_cs_pin: spi1-cs-pin {
> +				pins =3D "PH5";
> +				function =3D "spi1";
> +			};
> +
> +			uart0_ph_pins: uart0-ph-pins {
> +				pins =3D "PH0", "PH1";
> +				function =3D "uart0";
> +			};
> +
> +			uart1_pins: uart1-pins {
> +				pins =3D "PG6", "PG7";
> +				function =3D "uart1";
> +			};
> +
> +			uart1_rts_cts_pins: uart1-rts-cts-pins {
> +				pins =3D "PG8", "PG9";
> +				function =3D "uart1";
> +			};
> +		};
> +
> +		gic: interrupt-controller@3021000 {
> +			compatible =3D "arm,gic-400";
> +			reg =3D <0x03021000 0x1000>,
> +			      <0x03022000 0x2000>,
> +			      <0x03024000 0x2000>,
> +			      <0x03026000 0x2000>;
> +			interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HI=
GH)>;
> +			interrupt-controller;
> +			#interrupt-cells =3D <3>;
> +		};
> +
> +		mmc0: mmc@4020000 {
> +			compatible =3D "allwinner,sun50i-h616-mmc",
> +				     "allwinner,sun50i-a100-mmc";
> +			reg =3D <0x04020000 0x1000>;
> +			clocks =3D <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
> +			clock-names =3D "ahb", "mmc";
> +			resets =3D <&ccu RST_BUS_MMC0>;
> +			reset-names =3D "ahb";
> +			interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&mmc0_pins>;
> +			status =3D "disabled";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		mmc1: mmc@4021000 {
> +			compatible =3D "allwinner,sun50i-h616-mmc",
> +				     "allwinner,sun50i-a100-mmc";
> +			reg =3D <0x04021000 0x1000>;
> +			clocks =3D <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
> +			clock-names =3D "ahb", "mmc";
> +			resets =3D <&ccu RST_BUS_MMC1>;
> +			reset-names =3D "ahb";
> +			interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&mmc1_pins>;
> +			status =3D "disabled";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		mmc2: mmc@4022000 {
> +			compatible =3D "allwinner,sun50i-h616-emmc",
> +				     "allwinner,sun50i-a64-emmc";
> +			reg =3D <0x04022000 0x1000>;
> +			clocks =3D <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;
> +			clock-names =3D "ahb", "mmc";
> +			resets =3D <&ccu RST_BUS_MMC2>;
> +			reset-names =3D "ahb";
> +			interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&mmc2_pins>;
> +			status =3D "disabled";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		uart0: serial@5000000 {
> +			compatible =3D "snps,dw-apb-uart";
> +			reg =3D <0x05000000 0x400>;
> +			interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			clocks =3D <&ccu CLK_BUS_UART0>;
> +			resets =3D <&ccu RST_BUS_UART0>;
> +			status =3D "disabled";
> +		};
> +
> +		uart1: serial@5000400 {
> +			compatible =3D "snps,dw-apb-uart";
> +			reg =3D <0x05000400 0x400>;
> +			interrupts =3D <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			clocks =3D <&ccu CLK_BUS_UART1>;
> +			resets =3D <&ccu RST_BUS_UART1>;
> +			status =3D "disabled";
> +		};
> +
> +		uart2: serial@5000800 {
> +			compatible =3D "snps,dw-apb-uart";
> +			reg =3D <0x05000800 0x400>;
> +			interrupts =3D <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			clocks =3D <&ccu CLK_BUS_UART2>;
> +			resets =3D <&ccu RST_BUS_UART2>;
> +			status =3D "disabled";
> +		};
> +
> +		uart3: serial@5000c00 {
> +			compatible =3D "snps,dw-apb-uart";
> +			reg =3D <0x05000c00 0x400>;
> +			interrupts =3D <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			clocks =3D <&ccu CLK_BUS_UART3>;
> +			resets =3D <&ccu RST_BUS_UART3>;
> +			status =3D "disabled";
> +		};
> +
> +		uart4: serial@5001000 {
> +			compatible =3D "snps,dw-apb-uart";
> +			reg =3D <0x05001000 0x400>;
> +			interrupts =3D <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			clocks =3D <&ccu CLK_BUS_UART4>;
> +			resets =3D <&ccu RST_BUS_UART4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart5: serial@5001400 {
> +			compatible =3D "snps,dw-apb-uart";
> +			reg =3D <0x05001400 0x400>;
> +			interrupts =3D <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			clocks =3D <&ccu CLK_BUS_UART5>;
> +			resets =3D <&ccu RST_BUS_UART5>;
> +			status =3D "disabled";
> +		};
> +
> +		i2c0: i2c@5002000 {
> +			compatible =3D "allwinner,sun50i-h616-i2c",
> +				     "allwinner,sun6i-a31-i2c";
> +			reg =3D <0x05002000 0x400>;
> +			interrupts =3D <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_I2C0>;
> +			resets =3D <&ccu RST_BUS_I2C0>;
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&i2c0_pins>;
> +			status =3D "disabled";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		i2c1: i2c@5002400 {
> +			compatible =3D "allwinner,sun50i-h616-i2c",
> +				     "allwinner,sun6i-a31-i2c";
> +			reg =3D <0x05002400 0x400>;
> +			interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_I2C1>;
> +			resets =3D <&ccu RST_BUS_I2C1>;
> +			status =3D "disabled";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		i2c2: i2c@5002800 {
> +			compatible =3D "allwinner,sun50i-h616-i2c",
> +				     "allwinner,sun6i-a31-i2c";
> +			reg =3D <0x05002800 0x400>;
> +			interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_I2C2>;
> +			resets =3D <&ccu RST_BUS_I2C2>;
> +			status =3D "disabled";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		i2c3: i2c@5002c00 {
> +			compatible =3D "allwinner,sun50i-h616-i2c",
> +				     "allwinner,sun6i-a31-i2c";
> +			reg =3D <0x05002c00 0x400>;
> +			interrupts =3D <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_I2C3>;
> +			resets =3D <&ccu RST_BUS_I2C3>;
> +			status =3D "disabled";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		i2c4: i2c@5003000 {
> +			compatible =3D "allwinner,sun50i-h616-i2c",
> +				     "allwinner,sun6i-a31-i2c";
> +			reg =3D <0x05003000 0x400>;
> +			interrupts =3D <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_I2C4>;
> +			resets =3D <&ccu RST_BUS_I2C4>;
> +			status =3D "disabled";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		spi0: spi@5010000 {
> +			compatible =3D "allwinner,sun50i-h616-spi",
> +				     "allwinner,sun8i-h3-spi";
> +			reg =3D <0x05010000 0x1000>;
> +			interrupts =3D <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
> +			clock-names =3D "ahb", "mod";
> +			resets =3D <&ccu RST_BUS_SPI0>;
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&spi0_pins>;
> +			status =3D "disabled";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		spi1: spi@5011000 {
> +			compatible =3D "allwinner,sun50i-h616-spi",
> +				     "allwinner,sun8i-h3-spi";
> +			reg =3D <0x05011000 0x1000>;
> +			interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
> +			clock-names =3D "ahb", "mod";
> +			resets =3D <&ccu RST_BUS_SPI1>;
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&spi1_pins>;
> +			status =3D "disabled";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		emac0: ethernet@5020000 {
> +			compatible =3D "allwinner,sun50i-h616-emac",
> +				     "allwinner,sun50i-a64-emac";
> +			syscon =3D <&syscon>;
> +			reg =3D <0x05020000 0x10000>;
> +			interrupts =3D <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names =3D "macirq";
> +			resets =3D <&ccu RST_BUS_EMAC0>;
> +			reset-names =3D "stmmaceth";
> +			clocks =3D <&ccu CLK_BUS_EMAC0>;
> +			clock-names =3D "stmmaceth";
> +			status =3D "disabled";
> +
> +			mdio: mdio {
> +				compatible =3D "snps,dwmac-mdio";
> +				#address-cells =3D <1>;
> +				#size-cells =3D <0>;
> +			};
> +		};
> +
> +		usbotg: usb@5100000 {
> +			compatible =3D "allwinner,sun50i-h616-musb",
> +				     "allwinner,sun8i-a33-musb";
> +			reg =3D <0x05100000 0x0400>;
> +			clocks =3D <&ccu CLK_BUS_OTG>;
> +			resets =3D <&ccu RST_BUS_OTG>;
> +			interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names =3D "mc";
> +			phys =3D <&usbphy 0>;
> +			phy-names =3D "usb";
> +			extcon =3D <&usbphy 0>;
> +			status =3D "disabled";
> +		};
> +
> +		usbphy: phy@5100400 {
> +			compatible =3D "allwinner,sun50i-h616-usb-phy";
> +			reg =3D <0x05100400 0x24>,
> +			      <0x05101800 0x4>,
> +			      <0x05200800 0x4>,
> +			      <0x05310800 0x4>,
> +			      <0x05311800 0x4>;
> +			reg-names =3D "phy_ctrl",
> +				    "pmu0",
> +				    "pmu1",
> +				    "pmu2",
> +				    "pmu3";
> +			clocks =3D <&ccu CLK_USB_PHY0>,
> +				 <&ccu CLK_USB_PHY1>,
> +				 <&ccu CLK_USB_PHY2>,
> +				 <&ccu CLK_USB_PHY3>;
> +			clock-names =3D "usb0_phy",
> +				      "usb1_phy",
> +				      "usb2_phy",
> +				      "usb3_phy";
> +			resets =3D <&ccu RST_USB_PHY0>,
> +				 <&ccu RST_USB_PHY1>,
> +				 <&ccu RST_USB_PHY2>,
> +				 <&ccu RST_USB_PHY3>;
> +			reset-names =3D "usb0_reset",
> +				      "usb1_reset",
> +				      "usb2_reset",
> +				      "usb3_reset";
> +			status =3D "disabled";
> +			#phy-cells =3D <1>;
> +		};

Did you send a patch to support that PHY?

Maxime

--3mfoptda66u5dqyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX8e7MAAKCRDj7w1vZxhR
xbA0APwKuWyX5IzL0i/DExNoyYXOgPB6lgUDp8vd9HpgmMtrRAEA+xk9fjHV1jf6
DP8rG8c3F3vF/flKB2mU+i0LIel7zQ8=
=9zCo
-----END PGP SIGNATURE-----

--3mfoptda66u5dqyw--
