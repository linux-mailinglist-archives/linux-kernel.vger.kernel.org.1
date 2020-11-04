Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB072A5F1F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgKDIIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKDIIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:08:05 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E061C0613D3;
        Wed,  4 Nov 2020 00:08:05 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id m8so15930860ljj.0;
        Wed, 04 Nov 2020 00:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i9dtZ7vpXKJRhNNQ4olSprTzNKlL8nUFBc7kyxexUyM=;
        b=vQ9r1kTblkZJFYgAi3+Ise3xdBOd/ux7JOFBy+8I6mUS3i9AXP9/fwUQZfDjC/PkE5
         eLgNPz2VWbT73qMizDZ5QJefhvBhXNNmSwrOexb2EEjCl7DneE9FpZojlTmAYcP3sDgL
         R06kZ0Wa3PvF/i8YBgDQAdtWFjgqqXlac8nJulBhK7VI3Aud9aUE0pNiHgbzY1bAA0te
         iJVB92nstBvStArhlMiBsgK3qj9qE2MlcnF0Q/7VWnTyXinASB0ddLmndnqEFU+LQZEw
         FGdQAVFLYMhYFoJpiK+7eVs3JmUhBFHXyv0u3U35mYWf1VBUSbxSQa1XuvgYARoUGj4B
         pU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i9dtZ7vpXKJRhNNQ4olSprTzNKlL8nUFBc7kyxexUyM=;
        b=Rtr8V06gnMLcfrd7cVVvzJuu+0jLYtqSHRcZ8dctMjaLMOjlMxeiP08+gjwF8FmlUu
         p63ZBtTX+8Lr7QT4fGyWHUvsT/kOQin18qQlT7eVa7X7BQHWI6VANm2SgBR2jGBeqvHa
         +Tk9fTcOjjBOezk3ktOkN6Oxsnvk60my6ioLl43CHQfs66ywyqKZOSCKBYD3OEpO6F6P
         FfrPbh2D5k4qaFQeL0KgqYXep+Ym/OzdwemGmlvA2CUUIzyeuirvhtJSwi6UwI3CeVKn
         G/fFQqvmhioAjet4EzzkVHzeC/Hl7ThOLJstYpyKgwPyX7FDuAzPEVfTgVHZF4P6hWhQ
         +JSA==
X-Gm-Message-State: AOAM53329b3VR7tO1c1enFv/zTo8LF53lrzRKODajfwHHv3cMQKrIKqN
        im9+DGeL5UJtBqtGczfpE8fHwqvzc1rdF3d0h9c=
X-Google-Smtp-Source: ABdhPJxSK2XPvdBBTkKvqSPGFDCGnZ9OgWEFo7T00PubULqVH8Ih1HQNZt/qyYl8Iz8vwCdCWemWhPE2Xals+VQjxUs=
X-Received: by 2002:a2e:984e:: with SMTP id e14mr1775933ljj.110.1604477283596;
 Wed, 04 Nov 2020 00:08:03 -0800 (PST)
MIME-Version: 1.0
References: <20201102100157.85801-1-mtwget@gmail.com> <20201102100157.85801-2-mtwget@gmail.com>
 <20201103113743.5764tj2ryrht4dfs@gilmour.lan>
