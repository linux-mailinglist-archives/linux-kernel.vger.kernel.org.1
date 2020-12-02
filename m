Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A362CC6B2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgLBTb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbgLBTb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:31:58 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEC6C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 11:31:12 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id d18so5233028edt.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o50I7kB8txM++CPAFkrMrw9DtpsgpbpqDkc+hsx3aSc=;
        b=PEvwhSi6tdyemmMuiZL5rWy6fpDGFuvZYBYHH/aOuNFJLfJkWNCVl74sDGAUaPUAsQ
         Yeywclhgsq8IWBNFSd5JYD8EC3E8mT34+fV/DKGga8nsno4H/9IZ+h7AOguYX+C/ehI4
         stV6kZZWqpTZTw+wmAQ31hCzdkRFCbtxRBATk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o50I7kB8txM++CPAFkrMrw9DtpsgpbpqDkc+hsx3aSc=;
        b=ouyON8hMXRgqX0g3tivekcq6jD6r13Yt7BAKRYTOBeabPxvzZ7E4PKOenPpQfxzuWO
         PNATUk2mU2ThggHGMTazggOemn5+yzCUORSXyHiVUQhO7zWMputZI2O46ST1Xg6ELhDQ
         V7Z7MLwasS47sLIUJQcm+cm3hfHPf6UIIv0nGfeMJ5oDbpOvx+ZwNkvFEOptbQDXmoOn
         56Aur0XLeOI4GwKOZ/xmTIgFgNrPxR7iZKuEh5UvOoj/kElJRYiS4RhvcoGVikNa0Kk9
         +Xy+nh/94f3hKmyzpl49bOTqgEpQhe/Oif2+3a2Uh/ac9cskbxOmcUs9z5Nrni0xE3ZU
         JHsQ==
X-Gm-Message-State: AOAM5307uFeGODMVQYfiVeNH1ryesVKc8rjpBHe/nzdyiNv6Dp9KzptJ
        FSb/3cS2KTYTfWVhfONWFCOyXePT/i196QHTwOwXfQ==
X-Google-Smtp-Source: ABdhPJzfG5pA13b5rVSSde3qg5OJO1Q0ejYC2F9EMeUwh0tW3vpcJ743p6xlhbbuhV/65RRytMGosvaCzknOQofDDF0=
X-Received: by 2002:a05:6402:3d9:: with SMTP id t25mr1471265edw.338.1606937470811;
 Wed, 02 Dec 2020 11:31:10 -0800 (PST)
MIME-Version: 1.0
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
 <20201202121241.109952-5-jagan@amarulasolutions.com> <20201202173405.GD3490@kozik-lap>
In-Reply-To: <20201202173405.GD3490@kozik-lap>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 3 Dec 2020 01:00:59 +0530
Message-ID: <CAMty3ZDg-7J9zk14Y-L1LBJsVnoK7KvposzBNnDP7gRdR3NHEQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini SOM
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Dec 2, 2020 at 11:04 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, Dec 02, 2020 at 05:42:35PM +0530, Jagan Teki wrote:
> > i.Core MX8M Mini is an EDIMM SOM based on NXP i.MX8MM from Engicam.
>
> s/SOM/SoM/
>
> >
> > General features:
> > - NXP i.MX8MM
>
> i.MX 8M Mini
> as named by NXP:
> https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/i-mx-applications-processors/i-mx-8-processors/i-mx-8m-mini-arm-cortex-a53-cortex-m4-audio-voice-video:i.MX8MMINI
>
> > - Up to 2GB LDDR4
> > - 8/16GB eMMC
> > - Gigabit Ethernet
> > - USB 2.0 Host/OTG
> > - PCIe Gen2 interface
> > - I2S
> > - MIPI DSI to LVDS
> > - rest of i.MX8MM features
>
> Ditto
>
> >
> > i.Core MX8M Mini needs to mount on top of Engicam baseboards for
> > creating complete platform boards.
> >
> > Possible baseboards are,
> > - EDIMM2.2
> > - C.TOUCH 2.0
>
> Don't describe baseboards. You add here only SoM.

It's just information on how this SoM is being used. Let me know any
issues while explaining the combinations being used here.

