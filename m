Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090302846EF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 09:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgJFHP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 03:15:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgJFHP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 03:15:59 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E5C320789;
        Tue,  6 Oct 2020 07:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601968557;
        bh=Pm5Z7NVd1f2pZjZgJHSNKPNzGvewiuIqZ5UklodWXyY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U0yoI/R/ZLFNVTakbNSgPZoT4ef0Um/3+SRSFHcmqtcw/fULKtQ5nbkygzRvT9CIq
         llgsdUHpDNwbKPA8Y1IPXyvMlhtZnQJV8o/JMTzRV3Wev5T5F3Ue4EvIeG/Rcm9NP6
         oHRHtSmJz/0G/eHm3ldhGav1th8ZfCRPI1a9RBng=
Received: by mail-ed1-f54.google.com with SMTP id b12so12395654edz.11;
        Tue, 06 Oct 2020 00:15:57 -0700 (PDT)
X-Gm-Message-State: AOAM531GfaknJ7QmJ4UTTFxuZdDYlS9E0Z4euo3b0Wo6y4uMI7FApNol
        z5USdHzV6jprbuWCVuDgOJZlTygZ+6i81uzWEUU=
X-Google-Smtp-Source: ABdhPJy6Bduy/2vPpEtXDeg+sGokxkFGsGaNX8K4hY71wfoyWPBbf88d5SopREX/likk3O4XjoQM/xVhY/Zs/LtrErU=
X-Received: by 2002:a05:6402:22b7:: with SMTP id cx23mr4008415edb.246.1601968555919;
 Tue, 06 Oct 2020 00:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200930070647.10188-1-yong.wu@mediatek.com> <20200930070647.10188-3-yong.wu@mediatek.com>
 <20201002110831.GD6888@pi3> <1601958428.26323.26.camel@mhfsdcap03>
In-Reply-To: <1601958428.26323.26.camel@mhfsdcap03>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 6 Oct 2020 09:15:43 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfOOGnJeNCa58WEZqbzaAFdLHSm-7pyMyGkYgCBEt0+RA@mail.gmail.com>
Message-ID: <CAJKOXPfOOGnJeNCa58WEZqbzaAFdLHSm-7pyMyGkYgCBEt0+RA@mail.gmail.com>
Subject: Re: [PATCH v3 02/24] dt-bindings: memory: mediatek: Convert SMI to DT schema
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com,
        Greg Kroah-Hartman <gregkh@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Oct 2020 at 06:27, Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Fri, 2020-10-02 at 13:08 +0200, Krzysztof Kozlowski wrote:
> > On Wed, Sep 30, 2020 at 03:06:25PM +0800, Yong Wu wrote:
> > > Convert MediaTek SMI to DT schema.
> > >
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >  .../mediatek,smi-common.txt                   |  49 ---------
> > >  .../mediatek,smi-common.yaml                  | 100 ++++++++++++++++++
> > >  .../memory-controllers/mediatek,smi-larb.txt  |  49 ---------
> > >  .../memory-controllers/mediatek,smi-larb.yaml |  91 ++++++++++++++++
> > >  4 files changed, 191 insertions(+), 98 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> > >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> > >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> ...
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - enum:
> > > +          - mediatek,mt2701-smi-common
> > > +          - mediatek,mt2712-smi-common
> > > +          - mediatek,mt6779-smi-common
> > > +          - mediatek,mt8173-smi-common
> > > +          - mediatek,mt8183-smi-common
> > > +
> > > +      - description: for mt7623
> > > +        items:
> > > +          - const: mediatek,mt7623-smi-common
> > > +          - const: mediatek,mt2701-smi-common
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    description: |
> > > +      apb and smi are mandatory. the async is only for generation 1 smi HW.
> > > +      gals(global async local sync) also is optional, here is the list which
> > > +      require gals: mt6779 and mt8183.
> > > +    minItems: 2
> > > +    maxItems: 4
> > > +    items:
> > > +      - description: apb is Advanced Peripheral Bus clock, It's the clock for
> > > +          setting the register.
> > > +      - description: smi is the clock for transfer data and command.
> > > +      - description: async is asynchronous clock, it help transform the smi clock
> > > +          into the emi clock domain.
> > > +      - description: gals0 is the path0 clock of gals.
> > > +      - description: gals1 is the path1 clock of gals.
> > > +
> > > +  clock-names:
> > > +    oneOf:
> > > +      - items:
> > > +          - const: apb
> > > +          - const: smi
> > > +      - items:
> > > +          - const: apb
> > > +          - const: smi
> > > +          - const: async
> > > +      - items:
> > > +          - const: apb
> > > +          - const: smi
> > > +          - const: gals0
> > > +          - const: gals1
> >
> > Similarly to my comment to other properties, this requirement per
> > compatible should be part of the schema within 'if-then'.
>
> I'm not so familiar with this format. Do this has "if-then-'else
> if'-then-else"?

These are mutually exclusive conditions, so you can skip else:
 - if-then
 - if-then
 - if-then
It will be more readable then stacking 'if' under 'else'

>
> I tried below instead of the clocks segment above:
>
> ===================================
> if:
>   properties:
>     compatible:

Missing contains. Just take an example from some existing schema.

>       enum:
>         - mediatek,mt6779-smi-common
>         - mediatek,mt8183-smi-common
>
> then:
>   properties:
>     clock:
>       items:
>         - description: apb is the clock for setting the register..
>         - description: smi is the clock for transfer data and command.
>         - description: gals0 is the path0 clock of gals(global async
> local sync).
>         - description: gals1 is the path1 clock of gals.
>     clock-names:
>       items:
>         - const: apb
>         - const: smi
>         - const: gals0
>         - const: gals1
> else:
>   if:
>     properties:
>       compatible:
>         contains:
>           enum:
>             - mediatek,mt2701-smi-common
>
>   then:
>     properties:
>       clocks:
>         items:
>           - description: apb is the clock for setting the register.
>           - description: smi is the clock for transfer data and command.
>           - description: async is asynchronous clock, it help transform
> the smi clock
>               into the emi clock domain.
>       clock-names:
>         items:
>           - const: apb
>           - const: smi
>           - const: async
>   else:
>     properties:
>       clocks:
>         items:
>           - description: apb is the clock for setting the register.
>           - description: smi is the clock for transfer data and
> command.
>       clock-names:
>         items:
>           - const: apb
>           - const: smi
> ================================
>
> But I got a warning when dt_binding_check:
>
> CHKDT
> Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
>   SCHEMA
> Documentation/devicetree/bindings/processed-schema-examples.yaml
>   DTC
> Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.example.dt.yaml
>   CHECK
> Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.example.dt.yaml
> .../Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.example.dt.yaml: smi@14022000: 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'

There are several files which already choose different clocks based on
compatible, simple grep shows them:
Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
Documentation/devicetree/bindings/clock/idt,versaclock5.yaml

Best regards,
Krzysztof
