Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5364928AEEA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgJLHSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 03:18:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36483 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgJLHSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:18:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id l16so15822433eds.3;
        Mon, 12 Oct 2020 00:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OCtzqcTvgm/lHz6dwVOWYKE+wIp/najcKC43qSAnkQQ=;
        b=bTKBII3Bb5p4w7f27vx1Up3BTiYpxA02icl+ajWUPMdhYUf5kWAQnlZC8VNtPgyf2/
         sYp52TKXRRd15fdtFrJQ0dGWqrnjExLsSxAdsG1hnJiwTCvlpDFeuzEz+L9kn7n6s3qL
         s2PmaDtsRCj0IqtU76BzlRyzMYpXbbPKz1q0Z1hxjIsam/z3IhKHCtJ2S2ODgkd3shGJ
         9u4CwqV4teWsdZmVBvyMYTGsB7PR2VqSfX7E0TzUeP07UmR3wWwCZxWNvqXPWlf0ItwU
         NSGZcnAfrwpxgj0s65yXdiyrX9LJLL6YNXFT83lD2aSBrOaVhJWnYwsXWY6j9AbjqsAB
         kAiQ==
X-Gm-Message-State: AOAM533hMFHq+3l90iFY1ct1VslqUOgK6X1dw276BK7KlR1gpEjWsVBU
        RyeySN4C7asOocmZQf/0IHE=
X-Google-Smtp-Source: ABdhPJzH66RE1w9X2obXO5dNA8hKqBI0KiAd4eRYjVVAQ32i5EUIaFFJfhg/d3NrvvfQG9iIyYP+oQ==
X-Received: by 2002:aa7:c2c4:: with SMTP id m4mr13091357edp.172.1602487127112;
        Mon, 12 Oct 2020 00:18:47 -0700 (PDT)
Received: from pi3 ([194.230.155.215])
        by smtp.googlemail.com with ESMTPSA id a10sm9995107edu.78.2020.10.12.00.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 00:18:45 -0700 (PDT)
Date:   Mon, 12 Oct 2020 09:18:43 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
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
Subject: Re: [PATCH v3 02/24] dt-bindings: memory: mediatek: Convert SMI to
 DT schema
Message-ID: <20201012071843.GA1889@pi3>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
 <20200930070647.10188-3-yong.wu@mediatek.com>
 <20201002110831.GD6888@pi3>
 <1601958428.26323.26.camel@mhfsdcap03>
 <CAJKOXPfOOGnJeNCa58WEZqbzaAFdLHSm-7pyMyGkYgCBEt0+RA@mail.gmail.com>
 <1602310691.26323.39.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1602310691.26323.39.camel@mhfsdcap03>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 02:18:11PM +0800, Yong Wu wrote:
> On Tue, 2020-10-06 at 09:15 +0200, Krzysztof Kozlowski wrote:
> > On Tue, 6 Oct 2020 at 06:27, Yong Wu <yong.wu@mediatek.com> wrote:
> > >
> > > On Fri, 2020-10-02 at 13:08 +0200, Krzysztof Kozlowski wrote:
> > > > On Wed, Sep 30, 2020 at 03:06:25PM +0800, Yong Wu wrote:
> > > > > Convert MediaTek SMI to DT schema.
> > > > >
> > > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > > ---
> > > > >  .../mediatek,smi-common.txt                   |  49 ---------
> > > > >  .../mediatek,smi-common.yaml                  | 100 ++++++++++++++++++
> > > > >  .../memory-controllers/mediatek,smi-larb.txt  |  49 ---------
> > > > >  .../memory-controllers/mediatek,smi-larb.yaml |  91 ++++++++++++++++
> > > > >  4 files changed, 191 insertions(+), 98 deletions(-)
> > > > >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> > > > >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> > > > >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> > > > >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> > > ...
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    oneOf:
> > > > > +      - enum:
> > > > > +          - mediatek,mt2701-smi-common
> > > > > +          - mediatek,mt2712-smi-common
> > > > > +          - mediatek,mt6779-smi-common
> > > > > +          - mediatek,mt8173-smi-common
> > > > > +          - mediatek,mt8183-smi-common
> > > > > +
> > > > > +      - description: for mt7623
> > > > > +        items:
> > > > > +          - const: mediatek,mt7623-smi-common
> > > > > +          - const: mediatek,mt2701-smi-common
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  clocks:
> > > > > +    description: |
> > > > > +      apb and smi are mandatory. the async is only for generation 1 smi HW.
> > > > > +      gals(global async local sync) also is optional, here is the list which
> > > > > +      require gals: mt6779 and mt8183.
> > > > > +    minItems: 2
> > > > > +    maxItems: 4
> > > > > +    items:
> > > > > +      - description: apb is Advanced Peripheral Bus clock, It's the clock for
> > > > > +          setting the register.
> > > > > +      - description: smi is the clock for transfer data and command.
> > > > > +      - description: async is asynchronous clock, it help transform the smi clock
> > > > > +          into the emi clock domain.
> > > > > +      - description: gals0 is the path0 clock of gals.
> > > > > +      - description: gals1 is the path1 clock of gals.
> > > > > +
> > > > > +  clock-names:
> > > > > +    oneOf:
> > > > > +      - items:
> > > > > +          - const: apb
> > > > > +          - const: smi
> > > > > +      - items:
> > > > > +          - const: apb
> > > > > +          - const: smi
> > > > > +          - const: async
> > > > > +      - items:
> > > > > +          - const: apb
> > > > > +          - const: smi
> > > > > +          - const: gals0
> > > > > +          - const: gals1
> > > >
> > > > Similarly to my comment to other properties, this requirement per
> > > > compatible should be part of the schema within 'if-then'.
> > >
> > > I'm not so familiar with this format. Do this has "if-then-'else
> > > if'-then-else"?
> > 
> > These are mutually exclusive conditions, so you can skip else:
> >  - if-then
> >  - if-then
> >  - if-then
> > It will be more readable then stacking 'if' under 'else'
> 
> Thanks. I will use something like this:
> 
>  anyOf:

Then it should be oneOf as only one condition can be valid.

Best regards,
Krzysztof

>    - if: #gen1 hw
>      then:
>        use apb/smi/async clocks
> 
>    - if: #gen2 hw that has gals.
>      then:
>        use apb/smi/gals0/gals1 clocks
>      else: # gen2 hw that doesn't have gals.
>        use apb/smi clocks.
