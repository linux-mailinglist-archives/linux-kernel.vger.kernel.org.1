Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8A12CC679
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbgLBTVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgLBTVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:21:37 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BB7C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 11:20:50 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id jx16so6058011ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XIV8LJnE3lARpb+8mz8h4ToFKMsLrut7wmR/STxIdEE=;
        b=kgTd4n3jbvmRDM3bC1z5ztn0kKTwXEZFM4YcVi4tN+GRrhGe3qJxKxKi6rX0UlA3tg
         d1FbKioOtjLGEorIH0HDxNAq4zAF0bY1/AiVBqhINeeAb7Dkol6ZT3oOGqunFTHHd1P9
         c8hsNNIULUJv+UW61fZskqZGgDl2Ire8/mPdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIV8LJnE3lARpb+8mz8h4ToFKMsLrut7wmR/STxIdEE=;
        b=O5/KxEgPJicNdCuTD73FV+RAlz5ssSQubWoctVA5TJGjT7UXPr0bOZvGRcWeJMu+CC
         ULWqq8FUui02Z3y0QnFZRJYk8RAxCpvJRIoXJOoSCLvQ8CVK/CQgLj53l7oXTTCjOpoW
         06sq4iwFrPAsAQdPH5tbTWNLqkDo3e3Rjslc1xKPbioy2SSBYsvJzqQO8zi6zC4SGZ8g
         ti5WMREvZNfLm41PXD3VxT7E4uY6ve6muoXp5tEdx6sZHy8Ki+27/4PYP+BRuuqO+C1a
         NwE5qwvFCS2HpNXzBeQVtk7SmbpyCISPkL2KU7sTRA9bFBizKJJmlETgaLswdzRojDBA
         UH9Q==
X-Gm-Message-State: AOAM531k7QHjzR8b5z5M5pYzqh2P+WRlRcKLWXLvu9CpDdnYkX1rg6jg
        03Ab5h7aNKeY8JCTEpLYOJc9KUy63BxuTabLHzVnbg==
X-Google-Smtp-Source: ABdhPJxcJ9isynE61g/CfkPMMyJTZMU+9i1nIo2HNUXJ+vhb6u/iUAh7OBnXZteZbswI3KKDoW36iKdEa9H786uMDVA=
X-Received: by 2002:a17:906:26cc:: with SMTP id u12mr1250114ejc.295.1606936849372;
 Wed, 02 Dec 2020 11:20:49 -0800 (PST)
MIME-Version: 1.0
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
 <20201202121241.109952-9-jagan@amarulasolutions.com> <20201202174538.GH3490@kozik-lap>
In-Reply-To: <20201202174538.GH3490@kozik-lap>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 3 Dec 2020 00:50:37 +0530
Message-ID: <CAMty3ZCv1pBLbXQWbLGqTd+rYPw6L_SbugA5rNdAc8jeWqc6Jg@mail.gmail.com>
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

Hi Krzysztof,

On Wed, Dec 2, 2020 at 11:15 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, Dec 02, 2020 at 05:42:39PM +0530, Jagan Teki wrote:
> > i.Core MX8M Mini is an EDIMM SOM based on NXP i.MX8MM from Engicam.
> >
> > C.TOUCH 2.0 is a general purpose carrier board with capacitive
> > touch interface support.
> >
> > i.Core MX8M Mini needs to mount on top of this Carrier board for
> > creating complete i.Core MX8M Mini C.TOUCH 2.0 board.
> >
> > Add support for it.
> >
> > Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile        |  1 +
> >  .../imx8mm-engicam-icore-mx8mm-ctouch2.dts    | 21 +++++++++++++++++++
> >  2 files changed, 22 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2.dts
> >
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > index 4369d783dade..8191db4c64fa 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -30,6 +30,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
> >
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
> > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-engicam-icore-mx8mm-ctouch2.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-engicam-icore-mx8mm-edimm2.2.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2.dts b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2.dts
> > new file mode 100644
> > index 000000000000..aa3c03ad3109
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2.dts
> > @@ -0,0 +1,21 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2019 NXP
> > + * Copyright (c) 2019 Engicam srl
> > + * Copyright (c) 2020 Amarula Solutions(India)
> > + */
> > +
> > +/dts-v1/;
> > +#include "imx8mm.dtsi"
>
> You have multiple DTSI files to only include one DTSI. I was trying to
> follow the logic here but I failed...
>
> This is ctouch, so it should include SoM, which you call icore. But it
> also includes ctouch2 which *only* includes common DTSI. It's then
> exactly the same as starter kit which includes edimm (which includes
> common) and icore.

I hope you have checked the cover letter where I have mentioned all
the combinations.

1. SoM, Starter Kit, Carrier Board, Open Frame are three different hardware.

2. i.Core MX8M Mini is SoM

3. EDIMM 2.2 is Starter Kit

4. C.TOUCH 2.0 is Carrier board

5. 10"1 Open Frame board for LVDS

The combination of respective hardware mounting is,

1. SOM+Starter Kitt => i.Core MX8M Mini EDIMM 2.2 Starter Kit

2. SOM+C.TOUCH 2.0 => i.Core MX8M Mini C.TOUCH 2.0 Carrier board

3. SOM+C.TOUCH 2.0+10.1" OF => i.Core MX8M Mini C.TOUCH 2.0 10.1" Open
Frame board

About the bindings, (please check the
arch/arm64/boot/dts/rockchip/px30-engicam-*), It's been discussed
before with Rob for these boards bindings.

To, compare with what we have described with rockchip

SoM binding,
- engicam,icore-mx8mm is binding for i.Core MX8M Mini SoM
- engicam,px30-core is binding for PX30.Core SoM

EDIMM 2.2 is Starter Kit binding,
- engicam,icore-mx8mm-edimm2.2 is binding for EDIMM 2.2 is Starter Kit
in i.MX8MM
- engicam,px30-core-edimm2.2 is binding for EDIMM 2.2 is Starter Kit in PX30

C.TOUCH 2.0 is Carrier board binding,
- engicam,icore-mx8mm-ctouch2 is binding for C.TOUCH 2.0 is Carrier
board in i.MX8MM
- engicam,px30-core-ctouch2 is binding for C.TOUCH 2.0 is Carrier board in PX30

C.TOUCH 2.0 10"1 OF binding,
- engicam,icore-mx8mm-ctouch2-of10 is binding for C.TOUCH 2.0 10"1 in imx8MM
- engicam,px30-core-ctouch2-of10 for C.TOUCH 2.0 10"1 in PX30

So, there are 3 board combinations of which each board has a binding
of SoM and respective carrier binding like i.Core MX8M Mini EDIMM 2.2
Starter Kit has
"engicam,icore-mx8mm-edimm2.2", "engicam,icore-mx8mm"
"engicam,icore-mx8mm-ctouch2", "engicam,icore-mx8mm"
"engicam,icore-mx8mm-ctouch2-of10", "engicam,icore-mx8mm"

Some of the DTS files are using the engicam-common.dtsi nodes and for
ie reason those are empty and some need to have lvds display node
which is still underworking.

Hope this information helpful. Let me know for further inputs.

Jagan.
