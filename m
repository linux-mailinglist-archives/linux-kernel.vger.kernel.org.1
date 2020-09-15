Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F03926B624
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 01:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgIOX6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 19:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgIOObQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:31:16 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579E7C061354
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 07:31:02 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k15so3547274wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 07:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4bDWqRR4guNWJ8Ho3vrLhEw9Ya50FhpCsfHFPYIwDl8=;
        b=EpyIKuYzePngsVJUzKdMDRVcjIdhEwf9oUDdESKwqRuhOPbWQ9d3lIpXMrBqYN5N3M
         ooscz8Apdef0ya5jsJEa8K3lZf/P7iF1tm9Aw2pOQnBsO7NcjpVbpSBW+hIRKV0o90kt
         LgxeJI4VSjuiT2/QWfrbrgSZguL1XOeyIYGctMQxxVdr1OYj0dmKk7ipShFpbRMRgQEO
         IDWIYSd4iGmvfPgq5EzD7Yus7cTy5g1SOTs2eT/43qrZFYlQDGrKUKEiiVVx8Q0c8XbD
         KXchPwkYRD+rd8gGSFzVN7DdAlIIkAB/mi5Wg4tOaUngBra5NUeM9CXfgXiC2Z3XMkkC
         pGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4bDWqRR4guNWJ8Ho3vrLhEw9Ya50FhpCsfHFPYIwDl8=;
        b=L5y710arFBvwfoOsVblz1kqpqUngOPZgyiL2Hiiam8VMPyXt6J85Ka1HEjc+N7Y2kw
         IWkMV3O8SJe2kqx4eTQjWYQ8CY6PWIil3+Lvc+bjePZgga5hYquPlvs5CPlD2aKAAlS4
         QzmBRmBf5BavpX7R2M+ZkzrdSRo0SbHauBeORruaevftzxGBvu9Rbc2Oar+Ap5YIhvGP
         Vh0rQr/0zu8D9qwXNRfSrVWIQCC+PMhZcBst5uYrok82S3FTX67LQd5nUNW0S8MAvd91
         /WnNtlUY6JksC9q57uDQIDELqPiJirboK6FiJZEQ1R49xUk6yCkjzNxsdALegDPI2z/j
         KI4g==
X-Gm-Message-State: AOAM530ltGlHNONdJrVw75A2lLSMK6pL0Tz6QKXzNAuy29dn7xYAjPZ6
        T3J/dJTJnwGpI81glcNlB9OwxuQGYdp5h6fh
X-Google-Smtp-Source: ABdhPJybIzxgXmzTMtpiUHr6Zv9QFOKWroXp1zB70nyycR18bTej4x4TdQnyvP5/aj0LfV7fvdbgNw==
X-Received: by 2002:adf:f78c:: with SMTP id q12mr22141848wrp.6.1600180260100;
        Tue, 15 Sep 2020 07:31:00 -0700 (PDT)
Received: from [192.168.1.23] (home.beaume.starnux.net. [82.236.8.43])
        by smtp.gmail.com with ESMTPSA id v17sm28664710wrc.23.2020.09.15.07.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 07:30:59 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm64: dts: meson: initial support for aml-s905x-cc
 v2
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200915141921.57258-1-jbrunet@baylibre.com>
 <20200915141921.57258-3-jbrunet@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <4f67512c-51c7-77ae-af63-4bdd8867c313@baylibre.com>
