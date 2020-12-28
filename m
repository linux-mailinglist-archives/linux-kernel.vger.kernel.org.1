Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEA62E6A40
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 20:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgL1TDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 14:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbgL1TDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 14:03:33 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9E5C061796
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:02:53 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id x16so15396079ejj.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/HzG3+Wrxlm1uvlpRJdQ/9SwGbL2ngQgBk55RSigqh8=;
        b=ZhZY6jiqNdtWOt4+i9RckrGICCET3/MFEdKBQB4rj4dJBLmVtRLvMPbwkbdiKAiWA4
         +HlUEh6OzjfDIDv/HlD2pjsfu2CvDD4U+otRA3fzdSlfB5J0YFUdZdE4Pk2fIhOe0yoG
         ZLkHZMrieSA4punb/E6Tp1RGmKjtMU2Eu33ROlMLq/iKMQRghuOeVrNlhJ8pk5QR9Mo3
         UyTWPP5BHB9VF3eIU0Up2oTOtSMa6g0GjVkswVgqsA0v/Zh66ET/QVZrI9jr6keMnM4B
         I6ZT77Vh+CHqXjiAZZPq5G1fKNeCb2SOy1t4yr9lkFuiK9c9H7zIYsgwIRf4tmRLGJVL
         aeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/HzG3+Wrxlm1uvlpRJdQ/9SwGbL2ngQgBk55RSigqh8=;
        b=tcKcnvfMLSqFRAr0CE5e/y8J+V1UIPlTyIdW0Gi2oJXiH3ZP/7MMmF+ShesCpWAP55
         fYqG0NyuRal/RO1lJ9l6EwMc6D82IZsNYyuhu8bA1HQ8WAh2NErnixVItteRRzYrO2y8
         DF5CgI/oJJnK6/Rj81AHcCXhJXQOMKv+GekK7K63ZsG0TXfCNFarFaukI5/IkCMXUqCa
         J4N6Nu0i+nEbz7M3vgVmJQerDfI21tTD+MWwW/xkqBMYGz+i1ejxjyWRtVMAQSNqLsFc
         dFer3OJr9IIEL8nSB+VJim8ZKVv3S8zKQfSEh32Q/dWTseYQiuALc4WRayE4KIdmaEQD
         5iug==
X-Gm-Message-State: AOAM531LAnwG8tCddsZ97L1iAJ96PZ6nqdT4H2g6PoQC4T0OV2a+iv1b
        gabfwDt6U3YqiltaVOBKMrDVjA98Q0z7x3mHbnHtcg==
X-Google-Smtp-Source: ABdhPJwKRRWujBfKrBmeWi/c/jUnxNm3v7/iJ/ToIvs/EiLA4NlFfJ3NeyT5n84Hi+BboVXOMX5fy3BaCZKrc9NLfWg=
X-Received: by 2002:a17:906:720e:: with SMTP id m14mr41064601ejk.161.1609182171693;
 Mon, 28 Dec 2020 11:02:51 -0800 (PST)
MIME-Version: 1.0
References: <1608762196-29871-1-git-send-email-tharvey@gateworks.com>
 <1608762196-29871-2-git-send-email-tharvey@gateworks.com> <20201224113727.GB15628@kozik-lap>
In-Reply-To: <20201224113727.GB15628@kozik-lap>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 28 Dec 2020 11:02:40 -0800
Message-ID: <CAJ+vNU2NRWx74e94ToFJ+jKgrSveZeGVR8uTOJ+JAaWN3d=PXw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mm: Add Gateworks IMX8MM Development Kits
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

On Thu, Dec 24, 2020 at 3:37 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>

Thanks for the review!

> On Wed, Dec 23, 2020 at 02:23:16PM -0800, Tim Harvey wrote:
> > The Gateworks Venice GW71xx-0x/GW72xx-0x/GW73xx-0x are development
> > kits comprised of a GW700x SoM and a Baseboard.
> >
> > The GW700x SoM contains:
> >  - IMX8MM SoC
>
> It's i.MX 8M Mini.
> https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/i-mx-applications-processors/i-mx-8-processors/i-mx-8m-mini-arm-cortex-a53-cortex-m4-audio-voice-video:i.MX8MMINI
>

ok

