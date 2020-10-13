Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE1428D32E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 19:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388661AbgJMRfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 13:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgJMRfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 13:35:00 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EA6C0613D0;
        Tue, 13 Oct 2020 10:34:58 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id u21so979168eja.2;
        Tue, 13 Oct 2020 10:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uOXLByz02dM7zoLiRH2WAP9+6mmFcRsU4UEbZetpkas=;
        b=iIVOR6hp8Ewl6uBwRGAOp+8rSxLjn+6VJNVfnspFkMRRqOxCykDS5hG5+aWqEXjnQ3
         q62nsaS4g8YJnZQyLeU/2v3t1FWx3v1sEZTacAnfTAMokpym6Rf3IoByAHbEeNz1kma3
         qUAE/x+6Ai07YQO1AaU6GX9LKqpCUlOId9YIu7z06auoUfKd0Pftuqmgfe5dQoykbK3b
         f8RQ3zllb8cWjdgOztgVCPLcDIpQes1TNfpvMVis1n7EhMYH6F+R0q1eOGwjh26Jnnw/
         CwbNo0lRvGhQE5UYnbZJecMFxtT4WyrZasgfehMaaKm+cnSFeQw6kqKKm+IeQB7F1ROg
         YNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uOXLByz02dM7zoLiRH2WAP9+6mmFcRsU4UEbZetpkas=;
        b=oYFuVI7f1TIHwZsCC6Q2oVAMJgxzQby7FO61xBApTMcpeshF/bTLrKDIVUKOBRX+hg
         Kj4336xMUK/mGFGLoe+wdeou15dPJ9KxxtdxTz0lhozH6+V0TC02VBwglelk4O/triHW
         YXeG0Yr5pLkkM/K6YuCvN7UkvCREWmZSceIQsDbJv38cbRAiDuUuVV3bwiBrJsZKWe42
         aWI/TLbpql0bA1OnZt0ktsdzVLK24Vy9b15fe+taCkCkG5S9C1Ry59fmIwuN2ekVRjNe
         kFEMjUOqMd9p61feNtbCGEtkg+QIIVj5Lb+OgzCxnhpR8X7fQeogy4R7tBSINq6NXwys
         kdPA==
X-Gm-Message-State: AOAM532IdE38bbkDYEadJRRvVFtP9HeUkX6XA/pveLgYroipcllQLhta
        jgUGuzVyaQ/s1YcEN8hQF7Lh0E9p664=
X-Google-Smtp-Source: ABdhPJwh8qAmweoh4uJiu/Y6ofmdluXI+w77ZCkaStn9C5D8CWT8BDsAajxLik33n6oLqobAsQrgSw==
X-Received: by 2002:a17:906:5618:: with SMTP id f24mr889002ejq.86.1602610496810;
        Tue, 13 Oct 2020 10:34:56 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id gv10sm332843ejb.46.2020.10.13.10.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 10:34:56 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add basic support for
 Kobol's Helios64
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Aditya Prayoga <aditya@kobol.io>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201013161340.720403-1-uwe@kleine-koenig.org>
 <20201013161340.720403-3-uwe@kleine-koenig.org>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <a3957410-af99-5df4-8953-ffa3e7734aab@gmail.com>
Date:   Tue, 13 Oct 2020 19:34:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201013161340.720403-3-uwe@kleine-koenig.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Uwe,

Part 1 of 2 missing here.
Submit all patches to all maintainers and mail lists.
Don't forget robh+dt !

./scripts/get_maintainer.pl --noroles --norolestats --nogit-fallback
--nogit <patch 1> <patch2>

git send-email --suppress-cc all --annotate --to <..> --cc <..> <patch
1> <patch2>

On 10/13/20 6:13 PM, Uwe Kleine-König wrote:
> The hardware is described in detail on Kobol's wiki at
> https://wiki.kobol.io/helios64/intro/.
> 
> Up to now the following peripherals are working:
> 
>  - UART
>  - Micro-SD card
>  - eMMC
>  - ethernet port 1
>  - status LED
>  - temperature sensor on i2c bus 2
> 
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> ---

Add a little change log here.

