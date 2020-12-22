Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFFB2E077C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 09:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgLVIyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 03:54:17 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:53759 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLVIyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 03:54:16 -0500
Received: by mail-wm1-f45.google.com with SMTP id k10so1188624wmi.3;
        Tue, 22 Dec 2020 00:53:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QtE5e6AYSIzZbtOwGMsWWC8Csg+80tvhfv7BAVQIge0=;
        b=byOct+80rCy63UQQrsrccilG0KNlHR52BcdAgRD6oqB7IP4czWjs3xf9sLY92Iyw95
         /EdfhAjnyR+TlaLaUw/o2tMX1v5T6bVBBVh44fjhpDi7AqETDXq2rHeBJgp6ddjyTV6O
         3D9uTQPShe22ScQM3G20PtOJUUG4b7+38ayzgr5/o0foSiQIu0kqpjhzqYyEUnYg3nJI
         HHlEmT+kdwfld339aWvphEYpXeMmgBlRXucmvt8o7zBCHHx6/6sA1t97g8hRePgufORS
         QvXJ/KjKwNImRrgz3e2yhfN8bgAsAUfOcMU8E0eafcFbiZd4Xg9HGsHS8Xd46Oulg8Dk
         D/DA==
X-Gm-Message-State: AOAM531tmxNriufoYoWDRhS/FGc+XxnScVnQdcIPAQBUx8H57pxfZjg7
        DJj82+qVjNpx26W4jYdQ9+7UzhAOz5Z8ZA==
X-Google-Smtp-Source: ABdhPJxDmZ+hatd7pHWg3ft7wJ7iGB4B2ZASvd+18Obbp6kz5eMH5YAE0LxIclunGy8stz5FmbTwEg==
X-Received: by 2002:a7b:c8cd:: with SMTP id f13mr19979547wml.56.1608627213429;
        Tue, 22 Dec 2020 00:53:33 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id m5sm19686723wrz.18.2020.12.22.00.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 00:53:32 -0800 (PST)
Date:   Tue, 22 Dec 2020 09:53:30 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
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
Subject: Re: [PATCH v2 6/6] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
 EDIMM2.2 Starter Kit
Message-ID: <20201222085330.GA15568@kozik-lap>
References: <20201221113151.94515-1-jagan@amarulasolutions.com>
 <20201221113151.94515-7-jagan@amarulasolutions.com>
 <20201221140642.GF31176@kozik-lap>
 <CAMty3ZDWoorJ6y2zATAyd10TqbOAcjMdAkdini5tKt1euY0_7Q@mail.gmail.com>
 <20201221210601.GB2504@kozik-lap>
 <CAMty3ZDbSdv9k+SK=tEs-jNNDvGAASt-0zQjo0i3KseTLixSVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMty3ZDbSdv9k+SK=tEs-jNNDvGAASt-0zQjo0i3KseTLixSVQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 02:20:55PM +0530, Jagan Teki wrote:
> On Tue, Dec 22, 2020 at 2:36 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Tue, Dec 22, 2020 at 01:03:07AM +0530, Jagan Teki wrote:
> > > On Mon, Dec 21, 2020 at 7:36 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > >
> > > > On Mon, Dec 21, 2020 at 05:01:51PM +0530, Jagan Teki wrote:
> > > > > Engicam EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive
> > > > > Evaluation Board.
> > > > >
> > > > > Genaral features:
> > > > > - LCD 7" C.Touch
> > > > > - microSD slot
> > > > > - Ethernet 1Gb
> > > > > - Wifi/BT
> > > > > - 2x LVDS Full HD interfaces
> > > > > - 3x USB 2.0
> > > > > - 1x USB 3.0
> > > > > - HDMI Out
> > > > > - Mini PCIe
> > > > > - MIPI CSI
> > > > > - 2x CAN
> > > > > - Audio Out
> > > > >
> > > > > i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.
> > > > >
> > > > > i.Core MX8M Mini needs to mount on top of this Evaluation board for
> > > > > creating complete i.Core MX8M Mini EDIMM2.2 Starter Kit.
> > > > >
> > > > > PCIe, DSI, CSI nodes will add it into imx8mm-engicam-edimm2.2.dtsi once
> > > > > Mainline Linux supported.
> > > > >
> > > > > Add support for it.
> > > > >
> > > > > Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > ---
> > > > > Changes for v2:
> > > > > - updated commit message
> > > > > - dropped engicam from filename since it aligned with imx6 engicam
> > > > >   dts files naming conventions.
> > > > >
> > > > >  arch/arm64/boot/dts/freescale/Makefile        |  1 +
> > > > >  .../freescale/imx8mm-engicam-edimm2.2.dtsi    |  7 +++++++
> > > > >  .../freescale/imx8mm-icore-mx8mm-edimm2.2.dts | 21 +++++++++++++++++++
> > > > >  3 files changed, 29 insertions(+)
> > > > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-edimm2.2.dtsi
> > > > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dts
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > > > > index 8d49a2c74604..43783076f856 100644
> > > > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > > > @@ -33,6 +33,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
> > > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
> > > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
> > > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-ctouch2.dtb
> > > > > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-edimm2.2.dtb
> > > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-n801x-s.dtb
> > > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
> > > > >  dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
> > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-edimm2.2.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-engicam-edimm2.2.dtsi
> > > > > new file mode 100644
> > > > > index 000000000000..294df07289a2
> > > > > --- /dev/null
> > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-edimm2.2.dtsi
> > > > > @@ -0,0 +1,7 @@
> > > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > > +/*
> > > > > + * Copyright (c) 2020 Engicam srl
> > > > > + * Copyright (c) 2020 Amarula Solutions(India)
> > > > > + */
> > > > > +
> > > > > +#include "imx8mm-engicam-common.dtsi"
> > > >
> > > > It seems you ignored my comments from previous email. That's not how we
> > > > go with the process.
> > > >
> > > > Don't create confusing or overcomplicated hierarchy of includes. Don't
> > > > create files which do nothing.
> > >
> > > Idea is to move common nodes in separate dtsi instead of adding
> > > redundant nodes into respective areas. let me know if it still
> > > confusing.
> >
> > A file which *only* includes another file does not fulfill this idea of
> > moving common nodes to a separate DTSI file. Or if I still miss
> > something, please point me, what common nodes are stored in
> > imx8mm-engicam-edimm2.2.dtsi?
> 
> imx8mm-engicam-edimm2.2.dtsi for EDIMM2.2 Carrier
> imx8mm-engicam-ctouch2.dtsi for C.TOUCH2 Carrier
> imx8mm-engicam-common.dtsi for common nodes for above 2 carrier boards.
> 
> Yes, imx8mm-engicam-edimm2.2.dtsi is empty now

Then that's the answer. We do not create empty files.

> but nodes like PCIe,
> CSI, DSI will support once the respective drivers are part of Mainline
> but those are not supported in C.TOUCH2 carrier board dtsi. There are
> some GPIO pins differences between EDIMM2.2 and C.TOUCH2 carriers on
> WiFi/BT so those will be part of the respective carrier dtsi.

It's the same clear as before. Don't create empty files. Once you decide
to bring new features, you create a new file.

Best regards,
Krzysztof

