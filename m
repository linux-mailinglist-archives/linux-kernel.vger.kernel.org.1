Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD87023B4F0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 08:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgHDGQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 02:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgHDGQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:16:56 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125A0C061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 23:16:56 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id p1so22273089pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 23:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BQxJ0YUEkUrOH8elixr/LeYRVCMI3lZYKouIJxlT1ww=;
        b=Kp/clz9Ji/MSr0gPKB0VoVp+6il4plIqHCuLIFHeKdv2qd8wl5gAianRAmJ84nm6nw
         7Bd46F1j1tAwKRUjRIujnPkjMU0iRJNavuQd35YadrDkM4RFTtJLhl2CN/IwjcE01Zql
         ljjiPKgdIX3OdCaBEnd4lGSvrpthubixglVVzzdFQWmN1BXnm14/Bg/KAo/geLUv0zyu
         DUOTcsfrWO+kTDsNwOEfPdzftlLdccN3LExA/97bf6+kdgstMeHCQhRfJ8rNGxWi5VCG
         Qe5uUf1M/SUNI1pMMoiELWJDsss1uurQzknPSNrxGdaGOCz+YjO2Ly+hm/uwIO/4ZelH
         z+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BQxJ0YUEkUrOH8elixr/LeYRVCMI3lZYKouIJxlT1ww=;
        b=WMfpOnEgA8oH7P3Mqy0ftYnarrBESbvUgVvNd3RISznR1Z8S51xUZuX+vdfYSWO0Ik
         BagCPxJcBHLYPMgoRMGkfbBEqpb/sU2G97FWMfOLRaMawWT46iL1TK1bHlIhjPrzCd4S
         V50ciJ6gXa48n3e2xQvWaaLLM5fqRl4HHYXfsaFrYz3niOMIm0ljnfENNuKpRMl8P3hX
         elo66+QZ5ZFppjs4mWs5CstJFjffo7w1m5kufOaJU027o3/nha3KgZCJ3Eq7u5UAPCq8
         BDdeB2hrhRPY1UBQjcz9k5wUypMQ1SKLxL2D36e4+otOVIrA/Jd8Zuk6AhS8L6Uu9772
         HQeg==
X-Gm-Message-State: AOAM533vQyKPX+9ZAYJ72TVSnDDoLVns0BvWBV83H9ZFSMoDIh31KVzA
        BfARXYMX3wcKzrByoX2puw11uXkbb4I=
X-Google-Smtp-Source: ABdhPJw2cGTlB+eY9UVS49MTVDQTBYFtP15HBcGvkz2rjQaTTIt82GhHSGnPo6hVDvyVJJ6qhbGvow==
X-Received: by 2002:a17:902:7fcb:: with SMTP id t11mr8092847plb.266.1596521815373;
        Mon, 03 Aug 2020 23:16:55 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j4sm20537046pgk.4.2020.08.03.23.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 23:16:54 -0700 (PDT)
Date:   Mon, 3 Aug 2020 23:16:52 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] arm64: dts: qcom: Add support for Xiaomi Poco F1
 (Beryllium)
Message-ID: <20200804061652.GK61202@yoga>
References: <1596297341-13549-1-git-send-email-amit.pundir@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596297341-13549-1-git-send-email-amit.pundir@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 01 Aug 08:55 PDT 2020, Amit Pundir wrote:

