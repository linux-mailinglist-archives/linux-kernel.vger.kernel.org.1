Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4426C2CC217
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbgLBQVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:21:09 -0500
Received: from foss.arm.com ([217.140.110.172]:44302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730628AbgLBQVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:21:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7297F1063;
        Wed,  2 Dec 2020 08:20:21 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B03973F718;
        Wed,  2 Dec 2020 08:20:19 -0800 (PST)
Subject: Re: [PATCH 7/8] arm64: dts: allwinner: Add Allwinner H616 .dtsi file
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
 <20201202135409.13683-8-andre.przywara@arm.com>
 <3e5e78cbfc9149cdc630511970af0e52e8ebdfb2.camel@aosc.io>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 xsFNBFNPCKMBEAC+6GVcuP9ri8r+gg2fHZDedOmFRZPtcrMMF2Cx6KrTUT0YEISsqPoJTKld
 tPfEG0KnRL9CWvftyHseWTnU2Gi7hKNwhRkC0oBL5Er2hhNpoi8x4VcsxQ6bHG5/dA7ctvL6
 kYvKAZw4X2Y3GTbAZIOLf+leNPiF9175S8pvqMPi0qu67RWZD5H/uT/TfLpvmmOlRzNiXMBm
 kGvewkBpL3R2clHquv7pB6KLoY3uvjFhZfEedqSqTwBVu/JVZZO7tvYCJPfyY5JG9+BjPmr+
 REe2gS6w/4DJ4D8oMWKoY3r6ZpHx3YS2hWZFUYiCYovPxfj5+bOr78sg3JleEd0OB0yYtzTT
 esiNlQpCo0oOevwHR+jUiaZevM4xCyt23L2G+euzdRsUZcK/M6qYf41Dy6Afqa+PxgMEiDto
 ITEH3Dv+zfzwdeqCuNU0VOGrQZs/vrKOUmU/QDlYL7G8OIg5Ekheq4N+Ay+3EYCROXkstQnf
 YYxRn5F1oeVeqoh1LgGH7YN9H9LeIajwBD8OgiZDVsmb67DdF6EQtklH0ycBcVodG1zTCfqM
 AavYMfhldNMBg4vaLh0cJ/3ZXZNIyDlV372GmxSJJiidxDm7E1PkgdfCnHk+pD8YeITmSNyb
 7qeU08Hqqh4ui8SSeUp7+yie9zBhJB5vVBJoO5D0MikZAODIDwARAQABzS1BbmRyZSBQcnp5
 d2FyYSAoQVJNKSA8YW5kcmUucHJ6eXdhcmFAYXJtLmNvbT7CwXsEEwECACUCGwMGCwkIBwMC
 BhUIAgkKCwQWAgMBAh4BAheABQJTWSV8AhkBAAoJEAL1yD+ydue63REP/1tPqTo/f6StS00g
 NTUpjgVqxgsPWYWwSLkgkaUZn2z9Edv86BLpqTY8OBQZ19EUwfNehcnvR+Olw+7wxNnatyxo
 D2FG0paTia1SjxaJ8Nx3e85jy6l7N2AQrTCFCtFN9lp8Pc0LVBpSbjmP+Peh5Mi7gtCBNkpz
 KShEaJE25a/+rnIrIXzJHrsbC2GwcssAF3bd03iU41J1gMTalB6HCtQUwgqSsbG8MsR/IwHW
 XruOnVp0GQRJwlw07e9T3PKTLj3LWsAPe0LHm5W1Q+euoCLsZfYwr7phQ19HAxSCu8hzp43u
 zSw0+sEQsO+9wz2nGDgQCGepCcJR1lygVn2zwRTQKbq7Hjs+IWZ0gN2nDajScuR1RsxTE4WR
 lj0+Ne6VrAmPiW6QqRhliDO+e82riI75ywSWrJb9TQw0+UkIQ2DlNr0u0TwCUTcQNN6aKnru
 ouVt3qoRlcD5MuRhLH+ttAcmNITMg7GQ6RQajWrSKuKFrt6iuDbjgO2cnaTrLbNBBKPTG4oF
 D6kX8Zea0KvVBagBsaC1CDTDQQMxYBPDBSlqYCb/b2x7KHTvTAHUBSsBRL6MKz8wwruDodTM
 4E4ToV9URl4aE/msBZ4GLTtEmUHBh4/AYwk6ACYByYKyx5r3PDG0iHnJ8bV0OeyQ9ujfgBBP
 B2t4oASNnIOeGEEcQ2rjzsFNBFNPCKMBEACm7Xqafb1Dp1nDl06aw/3O9ixWsGMv1Uhfd2B6
 it6wh1HDCn9HpekgouR2HLMvdd3Y//GG89irEasjzENZPsK82PS0bvkxxIHRFm0pikF4ljIb
 6tca2sxFr/H7CCtWYZjZzPgnOPtnagN0qVVyEM7L5f7KjGb1/o5EDkVR2SVSSjrlmNdTL2Rd
 zaPqrBoxuR/y/n856deWqS1ZssOpqwKhxT1IVlF6S47CjFJ3+fiHNjkljLfxzDyQXwXCNoZn
 BKcW9PvAMf6W1DGASoXtsMg4HHzZ5fW+vnjzvWiC4pXrcP7Ivfxx5pB+nGiOfOY+/VSUlW/9
 GdzPlOIc1bGyKc6tGREH5lErmeoJZ5k7E9cMJx+xzuDItvnZbf6RuH5fg3QsljQy8jLlr4S6
 8YwxlObySJ5K+suPRzZOG2+kq77RJVqAgZXp3Zdvdaov4a5J3H8pxzjj0yZ2JZlndM4X7Msr
 P5tfxy1WvV4Km6QeFAsjcF5gM+wWl+mf2qrlp3dRwniG1vkLsnQugQ4oNUrx0ahwOSm9p6kM
 CIiTITo+W7O9KEE9XCb4vV0ejmLlgdDV8ASVUekeTJkmRIBnz0fa4pa1vbtZoi6/LlIdAEEt
 PY6p3hgkLLtr2GRodOW/Y3vPRd9+rJHq/tLIfwc58ZhQKmRcgrhtlnuTGTmyUqGSiMNfpwAR
 AQABwsFfBBgBAgAJBQJTTwijAhsMAAoJEAL1yD+ydue64BgP/33QKczgAvSdj9XTC14wZCGE
 U8ygZwkkyNf021iNMj+o0dpLU48PIhHIMTXlM2aiiZlPWgKVlDRjlYuc9EZqGgbOOuR/pNYA
 JX9vaqszyE34JzXBL9DBKUuAui8z8GcxRcz49/xtzzP0kH3OQbBIqZWuMRxKEpRptRT0wzBL
 O31ygf4FRxs68jvPCuZjTGKELIo656/Hmk17cmjoBAJK7JHfqdGkDXk5tneeHCkB411p9WJU
 vMO2EqsHjobjuFm89hI0pSxlUoiTL0Nuk9Edemjw70W4anGNyaQtBq+qu1RdjUPBvoJec7y/
 EXJtoGxq9Y+tmm22xwApSiIOyMwUi9A1iLjQLmngLeUdsHyrEWTbEYHd2sAM2sqKoZRyBDSv
 ejRvZD6zwkY/9nRqXt02H1quVOP42xlkwOQU6gxm93o/bxd7S5tEA359Sli5gZRaucpNQkwd
 KLQdCvFdksD270r4jU/rwR2R/Ubi+txfy0dk2wGBjl1xpSf0Lbl/KMR5TQntELfLR4etizLq
 Xpd2byn96Ivi8C8u9zJruXTueHH8vt7gJ1oax3yKRGU5o2eipCRiKZ0s/T7fvkdq+8beg9ku
 fDO4SAgJMIl6H5awliCY2zQvLHysS/Wb8QuB09hmhLZ4AifdHyF1J5qeePEhgTA+BaUbiUZf
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <1e31f575-b067-2d4c-1a64-9342049184d1@arm.com>
Date:   Wed, 2 Dec 2020 16:19:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <3e5e78cbfc9149cdc630511970af0e52e8ebdfb2.camel@aosc.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2020 16:03, Icenowy Zheng wrote:
> 在 2020-12-02星期三的 13:54 +0000，Andre Przywara写道：
>> This (relatively) new SoC is similar to the H6, but drops the
>> (broken)
>> PCIe support and the USB 3.0 controller. It also gets the management
>> controller removed, which in turn removes *some*, but not all of the
>> devices formerly dedicated to the ARISC (CPUS).
>> There does not seem to be an external interrupt controller anymore,
>> so
>> no external interrupts through an NMI pin. The AXP driver needs to
>> learn
>> living with that.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 704
>> ++++++++++++++++++
>>  1 file changed, 704 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
>> b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
>> new file mode 100644
>> index 000000000000..dcffbfdcd26b
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
>> @@ -0,0 +1,704 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +// Copyright (C) 2020 Arm Ltd.
>> +// based on the H6 dtsi, which is:
>> +//   Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/clock/sun50i-h616-ccu.h>
>> +#include <dt-bindings/clock/sun50i-h6-r-ccu.h>
>> +#include <dt-bindings/reset/sun50i-h616-ccu.h>
>> +#include <dt-bindings/reset/sun50i-h6-r-ccu.h>
>> +
>> +/ {
>> +	interrupt-parent = <&gic>;
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		cpu0: cpu@0 {
>> +			compatible = "arm,cortex-a53";
>> +			device_type = "cpu";
>> +			reg = <0>;
>> +			enable-method = "psci";
>> +			clocks = <&ccu CLK_CPUX>;
>> +		};
>> +
>> +		cpu1: cpu@1 {
>> +			compatible = "arm,cortex-a53";
>> +			device_type = "cpu";
>> +			reg = <1>;
>> +			enable-method = "psci";
>> +			clocks = <&ccu CLK_CPUX>;
>> +		};
>> +
>> +		cpu2: cpu@2 {
>> +			compatible = "arm,cortex-a53";
>> +			device_type = "cpu";
>> +			reg = <2>;
>> +			enable-method = "psci";
>> +			clocks = <&ccu CLK_CPUX>;
>> +		};
>> +
>> +		cpu3: cpu@3 {
>> +			compatible = "arm,cortex-a53";
>> +			device_type = "cpu";
>> +			reg = <3>;
>> +			enable-method = "psci";
>> +			clocks = <&ccu CLK_CPUX>;
>> +		};
>> +	};
>> +
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		/* 512KiB reserved for ARM Trusted Firmware (BL31) */
>> +		secmon_reserved: secmon@40000000 {
>> +			reg = <0x0 0x40000000 0x0 0x80000>;
>> +			no-map;
>> +		};
> 
> Should this node be dynamically added by the firmware? This is only
> some effort taken by our community, not from Allwinner. (Although
> Allwinner reserves much more memory in their BSP.)
> 
> (In my opinion, it should be applied by ATF to U-Boot DT, and then U-
> Boot add it to Linux DT.)

Yes, that is indeed a good idea. I put this in here to get things going.
The TF-A part is rather simple (we have code for that already), just
need to check if U-Boot does propagate this correctly.

> 
>> +	};
>> +
>> +	osc24M: osc24M_clk {
>> +		#clock-cells = <0>;
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <24000000>;
>> +		clock-output-names = "osc24M";
>> +	};
>> +
>> +	pmu {
>> +		compatible = "arm,cortex-a53-pmu";
>> +		interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>,
>> <&cpu3>;
>> +	};
>> +
>> +	psci {
>> +		compatible = "arm,psci-0.2";
>> +		method = "smc";
>> +	};
>> +
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		arm,no-tick-in-suspend;
>> +		interrupts = <GIC_PPI 13
>> +			(GIC_CPU_MASK_SIMPLE(4) |
>> IRQ_TYPE_LEVEL_HIGH)>,
>> +			     <GIC_PPI 14
>> +			(GIC_CPU_MASK_SIMPLE(4) |
>> IRQ_TYPE_LEVEL_HIGH)>,
>> +			     <GIC_PPI 11
>> +			(GIC_CPU_MASK_SIMPLE(4) |
>> IRQ_TYPE_LEVEL_HIGH)>,
>> +			     <GIC_PPI 10
>> +			(GIC_CPU_MASK_SIMPLE(4) |
>> IRQ_TYPE_LEVEL_HIGH)>;
>> +	};
>> +
>> +	soc {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x0 0x0 0x0 0x40000000>;
>> +
>> +		syscon: syscon@3000000 {
>> +			compatible = "allwinner,sun50i-h616-system-
>> control",
>> +				     "allwinner,sun50i-a64-system-
>> control";
>> +			reg = <0x03000000 0x1000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +
>> +			sram_c: sram@28000 {
>> +				compatible = "mmio-sram";
>> +				reg = <0x00028000 0x30000>;
>> +				#address-cells = <1>;
>> +				#size-cells = <1>;
>> +				ranges = <0 0x00028000 0x30000>;
>> +			};
>> +
>> +			sram_c1: sram@1a00000 {
>> +				compatible = "mmio-sram";
>> +				reg = <0x01a00000 0x200000>;
>> +				#address-cells = <1>;
>> +				#size-cells = <1>;
>> +				ranges = <0 0x01a00000 0x200000>;
>> +
>> +				ve_sram: sram-section@0 {
>> +					compatible = "allwinner,sun50i-
>> h616-sram-c1",
>> +						     "allwinner,sun4i-
>> a10-sram-c1";
>> +					reg = <0x000000 0x200000>;
>> +				};
>> +			};
>> +		};
>> +
>> +		ccu: clock@3001000 {
>> +			compatible = "allwinner,sun50i-h616-ccu";
>> +			reg = <0x03001000 0x1000>;
>> +			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>;
>> +			clock-names = "hosc", "losc", "iosc";
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +		};
>> +
>> +		watchdog: watchdog@30090a0 {
>> +			compatible = "allwinner,sun50i-h616-wdt",
>> +				     "allwinner,sun6i-a31-wdt";
>> +			reg = <0x030090a0 0x20>;
>> +			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&osc24M>;
>> +			status = "disabled";
>> +		};
>> +
>> +		pio: pinctrl@300b000 {
>> +			compatible = "allwinner,sun50i-h616-pinctrl";
>> +			reg = <0x0300b000 0x400>;
>> +			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_APB1>, <&osc24M>, <&rtc 0>;
>> +			clock-names = "apb", "hosc", "losc";
>> +			gpio-controller;
>> +			#gpio-cells = <3>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <3>;
>> +
>> +			ext_rgmii_pins: rgmii-pins {
>> +				pins = "PI0", "PI1", "PI2", "PI3",
>> "PI4",
>> +				       "PI5", "PI7", "PI8", "PI9",
>> "PI10",
>> +				       "PI11", "PI12", "PI13", "PI14",
>> "PI15",
>> +				       "PI16";
>> +				function = "emac0";
>> +				drive-strength = <40>;
>> +			};
>> +
>> +			i2c0_pins: i2c0-pins {
>> +				pins = "PI6", "PI7";
>> +				function = "i2c0";
>> +			};
>> +
>> +			i2c3_pins_a: i2c1-pins-a {
>> +				pins = "PH4", "PH5";
>> +				function = "i2c3";
>> +			};
>> +
>> +			ir_rx_pin: ir_rx_pin {
>> +				pins = "PH10";
>> +				function = "ir_rx";
>> +			};
>> +
>> +			mmc0_pins: mmc0-pins {
>> +				pins = "PF0", "PF1", "PF2", "PF3",
>> +				       "PF4", "PF5";
>> +				function = "mmc0";
>> +				drive-strength = <30>;
>> +				bias-pull-up;
>> +			};
>> +
>> +			mmc1_pins: mmc1-pins {
>> +				pins = "PG0", "PG1", "PG2", "PG3",
>> +				       "PG4", "PG5";
>> +				function = "mmc1";
>> +				drive-strength = <30>;
>> +				bias-pull-up;
>> +			};
>> +
>> +			mmc2_pins: mmc2-pins {
>> +				pins = "PC0", "PC1", "PC5", "PC6",
>> +				       "PC8", "PC9", "PC10", "PC11",
>> +				       "PC13", "PC14", "PC15", "PC16";
>> +				function = "mmc2";
>> +				drive-strength = <30>;
>> +				bias-pull-up;
>> +			};
>> +
>> +			spi0_pins: spi0-pins {
>> +				pins = "PC0", "PC2", "PC3", "PC4";
>> +				function = "spi0";
>> +			};
>> +
>> +			spi1_pins: spi1-pins {
>> +				pins = "PH6", "PH7", "PH8";
>> +				function = "spi1";
>> +			};
>> +
>> +			spi1_cs_pin: spi1-cs-pin {
>> +				pins = "PH5";
>> +				function = "spi1";
>> +			};
>> +
>> +			uart0_ph_pins: uart0-ph-pins {
>> +				pins = "PH0", "PH1";
>> +				function = "uart0";
>> +			};
>> +
>> +			uart1_pins: uart1-pins {
>> +				pins = "PG6", "PG7";
>> +				function = "uart1";
>> +			};
>> +
>> +			uart1_rts_cts_pins: uart1-rts-cts-pins {
>> +				pins = "PG8", "PG9";
>> +				function = "uart1";
>> +			};
>> +		};
>> +
>> +		gic: interrupt-controller@3021000 {
>> +			compatible = "arm,gic-400";
>> +			reg = <0x03021000 0x1000>,
>> +			      <0x03022000 0x2000>,
>> +			      <0x03024000 0x2000>,
>> +			      <0x03026000 0x2000>;
>> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4)
>> | IRQ_TYPE_LEVEL_HIGH)>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <3>;
>> +		};
>> +
>> +		mmc0: mmc@4020000 {
>> +			compatible = "allwinner,sun50i-h616-mmc",
>> +				     "allwinner,sun50i-a100-mmc";
>> +			reg = <0x04020000 0x1000>;
>> +			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
>> +			clock-names = "ahb", "mmc";
>> +			resets = <&ccu RST_BUS_MMC0>;
>> +			reset-names = "ahb";
>> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&mmc0_pins>;
>> +			status = "disabled";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		};
>> +
>> +		mmc1: mmc@4021000 {
>> +			compatible = "allwinner,sun50i-h616-mmc",
>> +				     "allwinner,sun50i-a100-mmc";
>> +			reg = <0x04021000 0x1000>;
>> +			clocks = <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
>> +			clock-names = "ahb", "mmc";
>> +			resets = <&ccu RST_BUS_MMC1>;
>> +			reset-names = "ahb";
>> +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&mmc1_pins>;
>> +			status = "disabled";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		};
>> +
>> +		mmc2: mmc@4022000 {
>> +			compatible = "allwinner,sun50i-h616-emmc",
>> +				     "allwinner,sun50i-a64-emmc";
>> +			reg = <0x04022000 0x1000>;
>> +			clocks = <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;
>> +			clock-names = "ahb", "mmc";
>> +			resets = <&ccu RST_BUS_MMC2>;
>> +			reset-names = "ahb";
>> +			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&mmc2_pins>;
>> +			status = "disabled";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		};
>> +
>> +		uart0: serial@5000000 {
>> +			compatible = "snps,dw-apb-uart";
>> +			reg = <0x05000000 0x400>;
>> +			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
>> +			reg-shift = <2>;
>> +			reg-io-width = <4>;
>> +			clocks = <&ccu CLK_BUS_UART0>;
>> +			resets = <&ccu RST_BUS_UART0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		uart1: serial@5000400 {
>> +			compatible = "snps,dw-apb-uart";
>> +			reg = <0x05000400 0x400>;
>> +			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
>> +			reg-shift = <2>;
>> +			reg-io-width = <4>;
>> +			clocks = <&ccu CLK_BUS_UART1>;
>> +			resets = <&ccu RST_BUS_UART1>;
>> +			status = "disabled";
>> +		};
>> +
>> +		uart2: serial@5000800 {
>> +			compatible = "snps,dw-apb-uart";
>> +			reg = <0x05000800 0x400>;
>> +			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
>> +			reg-shift = <2>;
>> +			reg-io-width = <4>;
>> +			clocks = <&ccu CLK_BUS_UART2>;
>> +			resets = <&ccu RST_BUS_UART2>;
>> +			status = "disabled";
>> +		};
>> +
>> +		uart3: serial@5000c00 {
>> +			compatible = "snps,dw-apb-uart";
>> +			reg = <0x05000c00 0x400>;
>> +			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
>> +			reg-shift = <2>;
>> +			reg-io-width = <4>;
>> +			clocks = <&ccu CLK_BUS_UART3>;
>> +			resets = <&ccu RST_BUS_UART3>;
>> +			status = "disabled";
>> +		};
>> +
>> +		uart4: serial@5001000 {
>> +			compatible = "snps,dw-apb-uart";
>> +			reg = <0x05001000 0x400>;
>> +			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
>> +			reg-shift = <2>;
>> +			reg-io-width = <4>;
>> +			clocks = <&ccu CLK_BUS_UART4>;
>> +			resets = <&ccu RST_BUS_UART4>;
>> +			status = "disabled";
>> +		};
>> +
>> +		uart5: serial@5001400 {
>> +			compatible = "snps,dw-apb-uart";
>> +			reg = <0x05001400 0x400>;
>> +			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>> +			reg-shift = <2>;
>> +			reg-io-width = <4>;
>> +			clocks = <&ccu CLK_BUS_UART5>;
>> +			resets = <&ccu RST_BUS_UART5>;
>> +			status = "disabled";
>> +		};
>> +
>> +		i2c0: i2c@5002000 {
>> +			compatible = "allwinner,sun50i-h616-i2c",
>> +				     "allwinner,sun6i-a31-i2c";
>> +			reg = <0x05002000 0x400>;
>> +			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_BUS_I2C0>;
>> +			resets = <&ccu RST_BUS_I2C0>;
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&i2c0_pins>;
>> +			status = "disabled";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		};
>> +
>> +		i2c1: i2c@5002400 {
>> +			compatible = "allwinner,sun50i-h616-i2c",
>> +				     "allwinner,sun6i-a31-i2c";
>> +			reg = <0x05002400 0x400>;
>> +			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_BUS_I2C1>;
>> +			resets = <&ccu RST_BUS_I2C1>;
>> +			status = "disabled";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		};
>> +
>> +		i2c2: i2c@5002800 {
>> +			compatible = "allwinner,sun50i-h616-i2c",
>> +				     "allwinner,sun6i-a31-i2c";
>> +			reg = <0x05002800 0x400>;
>> +			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_BUS_I2C2>;
>> +			resets = <&ccu RST_BUS_I2C2>;
>> +			status = "disabled";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		};
>> +
>> +		i2c3: i2c@5002c00 {
>> +			compatible = "allwinner,sun50i-h616-i2c",
>> +				     "allwinner,sun6i-a31-i2c";
>> +			reg = <0x05002c00 0x400>;
>> +			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_BUS_I2C3>;
>> +			resets = <&ccu RST_BUS_I2C3>;
>> +			status = "disabled";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		};
>> +
>> +		i2c4: i2c@5003000 {
>> +			compatible = "allwinner,sun50i-h616-i2c",
>> +				     "allwinner,sun6i-a31-i2c";
>> +			reg = <0x05003000 0x400>;
>> +			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_BUS_I2C4>;
>> +			resets = <&ccu RST_BUS_I2C4>;
>> +			status = "disabled";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		};
>> +
>> +		spi0: spi@5010000 {
>> +			compatible = "allwinner,sun50i-h616-spi",
>> +				     "allwinner,sun8i-h3-spi";
>> +			reg = <0x05010000 0x1000>;
>> +			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
>> +			clock-names = "ahb", "mod";
>> +			resets = <&ccu RST_BUS_SPI0>;
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&spi0_pins>;
>> +			status = "disabled";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		};
>> +
>> +		spi1: spi@5011000 {
>> +			compatible = "allwinner,sun50i-h616-spi",
>> +				     "allwinner,sun8i-h3-spi";
>> +			reg = <0x05011000 0x1000>;
>> +			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
>> +			clock-names = "ahb", "mod";
>> +			resets = <&ccu RST_BUS_SPI1>;
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&spi1_pins>;
>> +			status = "disabled";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		};
>> +
>> +		emac0: ethernet@5020000 {
>> +			compatible = "allwinner,sun50i-h616-emac",
>> +				     "allwinner,sun50i-a64-emac";
>> +			syscon = <&syscon>;
>> +			reg = <0x05020000 0x10000>;
>> +			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "macirq";
>> +			resets = <&ccu RST_BUS_EMAC0>;
>> +			reset-names = "stmmaceth";
>> +			clocks = <&ccu CLK_BUS_EMAC0>;
>> +			clock-names = "stmmaceth";
>> +			status = "disabled";
>> +
>> +			mdio: mdio {
>> +				compatible = "snps,dwmac-mdio";
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +			};
>> +		};
>> +
>> +		usbotg: usb@5100000 {
>> +			compatible = "allwinner,sun50i-h616-musb",
>> +				     "allwinner,sun8i-a33-musb";
>> +			reg = <0x05100000 0x0400>;
>> +			clocks = <&ccu CLK_BUS_OTG>;
>> +			resets = <&ccu RST_BUS_OTG>;
>> +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "mc";
>> +			phys = <&usbphy 0>;
>> +			phy-names = "usb";
>> +			extcon = <&usbphy 0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		usbphy: phy@5100400 {
>> +			compatible = "allwinner,sun50i-h616-usb-phy";
> 
> Sorry, but did I missed a patch for this compatible?

No, this is more of a placeholder at the moment, the USB PHY is not yet
working. Originally I had the H6 compatible in (which is obviously
wrong), then the H3 compatible - which looks like the right thing, but
didn't work. I guess there are some new bits in here, similar to the
A100 (also not working), but I didn't find the right ones yet.
I wanted to keep the nodes in, so people can check the other bits
already. Ideally the driver will just learn the new compatible and it
starts to work.

Thanks for having a look!

Cheers,
Andre


>> +			reg = <0x05100400 0x24>,
>> +			      <0x05101800 0x4>,
>> +			      <0x05200800 0x4>,
>> +			      <0x05310800 0x4>,
>> +			      <0x05311800 0x4>;
>> +			reg-names = "phy_ctrl",
>> +				    "pmu0",
>> +				    "pmu1",
>> +				    "pmu2",
>> +				    "pmu3";
>> +			clocks = <&ccu CLK_USB_PHY0>,
>> +				 <&ccu CLK_USB_PHY1>,
>> +				 <&ccu CLK_USB_PHY2>,
>> +				 <&ccu CLK_USB_PHY3>;
>> +			clock-names = "usb0_phy",
>> +				      "usb1_phy",
>> +				      "usb2_phy",
>> +				      "usb3_phy";
>> +			resets = <&ccu RST_USB_PHY0>,
>> +				 <&ccu RST_USB_PHY1>,
>> +				 <&ccu RST_USB_PHY2>,
>> +				 <&ccu RST_USB_PHY3>;
>> +			reset-names = "usb0_reset",
>> +				      "usb1_reset",
>> +				      "usb2_reset",
>> +				      "usb3_reset";
>> +			status = "disabled";
>> +			#phy-cells = <1>;
>> +		};
>> +
>> +		ehci0: usb@5101000 {
>> +			compatible = "allwinner,sun50i-h616-ehci",
>> +				     "generic-ehci";
>> +			reg = <0x05101000 0x100>;
>> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_BUS_OHCI0>,
>> +				 <&ccu CLK_BUS_EHCI0>,
>> +				 <&ccu CLK_USB_OHCI0>;
>> +			resets = <&ccu RST_BUS_OHCI0>,
>> +				 <&ccu RST_BUS_EHCI0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		ohci0: usb@5101400 {
>> +			compatible = "allwinner,sun50i-h616-ohci",
>> +				     "generic-ohci";
>> +			reg = <0x05101400 0x100>;
>> +			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_BUS_OHCI0>,
>> +				 <&ccu CLK_USB_OHCI0>;
>> +			resets = <&ccu RST_BUS_OHCI0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		ehci1: usb@5200000 {
>> +			compatible = "allwinner,sun50i-h616-ehci",
>> +				     "generic-ehci";
>> +			reg = <0x05200000 0x100>;
>> +			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_BUS_OHCI1>,
>> +				 <&ccu CLK_BUS_EHCI1>,
>> +				 <&ccu CLK_USB_OHCI1>;
>> +			resets = <&ccu RST_BUS_OHCI1>,
>> +				 <&ccu RST_BUS_EHCI1>;
>> +			phys = <&usbphy 1>;
>> +			phy-names = "usb";
>> +			status = "disabled";
>> +		};
>> +
>> +		ohci1: usb@5200400 {
>> +			compatible = "allwinner,sun50i-h616-ohci",
>> +				     "generic-ohci";
>> +			reg = <0x05200400 0x100>;
>> +			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_BUS_OHCI1>,
>> +				 <&ccu CLK_USB_OHCI1>;
>> +			resets = <&ccu RST_BUS_OHCI1>;
>> +			phys = <&usbphy 1>;
>> +			phy-names = "usb";
>> +			status = "disabled";
>> +		};
>> +
>> +		ehci2: usb@5310000 {
>> +			compatible = "allwinner,sun50i-h616-ehci",
>> +				     "generic-ehci";
>> +			reg = <0x05310000 0x100>;
>> +			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_BUS_OHCI2>,
>> +				 <&ccu CLK_BUS_EHCI2>,
>> +				 <&ccu CLK_USB_OHCI2>;
>> +			resets = <&ccu RST_BUS_OHCI2>,
>> +				 <&ccu RST_BUS_EHCI2>;
>> +			phys = <&usbphy 2>;
>> +			phy-names = "usb";
>> +			status = "disabled";
>> +		};
>> +
>> +		ohci2: usb@5310400 {
>> +			compatible = "allwinner,sun50i-h616-ohci",
>> +				     "generic-ohci";
>> +			reg = <0x05310400 0x100>;
>> +			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_BUS_OHCI2>,
>> +				 <&ccu CLK_USB_OHCI2>;
>> +			resets = <&ccu RST_BUS_OHCI2>;
>> +			phys = <&usbphy 2>;
>> +			phy-names = "usb";
>> +			status = "disabled";
>> +		};
>> +
>> +		ehci3: usb@5311000 {
>> +			compatible = "allwinner,sun50i-h616-ehci",
>> +				     "generic-ehci";
>> +			reg = <0x05311000 0x100>;
>> +			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_BUS_OHCI3>,
>> +				 <&ccu CLK_BUS_EHCI3>,
>> +				 <&ccu CLK_USB_OHCI3>;
>> +			resets = <&ccu RST_BUS_OHCI3>,
>> +				 <&ccu RST_BUS_EHCI3>;
>> +			phys = <&usbphy 3>;
>> +			phy-names = "usb";
>> +			status = "disabled";
>> +		};
>> +
>> +		ohci3: usb@5311400 {
>> +			compatible = "allwinner,sun50i-h616-ohci",
>> +				     "generic-ohci";
>> +			reg = <0x05311400 0x100>;
>> +			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_BUS_OHCI3>,
>> +				 <&ccu CLK_USB_OHCI3>;
>> +			resets = <&ccu RST_BUS_OHCI3>;
>> +			phys = <&usbphy 3>;
>> +			phy-names = "usb";
>> +			status = "disabled";
>> +		};
>> +
>> +		rtc: rtc@7000000 {
>> +			compatible = "allwinner,sun50i-h616-rtc",
>> +				     "allwinner,sun50i-h6-rtc";
>> +			reg = <0x07000000 0x400>;
>> +			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
>> +			clock-output-names = "osc32k", "osc32k-out",
>> "iosc";
>> +			#clock-cells = <1>;
>> +		};
>> +
>> +		r_ccu: clock@7010000 {
>> +			compatible = "allwinner,sun50i-h616-r-ccu";
>> +			reg = <0x07010000 0x400>;
>> +			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>,
>> +				 <&ccu CLK_PLL_PERIPH0>;
>> +			clock-names = "hosc", "losc", "iosc", "pll-
>> periph";
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +		};
>> +
>> +		r_pio: pinctrl@7022000 {
>> +			compatible = "allwinner,sun50i-h616-r-pinctrl";
>> +			reg = <0x07022000 0x400>;
>> +			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&r_ccu CLK_R_APB1>, <&osc24M>, <&rtc
>> 0>;
>> +			clock-names = "apb", "hosc", "losc";
>> +			gpio-controller;
>> +			#gpio-cells = <3>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <3>;
>> +
>> +			r_i2c_pins: r-i2c-pins {
>> +				pins = "PL0", "PL1";
>> +				function = "s_i2c";
>> +			};
>> +		};
>> +
>> +		ir: ir@7040000 {
>> +				compatible = "allwinner,sun50i-h616-
>> ir",
>> +					     "allwinner,sun6i-a31-ir";
>> +				reg = <0x07040000 0x400>;
>> +				interrupts = <GIC_SPI 106
>> IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&ccu CLK_R_APB1_IR>,
>> +					 <&ccu CLK_IR>;
>> +				clock-names = "apb", "ir";
>> +				resets = <&ccu RST_R_APB1_IR>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&ir_rx_pin>;
>> +				status = "disabled";
>> +		};
>> +
>> +		r_i2c: i2c@7081400 {
>> +			compatible = "allwinner,sun50i-h616-i2c",
>> +				     "allwinner,sun6i-a31-i2c";
>> +			reg = <0x07081400 0x400>;
>> +			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&r_ccu CLK_R_APB2_I2C>;
>> +			resets = <&r_ccu RST_R_APB2_I2C>;
>> +			status = "disabled";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		};
>> +	};
>> +};

