Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7282B5A54
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 08:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgKQHgP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Nov 2020 02:36:15 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40471 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgKQHgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 02:36:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id a3so2249700wmb.5;
        Mon, 16 Nov 2020 23:36:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9MPQ28eRVEZoeAfW6tqzwdTMKkuu3vxDE3zbTGm+kt8=;
        b=RhDYMHSxm6+CP4RZIuSvf4Z7yG7z7Yi3yvwnoqVq4PiLsGBY6goiYrEZjGiTx+CG/3
         tGlPPw8xjf4xtAsKv414nsKXOLxNGQk9h7j59n7hFmK37Rs4nywSgKhwYrMGnI/CFO6Y
         BE4n0YkSZi90S9JNpHpvthLZl3eGsQSB+I5PDdOeGP9NnAJVuEQYiSihaDAAoDJFgBpc
         3Hz5k2eWbbNCYa7EcA14KWRRaU07VT8t7InhXqGS8j1Dm2vsDe+7tfU1CupY91UWQP/Q
         VNMxLlUoFJntpmz+Ahn2ocF310fhZs/RPI2SHS6gvo1OdvIWkcKqlqW8XbCSM21CSddw
         9s4w==
X-Gm-Message-State: AOAM532L+xmqWhQhW/lL2KMLArIlOidJrxMt/0TaTPcX0ygluw3r2z8n
        VgWs14X9ct9GQ/nCmz+gAu4=
X-Google-Smtp-Source: ABdhPJwdQB+H6BgFI1QGO/+y7B87Ik2Fqrj1kQIreMHp3NfwdFDpfZ4JoZpHxjmghG10HkbgHsfEdg==
X-Received: by 2002:a7b:c202:: with SMTP id x2mr2754290wmi.48.1605598572563;
        Mon, 16 Nov 2020 23:36:12 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id 89sm27113016wrp.58.2020.11.16.23.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 23:36:11 -0800 (PST)
Date:   Tue, 17 Nov 2020 08:36:09 +0100
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
Subject: Re: [EXT] Re: [PATCH v3 1/4] dt-bindings: soc: imx8m: add DT Binding
 doc for soc unique ID