>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../dts/rockchip/rk3399-kobol-helios64.dts    | 378 ++++++++++++++++++
>  2 files changed, 379 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index b87b1f773083..ddf07c5e5f7c 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -24,6 +24,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-hugsun-x99.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-khadas-edge.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-khadas-edge-captain.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-khadas-edge-v.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-kobol-helios64.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-leez-p710.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopc-t4.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-m4.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> new file mode 100644
> index 000000000000..98a2bbed8c14
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> @@ -0,0 +1,378 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2020 Aditya Prayoga <aditya@kobol.io>
> + */
> +
> +/*
> + * The Kobol Helios64 is a board designed to operate as a NAS and optionally
> + * ships with an enclosing that can host five 2.5" hard disks.
> + *
> + * See https://wiki.kobol.io/helios64/intro/ for further details.
> + */
> +
> +/dts-v1/;
> +#include "rk3399.dtsi"
> +#include "rk3399-opp.dtsi"
> +
> +/ {
> +	model = "Kobol Helios64";
> +	compatible = "kobol,helios64", "rockchip,rk3399";
> +
> +	avdd_1v8_s0: avdd-1v8-s0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "avdd_1v8_s0";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc3v3_sys_s3>;
> +	};
> +
> +	clkin_gmac: external-gmac-clock {
> +		compatible = "fixed-clock";
> +		clock-frequency = <125000000>;
> +		clock-output-names = "clkin_gmac";
> +		#clock-cells = <0>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&fault_led &status_led>;

sort

> +
> +		fault-led {
fault_led: led-0 {}

My fault.
Change ones more...
  # The first form is preferred, but fall back to just 'led' anywhere in the
  # node name to at least catch some child nodes.
  "(^led-[0-9a-f]$|led)":

> +			label = "helios64:red:fault";
> +			gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
> +			default-state = "keep";
> +		};
> +

> +		status-led {

status_led: led-1 {}

> +			label = "helios64:green:status";
> +			gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;

> +			linux,default-trigger = "none";

Don't use 'none' for mainline.

> +			default-state = "on";
> +		};
> +	};
> +
> +	vcc1v8_sys_s0: vcc1v8-sys-s0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc1v8_sys_s0";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc1v8_sys_s3>;
> +	};
> +
> +	vcc3v0_sd: vcc3v0-sd {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v0_sd";

Doesn't a sd card need a on/off gpio?
Could you check the schematics?

> +		regulator-boot-on;
> +		regulator-min-microvolt = <3000000>;
> +		regulator-max-microvolt = <3000000>;
> +		vin-supply = <&vcc3v3_sys_s3>;
> +	};
> +
> +	vcc3v3_sys_s3: vcc_lan: vcc3v3-sys-s3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys_s3";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc5v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-on-in-suspend;
> +		};
> +	};
> +
> +	vcc5v0_sys: vcc5v0-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc12v_dcin_bkup>;
> +
> +		regulator-state-mem {
> +			regulator-on-in-suspend;
> +		};
> +	};
> +
> +	vcc12v_dcin: vcc12v-dcin {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc12v_dcin";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +	};
> +
> +	vcc12v_dcin_bkup: vcc12v-dcin-bkup {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc12v_dcin_bkup";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		vin-supply = <&vcc12v_dcin>;
> +	};
> +};
> +
> +/*
> + * The system doesn't run stable with cpu freq enabled, so disallow the lower
> + * frequencies until this problem is properly understood and resolved.
> + */
> +&cluster0_opp {
> +        /delete-node/ opp00;
> +        /delete-node/ opp01;
> +        /delete-node/ opp02;
> +        /delete-node/ opp03;
> +        /delete-node/ opp04;
> +};
> +&cluster1_opp {
> +        /delete-node/ opp00;
> +        /delete-node/ opp01;
> +        /delete-node/ opp02;
> +        /delete-node/ opp03;
> +        /delete-node/ opp04;
> +        /delete-node/ opp05;
> +        /delete-node/ opp06;
> +};
> +
> +&cpu_b0 {
> +	cpu-supply = <&vdd_cpu_b>;
> +};
> +
> +&cpu_b1 {
> +	cpu-supply = <&vdd_cpu_b>;
> +};
> +
> +&cpu_l0 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&cpu_l1 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&cpu_l2 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&cpu_l3 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&emmc_phy {
> +	status = "okay";
> +};
> +
> +&gmac {
> +	assigned-clock-parents = <&clkin_gmac>;
> +	assigned-clocks = <&cru SCLK_RMII_SRC>;
> +	clock_in_out = "input";
> +	phy-mode = "rgmii";
> +	phy-supply = <&vcc_lan>;
> +	pinctrl-0 = <&rgmii_pins &rgmii_phy_reset>;
> +	pinctrl-names = "default";
> +	rx_delay = <0x20>;
> +	snps,reset-active-low;
> +	snps,reset-delays-us = <0 10000 50000>;
> +	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> +	tx_delay = <0x28>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	clock-frequency = <400000>;
> +	i2c-scl-falling-time-ns = <4>;
> +	i2c-scl-rising-time-ns = <168>;
> +	status = "okay";
> +
> +	rk808: pmic@1b {
> +		compatible = "rockchip,rk808";
> +		reg = <0x1b>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
> +		clock-output-names = "xin32k", "rk808-clkout2";

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_int_l>;

sort

> +		vcc1-supply = <&vcc5v0_sys>;
> +		vcc2-supply = <&vcc5v0_sys>;
> +		vcc3-supply = <&vcc5v0_sys>;
> +		vcc4-supply = <&vcc5v0_sys>;
> +		vcc6-supply = <&vcc5v0_sys>;
> +		vcc7-supply = <&vcc5v0_sys>;
> +		vcc8-supply = <&vcc3v3_sys_s3>;
> +		vcc9-supply = <&vcc5v0_sys>;
> +		vcc10-supply = <&vcc5v0_sys>;
> +		vcc11-supply = <&vcc5v0_sys>;
> +		vcc12-supply = <&vcc3v3_sys_s3>;
> +		vddio-supply = <&vcc3v0_s3>;
> +		wakeup-source;

> +

remove empty line

> +		#clock-cells = <1>;
> +
> +		regulators {
> +			vdd_cpu_l: DCDC_REG2 {
> +				regulator-name = "vdd_cpu_l";
> +				regulator-always-on;
> +				regulator-boot-on;

> +				regulator-max-microvolt = <1350000>;
> +				regulator-min-microvolt = <750000>;


The rest has min above max.
Exception to the sort rule, not sure what Heiko wants, but keep it every
where the same.


> +				regulator-ramp-delay = <6001>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc1v8_sys_s3: DCDC_REG4 {
> +				regulator-name = "vcc1v8_sys_s3";
> +				regulator-always-on;
> +				regulator-boot-on;

> +				regulator-max-microvolt = <1800000>;
> +				regulator-min-microvolt = <1800000>;

idem

> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vcc_sdio_s0: LDO_REG4 {
> +				regulator-name = "vcc_sdio_s0";
> +				regulator-always-on;
> +				regulator-boot-on;

> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3000000>;

keep

> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3000000>;
> +				};
> +			};
> +
> +			vcc3v0_s3: LDO_REG8 {
> +				regulator-name = "vcc3v0_s3";
> +				regulator-always-on;
> +				regulator-boot-on;

> +				regulator-max-microvolt = <3000000>;
> +				regulator-min-microvolt = <3000000>;

change

> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3000000>;
> +				};
> +			};
> +		};
> +	};
> +
> +	vdd_cpu_b: regulator@40 {
> +		compatible = "silergy,syr827";
> +		reg = <0x40>;
> +		fcs,suspend-voltage-selector = <1>;
> +		pinctrl-0 = <&vsel1_gpio>;
> +		pinctrl-names = "default";
> +		regulator-always-on;
> +		regulator-boot-on;

> +		regulator-max-microvolt = <1500000>;
> +		regulator-min-microvolt = <712500>;

change

> +		regulator-name = "vdd_cpu_b";
> +		regulator-ramp-delay = <1000>;
> +		vin-supply = <&vcc5v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;

> +	i2c-scl-rising-time-ns = <160>;
> +	i2c-scl-falling-time-ns = <30>;

sort

> +	status = "okay";
> +
> +	temp@4c {
> +		compatible = "national,lm75";
> +		reg = <0x4c>;
> +	};
> +};
> +
> +&io_domains {
> +	audio-supply = <&vcc1v8_sys_s0>;
> +	bt656-supply = <&vcc1v8_sys_s0>;
> +	gpio1830-supply = <&vcc3v0_s3>;
> +	sdmmc-supply = <&vcc_sdio_s0>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	gmac {
> +		rgmii_phy_reset: rgmii-phy-reset {
> +			rockchip,pins =

> +				<3 RK_PB7 RK_FUNC_GPIO &pcfg_output_low>;

align on the same line similar to pmic

> +		};
> +	};
> +
> +	leds {
> +		fault_led: fault-led {
> +			rockchip,pins =

> +				<0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_down>;

align

> +		};
> +
> +		status_led: status-led {
> +			rockchip,pins =

> +				<0 RK_PB4 RK_FUNC_GPIO &pcfg_pull_down>,

align

> +		};
> +	};
> +
> +	pmic {
> +		pmic_int_l: pmic-int-l {
> +			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
> +		vsel1_gpio: vsel1-gpio {
> +			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +
> +		vsel2_gpio: vsel2-gpio {
> +			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +	};
> +};
> +
> +&pmu_io_domains {
> +	pmu1830-supply = <&vcc3v0_s3>;
> +	status = "okay";
> +};
> +
> +&sdhci {
> +	bus-width = <8>;

> +	disable-wp;

remove
not used with emmc

> +	mmc-hs200-1_8v;
> +	non-removable;

> +	supports-emmc;

remove
not a valid property for mainline

> +	vqmmc-supply = <&vcc1v8_sys_s0>;
> +	status = "okay";
> +};
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-sd-highspeed;

> +	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;

see regulator?

> +	disable-wp;
> +	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
> +	pinctrl-names = "default";
> +	vmmc-supply = <&vcc3v0_sd>;
> +	vqmmc-supply = <&vcc_sdio_s0>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> 

