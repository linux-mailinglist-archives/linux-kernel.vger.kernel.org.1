Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276472DFC89
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 15:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgLUOFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 09:05:47 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:45396 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgLUOFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 09:05:47 -0500
Received: by mail-wr1-f51.google.com with SMTP id d26so11149061wrb.12;
        Mon, 21 Dec 2020 06:05:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fCeeOMSQ8C5hTd5QQYkl7lI3uR+JRA0+BPaXAsb+Y2I=;
        b=dFb1qbOe6E9xpVb+rz2UCzKQhRbJsqg/ek4+SZ07yb4Ayn+kJ8KQ6TyRMd8xBHJwyS
         XC8GFW4Jju1NSBtyV6VX0hY2gtV6oLpn+VqBubztIRnOuewKvmNpH2amvBr2IfgZKwCS
         eWMjOF8S1GZRDAtGiO1OmZJVqcKY7oE5TFnp3nkR/t1O99uJL/IpVouTtQ3rzIWzagME
         VEJCKyn17j0PzdlyGw9eyVqv1ehxFAp0Zy/7pMFy4vFBEJBbOkcQF7C79f5vyXuR2IjB
         iasXARs4UAgFJ149fKaqoOGTVUezlprz5SxEx66Rp3AvERPLY54PinyedDOqNmqG1cPd
         GCaQ==
X-Gm-Message-State: AOAM530uKrObtKiywr/B68GeQOtf2avo+gXFYa2c/eKNOszM8Y/2lf1D
        GV6tHIm1r0+QHp11MYsb2T2gqbkp0efCPQ==
X-Google-Smtp-Source: ABdhPJzpt8b0NMGjlD4ab/U9TePD8sXjoRd6+XNhnKTlaDkow1ZpNMzC6n02RU31zqYKgLLFxLmZ4A==
X-Received: by 2002:adf:94c7:: with SMTP id 65mr18227650wrr.423.1608559504504;
        Mon, 21 Dec 2020 06:05:04 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id n8sm26433038wrs.34.2020.12.21.06.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 06:05:03 -0800 (PST)
Date:   Mon, 21 Dec 2020 15:05:01 +0100
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
Message-ID: <20201221140501.GE31176@kozik-lap>
References: <20201221113151.94515-1-jagan@amarulasolutions.com>
 <20201221113151.94515-3-jagan@amarulasolutions.com>
 <20201221134625.GB31176@kozik-lap>
 <CAMty3ZAi0B=fSRfpQG4bgE+Jt6GVhzRb_FZjCL3VQXp9vn-FEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMty3ZAi0B=fSRfpQG4bgE+Jt6GVhzRb_FZjCL3VQXp9vn-FEw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 07:29:22PM +0530, Jagan Teki wrote:
> On Mon, Dec 21, 2020 at 7:16 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Mon, Dec 21, 2020 at 05:01:47PM +0530, Jagan Teki wrote:
> > > i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.
> > >
> > > C.TOUCH 2.0 is a general purpose carrier board with capacitive
> > > touch interface support.
> > >
> > > i.Core MX8M Mini needs to mount on top of this Carrier board for
> > > creating complete i.Core MX8M Mini C.TOUCH 2.0 board.
> > >
> > > Add bindings for it.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v2:
> > > - updated commit message
> > >
> > >  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > index 67980dcef66d..e653e0a43016 100644
> > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > @@ -667,6 +667,8 @@ properties:
> > >          items:
> > >            - enum:
> > >                - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
> > > +              - engicam,icore-mx8mm               # i.MX8MM Engicam i.Core MX8M Mini SOM
> > > +              - engicam,icore-mx8mm-ctouch2       # i.MX8MM Engicam i.Core MX8M Mini C.TOUCH 2.0
> >
> > Please test your DTS against new schema with dtbs_check. This won't
> > match.
> 
> Sorry, not sure I understand clearly here.
> 
> This the dts file ie used matched compatible.
> compatible = "engicam,icore-mx8mm-ctouch2", "engicam,icore-mx8mm",
>                      "fsl,imx8mm";
> 
> I did build the dtbs_check without showing any issues like,
> 
> $ make ARCH=arm64 dtbs_check
> ...
> 
>     From schema: /w/dt-schema/dt-schema/dtschema/schemas/property-units.yaml
>   DTC     arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2-of10.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
> ..
> 
> Can you let me know what I missed here?

You pasted here output of validating with property-units.yaml (or
something else), not the schema which you changed. If you want to limit
the tests, use DT_SCHEMA_FILES.

I mentioned about exactly the same problem in yout previous v1
at patch #5. No changes here stil.

Best regards,
Krzysztof

