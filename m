Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CEC2D2553
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgLHIET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:04:19 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34328 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgLHIET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:04:19 -0500
Received: by mail-wr1-f66.google.com with SMTP id k14so15304087wrn.1;
        Tue, 08 Dec 2020 00:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=idKNMDUMpQRe7scdOjeO6VGYUZkB7f9r4VlFo9Ze3ns=;
        b=OUNVAF/p3n144Io39krg1xA3EexC5l2pguhm/Nwo+xXacS5wDhVuOXc6cm4Y0J6wZH
         CwdqjQOzgjuYJv6xjoJYwGanxsoFyO76a/VhwshaajLL/fIIU//GpL1DPiTrq78cbvoW
         jlp3M7a0fdU+DhP7gKGK3ddr8QMiueZ+FfX1MtPWDknQQJyWf0p4O57hfhbMnoGQ4l5/
         FPDrNzNWq04/MpUiNF+yHTtnpcZ/5gvQzt6fxwYqUibkgCAkGmnCLzgcYQ4i2Wn0MUpX
         e5UAKQZiVqmdUASrM1ol1ajDD0Pujr9qHsgIfHfuwvBzP53XIxaseVDtP0+p2rxjsN3d
         TryQ==
X-Gm-Message-State: AOAM533dHmfryepW475gHQW14nbTkz1wFCHvdjwXJfvKuwtEtW84pm1M
        uMKSScKp2WkPaVjML4vE36o=
X-Google-Smtp-Source: ABdhPJzwJd6F15wCZL2Lp1KwBbk5y/hxxQFNmnKudv1csJ/6yJOVqFELhAaaB1efyq77lHw3mPRYsg==
X-Received: by 2002:adf:f44c:: with SMTP id f12mr23857523wrp.155.1607414617149;
        Tue, 08 Dec 2020 00:03:37 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id n14sm2169265wmi.1.2020.12.08.00.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 00:03:35 -0800 (PST)
Date:   Tue, 8 Dec 2020 09:03:34 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mn: Fix duplicate node name
Message-ID: <20201208080334.GA4026@kozik-lap>
References: <VI1PR0402MB334290B621E8C02EA852A6E9E3CD0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB334290B621E8C02EA852A6E9E3CD0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 03:16:35AM +0000, S.j. Wang wrote:
> Hi
> 
> > 
> > On Mon, Dec 07, 2020 at 02:21:40PM +0100, Krzysztof Kozlowski wrote:
> > > On Mon, Dec 07, 2020 at 02:53:24PM +0800, Shengjiu Wang wrote:
> > > > Error log:
> > > > sysfs: cannot create duplicate filename
> > '/bus/platform/devices/30000000.bus'
> > > >
> > > > The spba bus name is duplicate with aips bus name.
> > > > Refine spba bus name to fix this issue.
> > > >
> > > > Fixes: 970406eaef3a ("arm64: dts: imx8mn: Enable Asynchronous Sample
> > > > Rate Converter")
> > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > ---
> > > >  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > > b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > > index fd669c0f3fe5..30762eb4f0a7 100644
> > > > --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > > @@ -246,7 +246,7 @@ aips1: bus@30000000 {
> > > >                     #size-cells = <1>;
> > > >                     ranges;
> > > >
> > > > -                   spba: bus@30000000 {
> > > > +                   spba: spba-bus@30000000 {
> > >
> > > The proper node name is "bus" so basically you introduce wrong name to
> > > other problem.  Introducing wrong names at least requires a comment.
> > 
> > I just noticed that my message was barely understandable... so let me fix it:
> > 
> > The proper node name is "bus" so basically you introduce wrong name to
> > _fix_ other problem.  Introducing wrong names at least requires a comment.
> > 
> > > However the actual problem here is not in node names but in addresses:
> > >
> > >       aips1: bus@30000000 {
> > >               spba: bus@30000000 {
> > >
> > > You have to devices with the same unit address. How do you share the
> > > address space?
> > >
> > > I think this should be rather fixed.
> > 
> > And again, hungry keyboard ate a letter, so:
> > 
> > You have _two_ devices with the same unit address. How do you share the
> > address space?
> > I think this should be rather fixed.
> > 
> 
> spba is the first block of aips1 space, so it has same start address as
> aips1.

The reference manual describes it "Reserved for SDMA2 internal memory",
so indeed it is first address but does it have to be mapped?
Anyway, why don't you use ranges to remove the conflict?

Best regards,
Krzysztof

