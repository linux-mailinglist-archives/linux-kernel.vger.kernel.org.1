Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B41D2CC1EB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389022AbgLBQQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:16:53 -0500
Received: from relay5.mymailcheap.com ([159.100.241.64]:34693 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387401AbgLBQQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:16:52 -0500
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.66.162])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 9DD642008F;
        Wed,  2 Dec 2020 16:15:54 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay2.mymailcheap.com (Postfix) with ESMTPS id C7D4F3ECD9;
        Wed,  2 Dec 2020 17:14:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id EE7712A365;
        Wed,  2 Dec 2020 11:14:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1606925662;
        bh=1/jvqysamr6Be24q9isG4YoQHcF5ys/CDdporo6bvXo=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=ZQKaZESbUtMOB37bkTy5zABUwnpDXw7edLz5XyEsUg+CV1TRvNEIE96AKYFdjBi0N
         i0J9udqaMwC9u36QVh1lHK3qhhlIsHDR7uXoRzsJMlWGCNwKAihSTbRBqHRpJkqPv9
         zMkiRAERTpyfrGdsY+Dy7l1Ima1HRN1paCPymluo=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8eLxsf1n27br; Wed,  2 Dec 2020 11:14:18 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Wed,  2 Dec 2020 11:14:18 -0500 (EST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 4FD4140026;
        Wed,  2 Dec 2020 16:14:17 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="i3diD1Oh";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [172.19.0.1] (unknown [64.225.114.122])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 7D63440026;
        Wed,  2 Dec 2020 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1606925646; bh=1/jvqysamr6Be24q9isG4YoQHcF5ys/CDdporo6bvXo=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=i3diD1OhAZsJoR1H5+vC3CYxPklesnEMgSpxnIMp6jTnET6Qp2GZSzUTzUXS9Mm+9
         UJtK9LniOwccKsoY1Ou9sMvpNCJGkL/EM8Ktv6wWhffseRDoKOyl4TcTgc77xVqs5/
         a0jjUHfXy+AfsjbnCQCbLxFcKY6u0wVQIgu4T+Eg=
Date:   Thu, 03 Dec 2020 00:13:52 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20201202160504.klxbpqgagra4uxeh@gilmour>
References: <20201202135409.13683-1-andre.przywara@arm.com> <20201202135409.13683-8-andre.przywara@arm.com> <20201202160504.klxbpqgagra4uxeh@gilmour>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 7/8] arm64: dts: allwinner: Add Allwinner H616 .dtsi file
To:     Maxime Ripard <maxime@cerno.tech>,
        Andre Przywara <andre.przywara@arm.com>
