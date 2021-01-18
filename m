Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9ECC2F98B7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 05:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbhAREhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 23:37:08 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:40411 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726350AbhAREhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 23:37:05 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id C8D9B58064E;
        Sun, 17 Jan 2021 23:35:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 17 Jan 2021 23:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=X
        6Q9g950Zhi6HU46wnQdYzPPJswj+bU97JbEY3M3gyA=; b=TIt1eI9WV38590uK2
        q0LMYbLe7iIzlEJVctt8rbtpbFJnmrqvIM5C6W2W+BgjjOI9bVcfIcwvmjISlVw1
        xIayLwABTfztRwM5g/9KWq9V3LxeX5FHJldYYIraRY1K2YsVtYD3thH3zOPanxXb
        tFSengxMBZwMt4u6IHjokorUw2fiViiZobncvMlJws7EaBC4jGzGARL0UW/p1T9e
        vdi6fYJBsZR0jP+KRUOSYS963Mr2yAKH8+8L7kXZhkUXyQCZUNu5sjXYw+vlS0UT
        OhCeoO0RUIsbKSM6jS/3fHGeh5fzpGGgfKSyDs8KeJC7IHJ3cK8xgDwiF9udP4nf
        Sv3Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=X6Q9g950Zhi6HU46wnQdYzPPJswj+bU97JbEY3M3g
        yA=; b=lmEIiOSz6hm60nW7PbWe9jjYcBHRhEppz9vs7dKPJ5bomFwMma8CkxsHs
        PP5YDb11QA8KErUrg1hm0RgO/yR9RjDcRSo8E1AreBnUqfqbayYyrt68ZznsCKx5
        0MT2ehP1Hj9M6LVnN+KWIaWT1mHW/oj7abafEP8sR5fYTdyrnLttRZczxZ4D1koM
        Zkcykpzy/t34LptW9cX4QxQxux5PTBspxFfmKiYE8ZeXFbimgauKGxLuB+VtJSfH
        iujpjqUJUYQPqLbJ0SU3klvRpzxlt86gPA8BDCO85lCPwJ0keAWBu0lWfDowrge8
        FI82fu1iY2v3wI6pZE7yWfY3SSCzA==
X-ME-Sender: <xms:LRAFYDC42_BY1vybCMiidiXNRLJntwIuxjgSkvo4FRnvXLRIZqRKUw>
    <xme:LRAFYEGaMs8zx7L2al7OmHFwUEaAzH0aF8POPsC7T26DxYl3dRS5jfwCGsKeIVWd4
    wsFbE0sojSDdOntGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdejgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefvfhfhuffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeeuhfffgeetgeekjedugeekieffgfejffffjeeltedtuedvgefgheel
    heejveevieenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeejtddrudefhe
    drudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:LRAFYLIhLhoZSr47GHrGNOznFNqflNq0tJIxh29amlXbrOIqyqYqHA>
    <xmx:LRAFYIl6Q7Hrb1BwPnZFLZnC4KV_yURmVvXi0eW2vDgn4ytv_9wCSQ>
    <xmx:LRAFYDSQtCxO-cgoNGrp2VZ1GWl7mf4vPXdGrxYWsMuM2xX14-qzxw>
    <xmx:LhAFYCGpplbBRXv8-2Ei52mDl_s46ALX06Tx5gQLtrDDY9AgpnM2NQ>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 46FFA1080059;
        Sun, 17 Jan 2021 23:35:57 -0500 (EST)
To:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, devicetree@vger.kernel.org
References: <20210118020848.11721-1-andre.przywara@arm.com>
 <20210118020848.11721-20-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 19/21] arm64: dts: allwinner: Add Allwinner H616 .dtsi
 file