> >  - LPDDR4 DRAM
> >  - eMMC FLASH
> >  - Gateworks System Controller (eeprom/pushbutton/reset/voltage-monitor)
> >  - GbE PHY connected to the IMX8MM FEC
> >  - Power Management IC
> >
> > The GW71xx Baseboard contains:
> >  - 1x MiniPCIe Socket with USB2.0, PCIe, and SIM
> >  - 1x RJ45 GbE (IMX8MM FEC)
> >  - PCIe Clock generator
> >  - GPS and accelerometer
> >  - 1x USB 2.0 Front Panel connector
> >  - wide range power supply
> >
> > The GW72xx Baseboard contains:
> >  - 2x MiniPCIe Socket with USB2.0, PCIe, and SIM
> >  - 2x RJ45 GbE (IMX8MM FEC and LAN743x)
> >  - 1x MicroSD connector
> >  - 1x USB 2.0 Front Panel connector
> >  - 1x SPI connector
> >  - PCIe Clock generator
> >  - GPS and accelerometer
> >  - Media Expansion connector (MIPI-CSI/MIPI-DSI/GPIO/I2S)
> >  - wide range power supply
> >
> > The GW73xx Baseboard contains:
> >  - 3x MiniPCIe Socket with USB2.0, PCIe, and SIM
> >  - 2x RJ45 GbE (IMX8MM FEC and LAN743x)
> >  - 1x MicroSD connector
> >  - 1x USB 2.0 Front Panel connector
> >  - 1x SPI connector
> >  - WiFi/BT
> >  - PCIe Clock generator
> >  - GPS and accelerometer
> >  - Media Expansion connector (MIPI-CSI/MIPI-DSI/GPIO/I2S)
> >  - wide range power supply
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
<snip>
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
> > @@ -0,0 +1,482 @@
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
> > +     gpio_keys {
> > +             compatible = "gpio-keys";
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +
> > +             user_pb {
> > +                     label = "user_pb";
> > +                     gpios = <&gsc_gpio 2 GPIO_ACTIVE_LOW>;
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
> > +                     label = "key-erased";
>
> Above you use underscore, here hyphen. Make it consistent.

ok

>
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
> > +};
> > +
<snip>
> > +
> > +&i2c1 {
> > +     clock-frequency = <100000>;
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_i2c1>;
> > +     status = "okay";
> > +
> > +     gsc: gsc@20 {
>
> Node name should describe class of a device so maybe
> "system-controller"?
>

The node-name here must match 'gsc' due to the bindings. The name
stands for 'Gateworks System Controller'.

> > +             compatible = "gw,gsc";
> > +             reg = <0x20>;
> > +             pinctrl-0 = <&pinctrl_gsc>;
> > +             interrupt-parent = <&gpio2>;
> > +             interrupts = <6 GPIO_ACTIVE_LOW>;
>
> Wrong flag.
>

oops... thanks for catching it was supposed to be falling anyway. I
will change to IRQ_TYPE_EDGE_FALLING

> > +             interrupt-controller;
> > +             #interrupt-cells = <1>;
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +
> > +             adc {
>
> Just to be sure - did you build it with W=1 to find any dtc warnings?
>

I did 'make dtbs_check' but not with W=1... will do that for next submission

> > +                     compatible = "gw,gsc-adc";
> > +                     #address-cells = <1>;
> > +                     #size-cells = <0>;
> > +
<snip>
> > +             };
> > +
> > +             fan-controller@0 {
> > +                     #address-cells = <1>;
> > +                     #size-cells = <0>;
>
> These do not seem needed.

They are required per
Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml but they
should be inherited from the parent node right? So perhaps
gateworks-gsc.yaml needs to remove them?

>
> > +                     compatible = "gw,gsc-fan";
> > +                     reg = <0x0a>;
> > +             };
> > +     };
> > +
> > +     gsc_gpio: pca9555@23 {
>
> Lookes like gpio-controller, so "gpio". Please run make dtbs_check to be
> sure your board validate against dt-schema.

Yes, I see these warnings now with 'make dtbs_check W=1'

Note when I do run 'make dtbs_check W=1' I see many warnings which
seem invalid that I have to skip over:
/usr/src/linux/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dt.yaml: pi
nctrl@30330000: fec1grp:fsl,pins:0: [104, 720, 0, 0, 0, 3, 108, 724, 1216, 0, 1,
 3, 112, 728, 0, 0, 0, 31, 116, 732, 0, 0, 0, 31, 120, 736, 0, 0, 0,
31, 124, 740, 0, 0, 0, 31, 156, 772, 0, 0, 0, 145, 152, 768, 0, 0, 0,
145, 148, 764, 0, 0, 0, 145, 144, 760, 0, 0, 0, 145, 132, 748, 0, 0,
0, 31, 140, 756, 0, 0, 0, 145, 136, 752, 0, 0, 0, 145, 128, 744, 0, 0,
0, 31, 244, 860, 0, 5, 0, 25] is too long
        From schema:
/usr/src/linux/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml
/usr/src/linux/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dt.yaml:
pinctrl@30330000: fec1grp:fsl,pins:0: Additional items are not allowed
(108, 724, 1216, 0, 1, 3, 112, 728, 0, 0, 0, 31, 116, 732, 0, 0, 0,
31, 120, 736, 0, 0, 0, 31, 124, 740, 0, 0, 0, 31, 156, 772, 0, 0, 0,
145, 152, 768, 0, 0, 0, 145, 148, 764, 0, 0, 0, 145, 144, 760, 0, 0,
0, 145, 132, 748, 0, 0, 0, 31, 140, 756, 0, 0, 0, 145, 136, 752, 0, 0,
0, 145, 128, 744, 0, 0, 0, 31, 244, 860, 0, 5, 0, 25 were unexpected)
^^^ It seems maybe something is too restrictive with
Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml that
doesn't allow an array of pins?

I see lots of warnings about imx8mm gpmi as well but they don't have
anything to do with my dtbs.

>
> > +             compatible = "nxp,pca9555";
> > +             reg = <0x23>;
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +             interrupt-parent = <&gsc>;
> > +             interrupts = <4>;
> > +     };
> > +
<snip>
> > +
> > +&iomuxc {
> > +     pinctrl_fec1: fec1grp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_ENET_MDC_ENET1_MDC                 0x3
> > +                     MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO               0x3
> > +                     MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3           0x1f
> > +                     MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2           0x1f
> > +                     MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1           0x1f
> > +                     MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0           0x1f
> > +                     MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3           0x91
> > +                     MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2           0x91
> > +                     MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1           0x91
> > +                     MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0           0x91
> > +                     MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC           0x1f
> > +                     MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC           0x91
> > +                     MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL     0x91
> > +                     MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL     0x1f
> > +                     MX8MM_IOMUXC_NAND_ALE_GPIO3_IO0                 0x19
> > +             >;
> > +     };
> > +
> > +     pinctrl_gsc: gscirq {
>
> grp suffix. I think dtbs_check should point this out.

ok, I do see this warning with 'make dtbs_check W=1'. I will fix the
node names for the iomux pin groups

<snip>
>
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dts
> > new file mode 100644
> > index 00000000..3f88c4a
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dts
> > @@ -0,0 +1,19 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2020 Gateworks Corporation
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "imx8mm.dtsi"
> > +#include "imx8mm-venice-gw700x.dtsi"
> > +#include "imx8mm-venice-gw71xx.dtsi"
> > +
> > +/ {
> > +     model = "Gateworks Venice GW71xx-0x i.MX8MM Development Kit";
> > +     compatible = "gw,imx8mm-gw71xx-0x", "fsl,imx8mm";
> > +
> > +     chosen {
> > +             stdout-path = &uart2;
> > +     };
> > +};
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
> > new file mode 100644
> > index 00000000..a4eeb0d
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
>
> This file is included only once, so it should be directly inside imx8mm-venice-gw71xx-0x.dts. Do not create empty DTS just to include DTSI and nothing more. It's really over-complicating simple hierarchy.

The reason for this is that the '0x' on the end is the SoM and in the
future there will be a '1x', '2x' SoM so imagine:
imx8mm-venice-gw71xx-2x.dts being the 'kit' that combines the
imx8mm-venice-gw71xx.dtsi baseboard and imx8mm-venice-gw702x.dtsi SoM.
Our numbering scheme has SoM's as gw70xx. I will add something to the
commit log that explains this.

>
> > @@ -0,0 +1,186 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2020 Gateworks Corporation
> > + */
> > +
> > +/ {
> > +     aliases {
> > +             usb0 = &usbotg1;
> > +             usb1 = &usbotg2;
> > +     };
> > +
> > +     leds {
>
> led-controller

ok - will fix

>
> > +             compatible = "gpio-leds";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_gpio_leds>;
> > +
> > +             user1 { /* GRN */
>
> led-0

ok, will fix

>
> > +                     label = "user1";
>
> label is now deprecated. See the common bindings.
>

ok, will fix by removing deprecated label and adding color/function props

> > +                     gpios = <&gpio5 5 GPIO_ACTIVE_HIGH>;
> > +                     default-state = "on";
> > +                     linux,default-trigger = "heartbeat";
> > +             };
> > +
<snip>
> > +&i2c2 {
> > +     clock-frequency = <400000>;
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_i2c2>;
> > +     status = "okay";
> > +
> > +     accel@19 {
>
> accelerometer
>

ok - will fix

You also had asked why ecspi2, i2c3 were enabled (with no child nodes)
and why uart1/uart3 were enabled on the carrier boards.

The carrier boards have off-board connectors for ecspi2, i2c3 so I
include them on the baseboard so that the Linux SPI/I2C userspace
API's could be used.

The carrier boards also have uart1 connected to a GPS, uart2/uart4
going to a multi-protocol RS232/RS485/RS422 transceiver that has some
GPIO to configure it, and uart3 going to an offboard I/O connector.
For this reason I have uart2 basic tx/rx configured on the gw70xx SoM
and uart1/uart2-gpio/uart4 configures on the carrier board.

I will submit a v2 shortly.

Best regards,

Tim
