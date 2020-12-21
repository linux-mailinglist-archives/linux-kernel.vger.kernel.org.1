Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D512DFCFA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 15:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgLUOmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 09:42:52 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:33333 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgLUOmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 09:42:51 -0500
Received: by mail-wr1-f43.google.com with SMTP id t30so11329707wrb.0;
        Mon, 21 Dec 2020 06:42:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D1iqUpvH1yLItA+ylay4Mb5NF2GVxYmQIsNidyuoth8=;
        b=nEthN+n+Lzr1pNsBS8mMw3B2Ar2x2Oa8EeeScp2bOg9wJxxbuOkxMdEsrohcAce5c6
         caGCKnDp1pbjR9/O+vcLJUCvNKfA2wV5NNMaCvQNIYzNksDaGkKlI22g3utKoKQyhJMF
         ksK32aLX6y4N5nITSTAICTp6bDPjKiNH/oKWGnC9/QnD6atXueRq/8QqGnRDrmcWmw4u
         OTSPbimz3oTkttvIU4fZgSEMIAMonI0QeKNft09ofNmzWsSjatTqh8giZ5R90+r6T6Pp
         C7AjkTM176sQovER62I6W+QukON7eycmGBzyuV8CzE6G50pTa2rDEHSWLr3uim1q6KtV
         VPxw==
X-Gm-Message-State: AOAM532P0wyGDoxZ9wT2QtV9FEmev5hj1qW/Bkfa9+kbgD+Ozwer/gvh
        HnH1J2rYuXel7Q4X8JgEXHA=
X-Google-Smtp-Source: ABdhPJzcrr7Yh3UPfXdSqPtIixnf1uXV8AdnLFDIcvR4NQ0laVxIouKjlAPCF3LSNpbpTVnjDV5wOg==
X-Received: by 2002:adf:f684:: with SMTP id v4mr19347580wrp.387.1608561730004;
        Mon, 21 Dec 2020 06:42:10 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id j13sm22735098wmi.36.2020.12.21.06.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 06:42:07 -0800 (PST)
Date:   Mon, 21 Dec 2020 15:42:06 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: arm: fsl: Add Engicam i.Core MX8M
 Mini C.TOUCH 2.0
Message-ID: <20201221144206.GA36114@kozik-lap>
References: <20201221113151.94515-1-jagan@amarulasolutions.com>
 <20201221113151.94515-3-jagan@amarulasolutions.com>
 <20201221134625.GB31176@kozik-lap>
 <CAMty3ZAi0B=fSRfpQG4bgE+Jt6GVhzRb_FZjCL3VQXp9vn-FEw@mail.gmail.com>
 <20201221140501.GE31176@kozik-lap>
 <CAMty3ZA4K8GvTfmrV1Mz6zp1w+iF0FvE04CODZUsHvg+J+a1nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMty3ZA4K8GvTfmrV1Mz6zp1w+iF0FvE04CODZUsHvg+J+a1nw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 08:09:47PM +0530, Jagan Teki wrote:
> On Mon, Dec 21, 2020 at 7:35 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Mon, Dec 21, 2020 at 07:29:22PM +0530, Jagan Teki wrote:
> > > On Mon, Dec 21, 2020 at 7:16 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > >
> > > > On Mon, Dec 21, 2020 at 05:01:47PM +0530, Jagan Teki wrote:
> > > > > i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.
> > > > >
> > > > > C.TOUCH 2.0 is a general purpose carrier board with capacitive
> > > > > touch interface support.
> > > > >
> > > > > i.Core MX8M Mini needs to mount on top of this Carrier board for
> > > > > creating complete i.Core MX8M Mini C.TOUCH 2.0 board.
> > > > >
> > > > > Add bindings for it.
> > > > >
> > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > ---
> > > > > Changes for v2:
> > > > > - updated commit message
> > > > >
> > > > >  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > index 67980dcef66d..e653e0a43016 100644
> > > > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > @@ -667,6 +667,8 @@ properties:
> > > > >          items:
> > > > >            - enum:
> > > > >                - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
> > > > > +              - engicam,icore-mx8mm               # i.MX8MM Engicam i.Core MX8M Mini SOM
> > > > > +              - engicam,icore-mx8mm-ctouch2       # i.MX8MM Engicam i.Core MX8M Mini C.TOUCH 2.0
> > > >
> > > > Please test your DTS against new schema with dtbs_check. This won't
> > > > match.
> > >
> > > Sorry, not sure I understand clearly here.
> > >
> > > This the dts file ie used matched compatible.
> > > compatible = "engicam,icore-mx8mm-ctouch2", "engicam,icore-mx8mm",
> > >                      "fsl,imx8mm";
> > >
> > > I did build the dtbs_check without showing any issues like,
> > >
> > > $ make ARCH=arm64 dtbs_check
> > > ...
> > >
> > >     From schema: /w/dt-schema/dt-schema/dtschema/schemas/property-units.yaml
> > >   DTC     arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
> > >   DTC     arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2-of10.dtb
> > >   DTC     arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
> > > ..
> > >
> > > Can you let me know what I missed here?
> >
> > You pasted here output of validating with property-units.yaml (or
> > something else), not the schema which you changed. If you want to limit
> > the tests, use DT_SCHEMA_FILES.
> >
> > I mentioned about exactly the same problem in yout previous v1
> > at patch #5. No changes here stil.
> 
> Yes, I usually did that check before posting. Please check the build
> log below and fsl.yaml binding is fine to build.
> 
> # make dt_binding_check DT_SCHEMA_FILES=arm/fsl.yaml

1. Wrong path to schema file,
2. Bindings pass, they are not a problem. You were running dtbs_check,
right?

Best regards,
Krzysztof
