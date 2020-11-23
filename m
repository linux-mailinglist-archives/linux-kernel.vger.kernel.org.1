Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB6A2C01FF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 10:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgKWJEo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Nov 2020 04:04:44 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44486 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKWJEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 04:04:43 -0500
Received: by mail-ed1-f65.google.com with SMTP id l5so16245703edq.11;
        Mon, 23 Nov 2020 01:04:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wGGlpzvGX0by37pqRtpcEEdM/2jadzvK1HD3lMXgLU0=;
        b=ix6B8IsnEofDPVMe0nIt0OGMzvGxygTHN0WZVY8AGXH+BGOyK+4zvYMM6a7aFQFMTd
         FFDnclWyRA1JpIhb5xiB/mmQiyzvdtl8xoKsVSp9G+fcFV420T3EuDYf+S6GVVsjK+g4
         lQsxNPPPQrLxtLHmuCVLAOj4bV3B4pqNM2L2Y2FI64w+uzCIKUgN47jR6sT4xYySDONm
         APFceL36CoaxKSfANB11QG8wgzVxnaFZ+J2saEWcA/dPTnVuXqHqoO5PRA9k5KxrDU4Z
         Ahb6E635MMBZ8cgZ+WRSgzTi/HItjtYtxTu8n7soqSjE0B88QkNSSO8u8/uvrmes/T21
         33rw==
X-Gm-Message-State: AOAM5327JTikbjuDTnqPYXoCDYrF7uCj4/4wXtdgZzErNwqrMZfxNfGF
        PL92lc+If3KMV6OfVFzV80o=
X-Google-Smtp-Source: ABdhPJzXhq9gEvTmWy4BzqVCA2dUlKZtyrI26WLTpJtn0H4cJoZyCMMvO3yAjfu7+TzSRCQIVqx/VQ==
X-Received: by 2002:a05:6402:54d:: with SMTP id i13mr48437719edx.3.1606122280616;
        Mon, 23 Nov 2020 01:04:40 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id k1sm4561266ejr.53.2020.11.23.01.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 01:04:39 -0800 (PST)
Date:   Mon, 23 Nov 2020 10:04:38 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v4 1/4] dt-bindings: soc: imx8m: add DT Binding
 doc for soc unique ID
Message-ID: <20201123090438.GA17112@kozik-lap>
References: <20201120101112.31819-1-alice.guo@nxp.com>
 <20201120105045.GA18581@kozik-lap>
 <DBBPR04MB606015EDBC99EF83B434D71AE2FC0@DBBPR04MB6060.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <DBBPR04MB606015EDBC99EF83B434D71AE2FC0@DBBPR04MB6060.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 04:45:13AM +0000, Alice Guo wrote:
> 
> 
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > Sent: 2020年11月20日 18:51
> > To: Alice Guo <alice.guo@nxp.com>
> > Cc: robh+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > dl-linux-imx <linux-imx@nxp.com>; Peng Fan <peng.fan@nxp.com>;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org
> > Subject: [EXT] Re: [PATCH v4 1/4] dt-bindings: soc: imx8m: add DT Binding doc
> > for soc unique ID
> > 
> > Caution: EXT Email
> > 
> > On Fri, Nov 20, 2020 at 06:11:09PM +0800, Alice Guo wrote:
> > > Add DT Binding doc for the Unique ID of i.MX 8M series.
> > >
> > > v2: remove the subject prefix "LF-2571-1"
> > > v3: put it into Documentation/devicetree/bindings/arm/fsl.yaml
> > >     modify the description of nvmem-cells
> > >     use "make ARCH=arm64 dtbs_check" to test it and fix errors
> > > v4: use allOf to limit new version DTS files for i.MX8M to include
> > >     "fsl,imx8mm/n/p/q-soc", nvmem-cells and nvmem-cells-names
> > >
> > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > ---
> > >  .../devicetree/bindings/arm/fsl.yaml          | 51
> > +++++++++++++++++++
> > >  1 file changed, 51 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > index 67980dcef66d..d8048323a290 100644
> > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > @@ -918,6 +918,57 @@ properties:
> > >                - fsl,s32v234-evb           # S32V234-EVB2 Customer
> > Evaluation Board
> > >            - const: fsl,s32v234
> > >
> > > +  soc:
> > > +    type: object
> > > +    properties:
> > > +      compatible:
> > > +        oneOf:
> > > +          - description: new version compatible for i.MX8M SoCs
> > > +            items:
> > > +              - enum:
> > > +                  - fsl,imx8mm-soc
> > > +                  - fsl,imx8mn-soc
> > > +                  - fsl,imx8mp-soc
> > > +                  - fsl,imx8mq-soc
> > > +              - const: simple-bus
> > > +
> > > +          - description: old version compatible for i.MX8M SoCs
> > > +            items:
> > > +              - const: simple-bus
> > > +
> > > +      nvmem-cells:
> > > +        maxItems: 1
> > > +        description: Phandle to the SOC Unique ID provided by a nvmem
> > > + node
> > > +
> > > +      nvmem-cells-names:
> > > +        const: soc_unique_id
> > > +
> > > +    allOf:
> > 
> > Nothing changed here comparing to previous version. Still does not work.
> > 
> > The allOf should not be part of soc node because the "if" below won't match.
> > Instead, it should be against root node.
> > 
> > Best regards,
> > Krzysztof
> 
> I'm sorry to disturb you. I don't very clear about the grammar rules of yaml, so don't know how to make allOf be part of root node.
> If allof is part of root node, how does it specify the soc node? The following is my change which is definitely wrong.
>   soc:
>     properties:
>       compatible:
>         - description: new version compatible for i.MX8M SoCs
>           items:
>             - enum:
>                 - fsl,imx8mm-soc
>                 - fsl,imx8mn-soc
>                 - fsl,imx8mp-soc
>                 - fsl,imx8mq-soc
>             - const: simple-bus
> 
>       nvmem-cells:
>         maxItems: 1
>         description: Phandle to the SOC Unique ID provided by a nvmem node
> 
>       nvmem-cells-names:
>         const: soc_unique_id
> 
> allOf:
>   - if:
>       properties:
>         compatible:
>           contains:
>             enum:
>               - fsl,imx8mm
>               - fsl,imx8mn
>               - fsl,imx8mp
>               - fsl,imx8mq
> 
>       then:
>         required:
>           - soc
> 
> Please give me suggestion. Thank you.

This should work:

940 allOf:
941   - if:
942       properties:
943         compatible:
944           contains:
945             enum:
946               - fsl,imx8mm
947               - fsl,imx8mn
948               - fsl,imx8mp
949               - fsl,imx8mq
950 
951     then:
952       patternProperties:
953         "^soc@[0-9a-f]+$":
954           properties:
955             compatible:
956               items:
957                 - enum:
958                     - fsl,imx8mm-soc
959                     - fsl,imx8mn-soc
960                     - fsl,imx8mp-soc
961                     - fsl,imx8mq-soc
962                 - const: simple-bus
963 
964           required:
965             - nvmem-cells
966             - nvmem-cells-names

And probablt "soc" should also be added to required, just below the
"then:".

You need to test it and find the proper solution.

Best regards,
Krzysztof


