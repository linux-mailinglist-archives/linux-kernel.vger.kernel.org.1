Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE982A7E85
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 13:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgKEMZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:25:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgKEMZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:25:09 -0500
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38F162078E;
        Thu,  5 Nov 2020 12:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604579108;
        bh=mQn6eQC8BgHY7sVHx/l8lzOgl2uWd1caiUoW+FfNyd8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xdv3zZVRDbS/oefaYlHx0GlF+5Tza70M6VZEhQBHrBgO9szMGieEHZU/hxRV4JqyN
         6UoaLgsyH0L68tYQzzPi8etwz09xZq5W3srfXAgy2a/rqmJa+YVzjOtjPgiTrBSIkd
         dYSQqFSQ5834EbvsGeuRbZ7wl1kBqFmef7NQoK+o=
Received: by mail-ej1-f50.google.com with SMTP id o9so2351526ejg.1;
        Thu, 05 Nov 2020 04:25:08 -0800 (PST)
X-Gm-Message-State: AOAM531iu9QkViHzYmzIA0XaC3mB9heolbEEnuSOsCaC7mEhRN4fs2Gt
        aeeNfd3yKOnb4excC1d0C3HJC6HTJqNqtgtghmI=
X-Google-Smtp-Source: ABdhPJxtLqq7R2+xslnKnuHlzyKI3dzkhbUoBKlME67gbPsBxdBuzfnBLveHWCaKlx1rJ771h4Hd1tVYM36lFOUIBNw=
X-Received: by 2002:a17:906:491a:: with SMTP id b26mr1971570ejq.385.1604579106683;
 Thu, 05 Nov 2020 04:25:06 -0800 (PST)
MIME-Version: 1.0
References: <20201105072629.24175-1-alice.guo@nxp.com> <20201105082543.GA17569@kozik-lap>
 <VI1PR04MB707134F5D01274A91E1CC878E2EE0@VI1PR04MB7071.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB707134F5D01274A91E1CC878E2EE0@VI1PR04MB7071.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 5 Nov 2020 13:24:55 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfyuaKpDZ5akWBq2rujxZLU0TR2eqiDcHWKVVPA_NpVVQ@mail.gmail.com>
Message-ID: <CAJKOXPfyuaKpDZ5akWBq2rujxZLU0TR2eqiDcHWKVVPA_NpVVQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 1/4] dt-bindings: soc: imx8m: add DT Binding
 doc for soc unique ID
To:     Alice Guo <alice.guo@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Nov 2020 at 13:19, Alice Guo <alice.guo@nxp.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > Sent: 2020=E5=B9=B411=E6=9C=885=E6=97=A5 16:26
> > To: Alice Guo <alice.guo@nxp.com>
> > Cc: robh+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > dl-linux-imx <linux-imx@nxp.com>; Peng Fan <peng.fan@nxp.com>;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org
> > Subject: [EXT] Re: [PATCH v2 1/4] dt-bindings: soc: imx8m: add DT Bindi=
ng doc
> > for soc unique ID
> >
> > Caution: EXT Email
> >
> > On Thu, Nov 05, 2020 at 03:26:26PM +0800, Alice Guo wrote:
> > > Add DT Binding doc for the Unique ID of i.MX 8M series.
> > >
> > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > ---
> > >  .../devicetree/bindings/arm/fsl.yaml          | 33
> > +++++++++++++++++++
> > >  1 file changed, 33 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml
> > b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > index e4db0f9ed664..0419f078502b 100644
> > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > @@ -901,6 +901,39 @@ properties:
> > >                - fsl,s32v234-evb           # S32V234-EVB2 Customer
> > Evaluation Board
> > >            - const: fsl,s32v234
> > >
> > > +  soc:
> > > +    description:
> > > +      i.MX8M Family SoC must provide a soc node in the root of the d=
evice
> > tree,
> > > +      representing the System-on-Chip since these test chips are rat=
her
> > complex.
> > > +    type: object
> > > +    properties:
> > > +      compatible:
> > > +        oneOf:
> > > +          - items:
> > > +              - const: fsl,imx8mm-soc
> > > +              - const: simple-bus
> > > +          - items:
> > > +              - const: fsl,imx8mn-soc
> > > +              - const: simple-bus
> > > +          - items:
> > > +              - const: fsl,imx8mp-soc
> > > +              - const: simple-bus
> > > +          - items:
> > > +              - const: fsl,imx8mq-soc
> > > +              - const: simple-bus
> > > +
> > > +      nvmem-cells:
> > > +        maxItems: 1
> > > +        description: Phandle to the SOC Unique ID provided by a nvme=
m
> > node
> > > +
> > > +      nvmem-cells-names:
> > > +        const: soc_unique_id
> > > +
> > > +    required:
> > > +      - compatible
> > > +      - nvmem-cells
> > > +      - nvmem-cell-names
> > > +
> >
> > Did you actually test it? I see multiple errors with this patch.
> > fsl-ls1012a-frdm.dt.yaml: /: soc:compatible: ['simple-bus'] is not vali=
d under any
> > of the given schemas
> >
> > Best regards,
> > Krzysztof
>
>
> [Alice Guo] Sorry. I did not see errors what you said. Can you tell me ho=
w did you test it?

It was a regular DT check, nothing unusual (make dtbs_check).

Best regards,
Krzysztof
