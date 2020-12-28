Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE412E6A67
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 20:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgL1TUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 14:20:21 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42]:40666 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbgL1TUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 14:20:21 -0500
Received: by mail-ej1-f42.google.com with SMTP id x16so15449820ejj.7;
        Mon, 28 Dec 2020 11:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EP+k0w9oGENn+3btQoRgIYL4rxkZwWbCQZccTKMj5eE=;
        b=sCoh6Sfe3xZVq3pTNMe/w2GiGKoYSuBDrsSBO5RniyQiYNnyqN1YqvmHP2Fq+gQGtZ
         GeFMFIxEGgc8pkBk6kd0W4cRyV0Jh19r0KDy+yVRYZ3PRsYR3FDR5alJyMFTHKFk/rlg
         1zR4hCBccFKq0v4VBJG9qeNcEEXZA8Nm/j9VG1dNThMOaFEZzmOtIJknL6KwXUmcAZrH
         zO27u5Ah3aj/N8D3TWA8lMtYM9lkP6Qk1lRkQXzZZZqaBpiPGmnG6Jt3zCgb8h66NLYA
         Sflqu7Wj4HhxyVvT9mt4CyhSTN0PUkhZdfRRTbFtjZKjs3/DJX9OyTedTneplqe2KoCJ
         PCcA==
X-Gm-Message-State: AOAM532rN7KdhVQoPfhR72SuRQLM9yGR9MuFlQssFjeNW6bMbkx6FD8y
        4OVqGqJGbnv3c26JRd3yyCo=
X-Google-Smtp-Source: ABdhPJyFojfwh/0V78r+JIq5MMSbL+LMDFtiEBcjgmQnDSgjZM4ieoXO94REsVa2nVd95DTTRuNk9g==
X-Received: by 2002:a17:906:7e0b:: with SMTP id e11mr41939859ejr.533.1609183177341;
        Mon, 28 Dec 2020 11:19:37 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id z13sm9831941edq.48.2020.12.28.11.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 11:19:36 -0800 (PST)
Date:   Mon, 28 Dec 2020 20:19:35 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mm: Add Gateworks IMX8MM Development
 Kits
Message-ID: <20201228191935.GA53937@kozik-lap>
References: <1608762196-29871-1-git-send-email-tharvey@gateworks.com>
 <1608762196-29871-2-git-send-email-tharvey@gateworks.com>
 <20201224113727.GB15628@kozik-lap>
 <CAJ+vNU2NRWx74e94ToFJ+jKgrSveZeGVR8uTOJ+JAaWN3d=PXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+vNU2NRWx74e94ToFJ+jKgrSveZeGVR8uTOJ+JAaWN3d=PXw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 11:02:40AM -0800, Tim Harvey wrote:
 > > +
