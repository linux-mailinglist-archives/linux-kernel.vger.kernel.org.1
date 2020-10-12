Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0886228BEB1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404039AbgJLRIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403845AbgJLRIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:08:24 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D09C2087D;
        Mon, 12 Oct 2020 17:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602522503;
        bh=diu7jTvqirdea73U2Pivn25Z5fqp8dxACmIMHPhvbwQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eAbD7YbuBxUjjRD7VMI3SGS3JQ3/TPUQvQE/GWdsGv+V5X5ieFF4h7fQgI7OYFS1b
         Y+DRqJUmrxFo3PvsyQj/5Gqc5T6wtjZIJVkyKK/+/KuSG6NGe10bRkdb3R8Lo16/K6
         dMkMi9dt6nkV86/Y/W/AiB3XefGkBc8YLmq3+Sck=
Received: by mail-ed1-f44.google.com with SMTP id l16so17798859eds.3;
        Mon, 12 Oct 2020 10:08:23 -0700 (PDT)
X-Gm-Message-State: AOAM532+OxvaA2c7AgICD3OSDGbJa5UOp65LY+Halr/WkCHQN6iapH7h
        WohjzY8qIfl5wWRMtDHTttwX34HowDeRfavP6Rs=
X-Google-Smtp-Source: ABdhPJznFFkxxdcO9CFLA1y4py80sWN1jeeBhSeZnTVvSdAbSWX+EHDk5exEBJ+K31o8PGsm86EFdFdTJq7JbVnnqqk=
X-Received: by 2002:aa7:c643:: with SMTP id z3mr13042703edr.104.1602522502225;
 Mon, 12 Oct 2020 10:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200930070647.10188-1-yong.wu@mediatek.com> <20200930070647.10188-2-yong.wu@mediatek.com>
 <20201002110709.GC6888@pi3> <1601958415.26323.25.camel@mhfsdcap03>
In-Reply-To: <1601958415.26323.25.camel@mhfsdcap03>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 12 Oct 2020 19:08:09 +0200
X-Gmail-Original-Message-ID: <CAJKOXPedQdOYque5igJ0_v_-_0L4S+NW6puUw-kWc+zWM96i_Q@mail.gmail.com>
Message-ID: <CAJKOXPedQdOYque5igJ0_v_-_0L4S+NW6puUw-kWc+zWM96i_Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/24] dt-bindings: iommu: mediatek: Convert IOMMU to
 DT schema
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
> On Fri, 2020-10-02 at 13:07 +0200, Krzysztof Kozlowski wrote:
> > On Wed, Sep 30, 2020 at 03:06:24PM +0800, Yong Wu wrote:
> > > Convert MediaTek IOMMU to DT schema.
> > >
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >  .../bindings/iommu/mediatek,iommu.txt         | 103 ------------
> > >  .../bindings/iommu/mediatek,iommu.yaml        | 154 ++++++++++++++++++
> > >  2 files changed, 154 insertions(+), 103 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> > >  create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > >
>
> [...]
>
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - enum:
> > > +          - mediatek,mt2701-m4u # mt2701 generation one HW
> > > +          - mediatek,mt2712-m4u # mt2712 generation two HW
> > > +          - mediatek,mt6779-m4u # mt6779 generation two HW
> > > +          - mediatek,mt8173-m4u # mt8173 generation two HW
> > > +          - mediatek,mt8183-m4u # mt8183 generation two HW
> > > +
> > > +      - description: mt7623 generation one HW
> > > +        items:
> > > +          - const: mediatek,mt7623-m4u
> > > +          - const: mediatek,mt2701-m4u
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    description: |
> > > +      bclk is optional. here is the list which require this bclk:
> > > +      mt2701, mt2712, mt7623 and mt8173.
> >
> > Similarly to my comment in other patch, this should be part of schema
> > within 'if-then'.
>
> Thanks for the review.
>
> I will change like this:
>
> =============
>   clocks:
>     items:
>       - description: bclk is the block clock.
>
>   clock-names:
>     items:
>       - const: bclk
>
> required:
>   - compatible
>   - reg
>   - interrupts
>   - mediatek,larbs
>   - '#iommu-cells'
> if:
>   properties:
>     compatible:
>       contains:
>         enum:
>           - mediatek,mt2701-m4u
>           - mediatek,mt2712-m4u
>           - mediatek,mt8173-m4u
>
> then:
>  required:
>    - clocks
> ==============
>
> If this is not right, please tell me.
> (dt_binding_check is ok.)

Looks fine, except "if" should be part of some "allOf" block.

Best regards,
Krzysztof