> Add initial dts support for Xiaomi Poco F1 (Beryllium).
> 
> This initial support is based on upstream Dragonboard 845c
> (sdm845) device. With this dts, Beryllium boots AOSP up to
> ADB shell over USB-C.
> 
> Supported functionality includes UFS, USB-C (peripheral),
> microSD card and Vol+/Vol-/power keys. Bluetooth should work
> too but couldn't be verified from adb command line, it is
> verified when enabled from UI with few WIP display patches.
> 
> Just like initial db845c support, initializing the SMMU is
> clearing the mapping used for the splash screen framebuffer,
> which causes the device to hang during boot and recovery
> needs a hard power reset. This can be worked around using:
> 
>     fastboot oem select-display-panel none
> 
> To switch ON the display back run:
> 
>     fastboot oem select-display-panel
> 
> But this only works on Beryllium devices running bootloader
> version BOOT.XF.2.0-00369-SDM845LZB-1 that shipped with
> Android-9 based release. Newer bootloader version do not
> support switching OFF the display panel at all. So we need
> a few additional smmu patches (under review) from here to
> boot to shell:
> https://github.com/pundiramit/linux/commits/beryllium-mainline
> 
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
> v3: Added a reserved-memory region from downstream kernel to fix
>     a boot regression with recent dma-pool changes in v5.8-rc6.
> v2: Updated machine compatible string for seemingly inevitable
>     future quirks.
> 
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  arch/arm64/boot/dts/qcom/sdm845-beryllium.dts | 331 ++++++++++++++++++++++++++
>  2 files changed, 332 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-beryllium.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 0f2c33d611df..3ef1b48bc0cb 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -21,6 +21,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-beryllium.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-mtp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-beryllium.dts
> new file mode 100644
> index 000000000000..af66459712fe
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-beryllium.dts
> @@ -0,0 +1,331 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "sdm845.dtsi"
> +#include "pm8998.dtsi"
> +#include "pmi8998.dtsi"
> +
> +/ {
> +	model = "Xiaomi Technologies Inc. Beryllium";
> +	compatible = "xiaomi,beryllium", "qcom,sdm845";
> +
> +	/* required for bootloader to select correct board */
> +	qcom,board-id = <69 0>;
> +	qcom,msm-id = <321 0x20001>;
> +
> +	aliases {
> +		hsuart0 = &uart6;
> +	};
> +
> +	dc12v: dc12v-regulator {

This is a phone, it doesn't have a 12V DC jack. So while I don't know
the exact power grid for this device, this node shouldn't be here.

> +		compatible = "regulator-fixed";
> +		regulator-name = "DC12V";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		regulator-always-on;
> +	};
> +
> +	gpio_keys {

y/_/-/

> +		compatible = "gpio-keys";
> +		autorepeat;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vol_up_pin_a>;
> +
> +		vol-up {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	vbat: vbat-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VBAT";
> +
> +		vin-supply = <&dc12v>;
> +		regulator-min-microvolt = <4200000>;
> +		regulator-max-microvolt = <4200000>;
> +		regulator-always-on;
> +	};
> +
> +	vbat_som: vbat-som-regulator {

This is specific to db845c, with its power grid split between the main
board and the SOM. Please omit.

> +		compatible = "regulator-fixed";
> +		regulator-name = "VBAT_SOM";
> +
> +		vin-supply = <&dc12v>;
> +		regulator-min-microvolt = <4200000>;
> +		regulator-max-microvolt = <4200000>;
> +		regulator-always-on;
> +	};
> +
> +	vdc_3v3: vdc-3v3-regulator {

This is probably not on the Poco and it's not referenced, please remove.

> +		compatible = "regulator-fixed";
> +		regulator-name = "VDC_3V3";
> +		vin-supply = <&dc12v>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	vdc_5v: vdc-5v-regulator {

Ditto.

> +		compatible = "regulator-fixed";
> +		regulator-name = "VDC_5V";
> +
> +		vin-supply = <&dc12v>;
> +		regulator-min-microvolt = <500000>;
> +		regulator-max-microvolt = <500000>;
> +		regulator-always-on;
> +	};
> +
> +	vreg_s4a_1p8: vreg-s4a-1p8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_s4a_1p8";
> +
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +	};
> +};
> +
> +&apps_rsc {
> +	pm8998-rpmh-regulators {
> +		compatible = "qcom,pm8998-rpmh-regulators";
> +		qcom,pmic-id = "a";
> +
> +		vreg_l1a_0p875: ldo1 {
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7a_1p8: ldo7 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l12a_1p8: ldo12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l13a_2p95: ldo13 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l17a_1p3: ldo17 {
> +			regulator-min-microvolt = <1304000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l20a_2p95: ldo20 {
> +			regulator-min-microvolt = <2960000>;
> +			regulator-max-microvolt = <2968000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l21a_2p95: ldo21 {
> +			regulator-min-microvolt = <2960000>;
> +			regulator-max-microvolt = <2968000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l24a_3p075: ldo24 {
> +			regulator-min-microvolt = <3088000>;
> +			regulator-max-microvolt = <3088000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l25a_3p3: ldo25 {
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3312000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l26a_1p2: ldo26 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +};
> +
> +&gcc {
> +	protected-clocks = <GCC_QSPI_CORE_CLK>,
> +			   <GCC_QSPI_CORE_CLK_SRC>,
> +			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>;
> +};
> +
> +/* Reserved memory changes from downstream */
> +/ {
> +	reserved-memory {
> +		removed_region: memory@88f00000 {

Do you know what these 26MB are used for? Do you think it's possible to
give it a more appropriate label? The size happens to be the same as
&adsp_mem from sdm845.dtsi, this is probably not a coincidence.

That said, this overlaps at least &rmtfs_mem, &qseecom_mem and
&camera_mem, so I would expect that you have a few warnings about this
early in the log? Please shuffle things around to avoid this.

> +			no-map;
> +			reg = <0 0x88f00000 0 0x1A00000>;

Please lowercase the 'A'

Regards,
Bjorn

> +		};
> +	};
> +};
> +
> +&pm8998_gpio {
> +	vol_up_pin_a: vol-up-active {
> +		pins = "gpio6";
> +		function = "normal";
> +		input-enable;
> +		bias-pull-up;
> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
> +	};
> +};
> +
> +&pm8998_pon {
> +	resin {
> +		compatible = "qcom,pm8941-resin";
> +		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> +		debounce = <15625>;
> +		bias-pull-up;
> +		linux,code = <KEY_VOLUMEDOWN>;
> +	};
> +};
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdc2_default_state &sdc2_card_det_n>;
> +
> +	vmmc-supply = <&vreg_l21a_2p95>;
> +	vqmmc-supply = <&vreg_l13a_2p95>;
> +
> +	bus-width = <4>;
> +	cd-gpios = <&tlmm 126 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <81 4>;
> +
> +	sdc2_default_state: sdc2-default {
> +		clk {
> +			pins = "sdc2_clk";
> +			bias-disable;
> +
> +			/*
> +			 * It seems that mmc_test reports errors if drive
> +			 * strength is not 16 on clk, cmd, and data pins.
> +			 */
> +			drive-strength = <16>;
> +		};
> +
> +		cmd {
> +			pins = "sdc2_cmd";
> +			bias-pull-up;
> +			drive-strength = <10>;
> +		};
> +
> +		data {
> +			pins = "sdc2_data";
> +			bias-pull-up;
> +			drive-strength = <10>;
> +		};
> +	};
> +
> +	sdc2_card_det_n: sd-card-det-n {
> +		pins = "gpio126";
> +		function = "gpio";
> +		bias-pull-up;
> +	};
> +};
> +
> +&uart6 {
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "qcom,wcn3990-bt";
> +
> +		vddio-supply = <&vreg_s4a_1p8>;
> +		vddxo-supply = <&vreg_l7a_1p8>;
> +		vddrf-supply = <&vreg_l17a_1p3>;
> +		vddch0-supply = <&vreg_l25a_3p3>;
> +		max-speed = <3200000>;
> +	};
> +};
> +
> +&usb_1 {
> +	status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +	dr_mode = "peripheral";
> +};
> +
> +&usb_1_hsphy {
> +	status = "okay";
> +
> +	vdd-supply = <&vreg_l1a_0p875>;
> +	vdda-pll-supply = <&vreg_l12a_1p8>;
> +	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
> +
> +	qcom,imp-res-offset-value = <8>;
> +	qcom,hstx-trim-value = <QUSB2_V2_HSTX_TRIM_21_6_MA>;
> +	qcom,preemphasis-level = <QUSB2_V2_PREEMPHASIS_5_PERCENT>;
> +	qcom,preemphasis-width = <QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT>;
> +};
> +
> +&usb_1_qmpphy {
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l26a_1p2>;
> +	vdda-pll-supply = <&vreg_l1a_0p875>;
> +};
> +
> +&ufs_mem_hc {
> +	status = "okay";
> +
> +	reset-gpios = <&tlmm 150 GPIO_ACTIVE_LOW>;
> +
> +	vcc-supply = <&vreg_l20a_2p95>;
> +	vcc-max-microamp = <800000>;
> +};
> +
> +&ufs_mem_phy {
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l1a_0p875>;
> +	vdda-pll-supply = <&vreg_l26a_1p2>;
> +};
> +
> +/* PINCTRL - additions to nodes defined in sdm845.dtsi */
> +
> +&qup_uart6_default {
> +	pinmux {
> +		pins = "gpio45", "gpio46", "gpio47", "gpio48";
> +		function = "qup6";
> +	};
> +
> +	cts {
> +		pins = "gpio45";
> +		bias-disable;
> +	};
> +
> +	rts-tx {
> +		pins = "gpio46", "gpio47";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	rx {
> +		pins = "gpio48";
> +		bias-pull-up;
> +	};
> +};
> -- 
> 2.7.4
> 
