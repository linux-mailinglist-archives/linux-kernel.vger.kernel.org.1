Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D009A2D2698
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgLHIuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:50:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44760 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgLHIuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:50:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id x6so11475894wro.11;
        Tue, 08 Dec 2020 00:50:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y0koPcLMtfqbktCsAIiMm4tX7WZXNRVhbxZdAvcr+Xk=;
        b=jMgygRW1PoGVXYJgnW4T6YlaJY6D8PNSSYXK6+5AffAJmpJR8wuvaaOx6h95XqKK/q
         63j4dm7KQnGHWzGXzTbvavHC/um42b7EuAMJI6MqeS87h8BSZnIHOXOQ73dEzkrGOGB2
         VCtIauzz/bbkDQAbcmk4ENojLJhO8EpO9PoAib9nI8He9e7wNJ9ukgOtUtWzkdW8Yrtg
         xCpmNgIN69HQHEnG+Nb0ZkLrQbKXC3GTWJ13DTWkCXTf7M9mVFRSrQPmLpYrgs5RPvSa
         BjoJfmoML+AqH4plUt8brZMxV3wuGRF2Dm/NfLJe6SBVzh8CQR2lLqrPzpj0DiT264Gl
         3nTA==
X-Gm-Message-State: AOAM533QfWiRa7cc53TmImdEJSMZjT7VKghOArONsgtcEMQ2Ekh9Zrp/
        5pyM+YNVA0a9ZSP0HbqA4uk=
X-Google-Smtp-Source: ABdhPJxA6RS0R2gOVXWCWGnV+uh/3Kv14fuvnan/fEHEb7oQxahAQY+Bo0gM03s1veEtbBW1dE0DSA==
X-Received: by 2002:a5d:5552:: with SMTP id g18mr24607916wrw.145.1607417408037;
        Tue, 08 Dec 2020 00:50:08 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id n14sm18421046wrx.79.2020.12.08.00.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 00:50:06 -0800 (PST)
Date:   Tue, 8 Dec 2020 09:50:05 +0100
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
Message-ID: <20201208085005.GA7654@kozik-lap>
References: <VI1PR0402MB3342A173BDB558D436A5C514E3CD0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB3342A173BDB558D436A5C514E3CD0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 08:44:51AM +0000, S.j. Wang wrote:
> > > > >
> > > > > On Mon, Dec 07, 2020 at 02:21:40PM +0100, Krzysztof Kozlowski wrote:
> > > > > > On Mon, Dec 07, 2020 at 02:53:24PM +0800, Shengjiu Wang wrote:
> > > > > > > Error log:
> > > > > > > sysfs: cannot create duplicate filename
> > > > > '/bus/platform/devices/30000000.bus'
> > > > > > >
> > > > > > > The spba bus name is duplicate with aips bus name.
> > > > > > > Refine spba bus name to fix this issue.
> > > > > > >
> > > > > > > Fixes: 970406eaef3a ("arm64: dts: imx8mn: Enable Asynchronous
> > > > > > > Sample Rate Converter")
> > > > > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > > > > ---
> > > > > > >  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > > > > > b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > > > > > index fd669c0f3fe5..30762eb4f0a7 100644
> > > > > > > --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > > > > > @@ -246,7 +246,7 @@ aips1: bus@30000000 {
> > > > > > >                     #size-cells = <1>;
> > > > > > >                     ranges;
> > > > > > >
> > > > > > > -                   spba: bus@30000000 {
> > > > > > > +                   spba: spba-bus@30000000 {
> > > > > >
> > > > > > The proper node name is "bus" so basically you introduce wrong
> > > > > > name to other problem.  Introducing wrong names at least requires a
> > comment.
> > > > >
> > > > > I just noticed that my message was barely understandable... so let me
> > fix it:
> > > > >
> > > > > The proper node name is "bus" so basically you introduce wrong
> > > > > name to _fix_ other problem.  Introducing wrong names at least
> > requires a comment.
> > > > >
> > > > > > However the actual problem here is not in node names but in
> > addresses:
> > > > > >
> > > > > >       aips1: bus@30000000 {
> > > > > >               spba: bus@30000000 {
> > > > > >
> > > > > > You have to devices with the same unit address. How do you share
> > > > > > the address space?
> > > > > >
> > > > > > I think this should be rather fixed.
> > > > >
> > > > > And again, hungry keyboard ate a letter, so:
> > > > >
> > > > > You have _two_ devices with the same unit address. How do you
> > > > > share the address space?
> > > > > I think this should be rather fixed.
> > > > >
> > > >
> > > > spba is the first block of aips1 space, so it has same start address
> > > > as aips1.
> > >
> > > The reference manual describes it "Reserved for SDMA2 internal
> > > memory", so indeed it is first address but does it have to be mapped?
> > > Anyway, why don't you use ranges to remove the conflict?
> > 
> > The IO address space remapping could be a solution but there is another
> > problem - the hardware representation in DT does not match what reference
> > manual is saying.
> > 
> > The AIPS bus @30000000 has several IPs:
> >  - SAI2@30020000
> >  - ...
> >  - GPIO1@30200000
> > 
> > However in DTS you will find additional SPBA bus for 30000000 - 300c0000.
> > It's not really the SDMA, as SDMA is at different address. It is rather an
> > address space which SDMA should map... but it is not a bus with children.
> > Adding spba-bus@30000000 with its children does not look like correct
> > representation of HW in DTS.
> > 
> 
> In the RM, it says AIPS-1 (s_b_1, via SPBA) Glob. Module Enable.
> Range is (30000000 - 300FFFFF)

No, AIPS-1 is till 303F_FFFF.

> 
> SPBA is a sub-bus under AIPS1. The SAI2@30020000 -  ASRC@300c0000
> Are the devices under SPBA bus.

Where did you find SPBA bus description in the Reference Manual?

Best regards,
Krzysztof
