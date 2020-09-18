Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E057B26F663
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 08:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgIRG6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 02:58:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgIRG6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 02:58:39 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12EAA21741;
        Fri, 18 Sep 2020 06:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600412318;
        bh=mjp2wDE0CPx5yKOwcHLy7u2mCk/dtE5oFHoNPu9lgt0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2mgmv2TT1Rddp0gW0w5fTvKfGGQn4xNtmmH8NYbXmjZ2ELZwXf6/Gcaz7INVj+CQ9
         +R8cv4OHrPdMgJdl2fSFdkRkN7cJtUCk6z5FZbZEJeuffRGdMCHY/yry2khNUVMWU9
         t1izuwNvWQuiAf85mPI3J1vJCj70n+Omw+UUckAk=
Received: by mail-ej1-f44.google.com with SMTP id nw23so6645020ejb.4;
        Thu, 17 Sep 2020 23:58:38 -0700 (PDT)
X-Gm-Message-State: AOAM531H7699Q/s0JhVhgHL67Vosp9ZVQLvGgSXwKcVunU5bNATDZ6pd
        024dHnEwrWVqv8wV3p0DM57AhmjwD+X8BcwJZ9I=
X-Google-Smtp-Source: ABdhPJxuUdNI1kI9EGKoX661IH6CqKsTqOJr2EABaLTyHqaGDXbYSQO6uutOU1nYbQDBXfIETEqoXrPjCNQOLRAANdI=
X-Received: by 2002:a17:906:4a51:: with SMTP id a17mr34126508ejv.381.1600412316471;
 Thu, 17 Sep 2020 23:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200917193754.542-1-krzk@kernel.org> <cf55864a2d9ff7fcd397273b27cb10619029bd58.camel@fi.rohmeurope.com>
In-Reply-To: <cf55864a2d9ff7fcd397273b27cb10619029bd58.camel@fi.rohmeurope.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 18 Sep 2020 08:58:24 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcYquTA8FMFxQ6-ANZdmVJ+Va2VmbudNyqXrmgUx+T=oQ@mail.gmail.com>
Message-ID: <CAJKOXPcYquTA8FMFxQ6-ANZdmVJ+Va2VmbudNyqXrmgUx+T=oQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mfd: rohm,bd71837-pmic: Add common properties
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 at 07:48, Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:
>
> Hi deeee Ho peeps!
>
> On Thu, 2020-09-17 at 21:37 +0200, Krzysztof Kozlowski wrote:
> > Add common properties appearing in DTSes (clock-names,
> > clock-output-names) with the common values (actually used in DTSes)
> > to
> > fix dtbs_check warnings like:
> >
> >   arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml:
> >     pmic@4b: 'clock-names', 'clock-output-names', do not match any of
> > the regexes: 'pinctrl-[0-9]+'
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > ---
> >
> > Changes since v1:
> > 1. Define the names, as used in existing DTS files.
> > ---
> >  .../devicetree/bindings/mfd/rohm,bd71837-pmic.yaml          | 6
> > ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-
> > pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71837-
> > pmic.yaml
> > index 65018a019e1d..3bfdd33702ad 100644
> > --- a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
> > @@ -32,9 +32,15 @@ properties:
> >    clocks:
> >      maxItems: 1
> >
> > +  clock-names:
> > +    const: osc
>
> I guess existing board dtses use "osc" then? Ok.

Yes.

>
> >    "#clock-cells":
> >      const: 0
> >
> > +  clock-output-names:
> > +    const: pmic_clk
>
> This is not a strong opinion but I feel that pmic_clk is a bit too
> generic name? I mean, what if there is a system with more than one
> PMICs? (I don't see such use-case with the BD718x7 though - but perhaps
> this can serve as a misleading example for other PMICs?

I don't expect two PMICs. Sometimes secondary device is added with few
regulators, e.g. a MUIC. Still only one device can supply the CPU and
probably this would be called PMIC.

> For example
> with the ROHM BD96801 family there may be multiple PMICs in one
> system). Anyways - if Rob is happy with this then please go with it :)

The name was taken from existing DTS files. That was Rob's idea as well.

Best regards,
Krzysztof

>
> Acked-By: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
>  *
> Thanks again for improving these bindings! I am constantly struggling
> with these x_x. Writing the bindings is probably hardest part of PMIC
> driver development -_-;
>
>
