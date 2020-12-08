Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C0B2D2644
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgLHIfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:35:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52157 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgLHIfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:35:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id v14so1408393wml.1;
        Tue, 08 Dec 2020 00:34:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=enzNCtuTXUERAqWNP2FRX/lOAT01YdeUK6MfKS4566M=;
        b=Tlgm/H0r8g5Isq+IM4hd8x9wy7G6eeRJtwzBQGO0mkc22dG8Hm6uXLex11LM5naswG
         FAzZMWGCzb+N76xBr9YEDL2xthgDqkm+uvAIAfEinV2dH0Mq6Mem8T+946gPLvqlyPUN
         yjBJ4g/tsIlqrYzeumLV3CdzGdGF5x9HPkaYq4ES6P4+20LyTAcYEbq1yHlT5gfpHRSC
         v4YmYHTDRn7Nn6nVPZJkt6iSHY+qojY+6qMtnV3dksMpBhU4iUbxa/BbdhOAmoyX0rOM
         rm5ff/NuaQr3PG3IDxz/9F6WbLEmfjN2qdUbEJ1ALdeS/5yxpvw74QjAyhXcl+0USQAM
         jRbA==
X-Gm-Message-State: AOAM532giyKWvCd39hMQPQjje8bOu1fKFjoL52Rh7beY51pi76n2YEd8
        2l93adIq7nw9yqAPuJbfk+k=
X-Google-Smtp-Source: ABdhPJw0Mp1LsP6U5nxNFa04aLqcuBFIZBUL+jpmp7S2mHB+yDHjdCGoTz2fovWlyYRF8UOMWsXG1w==
X-Received: by 2002:a1c:81d5:: with SMTP id c204mr2748186wmd.156.1607416472636;
        Tue, 08 Dec 2020 00:34:32 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id u12sm2329147wmu.28.2020.12.08.00.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 00:34:31 -0800 (PST)
Date:   Tue, 8 Dec 2020 09:34:30 +0100
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
Message-ID: <20201208083430.GA6481@kozik-lap>
References: <VI1PR0402MB334290B621E8C02EA852A6E9E3CD0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <20201208080334.GA4026@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201208080334.GA4026@kozik-lap>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 09:03:34AM +0100, Krzysztof Kozlowski wrote:
> On Tue, Dec 08, 2020 at 03:16:35AM +0000, S.j. Wang wrote:
> > Hi
> > 
> > > 
> > > On Mon, Dec 07, 2020 at 02:21:40PM +0100, Krzysztof Kozlowski wrote:
> > > > On Mon, Dec 07, 2020 at 02:53:24PM +0800, Shengjiu Wang wrote:
> > > > > Error log:
> > > > > sysfs: cannot create duplicate filename
> > > '/bus/platform/devices/30000000.bus'
> > > > >
> > > > > The spba bus name is duplicate with aips bus name.
> > > > > Refine spba bus name to fix this issue.
> > > > >
> > > > > Fixes: 970406eaef3a ("arm64: dts: imx8mn: Enable Asynchronous Sample
> > > > > Rate Converter")
> > > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > > ---
> > > > >  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > > > b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > > > index fd669c0f3fe5..30762eb4f0a7 100644
> > > > > --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > > > @@ -246,7 +246,7 @@ aips1: bus@30000000 {
> > > > >                     #size-cells = <1>;
> > > > >                     ranges;
> > > > >
> > > > > -                   spba: bus@30000000 {
> > > > > +                   spba: spba-bus@30000000 {
> > > >
> > > > The proper node name is "bus" so basically you introduce wrong name to
> > > > other problem.  Introducing wrong names at least requires a comment.
> > > 
> > > I just noticed that my message was barely understandable... so let me fix it:
> > > 
> > > The proper node name is "bus" so basically you introduce wrong name to
> > > _fix_ other problem.  Introducing wrong names at least requires a comment.
> > > 
> > > > However the actual problem here is not in node names but in addresses:
> > > >
> > > >       aips1: bus@30000000 {
> > > >               spba: bus@30000000 {
> > > >
> > > > You have to devices with the same unit address. How do you share the
> > > > address space?
> > > >
> > > > I think this should be rather fixed.
> > > 
> > > And again, hungry keyboard ate a letter, so:
> > > 
> > > You have _two_ devices with the same unit address. How do you share the
> > > address space?
> > > I think this should be rather fixed.
> > > 
> > 
> > spba is the first block of aips1 space, so it has same start address as
> > aips1.
> 
> The reference manual describes it "Reserved for SDMA2 internal memory",
> so indeed it is first address but does it have to be mapped?
> Anyway, why don't you use ranges to remove the conflict?

The IO address space remapping could be a solution but there is another
problem - the hardware representation in DT does not match what
reference manual is saying.

The AIPS bus @30000000 has several IPs:
 - SAI2@30020000
 - ...
 - GPIO1@30200000

However in DTS you will find additional SPBA bus for 30000000 -
300c0000. It's not really the SDMA, as SDMA is at different address. It
is rather an address space which SDMA should map... but it is not a bus
with children. Adding spba-bus@30000000 with its children does not look
like correct representation of HW in DTS.

Best regards,
Krzysztof

