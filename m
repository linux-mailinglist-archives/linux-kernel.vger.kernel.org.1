Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0382528B623
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbgJLN0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729726AbgJLN0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:26:20 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87D8420BED;
        Mon, 12 Oct 2020 13:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602509179;
        bh=yGzfcblPNkEu1jThQo3Kr1pZhnuRpAynpzlLmU3Eyto=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2D2ESyQOMTChv7yvxLAiD0dAuxlG0M14eT38MlEDqC6L6xVG1ZHu4M9xJTVMu5neu
         envgnta/HiKRtEOq8DzGGEU2tSlQMCpbouoj1QusJ1hHAbZKyt9hdK0qWJrfv3/G+f
         WjCjzSGa8vfOIx5nqxsYLyVIBn2+E5lpoNLRstuk=
Received: by mail-ed1-f46.google.com with SMTP id i5so16917055edr.5;
        Mon, 12 Oct 2020 06:26:19 -0700 (PDT)
X-Gm-Message-State: AOAM530/se2Fx6qazsLlzJDGJYxWdgWUzVg15Vgz8P7AGmTXvMg/1GwV
        FNiQiMq2P6H4xOZJ42dk/E3bBABKV4fYtXq7y2A=
X-Google-Smtp-Source: ABdhPJxZI9QpirJF8bPQYjiJrUckib3iXod98Zoj/Cz28ZEeJBmZJyvnNsh48f+gVrrDxErmHk+CoScI5f/RtUGp454=
X-Received: by 2002:a50:8b62:: with SMTP id l89mr14553273edl.132.1602509177952;
 Mon, 12 Oct 2020 06:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200930070647.10188-1-yong.wu@mediatek.com> <20200930070647.10188-3-yong.wu@mediatek.com>
 <20201002110831.GD6888@pi3> <1601958428.26323.26.camel@mhfsdcap03>
 <CAJKOXPfOOGnJeNCa58WEZqbzaAFdLHSm-7pyMyGkYgCBEt0+RA@mail.gmail.com>
 <1602310691.26323.39.camel@mhfsdcap03> <20201012071843.GA1889@pi3> <1602504119.26323.54.camel@mhfsdcap03>
In-Reply-To: <1602504119.26323.54.camel@mhfsdcap03>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 12 Oct 2020 15:26:05 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcn4scqt2C9eE_EikJ76kqro2QYzThdsXXR_5xtBmyH3g@mail.gmail.com>
Message-ID: <CAJKOXPcn4scqt2C9eE_EikJ76kqro2QYzThdsXXR_5xtBmyH3g@mail.gmail.com>
Subject: Re: [PATCH v3 02/24] dt-bindings: memory: mediatek: Convert SMI to DT schema
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
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

On Mon, 12 Oct 2020 at 14:02, Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Mon, 2020-10-12 at 09:18 +0200, Krzysztof Kozlowski wrote:
> > On Sat, Oct 10, 2020 at 02:18:11PM +0800, Yong Wu wrote:
> > > On Tue, 2020-10-06 at 09:15 +0200, Krzysztof Kozlowski wrote:
> > > > On Tue, 6 Oct 2020 at 06:27, Yong Wu <yong.wu@mediatek.com> wrote:
> > > > >
> > > > > On Fri, 2020-10-02 at 13:08 +0200, Krzysztof Kozlowski wrote:
> > > > > > On Wed, Sep 30, 2020 at 03:06:25PM +0800, Yong Wu wrote:
> > > > > > > Convert MediaTek SMI to DT schema.
> > > > > > >
> > > > > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > > > > ---
> > > > > > >  .../mediatek,smi-common.txt                   |  49 ---------
> > > > > > >  .../mediatek,smi-common.yaml                  | 100 ++++++++++++++++++
> > > > > > >  .../memory-controllers/mediatek,smi-larb.txt  |  49 ---------
> > > > > > >  .../memory-controllers/mediatek,smi-larb.yaml |  91 ++++++++++++++++
> > > > > > >  4 files changed, 191 insertions(+), 98 deletions(-)
> > > > > > >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> > > > > > >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> > > > > > >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> > > > > > >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> > > > > ...
> > > > > > > +properties:
> > > > > > > +  compatible:
> > > > > > > +    oneOf:
> > > > > > > +      - enum:
> > > > > > > +          - mediatek,mt2701-smi-common
> > > > > > > +          - mediatek,mt2712-smi-common
> > > > > > > +          - mediatek,mt6779-smi-common
> > > > > > > +          - mediatek,mt8173-smi-common
> > > > > > > +          - mediatek,mt8183-smi-common
> > > > > > > +
> > > > > > > +      - description: for mt7623
> > > > > > > +        items:
> > > > > > > +          - const: mediatek,mt7623-smi-common
> > > > > > > +          - const: mediatek,mt2701-smi-common
> > > > > > > +
> > > > > > > +  reg:
> > > > > > > +    maxItems: 1
> > > > > > > +
> > > > > > > +  clocks:
> > > > > > > +    description: |
> > > > > > > +      apb and smi are mandatory. the async is only for generation 1 smi HW.
> > > > > > > +      gals(global async local sync) also is optional, here is the list which
> > > > > > > +      require gals: mt6779 and mt8183.
> > > > > > > +    minItems: 2
> > > > > > > +    maxItems: 4
> > > > > > > +    items:
> > > > > > > +      - description: apb is Advanced Peripheral Bus clock, It's the clock for
> > > > > > > +          setting the register.
> > > > > > > +      - description: smi is the clock for transfer data and command.
> > > > > > > +      - description: async is asynchronous clock, it help transform the smi clock
> > > > > > > +          into the emi clock domain.
> > > > > > > +      - description: gals0 is the path0 clock of gals.
> > > > > > > +      - description: gals1 is the path1 clock of gals.
> > > > > > > +
> > > > > > > +  clock-names:
> > > > > > > +    oneOf:
> > > > > > > +      - items:
> > > > > > > +          - const: apb
> > > > > > > +          - const: smi
> > > > > > > +      - items:
> > > > > > > +          - const: apb
> > > > > > > +          - const: smi
> > > > > > > +          - const: async
> > > > > > > +      - items:
> > > > > > > +          - const: apb
> > > > > > > +          - const: smi
> > > > > > > +          - const: gals0
> > > > > > > +          - const: gals1
> > > > > >
> > > > > > Similarly to my comment to other properties, this requirement per
> > > > > > compatible should be part of the schema within 'if-then'.
> > > > >
> > > > > I'm not so familiar with this format. Do this has "if-then-'else
> > > > > if'-then-else"?
> > > >
> > > > These are mutually exclusive conditions, so you can skip else:
> > > >  - if-then
> > > >  - if-then
> > > >  - if-then
> > > > It will be more readable then stacking 'if' under 'else'
> > >
> > > Thanks. I will use something like this:
> > >
> > >  anyOf:
> >
> > Then it should be oneOf as only one condition can be valid.
>
> I did do this at the beginning. But I get a warning log when
> dt_binding_check.

Mhmm, right, since "if-else" matches in either of arms, then oneOf
will complain as it expects only one of items to match.  Then just go
with allOf. anyOf might match zero of items, so it would not catch
actual errors, I think.

Best regards,
Krzysztof
