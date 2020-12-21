Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30292E010C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 20:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgLUTd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 14:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgLUTdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 14:33:25 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECB7C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 11:32:45 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d13so12233342wrc.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 11:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9O4weIMpjztcb7QBDFAfSfq/pXNgDRI/CV9lYT9BdMc=;
        b=lQ5aTHPnBJCpasqOpW05NjZYuxCFWKZ489cCbn6odOR4cGnK8QJcwQMfbfVJf5DtPn
         oYG9MId8RtXM9PJ7iNrg3Ih30/OODINXDbzaSygtvd/FCQ654CPBdUP/23RYbId0aXtP
         HzE9mIW4c9sAOYSKvG8DDhAxc8Tutvx9+GacY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9O4weIMpjztcb7QBDFAfSfq/pXNgDRI/CV9lYT9BdMc=;
        b=aQpqIbC38kUt6F1DIfoWfgea4cDXIV26D19LsMbuHVS19IIG1f8zpmyNumbwmri4Uh
         AvpMjh1RO74s2vNYqvcriFZJOkkcRY2ahd8ZmmNZdvPSa0O+kVkep26t9Odl53iNbAie
         a0oYAVzlllFS98uOY44Sdfks0BLChmwsnuL7+lYSiuZC9rfULztGkKtLrmefgnWtOd6M
         pYSufp5/M8cBcKdt1+2SbEvBHqixPYlDrqvQmKuR9Kq8xIA03pBoMMiK6cdTTB2Grr32
         dSX9rqS2TsLBU1F9CzGu22QJv3djNdQ4UZezUDkmwZQPUrw6K0BHRwae11D5VBFZlV91
         3LyA==
X-Gm-Message-State: AOAM532J6EPS4QkEjCwdJEk9WWVNahIa3FxhfmuCfe/VNzbcEPNln0Pk
        0sdVm2u4/xetrvoeXGymmTu1PrhaDjWGzJUZ2aEy/F4pAZj+7cGy
X-Google-Smtp-Source: ABdhPJz11UO9Mqv4yMPgNehhtC/hj3Y4jjgczoKo5b7dFLVBfoL3gr78HYG6lOupKS2OZ8EYe1PMB6OfJIUl8ccqinY=
X-Received: by 2002:a17:906:c254:: with SMTP id bl20mr15313695ejb.336.1608559173756;
 Mon, 21 Dec 2020 05:59:33 -0800 (PST)
MIME-Version: 1.0
References: <20201221113151.94515-1-jagan@amarulasolutions.com>
 <20201221113151.94515-3-jagan@amarulasolutions.com> <20201221134625.GB31176@kozik-lap>
In-Reply-To: <20201221134625.GB31176@kozik-lap>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 21 Dec 2020 19:29:22 +0530
Message-ID: <CAMty3ZAi0B=fSRfpQG4bgE+Jt6GVhzRb_FZjCL3VQXp9vn-FEw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: arm: fsl: Add Engicam i.Core MX8M
 Mini C.TOUCH 2.0
To:     Krzysztof Kozlowski <krzk@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 7:16 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Mon, Dec 21, 2020 at 05:01:47PM +0530, Jagan Teki wrote:
> > i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.
> >
> > C.TOUCH 2.0 is a general purpose carrier board with capacitive
> > touch interface support.
> >
> > i.Core MX8M Mini needs to mount on top of this Carrier board for
> > creating complete i.Core MX8M Mini C.TOUCH 2.0 board.
> >
> > Add bindings for it.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v2:
> > - updated commit message
> >
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index 67980dcef66d..e653e0a43016 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -667,6 +667,8 @@ properties:
> >          items:
> >            - enum:
> >                - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
> > +              - engicam,icore-mx8mm               # i.MX8MM Engicam i.Core MX8M Mini SOM
> > +              - engicam,icore-mx8mm-ctouch2       # i.MX8MM Engicam i.Core MX8M Mini C.TOUCH 2.0
>
> Please test your DTS against new schema with dtbs_check. This won't
> match.

Sorry, not sure I understand clearly here.

This the dts file ie used matched compatible.
compatible = "engicam,icore-mx8mm-ctouch2", "engicam,icore-mx8mm",
                     "fsl,imx8mm";

I did build the dtbs_check without showing any issues like,

$ make ARCH=arm64 dtbs_check
...

    From schema: /w/dt-schema/dt-schema/dtschema/schemas/property-units.yaml
  DTC     arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2-of10.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
..

Can you let me know what I missed here?

Jagan.
