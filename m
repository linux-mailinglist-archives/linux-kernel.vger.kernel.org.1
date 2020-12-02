Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1472CC6CA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgLBThm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgLBThl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:37:41 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1665AC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 11:37:01 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id x16so6148224ejj.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dsg8o/7HSlbmxxW3Nfzw1kNdj67cIjZj4QxmLIvtS30=;
        b=MCXCP5Geq/ayh+LIkc+cblIrU6LHzGY67087bQkAj1Q1+QCou6YAW2DMA8+s981wDr
         M8XQWmg4x7d8hphfsWcUCx+4rUK/q4trdBDKUbx0m0Dt5FCfYqgPwptBjoX1dPj8E+R2
         /EHufrwUJDBah38HRZyD+9n+Hp0KpNrqwgBdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dsg8o/7HSlbmxxW3Nfzw1kNdj67cIjZj4QxmLIvtS30=;
        b=KaOyKrSRbSN+cLeTRrx0Pxm1Uus9tAaWuZW4K7qPzvsRnA4AKitwIHbEgO0Y4jGPg1
         cq/ycdWqLisVXjiDOyVJIFcOyBJTqokUBVSvo0WTV5BmTE6GeRguKk2QSCAXDiBH9gNu
         v3nc1pQrq5Yn+U5/XocOit9G5n0K72WU/bXjirkSmYBbP5es9x7fVmacfXousWpoAKLL
         lNALAO/gQN0PKzJDzK/5hUvjHVxwfny0r0nqDwChWwJHhZ/gt+spD3Gh0YCsns1pBzoh
         eY/S48gqLtQpY6xVGSPDM5YV/gftoYNr3+e/zbaP2VGTwa+33hhdBFslIR1e6/pQy5so
         /A2g==
X-Gm-Message-State: AOAM531DIhI2SlPZ+L5X+kKIZtNwW5xsVlwW1GCdSrAr2WlRI4dwxTGR
        cWsFl8j4JlAb7uhW8E12P4YaqhiGarlnkH4J7PVgpg==
X-Google-Smtp-Source: ABdhPJzFr67BNPb6L+Ep9+wqiy0ABK7f40A3jQ7Jhr1hafa6NvBdftTzk2KVnGTT1Bh1zFqZgBYPRG+jbtS9VdkHqH4=
X-Received: by 2002:a17:906:1481:: with SMTP id x1mr1333983ejc.186.1606937819640;
 Wed, 02 Dec 2020 11:36:59 -0800 (PST)
MIME-Version: 1.0
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
 <20201202121241.109952-9-jagan@amarulasolutions.com> <20201202174538.GH3490@kozik-lap>
 <CAMty3ZCv1pBLbXQWbLGqTd+rYPw6L_SbugA5rNdAc8jeWqc6Jg@mail.gmail.com> <20201202192542.GA85884@kozik-lap>
In-Reply-To: <20201202192542.GA85884@kozik-lap>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 3 Dec 2020 01:06:48 +0530
Message-ID: <CAMty3ZBg6b_Zw=xRzmGQqaygW__0sA6E6MRKVmCoMT=BN6wRwA@mail.gmail.com>
Subject: Re: [PATCH 08/10] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
 C.TOUCH 2.0
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

