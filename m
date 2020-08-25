Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC3D251259
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 08:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgHYGtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 02:49:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51081 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbgHYGtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:49:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id t2so1282326wma.0;
        Mon, 24 Aug 2020 23:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xu5xGZSY+yFQgovcXhMUWgqGOjtkm3hsvCXY91EThRQ=;
        b=gZ2jkEhXAvtvYP27MMIyFV5/J0HVbGIs74uKZvOriMsWEQu6LYcwXom0OosN7q5FFU
         tUJ3LPJMNighSsaoApLiXek0CUy+YsYS5GUf0jnT2EdUalpfsthvS20XQLTuS941eCVA
         CQxREM1rw0eWSd8cc553cTYo5NbI7+mYUAZCUvLS4Vd9Hv/wNlhSHQc5cdnoyQ0eylAa
         rvoBCdFwZl+qCtkgtJ0/OoLM79ZHUT6+cSlZ4zQ/HAQtPg+UVrlF8UDPQf5xSFfcR3d2
         aA6c7xlLAeuN+ANYX+QD8lAiHcUrYUutsa7IddTRd1VyjmVsW5noUZVgvEwwClAomfwV
         s+gA==
X-Gm-Message-State: AOAM5316ADPVifGp3E+YGa74XaffAEg8uiuTCe7O37VW4EO7ztkwDD5P
        x7sbFFDT2Vz5bPJ+2HQfNj4=
X-Google-Smtp-Source: ABdhPJzyAcY2Bw92cGcbfsJuTBwKqDGqGkJGMxEMpfhNk68WOOIS/f1lMDDS8tqHLpAt+d0YVzNPiA==
X-Received: by 2002:a1c:24d5:: with SMTP id k204mr505723wmk.159.1598338152035;
        Mon, 24 Aug 2020 23:49:12 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id y10sm283662wro.50.2020.08.24.23.49.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 23:49:11 -0700 (PDT)
Date:   Tue, 25 Aug 2020 08:49:08 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>, Li Jun <jun.li@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Han Xu <han.xu@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/16] dt-bindings: mtd: gpmi-nand: Fix matching of
 clocks on different SoCs
Message-ID: <20200825064908.GA3458@kozik-lap>
References: <20200824190701.8447-1-krzk@kernel.org>
 <20200824190701.8447-2-krzk@kernel.org>
 <20200825064020.GM13023@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825064020.GM13023@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 08:40:20AM +0200, Sascha Hauer wrote:
> On Mon, Aug 24, 2020 at 09:06:47PM +0200, Krzysztof Kozlowski wrote:
> > Driver requires different amount of clocks for different SoCs.  Describe
> > these requirements properly to fix dtbs_check warnings like:
> > 
> >     arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml: nand-controller@33002000: clock-names:1: 'gpmi_apb' was expected
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  .../devicetree/bindings/mtd/gpmi-nand.yaml    | 76 +++++++++++++++----
> >  1 file changed, 61 insertions(+), 15 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> > index 28ff8c581837..9d764e654e1d 100644
> > --- a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,imx6q-gpmi-nand
> > +              - fsl,imx6sx-gpmi-nand
> > +    then:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: SoC gpmi io clock
> > +            - description: SoC gpmi apb clock
> > +            - description: SoC gpmi bch clock
> > +            - description: SoC gpmi bch apb clock
> > +            - description: SoC per1 bch clock
> > +        clock-names:
> > +          items:
> > +            - const: gpmi_io
> > +            - const: gpmi_apb
> > +            - const: gpmi_bch
> > +            - const: gpmi_bch_apb
> > +            - const: per1_bch
> 
> This enforces this specific order of the clocks given in the dts. The
> clock binding itself doesn't require any specific order, that's what we
> have the names array for.
> 
> Is this really what we want?

Indeed but have in mind that the specific order was there already. This
patch does not address that part, only number of clocks.

Fixing this for any order could be done with patterns. I can work on
that.

Best regards,
Krzysztof
