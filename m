Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4542D04EC
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 13:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgLFMwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 07:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbgLFMwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 07:52:10 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF709C0613D1;
        Sun,  6 Dec 2020 04:51:29 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id b8so9604201ila.13;
        Sun, 06 Dec 2020 04:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKs7seglcNvWrGGZk1yQt+ute+GxuJT5pzosp6rKB6A=;
        b=UNMyi1W3vHRR/t1eB/S0VLQhgFEun53tkV7FQyeIYzoIaGsKbdPEK+pGh9crwn7Oq3
         34l4rS5QUGk4OG+Mn2OFHojMcdeAZqV2nto7H0RPSxYd9SK625jnprf9s6JUGN6gybxU
         sSPlfgxKImPHiY+iR5VKZceQMkFWwQm85HjitqELvZPNw1eq9t4B/MZhXtxGwG1EIdyZ
         3CwCfOJEAVdqcNoXRaxRq0IlvxVH/JnBV0ez6b2H4DrdEafxl1jC/WrUML7BgI9TYsWa
         i6VfmVh4YZApbsK6yaJKxCHv6aBeH8TnKoE/NPmYk6/D/1x35JAHQlAp340ZQpi5LO1l
         9Ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKs7seglcNvWrGGZk1yQt+ute+GxuJT5pzosp6rKB6A=;
        b=IT1MSWHA7AWzBhE9ARa+UI0uQZ6NkGwBIjewtV8aOIQkqjdz+GJtcvEkn6pvp9vIFa
         D8N1rdcndHpAhKvA2Cn96teLg8Buy62tntg1Hk1aeJoHxYQqorGQVnpMoxrHCQsW7q2G
         G8lOBlCQFiov5/LfLOQSVO51xp+2ybOkwMisxaBLImWL2F7g0NXUFJlMSe0HJVycOPtx
         27b7nBRUXNFOmrsK8vP/4DVL20vzjVP6leYUDXSD/7DInap7AybyF+ll5pwbB2F4sZGF
         +igKXZHvvbJ5xcaPUOEFAVd6agvXKWY4tkpXw4cqbf1L/5GcUNkA2QLG1kjCZofZaNh3
         Rflg==
X-Gm-Message-State: AOAM531pBK0NUSa1GFhZgRnaQbdxeg4RFup1BqVfwIad/ypBE1EzMQwQ
        2RXXoPEuWKVma17Mj5lt+IxfRn+q3tsiYA5rRgo=
X-Google-Smtp-Source: ABdhPJz0Jx5WReBzNxbnsGO/dkj427/vMXgX1E5Qe2dY/PLJskRiD/+LidW5L1qlIV3gf95SgUDaRA7EgrDTlbqYtaI=
X-Received: by 2002:a92:5:: with SMTP id 5mr15610902ila.150.1607259088992;
 Sun, 06 Dec 2020 04:51:28 -0800 (PST)
MIME-Version: 1.0
References: <20201202135409.13683-1-andre.przywara@arm.com> <20201202135409.13683-9-andre.przywara@arm.com>
In-Reply-To: <20201202135409.13683-9-andre.przywara@arm.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 6 Dec 2020 13:51:15 +0100
Message-ID: <CAJiuCcfbeOBAT9AL-B8t3Zv4evmJ1HchYjGVCFiycLSjEghs0A@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 8/8] arm64: dts: allwinner: Add OrangePi
 Zero 2 .dts
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On Wed, 2 Dec 2020 at 14:54, Andre Przywara <andre.przywara@arm.com> wrote:
>
> The OrangePi Zero 2 is a development board with the new H616 SoC.
>
> It features the usual connectors used on those small boards, and comes
> with the AXP305, which seems to be compatible with the AXP805.
>
> For more details see: http://linux-sunxi.org/Xunlong_Orange_Pi_Zero2
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../allwinner/sun50i-h616-orangepi-zero2.dts  | 228 ++++++++++++++++++
>  2 files changed, 229 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
>
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> index 211d1e9d4701..0cf8299b1ce7 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -35,3 +35,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> new file mode 100644
> index 000000000000..814f5b4fec7c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> @@ -0,0 +1,228 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2020 Arm Ltd.
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +       model = "OrangePi Zero2";
> +       compatible = "xunlong,orangepi-zero2", "allwinner,sun50i-h616";

You need to add this compatible to the sunxi.yaml boards list

