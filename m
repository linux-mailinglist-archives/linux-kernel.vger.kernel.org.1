Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD5F2B4A3C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbgKPQDU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Nov 2020 11:03:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34873 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbgKPQDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:03:19 -0500
Received: by mail-wm1-f68.google.com with SMTP id w24so24083175wmi.0;
        Mon, 16 Nov 2020 08:03:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cTPPtiGx5HABWSYjj2Jwh7qUN2s4bgdFOFffAOPRj60=;
        b=KNT6yHRubXuHnl6ZT3BDbSFaNLiMKqyslzDvdEq/cc2/8uyBcv8J8FdrCYip98o3UU
         0HoAS2xChWJAFUiadVD7GCSaqxwwduxDFnVh2wOujUKvJanEHWhH6678ni8fnjiwhJwv
         3crdMohZdW9oYRzh2zjrVgnHkzy6wm9gMxCLFGUtARRNQW3nh35d1kmbGmiBYebn0BCL
         tjw2t5epAMcbmh7dhWU78bKW13Lww953CjamB3wL7HEVNeQxwi/ejSjSU6LtDT3Tz65l
         dhGnXC9BWyB3Wq+kWuUXphM2R/WKir+h6sbgt6oC+89b9yprpbnzKAugi/nVtnZ6GiQC
         3dBw==
X-Gm-Message-State: AOAM532BrWzZplrM/fIgh4zvFN0YfcV5kCkf+Ngpwjrj+BcapFQHfvYT
        5wkG/AIDUfBdXUp6WGSnWS4=
X-Google-Smtp-Source: ABdhPJyYNOREUfzH58jqjfzNh1gaerwk5W77qLOc2STCfqhe8DvnCZk5FlL0CNhK+5pWyIWgvS5zIQ==
X-Received: by 2002:a1c:9901:: with SMTP id b1mr6818993wme.18.1605542597489;
        Mon, 16 Nov 2020 08:03:17 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id n23sm20326920wmk.24.2020.11.16.08.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:03:16 -0800 (PST)
Date:   Mon, 16 Nov 2020 17:03:14 +0100
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
Message-ID: <20201116160314.GA25108@kozik-lap>
References: <20201113110409.13546-1-alice.guo@nxp.com>
 <20201114164936.GA32552@kozik-lap>
 <AM6PR04MB60530B6F577A2A05B173748EE2E30@AM6PR04MB6053.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <AM6PR04MB60530B6F577A2A05B173748EE2E30@AM6PR04MB6053.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 07:04:13AM +0000, Alice Guo wrote:
> 
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > Sent: 2020年11月15日 0:50
> > To: Alice Guo <alice.guo@nxp.com>
> > Cc: robh+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > dl-linux-imx <linux-imx@nxp.com>; Peng Fan <peng.fan@nxp.com>;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org
> > Subject: [EXT] Re: [PATCH v3 1/4] dt-bindings: soc: imx8m: add DT Binding doc
> > for soc unique ID
> > 
> > Caution: EXT Email
> > 
> > On Fri, Nov 13, 2020 at 07:04:06PM +0800, Alice Guo wrote:
> > > Add DT Binding doc for the Unique ID of i.MX 8M series.
> > >
> > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > ---
> > >  .../devicetree/bindings/arm/fsl.yaml          | 25
> > +++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > index e4db0f9ed664..f4faebbb57da 100644
> > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > @@ -901,6 +901,31 @@ properties:
> > >                - fsl,s32v234-evb           # S32V234-EVB2 Customer
> > Evaluation Board
> > >            - const: fsl,s32v234
> > >
> > > +  soc:
> > > +    type: object
> > > +    properties:
> > > +      compatible:
> > > +        oneOf:
> > > +          - description: i.MX8M SoCs
> > > +            items:
> > > +              - enum:
> > > +                  - fsl,imx8mm-soc
> > > +                  - fsl,imx8mn-soc
> > > +                  - fsl,imx8mp-soc
> > > +                  - fsl,imx8mq-soc
> > > +              - const: simple-bus
> > > +
> > > +          - description: Other SoCs
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
> > >  additionalProperties: true
> > 
> > The "soc" node should be required for these compatibles. Otherwise you will
> > have to stay with this backwards-compatible-DTB-device-initcall-glue for many
> > years... I think you can achieve it with allOf.
> > 
> [Alice Guo]Hi,
> I find that my description for compatible is ambiguous. There are two kinds of compatible of the "soc" node:
> 1. For dtsi files used for SoCs other than imx8m series SoCs and old version dtsi files used for imx8m series SoCs,
> compatible of the "soc" node is "simple-bus".
> 2. For new version dtsi files used for imx8m series SoCs, compatible of the "soc" node is {"fsl,imx8mX-soc","simple-bus"}.
> 
> "nvmem-cell" is an optional property.
> 
> I do not understand what you mean. You mean that limit the compatible of "soc" node must include " fsl,imx8mX-soc" in new version dts files. Is my understanding correct?

All new DTS files should have soc node with "fsl,imx8mX-soc" and this
should be required by dtschema. The nvmem-cells and related properties
do not look like optional. From the hardware perspective - they are
always present. From the driver point of view: they are required and
driver will fail to work.

Best regards,
Krzysztof

