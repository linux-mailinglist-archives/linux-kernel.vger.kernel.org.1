Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F87F2E9AD5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 17:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbhADQPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 11:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbhADQPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 11:15:14 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336AFC061794
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 08:14:33 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id jx16so37464940ejb.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 08:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u0ql2hOKODtiVe3WufYLopYmblBpBFbJZKkH4GzaQpU=;
        b=ggeVSpKwsztGPvIJPdCt2kE0v578e87a9Lf0XeqPyivyKHwD5Rg2VMdg/cQWEJcTI4
         J2xTWn5YYAEw78ihkUE4vk51fZYXMQxhWv46/KcHffh1BxFhUubMAxX7cpnUel9Reb/l
         Hx9RcyKVTYMOtsbhBN3pDFh90J35YDwogovQLQ6i82OlVrpNBlm8Smdlq6leppBdEJel
         eA8NaEKKO53hsWRPYLsaELltZ03h0NHCqvh/yMMqzBwZIxTsP9B7FpBWij/wBLP010H0
         NuDycItjwAFNunJULq+FfFj/GlTEzZPrjqOgLw9rlrf93zgsIKDZOpPXdkG/tPEXEzAl
         ZdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u0ql2hOKODtiVe3WufYLopYmblBpBFbJZKkH4GzaQpU=;
        b=AjagqY7hj7nvTbzPk3keIULr+Uo5gpsRTVKRMDqjJg/3T6KwxHn6js0mt3zhjM9izR
         R8xFPfbpXXQLcfk5mYet64iQ6yu/69eh92XHCHSCbfFgJcDDcIbDjLyfAwouRFDrCxaP
         Y91kVcHpJ/1Av/ZfWvJEOEeYnALK0DXm3OXEhht8UnF9RLXbAPsPAwtSR0H4cDGV5S/s
         KADPgjJ6OZEOtFVIOjLrFJJzFVVCQKikJ2lqTd1cnydvJWgXq1J2OHCEmhspKh/2arEV
         Lfhhi5TpMVw6AZk8oAPpZJEzIv1HTNYxX2ZFR6sGv/faKw1YKYdecABK9rvKgMhbCVcM
         5iYQ==
X-Gm-Message-State: AOAM53278lkjRkKjj8hin6MIl85YNf5dyy5Q/LX+HKZxReBaCsw1BYD2
        M0RyNGPTSNpeQ4N/SuPMh3yEoeXsfqAln536HbbSBQ==
X-Google-Smtp-Source: ABdhPJwpq2WtyS4TdVSWKWivRyPvxpuEUH+t2wx3AtPMs7MSlX7TIchcFev9k+JfTxnOSKRR1l72ACs3BKa4T4SVueA=
X-Received: by 2002:a17:906:6a45:: with SMTP id n5mr68507602ejs.514.1609776871823;
 Mon, 04 Jan 2021 08:14:31 -0800 (PST)
MIME-Version: 1.0
References: <1609351123-22418-1-git-send-email-tharvey@gateworks.com>
 <1609351123-22418-2-git-send-email-tharvey@gateworks.com> <20210104123615.GA5974@kozik-lap>
