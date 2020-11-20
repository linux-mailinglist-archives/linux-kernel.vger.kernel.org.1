Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DB52BA3F9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 08:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgKTHyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 02:54:44 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:43613 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgKTHyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:54:43 -0500
Received: by mail-ej1-f66.google.com with SMTP id k27so11543249ejs.10;
        Thu, 19 Nov 2020 23:54:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Eq/cujlUFAwrKQYzYbGEyGBEOnWSD/TTaG5voRoVQjE=;
        b=VbqFQeV9bXE9iJmOIcXwt8VjuRfrb0aWggsouBqyVBh7C6A0AIozz+FXacXVHa/ZvP
         2WJzQlkBvvGoMWnMBG3Dn6n5lXmgAMJCNt4TaZHWStCG8uoi0RbJM6KuizVYUQ1mC/JX
         0EF5ypdEFngPRE1b4tV1M0zNDeE8YYupct21pmCpAROQt8j0H94MFUV4X2dh2p8Zlea3
         F9yxhicq5pP7bk/l10jU8o7jpmFucYs5L820bitS3vNFJnxfqOHaW2KfFD34sJ4+YoJk
         HIqM4yegQmBn2tXAI+/xKlUNjuOsShcxuoL77Ae/UgxfkmKS4/5DR25qkUlFOz5O7kTe
         gkog==
X-Gm-Message-State: AOAM533N1N2cOoy2LteuDJRvwQULzhF8kOinyx+Geg47Yb5PHSif1YMH
        kub2sIbO0T9FvFeVyDDIYxWcuiEYFfnuOQ==
X-Google-Smtp-Source: ABdhPJxuaR27wac9OpeJdOqiC/c4OeL2/B+cbpng51ZXhzx1PGawUYjtXR4G4tE9CeA6tkvySD65bg==
X-Received: by 2002:a17:906:840e:: with SMTP id n14mr31661878ejx.147.1605858881515;
        Thu, 19 Nov 2020 23:54:41 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id la9sm771763ejb.121.2020.11.19.23.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 23:54:40 -0800 (PST)
Date:   Fri, 20 Nov 2020 08:54:38 +0100
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
Message-ID: <20201120075438.GA4750@kozik-lap>
References: <AM6PR04MB605309F95A4BBD29DFA42B61E2E20@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20201117073609.GA3436@kozik-lap>
 <AM6PR04MB6053B8E66327B3204D58A0C1E2FF0@AM6PR04MB6053.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM6PR04MB6053B8E66327B3204D58A0C1E2FF0@AM6PR04MB6053.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 06:21:55AM +0000, Alice Guo wrote:
> > > +  soc:
> > > +    type: object
> > > +    properties:
> > > +      compatible:
> > > +        oneOf:
> > > +          - description: new version DTS for i.MX8M SoCs
> > > +            items:
> > > +              - enum:
> > > +                  - fsl,imx8mm-soc
> > > +                  - fsl,imx8mn-soc
> > > +                  - fsl,imx8mp-soc
> > > +                  - fsl,imx8mq-soc
> > > +              - const: simple-bus
> > > +
> > > +          - description: other SoCs and old version DTS for i.MX8M SoCs
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
> > > +      - if:
> > > +          properties:
> > > +            compatible:
> > > +              contains:
> > > +                enum:
> > > +                  - fsl,imx8mm-soc
> > > +                  - fsl,imx8mn-soc
> > > +                  - fsl,imx8mp-soc
> > > +                  - fsl,imx8mq-soc
> > > +                const: simple-bus
> > > +
> > > +        then:
> > > +          required:
> > > +            - nvmem-cells
> > > +            - nvmem-cells-names
> > >
> > > The above is my modification. Is that ok?
> > 
> > Does not look like solving anything.
> 
> If restrict that the newly added DTS file must have "fsl,imx8mX-soc" attributes, it cannot pass make dtbs_check because
> there are other DTS files which have soc node but are not used for i.mx8m family SoCs.

You need to check whether boards with i.MX 8M compatible have the SoC
node with one of above compatibles and nvmem-cells.  Since the top
select choses root node, then just check whether child exists with
specific pattern and compatibles (for given root compatibles).

Best regards,
Krzysztof