>
> >
> > Add support for it.
> >
> > Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  .../freescale/imx8mm-engicam-icore-mx8mm.dtsi | 209 ++++++++++++++++++
> >  1 file changed, 209 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm.dtsi
> > new file mode 100644
> > index 000000000000..b87917c40587
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm.dtsi
> > @@ -0,0 +1,209 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2018 NXP
> > + * Copyright (c) 2019 Engicam srl
> > + * Copyright (c) 2020 Amarula Solutons(India)
> > + */
> > +
> > +/ {
>
> Missing "model".

SoM dtsi won't comprise the model it has its own binding and while
combination board has a model that will include this binding. Please
check to exist binding file.
arch/arm64/boot/dts/rockchip/px30-engicam-px30-core.dtsi

>
> > +     compatible = "engicam,icore-mx8mm", "fsl,imx8mm";
> > +};
> > +
>
> No memory node? Isn't the memory a property of SoM?
>
> > +&A53_0 {
> > +     cpu-supply = <&reg_buck4>;
> > +};
>
> Supplies for the other cores.
>
> > +
> > +&i2c1 {
> > +     clock-frequency = <400000>;
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_i2c1>;
> > +     status = "okay";
> > +
> > +     pf8100@8 {
>
> Node name should describe generic class of a device, so probably you
> wanted here "pmic".

True, will update.

>
> > +             compatible = "nxp,pf8x00";
> > +             reg = <0x08>;
> > +
> > +             regulators {
> > +                     reg_ldo1: ldo1 {
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
>
> First min/max constraints. Then always-on and boot-on properties.
>
> > +                             regulator-max-microvolt = <5000000>;
> > +                             regulator-min-microvolt = <1500000>;
> > +                     };
> > +
> > +                     reg_ldo2: ldo2 {
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-max-microvolt = <5000000>;
> > +                             regulator-min-microvolt = <1500000>;
> > +                     };
> > +
> > +                     reg_ldo3: ldo3 {
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-max-microvolt = <5000000>;
> > +                             regulator-min-microvolt = <1500000>;
> > +                     };
> > +
> > +                     reg_ldo4: ldo4 {
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-max-microvolt = <5000000>;
> > +                             regulator-min-microvolt = <1500000>;
> > +                     };
> > +
> > +                     reg_buck1: buck1 {
> > +                             fsl,ilim-ma = <4500>;
>
> Where is this property documented?

Sorry it would be nxp,ilim-ma I will update in next version.

>
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-max-microvolt = <1800000>;
> > +                             regulator-min-microvolt =  <400000>;
> > +                     };
> > +
> > +                     reg_buck2: buck2 {
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-max-microvolt = <1800000>;
> > +                             regulator-min-microvolt =  <400000>;
> > +                     };
> > +
> > +                     reg_buck3: buck3 {
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-max-microvolt = <1800000>;
> > +                             regulator-min-microvolt =  <400000>;
> > +                     };
> > +
> > +                     reg_buck4: buck4 {
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-max-microvolt = <1800000>;
> > +                             regulator-min-microvolt =  <400000>;
> > +                             fast-slew = <1>;
>
> Where is this property documented?
>
> > +                     };
> > +
> > +                     reg_buck5: buck5 {
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-max-microvolt = <1800000>;
> > +                             regulator-min-microvolt =  <400000>;
> > +                     };
> > +
> > +                     reg_buck6: buck6 {
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-max-microvolt = <1800000>;
> > +                             regulator-min-microvolt =  <400000>;
> > +                     };
> > +
> > +                     reg_buck7: buck7 {
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-max-microvolt = <3300000>;
> > +                             regulator-min-microvolt = <3300000>;
> > +                     };
> > +
> > +                     reg_vsnvs: vsnvs {
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-max-microvolt = <3300000>;
> > +                             regulator-min-microvolt = <1800000>;
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&iomuxc {
> > +     pinctrl_i2c1: i2c1grp {
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL          0x400001c3
> > +                     MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA          0x400001c3
> > +             >;
> > +     };
> > +
> > +     pinctrl_uart2: uart2grp {
>
> Not used.
>
> > +             fsl,pins = <
> > +                     MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX     0x140
> > +                     MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX     0x140
> > +             >;
> > +     };
> > +
> > +     pinctrl_usdhc1_gpio: usdhc1grpgpio {
>
> This should complain on bindings check. Please run dtbs_check. The "grp"
> should be a suffix in node name, so "usdhc1gpiogrp".

Yes, will update it on the next version.

Jagan.
