Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1A52E0F68
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 21:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgLVUdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 15:33:07 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:37856 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbgLVUdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 15:33:07 -0500
Received: by mail-wr1-f53.google.com with SMTP id i9so15974513wrc.4;
        Tue, 22 Dec 2020 12:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O/y2aVCrsXS4wNPN6dvpENqHdfUVlZD7tj4fZbUkGTc=;
        b=II3g3VYe4mUwG0/pZh53EHpi6OJgC+DzQAZLx5gQYBv69od1I3m/Fkqh8RAzZlN/jS
         5qevIEVuTIUkrb+4PX6F/gIsIFOEBWczIN0vWhC8tIlDRkvgS26BX16xcLx/LSTVv32F
         RAgCiy0uS99jnQ6buPnOMmQsQ59RoY8uQ77+aZ0iW3p73GZayU/kswWHLUnGk6sfV6ki
         lpE+Xyx8Q771iD+pMWgUearveNUucddfC8VGEhs8QIgsNmE4+fmSZZlE7jwbWa67UN16
         GHGMUOfAm3p7GJRhHabDZ3nQ5UMYJOalMHbTyrgbDOXJmXbt4/YkD6FL4bQJ+3aea6z6
         DApw==
X-Gm-Message-State: AOAM533XrxB8sfJ8IC590EEosIQLWmSUx0/nzf0u/B/uVgxaQFd99bPj
        BQegWwbiRlqBI4mt+Ve7ptM=
X-Google-Smtp-Source: ABdhPJx63vP7AmeWdx7F/OALfiVmhMp+kG1WFZKqLT5WxegmooK84QyfwM/lbR3di2S++Tn7lewYYQ==
X-Received: by 2002:a5d:638b:: with SMTP id p11mr25122760wru.89.1608669143776;
        Tue, 22 Dec 2020 12:32:23 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id y68sm31235909wmc.0.2020.12.22.12.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 12:32:22 -0800 (PST)
Date:   Tue, 22 Dec 2020 21:32:21 +0100
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
Message-ID: <20201222203221.GA10029@kozik-lap>
References: <20201221113151.94515-1-jagan@amarulasolutions.com>
 <20201221113151.94515-3-jagan@amarulasolutions.com>
 <20201221134625.GB31176@kozik-lap>
 <CAMty3ZAi0B=fSRfpQG4bgE+Jt6GVhzRb_FZjCL3VQXp9vn-FEw@mail.gmail.com>
 <20201221140501.GE31176@kozik-lap>
 <CAMty3ZA4K8GvTfmrV1Mz6zp1w+iF0FvE04CODZUsHvg+J+a1nw@mail.gmail.com>
 <20201221144206.GA36114@kozik-lap>
 <CAMty3ZD8JAp3UGuOS2zTsOZ5QcFE6_Ba_UjtmhKpD3R3qra5jg@mail.gmail.com>
 <CAMty3ZCzB87_NGTRRvugcurSHWikcaCvKPuBBJJ1ocmqDQ8wzw@mail.gmail.com>
 <CAJKOXPcZ6diMrSxAK4LyvViAmaMNwa_Bz2B4hYUapz5YK6CSnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJKOXPcZ6diMrSxAK4LyvViAmaMNwa_Bz2B4hYUapz5YK6CSnw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 09:25:40PM +0100, Krzysztof Kozlowski wrote:
> On Tue, 22 Dec 2020 at 19:28, Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > On Mon, Dec 21, 2020 at 8:17 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > On Mon, Dec 21, 2020 at 8:12 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > >
> > > > On Mon, Dec 21, 2020 at 08:09:47PM +0530, Jagan Teki wrote:
> > > > > On Mon, Dec 21, 2020 at 7:35 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > > >
> > > > > > On Mon, Dec 21, 2020 at 07:29:22PM +0530, Jagan Teki wrote:
> > > > > > > On Mon, Dec 21, 2020 at 7:16 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Dec 21, 2020 at 05:01:47PM +0530, Jagan Teki wrote:
> > > > > > > > > i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.
> > > > > > > > >
> > > > > > > > > C.TOUCH 2.0 is a general purpose carrier board with capacitive
> > > > > > > > > touch interface support.
> > > > > > > > >
> > > > > > > > > i.Core MX8M Mini needs to mount on top of this Carrier board for
> > > > > > > > > creating complete i.Core MX8M Mini C.TOUCH 2.0 board.
> > > > > > > > >
> > > > > > > > > Add bindings for it.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > > > > ---
> > > > > > > > > Changes for v2:
> > > > > > > > > - updated commit message
> > > > > > > > >
> > > > > > > > >  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
> > > > > > > > >  1 file changed, 2 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > > > > > index 67980dcef66d..e653e0a43016 100644
> > > > > > > > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > > > > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > > > > > @@ -667,6 +667,8 @@ properties:
> > > > > > > > >          items:
> > > > > > > > >            - enum:
> > > > > > > > >                - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
> > > > > > > > > +              - engicam,icore-mx8mm               # i.MX8MM Engicam i.Core MX8M Mini SOM
> > > > > > > > > +              - engicam,icore-mx8mm-ctouch2       # i.MX8MM Engicam i.Core MX8M Mini C.TOUCH 2.0
> > > > > > > >
> > > > > > > > Please test your DTS against new schema with dtbs_check. This won't
> > > > > > > > match.
> > > > > > >
> > > > > > > Sorry, not sure I understand clearly here.
> > > > > > >
> > > > > > > This the dts file ie used matched compatible.
> > > > > > > compatible = "engicam,icore-mx8mm-ctouch2", "engicam,icore-mx8mm",
> > > > > > >                      "fsl,imx8mm";
> > > > > > >
> > > > > > > I did build the dtbs_check without showing any issues like,
> > > > > > >
> > > > > > > $ make ARCH=arm64 dtbs_check
> > > > > > > ...
> > > > > > >
> > > > > > >     From schema: /w/dt-schema/dt-schema/dtschema/schemas/property-units.yaml
> > > > > > >   DTC     arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
> > > > > > >   DTC     arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2-of10.dtb
> > > > > > >   DTC     arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
> > > > > > > ..
> > > > > > >
> > > > > > > Can you let me know what I missed here?
> > > > > >
> > > > > > You pasted here output of validating with property-units.yaml (or
> > > > > > something else), not the schema which you changed. If you want to limit
> > > > > > the tests, use DT_SCHEMA_FILES.
> > > > > >
> > > > > > I mentioned about exactly the same problem in yout previous v1
> > > > > > at patch #5. No changes here stil.
> > > > >
> > > > > Yes, I usually did that check before posting. Please check the build
> > > > > log below and fsl.yaml binding is fine to build.
> > > > >
> > > > > # make dt_binding_check DT_SCHEMA_FILES=arm/fsl.yaml
> > > >
> > > > 1. Wrong path to schema file,
> > > > 2. Bindings pass, they are not a problem. You were running dtbs_check,
> > > > right?
> > >
> > > But kbuild is building the fsl.yaml I did verify with by adding some
> > > wrong character in the file, it is showing build issues.
> > >
> > > Please check the clean log.
> > >
> > > # make mrproper
> > >   CLEAN   Documentation/devicetree/bindings
> > >   CLEAN   scripts/basic
> > >   CLEAN   scripts/dtc
> > > # make dt_binding_check
> > > DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/fsl.yaml
> > >   HOSTCC  scripts/basic/fixdep
> > >   HOSTCC  scripts/dtc/dtc.o
> > >   HOSTCC  scripts/dtc/flattree.o
> > >   HOSTCC  scripts/dtc/fstree.o
> > >   HOSTCC  scripts/dtc/data.o
> > >   HOSTCC  scripts/dtc/livetree.o
> > >   HOSTCC  scripts/dtc/treesource.o
> > >   HOSTCC  scripts/dtc/srcpos.o
> > >   HOSTCC  scripts/dtc/checks.o
> > >   HOSTCC  scripts/dtc/util.o
> > >   LEX     scripts/dtc/dtc-lexer.lex.c
> > >   YACC    scripts/dtc/dtc-parser.tab.[ch]
> > >   HOSTCC  scripts/dtc/dtc-lexer.lex.o
> > >   HOSTCC  scripts/dtc/dtc-parser.tab.o
> > >   HOSTCC  scripts/dtc/yamltree.o
> > >   HOSTLD  scripts/dtc/dtc
> > >   CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
> > > /w/linux/Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml:
> > > 'additionalProperties' is a required property
> > > /w/linux/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml:
> > > 'additionalProperties' is a required property
> > > /w/linux/Documentation/devicetree/bindings/media/coda.yaml:
> > > 'additionalProperties' is a required property
> > > /w/linux/Documentation/devicetree/bindings/serial/litex,liteuart.yaml:
> > > 'additionalProperties' is a required property
> > >   SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
> > > /w/linux/Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml:
> > > ignoring, error in schema:
> > > warning: no schema found in file:
> > > ./Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
> > > /w/linux/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml:
> > > ignoring, error in schema:
> > > warning: no schema found in file:
> > > ./Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
> > > /w/linux/Documentation/devicetree/bindings/media/coda.yaml: ignoring,
> > > error in schema:
> > > warning: no schema found in file:
> > > ./Documentation/devicetree/bindings/media/coda.yaml
> > > /w/linux/Documentation/devicetree/bindings/serial/litex,liteuart.yaml:
> > > ignoring, error in schema:
> > > warning: no schema found in file:
> > > ./Documentation/devicetree/bindings/serial/litex,liteuart.yaml
> > >   DTEX    Documentation/devicetree/bindings/arm/fsl.example.dts
> > >   DTC     Documentation/devicetree/bindings/arm/fsl.example.dt.yaml
> > >   CHECK   Documentation/devicetree/bindings/arm/fsl.example.dt.yaml
> >
> > Any further comments? I'm planning to send v3.
> 
> What comments do you need? Your schema and DTS are wrong. If you run
> dtbs_check, which I mentioned in the first email, you would see the
> result. Instead you pasted unrelevant check of other bindings and
> later pasted dt_binding_check. It does not make sense, so I clarified:
> > 2. Bindings pass, they are not a problem. You were running dtbs_check, right?
> 
> And you pasted dt_binding_check, so it kind of closes the discussion.
> I don't know what to add more.
> I reported this problem already in v1, so please don't send the same
> wrong code for the third time.

Let's make it obvious:

$ make -j4 dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/fsl.yaml

make[1]: Entering directory '/home/dev/linux/linux/out'
  UPD     include/config/kernel.release
  DTC     arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dt.yaml
  CHECK   arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dt.yaml
/home/dev/linux/linux/out/arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dt.yaml: /: compatible: 'oneOf' conditional failed, one must be fixed:
	['engicam,icore-mx8mm-ctouch2', 'engicam,icore-mx8mm', 'fsl,imx8mm'] is too long
	Additional items are not allowed ('fsl,imx8mm' was unexpected)

Best regards,
Krzysztof