Message-ID: <5a1112e8-af77-9000-f3ff-7e7df0b4c3d8@sholland.org>
Date:   Sun, 17 Jan 2021 22:35:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210118020848.11721-20-andre.przywara@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/21 8:08 PM, Andre Przywara wrote:
> This (relatively) new SoC is similar to the H6, but drops the (broken)
> PCIe support and the USB 3.0 controller. It also gets the management
> controller removed, which in turn removes *some*, but not all of the
> devices formerly dedicated to the ARISC (CPUS).
> There does not seem to be an extra interrupt controller anymore, also
> it lacks the corresponding NMI pin, so no interrupts for the PMIC.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 750 ++++++++++++++++++
>  1 file changed, 750 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> new file mode 100644
> index 000000000000..953e8fac20f0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> @@ -0,0 +1,750 @@
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
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <0>;
> +			enable-method = "psci";
> +			clocks = <&ccu CLK_CPUX>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <1>;
> +			enable-method = "psci";
> +			clocks = <&ccu CLK_CPUX>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <2>;
> +			enable-method = "psci";
> +			clocks = <&ccu CLK_CPUX>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <3>;
> +			enable-method = "psci";
> +			clocks = <&ccu CLK_CPUX>;
> +		};
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* 512KiB reserved for ARM Trusted Firmware (BL31) */
> +		secmon_reserved: secmon@40000000 {
> +			reg = <0x0 0x40000000 0x0 0x80000>;
> +			no-map;
> +		};
> +	};
> +
> +	osc24M: osc24M_clk {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		clock-output-names = "osc24M";
> +	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a53-pmu";
> +		interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		arm,no-tick-in-suspend;
> +		interrupts = <GIC_PPI 13
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
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0x0 0x40000000>;
> +
> +		syscon: syscon@3000000 {
> +			compatible = "allwinner,sun50i-h616-system-control";
> +			reg = <0x03000000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			sram_c: sram@28000 {
> +				compatible = "mmio-sram";
> +				reg = <0x00028000 0x30000>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0x00028000 0x30000>;
> +			};
> +		};
> +
> +		ccu: clock@3001000 {
> +			compatible = "allwinner,sun50i-h616-ccu";
> +			reg = <0x03001000 0x1000>;
> +			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>;
> +			clock-names = "hosc", "losc", "iosc";
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +		};
> +
> +		watchdog: watchdog@30090a0 {
> +			compatible = "allwinner,sun50i-h616-wdt",
> +				     "allwinner,sun6i-a31-wdt";
> +			reg = <0x030090a0 0x20>;
> +			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc24M>;
> +			status = "disabled";

Why is this disabled? Is it broken like the H6?

> +		};
> +
[...]
> +		rtc: rtc@7000000 {
> +			compatible = "allwinner,sun50i-h616-rtc",
> +				     "allwinner,sun50i-h6-rtc";
> +			reg = <0x07000000 0x400>;
> +			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-output-names = "osc32k", "osc32k-out", "iosc";
> +			#clock-cells = <1>;
> +		};
> +
> +		r_ccu: clock@7010000 {
> +			compatible = "allwinner,sun50i-h616-r-ccu";
> +			reg = <0x07010000 0x400>;

This range overlaps the NMI controller[1] at 0x07010320, which I
verified does exist. I don't know what it is connected to, since there
is no NMI pin. Maybe the ATE/AC200?

I suggest reducing the size to 0x210, since 0x20c is the highest
clock-gate-related register.

Cheers,
Samuel

[1]
https://github.com/orangepi-xunlong/linux-orangepi/blob/orange-pi-4.9-sun50iw9/arch/arm64/boot/dts/sunxi/sun50iw9p1.dtsi#L358

> +			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>,
> +				 <&ccu CLK_PLL_PERIPH0>;
> +			clock-names = "hosc", "losc", "iosc", "pll-periph";
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +		};
> +
> +		r_pio: pinctrl@7022000 {
> +			compatible = "allwinner,sun50i-h616-r-pinctrl";
> +			reg = <0x07022000 0x400>;
> +			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&r_ccu CLK_R_APB1>, <&osc24M>, <&rtc 0>;
> +			clock-names = "apb", "hosc", "losc";
> +			gpio-controller;
> +			#gpio-cells = <3>;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +
> +			r_i2c_pins: r-i2c-pins {
> +				pins = "PL0", "PL1";
> +				function = "s_i2c";
> +			};
> +
> +			r_rsb_pins: r-rsb-pins {
> +				pins = "PL0", "PL1";
> +				function = "s_rsb";
> +			};
> +		};
> +
> +		ir: ir@7040000 {
> +				compatible = "allwinner,sun50i-h616-ir",
> +					     "allwinner,sun6i-a31-ir";
> +				reg = <0x07040000 0x400>;
> +				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&r_ccu CLK_R_APB1_IR>,
> +					 <&r_ccu CLK_IR>;
> +				clock-names = "apb", "ir";
> +				resets = <&r_ccu RST_R_APB1_IR>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&ir_rx_pin>;
> +				status = "disabled";
> +		};
> +
> +		r_i2c: i2c@7081400 {
> +			compatible = "allwinner,sun50i-h616-i2c",
> +				     "allwinner,sun6i-a31-i2c";
> +			reg = <0x07081400 0x400>;
> +			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&r_ccu CLK_R_APB2_I2C>;
> +			resets = <&r_ccu RST_R_APB2_I2C>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		r_rsb: rsb@7083000 {
> +			compatible = "allwinner,sun50i-h616-rsb",
> +				     "allwinner,sun8i-a23-rsb";
> +			reg = <0x07083000 0x400>;
> +			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&r_ccu CLK_R_APB2_RSB>;
> +			clock-frequency = <3000000>;
> +			resets = <&r_ccu RST_R_APB2_RSB>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&r_rsb_pins>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +};
> 

