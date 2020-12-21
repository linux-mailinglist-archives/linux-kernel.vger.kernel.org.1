Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EC12E0032
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgLUSmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgLUSmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:42:22 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08FEC0611C5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:41:41 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id y19so25941994lfa.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ee3GcxK/K+Y6PzuaCUF7iaCAOxWV/hTPMt+xGfVrDt0=;
        b=pRwTtxCVxgLfzM8eZOEuzgR9Nyss+lWHtEDJodQKaBzcv51dNf8sUqA6CkD3DuSeRd
         ikchtYSHqEDoqoGybPOUIWN8Hxi6om6xl+RnMZprvk91XSW/J9TC8fNMHNmY275gGzAj
         F9uepVtceoOvEBSdRvdIcwaGkPO9qjcgB5ZxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ee3GcxK/K+Y6PzuaCUF7iaCAOxWV/hTPMt+xGfVrDt0=;
        b=d+8zhdk82hSf9a2QLz0X8N2ZhekM9nqWTiYn2a6scb/DOUqtZ+gdKGRxsnohp0x2LP
         K2GUDtbi9yJqfBblNX+9OEsLvhUf9thNbz/T31Qvtqp5435e+J29pc0NnvIouFphveEy
         P+0hAK2fmF/NzA99jLsO2Z9+vXAR6KIgyFJTsH37tRW2ZIesksYuVsh3fjdV5es+YX3U
         uHvzqCFvQepW3OTfC4ad/1g5PYG7Kkp0Yl6aUiPuUxV4eij9E7zRVyRWNpwhvW9toR6U
         W1LMICCiN9jC4dWeQfO7Rd3qLeWGkOETSs1vmB0x6o29Ar+B7psU2XuxYP7RZDE6jam9
         F9yw==
X-Gm-Message-State: AOAM533er9r1t5mv/6z+2oKuFALWoNhW+LWSDpYzGLwc4WVJ3+Xki51V
        oqgxGxV8LjJp+B9ps6nZN6JZUZJq8ggvv9lQcF+sZhDej3ucN50e
X-Google-Smtp-Source: ABdhPJz1OlJBqmiyAdLKtCN9U7Y8HOnVSRK4oYvhL5a/OcSvwvEuiNoeSNHNf7e6NrEiHIW7RQm43Qz57hC7S8UcfRM=
X-Received: by 2002:a17:906:1c92:: with SMTP id g18mr8822995ejh.522.1608561598933;
 Mon, 21 Dec 2020 06:39:58 -0800 (PST)
MIME-Version: 1.0
References: <20201221113151.94515-1-jagan@amarulasolutions.com>
 <20201221113151.94515-3-jagan@amarulasolutions.com> <20201221134625.GB31176@kozik-lap>
 <CAMty3ZAi0B=fSRfpQG4bgE+Jt6GVhzRb_FZjCL3VQXp9vn-FEw@mail.gmail.com> <20201221140501.GE31176@kozik-lap>
In-Reply-To: <20201221140501.GE31176@kozik-lap>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 21 Dec 2020 20:09:47 +0530
Message-ID: <CAMty3ZA4K8GvTfmrV1Mz6zp1w+iF0FvE04CODZUsHvg+J+a1nw@mail.gmail.com>
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

On Mon, Dec 21, 2020 at 7:35 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Mon, Dec 21, 2020 at 07:29:22PM +0530, Jagan Teki wrote:
> > On Mon, Dec 21, 2020 at 7:16 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > On Mon, Dec 21, 2020 at 05:01:47PM +0530, Jagan Teki wrote:
> > > > i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.
> > > >
> > > > C.TOUCH 2.0 is a general purpose carrier board with capacitive
> > > > touch interface support.
> > > >
> > > > i.Core MX8M Mini needs to mount on top of this Carrier board for
> > > > creating complete i.Core MX8M Mini C.TOUCH 2.0 board.
> > > >
> > > > Add bindings for it.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > ---
> > > > Changes for v2:
> > > > - updated commit message
> > > >
> > > >  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > index 67980dcef66d..e653e0a43016 100644
> > > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > @@ -667,6 +667,8 @@ properties:
> > > >          items:
> > > >            - enum:
> > > >                - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
> > > > +              - engicam,icore-mx8mm               # i.MX8MM Engicam i.Core MX8M Mini SOM
> > > > +              - engicam,icore-mx8mm-ctouch2       # i.MX8MM Engicam i.Core MX8M Mini C.TOUCH 2.0
> > >
> > > Please test your DTS against new schema with dtbs_check. This won't
> > > match.
> >
> > Sorry, not sure I understand clearly here.
> >
> > This the dts file ie used matched compatible.
> > compatible = "engicam,icore-mx8mm-ctouch2", "engicam,icore-mx8mm",
> >                      "fsl,imx8mm";
> >
> > I did build the dtbs_check without showing any issues like,
> >
> > $ make ARCH=arm64 dtbs_check
> > ...
> >
> >     From schema: /w/dt-schema/dt-schema/dtschema/schemas/property-units.yaml
> >   DTC     arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
> >   DTC     arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2-of10.dtb
> >   DTC     arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
> > ..
> >
> > Can you let me know what I missed here?
>
> You pasted here output of validating with property-units.yaml (or
> something else), not the schema which you changed. If you want to limit
> the tests, use DT_SCHEMA_FILES.
>
> I mentioned about exactly the same problem in yout previous v1
> at patch #5. No changes here stil.

Yes, I usually did that check before posting. Please check the build
log below and fsl.yaml binding is fine to build.

# make dt_binding_check DT_SCHEMA_FILES=arm/fsl.yaml
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/dtc/dtc.o
  HOSTCC  scripts/dtc/flattree.o
  HOSTCC  scripts/dtc/fstree.o
  HOSTCC  scripts/dtc/data.o
  HOSTCC  scripts/dtc/livetree.o
  HOSTCC  scripts/dtc/treesource.o
  HOSTCC  scripts/dtc/srcpos.o
  HOSTCC  scripts/dtc/checks.o
  HOSTCC  scripts/dtc/util.o
  LEX     scripts/dtc/dtc-lexer.lex.c
  YACC    scripts/dtc/dtc-parser.tab.[ch]
  HOSTCC  scripts/dtc/dtc-lexer.lex.o
  HOSTCC  scripts/dtc/dtc-parser.tab.o
  HOSTCC  scripts/dtc/yamltree.o
  HOSTLD  scripts/dtc/dtc
  CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
/w/linux/Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml:
'additionalProperties' is a required property
/w/linux/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml:
'additionalProperties' is a required property
/w/linux/Documentation/devicetree/bindings/media/coda.yaml:
'additionalProperties' is a required property
/w/linux/Documentation/devicetree/bindings/serial/litex,liteuart.yaml:
'additionalProperties' is a required property
  SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
/w/linux/Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml:
ignoring, error in schema:
warning: no schema found in file:
./Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
/w/linux/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml:
ignoring, error in schema:
warning: no schema found in file:
./Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
/w/linux/Documentation/devicetree/bindings/media/coda.yaml: ignoring,
error in schema:
warning: no schema found in file:
./Documentation/devicetree/bindings/media/coda.yaml
/w/linux/Documentation/devicetree/bindings/serial/litex,liteuart.yaml:
ignoring, error in schema:
warning: no schema found in file:
./Documentation/devicetree/bindings/serial/litex,liteuart.yaml
#

Jagan.
