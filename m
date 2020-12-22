Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3D12E0F57
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 21:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgLVU0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 15:26:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:53990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgLVU0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 15:26:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A4B2229C5;
        Tue, 22 Dec 2020 20:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608668752;
        bh=CMHmh//54HzzBao2oGraYPz/Rd2R+Q2LAdo6AbAmdHs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gIPowY20E/H+RYtypObWXXpXAZSzyZgRFeHhb5ym1McKJJQFNku9WcnEIrQhln6UV
         c+HFVrO8mKHLJtypT2RU+0XIqdtZ0jw2iVoqGOrt8XvwgkRbnxG7cPaU+1VI8p7IeR
         TVvOQY+dI/GSjqCurLGIXolPMTAur5kQ4e4C14ntroExzulUAKdEIDaeRNCDhRocn8
         wxeMZd1gGpgCX3px9ZMv70AbzwBlWn5L/x2yhm1BnMWEf8UNes5KB3edAHu+0Tm7xu
         xuX1IGn8Io0NtY0i1DBQc4bmKZzs28dt6XcXVEe9BQh9WwwgyfVzlZ790/jY3t9lJ8
         LtYmhR0KbxRiw==
Received: by mail-ot1-f53.google.com with SMTP id w3so13043193otp.13;
        Tue, 22 Dec 2020 12:25:52 -0800 (PST)
X-Gm-Message-State: AOAM532B0WgF/sjjqM+tW6g4x+M6ScDVMswoRtPPDHVX8S/dSd6XjeWr
        t6YHj2XHUzf4qd3YJjahzGNSgNI5TIX1OQ3e230=
X-Google-Smtp-Source: ABdhPJy3a2xnMofnmCEWCXUXxRsLqyJM6eOAPdo6XyhF3bzTLcGaLujjwr4B85gILg0BkyxZk24YxH8dREXHavmh1Fk=
X-Received: by 2002:a9d:69c1:: with SMTP id v1mr17840156oto.128.1608668751792;
 Tue, 22 Dec 2020 12:25:51 -0800 (PST)
MIME-Version: 1.0
References: <20201221113151.94515-1-jagan@amarulasolutions.com>
 <20201221113151.94515-3-jagan@amarulasolutions.com> <20201221134625.GB31176@kozik-lap>
 <CAMty3ZAi0B=fSRfpQG4bgE+Jt6GVhzRb_FZjCL3VQXp9vn-FEw@mail.gmail.com>
 <20201221140501.GE31176@kozik-lap> <CAMty3ZA4K8GvTfmrV1Mz6zp1w+iF0FvE04CODZUsHvg+J+a1nw@mail.gmail.com>
 <20201221144206.GA36114@kozik-lap> <CAMty3ZD8JAp3UGuOS2zTsOZ5QcFE6_Ba_UjtmhKpD3R3qra5jg@mail.gmail.com>
 <CAMty3ZCzB87_NGTRRvugcurSHWikcaCvKPuBBJJ1ocmqDQ8wzw@mail.gmail.com>
