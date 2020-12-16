Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7B42DC07D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 13:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgLPMrr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Dec 2020 07:47:47 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51]:39770 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgLPMrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 07:47:47 -0500
Received: by mail-ej1-f51.google.com with SMTP id n26so32492516eju.6;
        Wed, 16 Dec 2020 04:47:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mjY8Os39M4leEEPHTfeQTINO8VNbMA4I5Bxao3MHur4=;
        b=bBwxP85W/hQ4uMxOWUWfHS02LwSJLBeErtUn956U9uKb6q98knXbMiQajpnvYKrW3Q
         1zGR3FWCIHioWcWRPC2rqPAmPy3NVDFzVQ/RxbbndsRm9AaUI4HRiS4rnxWfIYMitswY
         2OYksPTsyyzFmahDLlzzAumVPcf3ZsyV+wSqLBQOKjWpcDDys/lBAcf+/1jlneuF/1F8
         fNm9AKiAg3MyyCzGSVbPi4Btit8OgBNWKT5UgBQTZaoq0ypYTURwJ3+ck4cpGJPM+PnD
         nFvoaxXzIRf/sm1wamxW0g9Xn9mc6InHpyKTaKZndCWB4OPLR2AEC0M9tCPakxT6JN5Q
         Hf3Q==
X-Gm-Message-State: AOAM533MWAWYyLApUamS4uNJyKqag+ozMOXvdJdAJKdqcYa0FkXKKQ6W
        giX/JM/FC4zEBOAK8CRuhq0=
X-Google-Smtp-Source: ABdhPJxUQINFO4W9ye268ixQRaS+0Zf01qYWyeDzWJ0ixBIEYF4tEhSFWniMLmNrOzQ9QWhRxeOYnQ==
X-Received: by 2002:a17:906:718b:: with SMTP id h11mr30432291ejk.241.1608122824654;
        Wed, 16 Dec 2020 04:47:04 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id i8sm20536770eds.72.2020.12.16.04.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 04:47:03 -0800 (PST)
Date:   Wed, 16 Dec 2020 13:47:02 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v7 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Message-ID: <20201216124702.GA28244@kozik-lap>
References: <20201215083551.6067-1-alice.guo@oss.nxp.com>
 <20201215091118.GB9386@kozik-lap>
 <AM6PR04MB6053AE68690ADF805D5A0809E2C50@AM6PR04MB6053.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <AM6PR04MB6053AE68690ADF805D5A0809E2C50@AM6PR04MB6053.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 09:55:34AM +0000, Alice Guo (OSS) wrote:
> 
> 
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > Sent: 2020年12月15日 17:11
> > To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > Cc: robh+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; devicetree@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH v7 1/4] dt-bindings: soc: imx8m: add DT Binding doc for soc
> > unique ID
> > 
> > On Tue, Dec 15, 2020 at 04:35:48PM +0800, Alice Guo (OSS) wrote:
> > > From: Alice Guo <alice.guo@nxp.com>
> > >
> > > Add DT Binding doc for the Unique ID of i.MX 8M series.
> > >
> > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > ---
> > >
> > > Changes for v7:
> > >  - change to a separate schema file
> > > Changes for v6:
> > >  - none
> > > Changes for v5:
> > >  - correct the error of using allOf
> > > Changes for v4:
> > >  - use allOf to limit new version DTS files for i.MX8M to include
> > >    "fsl,imx8m*-soc", nvmem-cells and nvmem-cells-names Changes for v3:
> > >  - put it into Documentation/devicetree/bindings/arm/fsl.yaml
> > >  - modify the description of nvmem-cells
> > >  - use "make ARCH=arm64 dtbs_check" to make sure it is right Changes
> > > for v2:
> > >  - remove the subject prefix "LF-2571-1"
> > >
> > >  .../bindings/soc/imx/imx8m-soc.yaml           | 54
> > +++++++++++++++++++
> > >  1 file changed, 54 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml
> > > b/Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml
> > > new file mode 100644
> > > index 000000000000..a2f7dc0c9b35
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml
> > > @@ -0,0 +1,54 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/soc/imx/imx8m-soc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: NXP i.MX8M Series SoC
> > > +
> > > +maintainers:
> > > +  - Alice Guo <alice.guo@nxp.com>
> > > +
> > > +description: |
> > > +  NXP i.MX8M series SoCs contain fuse entries from which SoC Unique
> > > +ID can be
> > > +  obtained.
> > > +
> > > +select:
> > 
> > Mhm, there are other compatibles here so indeed, select is needed.
> > 
> > > +  properties:
> > > +    compatible:
> > > +      contains:
> > > +        enum:
> > > +          - fsl,imx8mm
> > > +          - fsl,imx8mn
> > > +          - fsl,imx8mp
> > > +          - fsl,imx8mq
> > > +  required:
> > > +    - compatible
> > 
> > This does not work - does not match anything. It seems you missed proper
> > "required" for the matched node.
> > 
> > Provide also an example.
> > 
> > Best regards,
> > Krzysztof
> > 
> 
> Hi, Krzysztof
> Thank you for your advice. My opinion is different from yours.
> 
> I did the fowllowing test:
> --- a/Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml
> +++ b/Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml
> @@ -22,6 +22,7 @@ select:
>            - fsl,imx8mn
>            - fsl,imx8mp
>            - fsl,imx8mq
> +          - fsl,lx2160a
>    required:
>      - compatible
> 
> ➜  linux-next git:(master) ✗ make ARCH=arm64 dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml
> ...
> /home/nxf55104/virtualization/upstream/linux-next/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dt.yaml: /: soc:compatible:0: 'simple-bus' is not one of ['fsl,imx8mm-soc', 'fsl,imx8mn-soc', 'fsl,imx8mp-soc', 'fsl,imx8mq-soc']
>         From schema: /home/nxf55104/virtualization/upstream/linux-next/Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml
> ...
> 
> So, I think it works and can match stuff. I do not understand what proper " required" I missed. Please give me some tips. Thank you.

I applied the bindings (only) and run dtbs_check - everything passed
fine but it shouldn't. The DTS do not have soc compatibles.

Best regards,
Krzysztof