> > > +&i2c1 {
> > > +     clock-frequency = <100000>;
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_i2c1>;
> > > +     status = "okay";
> > > +
> > > +     gsc: gsc@20 {
> >
> > Node name should describe class of a device so maybe
> > "system-controller"?
> >
> 
> The node-name here must match 'gsc' due to the bindings. The name
> stands for 'Gateworks System Controller'.

Indeed, so it must stay like this.
 > > +
> > > +             fan-controller@0 {
> > > +                     #address-cells = <1>;
> > > +                     #size-cells = <0>;
> >
> > These do not seem needed.
> 
> They are required per
> Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml but they
> should be inherited from the parent node right? So perhaps
> gateworks-gsc.yaml needs to remove them?

Maybe they shouldn't be in the bindings, either? These are only for
nodes which have childre. The fan-controller does not have them.

> 
> >
> > > +                     compatible = "gw,gsc-fan";
> > > +                     reg = <0x0a>;
> > > +             };
> > > +     };
> > > +
> > > +     gsc_gpio: pca9555@23 {
> >
> > Lookes like gpio-controller, so "gpio". Please run make dtbs_check to be
> > sure your board validate against dt-schema.
> 
> Yes, I see these warnings now with 'make dtbs_check W=1'

dtbs_check without W=1.
dtbs with W=1.
These are different tools.

> 
> Note when I do run 'make dtbs_check W=1' I see many warnings which
> seem invalid that I have to skip over:
> /usr/src/linux/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dt.yaml: pi
> nctrl@30330000: fec1grp:fsl,pins:0: [104, 720, 0, 0, 0, 3, 108, 724, 1216, 0, 1,
>  3, 112, 728, 0, 0, 0, 31, 116, 732, 0, 0, 0, 31, 120, 736, 0, 0, 0,
> 31, 124, 740, 0, 0, 0, 31, 156, 772, 0, 0, 0, 145, 152, 768, 0, 0, 0,
> 145, 148, 764, 0, 0, 0, 145, 144, 760, 0, 0, 0, 145, 132, 748, 0, 0,
> 0, 31, 140, 756, 0, 0, 0, 145, 136, 752, 0, 0, 0, 145, 128, 744, 0, 0,
> 0, 31, 244, 860, 0, 5, 0, 25] is too long
>         From schema:
> /usr/src/linux/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml
> /usr/src/linux/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dt.yaml:
> pinctrl@30330000: fec1grp:fsl,pins:0: Additional items are not allowed
> (108, 724, 1216, 0, 1, 3, 112, 728, 0, 0, 0, 31, 116, 732, 0, 0, 0,
> 31, 120, 736, 0, 0, 0, 31, 124, 740, 0, 0, 0, 31, 156, 772, 0, 0, 0,
> 145, 152, 768, 0, 0, 0, 145, 148, 764, 0, 0, 0, 145, 144, 760, 0, 0,
> 0, 145, 132, 748, 0, 0, 0, 31, 140, 756, 0, 0, 0, 145, 136, 752, 0, 0,
> 0, 145, 128, 744, 0, 0, 0, 31, 244, 860, 0, 5, 0, 25 were unexpected)
> ^^^ It seems maybe something is too restrictive with
> Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml that
> doesn't allow an array of pins?

This is expected because dt-schema does not accept pin groups in one
array (<..., ....>). Compare your warnings with some other recent imx8mm
designs. If you introduce new, these have to be fixed.

> 
> I see lots of warnings about imx8mm gpmi as well but they don't have
> anything to do with my dtbs.
> 
> >
> > > +             compatible = "nxp,pca9555";
> > > +             reg = <0x23>;
> > > +             gpio-controller;
> > > +             #gpio-cells = <2>;
> > > +             interrupt-parent = <&gsc>;
> > > +             interrupts = <4>;
> > > +     };
> > > +
> <snip>
> > > +
> > > +&iomuxc {
> > > +     pinctrl_fec1: fec1grp {
> > > +             fsl,pins = <
> > > +                     MX8MM_IOMUXC_ENET_MDC_ENET1_MDC                 0x3
> > > +                     MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO               0x3
> > > +                     MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3           0x1f
> > > +                     MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2           0x1f
> > > +                     MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1           0x1f
> > > +                     MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0           0x1f
> > > +                     MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3           0x91
> > > +                     MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2           0x91
> > > +                     MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1           0x91
> > > +                     MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0           0x91
> > > +                     MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC           0x1f
> > > +                     MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC           0x91
> > > +                     MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL     0x91
> > > +                     MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL     0x1f
> > > +                     MX8MM_IOMUXC_NAND_ALE_GPIO3_IO0                 0x19
> > > +             >;
> > > +     };
> > > +
> > > +     pinctrl_gsc: gscirq {
> >
> > grp suffix. I think dtbs_check should point this out.
> 
> ok, I do see this warning with 'make dtbs_check W=1'. I will fix the
> node names for the iomux pin groups
> 
> <snip>
> >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dts
> > > new file mode 100644
> > > index 00000000..3f88c4a
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dts
> > > @@ -0,0 +1,19 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +/*
> > > + * Copyright 2020 Gateworks Corporation
> > > + */
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include "imx8mm.dtsi"
> > > +#include "imx8mm-venice-gw700x.dtsi"
> > > +#include "imx8mm-venice-gw71xx.dtsi"
> > > +
> > > +/ {
> > > +     model = "Gateworks Venice GW71xx-0x i.MX8MM Development Kit";
> > > +     compatible = "gw,imx8mm-gw71xx-0x", "fsl,imx8mm";
> > > +
> > > +     chosen {
> > > +             stdout-path = &uart2;
> > > +     };
> > > +};
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
> > > new file mode 100644
> > > index 00000000..a4eeb0d
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
> >
> > This file is included only once, so it should be directly inside imx8mm-venice-gw71xx-0x.dts. Do not create empty DTS just to include DTSI and nothing more. It's really over-complicating simple hierarchy.
> 
> The reason for this is that the '0x' on the end is the SoM and in the
> future there will be a '1x', '2x' SoM so imagine:
> imx8mm-venice-gw71xx-2x.dts being the 'kit' that combines the
> imx8mm-venice-gw71xx.dtsi baseboard and imx8mm-venice-gw702x.dtsi SoM.
> Our numbering scheme has SoM's as gw70xx. I will add something to the
> commit log that explains this.

If you really intend to upstream these future designs, then it's fine.
Have in mind that if you do not upstream them, anyone can simplify later
the hierarchy by renaming imx8mm-venice-gw71xx.dtsi into
imx8mm-venice-gw71xx.dts.

> 
> >
> > > @@ -0,0 +1,186 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +/*
> > > + * Copyright 2020 Gateworks Corporation
> > > + */
> > > +
> > > +/ {
> > > +     aliases {
> > > +             usb0 = &usbotg1;
> > > +             usb1 = &usbotg2;
> > > +     };
> > > +
> > > +     leds {
> >
> > led-controller
> 
> ok - will fix
> 
> >
> > > +             compatible = "gpio-leds";
> > > +             pinctrl-names = "default";
> > > +             pinctrl-0 = <&pinctrl_gpio_leds>;
> > > +
> > > +             user1 { /* GRN */
> >
> > led-0
> 
> ok, will fix
> 
> >
> > > +                     label = "user1";
> >
> > label is now deprecated. See the common bindings.
> >
> 
> ok, will fix by removing deprecated label and adding color/function props
> 
> > > +                     gpios = <&gpio5 5 GPIO_ACTIVE_HIGH>;
> > > +                     default-state = "on";
> > > +                     linux,default-trigger = "heartbeat";
> > > +             };
> > > +
> <snip>
> > > +&i2c2 {
> > > +     clock-frequency = <400000>;
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_i2c2>;
> > > +     status = "okay";
> > > +
> > > +     accel@19 {
> >
> > accelerometer
> >
> 
> ok - will fix
> 
> You also had asked why ecspi2, i2c3 were enabled (with no child nodes)
> and why uart1/uart3 were enabled on the carrier boards.
> 
> The carrier boards have off-board connectors for ecspi2, i2c3 so I
> include them on the baseboard so that the Linux SPI/I2C userspace
> API's could be used.

Sure, this makes sense. Can you add a comment to such nodes like:
"UART on header"

Customers usually copy the reference designs (boards) so it is usually
useful to explain why something on carrier board was enabled, even
though nothing is attached.

Best regards,
Krzysztof