In-Reply-To: <CAMty3ZCzB87_NGTRRvugcurSHWikcaCvKPuBBJJ1ocmqDQ8wzw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 22 Dec 2020 21:25:40 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcZ6diMrSxAK4LyvViAmaMNwa_Bz2B4hYUapz5YK6CSnw@mail.gmail.com>
Message-ID: <CAJKOXPcZ6diMrSxAK4LyvViAmaMNwa_Bz2B4hYUapz5YK6CSnw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: arm: fsl: Add Engicam i.Core MX8M
 Mini C.TOUCH 2.0
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Dec 2020 at 19:28, Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Mon, Dec 21, 2020 at 8:17 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > On Mon, Dec 21, 2020 at 8:12 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > On Mon, Dec 21, 2020 at 08:09:47PM +0530, Jagan Teki wrote:
> > > > On Mon, Dec 21, 2020 at 7:35 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > >
> > > > > On Mon, Dec 21, 2020 at 07:29:22PM +0530, Jagan Teki wrote:
> > > > > > On Mon, Dec 21, 2020 at 7:16 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > > > >
> > > > > > > On Mon, Dec 21, 2020 at 05:01:47PM +0530, Jagan Teki wrote:
> > > > > > > > i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.
> > > > > > > >
> > > > > > > > C.TOUCH 2.0 is a general purpose carrier board with capacitive
> > > > > > > > touch interface support.
> > > > > > > >
> > > > > > > > i.Core MX8M Mini needs to mount on top of this Carrier board for
> > > > > > > > creating complete i.Core MX8M Mini C.TOUCH 2.0 board.
> > > > > > > >
> > > > > > > > Add bindings for it.
> > > > > > > >
> > > > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > > > ---
> > > > > > > > Changes for v2:
> > > > > > > > - updated commit message
> > > > > > > >
> > > > > > > >  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
> > > > > > > >  1 file changed, 2 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > > > > index 67980dcef66d..e653e0a43016 100644
> > > > > > > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > > > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > > > > @@ -667,6 +667,8 @@ properties:
> > > > > > > >          items:
> > > > > > > >            - enum:
> > > > > > > >                - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
> > > > > > > > +              - engicam,icore-mx8mm               # i.MX8MM Engicam i.Core MX8M Mini SOM
> > > > > > > > +              - engicam,icore-mx8mm-ctouch2       # i.MX8MM Engicam i.Core MX8M Mini C.TOUCH 2.0
> > > > > > >
> > > > > > > Please test your DTS against new schema with dtbs_check. This won't
> > > > > > > match.
> > > > > >
> > > > > > Sorry, not sure I understand clearly here.
> > > > > >
> > > > > > This the dts file ie used matched compatible.
> > > > > > compatible = "engicam,icore-mx8mm-ctouch2", "engicam,icore-mx8mm",
> > > > > >                      "fsl,imx8mm";
> > > > > >
> > > > > > I did build the dtbs_check without showing any issues like,
> > > > > >
> > > > > > $ make ARCH=arm64 dtbs_check
> > > > > > ...
> > > > > >
> > > > > >     From schema: /w/dt-schema/dt-schema/dtschema/schemas/property-units.yaml
> > > > > >   DTC     arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
> > > > > >   DTC     arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2-of10.dtb
> > > > > >   DTC     arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
> > > > > > ..
> > > > > >
> > > > > > Can you let me know what I missed here?
> > > > >
> > > > > You pasted here output of validating with property-units.yaml (or
> > > > > something else), not the schema which you changed. If you want to limit
> > > > > the tests, use DT_SCHEMA_FILES.
> > > > >
> > > > > I mentioned about exactly the same problem in yout previous v1
> > > > > at patch #5. No changes here stil.
> > > >
> > > > Yes, I usually did that check before posting. Please check the build
> > > > log below and fsl.yaml binding is fine to build.
> > > >
> > > > # make dt_binding_check DT_SCHEMA_FILES=arm/fsl.yaml
> > >
> > > 1. Wrong path to schema file,
> > > 2. Bindings pass, they are not a problem. You were running dtbs_check,
> > > right?
> >
> > But kbuild is building the fsl.yaml I did verify with by adding some
> > wrong character in the file, it is showing build issues.
> >
> > Please check the clean log.
> >
> > # make mrproper
> >   CLEAN   Documentation/devicetree/bindings
> >   CLEAN   scripts/basic
> >   CLEAN   scripts/dtc
> > # make dt_binding_check
> > DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/fsl.yaml
> >   HOSTCC  scripts/basic/fixdep
> >   HOSTCC  scripts/dtc/dtc.o
> >   HOSTCC  scripts/dtc/flattree.o
> >   HOSTCC  scripts/dtc/fstree.o
> >   HOSTCC  scripts/dtc/data.o
> >   HOSTCC  scripts/dtc/livetree.o
> >   HOSTCC  scripts/dtc/treesource.o
> >   HOSTCC  scripts/dtc/srcpos.o
> >   HOSTCC  scripts/dtc/checks.o
> >   HOSTCC  scripts/dtc/util.o
> >   LEX     scripts/dtc/dtc-lexer.lex.c
> >   YACC    scripts/dtc/dtc-parser.tab.[ch]
> >   HOSTCC  scripts/dtc/dtc-lexer.lex.o
> >   HOSTCC  scripts/dtc/dtc-parser.tab.o
> >   HOSTCC  scripts/dtc/yamltree.o
> >   HOSTLD  scripts/dtc/dtc
> >   CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
> > /w/linux/Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml:
> > 'additionalProperties' is a required property
> > /w/linux/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml:
> > 'additionalProperties' is a required property
> > /w/linux/Documentation/devicetree/bindings/media/coda.yaml:
> > 'additionalProperties' is a required property
> > /w/linux/Documentation/devicetree/bindings/serial/litex,liteuart.yaml:
> > 'additionalProperties' is a required property
> >   SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
> > /w/linux/Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml:
> > ignoring, error in schema:
> > warning: no schema found in file:
> > ./Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
> > /w/linux/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml:
> > ignoring, error in schema:
> > warning: no schema found in file:
> > ./Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
> > /w/linux/Documentation/devicetree/bindings/media/coda.yaml: ignoring,
> > error in schema:
> > warning: no schema found in file:
> > ./Documentation/devicetree/bindings/media/coda.yaml
> > /w/linux/Documentation/devicetree/bindings/serial/litex,liteuart.yaml:
> > ignoring, error in schema:
> > warning: no schema found in file:
> > ./Documentation/devicetree/bindings/serial/litex,liteuart.yaml
> >   DTEX    Documentation/devicetree/bindings/arm/fsl.example.dts
> >   DTC     Documentation/devicetree/bindings/arm/fsl.example.dt.yaml
> >   CHECK   Documentation/devicetree/bindings/arm/fsl.example.dt.yaml
>
> Any further comments? I'm planning to send v3.

What comments do you need? Your schema and DTS are wrong. If you run
dtbs_check, which I mentioned in the first email, you would see the
result. Instead you pasted unrelevant check of other bindings and
later pasted dt_binding_check. It does not make sense, so I clarified:
> 2. Bindings pass, they are not a problem. You were running dtbs_check, right?

And you pasted dt_binding_check, so it kind of closes the discussion.
I don't know what to add more.
I reported this problem already in v1, so please don't send the same
wrong code for the third time.

Best regards,
Krzysztof