In-Reply-To: <20201103113743.5764tj2ryrht4dfs@gilmour.lan>
From:   Yu-Tung Chang <mtwget@gmail.com>
Date:   Wed, 4 Nov 2020 16:07:48 +0800
Message-ID: <CAHRgzyOao=w6Yyqqvi1Z26=rfJgumkzDbWLxD+_5uaLmyAWiQA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ARM: dts: sun8i: h3: Add initial NanoPi R1 support
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     robh+dt@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2020=E5=B9=B411=E6=9C=883=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=887:37=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi!
>
> On Mon, Nov 02, 2020 at 06:01:57PM +0800, Yu-Tung Chang wrote:
> > The NanoPi R1 is a complete open source board developed
> > by FriendlyElec for makers, hobbyists, fans and etc.
> >
> > NanoPi R1 key features
> > - Allwinner H3, Quad-core Cortex-A7@1.2GHz
> > - 512MB/1GB DDR3 RAM
> > - 8GB eMMC
> > - microSD slot
> > - 10/100/1000M Ethernet x 1
> > - 10/100 Ethernet x 1
> > - Wifi 802.11b/g/n
> > - Bluetooth 4.0
> > - Serial Debug Port
> > - 5V 2A DC power-supply
> >
> > Signed-off-by: Yu-Tung Chang <mtwget@gmail.com>
> > ---
> >  .../devicetree/bindings/arm/sunxi.yaml        |   5 +
> >  arch/arm/boot/dts/Makefile                    |   1 +
> >  arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts      | 169 ++++++++++++++++++
> >  3 files changed, 175 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts
> >
> > diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documen=
tation/devicetree/bindings/arm/sunxi.yaml
> > index 0f23133672a3..54a1aaee7e22 100644
> > --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> > +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> > @@ -251,6 +251,11 @@ properties:
> >            - const: friendlyarm,nanopi-neo-plus2
> >            - const: allwinner,sun50i-h5
> >
> > +      - description: FriendlyARM NanoPi R1
> > +        items:
> > +          - const: friendlyarm,nanopi-r1
> > +          - const: allwinner,sun8i-h3
> > +
> >        - description: FriendlyARM ZeroPi
> >          items:
> >            - const: friendlyarm,zeropi
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 4f0adfead547..aabaf67f86ed 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -1192,6 +1192,7 @@ dtb-$(CONFIG_MACH_SUN8I) +=3D \
> >       sun8i-h3-nanopi-m1-plus.dtb \
> >       sun8i-h3-nanopi-neo.dtb \
> >       sun8i-h3-nanopi-neo-air.dtb \
> > +     sun8i-h3-nanopi-r1.dtb \
> >       sun8i-h3-orangepi-2.dtb \
> >       sun8i-h3-orangepi-lite.dtb \
> >       sun8i-h3-orangepi-one.dtb \
> > diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts b/arch/arm/boot/d=
ts/sun8i-h3-nanopi-r1.dts
> > new file mode 100644
> > index 000000000000..204a39f93f4e
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts
> > @@ -0,0 +1,169 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (C) 2019 Igor Pecovnik <igor@armbian.com>
> > + * Copyright (C) 2020 Jayantajit Gogoi <jayanta.gogoi525@gmail.com>
> > + * Copyright (C) 2020 Yu-Tung Chang <mtwget@gmail.com>
> > +*/
> > +
> > +#include "sun8i-h3-nanopi.dtsi"
> > +#include <dt-bindings/leds/common.h>
> > +
> > +/ {
> > +     model =3D "FriendlyARM NanoPi R1";
> > +     compatible =3D "friendlyarm,nanopi-r1", "allwinner,sun8i-h3";
> > +
> > +     aliases {
> > +             serial1 =3D &uart1;
> > +             ethernet0 =3D &emac;
> > +             ethernet1 =3D &wifi;
> > +     };
> > +
> > +     reg_gmac_3v3: gmac-3v3 {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "gmac-3v3";
> > +             regulator-min-microvolt =3D <3300000>;
> > +             regulator-max-microvolt =3D <3300000>;
> > +             startup-delay-us =3D <100000>;
> > +             enable-active-high;
> > +             gpio =3D <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
> > +     };
> > +
> > +     reg_vdd_cpux: gpio-regulator {
> > +             compatible =3D "regulator-gpio";
> > +             regulator-name =3D "vdd-cpux";
> > +             regulator-type =3D "voltage";
> > +             regulator-boot-on;
> > +             regulator-always-on;
> > +             regulator-min-microvolt =3D <1100000>;
> > +             regulator-max-microvolt =3D <1300000>;
> > +             regulator-ramp-delay =3D <50>;
> > +             gpios =3D <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
> > +             gpios-states =3D <0x1>;
> > +             states =3D <1100000 0x0
> > +                       1300000 0x1>;
> > +     };
> > +
> > +     wifi_pwrseq: wifi_pwrseq {
> > +             compatible =3D "mmc-pwrseq-simple";
> > +             reset-gpios =3D <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
> > +             clocks =3D <&rtc 1>;
> > +             clock-names =3D "ext_clock";
> > +     };
> > +
> > +     leds {
> > +             led-2 {
> > +                     function =3D LED_FUNCTION_WAN;
> > +                     color =3D <LED_COLOR_ID_GREEN>;
> > +                     gpios =3D <&pio 6 11 GPIO_ACTIVE_HIGH>; /* PG11 *=
/
> > +             };
> > +
> > +             led-3 {
> > +                     function =3D LED_FUNCTION_LAN;
> > +                     color =3D <LED_COLOR_ID_GREEN>;
> > +                     gpios =3D <&pio 0 9 GPIO_ACTIVE_HIGH>; /* PA9 */
> > +             };
> > +     };
> > +};
> > +
> > +&cpu0 {
> > +     cpu-supply =3D <&reg_vdd_cpux>;
> > +};
> > +
> > +&ehci1 {
> > +     status =3D "okay";
> > +};
> > +
> > +&ehci2 {
> > +     status =3D "okay";
> > +};
> > +
> > +&emac {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&emac_rgmii_pins>;
> > +     phy-supply =3D <&reg_gmac_3v3>;
> > +     phy-handle =3D <&ext_rgmii_phy>;
> > +     phy-mode =3D "rgmii-id";
> > +     status =3D "okay";
> > +};
> > +
> > +&external_mdio {
> > +     ext_rgmii_phy: ethernet-phy@7 {
> > +             compatible =3D "ethernet-phy-ieee802.3-c22";
> > +             reg =3D <7>;
> > +     };
> > +};
> > +
> > +&mmc1 {
> > +     vmmc-supply =3D <&reg_vcc3v3>;
> > +     vqmmc-supply =3D <&reg_vcc3v3>;
> > +     mmc-pwrseq =3D <&wifi_pwrseq>;
> > +     bus-width =3D <4>;
> > +     non-removable;
> > +     status =3D "okay";
> > +
> > +     wifi: wifi@1 {
> > +             reg =3D <1>;
> > +             compatible =3D "brcm,bcm4329-fmac";
> > +             interrupt-parent =3D <&pio>;
> > +             interrupts =3D <6 10 IRQ_TYPE_LEVEL_LOW>; /* PG10 / EINT1=
0 */
> > +             interrupt-names =3D "host-wake";
> > +     };
> > +};
> > +
> > +&mmc2 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&mmc2_8bit_pins>;
> > +     vmmc-supply =3D <&reg_vcc3v3>;
> > +     vqmmc-supply =3D <&reg_vcc3v3>;
> > +     bus-width =3D <8>;
> > +     non-removable;
> > +     status =3D "okay";
> > +};
> > +
> > +&ohci1 {
> > +     status =3D "okay";
> > +};
> > +
> > +&ohci2 {
> > +     status =3D "okay";
> > +};
> > +
> > +&reg_usb0_vbus {
> > +     gpio =3D <&r_pio 0 2 GPIO_ACTIVE_HIGH>; /* PL2 */
> > +     status =3D "okay";
> > +};
> > +
> > +&uart1 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&uart1_pins>;
>
> This should be already set in the DTSI
>
uart0 as the debugging interface, uart1 as the external uart port,
uart3 as the bluetooth.
> > +     status =3D "okay";
> > +};
>
> What is this UART used for?
>
uart1 as the external uart port, use a separate physical interface.
> Thanks!
> Maxime

Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2020=E5=B9=B411=E6=9C=883=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=887:37=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi!
>
> On Mon, Nov 02, 2020 at 06:01:57PM +0800, Yu-Tung Chang wrote:
> > The NanoPi R1 is a complete open source board developed
> > by FriendlyElec for makers, hobbyists, fans and etc.
> >
> > NanoPi R1 key features
> > - Allwinner H3, Quad-core Cortex-A7@1.2GHz
> > - 512MB/1GB DDR3 RAM
> > - 8GB eMMC
> > - microSD slot
> > - 10/100/1000M Ethernet x 1
> > - 10/100 Ethernet x 1
> > - Wifi 802.11b/g/n
> > - Bluetooth 4.0
> > - Serial Debug Port
> > - 5V 2A DC power-supply
> >
> > Signed-off-by: Yu-Tung Chang <mtwget@gmail.com>
> > ---
> >  .../devicetree/bindings/arm/sunxi.yaml        |   5 +
> >  arch/arm/boot/dts/Makefile                    |   1 +
> >  arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts      | 169 ++++++++++++++++++
> >  3 files changed, 175 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts
> >
> > diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documen=
tation/devicetree/bindings/arm/sunxi.yaml
> > index 0f23133672a3..54a1aaee7e22 100644
> > --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> > +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> > @@ -251,6 +251,11 @@ properties:
> >            - const: friendlyarm,nanopi-neo-plus2
> >            - const: allwinner,sun50i-h5
> >
> > +      - description: FriendlyARM NanoPi R1
> > +        items:
> > +          - const: friendlyarm,nanopi-r1
> > +          - const: allwinner,sun8i-h3
> > +
> >        - description: FriendlyARM ZeroPi
> >          items:
> >            - const: friendlyarm,zeropi
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 4f0adfead547..aabaf67f86ed 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -1192,6 +1192,7 @@ dtb-$(CONFIG_MACH_SUN8I) +=3D \
> >       sun8i-h3-nanopi-m1-plus.dtb \
> >       sun8i-h3-nanopi-neo.dtb \
> >       sun8i-h3-nanopi-neo-air.dtb \
> > +     sun8i-h3-nanopi-r1.dtb \
> >       sun8i-h3-orangepi-2.dtb \
> >       sun8i-h3-orangepi-lite.dtb \
> >       sun8i-h3-orangepi-one.dtb \
> > diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts b/arch/arm/boot/d=
ts/sun8i-h3-nanopi-r1.dts
> > new file mode 100644
> > index 000000000000..204a39f93f4e
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts
> > @@ -0,0 +1,169 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (C) 2019 Igor Pecovnik <igor@armbian.com>
> > + * Copyright (C) 2020 Jayantajit Gogoi <jayanta.gogoi525@gmail.com>
> > + * Copyright (C) 2020 Yu-Tung Chang <mtwget@gmail.com>
> > +*/
> > +
> > +#include "sun8i-h3-nanopi.dtsi"
> > +#include <dt-bindings/leds/common.h>
> > +
> > +/ {
> > +     model =3D "FriendlyARM NanoPi R1";
> > +     compatible =3D "friendlyarm,nanopi-r1", "allwinner,sun8i-h3";
> > +
> > +     aliases {
> > +             serial1 =3D &uart1;
> > +             ethernet0 =3D &emac;
> > +             ethernet1 =3D &wifi;
> > +     };
> > +
> > +     reg_gmac_3v3: gmac-3v3 {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "gmac-3v3";
> > +             regulator-min-microvolt =3D <3300000>;
> > +             regulator-max-microvolt =3D <3300000>;
> > +             startup-delay-us =3D <100000>;
> > +             enable-active-high;
> > +             gpio =3D <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
> > +     };
> > +
> > +     reg_vdd_cpux: gpio-regulator {
> > +             compatible =3D "regulator-gpio";
> > +             regulator-name =3D "vdd-cpux";
> > +             regulator-type =3D "voltage";
> > +             regulator-boot-on;
> > +             regulator-always-on;
> > +             regulator-min-microvolt =3D <1100000>;
> > +             regulator-max-microvolt =3D <1300000>;
> > +             regulator-ramp-delay =3D <50>;
> > +             gpios =3D <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
> > +             gpios-states =3D <0x1>;
> > +             states =3D <1100000 0x0
> > +                       1300000 0x1>;
> > +     };
> > +
> > +     wifi_pwrseq: wifi_pwrseq {
> > +             compatible =3D "mmc-pwrseq-simple";
> > +             reset-gpios =3D <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
> > +             clocks =3D <&rtc 1>;
> > +             clock-names =3D "ext_clock";
> > +     };
> > +
> > +     leds {
> > +             led-2 {
> > +                     function =3D LED_FUNCTION_WAN;
> > +                     color =3D <LED_COLOR_ID_GREEN>;
> > +                     gpios =3D <&pio 6 11 GPIO_ACTIVE_HIGH>; /* PG11 *=
/
> > +             };
> > +
> > +             led-3 {
> > +                     function =3D LED_FUNCTION_LAN;
> > +                     color =3D <LED_COLOR_ID_GREEN>;
> > +                     gpios =3D <&pio 0 9 GPIO_ACTIVE_HIGH>; /* PA9 */
> > +             };
> > +     };
> > +};
> > +
> > +&cpu0 {
> > +     cpu-supply =3D <&reg_vdd_cpux>;
> > +};
> > +
> > +&ehci1 {
> > +     status =3D "okay";
> > +};
> > +
> > +&ehci2 {
> > +     status =3D "okay";
> > +};
> > +
> > +&emac {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&emac_rgmii_pins>;
> > +     phy-supply =3D <&reg_gmac_3v3>;
> > +     phy-handle =3D <&ext_rgmii_phy>;
> > +     phy-mode =3D "rgmii-id";
> > +     status =3D "okay";
> > +};
> > +
> > +&external_mdio {
> > +     ext_rgmii_phy: ethernet-phy@7 {
> > +             compatible =3D "ethernet-phy-ieee802.3-c22";
> > +             reg =3D <7>;
> > +     };
> > +};
> > +
> > +&mmc1 {
> > +     vmmc-supply =3D <&reg_vcc3v3>;
> > +     vqmmc-supply =3D <&reg_vcc3v3>;
> > +     mmc-pwrseq =3D <&wifi_pwrseq>;
> > +     bus-width =3D <4>;
> > +     non-removable;
> > +     status =3D "okay";
> > +
> > +     wifi: wifi@1 {
> > +             reg =3D <1>;
> > +             compatible =3D "brcm,bcm4329-fmac";
> > +             interrupt-parent =3D <&pio>;
> > +             interrupts =3D <6 10 IRQ_TYPE_LEVEL_LOW>; /* PG10 / EINT1=
0 */
> > +             interrupt-names =3D "host-wake";
> > +     };
> > +};
> > +
> > +&mmc2 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&mmc2_8bit_pins>;
> > +     vmmc-supply =3D <&reg_vcc3v3>;
> > +     vqmmc-supply =3D <&reg_vcc3v3>;
> > +     bus-width =3D <8>;
> > +     non-removable;
> > +     status =3D "okay";
> > +};
> > +
> > +&ohci1 {
> > +     status =3D "okay";
> > +};
> > +
> > +&ohci2 {
> > +     status =3D "okay";
> > +};
> > +
> > +&reg_usb0_vbus {
> > +     gpio =3D <&r_pio 0 2 GPIO_ACTIVE_HIGH>; /* PL2 */
> > +     status =3D "okay";
> > +};
> > +
> > +&uart1 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&uart1_pins>;
>
> This should be already set in the DTSI
>
> > +     status =3D "okay";
> > +};
>
> What is this UART used for?
>
> Thanks!
> Maxime
