Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57822D2728
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgLHJGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:06:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52325 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728544AbgLHJGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:06:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id a6so1478365wmc.2;
        Tue, 08 Dec 2020 01:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yp6QbU20dThiZX55YMgwP3N0UblwKDOB7By25gccL7c=;
        b=sAkl74s0WB5ZfNOAbD2UvPb6wQvtsATgZcXpAWIvJPYyO9Gnj82zefH+j+mA6scCBa
         C2u0UJFnaTTz+PjGtSPqHgRvh43B+xJvF0L5m3B47G6QGs9o9fY8FybnBq7MULJ7Qw0H
         6XXGE15XlCZ+kWjWQV7xP/Tjn5xD4MmOHdaLYVkIKo6ffAfbc8mVff4b/CoMQg7Un5Tf
         w35MXK5YqacT9+gxhjVae4DiMM8obQSCjqNzIn7sQzxEL0hkJunqclnqKnLRG5bYhKV9
         CcDVdfKY7D1imMptnU4FW5RfWcFzgGcHzp2mvt8/0iCCvDdnEjNS08bpL6xWttlRY9Mg
         aXDg==
X-Gm-Message-State: AOAM5310pkQ1y6XOuCuJPxvkP5F0B1NhzRtON7EHLTW9bh3RTQSjG1aK
        Oy+SopdJjlk/UKGsYdL4n5s=
X-Google-Smtp-Source: ABdhPJy9qWTsAHTIyarbSwMqk6HSg5nF0G3ha8z2BhOwMciZ8zVRzeZ0zOwuEFo3aEIZXSVCkNduYg==
X-Received: by 2002:a1c:4843:: with SMTP id v64mr2900420wma.186.1607418364268;
        Tue, 08 Dec 2020 01:06:04 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id i11sm19196228wrm.1.2020.12.08.01.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 01:06:03 -0800 (PST)
Date:   Tue, 8 Dec 2020 10:06:01 +0100
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
Message-ID: <20201208090601.GA8347@kozik-lap>
References: <VI1PR0402MB334257A91BBAFE48C7AACD56E3CD0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB334257A91BBAFE48C7AACD56E3CD0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 08:57:49AM +0000, S.j. Wang wrote:
> > On Tue, Dec 08, 2020 at 08:44:51AM +0000, S.j. Wang wrote:
> > > > > > >
> > > > > > > On Mon, Dec 07, 2020 at 02:21:40PM +0100, Krzysztof Kozlowski
> > wrote:
> > > > > > > > On Mon, Dec 07, 2020 at 02:53:24PM +0800, Shengjiu Wang wrote:
> > > > > > > > > Error log:
> > > > > > > > > sysfs: cannot create duplicate filename
> > > > > > > '/bus/platform/devices/30000000.bus'
> > > > > > > > >
> > > > > > > > > The spba bus name is duplicate with aips bus name.
> > > > > > > > > Refine spba bus name to fix this issue.
> > > > > > > > >
> > > > > > > > > Fixes: 970406eaef3a ("arm64: dts: imx8mn: Enable
> > > > > > > > > Asynchronous Sample Rate Converter")
> > > > > > > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > > > > > > ---
> > > > > > > > >  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
> > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > > > > > > > b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > > > > > > > index fd669c0f3fe5..30762eb4f0a7 100644
> > > > > > > > > --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > > > > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > > > > > > > @@ -246,7 +246,7 @@ aips1: bus@30000000 {
> > > > > > > > >                     #size-cells = <1>;
> > > > > > > > >                     ranges;
> > > > > > > > >
> > > > > > > > > -                   spba: bus@30000000 {
> > > > > > > > > +                   spba: spba-bus@30000000 {
> > > > > > > >
> > > > > > > > The proper node name is "bus" so basically you introduce
> > > > > > > > wrong name to other problem.  Introducing wrong names at
> > > > > > > > least requires a
> > > > comment.
> > > > > > >
> > > > > > > I just noticed that my message was barely understandable... so
> > > > > > > let me
> > > > fix it:
> > > > > > >
> > > > > > > The proper node name is "bus" so basically you introduce wrong
> > > > > > > name to _fix_ other problem.  Introducing wrong names at least
> > > > requires a comment.
> > > > > > >
> > > > > > > > However the actual problem here is not in node names but in
> > > > addresses:
> > > > > > > >
> > > > > > > >       aips1: bus@30000000 {
> > > > > > > >               spba: bus@30000000 {
> > > > > > > >
> > > > > > > > You have to devices with the same unit address. How do you
> > > > > > > > share the address space?
> > > > > > > >
> > > > > > > > I think this should be rather fixed.
> > > > > > >
> > > > > > > And again, hungry keyboard ate a letter, so:
> > > > > > >
> > > > > > > You have _two_ devices with the same unit address. How do you
> > > > > > > share the address space?
> > > > > > > I think this should be rather fixed.
> > > > > > >
> > > > > >
> > > > > > spba is the first block of aips1 space, so it has same start
> > > > > > address as aips1.
> > > > >
> > > > > The reference manual describes it "Reserved for SDMA2 internal
> > > > > memory", so indeed it is first address but does it have to be mapped?
> > > > > Anyway, why don't you use ranges to remove the conflict?
> > > >
> > > > The IO address space remapping could be a solution but there is
> > > > another problem - the hardware representation in DT does not match
> > > > what reference manual is saying.
> > > >
> > > > The AIPS bus @30000000 has several IPs:
> > > >  - SAI2@30020000
> > > >  - ...
> > > >  - GPIO1@30200000
> > > >
> > > > However in DTS you will find additional SPBA bus for 30000000 -
> > 300c0000.
> > > > It's not really the SDMA, as SDMA is at different address. It is
> > > > rather an address space which SDMA should map... but it is not a bus
> > with children.
> > > > Adding spba-bus@30000000 with its children does not look like
> > > > correct representation of HW in DTS.
> > > >
> > >
> > > In the RM, it says AIPS-1 (s_b_1, via SPBA) Glob. Module Enable.
> > > Range is (30000000 - 300FFFFF)
> > 
> > No, AIPS-1 is till 303F_FFFF.
> 
> Yes,  AIPSA-1 is till 303F_FFFF,  but it is divided to 2 parts.
> (30000000 - 300FFFFF) is the first part. 
> 
> Please go to table 2-3 AIPS1 memory map in RM.  In the "region" column,
> There is " AIPS-1 (s_b_1, via SPBA) Glob. Module Enable". It means
> This part is connect to SPBA bus.

Thanks, I see it now. Indeed you have two buses which start at the same
address space. You can:
1. Remap addresses,
2. Rename APIS and SPBA to bus-1 and bus-2,
3. Add specific (non-generic) name to spba-bus which you did initially.

All of these are rather workarounds so I don't mind your approach (3).

Best regards,
Krzysztof

