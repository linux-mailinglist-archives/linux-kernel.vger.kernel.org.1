Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F7726A86F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 17:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgIOPJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 11:09:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbgIOOlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:41:47 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 674D521D43;
        Tue, 15 Sep 2020 14:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600180731;
        bh=ULrLXLBFSf8v08km1JIpj+U9o/HmmxSgfv7QtS1UI34=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tx3mGP4e7AlKlnOo5BXgVE4S6aXmPU3XQpmr1dge2/YWtyy8HN/EGy+fahm27hIfH
         6yedK1q/jiLysI7QXiV3v2r8XFYviECOztO4NSPa26lYbkgiXdHJ7lovy40URtlnCe
         VqIirdg/lGheHhcrycOdzadS5KSmxHHq2U6T8o5Q=
Received: by mail-oi1-f172.google.com with SMTP id u126so4060575oif.13;
        Tue, 15 Sep 2020 07:38:51 -0700 (PDT)
X-Gm-Message-State: AOAM531Qd8KbrUWu2vky4D2usSCwkKgtT2LrQa9i1rC7jFaKWiemjeMw
        zPsMQ8YlvV6KKOAMsazR6gceBrxCANQu72+HPg==
X-Google-Smtp-Source: ABdhPJxRLb5pJZVUowukfIpm47EAVpHE5eGiUcywMTwuxxJXFp9MUEilmh3exqby3L0CYDonuiuZQcVK+5hz1YzMNFs=
X-Received: by 2002:aca:1711:: with SMTP id j17mr3729398oii.152.1600180730631;
 Tue, 15 Sep 2020 07:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200904145312.10960-1-krzk@kernel.org> <20200904145312.10960-7-krzk@kernel.org>
 <20200914224407.GA388924@bogus> <6bfa15383657ca38a28edac38b5e8adf891865e7.camel@fi.rohmeurope.com>
In-Reply-To: <6bfa15383657ca38a28edac38b5e8adf891865e7.camel@fi.rohmeurope.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 15 Sep 2020 08:38:38 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK0UPXxQ6YD5Hp4VGP4vRVshzVTRZRR2eLMZ35aY3uYBA@mail.gmail.com>
Message-ID: <CAL_JsqK0UPXxQ6YD5Hp4VGP4vRVshzVTRZRR2eLMZ35aY3uYBA@mail.gmail.com>
Subject: Re: [PATCH 06/13] dt-bindings: mfd: rohm,bd71837-pmic: Add common properties
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "krzk@kernel.org" <krzk@kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "robert.chiras@nxp.com" <robert.chiras@nxp.com>,
        "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
        "linux+etnaviv@armlinux.org.uk" <linux+etnaviv@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "festevam@gmail.com" <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 12:34 AM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:
>
>
> Hello All,
>
> On Mon, 2020-09-14 at 16:44 -0600, Rob Herring wrote:
> > On Fri, Sep 04, 2020 at 04:53:05PM +0200, Krzysztof Kozlowski wrote:
> > > Add common properties appearing in DTSes (clock-names,
> > > clock-output-names) to fix dtbs_check warnings like:
> > >
> > >   arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml:
> > >     pmic@4b: 'clock-names', 'clock-output-names', do not match any
> > > of the regexes: 'pinctrl-[0-9]+'
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > ---
> > >  .../devicetree/bindings/mfd/rohm,bd71837-pmic.yaml          | 6
> > > ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-
> > > pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71837-
> > > pmic.yaml
> > > index 65018a019e1d..ecce0d5e3a95 100644
> > > --- a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
> > > +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
> > > @@ -32,9 +32,15 @@ properties:
> > >    clocks:
> > >      maxItems: 1
> > >
> > > +  clock-names:
> > > +    maxItems: 1
> >
> > Needs to define what the name is.
>
> Someone once told me that "naming is hard".
> Do we have some good common convention for 32K oscillator input naming?

No.

> Or should it just be dropped?

Yes, having a name for a single entry in *-names is kind of pointless IMO.


> > > +
> > >    "#clock-cells":
> > >      const: 0
> > >
> > > +  clock-output-names:
> > > +    maxItems: 1
> >
> > Ideally this one too, but we've been more flexible on it.
>
> Data-sheet for BD71837 uses pin name "C32k_OUT". So maybe this would be
> good?

What's in all the dts files? I'd go with that if there's any clear
winner. If it's already a random free-for-all, then just leave it
as-is.

>
> BD71838 uses "bd71828-32k-out" . so we could also go with this same
> convention and use "bd71837-32k-out". Or - we could take a risk and
> *assume* typical use case for this clk (as this is typically used with
> i.MX8 I'd guess the 32k is used for RTC) and name it accordingly.

It should be aligned with what the output is called, not what it is
connected to.

Rob