CC:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <5804AC62-6974-45AD-A586-AB030C0D0A82@aosc.io>
X-Rspamd-Queue-Id: 4FD4140026
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
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_TWELVE(0.00)[12];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B412=E6=9C=883=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=881=
2:05:04, Maxime Ripard <maxime@cerno=2Etech> =E5=86=99=E5=88=B0:
>On Wed, Dec 02, 2020 at 01:54:08PM +0000, Andre Przywara wrote:
>> This (relatively) new SoC is similar to the H6, but drops the
>(broken)
>> PCIe support and the USB 3=2E0 controller=2E It also gets the managemen=
t
>> controller removed, which in turn removes *some*, but not all of the
>> devices formerly dedicated to the ARISC (CPUS)=2E
>> There does not seem to be an external interrupt controller anymore,
>so
>> no external interrupts through an NMI pin=2E The AXP driver needs to
>learn
>> living with that=2E
>>=20
>> Signed-off-by: Andre Przywara <andre=2Eprzywara@arm=2Ecom>
>> ---
>>  =2E=2E=2E/arm64/boot/dts/allwinner/sun50i-h616=2Edtsi | 704
>++++++++++++++++++
>>  1 file changed, 704 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616=2Edtsi
>>=20
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616=2Edtsi
>b/arch/arm64/boot/dts/allwinner/sun50i-h616=2Edtsi
>> new file mode 100644
>> index 000000000000=2E=2Edcffbfdcd26b
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616=2Edtsi
>> @@ -0,0 +1,704 @@
>> +// SPDX-License-Identifier: (GPL-2=2E0+ OR MIT)
>> +// Copyright (C) 2020 Arm Ltd=2E
>> +// based on the H6 dtsi, which is:
>> +//   Copyright (C) 2017 Icenowy Zheng <icenowy@aosc=2Eio>
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic=2Eh>
>> +#include <dt-bindings/clock/sun50i-h616-ccu=2Eh>
>> +#include <dt-bindings/clock/sun50i-h6-r-ccu=2Eh>
>> +#include <dt-bindings/reset/sun50i-h616-ccu=2Eh>
>> +#include <dt-bindings/reset/sun50i-h6-r-ccu=2Eh>
>> +
>> +/ {
>> +	interrupt-parent =3D <&gic>;
>> +	#address-cells =3D <2>;
>> +	#size-cells =3D <2>;
>> +
>> +	cpus {
>> +		#address-cells =3D <1>;
>> +		#size-cells =3D <0>;
>> +
>> +		cpu0: cpu@0 {
>> +			compatible =3D "arm,cortex-a53";
>> +			device_type =3D "cpu";
>> +			reg =3D <0>;
>> +			enable-method =3D "psci";
>> +			clocks =3D <&ccu CLK_CPUX>;
>> +		};
>> +
>> +		cpu1: cpu@1 {
>> +			compatible =3D "arm,cortex-a53";
>> +			device_type =3D "cpu";
>> +			reg =3D <1>;
>> +			enable-method =3D "psci";
>> +			clocks =3D <&ccu CLK_CPUX>;
>> +		};
>> +
>> +		cpu2: cpu@2 {
>> +			compatible =3D "arm,cortex-a53";
>> +			device_type =3D "cpu";
>> +			reg =3D <2>;
>> +			enable-method =3D "psci";
>> +			clocks =3D <&ccu CLK_CPUX>;
>> +		};
>> +
>> +		cpu3: cpu@3 {
>> +			compatible =3D "arm,cortex-a53";
>> +			device_type =3D "cpu";
>> +			reg =3D <3>;
>> +			enable-method =3D "psci";
>> +			clocks =3D <&ccu CLK_CPUX>;
>> +		};
>> +	};
>> +
>> +	reserved-memory {
>> +		#address-cells =3D <2>;
>> +		#size-cells =3D <2>;
>> +		ranges;
>> +
>> +		/* 512KiB reserved for ARM Trusted Firmware (BL31) */
>> +		secmon_reserved: secmon@40000000 {
>> +			reg =3D <0x0 0x40000000 0x0 0x80000>;
>> +			no-map;
>> +		};
>> +	};
>
>I'm not sure why that node is there, the previous SoCs didn't have it?

Previously we (ab)use SRAM A2 (designed for ARISC) for ATF=2E
But H616 has no SRAM A2=2E

>Shouldn't ATF patch it itself?
>
>> +	osc24M: osc24M_clk {
>> +		#clock-cells =3D <0>;
>> +		compatible =3D "fixed-clock";
>> +		clock-frequency =3D <24000000>;
>> +		clock-output-names =3D "osc24M";
>> +	};
>> +
>> +	pmu {
>> +		compatible =3D "arm,cortex-a53-pmu";
>> +		interrupts =3D <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
>> +			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-affinity =3D <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
>> +	};
>> +
>> +	psci {
>> +		compatible =3D "arm,psci-0=2E2";
>> +		method =3D "smc";
>> +	};
>> +
>> +	timer {
>> +		compatible =3D "arm,armv8-timer";
>> +		arm,no-tick-in-suspend;
>
>This was tested with crust I assume?
>
>> +		interrupts =3D <GIC_PPI 13
>> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
>> +			     <GIC_PPI 14
>> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
>> +			     <GIC_PPI 11
>> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
>> +			     <GIC_PPI 10
>> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>> +	};
>> +
>> +	soc {
>> +		compatible =3D "simple-bus";
>> +		#address-cells =3D <1>;
>> +		#size-cells =3D <1>;
>> +		ranges =3D <0x0 0x0 0x0 0x40000000>;
>> +
>> +		syscon: syscon@3000000 {
>> +			compatible =3D "allwinner,sun50i-h616-system-control",
>
>That compatible isn't documented
>
>> +				     "allwinner,sun50i-a64-system-control";
>> +			reg =3D <0x03000000 0x1000>;
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <1>;
>> +			ranges;
>> +
>> +			sram_c: sram@28000 {
>> +				compatible =3D "mmio-sram";
>> +				reg =3D <0x00028000 0x30000>;
>> +				#address-cells =3D <1>;
>> +				#size-cells =3D <1>;
>> +				ranges =3D <0 0x00028000 0x30000>;
>> +			};
>> +
>> +			sram_c1: sram@1a00000 {
>> +				compatible =3D "mmio-sram";
>> +				reg =3D <0x01a00000 0x200000>;
>> +				#address-cells =3D <1>;
>> +				#size-cells =3D <1>;
>> +				ranges =3D <0 0x01a00000 0x200000>;
>> +
>> +				ve_sram: sram-section@0 {
>> +					compatible =3D "allwinner,sun50i-h616-sram-c1",
>
>Ditto
>
>> +						     "allwinner,sun4i-a10-sram-c1";
>> +					reg =3D <0x000000 0x200000>;
>> +				};
>> +			};
>> +		};
>> +
>> +		ccu: clock@3001000 {
>> +			compatible =3D "allwinner,sun50i-h616-ccu";
>
>Ditto
>
>> +			reg =3D <0x03001000 0x1000>;
>> +			clocks =3D <&osc24M>, <&rtc 0>, <&rtc 2>;
>> +			clock-names =3D "hosc", "losc", "iosc";
>> +			#clock-cells =3D <1>;
>> +			#reset-cells =3D <1>;
>> +		};
>> +
>> +		watchdog: watchdog@30090a0 {
>> +			compatible =3D "allwinner,sun50i-h616-wdt",
>
>Ditto=2E I guess you can just run checkpatch there, it will let you know
>all the ones that aren't documented :)
>
>> +				     "allwinner,sun6i-a31-wdt";
>> +			reg =3D <0x030090a0 0x20>;
>> +			interrupts =3D <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =3D <&osc24M>;
>> +			status =3D "disabled";
>> +		};
>> +
>> +		pio: pinctrl@300b000 {
>> +			compatible =3D "allwinner,sun50i-h616-pinctrl";
>> +			reg =3D <0x0300b000 0x400>;
>> +			interrupts =3D <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =3D <&ccu CLK_APB1>, <&osc24M>, <&rtc 0>;
>> +			clock-names =3D "apb", "hosc", "losc";
>> +			gpio-controller;
>> +			#gpio-cells =3D <3>;
>> +			interrupt-controller;
>> +			#interrupt-cells =3D <3>;
>> +
>> +			ext_rgmii_pins: rgmii-pins {
>> +				pins =3D "PI0", "PI1", "PI2", "PI3", "PI4",
>> +				       "PI5", "PI7", "PI8", "PI9", "PI10",
>> +				       "PI11", "PI12", "PI13", "PI14", "PI15",
>> +				       "PI16";
>> +				function =3D "emac0";
>> +				drive-strength =3D <40>;
>> +			};
>> +
>> +			i2c0_pins: i2c0-pins {
>> +				pins =3D "PI6", "PI7";
>> +				function =3D "i2c0";
>> +			};
>> +
>> +			i2c3_pins_a: i2c1-pins-a {
>
>I guess you meant i2c3 in the node name?
>
>The pin groups with multiple options also are supposed to have the pin
>bank instead of the _a or _b suffix, so i2c3_ph_pins=20
>
>> +				pins =3D "PH4", "PH5";
>> +				function =3D "i2c3";
>> +			};
>> +
>> +			ir_rx_pin: ir_rx_pin {
>> +				pins =3D "PH10";
>> +				function =3D "ir_rx";
>> +			};
>> +
>> +			mmc0_pins: mmc0-pins {
>> +				pins =3D "PF0", "PF1", "PF2", "PF3",
>> +				       "PF4", "PF5";
>> +				function =3D "mmc0";
>> +				drive-strength =3D <30>;
>> +				bias-pull-up;
>> +			};
>> +
>> +			mmc1_pins: mmc1-pins {
>> +				pins =3D "PG0", "PG1", "PG2", "PG3",
>> +				       "PG4", "PG5";
>> +				function =3D "mmc1";
>> +				drive-strength =3D <30>;
>> +				bias-pull-up;
>> +			};
>> +
>> +			mmc2_pins: mmc2-pins {
>> +				pins =3D "PC0", "PC1", "PC5", "PC6",
>> +				       "PC8", "PC9", "PC10", "PC11",
>> +				       "PC13", "PC14", "PC15", "PC16";
>> +				function =3D "mmc2";
>> +				drive-strength =3D <30>;
>> +				bias-pull-up;
>> +			};
>> +
>> +			spi0_pins: spi0-pins {
>> +				pins =3D "PC0", "PC2", "PC3", "PC4";
>> +				function =3D "spi0";
>> +			};
>> +
>> +			spi1_pins: spi1-pins {
>> +				pins =3D "PH6", "PH7", "PH8";
>> +				function =3D "spi1";
>> +			};
>> +
>> +			spi1_cs_pin: spi1-cs-pin {
>> +				pins =3D "PH5";
>> +				function =3D "spi1";
>> +			};
>> +
>> +			uart0_ph_pins: uart0-ph-pins {
>> +				pins =3D "PH0", "PH1";
>> +				function =3D "uart0";
>> +			};
>> +
>> +			uart1_pins: uart1-pins {
>> +				pins =3D "PG6", "PG7";
>> +				function =3D "uart1";
>> +			};
>> +
>> +			uart1_rts_cts_pins: uart1-rts-cts-pins {
>> +				pins =3D "PG8", "PG9";
>> +				function =3D "uart1";
>> +			};
>> +		};
>> +
>> +		gic: interrupt-controller@3021000 {
>> +			compatible =3D "arm,gic-400";
>> +			reg =3D <0x03021000 0x1000>,
>> +			      <0x03022000 0x2000>,
>> +			      <0x03024000 0x2000>,
>> +			      <0x03026000 0x2000>;
>> +			interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
>IRQ_TYPE_LEVEL_HIGH)>;
>> +			interrupt-controller;
>> +			#interrupt-cells =3D <3>;
>> +		};
>> +
>> +		mmc0: mmc@4020000 {
>> +			compatible =3D "allwinner,sun50i-h616-mmc",
>> +				     "allwinner,sun50i-a100-mmc";
>> +			reg =3D <0x04020000 0x1000>;
>> +			clocks =3D <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
>> +			clock-names =3D "ahb", "mmc";
>> +			resets =3D <&ccu RST_BUS_MMC0>;
>> +			reset-names =3D "ahb";
>> +			interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>> +			pinctrl-names =3D "default";
>> +			pinctrl-0 =3D <&mmc0_pins>;
>> +			status =3D "disabled";
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <0>;
>> +		};
>> +
>> +		mmc1: mmc@4021000 {
>> +			compatible =3D "allwinner,sun50i-h616-mmc",
>> +				     "allwinner,sun50i-a100-mmc";
>> +			reg =3D <0x04021000 0x1000>;
>> +			clocks =3D <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
>> +			clock-names =3D "ahb", "mmc";
>> +			resets =3D <&ccu RST_BUS_MMC1>;
>> +			reset-names =3D "ahb";
>> +			interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>> +			pinctrl-names =3D "default";
>> +			pinctrl-0 =3D <&mmc1_pins>;
>> +			status =3D "disabled";
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <0>;
>> +		};
>> +
>> +		mmc2: mmc@4022000 {
>> +			compatible =3D "allwinner,sun50i-h616-emmc",
>> +				     "allwinner,sun50i-a64-emmc";
>> +			reg =3D <0x04022000 0x1000>;
>> +			clocks =3D <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;
>> +			clock-names =3D "ahb", "mmc";
>> +			resets =3D <&ccu RST_BUS_MMC2>;
>> +			reset-names =3D "ahb";
>> +			interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>> +			pinctrl-names =3D "default";
>> +			pinctrl-0 =3D <&mmc2_pins>;
>> +			status =3D "disabled";
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <0>;
>> +		};
>> +
>> +		uart0: serial@5000000 {
>> +			compatible =3D "snps,dw-apb-uart";
>> +			reg =3D <0x05000000 0x400>;
>> +			interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
>> +			reg-shift =3D <2>;
>> +			reg-io-width =3D <4>;
>> +			clocks =3D <&ccu CLK_BUS_UART0>;
>> +			resets =3D <&ccu RST_BUS_UART0>;
>> +			status =3D "disabled";
>> +		};
>> +
>> +		uart1: serial@5000400 {
>> +			compatible =3D "snps,dw-apb-uart";
>> +			reg =3D <0x05000400 0x400>;
>> +			interrupts =3D <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
>> +			reg-shift =3D <2>;
>> +			reg-io-width =3D <4>;
>> +			clocks =3D <&ccu CLK_BUS_UART1>;
>> +			resets =3D <&ccu RST_BUS_UART1>;
>> +			status =3D "disabled";
>> +		};
>> +
>> +		uart2: serial@5000800 {
>> +			compatible =3D "snps,dw-apb-uart";
>> +			reg =3D <0x05000800 0x400>;
>> +			interrupts =3D <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
>> +			reg-shift =3D <2>;
>> +			reg-io-width =3D <4>;
>> +			clocks =3D <&ccu CLK_BUS_UART2>;
>> +			resets =3D <&ccu RST_BUS_UART2>;
>> +			status =3D "disabled";
>> +		};
>> +
>> +		uart3: serial@5000c00 {
>> +			compatible =3D "snps,dw-apb-uart";
>> +			reg =3D <0x05000c00 0x400>;
>> +			interrupts =3D <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
>> +			reg-shift =3D <2>;
>> +			reg-io-width =3D <4>;
>> +			clocks =3D <&ccu CLK_BUS_UART3>;
>> +			resets =3D <&ccu RST_BUS_UART3>;
>> +			status =3D "disabled";
>> +		};
>> +
>> +		uart4: serial@5001000 {
>> +			compatible =3D "snps,dw-apb-uart";
>> +			reg =3D <0x05001000 0x400>;
>> +			interrupts =3D <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
>> +			reg-shift =3D <2>;
>> +			reg-io-width =3D <4>;
>> +			clocks =3D <&ccu CLK_BUS_UART4>;
>> +			resets =3D <&ccu RST_BUS_UART4>;
>> +			status =3D "disabled";
>> +		};
>> +
>> +		uart5: serial@5001400 {
>> +			compatible =3D "snps,dw-apb-uart";
>> +			reg =3D <0x05001400 0x400>;
>> +			interrupts =3D <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>> +			reg-shift =3D <2>;
>> +			reg-io-width =3D <4>;
>> +			clocks =3D <&ccu CLK_BUS_UART5>;
>> +			resets =3D <&ccu RST_BUS_UART5>;
>> +			status =3D "disabled";
>> +		};
>> +
>> +		i2c0: i2c@5002000 {
>> +			compatible =3D "allwinner,sun50i-h616-i2c",
>> +				     "allwinner,sun6i-a31-i2c";
>> +			reg =3D <0x05002000 0x400>;
>> +			interrupts =3D <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =3D <&ccu CLK_BUS_I2C0>;
>> +			resets =3D <&ccu RST_BUS_I2C0>;
>> +			pinctrl-names =3D "default";
>> +			pinctrl-0 =3D <&i2c0_pins>;
>> +			status =3D "disabled";
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <0>;
>> +		};
>> +
>> +		i2c1: i2c@5002400 {
>> +			compatible =3D "allwinner,sun50i-h616-i2c",
>> +				     "allwinner,sun6i-a31-i2c";
>> +			reg =3D <0x05002400 0x400>;
>> +			interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =3D <&ccu CLK_BUS_I2C1>;
>> +			resets =3D <&ccu RST_BUS_I2C1>;
>> +			status =3D "disabled";
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <0>;
>> +		};
>> +
>> +		i2c2: i2c@5002800 {
>> +			compatible =3D "allwinner,sun50i-h616-i2c",
>> +				     "allwinner,sun6i-a31-i2c";
>> +			reg =3D <0x05002800 0x400>;
>> +			interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =3D <&ccu CLK_BUS_I2C2>;
>> +			resets =3D <&ccu RST_BUS_I2C2>;
>> +			status =3D "disabled";
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <0>;
>> +		};
>> +
>> +		i2c3: i2c@5002c00 {
>> +			compatible =3D "allwinner,sun50i-h616-i2c",
>> +				     "allwinner,sun6i-a31-i2c";
>> +			reg =3D <0x05002c00 0x400>;
>> +			interrupts =3D <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =3D <&ccu CLK_BUS_I2C3>;
>> +			resets =3D <&ccu RST_BUS_I2C3>;
>> +			status =3D "disabled";
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <0>;
>> +		};
>> +
>> +		i2c4: i2c@5003000 {
>> +			compatible =3D "allwinner,sun50i-h616-i2c",
>> +				     "allwinner,sun6i-a31-i2c";
>> +			reg =3D <0x05003000 0x400>;
>> +			interrupts =3D <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =3D <&ccu CLK_BUS_I2C4>;
>> +			resets =3D <&ccu RST_BUS_I2C4>;
>> +			status =3D "disabled";
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <0>;
>> +		};
>> +
>> +		spi0: spi@5010000 {
>> +			compatible =3D "allwinner,sun50i-h616-spi",
>> +				     "allwinner,sun8i-h3-spi";
>> +			reg =3D <0x05010000 0x1000>;
>> +			interrupts =3D <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =3D <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
>> +			clock-names =3D "ahb", "mod";
>> +			resets =3D <&ccu RST_BUS_SPI0>;
>> +			pinctrl-names =3D "default";
>> +			pinctrl-0 =3D <&spi0_pins>;
>> +			status =3D "disabled";
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <0>;
>> +		};
>> +
>> +		spi1: spi@5011000 {
>> +			compatible =3D "allwinner,sun50i-h616-spi",
>> +				     "allwinner,sun8i-h3-spi";
>> +			reg =3D <0x05011000 0x1000>;
>> +			interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =3D <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
>> +			clock-names =3D "ahb", "mod";
>> +			resets =3D <&ccu RST_BUS_SPI1>;
>> +			pinctrl-names =3D "default";
>> +			pinctrl-0 =3D <&spi1_pins>;
>> +			status =3D "disabled";
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <0>;
>> +		};
>> +
>> +		emac0: ethernet@5020000 {
>> +			compatible =3D "allwinner,sun50i-h616-emac",
>> +				     "allwinner,sun50i-a64-emac";
>> +			syscon =3D <&syscon>;
>> +			reg =3D <0x05020000 0x10000>;
>> +			interrupts =3D <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names =3D "macirq";
>> +			resets =3D <&ccu RST_BUS_EMAC0>;
>> +			reset-names =3D "stmmaceth";
>> +			clocks =3D <&ccu CLK_BUS_EMAC0>;
>> +			clock-names =3D "stmmaceth";
>> +			status =3D "disabled";
>> +
>> +			mdio: mdio {
>> +				compatible =3D "snps,dwmac-mdio";
>> +				#address-cells =3D <1>;
>> +				#size-cells =3D <0>;
>> +			};
>> +		};
>> +
>> +		usbotg: usb@5100000 {
>> +			compatible =3D "allwinner,sun50i-h616-musb",
>> +				     "allwinner,sun8i-a33-musb";
>> +			reg =3D <0x05100000 0x0400>;
>> +			clocks =3D <&ccu CLK_BUS_OTG>;
>> +			resets =3D <&ccu RST_BUS_OTG>;
>> +			interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names =3D "mc";
>> +			phys =3D <&usbphy 0>;
>> +			phy-names =3D "usb";
>> +			extcon =3D <&usbphy 0>;
>> +			status =3D "disabled";
>> +		};
>> +
>> +		usbphy: phy@5100400 {
>> +			compatible =3D "allwinner,sun50i-h616-usb-phy";
>> +			reg =3D <0x05100400 0x24>,
>> +			      <0x05101800 0x4>,
>> +			      <0x05200800 0x4>,
>> +			      <0x05310800 0x4>,
>> +			      <0x05311800 0x4>;
>> +			reg-names =3D "phy_ctrl",
>> +				    "pmu0",
>> +				    "pmu1",
>> +				    "pmu2",
>> +				    "pmu3";
>> +			clocks =3D <&ccu CLK_USB_PHY0>,
>> +				 <&ccu CLK_USB_PHY1>,
>> +				 <&ccu CLK_USB_PHY2>,
>> +				 <&ccu CLK_USB_PHY3>;
>> +			clock-names =3D "usb0_phy",
>> +				      "usb1_phy",
>> +				      "usb2_phy",
>> +				      "usb3_phy";
>> +			resets =3D <&ccu RST_USB_PHY0>,
>> +				 <&ccu RST_USB_PHY1>,
>> +				 <&ccu RST_USB_PHY2>,
>> +				 <&ccu RST_USB_PHY3>;
>> +			reset-names =3D "usb0_reset",
>> +				      "usb1_reset",
>> +				      "usb2_reset",
>> +				      "usb3_reset";
>> +			status =3D "disabled";
>> +			#phy-cells =3D <1>;
>> +		};
>
>Did you send a patch to support that PHY?
>
>Maxime
