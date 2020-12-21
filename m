Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1DA2E018F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 21:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgLUUau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 15:30:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgLUUau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 15:30:50 -0500
X-Gm-Message-State: AOAM533uQu3a/BXkuK62xim6U2vmmG2XFOpjP+DpVlncg+RS9c4bir8Y
        rNV0l2Zwc0YQGwHjUXlhPDA7LMtaSzX8Ww2k+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608582609;
        bh=VRlcGOvXjykbViJN9Oo4x10SGzr+RNj9IgjIK7YCHmI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rlQztuB7m6enZisvk6V3jpeNHQiUIg1qYn+f9hUu3iKVYjEgMK+JEFGdO1nkoz/b7
         4aeF33Ht9a1iHUGNbOpS38goyGxSzFMCaWfJiNgy7mRA9lhAx9a0L3MJjV8CGUhGT1
         l9qxZdGoXR49UMCWzwQSQmkjlMtxIPRQHrca7aWy7KqJxTbnlzKfHBiXf1I0u4uRBD
         bRo6bd+NAsTZu38xXTTFkcf8j2sjqZsikS6ujDkYW0DQ5SFkchA8pAC3uKgfukTrdM
         JaF+4v4TjeXGUbCNPthb2BvkrwoKImlniBIhtysCf8ebDRxKv3YEenCnMnpTFtc+IN
         S0kiCMAavdh/Q==
X-Google-Smtp-Source: ABdhPJwPHYMomSZZRkYdjvDeTt7+4n8guOOUHh4yS4/LSvYvuMc9bAfOQjq09wKPVFYy/9r5+TsKz3gfSwrx+QoJuQg=
X-Received: by 2002:a17:906:4146:: with SMTP id l6mr17161767ejk.341.1608582607273;
 Mon, 21 Dec 2020 12:30:07 -0800 (PST)
MIME-Version: 1.0
References: <20201218083726.16427-1-alice.guo@oss.nxp.com> <20201218085223.GA17306@kozik-lap>
 <AM6PR04MB6053A65F794B316659CDE638E2C30@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20201218093641.GA38684@kozik-lap> <AM6PR04MB60534C972777EED96FD105D2E2C30@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <CAL_JsqLyPPpO5OVLa4baqaJ3MGjJe5p_100ULZSmuf4q8UjWGw@mail.gmail.com> <AM6PR04MB6053DA4440458D9F9BDB1C08E2C00@AM6PR04MB6053.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB6053DA4440458D9F9BDB1C08E2C00@AM6PR04MB6053.eurprd04.prod.outlook.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 21 Dec 2020 13:29:55 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKtVKeU2eVemB1XRNHab4XxA_UH2ePQAQCdfRK2UsyEeA@mail.gmail.com>
Message-ID: <CAL_JsqKtVKeU2eVemB1XRNHab4XxA_UH2ePQAQCdfRK2UsyEeA@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 2:20 AM Alice Guo (OSS) <alice.guo@oss.nxp.com> wro=
te:
>
>
>
> > -----Original Message-----
> > From: Rob Herring <robh+dt@kernel.org>
> > Sent: 2020=E5=B9=B412=E6=9C=8818=E6=97=A5 22:00
> > To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > Cc: Krzysztof Kozlowski <krzk@kernel.org>; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH v8 1/4] dt-bindings: soc: imx8m: add DT Binding doc=
 for soc