> +
> +       aliases {
> +               ethernet0 = &emac0;
> +               serial0 = &uart0;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               power {
> +                       label = "orangepi:red:power";

label is deprecated
function = LED_FUNCTION_POWER;
color = <LED_COLOR_ID_RED>;

> +                       gpios = <&pio 2 13 GPIO_ACTIVE_HIGH>; /* PC13 */
> +                       default-state = "on";
> +               };
> +
> +               status {
> +                       label = "orangepi:green:status";

same here
function = LED_FUNCTION_STATUS;
color = <LED_COLOR_ID_GREEN>;

> +                       gpios = <&pio 2 12 GPIO_ACTIVE_HIGH>; /* PC12 */
> +               };
> +       };
> +
> +       reg_vcc5v: vcc5v {
> +               /* board wide 5V supply directly from the USB-C socket */
> +               compatible = "regulator-fixed";
> +               regulator-name = "vcc-5v";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               regulator-always-on;
> +       };
> +
> +       reg_usb1_vbus: usb1-vbus {
> +               compatible = "regulator-fixed";
> +               regulator-name = "usb1-vbus";

Could you add reg_vcc5v as vin-supply.
This doesn't change anything but will be a better description of the HW.

> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               enable-active-high;
> +               gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>; /* PC16 */
> +               status = "okay";
> +       };
> +};
> +
> +&ehci0 {
> +       status = "okay";
> +};
> +
> +&ehci1 {
> +       status = "okay";
> +};
> +
> +/* USB 2 & 3 are on headers only. */
> +
> +&emac0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&ext_rgmii_pins>;
> +       phy-mode = "rgmii";
> +       phy-handle = <&ext_rgmii_phy>;
> +       phy-supply = <&reg_dcdce>;
> +       allwinner,rx-delay-ps = <3100>;
> +       allwinner,tx-delay-ps = <700>;
> +       status = "okay";
> +};
> +
> +&mdio {
> +       ext_rgmii_phy: ethernet-phy@1 {
> +               compatible = "ethernet-phy-ieee802.3-c22";
> +               reg = <1>;
> +       };
> +};
> +
> +&mmc0 {
> +       vmmc-supply = <&reg_dcdce>;
> +       cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;  /* PF6 */
> +       bus-width = <4>;
> +       status = "okay";
> +};
> +
> +&ohci0 {
> +       status = "okay";
> +};
> +
> +&ohci1 {
> +       status = "okay";
> +};
> +
> +&r_i2c {
> +       status = "okay";
> +
> +       axp305: pmic@36 {
> +               compatible = "x-powers,axp305", "x-powers,axp805",
> +                            "x-powers,axp806";
> +               reg = <0x36>;
> +
> +               /* dummy interrupt to appease the driver for now */
> +               interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> +               interrupt-controller;
> +               #interrupt-cells = <1>;
> +
> +               x-powers,self-working-mode;
> +               vina-supply = <&reg_vcc5v>;
> +               vinb-supply = <&reg_vcc5v>;
> +               vinc-supply = <&reg_vcc5v>;
> +               vind-supply = <&reg_vcc5v>;
> +               vine-supply = <&reg_vcc5v>;
> +               aldoin-supply = <&reg_vcc5v>;
> +               bldoin-supply = <&reg_vcc5v>;
> +               cldoin-supply = <&reg_vcc5v>;
> +
> +               regulators {
> +                       reg_aldo1: aldo1 {
> +                               regulator-always-on;
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-name = "vcc-sys";
> +                       };
> +
> +                       reg_aldo2: aldo2 {
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-name = "vcc3v3-ext";
> +                       };
> +
> +                       reg_aldo3: aldo3 {
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-name = "vcc3v3-ext2";
> +                       };
> +
> +                       reg_bldo1: bldo1 {
> +                               regulator-always-on;
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-name = "vcc1v8";
> +                       };
> +
> +                       bldo2 {
> +                               /* unused */
> +                       };
> +
> +                       bldo3 {
> +                               /* unused */
> +                       };
> +
> +                       bldo4 {
> +                               /* unused */
> +                       };
> +
> +                       cldo1 {
> +                               /* reserved */
> +                       };
> +
> +                       cldo2 {
> +                               /* unused */
> +                       };
> +
> +                       cldo3 {
> +                               /* unused */
> +                       };
> +
> +                       reg_dcdca: dcdca {
> +                               regulator-always-on;
> +                               regulator-min-microvolt = <810000>;
> +                               regulator-max-microvolt = <1080000>;
> +                               regulator-name = "vdd-cpu";
> +                       };
> +
> +                       reg_dcdcc: dcdcc {
> +                               regulator-always-on;
> +                               regulator-min-microvolt = <810000>;
> +                               regulator-max-microvolt = <1080000>;
> +                               regulator-name = "vdd-gpu-sys";
> +                       };
> +
> +                       reg_dcdcd: dcdcd {
> +                               regulator-always-on;
> +                               regulator-min-microvolt = <1500000>;
> +                               regulator-max-microvolt = <1500000>;
> +                               regulator-name = "vdd-dram";
> +                       };
> +
> +                       reg_dcdce: dcdce {
> +                               regulator-boot-on;
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-name = "vcc-eth-mmc";
> +                       };
> +
> +                       sw {
> +                               /* unused */
> +                       };
> +               };
> +       };
> +};
> +
> +&uart0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart0_ph_pins>;
> +       status = "okay";
> +};
> +
> +&usbotg {
> +       dr_mode = "otg";
> +       status = "okay";
> +};
> +
> +&usbphy {
> +       usb0_vbus-supply = <&reg_vcc5v>;
> +       usb1_vbus-supply = <&reg_usb1_vbus>;
> +       status = "okay";
> +};
> --
> 2.17.5
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20201202135409.13683-9-andre.przywara%40arm.com.
