Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFD32F4F40
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbhAMPxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:53:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbhAMPxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:53:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F878233F8;
        Wed, 13 Jan 2021 15:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610553174;
        bh=xbCpQynJtv/c55NX+YOjuFWAG2HeEEWgKuhf0zK0ffg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lR78CUqETcnfsQ1fd4c/egZBAwNk1XRmy6o5GOX+ehUY6xcHjWJQ34/jc2x0IKWGp
         VNs9bT5I3hqAARaiQru5wl4ybdqwydzpMcQ5sIoOFSASCLk+v/Udt23IhY8pgnqLDJ
         qXFpMmz/5bAmnvXjHyqJz3PlFYZPpTLTu9ZNco5zQmHj+RaedmTdReMIqyzxj/NtWT
         x7nEi9HDeVCBWYQrTMX6SaeDXOnpj33LXd/pKK8smm2jvleUOA55mOMPkW2iHDmIXu
         Wp3rVv90s2BFw3ktQHAHSGr1lUbW4LDQzAhyBuD0Aj8cuBz7jimpyXBMF3+m1rTe/v
         0fgc9IMqWoRAw==
Received: by mail-ej1-f49.google.com with SMTP id 6so3766638ejz.5;
        Wed, 13 Jan 2021 07:52:54 -0800 (PST)
X-Gm-Message-State: AOAM533dfVsXOrOPIdHWFu3rm5jjtercHIP/ooTMSFsIE2oxdNOVk0du
        xVVQ4btelms0cK8xA5uBQlJ1GapRHwBXhm02jQ==
X-Google-Smtp-Source: ABdhPJzHoWcjN3cGo3TDvAIn07gWPu3Y5jJntVZNEw+dl8Csotad2ziZxBVxesABVdLkBRtWOY7vZe+PTyzkafubnNE=
X-Received: by 2002:a17:906:25c4:: with SMTP id n4mr1844111ejb.359.1610553173207;
 Wed, 13 Jan 2021 07:52:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
 <a91eb6288331bb80b30534a31049cde508307fc0.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
 <20210113135201.GA2328369@robh.at.kernel.org> <629dbc81badc9facea538733bfa8ddc0842b1df7.camel@fi.rohmeurope.com>
In-Reply-To: <629dbc81badc9facea538733bfa8ddc0842b1df7.camel@fi.rohmeurope.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 13 Jan 2021 09:52:41 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+N8dw82O-K6O53iogisgK2QZ=TEf7UCbBEbQGi9w4W9Q@mail.gmail.com>
Message-ID: <CAL_Jsq+N8dw82O-K6O53iogisgK2QZ=TEf7UCbBEbQGi9w4W9Q@mail.gmail.com>
Subject: Re: [PATCH 04/15] dt_bindings: bd71828: Add clock output mode
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 8:52 AM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:
>
>
> On Wed, 2021-01-13 at 07:52 -0600, Rob Herring wrote:
> > On Fri, Jan 08, 2021 at 03:34:16PM +0200, Matti Vaittinen wrote:
> > > The BD71828 allows configuring the clk32kout pin mode to CMOS or
> > > open-drain. Add device-tree property for specifying the preferred
> > > mode.
> > >
> > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > ---
> > >  .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml         | 7
> > > +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-
> > > pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-
> > > pmic.yaml
> > > index 3a6a1a26e2b3..cba085836bc0 100644
> > > --- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> > > +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> > > @@ -44,6 +44,13 @@ properties:
> > >    clock-output-names:
> > >      const: bd71828-32k-out
> > >
> > > +  rohm,clkout-mode:
> > > +    description: clk32kout mode. Can be set to "open-drain" or
> > > "cmos".
> > > +    $ref: "/schemas/types.yaml#/definitions/string"
> > > +    enum:
> > > +      - open-drain
> > > +      - cmos
> > > +
> >
> > I think a boolean or tristate ((0/1/not present) if you need 'leave
> > default') would be better.
>
> I was thinking of boolean but I hit the exact problem of leaving the
> default. (Booleans are so tempting for a lazy coder like me :] ) Do you
> mean uint with allowed values of 0/1 with the tristated?

Yes.

> I can sure do
> that - but wouldn't open-drain / cmos be more descriptive?

You'd get at least half by naming it 'rohm,clkout-open-drain'. I think
anyone that knows what open-drain means will know what !open-drain
implies.

Rob
