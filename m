Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148472CC69A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbgLBT02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:26:28 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33868 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgLBT01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:26:27 -0500
Received: by mail-ed1-f68.google.com with SMTP id y22so5285395edv.1;
        Wed, 02 Dec 2020 11:26:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eYcaogqYzN6ZUt28+vyieuwTVixxxaeMvV8MlkHBuEo=;
        b=WYYscVNw0wP9kFF2QtQrlI2wkFbCerW8TB2pYPhjTFFMx1hXJYhSdkSTfBuELVTmPz
         pG5+au/hAhk5O336mdGbfoy7yHWjhdj5mLv/kY/QKab1Ly6QgVuTRv2hdzxe8Yk2gf0M
         59g81pCAAwbF+QdeZYpCn9KhXyh5BXyaoYlIQBW4CcW/k8tU9tIbwJ5msiMqZN61j4a5
         D1gsbmTMzvv4heQgJWCKz8LDBtnolOH7ZHOTKv3zmzteaB2VRZeTmPnsJu0pdI25uHx2
         8kQF3+wYzqgVDMtvHnS+1BJ0PLce5fQxmJQ3XRoA8Mx5jBsABClAti/1usZNeKIqARBP
         qvsA==
X-Gm-Message-State: AOAM533/UBu2AEGqXahD5rWB7E4adQHI3W3LQnzOtf1TBAKylzQ2Bvhl
        FjZ5SiEf+U7RzSDWYErP7MQ=
X-Google-Smtp-Source: ABdhPJxagTWtEJZPAPkpLJVZKLSduip+7GVycNBghRDTPBs9MQMJGf/06IKdC4IlOggUC5dAuIsXnA==
X-Received: by 2002:a50:e0ce:: with SMTP id j14mr1531711edl.18.1606937145269;
        Wed, 02 Dec 2020 11:25:45 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id c25sm533612ejx.39.2020.12.02.11.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:25:43 -0800 (PST)
Date:   Wed, 2 Dec 2020 21:25:42 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Subject: Re: [PATCH 08/10] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
 C.TOUCH 2.0
Message-ID: <20201202192542.GA85884@kozik-lap>
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
 <20201202121241.109952-9-jagan@amarulasolutions.com>
 <20201202174538.GH3490@kozik-lap>
 <CAMty3ZCv1pBLbXQWbLGqTd+rYPw6L_SbugA5rNdAc8jeWqc6Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMty3ZCv1pBLbXQWbLGqTd+rYPw6L_SbugA5rNdAc8jeWqc6Jg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 12:50:37AM +0530, Jagan Teki wrote:
> Hi Krzysztof,
> 
> On Wed, Dec 2, 2020 at 11:15 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Wed, Dec 02, 2020 at 05:42:39PM +0530, Jagan Teki wrote:
> > > i.Core MX8M Mini is an EDIMM SOM based on NXP i.MX8MM from Engicam.
> > >
> > > C.TOUCH 2.0 is a general purpose carrier board with capacitive
> > > touch interface support.
> > >
> > > i.Core MX8M Mini needs to mount on top of this Carrier board for
> > > creating complete i.Core MX8M Mini C.TOUCH 2.0 board.
> > >
> > > Add support for it.
> > >
> > > Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/Makefile        |  1 +
> > >  .../imx8mm-engicam-icore-mx8mm-ctouch2.dts    | 21 +++++++++++++++++++
> > >  2 files changed, 22 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2.dts
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > > index 4369d783dade..8191db4c64fa 100644
> > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > @@ -30,6 +30,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
> > >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
> > >
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
> > > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-engicam-icore-mx8mm-ctouch2.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-engicam-icore-mx8mm-edimm2.2.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2.dts b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2.dts
> > > new file mode 100644
> > > index 000000000000..aa3c03ad3109
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm-ctouch2.dts
> > > @@ -0,0 +1,21 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +/*
> > > + * Copyright (c) 2019 NXP
> > > + * Copyright (c) 2019 Engicam srl
> > > + * Copyright (c) 2020 Amarula Solutions(India)
> > > + */
> > > +
> > > +/dts-v1/;
> > > +#include "imx8mm.dtsi"
> >
> > You have multiple DTSI files to only include one DTSI. I was trying to
> > follow the logic here but I failed...
> >
> > This is ctouch, so it should include SoM, which you call icore. But it
> > also includes ctouch2 which *only* includes common DTSI. It's then
> > exactly the same as starter kit which includes edimm (which includes
> > common) and icore.
> 
> I hope you have checked the cover letter where I have mentioned all
> the combinations.
> 
> 1. SoM, Starter Kit, Carrier Board, Open Frame are three different hardware.
> 
> 2. i.Core MX8M Mini is SoM
> 
> 3. EDIMM 2.2 is Starter Kit
> 
> 4. C.TOUCH 2.0 is Carrier board
> 
> 5. 10"1 Open Frame board for LVDS
> 
> The combination of respective hardware mounting is,
> 
> 1. SOM+Starter Kitt => i.Core MX8M Mini EDIMM 2.2 Starter Kit
> 
> 2. SOM+C.TOUCH 2.0 => i.Core MX8M Mini C.TOUCH 2.0 Carrier board
> 
> 3. SOM+C.TOUCH 2.0+10.1" OF => i.Core MX8M Mini C.TOUCH 2.0 10.1" Open
> Frame board

It does not explain why you created 3 empty DTSI and 2 empty DTS files.

> 
> About the bindings, (please check the
> arch/arm64/boot/dts/rockchip/px30-engicam-*), It's been discussed
> before with Rob for these boards bindings.

Refer to my specific comments about bindings.

> 
> To, compare with what we have described with rockchip
> 
> SoM binding,
> - engicam,icore-mx8mm is binding for i.Core MX8M Mini SoM
> - engicam,px30-core is binding for PX30.Core SoM
> 
> EDIMM 2.2 is Starter Kit binding,
> - engicam,icore-mx8mm-edimm2.2 is binding for EDIMM 2.2 is Starter Kit
> in i.MX8MM
> - engicam,px30-core-edimm2.2 is binding for EDIMM 2.2 is Starter Kit in PX30
> 
> C.TOUCH 2.0 is Carrier board binding,
> - engicam,icore-mx8mm-ctouch2 is binding for C.TOUCH 2.0 is Carrier
> board in i.MX8MM
> - engicam,px30-core-ctouch2 is binding for C.TOUCH 2.0 is Carrier board in PX30
> 
> C.TOUCH 2.0 10"1 OF binding,
> - engicam,icore-mx8mm-ctouch2-of10 is binding for C.TOUCH 2.0 10"1 in imx8MM
> - engicam,px30-core-ctouch2-of10 for C.TOUCH 2.0 10"1 in PX30
> 
> So, there are 3 board combinations of which each board has a binding
> of SoM and respective carrier binding like i.Core MX8M Mini EDIMM 2.2
> Starter Kit has
> "engicam,icore-mx8mm-edimm2.2", "engicam,icore-mx8mm"
> "engicam,icore-mx8mm-ctouch2", "engicam,icore-mx8mm"
> "engicam,icore-mx8mm-ctouch2-of10", "engicam,icore-mx8mm"
> 
> Some of the DTS files are using the engicam-common.dtsi nodes and for
> ie reason those are empty and some need to have lvds display node
> which is still underworking.

Therefore add them when you have any contents for these DTS files.

> 
> Hope this information helpful. Let me know for further inputs.

Thanks for the information but it was not much helpful. It does not
answer at all why you have so many empty files, why you include
imx8mm.dtsi not in the SoM but somewhere else.

Best regards,
Krzysztof