On Thu, Dec 3, 2020 at 12:55 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, Dec 03, 2020 at 12:50:37AM +0530, Jagan Teki wrote:
> > Hi Krzysztof,
> >
> > On Wed, Dec 2, 2020 at 11:15 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > On Wed, Dec 02, 2020 at 05:42:39PM +0530, Jagan Teki wrote:
> > > > i.Core MX8M Mini is an EDIMM SOM based on NXP i.MX8MM from Engicam.
> > > >
> > > > C.TOUCH 2.0 is a general purpose carrier board with capacitive
> > > > touch interface support.
> > > >
> > > > i.Core MX8M Mini needs to mount on top of this Carrier board for
> > > > creating complete i.Core MX8M Mini C.TOUCH 2.0 board.
> > > >
> > > > Add support for it.
> > > >
> > > > Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > ---
> > > >  arch/arm64/boot/dts/freescale/Makefile        |  1 +
> > > >  .../imx8mm-engicam-icore-mx8mm-ctouch2.dts    | 21 +++++++++++++++++++
> > > >  2 files changed, 22 insertions(+)
> > > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2.dts
> > > >
> > > > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > > > index 4369d783dade..8191db4c64fa 100644
> > > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > > @@ -30,6 +30,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
> > > >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
> > > >
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
> > > > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-engicam-icore-mx8mm-ctouch2.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-engicam-icore-mx8mm-edimm2.2.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2.dts b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2.dts
> > > > new file mode 100644
> > > > index 000000000000..aa3c03ad3109
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2.dts
> > > > @@ -0,0 +1,21 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > +/*
> > > > + * Copyright (c) 2019 NXP
> > > > + * Copyright (c) 2019 Engicam srl
> > > > + * Copyright (c) 2020 Amarula Solutions(India)
> > > > + */
> > > > +
> > > > +/dts-v1/;
> > > > +#include "imx8mm.dtsi"
> > >
> > > You have multiple DTSI files to only include one DTSI. I was trying to
> > > follow the logic here but I failed...
> > >
> > > This is ctouch, so it should include SoM, which you call icore. But it
> > > also includes ctouch2 which *only* includes common DTSI. It's then
> > > exactly the same as starter kit which includes edimm (which includes
> > > common) and icore.
> >
> > I hope you have checked the cover letter where I have mentioned all
> > the combinations.
> >
> > 1. SoM, Starter Kit, Carrier Board, Open Frame are three different hardware.
> >
> > 2. i.Core MX8M Mini is SoM
> >
> > 3. EDIMM 2.2 is Starter Kit
> >
> > 4. C.TOUCH 2.0 is Carrier board
> >
> > 5. 10"1 Open Frame board for LVDS
> >
> > The combination of respective hardware mounting is,
> >
> > 1. SOM+Starter Kitt => i.Core MX8M Mini EDIMM 2.2 Starter Kit
> >
> > 2. SOM+C.TOUCH 2.0 => i.Core MX8M Mini C.TOUCH 2.0 Carrier board
> >
> > 3. SOM+C.TOUCH 2.0+10.1" OF => i.Core MX8M Mini C.TOUCH 2.0 10.1" Open
> > Frame board
>
> It does not explain why you created 3 empty DTSI and 2 empty DTS files.
>
> >
> > About the bindings, (please check the
> > arch/arm64/boot/dts/rockchip/px30-engicam-*), It's been discussed
> > before with Rob for these boards bindings.
>
> Refer to my specific comments about bindings.
>
> >
> > To, compare with what we have described with rockchip
> >
> > SoM binding,
> > - engicam,icore-mx8mm is binding for i.Core MX8M Mini SoM
> > - engicam,px30-core is binding for PX30.Core SoM
> >
> > EDIMM 2.2 is Starter Kit binding,
> > - engicam,icore-mx8mm-edimm2.2 is binding for EDIMM 2.2 is Starter Kit
> > in i.MX8MM
> > - engicam,px30-core-edimm2.2 is binding for EDIMM 2.2 is Starter Kit in PX30
> >
> > C.TOUCH 2.0 is Carrier board binding,
> > - engicam,icore-mx8mm-ctouch2 is binding for C.TOUCH 2.0 is Carrier
> > board in i.MX8MM
> > - engicam,px30-core-ctouch2 is binding for C.TOUCH 2.0 is Carrier board in PX30
> >
> > C.TOUCH 2.0 10"1 OF binding,
> > - engicam,icore-mx8mm-ctouch2-of10 is binding for C.TOUCH 2.0 10"1 in imx8MM
> > - engicam,px30-core-ctouch2-of10 for C.TOUCH 2.0 10"1 in PX30
> >
> > So, there are 3 board combinations of which each board has a binding
> > of SoM and respective carrier binding like i.Core MX8M Mini EDIMM 2.2
> > Starter Kit has
> > "engicam,icore-mx8mm-edimm2.2", "engicam,icore-mx8mm"
> > "engicam,icore-mx8mm-ctouch2", "engicam,icore-mx8mm"
> > "engicam,icore-mx8mm-ctouch2-of10", "engicam,icore-mx8mm"
> >
> > Some of the DTS files are using the engicam-common.dtsi nodes and for
> > ie reason those are empty and some need to have lvds display node
> > which is still underworking.
>
> Therefore add them when you have any contents for these DTS files.
>
> >
> > Hope this information helpful. Let me know for further inputs.
>
> Thanks for the information but it was not much helpful. It does not
> answer at all why you have so many empty files, why you include
> imx8mm.dtsi not in the SoM but somewhere else.

Sorry, I have missed it.

All these three carrier board dtsi files,

imx8mm-engicam-edimm2.2.dtsi
imx8mm-engicam-icore-mx8mm-ctouch2.dts
imx8mm-engicam-icore-mx8mm-ctouch2-of10.dts

are included imx8mm-engicam-common.dtsi. ie is the reason these are empty.

And I agree with your point of adding whenever it ready. I will drop
display related carrier imx8mm-engicam-icore-mx8mm-ctouch2-of10.dts
when DSI, LVDS ready, and update on next versions.

Thanks for the review.

Jagan.