Date:   Tue, 15 Sep 2020 16:30:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915141921.57258-3-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/09/2020 16:19, Jerome Brunet wrote:
> Add initial support for the libretech aml-s905x-cc (Le Potato) v2
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/Makefile          |   1 +
>  .../meson-gxl-s905x-libretech-cc-v2.dts       | 318 ++++++++++++++++++
>  2 files changed, 319 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index 4e2239ffcaa5..be5277b7fbf4 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -24,6 +24,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s805x-libretech-ac.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-hwacom-amazetv.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-khadas-vim.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc-v2.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
> new file mode 100644
> index 000000000000..675eaa87963e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
> @@ -0,0 +1,318 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2020 BayLibre, SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/sound/meson-aiu.h>
> +
> +#include "meson-gxl-s905x.dtsi"
> +
> +/ {
> +	compatible = "libretech,aml-s905x-cc-v2", "amlogic,s905x",
> +		     "amlogic,meson-gxl";
> +	model = "Libre Computer AML-S905X-CC V2";
> +
> +	aliases {
> +		serial0 = &uart_AO;
> +		ethernet0 = &ethmac;
> +		spi0 = &spifc;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	emmc_pwrseq: emmc-pwrseq {
> +		compatible = "mmc-pwrseq-emmc";
> +		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&hdmi_tx_tmds_out>;
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-blue {
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_STATUS;
> +			gpios = <&gpio GPIODV_24 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +			panic-indicator;
> +		};
> +
> +		led-green {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_DISK_ACTIVITY;
> +			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "disk-activity";
> +		};
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x80000000>;
> +	};
> +
> +	ao_5v: regulator-ao_5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "AO_5V";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&dc_in>;
> +		regulator-always-on;
> +	};
> +
> +	dc_in: regulator-dc_in {
> +		compatible = "regulator-fixed";
> +		regulator-name = "DC_IN";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +
> +	vcck: regulator-vcck {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCCK";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&ao_5v>;
> +		regulator-always-on;
> +	};
> +
> +	vcc_card: regulator-vcc_card {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_CARD";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vddio_ao3v3>;
> +
> +		gpio = <&gpio GPIOCLK_1 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	vcc5v: regulator-vcc5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC5V";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&ao_5v>;
> +
> +		gpio = <&gpio GPIOH_3 GPIO_OPEN_DRAIN>;
> +	};
> +
> +	vddio_ao3v3: regulator-vddio_ao3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDIO_AO3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&ao_5v>;
> +		regulator-always-on;
> +	};
> +
> +
> +	vddio_card: regulator-vddio-card {
> +		compatible = "regulator-gpio";
> +		regulator-name = "VDDIO_CARD";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
> +		gpios-states = <0>;
> +
> +		states = <3300000 0>,
> +			 <1800000 1>;
> +
> +		regulator-settling-time-up-us = <200>;
> +		regulator-settling-time-down-us = <50000>;
> +	};
> +
> +	vddio_ao18: regulator-vddio_ao18 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDIO_AO18";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vddio_ao3v3>;
> +		regulator-always-on;
> +	};
> +
> +	vcc_1v8: regulator-vcc_1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC 1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vddio_ao3v3>;
> +		regulator-always-on;
> +	};
> +
> +	sound {
> +		compatible = "amlogic,gx-sound-card";
> +		model = "GXL-LIBRETECH-S905X-CC-V2";
> +		assigned-clocks = <&clkc CLKID_MPLL0>,
> +				  <&clkc CLKID_MPLL1>,
> +				  <&clkc CLKID_MPLL2>;
> +		assigned-clock-parents = <0>, <0>, <0>;
> +		assigned-clock-rates = <294912000>,
> +				       <270950400>,
> +				       <393216000>;
> +		status = "okay";
> +
> +		dai-link-0 {
> +			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
> +		};
> +
> +		dai-link-1 {
> +			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
> +			dai-format = "i2s";
> +			mclk-fs = <256>;
> +
> +			codec-0 {
> +				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
> +			};
> +		};
> +
> +		dai-link-2 {
> +			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
> +
> +			codec-0 {
> +				sound-dai = <&hdmi_tx>;
> +			};
> +		};
> +	};
> +};
> +
> +
> +&aiu {
> +	status = "okay";
> +};
> +
> +&cec_AO {
> +	status = "okay";
> +	pinctrl-0 = <&ao_cec_pins>;
> +	pinctrl-names = "default";
> +	hdmi-phandle = <&hdmi_tx>;
> +};
> +
> +
> +&ethmac {
> +	status = "okay";
> +};
> +
> +&internal_phy {
> +	pinctrl-0 = <&eth_link_led_pins>, <&eth_act_led_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&ir {
> +	status = "okay";
> +	pinctrl-0 = <&remote_input_ao_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&hdmi_tx {
> +	status = "okay";
> +	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
> +	hdmi-supply = <&vcc5v>;
> +	pinctrl-names = "default";
> +};
> +
> +&hdmi_tx_tmds_port {
> +	hdmi_tx_tmds_out: endpoint {
> +		remote-endpoint = <&hdmi_connector_in>;
> +	};
> +};
> +
> +&saradc {
> +	status = "okay";
> +	vref-supply = <&vddio_ao18>;
> +};
> +
> +/* SD card */
> +&sd_emmc_b {
> +	pinctrl-0 = <&sdcard_pins>;
> +	pinctrl-1 = <&sdcard_clk_gate_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-ddr50;
> +	max-frequency = <100000000>;
> +	disable-wp;
> +
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
> +
> +	vmmc-supply = <&vcc_card>;
> +	vqmmc-supply = <&vddio_card>;
> +
> +	status = "okay";
> +};
> +
> +/* eMMC */
> +&sd_emmc_c {
> +	pinctrl-0 = <&emmc_pins>;
> +	pinctrl-1 = <&emmc_clk_gate_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	max-frequency = <200000000>;
> +	disable-wp;
> +
> +	mmc-pwrseq = <&emmc_pwrseq>;
> +	vmmc-supply = <&vddio_ao3v3>;
> +	vqmmc-supply = <&vcc_1v8>;
> +
> +	status = "okay";
> +};
> +
> +&spifc {
> +	status = "okay";
> +	pinctrl-0 = <&nor_pins>;
> +	pinctrl-names = "default";
> +
> +	nor_4u1: spi-flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <3000000>;
> +	};
> +};
> +
> +&uart_AO {
> +	status = "okay";
> +	pinctrl-0 = <&uart_ao_a_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&usb {
> +	status = "okay";
> +	dr_mode = "host";
> +};
> +
> +&usb2_phy0 {
> +	pinctrl-names = "default";
> +	phy-supply = <&vcc5v>;
> +};
> +
> +&usb2_phy1 {
> +	phy-supply = <&vcc5v>;
> +};
> 

I'm pretty sure most of this can be shared with the v1 via a common dtsi,
with only the differences this v2 dts (spifc, and ?).

Neil
