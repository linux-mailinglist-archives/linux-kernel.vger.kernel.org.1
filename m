Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA482F508F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbhAMRCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbhAMRCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:02:54 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F77C061786;
        Wed, 13 Jan 2021 09:02:14 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id d17so4066265ejy.9;
        Wed, 13 Jan 2021 09:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fsWIg5PACIqAQJkpSAiP4B6rfnQipTypsk8Y+STOLi0=;
        b=qyQkKbeC2eS39CibHBCiHmzDHzmkQZRskxPevYrlIpMEYq6bDd6UpBMB6myP+QW76U
         ikhBF97+rbfkSP7ruA2aC/h1aYJ/P5VGQNjB98chOAXQX68IGpx+hJ1+46yy5XloDSZI
         4uZd/GLnV6GKrR9/ozKD0rHOQmKjCu2CVfVQSJoSvAHkeSyzr+GNVU4BmF2E6L9kTcHs
         EbTJQixyAu0l/MKXV8NWD3VFHEhwRE160Tpr3niLGAryrgPvJjEgWpiNhnRLj/EeKLhK
         HNe5HLKcZ8FvBvHNaROhjSVKJtl2hwIn9Vm4YNPH4SU3X+TStrlvcVFlpPhrc/x+zyXG
         VHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fsWIg5PACIqAQJkpSAiP4B6rfnQipTypsk8Y+STOLi0=;
        b=XGCiApgNJVE0Rt2uGJpi4Q+jgLDc7inHs0pLhCeOiMuzGqmQ0D9fWmQ6Ie5/LFabNK
         qrIakc63sm3ugFs3SivG8vYGXsZ39GPNga8YCcCpCAirUhh2GGv1Os7CTuwujAVj0cit
         12iFvOa+JxCMVeY2ccb/NJl7njVFc2uaXA4U2xg68PH6Yrsg3RX8u0KuEumhvcuYuADg
         fGjyNEo8DZHM9w6LgblFVbsabcdWiHm+ns35bcWR7rs0jlEblQWhTEAwz+lZxmEbg+P3
         yWo1xMxMkLVs7nJlzoZ4RUvDBSDqmtWT4+vvs30WSszeW79kkcYn9R5KRwsoS6xkWm58
         0amQ==
X-Gm-Message-State: AOAM5337gqcqUomFGjjdiAlVerM9eD60sbj5tsS/lBHn04ImdMW3EW+p
        8N72ewlExWu4oJQUitCJxvWGLdHp7D0XiMeJocI=
X-Google-Smtp-Source: ABdhPJx+qz2C1QhAWm1qgHb1sbEhabkkxIg/EgF03QgHX5jmRAEuLd1TaBceIiWfbncxdy3bd7imxyxBDsJkxEZSHAo=
X-Received: by 2002:a17:906:4443:: with SMTP id i3mr2136231ejp.133.1610557332757;
 Wed, 13 Jan 2021 09:02:12 -0800 (PST)
MIME-Version: 1.0
References: <20210113143443.1148506-1-adrien.grassein@gmail.com>
 <20210113143443.1148506-3-adrien.grassein@gmail.com> <20210113164619.GA5874@kozik-lap>
In-Reply-To: <20210113164619.GA5874@kozik-lap>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Wed, 13 Jan 2021 18:02:01 +0100
Message-ID: <CABkfQAFN5u8wexHHCs-umZj3o2dMBQB4_+8OVAeGe0OvV12g5Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: imx: Add i.mx8mm nitrogen8mm basic dts support
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 13 janv. 2021 =C3=A0 17:46, Krzysztof Kozlowski <krzk@kernel.org> a=
 =C3=A9crit :
>
> On Wed, Jan 13, 2021 at 03:34:42PM +0100, Adrien Grassein wrote:
> > Tested with a basic Build Root configuration booting from sdcard.
> >
> > Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> >  .../dts/freescale/imx8mm-nitrogen8mm_rev2.dts | 364 ++++++++++++++++++
> >  2 files changed, 365 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_re=
v2.dts
> >
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/d=
ts/freescale/Makefile
> > index 901d80086b47..b2eb7a5e4db3 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -45,6 +45,7 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-librem5-devkit.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-librem5-r2.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-librem5-r3.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-nitrogen.dtb
> > +dtb-$(CONFIG_ARCH_MXC) +=3D imx8mm-nitrogen8mm_rev2.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-phanbell.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-pico-pi.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-thor96.dtb
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts =
b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts
> > new file mode 100644
> > index 000000000000..506e467ebf16
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts
> > @@ -0,0 +1,364 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Device Tree file for Boundary Devices i.MX8MMini Nitrogen8MM Rev2 b=
oard.
> > + * Adrien Grassein <adrien.grassein@gmail.com.com>
> > + */
> > +/dts-v1/;
> > +#include "imx8mm.dtsi"
> > +
> > +/ {
> > +     model =3D "Boundary Devices i.MX8MMini Nitrogen8MM Rev2";
> > +     compatible =3D "boundary,imx8mm-nitrogen8mm", "fsl,imx8mm";
> > +
> > +     reg_vref_1v8: regulator-vref-1v8 {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "vref-1v8";
> > +             regulator-min-microvolt =3D <1800000>;
> > +             regulator-max-microvolt =3D <1800000>;
> > +     };
> > +
> > +     reg_vref_3v3: regulator-vref-3v3 {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "vref-3v3";
> > +             regulator-min-microvolt =3D <3300000>;
> > +             regulator-max-microvolt =3D <3300000>;
> > +     };
>
> Why do you need these two regulators? They don't do anything, there is
> no control over them.
>

Sorry, I guess it was usefull for the eMMc, but after a test, it xas not.
It will be removed in v3.

> > +};
> > +
> > +&A53_0 {
> > +     cpu-supply =3D <&reg_sw3>;
> > +};
> > +
> > +&A53_1 {
> > +     cpu-supply =3D <&reg_sw3>;
> > +};
> > +
> > +&A53_2 {
> > +     cpu-supply =3D <&reg_sw3>;
> > +};
> > +
> > +&A53_3 {
> > +     cpu-supply =3D <&reg_sw3>;
> > +};
> > +
> > +&i2c1 {
> > +     clock-frequency =3D <400000>;
> > +     pinctrl-names =3D "default", "gpio";
> > +     pinctrl-0 =3D <&pinctrl_i2c1>;
> > +     pinctrl-1 =3D <&pinctrl_i2c1_1>;
> > +     scl-gpios =3D <&gpio5 14 GPIO_OPEN_DRAIN>;
> > +     sda-gpios =3D <&gpio5 15 GPIO_OPEN_DRAIN>;
> > +     status =3D "okay";
> > +
> > +     pmic@8 {
> > +             compatible =3D "nxp,pf8121a";
> > +             reg =3D <0x8>;
> > +             status =3D "okay";
> > +
> > +             regulators {
> > +                     reg_ldo2: ldo2 {
>
> The PMIC regulators should be described fully, so bring them back from
> the v1.
>
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-max-microvolt =3D <5000000>;
> > +                             regulator-min-microvolt =3D <1500000>;
> > +                     };
> > +
> > +                     reg_sw3: buck3 {
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-max-microvolt =3D <1800000>;
> > +                             regulator-min-microvolt =3D  <400000>;
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&fec1 {
>
> Please order the overridden nodes alphabetically, with iomux exception
> which goes to the end (by convention in NXP). You define i2c1, then fec1
> and then i2c3. Should be fec1, i2c1 and then i2c3.
>
> Best regards,
> Krzysztof


Thanks a lot for you reviews,
Best regards,
Adrien