Message-ID: <20201117073609.GA3436@kozik-lap>
References: <AM6PR04MB605309F95A4BBD29DFA42B61E2E20@AM6PR04MB6053.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <AM6PR04MB605309F95A4BBD29DFA42B61E2E20@AM6PR04MB6053.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 07:10:28AM +0000, Alice Guo wrote:
> 
> 
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > Sent: 2020年11月17日 0:03
> > To: Alice Guo <alice.guo@nxp.com>
> > Cc: robh+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > dl-linux-imx <linux-imx@nxp.com>; Peng Fan <peng.fan@nxp.com>;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org
> > Subject: Re: [EXT] Re: [PATCH v3 1/4] dt-bindings: soc: imx8m: add DT Binding
> > doc for soc unique ID
> > 
> > Caution: EXT Email
> > 
> > On Mon, Nov 16, 2020 at 07:04:13AM +0000, Alice Guo wrote:
> > >
> > > > -----Original Message-----
> > > > From: Krzysztof Kozlowski <krzk@kernel.org>
> > > > Sent: 2020年11月15日 0:50
> > > > To: Alice Guo <alice.guo@nxp.com>
> > > > Cc: robh+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > > > dl-linux-imx <linux-imx@nxp.com>; Peng Fan <peng.fan@nxp.com>;
> > > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > linux-arm-kernel@lists.infradead.org
> > > > Subject: [EXT] Re: [PATCH v3 1/4] dt-bindings: soc: imx8m: add DT
> > > > Binding doc for soc unique ID
> > > >
> > > > Caution: EXT Email
> > > >
> > > > On Fri, Nov 13, 2020 at 07:04:06PM +0800, Alice Guo wrote:
> > > > > Add DT Binding doc for the Unique ID of i.MX 8M series.
> > > > >
> > > > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > > > ---
> > > > >  .../devicetree/bindings/arm/fsl.yaml          | 25
> > > > +++++++++++++++++++
> > > > >  1 file changed, 25 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > index e4db0f9ed664..f4faebbb57da 100644
> > > > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > @@ -901,6 +901,31 @@ properties:
> > > > >                - fsl,s32v234-evb           # S32V234-EVB2
> > Customer
> > > > Evaluation Board
> > > > >            - const: fsl,s32v234
> > > > >
> > > > > +  soc:
> > > > > +    type: object
> > > > > +    properties:
> > > > > +      compatible:
> > > > > +        oneOf:
> > > > > +          - description: i.MX8M SoCs
> > > > > +            items:
> > > > > +              - enum:
> > > > > +                  - fsl,imx8mm-soc
> > > > > +                  - fsl,imx8mn-soc
> > > > > +                  - fsl,imx8mp-soc
> > > > > +                  - fsl,imx8mq-soc
> > > > > +              - const: simple-bus
> > > > > +
> > > > > +          - description: Other SoCs
> > > > > +            items:
> > > > > +              - const: simple-bus
> > > > > +
> > > > > +      nvmem-cells:
> > > > > +        maxItems: 1
> > > > > +        description: Phandle to the SOC Unique ID provided by a
> > > > > + nvmem node
> > > > > +
> > > > > +      nvmem-cells-names:
> > > > > +        const: soc_unique_id
> > > > > +
> > > > >  additionalProperties: true
> > > >
> > > > The "soc" node should be required for these compatibles. Otherwise
> > > > you will have to stay with this
> > > > backwards-compatible-DTB-device-initcall-glue for many years... I think you
> > can achieve it with allOf.
> > > >
> > > [Alice Guo]Hi,
> > > I find that my description for compatible is ambiguous. There are two kinds of
> > compatible of the "soc" node:
> > > 1. For dtsi files used for SoCs other than imx8m series SoCs and old
> > > version dtsi files used for imx8m series SoCs, compatible of the "soc" node is
> > "simple-bus".
> > > 2. For new version dtsi files used for imx8m series SoCs, compatible of the
> > "soc" node is {"fsl,imx8mX-soc","simple-bus"}.
> > >
> > > "nvmem-cell" is an optional property.
> > >
> > > I do not understand what you mean. You mean that limit the compatible of
> > "soc" node must include " fsl,imx8mX-soc" in new version dts files. Is my
> > understanding correct?
> > 
> > All new DTS files should have soc node with "fsl,imx8mX-soc" and this should be
> > required by dtschema. The nvmem-cells and related properties do not look like
> > optional. From the hardware perspective - they are always present. From the
> > driver point of view: they are required and driver will fail to work.
> 
> [Alice Guo] 
> +  soc:
> +    type: object
> +    properties:
> +      compatible:
> +        oneOf:
> +          - description: new version DTS for i.MX8M SoCs
> +            items:
> +              - enum:
> +                  - fsl,imx8mm-soc
> +                  - fsl,imx8mn-soc
> +                  - fsl,imx8mp-soc
> +                  - fsl,imx8mq-soc
> +              - const: simple-bus
> +
> +          - description: other SoCs and old version DTS for i.MX8M SoCs
> +            items:
> +              - const: simple-bus
> +
> +      nvmem-cells:
> +        maxItems: 1
> +        description: Phandle to the SOC Unique ID provided by a nvmem node
> +
> +      nvmem-cells-names:
> +        const: soc_unique_id
> +
> +    allOf:
> +      - if:
> +          properties:
> +            compatible:
> +              contains:
> +                enum:
> +                  - fsl,imx8mm-soc
> +                  - fsl,imx8mn-soc
> +                  - fsl,imx8mp-soc
> +                  - fsl,imx8mq-soc
> +                const: simple-bus
> +
> +        then:
> +          required:
> +            - nvmem-cells
> +            - nvmem-cells-names
> 
> The above is my modification. Is that ok?

Does not look like solving anything.

Best regards,
Krzysztof

