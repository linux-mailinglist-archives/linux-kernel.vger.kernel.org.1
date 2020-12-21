Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E8C2E0111
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 20:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgLUTeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 14:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgLUTeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 14:34:00 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8E4C061282
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 11:33:20 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id j22so14999018eja.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 11:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pb1m+eHhWw+yOXKOAnhn6l+hywm6OGgR2u/XR7HjvII=;
        b=h26DYkpqx32ip/b6q/4C8kMeM8GbTSR0NR5L8UoOmvKIy9o/VpcDLBuKJlKgdx8G1r
         HZ5v2r/bT3psa8oMnj8AHOtwADEfFpP389O91qC9GSHcwHEoIEzbliG6Y5i+nbJ5zDY3
         XaRcq5OlHGr8QIfL6X5q64udokFl1SkVztQvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pb1m+eHhWw+yOXKOAnhn6l+hywm6OGgR2u/XR7HjvII=;
        b=jH0HHIrE+bRseRG4xgAECiOsYiohTPOgEqjMVthqyjE3tZDQaSNLMqMKDejkmiI6T8
         3kNyMvVgEVQ8lOum1ctGOat5wd/ahQbEeCZDriyK+JkUzCM32FBluqKP2b4AUgY9U4+n
         Wx1AdRGg6tIg5H+kx1wISdtzYVGhfXtvxbdZAfsLTYKE29Ug3aOwQNqcU8EdPEkVlLLj
         TLWXvJo7dOGioiJnAC0TXLJvDlnTA2ZRAU7rgM51qoLML2hkthI9v9DX7e03YTnTMj2J
         BBpQX5LDORsvEB8QMeaZQg8rx2jfvHKqaA9hyBehtXBy5o5ruHWtpDMW7xpu+aL8s68X
         5Dew==
X-Gm-Message-State: AOAM530+qKKcZRBsAl2xW90fhaxFidQRSdr90ErthAKZzYUwmPA3IDai
        wP7pMV7450hWSrLLd2xidcDNm6QG94XclNSlBJSxcA==
X-Google-Smtp-Source: ABdhPJxrRJkhtvKdQvdWpu00aAd7fHCVYwl0DO8M3A1Z9aI2vXDj+Z8Dm/ZyRbRIbwNVZDnN+K2kB2ZvWTTgxkaEacA=
X-Received: by 2002:a17:906:c310:: with SMTP id s16mr16805482ejz.186.1608579199023;
 Mon, 21 Dec 2020 11:33:19 -0800 (PST)
MIME-Version: 1.0
References: <20201221113151.94515-1-jagan@amarulasolutions.com>
 <20201221113151.94515-7-jagan@amarulasolutions.com> <20201221140642.GF31176@kozik-lap>
In-Reply-To: <20201221140642.GF31176@kozik-lap>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 22 Dec 2020 01:03:07 +0530
Message-ID: <CAMty3ZDWoorJ6y2zATAyd10TqbOAcjMdAkdini5tKt1euY0_7Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
 EDIMM2.2 Starter Kit
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matteo Lisi <matteo.lisi@engicam.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 7:36 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Mon, Dec 21, 2020 at 05:01:51PM +0530, Jagan Teki wrote:
> > Engicam EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive
> > Evaluation Board.
> >
> > Genaral features:
> > - LCD 7" C.Touch
> > - microSD slot
> > - Ethernet 1Gb
> > - Wifi/BT
> > - 2x LVDS Full HD interfaces
> > - 3x USB 2.0
> > - 1x USB 3.0
> > - HDMI Out
> > - Mini PCIe
> > - MIPI CSI
> > - 2x CAN
> > - Audio Out
> >
> > i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.
> >
> > i.Core MX8M Mini needs to mount on top of this Evaluation board for
> > creating complete i.Core MX8M Mini EDIMM2.2 Starter Kit.
> >
> > PCIe, DSI, CSI nodes will add it into imx8mm-engicam-edimm2.2.dtsi once
> > Mainline Linux supported.
> >
> > Add support for it.
> >
> > Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v2:
> > - updated commit message
> > - dropped engicam from filename since it aligned with imx6 engicam
> >   dts files naming conventions.
> >
> >  arch/arm64/boot/dts/freescale/Makefile        |  1 +
> >  .../freescale/imx8mm-engicam-edimm2.2.dtsi    |  7 +++++++
> >  .../freescale/imx8mm-icore-mx8mm-edimm2.2.dts | 21 +++++++++++++++++++
> >  3 files changed, 29 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-edimm2.2.dtsi
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dts
> >
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > index 8d49a2c74604..43783076f856 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -33,6 +33,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-ctouch2.dtb
> > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-edimm2.2.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-n801x-s.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-edimm2.2.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-engicam-edimm2.2.dtsi
> > new file mode 100644
> > index 000000000000..294df07289a2
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-edimm2.2.dtsi
> > @@ -0,0 +1,7 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2020 Engicam srl
> > + * Copyright (c) 2020 Amarula Solutions(India)
> > + */
> > +
> > +#include "imx8mm-engicam-common.dtsi"
>
> It seems you ignored my comments from previous email. That's not how we
> go with the process.
>
> Don't create confusing or overcomplicated hierarchy of includes. Don't
> create files which do nothing.

Idea is to move common nodes in separate dtsi instead of adding
redundant nodes into respective areas. let me know if it still
confusing.

Jagan.