> > unique ID
> >
> > On Fri, Dec 18, 2020 at 4:14 AM Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Krzysztof Kozlowski <krzk@kernel.org>
> > > > Sent: 2020=E5=B9=B412=E6=9C=8818=E6=97=A5 17:37
> > > > To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > > > Cc: robh+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de=
;
> > > > kernel@pengutronix.de; festevam@gmail.com;
> > > > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > > linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > > > Subject: Re: [PATCH v8 1/4] dt-bindings: soc: imx8m: add DT Binding
> > > > doc for soc unique ID
> > > >
> > > > On Fri, Dec 18, 2020 at 09:05:00AM +0000, Alice Guo (OSS) wrote:
> > > >  > > +    required:
> > > > > > > +      - compatible
> > > > > > > +      - nvmem-cells
> > > > > > > +      - nvmem-cell-names
> > > > > > > +
> > > > > > > +additionalProperties: true
> > > > > >
> > > > > > Don't leave comments unresolved (or resolve them against review
> > > > > > without discussion). Rob asked for changing it. The same as wit=
h
> > > > > > all schemas - you need to describe the missing properties.
> > > > > >
> > > > > > Best regards,
> > > > > > Krzysztof
> > > > >
> > > > > Hi,
> > > > > Thank you for your advice. I replied to him and let him know I
> > > > > remained here
> > > > unchanged. There will be errors according to his suggestion.
> > > >
> > > > Then the solution is to correct the errors - describe missing
> > > > properties
> > > > - instead of ignoring the suggestion and making a resubmit right aw=
ay.
> > > >
> > > > Best regards,
> > > > Krzysztof
> > >
> > > Hi,
> > > I am sorry I do not DT Binding doc very well.
> > >
> > > I checked the usage of patternProperties and additionalProperties in
> > https://json-schema.org/understanding-json-schema/reference/object.html=
.
> > > I noticed a sentence on the website: " If additionalProperties is a
> > > boolean and set to false, no additional properties will be allowed.",=
 so I think
> > that if additionalProperties is a boolean and set to true, additional p=
roperties
> > will be allowed. Letting here unchanged is my solution to correct the e=
rrors.
> > > I am not sure, I asked Rob for advice on the v6 by email, but he didn=
't reply to
> > me, so I made a resubmit.
> >
> > You waited an hour and I was sleeping! Waiting means waiting a week.
> >
> > You need to add '#address-cells' and '#size-cells'.
> >
> > Rob
> Hi, Rob
>
> Can change to the following code?
> When uses "additionalProperties: type: object", need to add model, compat=
ible, interrupt-parent, #address-cells and #size-cells.
> There will be error with adding interrupt-parent because "dt-bindings: re=
move 'interrupt-parent' from bindings".

You are at the wrong level. It's 'additionalProperties' for the soc
node, not the root. See below.

>
> # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> %YAML 1.2
> ---
> $id: http://devicetree.org/schemas/soc/imx/imx8m-soc.yaml#
> $schema: http://devicetree.org/meta-schemas/core.yaml#
>
> title: NXP i.MX8M Series SoC
>
> maintainers:
>   - Alice Guo <alice.guo@nxp.com>
>
> description: |
>   NXP i.MX8M series SoCs contain fuse entries from which SoC Unique ID ca=
n be
>   obtained.
>
> properties:
>   $nodename:
>     const: '/'
>
>   compatible:
>     contains:
>       enum:
>         - fsl,imx8mm
>         - fsl,imx8mn
>         - fsl,imx8mp
>         - fsl,imx8mq
>
>   "#address-cells":
>     const: 2
>   "#size-cells":
>     const: 2
>
> patternProperties:
>   "^soc@[0-9a-f]+$":
>     type: object
>     properties:
>       compatible:
>         items:
>           - enum:
>               - fsl,imx8mm-soc
>               - fsl,imx8mn-soc
>               - fsl,imx8mp-soc
>               - fsl,imx8mq-soc
>           - const: simple-bus
>
>       nvmem-cells:
>         maxItems: 1
>         description: Phandle to the SOC Unique ID provided by a nvmem nod=
e
>
>       nvmem-cells-names:
>         const: soc_unique_id
>
>     required:
>       - compatible
>       - nvmem-cells
>       - nvmem-cell-names
>

      additionalProperties:
        type: object

> additionalProperties: true

And keep this as-is.

> ...
>
> Best regards,
> Alice
>
>