In-Reply-To: <20210104123615.GA5974@kozik-lap>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 4 Jan 2021 08:14:20 -0800
Message-ID: <CAJ+vNU2xctqRVYd7uTUWKhgW9jAp6t2Pjv2VxSiXaGTnfj3chA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: imx8mm: Add Gateworks i.MX 8M Mini
 Development Kits
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 4:36 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, Dec 30, 2020 at 09:58:43AM -0800, Tim Harvey wrote:
> > The Gateworks Venice GW71xx-0x/GW72xx-0x/GW73xx-0x are development
> > kits comprised of a GW700x SoM and a Baseboard. Future SoM's such
> > as the GW701x will create additional combinations.
> >
> > The GW700x SoM contains:
> >  - i.MX 8M Mini SoC
> >  - LPDDR4 DRAM
> >  - eMMC FLASH
> >  - Gateworks System Controller (eeprom/pushbutton/reset/voltage-monitor)
> >  - GbE PHY connected to the i.MX 8M Mini FEC
> >  - Power Management IC
> >
> > The GW71xx Baseboard contains:
> >  - 1x MiniPCIe Socket with USB2.0, PCIe, and SIM
> >  - 1x RJ45 GbE (i.MX 8M Mini FEC)
> >  - I/O connector with 1x-SPI/1x-I2C/1x-UART/4x-GPIO signals
> >  - PCIe Clock generator
> >  - GPS and accelerometer
> >  - 1x USB 2.0 Front Panel connector
> >  - wide range power supply
> >
> > The GW72xx Baseboard contains:
> >  - 2x MiniPCIe Socket with USB2.0, PCIe, and SIM
> >  - 2x RJ45 GbE (i.MX 8M Mini FEC and LAN743x)
> >  - 1x MicroSD connector
> >  - 1x USB 2.0 Front Panel connector
> >  - 1x SPI connector
> >  - 1x Serial connector supporting 2x-UART or 1x-UART configured as 1 of:
> >    RS232 w/ flow-controll, RS485, RS422
> >  - PCIe Clock generator
> >  - GPS and accelerometer
> >  - Media Expansion connector (MIPI-CSI/MIPI-DSI/GPIO/I2S)
> >  - I/O connector with 2x-ADC,2x-GPIO,1x-UART,1x-I2C
> >  - wide range power supply
> >
> > The GW73xx Baseboard contains:
> >  - 3x MiniPCIe Socket with USB2.0, PCIe, and SIM
> >  - 2x RJ45 GbE (i.MX 8M Mini FEC and LAN743x)
> >  - 1x MicroSD connector
> >  - 1x USB 2.0 Front Panel connector
> >  - 1x SPI connector
> >  - 1x Serial connector supporting 2x-UART or 1x-UART configured as 1 of:
> >    RS232 w/ flow-controll, RS485, RS422
> >  - WiFi/BT
> >  - PCIe Clock generator
> >  - GPS and accelerometer
> >  - Media Expansion connector (MIPI-CSI/MIPI-DSI/GPIO/I2S)
> >  - I/O connector with 2x-ADC,2x-GPIO,1x-UART,1x-I2C
> >  - wide range power supply
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> > v4:
> >  - replace underscore with hyphen for gpio-keys node
> >  - add 'off-board header' comments to i2c/spi/uart nodes that go off-board
> >  - move node comments to own line above node
> >  - add spaces after comma
> >  - move uart2_gpio rs485 config pinmux to hoggroup as they don't necessarily
> >    relate to uart2
> >  - fix fifo-depth dt property for phy
> >
> > v3:
> >  - fix gpio controller node name
> >  - add rtc node to SoM
> >  - add pmic pinctrl to SoM
> >  - fixed compatible string for SoM eeprom's
> >
> > v2:
> >  - fix i.MX 8M Mini name in commit log
> >  - consistent use of underscore vs hyphen in labels
> >  - fix gsc interrupt type
> >  - fix iomux group node names
> >  - fix led-controller bindings:
> >    (use correct node names, color, function and remove label)
> >  - use accelerometer node name vs accel
> >  - remove sai3 from gw71xx baseboard
> >  - added serial connector description to commit message
> >  - added I/O connector description to commit message
> >  - removed unnecessary #address-cells/#size-cells from gpio-keys node
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile             |   3 +
> >  .../boot/dts/freescale/imx8mm-venice-gw700x.dtsi   | 497 +++++++++++++++++++++
> >  .../boot/dts/freescale/imx8mm-venice-gw71xx-0x.dts |  19 +
> >  .../boot/dts/freescale/imx8mm-venice-gw71xx.dtsi   | 186 ++++++++
> >  .../boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts |  20 +
> >  .../boot/dts/freescale/imx8mm-venice-gw72xx.dtsi   | 314 +++++++++++++
> >  .../boot/dts/freescale/imx8mm-venice-gw73xx-0x.dts |  19 +
> >  .../boot/dts/freescale/imx8mm-venice-gw73xx.dtsi   | 366 +++++++++++++++
> >  8 files changed, 1424 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dts
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dts
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > index f8d5943..ecdd233 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -32,6 +32,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
> > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw71xx-0x.dtb
> > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x.dtb
> > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mn-var-som-symphony.dtb
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
> > new file mode 100644
> > index 00000000..5985a39
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
> > @@ -0,0 +1,497 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2020 Gateworks Corporation
> > + */
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/linux-event-codes.h>
> > +#include <dt-bindings/net/ti-dp83867.h>
> > +
> > +/ {
> > +     memory@40000000 {
> > +             device_type = "memory";
> > +             reg = <0x0 0x40000000 0 0x80000000>;
> > +     };
> > +
> > +     gpio-keys {
> > +             compatible = "gpio-keys";
> > +
> > +             user_pb {
>
> All these nodes as well - hyphens instead of underscore.

will fix

>
>
> > +                     label = "user_pb";
> > +                     gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
> > +                     linux,code = <BTN_0>;
> > +             };
> > +
> > +             user_pb1x {
> > +                     label = "user_pb1x";
> > +                     linux,code = <BTN_1>;
> > +                     interrupt-parent = <&gsc>;
> > +                     interrupts = <0>;
> > +             };
> > +
> > +             key_erased {
> > +                     label = "key_erased";
> > +                     linux,code = <BTN_2>;
> > +                     interrupt-parent = <&gsc>;
> > +                     interrupts = <1>;
> > +             };
> > +
> > +             eeprom_wp {
> > +                     label = "eeprom_wp";
> > +                     linux,code = <BTN_3>;
> > +                     interrupt-parent = <&gsc>;
> > +                     interrupts = <2>;
> > +             };
> > +
> > +             tamper {
> > +                     label = "tamper";
> > +                     linux,code = <BTN_4>;
> > +                     interrupt-parent = <&gsc>;
> > +                     interrupts = <5>;
> > +             };
> > +
> > +             switch_hold {
> > +                     label = "switch_hold";
> > +                     linux,code = <BTN_5>;
> > +                     interrupt-parent = <&gsc>;
> > +                     interrupts = <7>;
> > +             };
> > +     };
>
> Rest of DTS looks ok, thanks!
>

Great - thank you so much for the reviews! I will follow-up shortly
with another revision.

Best regards and Happy New Year!

Tim
